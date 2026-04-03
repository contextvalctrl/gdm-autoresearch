# EpistemicBond v0 — Technical Specification

**Maintainer:** Logan (ValCtrl AI — Chief of Staff)
**Run:** r075 → corrected by r077 (VAL-462) → corrected by r081 (VAL-469) → corrected by r083 (VAL-471) → updated by r089 (VAL-494: §10 deferred-features list updated with r129–r131 Phase 3 items; duplicate footer removed) → updated by r090 (VAL-500: Run/Issue header chain corrected to include r089/VAL-494) → updated by r091 (VAL-501: footer signature corrected to include r090/VAL-500 chain entry) → updated by r092 (VAL-502: Run/Issue header chain updated to include r092/VAL-502 entry) → updated by r093 (VAL-503: Run/Issue header chain and footer signature updated to include r093/VAL-503 entry) → updated by r094 (VAL-504: Run/Issue header chain and footer signature updated to include r094/VAL-504 entry) → updated by r095 (VAL-505: Run/Issue header chain and footer signature updated to include r095/VAL-505 entry) → updated by r096 (VAL-506: Run/Issue header chain and footer signature updated to include r096/VAL-506 entry)
**Date:** 2026-04-03
**Issue:** VAL-460 → updated by VAL-462 → updated by VAL-471 → updated by VAL-494 → updated by VAL-500 → updated by VAL-501 → updated by VAL-502 → updated by VAL-503 → updated by VAL-504 → updated by VAL-505 → updated by VAL-506
**Depends on:** executable-roadmap.md (r074), atlas-formal-analysis.md (r072), research-synthesis.md (r073)
**Purpose:** Bridge the theoretical mechanism design and executable roadmap to concrete engineering artifacts. This document is the handoff to engineering for Phase 0 (testnet deployment, Weeks 1–3).

---

## Overview

This spec defines the **minimum viable smart contract interface** and **off-chain coordination protocol** for EpistemicBond v0 — the Layer 2 epistemic bond layer on GestAlt's batch clearing infrastructure.

Everything in this document is designed to be implementable in ≤3 weeks by one Solidity engineer. Scope is strictly limited to what is needed for Phase 1 (closed knower beta, corporate earnings domain, 15 knowers, 30 epochs). All Phase 2+ features are explicitly deferred.

---

## 1. System Boundaries

### 1.1 What this spec covers

| Component | Included in v0 | Notes |
|---|---|---|
| Knower identity registry with c_id registration fee | ✅ | Atlas r073 Sybil requirement |
| Sealed-commit / batch-reveal claim flow | ✅ | Front-run resistance requirement |
| Credibility weight computation: `w_i = σ(α·T_i) · log(1 + k_i/k_0)` | ✅ | Core mechanism |
| S_public aggregation (linear opinion pool) | ✅ | LOP; LogOP upgrade deferred |
| Track record update: `T_i += η · (R_i − E[R])` | ✅ | Slow-moving credibility |
| Log-score reward/slash: `R_i = k_i · [log μ_i(ω*) − log S_prev(ω*)]` | ✅ | Settlement |
| Oracle resolution ingestion | ✅ | Binary outcomes only (v0) |
| Holdback mechanism (70%/30% split) | ✅ | Slashing surface |
| TOWL zone gating (Zone A/B/C hard gates) | ✅ | Solvency guard |
| Off-chain claim routing (unknower access) | ✅ | Off-chain; on-chain commitment only |
| Fee collection (base + performance) | ❌ | Phase 2; Phase 1 is track-record-only |
| LOP → LogOP dynamic selector | ❌ | Phase 2+ |
| L2 advisory signal to L1 | ❌ | Phase 3+ |
| AI agent API | ❌ | Phase 2+ |
| Cross-domain track records | ❌ | Phase 3+ |
| VCG fee structure | ❌ | Post-Phase 2 |

### 1.2 Actors

| Actor | Role | On-chain identity |
|---|---|---|
| **Knower** | Submits credentialed claim; stakes k_i units; builds T_i over epochs | Registered address; paid c_id |
| **Protocol admin** | Deploys contract; sets parameters; operates oracle relay | Multisig or deployer EOA (v0) |
| **Oracle relay** | Delivers ω* after epoch close; bonded; independent of L1 positions | Designated address; bonded |
| **Unknower** | Off-chain consumer; accesses revealed claim bundles; no on-chain role in v0 | Off-chain; future v1 may add |

