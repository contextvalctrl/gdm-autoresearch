# GestAlt v2.1 — Security Audit Brief for Zellic

**Project:** GestAlt v2.1 (ValCtrl)
**Review target:** 4 Solidity contracts (primary) + GovernanceParams, EATManager (secondary)
**Code freeze:** 2026-04-21
**Requested start:** 2026-04-28
**Deadline:** 2026-06-02 (Demo Day: 2026-06-16)

---

## Mechanism Context

GestAlt v2.1 is a warranted-state clearing protocol. It is NOT an AMM, lending protocol, or standard prediction market. The core primitive is a "credible claim" — a capital-staked assertion about the value of a coordinate variable, backed by slashable escrow. If the claim is correct at oracle resolution, the claimer earns fees. If wrong, escrow is slashed.

**Key semantic distinction:** Capital is the anti-Sybil participation gate only. Epistemic influence on the settlement price is determined by track record (log-score history), not wallet size. Settlement price = credibility-weighted average of claims by agents who have survived oracle resolutions on the same coordinate class.

A "Settlement Freeze Protocol" produces a settlement price for institutional event-contract positions. Oracle authority is separate from knower attestation: oracle overrides do NOT slash the knower (oracle authority ≠ quality failure). This is a novel two-type interaction not found in standard DeFi oracle patterns.

