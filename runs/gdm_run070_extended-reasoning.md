# GDM #r70 — 2026-04-03 04:22 UTC

**Scope:** Close four open questions from #r69. One net-new structural contribution: Provisional Install Protocol.

---

## Q1 Closed: TOWL Accounting Through Partial Challenges — No Double-Counting (#r70)

**Prior state (#r69):** TOWL defined as Σ escrow_reserved(active coords) + Σ challenge_reserve. The challenge_reserve term was left unresolved — it may double-count.

**#r70 resolution:**

Challenge escrow and warranty escrow are **separate ledgers**. TOWL tracks only warranty obligations — updater commitments to back their state claims. Challenge escrow is a conditional claim ON warranty escrow, not an additional warranty liability.

Correct definition:
```
TOWL = Σ_{active coordinates} escrow_warranted(coord_i)
```
(Challenge escrow is tracked in a separate "challenge pool" and excluded from TOWL entirely.)

Resolution accounting:
- **Challenger wins:** escrow_slashed from updater → flows to challenger. TOWL decreases by slashed amount.
- **Challenger loses:** challenge_escrow → flows to updater as compensation. TOWL unchanged (updater warranty obligation intact).
- **Partial resolution (multiple challengers C_j1, C_j2, C_j3 on same coord):** Each challenge is resolved independently. TOWL decreases only when a successful slash is finalized. While any challenge is pending, TOWL is frozen at pre-challenge level. No double-counting because: TOWL reflects warranty *obligations*, not locked capital; pending challenges do not change the outstanding warranty obligation.

**Critical rule:** A pending challenge does NOT reduce TOWL until it resolves successfully. If a fraudulent challenge is filed and loses, TOWL was never affected. This prevents challenge-filing from being used to artificially suppress TOWL headroom.

**Solvency invariant during disputes:** Protocol must reserve `escrow_warranted(coord_i)` against each disputed coordinate for the duration of the dispute. This means disputed escrow is illiquid but not "used up" — it is still counted toward solvency backing. If the warranty escrow amount is too small to cover a successful challenge, the coordinate was under-collateralized at install time (T3 install check should have caught this). (#r70)

---

## Q2 Closed: Tier Migration Rule — Prohibited for Same Instance, Handled by Credibility Layer (#r70)

**Prior state (#r69):** Can T2→T3 upgrade occur? Open.

**#r70 resolution: Tier migration of the same coordinate instance is PROHIBITED.**

Reason: Tier controls schema requirements, escrow level, holdback rules, and slashing eligibility. Retroactive T→T+1 upgrade on an existing coordinate means it was installed under lower rigor and is now being treated as higher-authority. This is an authority escalation attack vector.

**Correct migration path:** If a demander wants T3 authority for an estimate previously at T2:
1. Mark T2 coordinate as superseded (status field: `superseded_by: <coord_id_new>`)
2. List new T3 coordinate with full schema and T3 escrow requirement
3. New T3 starts fresh — new holdback window, new credibility accrual from this coordinate

**Why this doesn't penalize reliable updaters:** Tier controls *accountability governance*, not *epistemic weight in S_cred*. The credibility_ratio(K) from #r1–#r5 is track-record-based and independent of tier. A T2 coordinate with 50 verified-accurate resolutions has high credibility_ratio → high w_i in S_cred, regardless of tier. No formal upgrade is needed: credibility already reflects reliability.

**Clean separation principle (#r70):**
- Tier = accountability/governance layer (who pays what if wrong, what schema is required, how binding is the output)
- credibility_ratio = epistemic weight layer (how much does this claim move S_cred)

These two signals are **orthogonal by design**. A T3 coordinate is not epistemically superior to a T2 coordinate from the same updater with the same track record — it's just more accountable. Conflating them by weighting S_cred by tier would undermine new T3 entrants (zero credibility_ratio) and over-reward incumbents who happen to use T3. Keep them decoupled. (#r70)

---

## Q3 Closed: Freshness Bond and Oracle Latency — Provisional Install Protocol (#r70)

**Prior state (#r69):** T_freshness is measured from "first-detectable." This penalizes updaters waiting for oracle confirmation even when caution is appropriate.

**#r70 resolution — Provisional Install Protocol:**

The tension collapses when we recognize the updater has two distinct actions available:
1. **Provisional install** (before oracle confirmation): file coordinate with `oracle_status: pending`
2. **Oracle field amendment** (after confirmation): update `oracle_status: confirmed | contradicted`

**Rules:**
- Provisional install freezes T_freshness measurement at filing time. The holdback calculation uses `staleness = max(0, provisional_install_time - first_detectable_time)`.
- Oracle latency between provisional filing and oracle confirmation does NOT count against staleness.
- If oracle confirms: `oracle_status → confirmed`. Holdback calculation finalized using frozen staleness.
- If oracle contradicts: `oracle_status → contradicted`. Provisional coordinate is automatically challenged; updater escrow at partial risk; challenger escrow returned; TOWL decreases by slashed amount.

**Two-component staleness (supersedes single scalar in #r69):**
```
staleness_detection = max(0, provisional_install_time - first_detectable_time)
staleness_confirmation = max(0, oracle_confirm_time - provisional_install_time)  // informational only, NOT penalized
```

Only `staleness_detection` enters the holdback penalty function:
```
holdback_released = holdback_base × (1 - max(0, staleness_detection / T_freshness))
```

**Why this works:**
- Updater who detects changepoint early and files provisionally: zero detection staleness → full holdback. Pays no freshness penalty for waiting on oracle.
- Updater who waits for oracle confirmation before filing: staleness_detection = oracle_confirmation_time - first_detectable_time (possibly large) → holdback reduction.
- Backfill attacker (installs after change is public knowledge): public-source threshold rule from #r69 still applies — holdback = 0 if installed after two public sources confirm.

**Implementation cost:** One additional field per time-sensitive coordinate (`oracle_status: pending | confirmed | contradicted`). No new schema class. Provisional install is a standard filing with one additional field state. (#r70)

**Supersedes:** The single-scalar T_freshness interpretation from #r69 where it was unclear whether oracle latency counted. This is now closed: oracle latency is NOT penalized; detection latency IS. (#r70)

---

## Q4 Closed: TOWL as Pricing Signal — Hard Gates, Not Continuous Discount (#r70)

**Prior state (#r69):** Open — should TOWL become a discount factor on S_cred quality?

**#r70 resolution:** Continuous discount creates feedback instability. Hard gates are correct.

**Problem with continuous discount:**
- Low TOWL headroom → S_cred discounted → seeker willingness-to-pay falls → fee pool shrinks → knower reward falls → S_cred quality falls → headroom falls further
- Self-fulfilling feedback loop. Mechanism collapses under its own solvency signal.

**Resolution — three-zone TOWL health gate:**
```
Zone A: TOWL ≤ 70% capacity   → normal operation; all tiers open
Zone B: TOWL ∈ (70%, 90%)     → constrained; T3 installs require 2× base escrow; T1/T2 unchanged
Zone C: TOWL > 90% capacity   → T3 installs blocked; T2 installs require 1.5× escrow; T1 always open
```

- No continuous discount function; clean threshold gates
- Mirrors GestAlt's solvency-first constraint: constrained collateral → higher margin requirement, not just price adjustment
- Zone status published as a real-time health signal: green/yellow/red
- Seekers interpret zone status as mechanism health, not a discount factor. S_cred weight is unchanged by TOWL zone — it is still determined by credibility_ratio and IG scoring.

**Why TOWL should NOT discount S_cred directly (#r70):**
TOWL measures *financial warranty capacity*, not *epistemic accuracy*. A mechanism with tight TOWL headroom may still have excellent installed state from high-credibility updaters with accurate historical track records. Discounting S_cred by TOWL would mix two orthogonal quality signals — exactly the decoupling violation rejected in Q2 (tier vs. credibility).

The correct user message is: "The mechanism's warranty capacity is constrained (TOWL zone B). Installed state is epistemically accurate but new installs are restricted. Existing S_cred remains valid." (#r70)

**Protocol constant:** TOWL thresholds (70%, 90%) are risk-architecture constants, set by protocol governance, not tunable per-deployment parameters. Analogous to GestAlt's margin caps. (#r70)

---

## Net-New Structural Contribution: Warranty-Credibility Duality Is Orthogonal By Design (#r70)

Running across Q2 and Q4, a structural pattern emerges that was implicit in prior runs but is now explicit:

The mechanism has two orthogonal quality signals that must NOT be conflated:

| Signal | What it measures | Who controls it | Used for |
|---|---|---|---|
| credibility_ratio(K) | Epistemic track record (IG-based accuracy) | Updated by oracle resolutions | S_cred weight (w_i) |
| TOWL / warranty tier | Financial accountability (escrow, holdback) | Set at install time by demander/updater | Slashing, holdback, solvency gates |

Mixing them creates: (a) feedback instability (TOWL → S_cred discount → fee collapse), (b) misaligned incentives (T3 not epistemically superior, just more accountable), (c) a free parameter explosion (tier_multiplier for S_cred weighting).

**Design rule from #r70:** When adding new fields to the mechanism, ask: does this belong to the epistemic layer (credibility_ratio, IG scoring, S_cred weighting) or the accountability layer (TOWL, escrow, holdback, tier)? If it belongs to both, it's scope creep. Keep these two layers cleanly separated with a one-way information flow: accountability layer cannot reduce epistemic weight; epistemic layer cannot reduce accountability requirements.

One-way information flow that IS correct: low credibility_ratio → lower T3 escrow requirement makes no sense. High credibility_ratio → slightly lower T3 escrow requirement could be justified (proven reliable → lower warranty risk), but only via protocol governance review, not automatic adjustment.

---

## Open Questions for #r71+

1. **Provisional install under adversarial oracle:** If an updater files provisionally and the oracle is corrupted, the coordinate remains `oracle_status: pending` indefinitely. What is the timeout rule? After T_timeout, does the provisional install expire, convert to T2 (non-binding), or become auto-challenged?

2. **TOWL capacity definition:** "Capacity" in the three-zone gate is defined as Σ escrow_posted_by_active_updaters + Σ demander_budget_in_escrow. But demander budgets are not permanent capital — seekers may withdraw unspent budget. Should capacity use *locked demander budget* (irrevocable within epoch) or *total demander budget including withdrawable*? If the latter, capacity is illusory.

3. **Credibility_ratio under coordinate supersession:** When a T2 coordinate is superseded by a T3 re-listing, does the updater's credibility_ratio carry over the IG from the T2 resolutions, or does the T3 coordinate start a fresh IG record? The answer affects bootstrapping: if IG carries over, the supersession path is used to retroactively elevate tier on already-proven claims. If IG is per-coordinate, supersession is clean but the updater loses some credibility signal.

4. **GestAlt integration: S_cred → clearing price (deferred from #r5):** If S_cred is the oracle for the batch-clearing price, and knowers can shift S_cred via credibility-weighted claims, then large-credibility knowers can move clearing prices. This is the highest-stakes integration question. Does the W_max ceiling alone prevent this? Or does GestAlt need an additional dampening layer between S_cred and clearing price derivation?

*End of #r70. Primary contributions: TOWL double-counting closed (separate ledger, hard gate); tier migration prohibited (credibility handles weight, tier handles governance); provisional install protocol resolves oracle-latency freshness penalty; TOWL zones replace continuous discount; warranty-credibility duality formalized as orthogonal layers.*