---

## 2. Solidity Interface

### 2.1 `IEpistemicBondRegistry` — Knower Registration

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title IEpistemicBondRegistry
/// @notice Knower identity registration with Sybil-cost floor.
/// @dev Per Atlas r073 Q1: identity registration fee c_id is MANDATORY.
///      The log-stake influence function is NOT Sybil-proof without it.
interface IEpistemicBondRegistry {

    event KnowerRegistered(address indexed knower, uint256 registrationFee, uint256 timestamp);
    event KnowerSlashed(address indexed knower, uint256 amount, string reason);

    /// @notice Register as a knower. Non-refundable c_id fee must be paid.
    /// @dev c_id is burned (sent to address(0)) or directed to protocol treasury.
    function register() external payable;

    /// @notice Check if an address is a registered knower.
    function isRegistered(address knower) external view returns (bool);

    /// @notice Return the current track record T_i for a knower.
    /// @dev T_i ∈ [-10, +10] typical range; starts at 0.0 for new registrants.
    function trackRecord(address knower) external view returns (int256);

    /// @notice Return the credibility weight w_i for a knower given their current T_i and stake k_i.
    /// @dev w_i = σ(α · T_i) · log(1 + k_i / k_0)
    ///      Returned as fixed-point with 18 decimals (WAD).
    function credibilityWeight(address knower, uint256 stake) external view returns (uint256);
}
```

### 2.2 `IEpistemicBondCoordinate` — Per-Coordinate Epoch Flow

Each coordinate (e.g., "AAPL Q2 2026 EPS beat/miss") deploys one coordinate contract, or the master contract manages coordinates by ID. Recommend coordinate-per-contract for isolation in v0; migrate to ID-indexed singleton in v1.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title IEpistemicBondCoordinate
/// @notice One binary coordinate: knowers stake on outcome probabilities,
///         unknowers (off-chain in v0) access aggregated claims,
///         oracle resolves, rewards distributed.
interface IEpistemicBondCoordinate {

    // ---------------------------------------------------------
    // Events
    // ---------------------------------------------------------

    event EpochOpened(uint256 indexed epochId, uint256 openTime, uint256 commitDeadline, uint256 revealDeadline);
    event CommitSubmitted(address indexed knower, uint256 indexed epochId, bytes32 commitment);
    event ClaimRevealed(address indexed knower, uint256 indexed epochId, uint256 pTrue, uint256 stake);
    event SPublicComputed(uint256 indexed epochId, uint256 sPublic, uint256 totalWeight);
    event OracleResolved(uint256 indexed epochId, bool outcome, address oracle);
    event RewardDistributed(address indexed knower, uint256 indexed epochId, int256 reward, uint256 newTrackRecord);
    event EpochClosed(uint256 indexed epochId, uint256 closeTime);

    // ---------------------------------------------------------
    // Epoch state enum
    // ---------------------------------------------------------

    enum EpochState {
        NotStarted,
        CommitPhase,    // Knowers submit sealed commitments
        RevealPhase,    // Knowers reveal claims; commitment hash checked
        Aggregation,    // S_public computed; off-chain access window
        OraclePending,  // Awaiting oracle resolution
        Settling,       // Distributing rewards/slashes
        Closed          // Final; track records updated
    }

    // ---------------------------------------------------------
    // Views
    // ---------------------------------------------------------

    function currentEpoch() external view returns (uint256);
    function epochState(uint256 epochId) external view returns (EpochState);
    function sPrev(uint256 epochId) external view returns (uint256);  // WAD
    function sPublic(uint256 epochId) external view returns (uint256); // WAD

    // ---------------------------------------------------------
    // Phase 1: Commit
    // ---------------------------------------------------------

    /// @notice Submit a sealed commitment for the current epoch.
    /// @param commitment keccak256(abi.encodePacked(pTrue, stake, nonce, epochId, address(this)))
    /// @dev Knower must also transfer stake into escrow in this call (msg.value or token transfer).
    ///      Minimum stake: k_min. Holdback: 30% locked until oracle resolution.
    function commit(bytes32 commitment) external payable;

    // ---------------------------------------------------------
    // Phase 2: Reveal
    // ---------------------------------------------------------

    /// @notice Reveal the sealed commitment.
    /// @param pTrue Knower's probability estimate for outcome = true, WAD (1e18 = 100%).
    ///              Must satisfy 0 < pTrue < 1e18 (exclusive; ε-bounded at contract level).
    /// @param stake Staked amount (must match msg.value paid at commit time).
    /// @param nonce Secret nonce used in commitment.
    function reveal(uint256 pTrue, uint256 stake, bytes32 nonce) external;

    // ---------------------------------------------------------
    // Phase 3: Aggregate (permissionless or admin-triggered)
    // ---------------------------------------------------------

    /// @notice Trigger S_public computation after reveal deadline.
    /// @dev Permissionless in v0 (anyone can call after deadline).
    ///      S_public = Σ w_i · pTrue_i / Σ w_i   (linear opinion pool)
    ///      w_i = σ(α · T_i) · log(1 + k_i / k_0)
    function computeSPublic(uint256 epochId) external;

    // ---------------------------------------------------------
    // Phase 4: Oracle resolution
    // ---------------------------------------------------------

    /// @notice Called by the oracle relay to provide resolution.
    /// @param epochId Epoch being resolved.
    /// @param outcome true = outcome "true" occurred; false = outcome "false" occurred.
    /// @dev Oracle relay address must be pre-approved. Bond required of oracle (set at deploy).
    function resolveOracle(uint256 epochId, bool outcome) external;

    // ---------------------------------------------------------
    // Phase 5: Settlement (permissionless)
    // ---------------------------------------------------------

    /// @notice Distribute rewards and slashes for a resolved epoch.
    /// @dev Anyone can call after oracle resolution.
    ///      R_i = k_i · [log(p_i(ω*)) - log(S_prev(ω*))]
    ///      where ω* is the resolved outcome, S_prev is sPrev(epochId).
    ///      T_i updated: T_i += η · (R_i - expected_R)
    ///      expected_R is the reward a prior-matched claim would have received (zero by definition).
    function settle(uint256 epochId) external;

    // ---------------------------------------------------------
    // Knower-specific settlement claim
    // ---------------------------------------------------------

    /// @notice Knower pulls their net reward/slash for a settled epoch.
    function claimSettlement(uint256 epochId) external;
}
```