**S_epistemic / S_settlement separation (Invariant #162):** The live epoch-buffer estimate (`getLiveS_epistemic`) and the committed settlement input (`getCommittedS_cred`) are distinct state variables. No post-T_anchor code path is permitted to read `getLiveS_epistemic` for settlement purposes.

---

## 4-Contract Primary Scope

1. **CredibilityAggregator_v1**
   Central state: `credibility_ratio` (log-score history), S_cred (credibility-weighted aggregate), epoch buffer (one-epoch delay between S_cred update and clearing feed release)

2. **ClaimEscrow_v1**
   Standard escrow lockup/release; LTRP routing; slash flows

3. **SettlementEngine_v1**
   Settlement Freeze Protocol; Zone C deferral; settlement_finality challenge type; `oracle_settlement_override` (NO-SLASH path — non-standard, high audit priority)

4. **OracleManager_v1**
   oracle_settlement_override routing; oracle authority distinction from slash path

**Secondary scope (internal review + spot-check):**
- CoordinateRegistry_v1
- EATManager_v1
- GovernanceParams_v1

---

## Oracle Duality (Non-Standard — Read This First)

Two epistemically distinct settlement roles:

- **Knower (attestor):** credibility-weighted aggregate → candidate settlement price S_mechanism(c)
- **Oracle (authority):** external registry → final definitive value via `oracle_settlement_override`

A successful oracle override does **NOT** slash the knower. This is intentional and critical. Slashing on oracle override would collapse the mechanism's participation incentive. The auditor must verify this is enforced, not just documented: **no code path in `oracle_settlement_override` modifies escrow balances.**

---

## Six Prioritised Audit Items (ZA-1 through ZA-6)

### ZA-1 — credibility_ratio log-score edge cases
**Risk:** Fixed-point precision loss allows wrong claim to escape penalty; zero-probability bucket handling undefined.
**Verify:**
- Minimum log-score penalty is non-zero for any non-trivial stake.
- Zero-probability claim bucket → proportional slash; no division-by-zero.
- Large stake → W_MAX cap applied before S_cred weighting.
**Pass condition:** Any non-trivial wrong claim results in a measurable credibility_ratio reduction. No arithmetic underflow path produces zero penalty for a wrong large-stake claim.

---

### ZA-2 — W_MAX simultaneous-cap enforcement
**Risk:** Sequential cap creates processing-order manipulation surface. An adversary front-runs `commitEpochBuffer` to guarantee first-processing priority.
**Verify:**
- W_MAX cap applied simultaneously to ALL knowers before renormalisation (Option A, not sequential).
- Single renormalisation pass after all caps applied.
- No re-entrancy on `commitEpochBuffer` that could re-enter mid-cap computation.
**Pass condition:** S_cred output is identical regardless of knower ordering in the input array. Demonstrate with two equivalent test vectors with reversed knower order.

---

### ZA-3 — T_anchor atomic StateFreeze
**Risk:** Concurrent S_cred update in same block as StateFreeze interleaves before snapshot is taken.
**Verify:** `CoordinateRegistry.freezeForSettlement` is a single atomic EVM transaction reading epoch-open S_cred snapshot. `SettlementEngine.candidate_price` storage slot is written exactly once (in `freezeForSettlement`) and never overwritten post-freeze.
**Attack vector:** Attacker submits high-stake claim in same block as StateFreeze, shifting live S_epistemic before settlement snapshot is captured.
**Pass condition:** `candidate_price` storage value at T_anchor equals `getCommittedS_cred(classId, epochAtAnchor - 1)` — not `getLiveS_epistemic`.

---

### ZA-4 — Zone C deferral bypass
**Risk:** Non-challenge-type governance call indirectly advances the settlement window counter while class is in Zone C.
**Verify:** Settlement finality challenge windows cannot advance while `class_zone == ZONE_C`. Confirm only `settlement_finality` challenge type is deferred; epistemic challenges advance normally. `zone_at_T_anchor` field is write-once and cannot be retroactively altered post-StateFreeze.
**Pass condition:** Zero code paths advance settlement finality deadline counter while zone == ZONE_C.

---

### ZA-5 — EATManager freeze-aware logging (S_epistemic / S_settlement separation)
**Risk:** Post-T_anchor call to `getLiveS_epistemic` in monitoring context returns stale value; caller misuses it as settlement input.
**Verify:** `getLiveS_epistemic()` post-T_anchor calls within EATManager are tagged `POST_FREEZE_LIVE_NOT_FOR_SETTLEMENT`. No code path inside `SettlementEngine`, `ClaimEscrow`, or `CoordinateRegistry` reads `getLiveS_epistemic` after `freezeForSettlement` has executed for the same `(classId, epoch)` pair.
**Pass condition:** Zero `getLiveS_epistemic` calls originating from `SettlementEngine` in any post-T_anchor code path. EATManager post-freeze diagnostic calls are tagged and do not flow into `candidate_price`.

---

### ZA-6 — Immutable cross-contract addresses
**Risk:** Governance takeover calls a post-constructor address setter to redirect CredibilityAggregator reads to a malicious contract.
**Verify:** All v2.1 cross-contract addresses are set in constructors and declared `immutable`. No setter function for any cross-contract address exists in any v2.1 contract bytecode. No `delegatecall` path writes to cross-contract address storage slots.
**Special check — k_a_max_single_stake:** `k_a_max_single_stake` in CoordinateRegistry_v1 has no setter function (immutable after class registration). Verify via function selector analysis and delegatecall path scan.
**Pass condition:** Function selector analysis produces zero matches for any address setter. Zero `delegatecall` targets writing to cross-contract address storage.

---

## Relational Constraint Checklist (GovernanceParams — 12 hard-enforced)

The following constraints must be enforced in both directions at parameter-update time in `GovernanceParams`:

| Constraint | Parameters | Source |
|---|---|---|
| `tolerance ≤ ⌊window_size / 4⌋` | tolerance, window_size | Invariant #134 |
| `γ_corr_cross ≤ γ_corr` | γ_corr_cross, γ_corr | Invariant #130 |
| `β_min ≤ β_max` | β_min, β_max | Invariant #129 |
| `α_min ≤ α_max` | α_min, α_max | Invariant #144 |
| `α_min ≥ 0.0`, `α_max ≤ 0.5` | α_min, α_max | absolute bounds |
| `w_override_base ≤ 0.6` | w_override_base | Invariant #154 |
| `γ ∈ (0, 1)` (chain depth discount) | γ | absolute bounds |
| `fee_fraction ∈ [0.005, 0.05]` | fee_fraction | Invariant #180 |
| `window_size ≥ 4` | window_size | Invariant #134 |
| `ρ_floor ≤ ρ_ceil` | ρ_floor, ρ_ceil | Invariant #143 |
| `w_max_pct ∈ [0.05, 0.25]` | w_max_pct | Invariant #161 |
| `T_provisional_max ≤ 3 × T_oracle_window` | T_provisional_max, T_oracle_window | Invariant class-level |

**Bidirectional enforcement required:** Setting either parameter in a pair to violate the constraint must revert. Three relational pairs (tolerance/window_size, γ_corr_cross/γ_corr, ρ_floor/ρ_ceil) require dedicated adversarial PoC.

---

## Self-Query Prohibition (Invariant #164)

An address that is a registered knower on `(classId, coord)` cannot simultaneously pay an EQ query targeting the same `(classId, coord)` in the same epoch. Verify `require(msg.sender != claim.knowerAddress)` or equivalent guard in ClaimEscrow or EQ escrow contract. Pass condition: self-query transaction reverts.

---

## Reference Documents

- Mechanism invariants #1–#184 (`knowledge-marketplace-aggregate.md`)
- Engineering handoff documents (`gestalt-contracts/docs/`)
- Deployment order: GovernanceParams → EATManager → CoordinateRegistry → GestAltVault → CredibilityAggregator → OracleManager → SettlementEngine

---

*Prepared: #r198 — 2026-04-04T06:42Z*
*Contact: team@valctrl.com*