### 2.3 `IEpistemicBondParams` — Protocol Constants (Governance-Adjustable)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title IEpistemicBondParams
/// @notice Protocol constants for v0. Governance-adjustable post-launch.
/// @dev All WAD values use 1e18 = 1.0
interface IEpistemicBondParams {

    // ----- v0 Defaults (from executable-roadmap.md §3) -----

    /// @notice c_id: non-refundable identity registration fee.
    /// @dev v0 default: 100 protocol units. MUST be > 0. Atlas r073 Sybil requirement.
    function registrationFee() external view returns (uint256);

    /// @notice k_0: reference stake for log-diminishing influence.
    /// @dev v0 default: 100 units.
    function referenceStake() external view returns (uint256);

    /// @notice k_min: minimum claim stake.
    /// @dev v0 default: 50 units.
    function minimumStake() external view returns (uint256);

    /// @notice α: credibility sigmoid sensitivity.
    /// @dev v0 default: 1.0 (WAD). Tune after Phase 1.
    function sigmoidAlpha() external view returns (uint256);

    /// @notice η: track record learning rate.
    /// @dev v0 default: 0.01 (WAD). Slow-moving by design.
    function learningRate() external view returns (uint256);

    /// @notice W_max: maximum credibility weight fraction for any single knower.
    /// @dev v0 default: 0.25 (25%). No knower controls >25% of S_public.
    function maxCredibilityFraction() external view returns (uint256);

    /// @notice ε_smoothing: minimum probability floor to avoid log(0).
    /// @dev v0 default: 0.001 (WAD). Applied to both pTrue and (1-pTrue).
    function epsilonSmoothing() external view returns (uint256);

    /// @notice holdback: fraction of stake locked until oracle resolution.
    /// @dev v0 default: 0.30 (30%). 70% released at reveal deadline.
    function holdbackFraction() external view returns (uint256);

    /// @notice TOWL zone thresholds.
    /// @dev Zone A < 70% utilization; Zone B 70–90%; Zone C > 90%.
    function towlZoneAThreshold() external view returns (uint256); // 0.70 WAD
    function towlZoneBThreshold() external view returns (uint256); // 0.90 WAD

    /// @notice Epoch duration in seconds.
    /// @dev v0 default: 86400 (24 hours). Matches daily earnings release cadence.
    function epochDuration() external view returns (uint256);

    /// @notice Commit phase duration within an epoch.
    /// @dev v0 default: 57600 (16 hours). Remaining 8h split 4h reveal + 4h aggregation.
    function commitPhaseDuration() external view returns (uint256);

    /// @notice Reveal phase duration within an epoch.
    /// @dev v0 default: 14400 (4 hours).
    function revealPhaseDuration() external view returns (uint256);

    /// @notice Oracle liveness window after reveal deadline.
    /// @dev v0 default: 172800 (48 hours). Option C: auto-challenge if exceeded.
    function oracleLivenessWindow() external view returns (uint256);

    /// @notice T_freshness window for provisional install status.
    /// @dev v0 default: 259200 (72 hours).
    function trackRecordFreshnessWindow() external view returns (uint256);

    /// @notice Seed subsidy floor per knower per epoch (Phase 1 only).
    /// @dev v0 default: 10 units/epoch. Funded from protocol treasury. Phase 1 only.
    function seedSubsidyFloor() external view returns (uint256);
}
```

---

## 3. Off-Chain Claim Routing Protocol (v0)

In v0, unknower access is off-chain. The on-chain contract only records commitment hashes and reveals. Off-chain, an operator service provides unknowers with access to revealed claim bundles.

### 3.1 Claim bundle format (post-reveal)

After `computeSPublic()` is called for an epoch, the following data is publicly available on-chain and can be served off-chain:

```json
{
  "epochId": 42,
  "coordinateId": "AAPL-Q2-2026-EPS",
  "commitDeadline": 1712177600,
  "revealDeadline": 1712181200,
  "sPublic": 0.634,
  "totalWeight": 3.82,
  "claims": [
    {
      "knower": "0xabc...123",
      "pTrue": 0.72,
      "stake": 250,
      "credibilityWeight": 0.91,
      "trackRecord": 1.43
    },
    {
      "knower": "0xdef...456",
      "pTrue": 0.58,
      "stake": 180,
      "credibilityWeight": 0.73,
      "trackRecord": 0.89
    }
  ]
}
```

### 3.2 Access control for Phase 1

Phase 1 has no unknower fee (track-record bootstrap only). Claim bundles are available to:
- Pre-approved Phase 1 observers (allowlist maintained by protocol admin off-chain)
- The public leaderboard (credibility weights only; pTrue values optionally anonymized)

Phase 2 introduces fee-gated access via an off-chain subscription mechanism. The on-chain contract does not need to change for this transition.

### 3.3 Public leaderboard endpoint

Simple REST endpoint served by the operator node:

```
GET /api/v0/coordinates
GET /api/v0/coordinates/{coordinateId}/epoch/{epochId}/claims
GET /api/v0/knowers/{address}/track-record
GET /api/v0/leaderboard
```

Implementation: index from on-chain events; serve from a simple database. No auth in v0.

---

## 4. Corporate Earnings Oracle Integration (v0)

Per Lens r073 and executable-roadmap.md: corporate earnings is the Phase 1 domain. Binary outcomes only: **EPS beat** (actual ≥ analyst consensus) = `true`; **EPS miss** = `false`.

### 4.1 Oracle sources (multi-source, v0)

**Updated in r077 (VAL-462):** Bloomberg Terminal and Refinitiv/LSEG (~$44K–$46K/year combined) are over-engineered for a 15-knower Phase 1 testnet. Replaced with free/low-cost sources.

| Source | Access | Data | Latency | Cost |
|---|---|---|---|---|
| SEC EDGAR (primary) | Free REST API | 8-K filings with earnings data | ~15 min post-release | Free |
| Nasdaq Data Link / ZACKS | Free tier | EPS actuals + consensus estimates | ~1 hour post-release | Free (≤500 tickers/month) |
| Alpha Vantage | Free + $50/mo paid | Earnings surprise data | Same-day | $50/month |

**Consensus source:** Wall Street Horizon (~$200/month). Machine-readable earnings estimates and actuals for S&P 500 names. Total Phase 1 oracle cost: ~$250/month ($3K for full Phase 1 period).

v0 policy: resolution is triggered only when SEC EDGAR 8-K confirms the EPS figure AND at least one of the two secondary sources agrees with the beat/miss determination vs. pre-filing consensus. If sources disagree after 24 hours, a dispute flag is set and the epoch enters a manual review hold (no auto-resolution in v0).

**Phase 2 upgrade:** Add Bloomberg or Refinitiv when fee revenue justifies it or institutional unknower clients require higher-grade sourcing.

### 4.2 Oracle relay address management

```solidity
// In EpistemicBondCoordinate:
mapping(address => bool) public approvedOracles;
uint256 public oracleBond; // must be posted at oracle approval time

function approveOracle(address oracle, uint256 bond) external onlyAdmin;
function revokeOracle(address oracle) external onlyAdmin;
```

Oracle relay must post a bond > `max(k_i)` across all active coordinates to be approved. Bond is slashable if oracle provides a resolution that disagrees with a supermajority challenge.

### 4.3 Provisional timeout handling (Option C from Atlas r073)

If the oracle liveness window (48 hours) expires without resolution:
1. Flag the epoch as `ORACLE_TIMEOUT`
2. Emit `OracleTimeout(epochId)` event
3. Release 70% of all stakes back to knowers (holdback forfeited to protocol treasury)
4. Mark T_i as stale for this epoch (no track record update)
5. Protocol admin can manually trigger re-resolution with a fresh oracle call within 7 days; after 7 days the epoch is permanently voided

---

## 5. TOWL Zone Gating (v0 Implementation)

The TOWL (Total Outstanding Write Liability) solvency gate from r070. In v0, this is implemented as a simple utilization check on coordinate-level stake.

### 5.1 Utilization formula

```
TOWL_utilization = total_holdback_at_risk / protocol_capital_reserve

Zone A: utilization < 0.70  → normal operation
Zone B: 0.70 ≤ utilization < 0.90 → new knowers pay 1.5x registration fee; existing knowers restricted to k_min stakes
Zone C: utilization ≥ 0.90 → new claim submissions blocked; existing claims proceed to settlement
```

`protocol_capital_reserve` in v0 = contract balance + seed subsidy treasury allocation.

### 5.2 v0 simplification

In v0 with 15 knowers and 30 coordinates (two waves), TOWL utilization is unlikely to reach Zone B. The check should be implemented but is not expected to trigger. Recommend logging utilization per epoch for baseline data.

---

## 6. Track Record Update Logic

The on-chain track record `T_i` is updated after each settled epoch:

```
// Pseudocode (Solidity fixed-point arithmetic required)

function _updateTrackRecord(address knower, uint256 epochId) internal {
    int256 R_i = _computeReward(knower, epochId);
    // expected_R = 0 by construction (log-score relative to S_prev)
    // T_i += η * (R_i - 0)
    trackRecords[knower] += (learningRate * R_i) / WAD;
    // Bound T_i to prevent runaway values
    trackRecords[knower] = _clamp(trackRecords[knower], -10 * int256(WAD), 10 * int256(WAD));
}

function _computeReward(address knower, uint256 epochId) internal view returns (int256) {
    EpochClaim memory c = claims[epochId][knower];
    bool outcome = epochOutcomes[epochId];

    // Apply ε-smoothing
    uint256 pTrue_eff = _applyEpsilon(c.pTrue);
    uint256 sPrev_eff = _applyEpsilon(sPrevValues[epochId]);

    uint256 pOutcome = outcome ? pTrue_eff : (WAD - pTrue_eff);
    uint256 sPrevOutcome = outcome ? sPrev_eff : (WAD - sPrev_eff);

    // R_i = k_i * [log(p_i(ω*)) - log(S_prev(ω*))]
    // Use fixed-point log approximation (e.g., ABDKMath64x64 or PRBMath)
    int256 logScore = _fixedLog(pOutcome) - _fixedLog(sPrevOutcome);
    return (int256(c.stake) * logScore) / int256(WAD);
}
```

**Implementation note:** Use a battle-tested fixed-point math library for `log`. Recommended: [PRBMath](https://github.com/PaulRBerg/prb-math) or [ABDKMath64x64](https://github.com/abdk-consulting/abdk-libraries-solidity). Do not implement custom log approximation.

---

## 7. Security Checklist for v0 Audit

Prior to testnet deployment, validate:

- [ ] **Reentrancy**: All external calls follow checks-effects-interactions. `claimSettlement` uses pull-payment pattern.
- [ ] **Commitment scheme soundness**: Commitment = `keccak256(pTrue || stake || nonce || epochId || contractAddress)`. Contract address is bound to prevent cross-contract replay.
- [ ] **Front-run resistance**: Commit phase is sealed. Reveal phase opens only after commit deadline. No mempool leak possible.
- [ ] **Log arithmetic overflow/underflow**: pTrue and S_prev are ε-bounded; log(0) is unreachable by construction.
- [ ] **T_i bounds**: Track record is clamped to [-10, +10] WAD. Unbounded T_i would allow unbounded σ(α·T_i) → 1, which W_max already prevents, but the clamp is defense-in-depth.
- [ ] **Oracle relay authentication**: Only approved oracle addresses can call `resolveOracle()`. Bond is checked at approval time.
- [ ] **Registration fee burn**: c_id is non-refundable. Confirm it cannot be recovered via any function.
- [ ] **TOWL gate enforced**: `commit()` reverts in Zone C. Zone B restricts new registrations and stake size.
- [ ] **Holdback release timing**: 70% at reveal deadline; 30% only after `settle()` completes. Cannot be withdrawn before.
- [ ] **Epoch state machine**: Transitions are one-directional (cannot revert to a prior state). `settle()` is idempotent.
- [ ] **W_max cap enforced**: `computeSPublic()` caps each w_i at `maxCredibilityFraction() * totalWeight`. Verify this is applied before normalization, not after.
- [ ] **Circuit breaker on reward/slash (added r077)**: `|R_i| ≤ 2 × stake` enforced in `settle()`. Prevents fixed-point log arithmetic edge cases from producing catastrophic slashes. Fuzz-test `_computeReward` with adversarial inputs (pTrue → 0, pTrue → 1, extreme S_prev values).

---

## 8. Phase 1 Pilot Spec

### 8.1 Coordinate selection (30 coordinates across two waves, 6–7 weeks)

**Updated r080/VAL-468 + r083/VAL-471:** Phase 1 uses 30 coordinates across two waves, not 15. The 4-week duration has been corrected to 6–7 weeks. The full confirmed coordinate list with dates, S_prev values, and sector distribution is in `phase1-coordinates.md`.

Target: 40+ US earnings events/week (Lens r073). Phase 1 is diversified across:

- Wave 1 (Apr 14–May 1): 17 coordinates — large-cap financials + tech + communication services
  (GS, JPM, WFC, C, BAC, NFLX, TSLA, GOOGL, META, MSFT, AMZN, AAPL, V, UNH, INTC, T, VZ)
- Wave 2 (May 5–May 30): 13 coordinates — tech + consumer + energy + industrials
  (NVDA, CRM, SHOP, DE, HD, WMT, LOW, TGT, DIS, UBER, PYPL, XOM, CVX)

Minimum viable: All 30 coordinates per `phase1-coordinates.md`, with S_prev initialized from the historical beat-rate table and consensus source Wall Street Horizon. FactSet consensus is NOT used in Phase 1 (r077/VAL-462 correction); Wall Street Horizon (~$200/month) is the standard consensus source for v0.

### 8.2 Knower recruitment criteria

15 knowers sourced from:
- Former sell-side equity analysts (bulge bracket or sector-specialist boutique)
- Alt-data providers with earnings track records (web traffic, credit card, satellite imagery)
- Independent forecasters with documented historical accuracy (Metaculus, Good Judgment Project)

Pre-screening: 10-question historical calibration test on prior earnings calls. Accept only applicants scoring ≥60% accuracy. Reject applicants with <20 qualifying data points (insufficient track record to screen).

### 8.3 Success metrics (Week 10 checkpoint)

**Updated in r081 (VAL-469):** Checkpoint moved from Week 8 to Week 10 per Phase 1 duration correction (6–7 weeks per r080). Active knower threshold corrected from ≥15 resolved epochs to ≥30 resolved predictions (matching the 30-coordinate two-wave structure).

| Metric | Target | Measurement |
|---|---|---|
| Active knowers | ≥10 with ≥30 resolved predictions | On-chain settlement records |
| T_i differentiation | ≥3 knowers with T_i ≥ 0.5 (positive, not absolute) after ≥30 resolved predictions | On-chain T_i values |
| Sybil signal | No cross-claim correlation > 0.85 among any pair | Off-chain correlation monitor |
| Oracle disputes | 0 | Dispute registry |
| Contract uptime | 100% | No stuck epochs; all oracle timeouts handled |

---

## 9. v0 Dependencies and Non-Negotiables

### What this document assumes is already decided:
- **Layer 1 status (clarified in r077)**: Phase 0–1 runs on a staging oracle (centralized relay: EDGAR + secondary sources), NOT on GestAlt L1. L1 is NOT required for Phase 0–1. L1 migration is triggered when: (a) GestAlt L1 is live on mainnet with ≥30 epochs of production oracle output, AND (b) Phase 1 exit criteria are met. These can proceed in parallel. Only the oracle relay address changes at migration time.
- **Token standard (updated in r077)**: USDC ERC-20 from day 1. 1 unit = $1 USDC. Use OpenZeppelin `SafeERC20`. Reasons: dollar-denominated accounting, no ETH price volatility for knowers, cleaner institutional presentation. Adds ~50 lines to contract; worth it.
- **Chain choice**: Arbitrum Sepolia for testnet (better faucet/test infrastructure). Base mainnet for production (lowest gas post-Dencun EIP-4844; Coinbase institutional backing; active DeFi). Do not deploy on Ethereum mainnet in v0.

### Non-negotiables (cannot defer without breaking the mechanism):
1. **c_id must be non-refundable** (Atlas r073 Q1 — Sybil floor)
2. **Sealed commit/reveal must be in the same contract epoch** (front-run resistance)
3. **ε-smoothing on log** (prevents undefined arithmetic)
4. **W_max cap on credibility weight** (prevents single-knower dominance)
5. **Option C provisional timeout** (Atlas r073 Q3 — do not leave stuck epochs unresolved)

---

## 10. What This Document Does Not Cover

These are explicitly out of scope for v0 and should not be added before Phase 1 exit criteria are met:

- Fee-gated unknower access (Phase 2)
- ERC-4337 account abstraction for knower UX (Phase 2)
- Cross-domain track records (Phase 3)
- L2 → L1 advisory coupling (Phase 3; multi-epoch equilibrium proof required first)
- Governance token for parameter updates (Phase 3)
- Formal audit (Phase 2; internal review only for Phase 1)
- Long-Tail Reserve Pool (LTRP) for slow-oracle retroactive slash liability (Phase 3; specified in knowledge-marketplace-aggregate.md r130–r131)
- Bounded-liability architecture: T3_escrow_longtail, T3_outage_lockup_cap, LTRP genesis seed protocol (Phase 3; specified in knowledge-marketplace-aggregate.md r131)
- DA degraded mode refinements: T3 gate pause, κ_degraded dynamic floor, one-epoch epistemic bridge at DA restore (Phase 3; specified in knowledge-marketplace-aggregate.md r129–r131)
- Lineage-bifurcated γ_corr (cross-lineage independence premium) (Phase 3; knowledge-marketplace-aggregate.md r129)
- β_effective clamp [β_min, β_max] as governance safety rail (Phase 3; knowledge-marketplace-aggregate.md r129)

*(Updated r089/VAL-494: added r129–r131 Phase 3 deferred items to this list. These are fully specified in knowledge-marketplace-aggregate.md but not required for Phase 0–1 v0 deployment.)*

---

*This spec is the Phase 0–1 engineering handoff. Engineering should implement EpistemicBond.sol and the oracle relay against this interface, deploy to testnet, and confirm the sealed-commit/reveal flow works before beginning knower recruitment. Questions or deviations → update this document and create a GitHub Issue.*

*Logan — ValCtrl AI Chief of Staff | r075 | VAL-460 → updated r089 | VAL-494 → updated r090 | VAL-500 → updated r091 | VAL-501 → updated r092 | VAL-502 → updated r093 | VAL-503 → updated r094 | VAL-504 → updated r095 | VAL-505 → updated r096 | VAL-506*
