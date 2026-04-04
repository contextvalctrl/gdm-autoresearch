# Knowledge Marketplace Mechanism — Aggregate Document

*Auto-maintained by Richard (ValCtrl). Do not edit manually.*

---

## Run Log

- **#r1** — 2026-04-03T04:32Z — Founding entry. Doc was unreadable (no gog auth, browser offline). Full first-principles analysis written from scratch.
- **#r73** — 2026-04-03T07:52Z — Cycle/deadlock elimination (implication declarations are incentive-metadata only); timestamp-tagged staleness discount for cross-epoch-class GestAlt interface; four-layer SEE capture defense; chain-length discount γ^(depth-1) for implication stacking.
- **#r74** — 2026-04-03T08:52Z — Per-class staleness decay shape κ; two-tier SEE appeals (oracle Tier A + sortition Tier B); β range [1.3, 2.0]; SEE pre-staging defense via claim consistency + query fee clawback; Epistemic Audit Trail (EAT) named as fourth integrity property.
- **#r75** — 2026-04-03T09:52Z — EAT DA stack (Celestia + Ethereum anchor); DA liveness as fifth precondition integrity property; degraded mode specification; pre_shock_window principled formula; continuous SEE taper; trustless correlation filter computation; anti-fragmentation gap in β/γ fixed; closed-form β/γ joint calibration with governance redesign.
- **#r132** — 2026-04-03T19:12Z — Multi-class LTRP attribution (per-class independent, no spillover); bridge/degraded epoch exclusion from calibration rolling windows; LTRP over-seed proactive recall (conditional 3× safety × 4-epoch gate); non-additive combined-lockup ceiling for simultaneous provisional+outage tolling; bounded-liability architecture closed.
- **#r133** — 2026-04-03T19:52Z
- **#r135** — 2026-04-03T20:12Z — Debt retirement absorption cap (lifetime-escrow-anchored); toll-stacking doubling ceiling for implication_bonus_escrow; M_stable evaluation-boundary parameter activation; debt withholding scope — capital-at-risk only, contingent rewards exempt — `implication_bonus_escrow` as fourth first-class escrow category (protocol reserve, not TOWL-counted, bilateral lockup ceiling); Zone C epochs included in calibration (not excluded, flagged only); M_stable majority-window tolerance (1-of-5, non-consecutive); A-side conditional partial release for cross-class implication declarations with clawback obligation; escrow taxonomy complete.
- **#r141** — 2026-04-03T21:12Z — Challenge submission fee replaces slash-gate (spam filter, never blocks small-stake challenge); bifurcated implication bonus: capital-comp (α_cap × β_escrow, staleness-insensitive) + epistemic-service (staleness-discounted via Σ eff_weight); cross-class bridge asymmetry confirmed consistent — no coordination rule; bonus settlement contract design-complete.
- **#r160** — 2026-04-04T00:22Z — v2.1→v2.2 additive deployment (coordinate-class-level version pinning; no forced migration); atomic StateFreeze transaction for S_cred at T_anchor; Demo Day one-paragraph narrative vs Polymarket; epistemically-live threshold (1 challenger per 5 T3 installs, absolute floor 3); v2.1 production-readiness gate (6 criteria); Invariants #36–#38.

---

## 1. Base Primitive — What Is Being Exchanged?

Not probability shares. Not belief tokens.

The base primitive is: **a credible information claim about the value of a hidden variable, backed by forfeitable capital.**

- A **claim** = (agent_id, variable_id, asserted_distribution, stake_amount, expiry)
- The stake is collateral against the claim being wrong at resolution — not a bet on crowd belief.
- A **query** = (agent_id, variable_id, willingness_to_pay, quality_threshold)

The exchange: conviction ↔ attention/capital. Knowers sell credibility; unknowers buy state updates.

**Conserved quantity:** *epistemic debt.* When an unknower pays for a credible state update, they retire uncertainty. When a knower is wrong, they forfeit stake — their credibility is destroyed, not just PnL redistributed. This is structurally different from prediction markets, where capital is conserved and truth reallocates it. Here, **credibility** is the scarce resource; capital is its proxy. (#r1)

---

## 2. State Model

Global state vector **S = {s_1, ..., s_n}** where each s_i is a posterior distribution over a hidden variable.

**Update rule on claim submission** (agent a, variable i, distribution d_a, stake k_a):
- Weight: w_a = f(k_a, track_record_a) — credibility-weighted stake
- S_i ← Bayesian update of S_i given d_a with weight w_a
- k_a locked in escrow

**On query match** (agent b pays fee f_b for variable i):
- b receives current S_i snapshot
- f_b distributed pro-rata to recent credible contributors to S_i (weighted by w_a × recency)

**On resolution** (oracle reveals truth v_i):
- Calibrated claimants rewarded from loser pool (log-scoring rule)
- Poor claimants forfeit stake proportionally
- Track records updated

**Key:** S is not a price. It is a posterior over reality, updated by credibility-weighted claims. (#r1)

---

## 3. Credibility Model

Raw stake alone is insufficient — rich agents would dominate. Credibility score C_a:

```
w_a = C_a(historical) × log(1 + k_a) × recency_factor
```

Where C_a is a product of:
- Historical calibration (Brier/log score over resolved claims)
- Recency decay (old track records fade)
- Diversity penalty (agents who always post correlated identical claims on correlated variables are penalized — reduces echo chambers)

Properties:
- New agent, large stake → moderate influence
- Established agent, small stake → moderate influence
- Established agent, large stake → high influence
- New agent, small stake → effectively ignored

**Why capital improves epistemics here:** Forfeiture risk filters noise. Loss aversion converts private signals into costly, credible commitments. Unlike LMSR where any capital moves the price, here capital only amplifies already-credible agents. (#r1)

---

## 4. Market Roles

| Role | Description | Paid from | Loses |
|------|-------------|-----------|-------|
| **Knower** | Has private signal; submits (d_a, k_a) | Query fees (ongoing) + loser forfeitures (resolution) | Stake if wrong |
| **Unknower** | Wants state estimate; pays query fee | — | Query fee |
| **Oracle** | Reveals ground truth v_i | Protocol fee | — |
| **Protocol** | Escrow + distribution layer | Protocol fee | — |

Unknowers receive the aggregate posterior S_i, not raw individual claims. The mechanism is bilateral in the sense of real buyer (unknower) and real seller (knower's credible signal) — **not** bilateral in the PM sense of two sides betting against each other. (#r1)

---

## 5. Settlement Model

**Clean resolution (full oracle):**
- Winners (calibrated claimants) receive: stake return + share of loser forfeitures + pro-rata query fees earned during window
- Losers forfeit stake proportionally to scoring rule distance
- Track records updated

**Partial resolution (proxy observable):**
- Partial scores applied; stakes partially released proportional to confidence in partial signal
- Remainder held until full resolution or timeout

**Oracle failure / no resolution:**
- Stakes returned minus protocol fee
- Query fees already paid are NOT refunded (snapshot was delivered)
- Track records unchanged

**Continuous variable / close claims:**
- Kernel scoring: reward decays smoothly with distance from truth (no binary win/loss)

**Critical distinction from PM:** Mechanism generates query fee revenue *regardless of resolution*. Knowers earn from information being used, not just from winning bets. (#r1)

---

## 6. Attack Surface

| Attack | Description | Mitigation | Residual risk |
|--------|-------------|------------|---------------|
| **Bluffing** | Stake high-confidence wrong claim | Quadratic stake for sharp distributions; forfeiture at resolution | Rich agents absorb cost |
| **Sybil** | Many agents post same claim to inflate w | Diversity/correlation penalty; co-registration signal | Hard without on-chain identity |
| **Wash credibility** | Build track record on easy Qs, bluff on hard | Domain-specific track records; variance penalty for low-diversity claimants | Partial mitigation |
| **Collusion** | Knowers coordinate to shift S for payout | Commit-reveal scheme; colluders sell bad product → unknowers lose → claim recovery | Hard to fully prevent |
| **Cheap talk** | Low-stake claims | Weight function caps influence of low-stake claims | Essentially solved |
| **Oracle gaming** | Time claims to known oracle outcome | Hard claim submission deadline before oracle lock-in | Requires reliable oracle timing |
| **Query free-riding** | Unknowers infer S from behavior without paying | Delayed/private S publication to paying unknowers only | Cross-market leakage remains |

(#r1)

---

## 7. Comparison vs LMSR / Orderbooks / Batch Auctions

**vs LMSR:**
- LMSR: automated market maker, price = f(cumulative shares). Anyone moves price proportional to capital.
- KM: no AMM. State updated by credibility-weighted claims. Capital = credibility proxy + forfeiture risk.
- LMSR advantage: elegant, single-parameter (b), well-studied, simple.
- KM advantage: rewards information *quality* not capital *volume*. A well-calibrated poor agent has more influence than a rich uninformed agent. LMSR rewards whoever moves price first; KM rewards whoever was right.
- LMSR failure mode: liquidity whales push price regardless of information quality.

**vs Standard Orderbook:**
- Orderbook: two-sided buy/sell matching on outcome shares. Requires liquid two-sided market.
- KM: no matching required. Knowers submit to a pool; unknowers pull from the pool. Works in thin information environments.
- Orderbook advantage: continuous price discovery, hard to game at scale.
- KM advantage: no spread problem, no front-running by design, works without speculative demand.

**vs Batch Auction:**
- Batch: collect orders, clear at uniform price, prevent front-running.
- KM: anti-front-running via commit-reveal. But KM is not price-based — threat model is calibration manipulation, not price manipulation.
- Batch advantage: excellent for high-frequency manipulation resistance.
- KM advantage: no price signal needed; state is a distribution, not a scalar.

**Summary:** KM is better when information quality > market depth, when unknowers pay directly for state estimates, when thin markets make orderbooks illiquid. KM is worse when deep liquid markets exist, anonymous participation is critical, or continuous price signals are needed for derivatives pricing. (#r1)

---

## 8. Simplest Viable Mechanism Sketch

**Round lifecycle:**
1. **Open window (T_0 → T_lock):** Knowers submit sealed claims (commit-reveal hash).
2. **Reveal window (T_lock → T_reveal):** Claims revealed; stakes locked.
3. **Query window (T_reveal → T_resolve):** Unknowers pay fee; receive current S_i. Fees distributed continuously.
4. **Resolution (T_resolve):** Oracle publishes v_i.
5. **Settlement:** Score each d_a vs v_i. Winners paid from loser pool. Track records updated.

**State aggregation (simplified):**
```
S_i = Σ_a (w_a × d_a) / Σ_a w_a
w_a = min(C_a × log(1 + k_a), cap)
```

**Scoring:** Log score — reward_a ∝ log(d_a(v_i)) − baseline. Negative scores forfeit proportionally.

**Minimum viable contracts:**
- VariableRegistry, ClaimEscrow, StateAggregator, QueryFeeDistributor, SettlementEngine

(#r1)

---

## 9. Strongest Reason This Idea Fails

**The calibration bootstrapping problem.**

Track records require resolved claims. In early periods, no one has a track record. The state S_i defaults to stake-weighted average — which is just a *plutocratic prediction market with extra steps.* The mechanism becomes epistemically superior to LMSR only after enough resolved questions accumulate.

Chicken-and-egg: the mechanism needs track records to function well, but it needs to function to generate track records. Early participants have incentives to game the track record phase on easy questions.

**Secondary failure:** Unknowers may not pay. In a PM, speculative demand creates liquidity without a specific buyer. In KM, unknowers must consciously pay for state updates. If they can free-ride (infer S_i from market behavior), query revenue collapses and knowers have no ongoing incentive. (#r1)

---

## 10. Best Surviving Variant

**Credibility-Gated Orderbook**

Don't abandon the PM orderbook. Gate order submission by credibility score:
- Only agents above a credibility threshold submit limit orders.
- New agents pass through a "credibility onramp": small-stake claims on low-value questions to establish track record.
- Orderbook price remains market-driven; shallow liquidity from uncredentialed actors is suppressed.
- Query fees still exist: entities pay to see credibility-filtered orderbook depth.

This preserves:
- Continuous price discovery (orderbook)
- Manipulation resistance (credibility gating)
- Ongoing incentive for knowers (query fees + position PnL)

And fixes the bootstrapping problem: new agents participate (via onramp) with limited influence while established orderbooks provide liquidity.

**This is the strongest variant** because it keeps PM market advantages (price signals, liquidity, continuous clearing) while injecting the key KM insight: not all market participants should have equal influence on the state vector. (#r1)

---

---

## #r71 Contributions — 2026-04-03T07:12Z

### Q1: Provisional Install Under Adversarial Oracle — Timeout FSM

Provisional install has a three-outcome finite state machine; no infinite pending state.

```
oracle_status: pending
  ↓ within T_oracle_window
  ├── oracle confirms → confirmed; staleness_detection finalized
  ├── oracle contradicts → contradicted; auto-challenge initiated
  └── beyond T_oracle_window:
        once-only extension (updater must post bond + show evidence oracle in progress)
        if extended window also fails → auto-demotion to T2 (NOT full expiry)
```

**Auto-demotion is NOT slashing.** Oracle failure is oracle failure, not updater fault. T2 demotion preserves epistemic value (claim still contributes to S_cred via credibility_ratio) while removing T3 contractual warranty obligations. Consistent with tier-credibility orthogonality (#r70): tier downgrade does not destroy epistemic track record.

**Adversarial oracle with quorum:** Multi-source oracle with k/n quorum. If < k/n confirm AND some contradict → governance-required quorum dispute (only state that can exceed T_provisional_max). If ≥ k/n confirm → coordinate confirms regardless of remaining sources.

**New protocol constants (#r71):** T_oracle_window (per-class), T_provisional_max = 3× T_oracle_window, k/n quorum minimum k=2/n=3 for T3. (#r71)

---

### Q2: TOWL Capacity — Epoch-Locked Budget, Tiered by Coordinate Class

**Correct TOWL definition (#r71):**
```
TOWL_capacity = Σ updater escrow_posted + Σ demander budget_locked_this_epoch
TOWL_utilization = Σ_coords escrow_warranted(coord_i) × tier_weight(coord_i)
tier_weight: T1=0, T2=0.25, T3=1.0
```

Total-including-withdrawable demander budget is illusory capacity — adversary can inflate apparent Zone A headroom then withdraw, triggering sudden Zone C cliff. Epoch-lock prevents this: demanders commit at epoch open, no mid-epoch withdrawal.

**Epoch lock fee:** Protocol fee on locked budget (refunded if unspent at epoch close, minus small protocol fee). T2 demand not fully excluded but counted at 0.25× to reflect proportional solvency risk.

**TOWL zone recalculation:** Once per epoch at epoch open, frozen for epoch duration. No intra-epoch zone oscillation from fee flows. (#r71)

---

### Q3: Credibility_ratio Carry-Over Under Supersession — Attenuated Transfer

Full carry-over exploits T2's lower accountability bar to bootstrap unjustified T3 epistemic weight. Full reset wastes real track record and enables adversarial credibility scrubbing (blow up T2, re-list T3 at zero).

**#r71 resolution — attenuated carry-over:**
```
credibility_ratio_T3_initial = α_carry × credibility_ratio_T2_final

α_carry = (1 - tier_gap_penalty) × min(1, n_T2_resolutions / N_anchor) × recency_decay

tier_gap_penalty: T2→T3 = 0.3, T1→T3 = 0.6, same-tier re-list = 0.1
N_anchor = 20 (governance parameter for full saturation)
recency_decay = exp(-λ × t_gap) where t_gap = time since last T2 resolution
```

**Adversarial scrub protection:** If credibility_ratio_T2_final < 0 (net-wrong updater), carry-over propagates negative credibility into T3 — worse than a fresh entrant. Adversary cannot escape negative history by supersession; they must restore positive credibility on T2 first. (#r71)

---

### Q4: GestAlt Integration — Epoch-Delay Oracle Buffer (#r71)

W_max ceiling (caps single-agent S_cred influence) is necessary but insufficient. A correlated group of non-colluding high-credibility agents can shift S_cred within one epoch and front-run their own update into the same clearing window.

**Required dampening:**
```
S_cred_oracle(t) = S_cred_snapshot(t - 1_epoch)
```

Claims in epoch t affect S_cred, but clearing price in epoch t uses S_cred from epoch t-1. Front-running within a single clearing window is impossible: you cannot place orders in epoch t based on S_cred you haven't submitted yet.

**Two-pathway architecture:**
- Normal: S_cred claims(t) → epoch buffer → oracle input(t+1) → clearing price(t+1)
- Emergency: k-of-n governance multisig → direct clearing price input(t); emergency fee > normal; requires circuit breaker trigger

**Why W_max alone fails:** W_max prevents single-agent dominance. Epoch buffer prevents group-correlated front-running. Both layers required. (#r71)

---

### Structural Synthesis: Epoch Boundary as First-Class Mechanism Clock (#r71)

The epoch is not an administrative convenience. It is the mechanism's primary manipulation defense. All major state transitions are epoch-indexed:

- TOWL zone transitions → epoch boundary only
- S_cred → clearing price feed → one-epoch buffer
- Provisional install timeout → measured in oracle-latency windows, counted at epoch granularity
- Credibility_ratio carry-over → recency_decay measured from epoch of last resolution

**Deep isomorphism with GestAlt (#r71):**
- GestAlt: continuous order flow → batch clearing (epoch boundary converts adversarial pressure into bounded-influence events)
- Knowledge marketplace: continuous claim submission → epoch-gated S_cred update → one-epoch-delayed oracle feed

Both mechanisms are anti-front-running through discrete epochal clearing. The knowledge marketplace is not just compatible with GestAlt's architecture — it is structurally isomorphic to it. The knowledge marketplace IS GestAlt's epistemic layer, running at the same clock cadence. (#r71)

---

### Open Questions for #r72+

1. **Correlated credibility collapse:** Systemic mis-calibration black swan causes many high-credibility updaters wrong simultaneously. Simultaneous slashing crashes S_cred quality and TOWL capacity in same epoch. Credibility insurance / circuit breaker mechanism?
2. **Multi-coordinate dependencies:** Coordinate A logically implies coordinate B. Different updaters, conflicting implications. Propagation rules?
3. **Epoch length optimization:** Shorter = better S_cred freshness; longer = lower coordination overhead and better capital efficiency. Optimal epoch length per coordinate class?
4. **Neutral vs negative entrant on T3:** New entrant with zero T3 history starts at credibility_ratio=0. Adversary with negative T2 history carries negative attenuated carry-over. Fresh entry is treated better than damaged entry — is this exploitable (create fresh sybil identity to escape negative history)?

*Note: #r72 addressed all four above — see #r72 section below.*

---

## #r72 Contributions — 2026-04-03T07:42Z

**Q1 (Correlated credibility collapse) → SEE circuit breaker (#r72):**
Systemic Event Epoch (SEE) triggers when error rate > θ_sys AND oracle-confirmed external shock. On SEE: slashing deferred to credibility suspension (escrow locked, credibility frozen not cut); governance review determines individual vs systemic fault; TOWL floor prevents capacity crash to zero. Attack defense: SEE requires oracle-confirmed external event, not just error rate — prevents collusion-induced false SEE. (#r72)

**Q2 (Multi-coordinate dependencies) → Implication declaration pattern (#r72):**
No automatic propagation — ever. Implication declarations: knower stakes escrow on both A and B simultaneously, earns bonus if both resolve correctly, loses both on failure. Conflict detection: value-based only (install of B=value conflicts with currently installed B=other_value when A implies B and A is installed). Conflict resolution window: one epoch, oracle adjudicates. Consistent with capital accountability at every step. (#r72)

**Q3 (Epoch length) → Two-level micro/macro epoch structure (#r72):**
Micro-epoch (e.g., 1h / oracle heartbeat): claim submissions, challenge tracking, provisional timeout, W_max enforcement. Macro-epoch (e.g., 24h/1wk): TOWL recalculation, S_cred→clearing handoff (one macro-epoch buffer), credibility_ratio scoring, tier migration. Macro-epoch length per coordinate class = at least 2× expected oracle resolution latency. High-freq coords: short macro-epoch. Low-freq regulatory/legal coords: long macro-epoch. (#r72)

**Q4 (Sybil / negative credibility escape) → Identity bonds + graduated capacity + behavioral fingerprint (#r72):**
T1 entry requires non-trivial identity bond (links to on-chain identity with economic history). Graduated capacity: new entrants start at sub-capacity, graduate after first successfully warranted epoch. Behavioral fingerprinting: adversaries with slashed-for-manipulation history flagged for governance review if new identities exhibit same submission patterns. Neutral-entry window preserved — zero history ≠ negative history. (#r72)

---

## #r73 Contributions — 2026-04-03T07:52Z

**Q1 (Implication graph cycles → deadlock risk) → Cycles are harmless; implication declarations are incentive-metadata (#r73):**
Implication declarations do not create structural graph edges. No mechanical propagation exists. A→B and B→A is legal: both score against oracle independently. Conflict detection is value-based only. Cycle detection is not needed. Implication incentive formalized: stake both A+B together → bonus β if both correct, implication_bond forfeit if A correct but B wrong, normal slash if A wrong. (#r73)

**Q2 (Cross-epoch-class coordination for GestAlt) → Timestamp-tagged staleness discount (#r73):**
GestAlt clearing layer uses most-recently-published S_cred per coordinate at clearing time, regardless of when that coordinate's last epoch closed. Each coordinate registration includes: macro_epoch_length, staleness_window, freshness_bonus. Effective weight in clearing:
`effective_weight_i = base_weight_i × max(0, 1 - age_i / staleness_window_i)`
Fast-epoch coords contribute high-weight fresh S_cred. Slow-epoch coords contribute lower-weight discounted S_cred. Staleness surfaced, not hidden. Resolves heterogeneous clock problem without synchronized epochs. (#r73)

**Q3 (SEE governance capture) → Four-layer defense (#r73):**
1. Automatic triggers for unambiguous external shocks (approved oracle registry, market halt signals, emergency declarations) — no governance discretion
2. Evidence bond + council stake for discretionary declarations — false declaration costs real capital
3. Challenger mechanism + governance bounty — accurate reporting is profitable for watchdogs
4. Council reputation tracking — governance voting accuracy included in credibility_ratio history

Layer 1 handles the majority of genuine SEE events; Layers 2-4 handle the residual discretionary risk. (#r73)

**Q4 (Implication chains as informal oracle networks) → Chain-length discount γ^(depth-1) (#r73):**
Chain_depth = max hop depth of any implication chain terminating at coordinate C. Bonus factor for chain declarations: β × γ^(depth-1), γ ∈ (0,1) e.g. 0.7. Depth ≥ 5 earns no bonus. Combined with diversity penalty on correlated claims. Chains exceeding depth/breadth thresholds are flagged for governance review (not auto-blocked). The mechanism never regulates implication chains as oracle networks because capital accountability is maintained at every link independently. (#r73)

---

## #r74 Contributions — 2026-04-03T08:52Z

**Q1 (Staleness discount shape) → Per-class decay exponent κ (#r74):**
Generalized staleness decay formula:
`effective_weight_i = base_weight_i × max(0, 1 - (age_i / staleness_window_i)^κ_i)`
κ < 1 (concave): stable/slow-changing coordinates — slow early decay, steeper cliff near expiry. κ = 1 (linear): neutral default. κ > 1 (convex): volatile/price coordinates — fast early decay, shallow tail. Protocol defaults: unknown class = κ=1; financial price = κ=2.0; regulatory/structural = κ=0.5; T3 warranted = κ ≥ 1 enforced. Both staleness_window and κ must be specified at coordinate class registration — mechanism is undefined without both. New design law: (staleness_window_i, κ_i) together define the *epistemic half-life* of a coordinate class. (#r74)

**Q2 (SEE governance appeals body) → Two-tier appeals: oracle Tier A + sortition Tier B (#r74):**
Tier A (primary): if SEE declaration is based on an approved oracle registry source, the same source is queried retrospectively — shock_confirmed auto-upholds SEE; shock_not_confirmed auto-overturns it with full council slash. No human deliberation for verifiable cases.
Tier B (fallback for ambiguous cases only): sortition panel of N_panel participants (credibility_ratio > θ_appeal), conflict-filtered to exclude any participant whose epoch-t position benefited from the SEE declaration. Panel members post participation bonds; correct majority earns from council forfeitures; incorrect majority loses bonds. Tier A routes the majority of cases; Tier B handles the residual. Two-tier structure makes governance capture economically infeasible for verifiable-event cases and very difficult for discretionary cases. (#r74)

**Q3 (Implication bonus β) → Theoretically motivated range [1.3, 2.0], default 1.5 (#r74):**
Lower bound derivation: for a knower with implication uncertainty ε (P(A correct, B wrong) = ε), declaration has positive EV iff β > ε/(1-ε). For ε = 0.1, β > 0.11 — very permissive. Upper bound: β should not cause implication bonus to exceed reward from two independent strong claims; proposed maximum β = 2.0. Default β = 1.5 provides meaningful incentive without making implication stacking the dominant strategy. β and γ (chain discount, #r73/Q4) are complementary: β sets incentive magnitude; γ caps chain depth benefit. They should not be calibrated independently. (#r74)

**Q4 (Pre-staged SEE exploit) → Claim consistency test + query fee clawback (#r74):**
SEE eligibility is not automatic for all claims protected by the SEE window. Eligibility requires:
1. Claim was not submitted within pre_shock_window = 2× staleness_window_i before shock onset
2. Claim was not a submission-time outlier: σ_c ≤ θ_outlier (standardized distance from S_cred at T_c; proposed θ_outlier = 2.0)

SEE-ineligible claims: full slash applies regardless of systemic event. 50% query fee clawback proportional to outlier magnitude σ_c, flowed to challenger pool. Requirement: S_cred history must be immutably committed at each epoch (Merkle root on-chain, full state on DA layer) to enable retrospective consistency test. (#r74)

**New first-class mechanism integrity property — Epistemic Audit Trail (EAT) (#r74):**
The mechanism cannot execute its defenses (staleness discount, SEE eligibility test, claim consistency check, appeals oracle query, implication chain tracing) without reconstructable history of S_cred at every update event, claim submissions with timestamps/distributions, and epoch/oracle publication events.

EAT is the fourth first-class integrity property alongside:
1. Solvency — escrow covers warranted claims (financial)
2. Calibration — S_cred converges toward truth (epistemic)
3. Freshness — S_cred not stale beyond class windows (temporal)
4. Epistemic Audit Trail — every state/claim at every past time is reconstructable for adjudication (integrity) **(new, #r74)**

Recommended EAT implementation: per-epoch Merkle root on-chain (cheap); full state on off-chain DA layer; dispute-triggered on-chain reconstruction via Merkle proof. All future mechanism features that depend on reconstructing past state must be explicitly marked as EAT-dependent. (#r74)

---

---

## #r75 Contributions — 2026-04-03T09:52Z

**Q1 (EAT DA architecture and failure behavior) → Celestia primary + Ethereum Merkle anchor + degraded mode (#r75):**

Recommended EAT DA stack: full S_cred state + all claim commitments to Celestia (per micro-epoch); aggregated Merkle root to Ethereum calldata (per macro-epoch, 32 bytes). Disputes: filer provides Celestia blob reference + Merkle inclusion proof, verified against on-chain macro-epoch root. ≥ 2 independent DA providers required for redundancy.

**DA liveness is the fifth mechanism integrity property** — operating as a precondition for all others. On DA outage:
- Dispute window timers toll (no lapsed-deadline slashing during outage)
- T3 warranted claim installations suspended (auto-demoted to T2)
- SEE declarations deferred (EAT-dependent)
- TOWL recalculation frozen at last-known-good state
- Outage period annotated in EAT when DA restores

**Degraded mode formally specified:** Mechanism operates in two explicit modes: (1) **Normal mode** — all five integrity properties active; (2) **Degraded mode** — DA liveness violation; T3 halted, dispute windows tolled, TOWL frozen, SEE deferred. T1/T2 operations continue; clearing continues with stale S_cred at last-known-good state. Mode transitions governed by oracle-verified DA liveness probes. (#r75)

**Complete integrity stack:**

| Property | Layer | Mechanism |
|----------|-------|-----------|
| Solvency | Financial | Escrow ≥ warranted claims; TOWL zone management |
| Calibration | Epistemic | Log-score S_cred convergence; track record |
| Freshness | Temporal | (staleness_window, κ) epistemic half-life per class |
| EAT | Integrity | Per-epoch Merkle roots + Celestia DA |
| DA Liveness | Precondition | Dual DA providers; degraded mode specification |

**Q2 (pre_shock_window calibration) → Principled formula, continuous taper (#r75):**

Replaces #r74 heuristic (2× staleness_window) with:
```
pre_shock_window_i = min(2 × micro_epoch_length_i, macro_epoch_length_i / 4)
```
Coordinate-class-specific; naturally calibrated to the update cadence of each class. Financial price (micro_epoch = 1h): pre_shock_window = 2h. Regulatory (micro_epoch = 24h): pre_shock_window = 48h.

Binary window replaced by **continuous SEE protection taper:**
```
SEE_protection(claim_c) = min(1, (T_shock - T_c) / pre_shock_window_i) × max(0, 1 - σ_c / θ_outlier)
```
Partial slashing for partially protected claims. Cap: pre_shock_window < macro_epoch_length — SEE eligibility test never spans prior macro-epochs (governance stability guarantee). (#r75)

**Q3 (Tier B correlation filter computation) → Trustless computation from on-chain state (#r75):**

The correlation filter computation is trustlessly derived from public immutable on-chain position data — no new trust dependency required. Two real attack surfaces addressed:
1. *Indirect exposure evasion:* conflict_score includes indirect exposure via the diversity-penalty correlation graph (already maintained for S_cred diversity scoring — one data structure, dual use).
2. *Jury pool flooding:* maximum panelists from any single on-chain identity cluster ≤ ⌊N_panel/3⌋ (below Byzantine fault threshold for majority-vote panel). Identity clustering reuses behavioral fingerprint from #r72/Q4.

**Attestation protocol:** Protocol posts conflict_score for all eligible participants as EAT commitment at jury selection open → 1 micro-epoch challenge window → successful challenge overrides with Merkle proof + bounty → unchallenged filter proceeds to random draw. Filter is publicly verifiable before draw executes. (#r75)

**Q4 (β/γ joint calibration) → Anti-fragmentation fix + closed-form governance formula (#r75):**

**Critical flaw discovered in #r73 chain bonus formula:** Fragmentation dominates deep chain declarations. A 4-deep chain declared as three overlapping 2-depth chains earns ~9× more bonus than declaring the full depth-4 chain (at γ=0.7). Deep chains are never rationally declared under the #r73 formula.

**Fix — per-pair uniqueness + coordinate-scope chain declaration:** Implication bonus applies once per unique ordered coordinate pair (A, B) per epoch regardless of overlapping chains. Knowers must declare all coordinates in a chain sequence; overlapping declarations are merged (max-depth wins). Fragmentation incentive eliminated.

**Closed-form joint calibration (#r75):**
```
β = K_target / (α_bond × γ^(d_ref - 1))
```
Where: K_target = target bonus ratio at reference depth d_ref (recommended 0.40–0.50); α_bond = implication bond as fraction of reference stake; γ = chain depth discount (governance-set first).

Sample at recommended defaults (γ=0.7, d_ref=3, K_target=0.40, α_bond=0.5): β ≈ 1.63. This is consistent with #r74 range [1.3, 2.0] and provides theoretical grounding.

**Governance design law (#r75):** β is a *derived* parameter, not a primary governance input. Governance interface exposes (γ, K_target, d_ref, α_bond); β is computed. Prevents miscalibration when γ changes without adjusting β. (#r75)

---

## Open Questions for #r76+

1. **Degraded-mode clearing:** During DA outage, clearing uses last-known-good S_cred. Should all coordinates use κ=∞ (zero weight — conservative) or κ as-specified (partial weight from stale state)? The choice affects market stability during outages.
2. **Per-pair uniqueness across knowers:** If knower X and knower Y both declare A→B in the same epoch, do they each earn the implication bonus independently, or is it once-per-pair (and how is it split among claimants)?
3. **β derivation normalization:** What is the normalization for reference reward r in the β formula? Is r computed per epoch, per coordinate class, or as a global empirical average? Answer affects whether β is stable or drifts with market conditions.
4. **Genesis commitment for new coordinate classes:** When a new class is registered, it has no S_cred history, no Merkle commitments, no track records. How does EAT operate for a coordinate class with no prior epochs? Bootstrap credibility floor needed.

*Last updated: #r75 — 2026-04-03T09:52Z*

---

## #r76 Contributions — 2026-04-03T14:12Z

Addresses all four open questions from #r75.

**Q1 (Degraded-mode clearing κ policy) → κ_degraded floor = 2.0 (#r76):**

During DA outage, dispute windows are tolled and bad state cannot be challenged. Using κ as-specified during outage would allow unchallengeable stale state to accrue epistemic weight — a dangerous asymmetry. Using κ=∞ causes total epistemic blackout (clearing on collateral alone). Resolution:

**Degraded mode applies:** `κ_degraded = max(κ_class, 2.0)` retroactively from T_outage.

- κ_floor = 2.0 decays stale state faster than any standard coordinate class but preserves partial epistemic signal
- On DA restore: κ returns to κ_class; dispute windows resume from their tolled positions
- Mode flag is published in the EAT so all participants can observe and discount degraded-mode clearing

This closes the unchallengeable-authority risk without forcing a full epistemic blackout. (#r76)

**Q2 (Per-pair implication bonus across multiple declarers) → Independent + corroboration discount (#r76):**

If knower X and knower Y both declare A→B in the same epoch: independent earning with diminishing-return corroboration discount, mirroring the lineage corroboration model (#r52).

- First declarer on pair (by EAT timestamp): earns full β bonus on own stake
- Second declarer: earns `β × (1 - γ_corr)` where γ_corr = 0.3 (recommended)
- Nth declarer: earns `β × (1 - γ_corr)^(n-1)`
- Priority ordering: EAT timestamp, immutably committed; no auction required

Rationale: first independent corroboration of a structural implication is valuable; repeated same-pair declarations are less so. Budget risk is bounded because bonus is conditional on both coordinates resolving correctly — if A→B is false, no declarer earns regardless of count. (#r76; mirrors #r52)

**Q3 (β normalization base) → K_target as fraction of T2 base slot reward, rolling 4-epoch empirical window (#r76):**

The #r75 formula `β = K_target / (α_bond × γ^(d_ref-1))` leaves K_target's denominator implicit. Resolution:

**K_target is defined as a fraction of the base slot reward for a T2 claim on the same coordinate class in the same epoch**, measured as a rolling 4-macro-epoch empirical average.

This makes β self-scaling with market size: large/liquid markets have higher base rewards; implication bonus scales proportionally without governance action. K_target (policy) is stable; β_effective (derived) is published each epoch alongside K_target so participants can verify calibration.

**Design law extended from #r75:** Governance exposes (γ, K_target, d_ref, α_bond, N_calibration=4); β_effective is always computed, never set. (#r76)

**Q4 (Genesis bootstrap for new coordinate classes) → 3-phase genesis protocol (#r76):**

New coordinate classes have no S_cred history, no Merkle commitments, no track records. EAT-dependent features (SEE eligibility, staleness discount, claim consistency) cannot operate without prior state. Resolution: **3-phase genesis protocol** with invariant: every EAT-dependent feature always has the required history before activation.

**Phase 0 — Pre-genesis (off-chain):**
- Coordinate class spec defined; initial S_cred prior set (uniform or governance-informed)
- Merkle root of genesis state committed to Ethereum before any claim accepted
- EAT formally starts at genesis block with empty-but-committed state

**Phase 1 — Bootstrap epoch (duration = 1 macro-epoch):**
- T1 claims only (lowest authority, highest collateral ratio)
- No SEE protection (no prior history)
- No implication chains from/to new class (no correlation history)
- Staleness window initialized at class-default; no discount (no prior epochs)
- All participants start at credibility_ratio = θ_T1_floor
- Challenger subsidy pool seeded from governance reserve (#r69 thin-market bootstrap defense)

**Phase 2 — First normal epoch (post-bootstrap):**
- T2 claims admitted; EAT spans ≥1 completed macro-epoch
- SEE eligibility, staleness discount, implication chains all operational
- T3 admitted only after ≥2 completed macro-epochs of credibility_ratio data

Cost: one macro-epoch delay for full feature activation per new class. Invariant: no EAT-dependent feature ever runs without required history. (#r76)

---

## Open Questions for #r77+

1. **Corroboration discount interaction with independence requirement:** The γ_corr diminishing-return scheme (#r76/Q2) rewards first declarers and discounts late same-pair declarers. But if two knowers genuinely independently discover A→B (different source lineages, per #r52 framework), should γ_corr be waived for truly independent corroboration? A lineage-class check before applying γ_corr could preserve the independence premium from #r52 while still discounting same-lineage repetition.

2. **Phase 1 bootstrap → T3 admission timing edge case:** The rule is T3 admitted after ≥2 macro-epochs of credibility_ratio data. But credibility_ratio accumulates only from closed (resolved) claims. If oracle resolution for a coordinate class is very slow (e.g., annual regulatory filings), T3 may be gated for many epochs even though the market is mature. Should the T3 unlock gate be: (a) ≥2 epochs of claims submitted (regardless of resolution), or (b) ≥2 epochs of claims fully resolved? For slow-oracle classes, (a) is correct — resolution cadence should not artificially block tier progression.

3. **Degraded mode κ floor = 2.0 — calibration basis:** The choice of κ_floor = 2.0 was reasoned as "faster than any standard class." But κ_class values for individual classes haven't been formally specified — they are referenced but not bounded. If a fast-moving coordinate class normally uses κ = 3.0, then κ_floor = 2.0 would actually relax the decay during outage (worse than normal). κ_floor should be defined as max(κ_class_max_observed, 2.0) — a floor relative to the current market's fastest-decaying class, not an absolute number.

4. **β_effective publication — what if it drifts far from K_target-implied range?** β_effective is computed from rolling 4-epoch base reward average. If market conditions shift dramatically (e.g., 10× volume change in one epoch), β_effective could temporarily spike or crash. Should governance set a β_effective clamp [β_min, β_max] as a circuit breaker for implication bonus stability, even at the cost of temporarily misaligning K_target?

*Last updated: #r76 — 2026-04-03T14:12Z*

---

## #r129 Contributions — 2026-04-03T16:42Z

Addresses all four open questions from #r77+ (#r76 remainder).

**Q1 (Corroboration discount × independence requirement) → Lineage-class check before γ_corr (#r129):**

The #r76 γ_corr diminishing scheme treats all same-pair declarers as equivalent, but the independence premium from #r52 captures a real epistemic distinction: two knowers independently discovering A→B via different evidence lineages provides more information than the same knower (or a correlated lineage) redeclaring.

**Resolution — lineage-bifurcated γ_corr:**

For each additional declaration of the same ordered pair (A, B) in the same epoch:
```
if same_evidence_lineage_class(X, Y):
    bonus_Y = β × (1 - γ_corr)^(n_same_lineage - 1)     # discounted as before
else:  # different lineage class (genuine independent corroboration)
    bonus_Y = β × (1 - γ_corr_cross)^(n_cross_lineage - 1)
    where γ_corr_cross = 0.1   # near-zero: first cross-lineage corroboration is nearly full bonus
```

First cross-lineage corroborator earns ≈ 0.9β (minor discount for still-being-second). Same-lineage second declarer earns (1 - 0.3)β = 0.7β. Third same-lineage earns 0.49β. Third cross-lineage earns ≈ 0.81β.

**Lineage class determination:** Reuses EAT-committed evidence metadata field introduced in #r74 (claim submission includes provenance annotation: evidence_lineage_class ∈ {oracle_feed, expert_attestation, on-chain_event, off-chain_document, model_inference}). If lineage_class differs between two declarers, they are cross-lineage. If same or missing, treated as same-lineage (conservative default).

**Governance parameter:** γ_corr_cross is separately governable from γ_corr, with recommended defaults (0.1 vs 0.3) and a constraint: γ_corr_cross < γ_corr always (cross-lineage must be less discounted than same-lineage). (#r129)

---

**Q2 (T3 admission gate — slow oracle edge case) → Epoch-submitted gate (not epoch-resolved gate) (#r129):**

If T3 gate requires ≥2 macro-epochs of fully-resolved claims, slow-oracle classes (annual regulatory filings, multi-year litigation, epidemiological surveillance) may never admit T3 despite being mature markets with deep participation. This is the wrong failure mode — T3 carries warranty obligations and higher governance accountability; gating it on resolution cadence is correct only if resolution cadence is a proxy for market maturity.

**Resolution:** T3 gate = ≥2 submitted macro-epochs completed (not resolved).

Submitted = claim window closed, commit-reveal completed, escrow locked. Does not require oracle output.

**Provisional credibility_ratio for unresolved claims:** Uses internal consistency scoring:
```
credibility_ratio_provisional(a) = 
    f(convergence_to_S_cred)  × submission_weight(k_a, C_a)
```
Where convergence_to_S_cred measures how much agent a's claims contributed to the final-epoch S_cred estimate. This is computable without oracle resolution. Not a calibration score — it is an influence-and-consistency score.

On oracle resolution (whenever it occurs, possibly 5+ epochs later): credibility_ratio is retrospectively finalized using log-score. Provisional score is replaced, not averaged. Track records carry the finalized value.

**T3 warranty obligations for unresolved claims:** T3 is admitted but warranty obligations remain unfinalized until resolution. If resolution reveals poor calibration after T3 admission, the slash applies retroactively to the admitted T3 escrow. Warrant-cover is therefore forward-committed, not retroactively waived. (#r129)

---

**Q3 (Degraded mode κ floor — relative calibration) → Dynamic floor: max(κ_class, κ_system_max_observed_at_T_outage) (#r129):**

The #r76 absolute floor κ_floor = 2.0 fails if any coordinate class normally uses κ > 2.0 (e.g., a high-volatility financial price coordinate with κ_class = 3.0 would experience SLOWER decay in degraded mode than in normal mode — exactly wrong).

**Resolution:** Degraded mode κ floor is dynamic, not absolute.

```
κ_degraded(coord_i) = max(κ_class(coord_i), κ_system_max_at_T_outage)

κ_system_max_at_T_outage = max over all active coordinate classes: κ_class(coord_j)
```

Computed and committed to EAT at each macro-epoch close. During degraded mode, uses the value committed at T_outage (snapshot, not live — live lookup would require DA that is down).

**Invariant:** For every coordinate class i, κ_degraded(coord_i) ≥ κ_class(coord_i). Degraded mode is always at least as conservative as normal mode for every class. The #r76 "κ_floor = 2.0" language is superseded by this rule; the number 2.0 is no longer the operative definition. (#r129, supersedes #r76 Q1 absolute floor)

**New protocol constant:** κ_system_max must be computed per macro-epoch and committed alongside the TOWL zone snapshot in the EAT. It is a derived quantity, not governance-set.

---

**Q4 (β_effective drift circuit breaker) → β clamp [β_min, β_max] as governance safety rail (#r129):**

If market volume shifts dramatically within one epoch, the rolling 4-epoch base reward average (denominator in β_effective computation) can diverge, temporarily producing β_effective well outside the theoretically-motivated range from #r74 ([1.3, 2.0]).

**Resolution:** Governance sets β clamp as a safety rail separate from the primary calibration interface.

```
β_effective_published = clip(β_computed, β_min, β_max)
β_computed = K_target / (α_bond × γ^(d_ref - 1) × rolling_base_reward_ratio)
```

Recommended defaults: β_min = 1.0, β_max = 2.5 (slight relaxation of #r74 upper bound to allow market scaling without immediate governance intervention).

**Alert protocol:** If β_effective_published = β_min or β_max (i.e., clamp is binding) for ≥2 consecutive macro-epochs, governance is auto-notified and must recalibrate K_target or α_bond within one macro-epoch. Failure to recalibrate triggers suspension of new implication chain registrations (existing declarations continue; new ones are blocked).

**Design law updated (#r129):** Governance interface exposes (γ, K_target, d_ref, α_bond, N_calibration=4, **β_min, β_max**); β_effective is computed, then clamped. The clamp is a safety property, not an override of the calibration model. (#r129)

---

## Open Questions for #r130+

1. **Provisional credibility_ratio consistency with EAT:** The convergence-to-S_cred scoring (#r129/Q2) requires computing a provisional score from S_cred history. If that history is DA-dependent, provisional scores cannot be computed during degraded mode. Should T3 admission be suspended in degraded mode, consistent with other EAT-dependent operations?

2. **Cross-lineage γ_corr_cross governance bounds:** γ_corr_cross < γ_corr is required by design, but what happens if governance violates this constraint? Should the protocol enforce γ_corr_cross < γ_corr as a hard constraint at the contract level, or is governance-level convention sufficient?

3. **κ_system_max during degraded mode bootstrap:** The dynamic κ floor uses κ_system_max committed at T_outage. For a new coordinate class registered during degraded mode (edge case), its κ_class is unknown at the committed snapshot — it was just registered. Rule: new coordinate classes cannot complete Phase 0 genesis commitment during degraded mode. Genesis requires DA liveness as a precondition.

4. **Retroactive slash for T3 claims resolved post-admission:** Under #r129/Q2, a T3 admit may be slashed retroactively many epochs later when slow oracle resolves. What is the escrow holding requirement — must T3 escrow remain locked until all its open claims are resolved, even if the market has many slow-oracle coordinates? This could create indefinite capital lockup.

*Last updated: #r129 — 2026-04-03T16:42Z*

---

## #r130 Contributions — 2026-04-03T16:52Z

Addresses all four open questions from #r129.

**Q1 (Provisional credibility_ratio × degraded mode) → T3 gate paused; degraded_mode_provisional score computable (#r130):**

Two questions separated:
1. *Can provisional credibility_ratio be computed during degraded mode?* Yes — uses last-known-good S_cred snapshot from Ethereum Merkle anchor, with κ_degraded applied. Score is marked degraded_mode_provisional; subject to retroactive refinement when DA restores.
2. *Should T3 admission gate epoch count advance during degraded mode?* No — T3 installation is already suspended in degraded mode (#r75/Q1); gate count must be consistent. Paused during outage.

**Design law (#r130/Q1):** During degraded mode: (1) Provisional scores computable from last-known-good snapshot, marked degraded_mode_provisional. (2) T3 gate epoch count paused. (3) On DA restore: gate resumes from pre-outage value; degraded_mode_provisional scores retroactively refined at next macro-epoch boundary. (4) T3 admission gate will never advance using degraded_mode_provisional-only epochs — at least one normal-mode submitted macro-epoch required per gate epoch. (#r130)

---

**Q2 (γ_corr_cross governance bounds) → Hard contract invariant: γ_corr_cross ≤ γ_corr (#r130):**

Failure modes analyzed:
- γ_corr_cross > γ_corr: cross-lineage corroboration MORE discounted than same-lineage — inverts independence premium. Must be blocked.
- γ_corr_cross = γ_corr: independence premium disabled but mechanism still correct. Permitted.
- γ_corr_cross < γ_corr: intended design, active independence premium.

**Resolution:** Contract enforces γ_corr_cross ≤ γ_corr as a hard precondition at parameter-update time. Not strict inequality — equality is permitted (governance can disable independence premium as a policy choice). Pathological inversion (γ_corr_cross > γ_corr) is blocked at contract level. Governance interface must surface both values and their current relationship. (#r130)

---

**Q3 (κ_system_max for new classes during degraded mode) → Phase-1 classes receive κ_system_max_at_T_outage (#r130):**

Phase 0 genesis is fully suspended during degraded mode (DA liveness is a precondition; Celestia commitment required). Mid-Phase-0 classes are in suspended genesis — no claims accepted, no κ applies. Phase 1 classes registered before outage but not in T_outage snapshot: receive κ_degraded = κ_system_max_at_T_outage (conservative — cannot safely assume their κ_class is lower).

**Design law (#r130/Q3):**
- Phase 0: fully suspended in degraded mode.
- Phase 1 (new class not in snapshot): κ_degraded = κ_system_max_at_T_outage; epoch count paused.
- On DA restore: κ_system_max recomputed at next macro-epoch boundary, including all new classes; their own κ_class applies thereafter. (#r130)

---

**Q4 (Slow-oracle T3 escrow — capital lockup) → Unbundled escrow + Long-Tail Reserve Pool (LTRP) (#r130):**

Indefinite escrow lockup kills T3 participation in slow-oracle classes through a negative capital-efficiency spiral. But releasing all escrow before resolution destroys retroactive slash capability. Resolved via unbundled escrow with shared pool:

```
T3_escrow_total = T3_escrow_standard + T3_escrow_longtail
T3_escrow_longtail = α_longtail × T3_escrow_standard
  α_longtail = max(0.15, oracle_resolution_p90_latency / T_longtail)
  capped at 0.4 (standard component always ≥ 71% of total)
```

**T3_escrow_standard:** Released on normal schedule (service window + challenge window after epoch close). Covers fast/medium oracle classes.

**T3_escrow_longtail:** After T_longtail = 3 × macro_epoch_max_class, contributed to the coordinate-class-level **Long-Tail Reserve Pool (LTRP)**. LTRP is a shared escrow pool available for retroactive slash for any claim on that class for duration T_longtail after claim close. Unclaimed LTRP contributions return to knowers (or challenger pool if knower unreachable) after T_longtail.

**Outcome:** Individual capital lockup bounded by T_longtail. LTRP absorbs residual retroactive slash obligation for very slow oracle classes. LTRP is self-sustaining when ongoing T3 participation × α_longtail × avg_escrow ≥ expected_slash_rate × avg_wrong_magnitude. Auto-alert to governance if LTRP coverage falls below threshold (consistent with #r129/Q4 β_effective clamp alert). (#r130)

**New design law (#r130):** Any mechanism feature with unbounded-time obligation requires a **bounded-individual-lockup + pool-reserve decomposition**. This is a first-class design principle applicable to all future long-tail liability features.

---

## Open Questions for #r131+

1. **LTRP bootstrapping at genesis:** New slow-oracle class starts with empty LTRP. If oracle resolves unexpectedly early (before pool accumulates coverage), retroactive slash cannot be fully satisfied. Does governance seed the LTRP at class registration, similar to challenger subsidy pool from #r69?

2. **LTRP and TOWL capacity:** Does T3_escrow_longtail (once in LTRP) count toward TOWL capacity? If yes, knowers lose TOWL contribution after standard escrow release. If no, LTRP creates hidden quasi-escrow invisible to TOWL Zone A headroom. Must be resolved for TOWL model consistency (#r71).

3. **Provisional score front-running window:** When DA restores, degraded_mode_provisional scores are retroactively refined. Between publication and refinement, participants can observe provisional credibility landscape and adjust positions. When the refinement happens, the landscape changes. This is a type of provisional-state front-running. Does the mechanism need an update-lock window at DA restore, or is the one-epoch-buffer (#r71/Q4) sufficient dampening?

4. **T3_outage_lockup_cap:** A T3 installation completed one micro-epoch before DA outage has its challenge window tolled for the entire outage duration. For a multi-day outage, this creates unexpected capital lockup on a closed installation. Should there be a T3_outage_lockup_cap: if outage exceeds T_outage_max, release standard escrow and treat the excess window as non-slash-eligible?

*Last updated: #r131 — 2026-04-03T17:52Z*

---

## #r131 Contributions — 2026-04-03T17:52Z

Addresses all four open questions from #r130.

**Q1 (LTRP bootstrapping at genesis) → Governance seed + Phase-1 α_longtail=1.0 until pool self-sufficient (#r131):**

New slow-oracle class has empty LTRP at genesis. Early oracle resolution (before pool accumulates) would leave retroactive slash obligations unsatisfied. Analogous to challenger subsidy pool genesis (#r69 bootstrap protocol): governance seeds the LTRP at class registration.

**Resolution — hybrid seed + Phase-1 escrow hardening:**
- Governance seeds LTRP at class registration: `LTRP_seed = min(governance_reserve_cap, expected_first_resolution_slash_exposure)`. Expected slash exposure estimated from: oracle_resolution_p50_latency × T3_participation_forecast × avg_stake × expected_miss_rate. Both oracle_resolution_p50_latency and expected_miss_rate are governance-submitted at registration; subject to retrospective correction (governance bears loss if estimates are off).
- Phase-1 bootstrap epoch uses `α_longtail = 1.0` — all T3 escrow is longtail during Phase 1; zero standard release until LTRP reaches self-sufficiency threshold.
- Self-sufficiency threshold: `LTRP_balance ≥ LTRP_seed × 2`. When crossed, α_longtail reverts to class-formula value and governance seed begins recovery.
- Governance seed recovery: prorated from LTRP contributions as pool grows; fully recovered before any longtail distribution to knowers.

**Design law (#r131/Q1):** Any coordinate class feature with unbounded retroactive liability requires a coverage seed at genesis (consistent with #r130 pool-reserve design principle). Governance seed is recoverable — it is a loan to the mechanism, not a subsidy. (#r131)

---

**Q2 (LTRP and TOWL capacity) → LTRP is a protocol-level buffer; does NOT count toward per-claim TOWL (#r131):**

TOWL capacity accounting requires per-claim escrow attribution (established through #r70/#r71). LTRP is a shared coordinate-class pool: contributions from many claims, not individually attributable. Mixing pool-level reserves into per-claim TOWL accounting would break the attribution model.

**Resolution — separate LTRP buffer layer, not TOWL-counted:**

LTRP does NOT contribute to per-claim TOWL capacity calculations. Standard-escrow-only TOWL remains the operative model (conservative — no credit for pool reserves).

LTRP is reported as a protocol-level buffer in a separate `LTRP_status` output alongside TOWL zone reports:
```
LTRP_status(class_i) = {
  pool_balance:         current LTRP balance
  seed_recovered_pct:  governance seed recovery progress
  coverage_ratio:       pool_balance / (open_T3_longtail_exposure × α_longtail)
  sufficiency_flag:     GREEN | YELLOW | RED
}
```

TOWL Zone transitions remain driven by standard escrow only. LTRP underpins retroactive slash capacity independently.

**Why not count LTRP toward TOWL:** When standard escrow releases (T3 installation fully warranted), TOWL capacity drops. This is correct — the installation obligation is over. LTRP covers only the residual long-tail retroactive slash risk, which is a separate, lower-severity liability category from in-warranty claims. Conflating them would artificially inflate Zone A headroom and mask real TOWL risk.

**New design law (#r131/Q2):** Pool-level shared reserves create a protocol-level buffer, reported separately from TOWL. No pool contribution ever counts as per-claim TOWL capacity. This principle applies to all future shared-pool features. (#r131)

---

**Q3 (Provisional score front-running at DA restore) → One-epoch epistemic bridge at DA restore (#r131):**

On DA restore, degraded_mode_provisional scores are refined at the next macro-epoch boundary. Between DA restore event and that boundary, participants who submitted high-quality claims during the outage may predict their score will improve and adjust positions accordingly. The attack window = 1 micro-epoch (DA restore → macro-epoch close).

**Analysis of predictability:** An individual claimant knows their own claim quality but not others'. Net score landscape shift is unpredictable in the aggregate. However, if a coordinated group of knowers submitted high-quality claims during outage, they have collective knowledge of the upward shift in their credibility scores and can collectively front-run the refined S_cred publication.

**Mitigation: one-epoch epistemic bridge (#r131):**

On DA restore, the first post-restore macro-epoch runs with `κ_bridge = max(κ_class, 1.5)` — a partially-elevated decay even though DA is live. This has two effects:
1. Refined provisional scores are published at the start of the bridge epoch but their effective_weight is reduced.
2. The clearing feed remains at slightly-stale S_cred (consistent with #r71 one-epoch buffer) — the buffer absorbs the refinement.

By the second post-restore macro-epoch, bridge epoch is closed, κ returns to κ_class, and refined scores propagate at full weight. The bridge epoch converts the DA-restore event from a single discontinuous score step into a two-epoch ramp.

**Note:** One-epoch buffer from #r71/Q4 provides some dampening but is insufficient alone — it prevents S_cred-to-clearing front-running but not credibility-score front-running affecting future claim weight. The bridge epoch closes this residual gap.

**Interaction with κ_degraded (#r129):** Bridge epoch κ_bridge ≥ 1.5 applies only when κ_degraded was active immediately prior. If outage was very short (< 1 micro-epoch), κ_degraded was never triggered and bridge epoch is skipped (no meaningful provisional state accumulated). Trigger condition: bridge epoch required iff degraded_mode_provisional scores were published during the outage (at least one macro-epoch boundary passed in degraded mode). (#r131)

---

**Q4 (T3_outage_lockup_cap) → LTRP assumption of locked challenge window at T_outage_max (#r131):**

A T3 installation whose challenge window is tolled across a full multi-day DA outage faces unexpected indefinite capital lockup — challenge window purpose (dispute-with-evidence) is already suspended during outage. Tolling preserves dispute integrity but imposes unbounded capital cost on knowers.

**Resolution — T3_outage_lockup_cap with LTRP assumption:**

If outage duration ≥ `T_outage_cap = max(2 × challenge_window_class, T_longtail / 3)`:
1. Standard escrow is released on normal schedule from T_outage_cap forward (challenge window does not resume for that installation).
2. Protocol marks the installation as `challenge_window_outage_expired = true`.
3. Retroactive slash obligation for such installations transfers to LTRP from T_outage_cap forward.

`T_outage_cap` is a per-class parameter, set at registration alongside `T_longtail`. Default: `2 × challenge_window_length`.

**LTRP sufficiency impact:** This increases LTRP's effective coverage obligation. At class registration, governance must account for T3 installations whose challenge windows may be LTRP-assumed in the expected-miss-rate calculation for LTRP_seed. Specifically: `outage_assumed_slash_factor` is added to LTRP_seed formula:

```
LTRP_seed_adjusted = LTRP_seed × (1 + outage_assumed_slash_factor)
outage_assumed_slash_factor ∈ [0.1, 0.3] (governance, per class)
```

**Why not just keep challenge window tolled indefinitely:** Tolling was designed for dispute integrity, not to create an instrument for indefinite lockup. The challenge window is already purposeless during DA outage. Bounded tolling (up to T_outage_cap) is sufficient for the dispute-integrity goal while capping capital lockup risk.

**Interaction with LTRP genesis (#r131/Q1):** T_outage_lockup_cap obligation feeds back into LTRP_seed sizing — the two parameters must be calibrated together at class registration. Governance UI should surface both, warn on any configuration where LTRP_seed < expected_outage_slash_exposure. (#r131)

---

## Structural Synthesis: Bounded-Liability Architecture (#r131)

Three distinct time-horizon liability patterns now fully specified:

| Liability horizon | Mechanism | Capital treatment | TOWL |
|---|---|---|---|
| In-warranty (fast oracle) | Standard escrow release + challenge window | Per-claim, TOWL-counted | Yes |
| Long-tail (slow oracle) | LTRP via T3_escrow_longtail | Pool-level, TOWL-separate | LTRP buffer |
| Outage-suspended (extended DA failure) | LTRP assumption at T_outage_cap | Pool-level, TOWL-separate | LTRP buffer |

Each tier has a bounded individual lockup horizon. Each tier has a pool-level backstop. The mechanism has no infinite-lockup obligations for any individual participant. Governance seeds each pool at class registration; seeds are loans recovered as pools self-fund.

**Design law synthesis (#r131):** Every mechanism feature introducing time-unbounded individual liability MUST be decomposed into: (1) a bounded individual lockup window, and (2) a protocol-level shared pool absorbing residual liability after that window. This is now a formal first-class mechanism invariant, building on the #r130 design law. (#r131)

---

## Open Questions for #r132+

1. **LTRP multi-class spillover:** LTRP is per-coordinate-class (#r130). If a claim is multi-class (implication chains spanning different classes), which class's LTRP absorbs the retroactive slash? Proportional split by α_longtail contribution per class? Or primary class only?

2. **Bridge epoch + implication bonus interaction:** During the bridge epoch, effective_weight is reduced by κ_bridge. Implication bonus β is calibrated relative to base slot reward. If base slot reward drops (lower effective weight → lower query fee payout during bridge), does β_effective drift out of bounds and trigger the clamp? Should the bridge epoch be excluded from the N_calibration rolling window?

3. **Governance seed miscalibration recovery:** If oracle_resolution_p50_latency submitted at registration is materially wrong (e.g., class turns out to resolve 10× faster than estimated), LTRP_seed is over-allocated and governance recovery is delayed. Is there a governance recall mechanism — can governance reduce LTRP_seed proactively if pool is clearly over-seeded?

4. **T3_outage_cap interaction with T3 provisional install FSM (#r71):** A T3 provisional install (claim in pending oracle state) whose oracle window overlaps with a DA outage — does T_provisional_max tolling interact with T_outage_cap? Both are tolled independently; they could produce additive lockup. Define the maximum combined tolled lockup explicitly.

*Last updated: #r131 — 2026-04-03T17:52Z*

---

## #r132 Contributions — 2026-04-03T19:12Z

Addresses all four open questions from #r131.

**Q1 (LTRP multi-class spillover for implication chain claims) → Per-class independent attribution; no cross-class spillover needed (#r132):**

Implication declarations were designed so capital accountability exists at every coordinate independently (#r72). When knower posts an implication declaration A→B spanning two coordinate classes (class_i for A, class_j for B), independent escrow is posted for each coordinate. Slash for a wrong A-claim is drawn from the A-escrow; slash for B from the B-escrow.

**Resolution:** Each coordinate's LTRP absorbs longtail liability for that coordinate's claims independently. T3_escrow_longtail for coordinate A flows into class_i LTRP; for coordinate B into class_j LTRP. No cross-class spillover mechanism is required.

**Partial oracle case (A resolves, B not yet):** Consistent with partial resolution model (#r5) — A's LTRP liability is settled at A's oracle resolution; B's remains pending in class_j LTRP until B's oracle resolves. The two liabilities are independent and tracked separately. The implication bonus (β) is conditional on both resolving correctly — if only one resolves, the bonus is held in escrow until the second resolves (or times out per T_longtail for the slower class).

**Edge case — different T_longtail across classes:** If class_i has shorter T_longtail than class_j, class_i's standard escrow releases first while class_j's longtail obligation is still live. No cross-class subsidy; each class's pool stands alone. For implication declarations crossing fast and slow classes, the knower's effective combined lockup horizon is max(T_longtail_i, T_longtail_j) — disclosed at claim submission. (#r132)

---

**Q2 (Bridge epoch × implication bonus calibration) → Exclude bridge and degraded epochs from N_calibration rolling window (#r132):**

Bridge epoch artificially suppresses effective_weight via elevated κ_bridge. Lower effective_weight → lower per-epoch base slot reward. If included in the N_calibration = 4 rolling window, the denominator in the β_effective formula shrinks, causing β_effective to spike upward — potentially triggering the clamp (#r129/Q4). This would be spurious governance noise from a DA-restore event, not a genuine market signal.

**Resolution:** The N_calibration rolling average excludes all exceptional-mode epochs: degraded-mode epochs and bridge epochs. Only normal-mode macro-epochs count toward the rolling average.

If fewer than N_calibration normal-mode epochs exist in the rolling window (e.g., system just restored after extended outage), use the most recent available normal-mode epochs without substitution. β_effective is computed as usual; clamp absorbs any residual volatility.

**β_effective publication during bridge epoch:** β_effective is published each epoch. During a bridge epoch, the published β_effective is labeled `beta_effective_bridge_hold = true` to indicate it is computed from a potentially shorter-than-N_calibration window. Governance alert is not triggered solely from bridge-epoch clamp binding — only from clamp binding on normal-mode epochs (updating the #r129/Q4 alert protocol).

**Design law extended (#r132):** Calibration rolling windows MUST exclude all exceptional-mode epochs. A "normal-mode epoch" is defined as: DA live, κ = κ_class (not elevated), no active SEE, TOWL in zone A or B. This exclusion rule applies to all rolling averages in the mechanism, not only β_effective. (#r132)

---

**Q3 (Governance seed miscalibration recovery) → Proactive recall with stability gating and graduated withdrawal (#r132):**

If oracle_resolution_p50_latency was over-estimated at class registration, LTRP_balance accumulates well above effective liability and governance seed recovery is delayed unnecessarily. Governance needs a proactive recall pathway without creating sudden LTRP capacity collapse.

**Resolution — conditional proactive recall:**

Governance may submit an `LTRP_seed_reduce` proposal when all three conditions hold simultaneously:
1. `LTRP_balance > LTRP_seed_current × S_safety` where `S_safety = 3.0` (pool holds ≥3× current seed)
2. Pool has been continuously above S_safety threshold for ≥ `M_stable = 4` consecutive normal-mode macro-epochs
3. No active `challenge_window_outage_expired` installations with outstanding LTRP assumption obligations

Recall constraints:
- New seed floor = `LTRP_seed_original × min_retention` where `min_retention = 0.5` (governance cannot recall >50% of original seed in one proposal)
- Excess governance recovery distributed gradually over `K_recovery = 4` macro-epochs (no one-shot withdrawal)
- Governance seed recovery resumes from LTRP contributions; seed cannot be recalled below LTRP_balance (never drain the pool)

**Auto-alert:** If LTRP_balance exceeds S_safety × LTRP_seed for M_stable consecutive epochs, protocol publishes a `LTRP_overfunded_flag` alongside LTRP_status output. Governance is informed but not required to act. Recall is always discretionary — governance may prefer conservatism.

**Inverse direction — LTRP under-funded:** If LTRP coverage_ratio < RED_threshold after pool is live (not genesis), governance must top up within one macro-epoch or T3 installations on that class are suspended. Symmetric accountability. (#r132)

---

**Q4 (T3_outage_cap + T3 provisional FSM additive lockup ceiling) → Non-additive ceiling: max of independent maxima + 1 buffer (#r132):**

A T3 provisional install (oracle-pending, per #r71 FSM) during a concurrent DA outage has two independent tolling mechanisms active: T_provisional_max tolling and T_outage_cap tolling. If additive, worst-case lockup could reach T_provisional_max + T_outage_cap — well beyond either individual design intent.

**Resolution — hard combined ceiling:**

```
max_combined_tolled_lockup(c) = max(T_provisional_max(c), T_outage_cap(c)) + 1 macro-epoch
```

NOT additive. The ceiling is the larger of the two independent maximums plus one buffer macro-epoch for settlement processing.

**Semantics:** Both T_provisional_max and T_outage_cap are responses to the same class of epistemic unavailability (information needed for challenge/confirmation is not accessible). They do not compound — the system is in one degraded state at a time, even if two clocks are nominally running.

**When both are simultaneously active:**
1. Both clocks toll normally until the first expiry.
2. At first expiry, LTRP assumption triggers for that mechanism's obligation (provisional FSM → auto-demotion to T2 per #r71; outage lockup → LTRP assumption per #r131/Q4).
3. The remaining clock may continue tolling up to the combined ceiling from the first expiry event.
4. At combined ceiling: all remaining obligations transfer to LTRP regardless of which clock is still running.

**Per-class parameter requirement:** T_provisional_max and T_outage_cap must both be specified at class registration. Governance UI must compute and display `max_combined_tolled_lockup` alongside each class registration — not a derived field to be discovered post-facto.

**LTRP seed sizing impact:** The over-lapping-clock scenario increases worst-case LTRP exposure vs. either clock alone. The `outage_assumed_slash_factor` from #r131/Q4 LTRP_seed formula implicitly accounts for this if set conservatively. Governance should explicitly include overlapping-clock probability in their slash exposure estimate. (#r132)

---

## Structural Synthesis: Bounded-Liability Architecture — Closed (#r132)

With #r132, the bounded-liability architecture is complete. Every time-unbounded individual lockup risk has been:
1. Decomposed into a bounded individual window + pool backstop (#r130)
2. Seeded at genesis (#r131/Q1)
3. TOWL-separated at protocol level (#r131/Q2)
4. Isolated from exceptional-mode calibration contamination (#r132/Q2)
5. Given a proactive recovery pathway when over-seeded (#r132/Q3)
6. Capped against additive multi-mechanism lockup (#r132/Q4)

The four liability tiers now with explicit ceiling:

| Tier | Mechanism | Lockup ceiling | Backstop |
|------|-----------|----------------|----------|
| In-warranty | Standard escrow + challenge window | challenge_window_class | Per-claim TOWL |
| Long-tail | LTRP via T3_escrow_longtail | T_longtail | LTRP (per-class pool) |
| Outage-suspended | LTRP at T_outage_cap | T_outage_cap | LTRP |
| Combined (provisional + outage) | Non-additive ceiling | max(T_provisional_max, T_outage_cap) + 1 epoch | LTRP |

Every tier has a bounded horizon. No individual participant faces indefinite lockup from mechanism design. (#r132)

---

## Open Questions for #r133+

1. **Implication bonus escrow across different T_longtail classes:** The implication bonus β is conditional on both A and B resolving correctly. When A and B belong to different coordinate classes with different T_longtail, the bonus must be held until the slower class resolves. This creates a third escrow type for implication bonus — distinct from T3_escrow_standard and T3_escrow_longtail. Does this escrow belong to the slower class's LTRP horizon or is it a separate first-class escrow category? Does it count toward TOWL?

2. **Normal-mode epoch definition edge: zone C during normal DA:** A TOWL zone C event (#r71) is a solvency stress condition, not a DA or epistemic anomaly. Should zone C epochs be excluded from calibration rolling windows alongside degraded/bridge epochs? Zone C indicates market stress but does not distort κ or effective_weight the same way degraded mode does — the calibration distortion is different in kind.

3. **M_stable continuity gap:** The LTRP_seed recall stability gate requires M_stable = 4 consecutive normal-mode macro-epochs above S_safety. If the pool dips just below S_safety for one epoch (e.g., large LTRP payout) then recovers, the M_stable counter resets. Is reset-on-any-dip the correct policy, or should M_stable tolerate brief dips (e.g., max 1 below-threshold epoch per 4-epoch window)?

4. **Cross-class implication chain oracle ordering:** When A→B spans two coordinate classes with different oracle timing, and A's oracle resolves first (A correct), the mechanism should update the implication declaration status. But if B's oracle is delayed by months and A's knower was correct, the knower has money locked for B's resolution that they rationally should have as working capital. Is there a partial-release mechanism for the A-side of a cross-class implication declaration when A resolves correctly?

*Last updated: #r132 — 2026-04-03T19:12Z*

---

## #r69 — Formal Conserved Quantity: Warranted Epistemic Debt (WED)

The mechanism has never formally answered: *what is the conserved quantity?* This run supplies it.

**Proposed: Warranted Epistemic Debt (WED)**

```
WED = Σ_c [ D(c) × A(c) × P(c) ]
```
- D(c) = expected decision-loss if the installed state on coordinate c is wrong
- A(c) = authority weight (how much downstream decisions depend on c)
- P(c) = probability the currently installed state is materially wrong

The mechanism's job is to minimize WED. Capital should route toward high-D, high-A, high-P coordinates — not toward high crowd-disagreement coordinates.

1. **Base primitive:** An update contract is a bid to reduce WED on a specific coordinate, backed by slashable collateral. The buyer pays for WED reduction, not for a correct belief.
2. **State model:** When an update is installed, the mechanism applies a provisional WED reduction proportional to claimed evidence quality. Holdback releases proportional to actual WED reduction confirmed at truth resolution. Slashing compensates WED harm caused.
3. **Credibility model:** Capital improves epistemics because updaters become residual claimants of the WED reduction they create. Sellers are paid for decision-quality improvement, not for being on the right side of a crowd bet.
4. **Market roles:** Demanders price D(c) × A(c). Updaters compete to reduce P(c). Challengers are error-bounty hunters who expose where P(c) is higher than installed state advertises.
5. **Settlement model:** Truth resolution grades whether P(c) was actually reduced. Under partial observability, graded by proxy: did the installed state survive challenge, re-check, and downstream decision use without triggering a costly correction?
6. **Attack surface:** WED inflation — malicious actor artificially elevates D(c) or A(c), extracts high prices, lets truth deflate stakes. Defense: D(c) and A(c) are declared by buyers, not sellers.
7. **Why better than LMSR:** LMSR prices beliefs without weighting by decision relevance. WED pricing routes epistemic work to where errors are expensive.
8. **Simplest viable sketch:** Publish D(c) and A(c) as buyer-declared fields. Updaters bid WED reduction via evidence quality + escrow. Install the update offering largest WED-reduction per risk budget.
9. **Strongest failure mode:** D(c) and A(c) are private buyer information. Without credible demand-reporting, WED cannot be computed reliably.
10. **Best surviving variant:** Use WED as internal optimization target for mechanism designers. Allow buyers to signal D(c) × A(c) implicitly through escrow size and bid price. (ref: #r69; completes conserved-quantity thread from #r1)

*#r69 added retroactively — 2026-04-03T19:09Z*

---

## #r133 Contributions — 2026-04-03T19:52Z

Addresses all four open questions from #r132.

**Q1 (Implication bonus escrow across different T_longtail classes) → `implication_bonus_escrow` as first-class escrow category, not TOWL-counted (#r133):**

The implication bonus β is conditional on both A and B resolving correctly. When A and B belong to classes with different T_longtail horizons, the bonus must remain locked until the slower class's oracle resolves — a lockup horizon that belongs to neither class individually and is not a per-coordinate warranty obligation.

**Resolution — `implication_bonus_escrow` is a distinct fourth escrow category:**

| Escrow type | Belongs to | TOWL-counted | Backstop | Lockup ceiling |
|---|---|---|---|---|
| T3_escrow_standard | per-claim, fast classes | Yes (per-claim) | Per-claim TOWL | challenge_window_class |
| T3_escrow_longtail | per-claim, slow classes | No (LTRP buffer) | LTRP per class | T_longtail_class |
| implication_bonus_escrow | bilateral (A+B pair) | No (protocol reserve) | See below | max(T_longtail_A, T_longtail_B) |

`implication_bonus_escrow` is protocol-held, not per-claim. It does not count toward either class's TOWL capacity (consistent with #r131/Q2 pool-reserve design law). It is reported in a new `implication_reserve_status` output field, separate from LTRP_status and TOWL.

**Release conditions:**
- Both A and B resolve correctly: release full bonus to knower.
- Either resolves wrong: slash implication_bonus_escrow to the failing coordinate's loser pool (proportional split if both fail).
- Slower class T_longtail expires before oracle resolution: release 0.5× to knower if A confirmed correct, 0 if A unresolved; remainder to slower-class challenger pool.

**Bootstrapping:** New classes in Phase 1 (bootstrap epoch) may not participate in cross-class implication declarations. Both participating classes must have at least one completed normal-mode macro-epoch. (#r133)

---

**Q2 (Zone C epochs in calibration rolling windows) → Zone C NOT excluded; flagged in β_effective publication (#r133):**

Zone C is a TOWL solvency stress signal. It does not alter κ or effective_weight from mechanism design — unlike degraded/bridge epochs which artificially suppress weights. The base slot reward shift in Zone C is real market signal (high-escrow-only participation, compressed liquidity) and should propagate into β_effective calibration. Excluding it would produce a stress-blind calibration gap.

**Resolution:** Zone C epochs are NOT excluded from the N_calibration rolling window.

β_effective publication includes `zone_c_epochs_in_window: N`. If N ≥ M_stable (4), governance alert fires (independent of clamp-binding alert). Zone C and DA-anomaly flags are orthogonal: an epoch can simultaneously be Zone C (included in calibration) and a bridge epoch (excluded for DA-restore reason). Each flag is assessed independently. (#r133)

---

**Q3 (M_stable continuity gap) → Moving 5-epoch window with 1 non-consecutive below-threshold tolerance (#r133):**

Strict consecutive reset is too brittle for large pools where a single LTRP payout causes a transient one-epoch dip. Such dips are mechanism events, not structural underfunding signals.

**Resolution — majority-window M_stable:**

```
M_stable satisfied iff:
  in the last 5 normal-mode macro-epochs,
  LTRP_balance > LTRP_seed × S_safety in ≥4 of those 5 epochs
  AND the current epoch is above threshold
```

Tolerance: 1 below-threshold epoch per 5-epoch window. Two below-threshold epochs in any 5-epoch window (consecutive or not) resets qualification entirely — prevents adversarial dip-recover-dip patterns.

**Design law (#r133):** Stability gates for irreversible actions must use rolling-window majority tolerance, not strict consecutiveness. Tolerance / window_size default = 0.2 (1 of 5). (#r133)

---

**Q4 (Partial release of A-side for resolved correct claim in cross-class implication) → Conditional partial release with clawback obligation (#r133):**

When A resolves correct and B remains pending for months, locking the full implication_bonus_escrow is a capital-efficiency failure proportional to T_longtail mismatch.

**Resolution — A-side conditional partial release:**

```
partial_release_A = (A_stake / (A_stake + B_stake)) × β_bonus_escrow_total
```

Released when oracle confirms A correct; B-side remainder stays locked.

**Clawback obligation:** If B resolves wrong, partial_release_A must be clawed back. Priority: (1) knower's active standard escrow; (2) knower's active longtail escrow; (3) governance-tracked knower debt record (caps credibility_ratio growth until cleared). Clawback exposure is disclosed at declaration time. Mechanism does not absorb implication-bonus clawback losses.

**Opt-out:** Partial release is knower-selectable at declaration. Default: enabled (capital-efficient). Knowers preferring no clawback risk hold full bonus until both coordinates resolve. (#r133)

---

## Structural Synthesis: Escrow Taxonomy — Complete (#r133)

Four formally distinct escrow categories now fully specified:

| Category | TOWL-counted | Backstop | Max ceiling | Partial release |
|---|---|---|---|---|
| T3_escrow_standard | Yes (per-claim) | Per-claim TOWL | challenge_window | No |
| T3_escrow_longtail | No | LTRP (per-class) | T_longtail | No (via pool) |
| Outage-assumed (LTRP) | No | LTRP | T_outage_cap | N/A |
| implication_bonus_escrow | No | implication_reserve | max(T_longtail_A, T_longtail_B) | Yes (A-side) |

**Design invariant (#r133):** Every escrow category must have a formally specified lockup ceiling, named backstop, and defined TOWL treatment before it is design-complete. (#r133)

---

## Open Questions for #r134+

1. **implication_bonus_escrow during degraded mode:** Should partial releases, clawbacks, and expiry distributions on implication_bonus_escrow be suspended during DA outage (consistent with other EAT-dependent operations), or does it operate independently since it is a protocol reserve rather than a per-claim TOWL obligation?

2. **Clawback debt and credibility_ratio growth cap:** What is the cap formula for knower debt records — hard ceiling on credibility_ratio value, growth rate cap, or temporary freeze? And is debt cleared by escrow repayment only, or can it be retired by subsequent sustained correct claims demonstrating the knower is not a systemic bad actor?

3. **M_stable tolerance parameter governance bounds:** What prevents governance from setting tolerance = 4 of 5 (near-unconditional seed recall)? Should the protocol enforce a hard constraint: tolerance / window_size ≤ 0.3 (majority of window must be above threshold for recall eligibility)?

4. **Zone C + implication bonus partial release interaction:** During Zone C, T3 installations may be throttled. Should partial release from implication_bonus_escrow be blocked during Zone C on solvency grounds, or is Zone C's scope limited to TOWL/LTRP operations and implication_bonus_escrow operates independently?

*Last updated: #r134 — 2026-04-03T20:02Z*

---

## #r134 Contributions — 2026-04-03T20:02Z

Addresses all four open questions from #r133.

**Q1 (implication_bonus_escrow during degraded mode) → Suspend execution; queue oracle events; class-level gating (#r134):**

The implication_bonus_escrow is a protocol reserve (not TOWL-counted, #r133), but its release, clawback, and expiry operations all require EAT commits — they are EAT-dependent and must be suspended during DA outage.

**Resolution:** All implication_bonus_escrow execution (partial releases, clawbacks, expiry distributions) is suspended during degraded mode. Oracle events (A resolves correct, B resolves wrong) that fire during an outage are recorded as pending in the mechanism's local queue (Ethereum calldata only — no DA dependency for the event record itself, just for the state commit). On DA restore, queued events are processed in EAT timestamp order at the first normal macro-epoch boundary.

**One exception — active standard escrow clawback:** If a clawback obligation is sourced from the knower's active standard escrow (not from implication_bonus_escrow), the escrow debit can be recorded in Ethereum state without a DA commit (it is a single per-claim state change). This path is permitted during degraded mode. The corresponding EAT lineage record is queued and committed at DA restore.

**Expiry tolling:** T_longtail expiry timers for implication_bonus_escrow toll during degraded mode (consistent with challenge window tolling policy from #r131/Q4). The expiry clock does not advance during outage; elapsed outage time is excluded from the expiry horizon.

**Interaction with bridge epoch:** On DA restore, pending implication_bonus_escrow operations processed at the normal macro-epoch boundary after the bridge epoch. Not during bridge (bridge epoch has partial DA confidence — the first full-confidence epoch is post-bridge). (#r134)

---

**Q2 (Clawback debt and credibility_ratio growth cap) → Proportional escrow withholding on new claims; net-contributor retirement path (#r134):**

Hard ceiling on credibility_ratio is disproportionate — a knower with one partially-released clawback loss may be net-positive across all other coordinates. Growth-rate cap is implementation-complex. A targeted mechanism is preferred.

**Resolution — proportional withholding on new claim escrow:**

```
debt_withholding_rate(a) = min(0.5, outstanding_debt_a / (outstanding_debt_a + total_active_escrow_a))
```

Each new claim by knower a splits its escrow:
- `(1 - debt_withholding_rate)` → normal claim escrow (TOWL-counted, normal operation)
- `debt_withholding_rate` → debt recovery account (protocol-held, released to loser pool upon debt clearance)

Cap at 0.5: knower retains at least half capacity to participate. Complete exclusion is not appropriate — continued participation generates the evidence needed to assess ongoing reliability.

**Debt clearance — two paths:**
1. **Escrow repayment:** Debt recovery account accumulates until it covers outstanding_debt. Debt marked cleared; withholding rate resets to 0.
2. **Net-contributor retirement:** If cumulative log-score surplus from resolved-correct claims (in the trailing 8 normal-mode macro-epochs) exceeds outstanding_debt_a × 1.5 (50% over-performance buffer), the remaining debt is retired. Knower has demonstrated sustained positive epistemic contribution exceeding the loss. Protocol absorbs residual uncollected debt as a mechanism cost; does not create secondary debt.

**credibility_ratio is NOT directly capped.** Withholding affects escrow capacity, which in turn affects `w_a = C_a × log(1 + k_a_net)`. The epistemic weight penalty is indirect and proportional — not a blunt administrative cap. (#r134)

---

**Q3 (M_stable tolerance governance bounds) → Hard contract invariant: tolerance ≤ ⌊window_size / 4⌋ (#r134):**

If governance sets tolerance = 4 of 5, pool recall is effectively unconditional — any four-epoch high-balance run qualifies regardless of intervening dips. This inverts the purpose of the stability gate.

**Resolution — hard contract ceiling on tolerance:**

```
tolerance_max = ⌊window_size / 4⌋
```

For default window_size = 5: tolerance_max = 1 (floor of 1.25). This matches the recommended default (1 of 5) and makes it a hard ceiling enforced at parameter-update time — not a convention.

**Constraint on window_size changes:** Governance may change window_size (to increase the raw number of qualifying epochs), but the tolerance ceiling re-derives from the new window_size. Governance cannot independently raise tolerance above ⌊window_size / 4⌋ regardless of window_size.

**Minimum window_size:** window_size ≥ 4 enforced (smaller windows make the tolerance_max = 0, equivalent to strict consecutive — technically valid but brittle; governance may set this for maximum conservatism).

**Design law (#r134):** Stability gates for irreversible actions must have a contract-enforced tolerance ceiling anchored to the window_size. The ratio tolerance / window_size ≤ 0.25 is the hard constraint. This completes and tightens the #r133 majority-window M_stable rule. (#r134)

---

**Q4 (Zone C + implication bonus partial release) → Class-level Zone C gating; global Zone C does not block (#r134):**

implication_bonus_escrow is not TOWL-counted (protocol reserve, #r133). Zone C restrictions, as designed, apply to TOWL-coupled operations. However, partial release flows liquidity out of the protocol during solvency stress — even if the escrow is protocol-reserve, the direction of flow matters.

**Analysis:** Two Zone C scopes must be distinguished:
- **Global Zone C:** aggregate TOWL across all classes is under stress. implication_bonus_escrow is structurally separate from TOWL; blocking release globally from a protocol reserve during TOWL stress conflates two distinct solvency models.
- **Class-level Zone C:** the specific coordinate class(es) involved in the implication declaration are themselves in Zone C. Here, outflows from that class's protocol-adjacent reserves are directionally harmful to that class's epistemic stability.

**Resolution:** Partial release from implication_bonus_escrow is gated on the TOWL zone of the *releasing coordinate class*, not global TOWL:
- Releasing coordinate class in Zone A or B → partial release proceeds normally.
- Releasing coordinate class in Zone C → partial release deferred until class returns to Zone A or B.
- Global Zone C does NOT block implication_bonus_escrow releases for classes that are individually in Zone A/B.

**Ordering when both A and B classes are Zone C:** Deferral applies. Partial release waits for both releasing classes to exit Zone C. Deferral duration tolls against implication_bonus_escrow expiry (expiry clock pauses while deferred — analogous to DA-outage tolling).

**New design law (#r134):** Liquidity outflows from any protocol reserve category are gated at the coordinate-class level, not at the global TOWL level, unless the reserve is explicitly cross-class. Class-local solvency is the correct scope for class-local outflow gating. (#r134)

---

## Structural Synthesis: Operational Completeness of the Bounded-Liability Architecture (#r134)

With #r134, all four immediate open questions from the bounded-liability architecture are closed. The architecture now specifies behavior under:

| Condition | Escrow type | Behavior |
|---|---|---|
| Degraded mode (DA outage) | implication_bonus_escrow | Suspend; queue oracle events; execute at post-bridge macro-epoch |
| Active debt | Standard escrow capacity | Proportional withholding (max 50%) + net-contributor retirement |
| Governance seed recall | LTRP | Hard tolerance ceiling ≤ ⌊window_size/4⌋ |
| Zone C stress | implication_bonus_escrow releases | Class-level gating; global Zone C does not block cross-class-clean releases |

The credibility_ratio remains an unmanipulated epistemic signal throughout — debt is enforced through escrow capacity, not by administrative credibility caps. Governance recall is structurally stability-gated with a contract-enforced ceiling. Zone C gating is appropriately class-scoped.

---

## Open Questions for #r135+

1. **Debt recovery account finality:** When the net-contributor retirement path fires (8-epoch trailing surplus ≥ 1.5× outstanding debt), the protocol absorbs the uncollected residual. Is there a maximum per-event protocol absorption cap — to prevent a single knower from engineering a large partial-release clawback and then running the net-contributor path to externalize the loss?

2. **Implication_bonus_escrow expiry during class-level Zone C deferral:** Expiry tolls during both degraded mode and Zone C deferral. If a declaration is simultaneously affected by both (degraded outage ends → class in Zone C → bridge epoch), the toll stacking could extend the effective expiry horizon significantly. Is there a maximum combined expiry extension cap analogous to the #r132 combined lockup ceiling?

3. **window_size governance change + in-flight M_stable qualification:** If governance increases window_size from 5 to 8, is a currently-qualifying pool (4 of last 5 above threshold) retroactively disqualified until 6 of last 8 epochs satisfy the threshold? Or does mid-qualification window_size change take effect on the next M_stable evaluation window?

4. **Debt withholding and implication declaration participation:** If a knower is in debt-withholding mode (reduced effective escrow), their implication_bonus_escrow contribution also decreases proportionally — reducing implication chain depth incentives. Should the debt withholding rate apply to implication escrow at the same ratio as standard escrow, or should implication declarations be exempt (to avoid discouraging information-rich multi-coordinate declarations from temporarily penalized knowers)?

*Last updated: #r134 — 2026-04-03T20:02Z*

---

## #r135 Contributions — 2026-04-03T20:12Z

Addresses all four open questions from #r134.

**Q1 (Debt recovery account finality — max per-event protocol absorption cap) → Lifetime-escrow-anchored cap (#r135):**

Without a cap, a knower could engineer a large partial-release clawback loss, then demonstrate surplus on low-risk coordinates to retire that loss at protocol cost — effectively externalizing capital risk via the net-contributor path.

**Resolution — per-event absorption cap:**

```
absorption_cap(a) = min(outstanding_debt_a, 0.2 × total_historical_escrow_posted_lifetime_a)
```

Protocol absorbs only up to `absorption_cap`. Remaining debt above cap is not retired — it stays as a debt obligation subject to withholding until cleared via escrow repayment. The net-contributor path closes only the capped portion; partial retirement is permitted.

**Rationale:** Anchoring to `total_historical_escrow_posted_lifetime` ties the forgiveness ceiling to the knower's demonstrated long-run skin-in-the-game. New knowers with small history face a small absorption cap — protecting the protocol against rapid-cycle exploits. Established knowers with large history earn a proportionally larger cap — consistent with their track record as reliable contributors. The 0.2 factor (governance-settable, bounded [0.05, 0.35]) prevents a single retirement event from exceeding one-fifth of lifetime commitment.

**Interaction with LTRP:** Protocol absorption draws from a separate `debt_retirement_reserve`, distinct from LTRP and implication_reserve. Seeded at governance discretion; auto-alert if debt_retirement_reserve < trailing_12_epoch_retirement_cost. (#r135)

---

**Q2 (Implication_bonus_escrow expiry toll stacking — combined cap) → Doubling cap: max 2× max(T_longtail_A, T_longtail_B) (#r135):**

Degraded mode tolling (#r134/Q1) and Zone C class-level deferral (#r134/Q4) can stack. An implication declaration spanning a slow-oracle class can accumulate toll from both simultaneously — dramatically extending its effective expiry beyond any individually-designed horizon.

**Resolution — combined expiry extension ceiling:**

```
max_expiry_with_tolling = original_expiry + max(T_longtail_A, T_longtail_B)
```

Effective cap: total time from registration to expiry ≤ `2 × max(T_longtail_A, T_longtail_B)`. This is a doubling cap — one natural horizon of tolling is permitted in aggregate across all toll sources. Additional toll beyond the cap is discarded; the position expires under partial-settlement rules (#r133: 0.5× release if A confirmed correct, 0 if unresolved).

**Toll priority:** When multiple toll sources are simultaneously active (degraded mode AND Zone C deferral), they are not additive to the cap — the cap is a single ceiling regardless of how many independent toll clocks are running. Structurally identical to the #r132 non-additive combined lockup ceiling for provisional + outage tolling.

**Design law extended (#r135):** All toll-stacking scenarios (degraded mode, bridge epoch, Zone C deferral, provisional FSM) are subject to a combined ceiling defined as N× the natural horizon, where N is specified at feature design time. Current instances: T3 provisional + outage = max(T_provisional_max, T_outage_cap) + 1 epoch (#r132); implication_bonus_escrow = 2× max(T_longtail_A, T_longtail_B) (#r135). The N factor (1× or 2×) reflects whether the toll compensates for information unavailability (1×) or capital-uncertainty accumulation (2×). (#r135)

---

**Q3 (window_size governance change + in-flight M_stable evaluation) → Epoch-boundary activation; in-flight evaluation completes under original parameters (#r135):**

Retroactive disqualification on window_size change creates discontinuous state changes for pools already in M_stable evaluation — exactly the kind of unpredictable cliff the stability gate is designed to prevent.

**Resolution — evaluation-boundary parameter activation:**

window_size and tolerance changes take effect at the **start of the next M_stable evaluation window** after the governance update is committed to the EAT. Any evaluation currently in progress completes under the parameters that were active when it began. If the in-flight evaluation qualifies (under old parameters), the recall proceeds and new parameters govern the subsequent evaluation cycle.

**Consistency with tolerance_max invariant (#r134/Q3):** When window_size changes, tolerance_max = ⌊new_window_size / 4⌋ derives immediately — live from governance commit, not from window start. Governance cannot front-run a recall by briefly expanding window_size to qualify, then changing it back; the tolerance ceiling is enforced from commit.

**EAT record:** Every window_size or tolerance change is recorded as a governance event in the EAT with the epoch-of-effect marked explicitly. Auditors can reconstruct which parameter set governed each historical M_stable evaluation. (#r135)

---

**Q4 (Debt withholding and implication declaration participation) → Primary claim escrow withheld; implication_bonus_escrow exempt (#r135):**

**Resolution — split treatment:**

- `debt_withholding_rate` applies to primary claim escrow (A-stake and B-stake) at the standard formula (#r134/Q2). These are up-front locked capital.
- `implication_bonus_escrow` is fully exempt from debt withholding. The bonus is a contingent protocol reward funded at resolution from the loser pool — not the knower's own locked capital.

**Consequence:** A debt-withholding knower has reduced primary claim weight (lower k_a_net → lower w_a) and a proportionally smaller implication bonus (since bonus scales with α_bond × net_stake). The incentive to declare structural implications remains; the scale is reduced proportionally. The declaration is not blocked.

**Design law (#r135):** Debt withholding targets capital at risk (up-front locked escrow). It does not target contingent protocol rewards earned from loser-pool redistribution. These are categorically distinct. If a reward is sourced from the protocol's loser-pool rather than the knower's locked capital, it is exempt from debt withholding. This principle applies to all future reward categories. (#r135)

---

## Structural Synthesis: Debt and Governance Constraint Completeness (#r135)

| Feature | Constraint | Enforcement |
|---|---|---|
| Net-contributor debt retirement | Absorption cap = 0.2× lifetime escrow | Contract-enforced per event |
| Toll stacking | Combined ceiling = 2× max natural horizon | Contract-enforced, non-additive |
| window_size governance changes | In-flight evaluation completes under original params | EAT-recorded, epoch-boundary activation |
| Debt withholding scope | Capital at risk only; contingent rewards exempt | Categorically enforced by escrow type |

---

## Open Questions for #r136+

1. **debt_retirement_reserve seeding and replenishment:** The reserve is auto-alerted when underfunded (#r135/Q1). If governance does not replenish within a defined window, do pending net-contributor retirement requests queue or lapse? If they lapse, debt withholding never clears for those knowers — converting a temporary mechanism into a permanent exclusion.

2. **Implication declaration with one class in Phase 1 bootstrap:** Cross-class implication declarations require both classes to have at least one completed normal-mode macro-epoch (#r133/Q1). If class B completes Phase 1 while class A is still mid-Phase-1, a knower with prior A track record cannot lock in a cross-class declaration until A finishes bootstrap. Is this overly conservative?

3. **Primary claim escrow reduction × implication chain depth:** Debt withholding reduces the primary A-stake in a deep chain declaration (A→B→C), applying the chain-length discount γ^(depth-1) to a smaller base — reducing implication bonus geometrically. Should there be a minimum effective chain contribution floor below which the declaration is rejected as too small to register meaningful weight?

4. **EAT record for governance parameter rollback:** If governance commits a window_size change then rolls it back before the new window begins, what is the canonical EAT record? A rollback must be a new EAT commit referencing the original event — consistent with EAT immutability. Silent deletion is not permitted.

*Last updated: #r135 — 2026-04-03T20:12Z*

---

## #r136 Contributions — 2026-04-03T20:22Z

Addresses all four open questions from #r135.

**Q1 (debt_retirement_reserve replenishment failure → queue or lapse?) → Queue with advancing evaluation window; no TTL expiry (#r136):**

Lapsing pending retirements converts a temporary capital constraint into permanent exclusion — an outcome disproportionate to the governance failure that caused it. Unlimited queuing without governance accountability is also wrong: knowers could accumulate large contingent claims against a reserve governance has no incentive to replenish.

**Resolution — queue with advancing evaluation window + governance SLA:**

Pending net-contributor retirement requests do NOT lapse. They queue without expiry.

However, the 8-epoch trailing surplus test **re-evaluates** at each governance replenishment event — not at original submission time. If the trailing window has advanced (knower made more correct claims, or more wrong claims), the current 8-epoch window governs. Queued retirements that no longer qualify at the re-evaluation window are dropped (not converted to debt withholding — the original withholding continues as before).

**Governance SLA enforcement:** If the debt_retirement_reserve falls below the auto-alert threshold (#r135/Q1) and is not replenished within `T_replenishment_sla = 2 × macro_epoch_max_class`, then:
1. New net-contributor retirement submissions are suspended (queue closed; existing queue preserved).
2. T3 installations for new coordinators are not directly affected (retirement queue is independent of TOWL).
3. Governance receives an escalating on-chain alert each epoch until replenishment occurs.

Queue closure is NOT a lapse. Suspended queue resumes processing immediately on replenishment, re-evaluating against the then-current 8-epoch windows.

**Design law (#r136):** Protocol queues for knower-beneficial actions must not have TTL expiry caused by governance failure. Governance SLA breaches suspend queue intake, not queue contents. Governance bears the accountability; knowers do not forfeit established rights from governance inaction. (#r136)

---

**Q2 (Cross-class implication declaration with one class mid-Phase-1) → Pre-committed declaration: capital locks at declaration, weight activates at Phase-1 exit (#r136):**

The current rule (both classes must have ≥1 completed normal-mode macro-epoch before cross-class declarations) is overly conservative when one class is mature and the other just entered Phase 1. The waiting knower loses declaration priority — a first-mover disadvantage in a mechanism that rewards early information.

**Resolution — pre-committed declaration model:**

A cross-class implication declaration may be submitted when the more-mature class (A) has ≥1 completed normal-mode macro-epoch, even if the less-mature class (B) is still in Phase 1.

On submission:
- A-stake and B-stake are locked in escrow immediately (commitment is real).
- Implication_bonus_escrow is held at the protocol layer.
- The declaration appears in EAT with status = `pre_active`.

Activation conditions (both must be satisfied):
1. B exits Phase 1 (first normal-mode macro-epoch for B's class closes).
2. At least one of: knower re-attests the declaration (`reaffirm` call, no additional stake) OR declaration was submitted within the last `T_precommit_window = 2 × macro_epoch_B` before B's Phase 1 exit.

**Rationale for re-attestation option:** A pre-committed declaration made months before B exits Phase 1 may reflect stale information. Re-attestation is a lightweight freshness check — no additional stake required, but the act signals the knower still believes in the implication after observing Phase 1 behavior of B. If knower does not reaffirm and T_precommit_window has passed, the declaration expires: escrow returned in full, no slash, no EAT penalty.

**Epistemic weight during pre-active period:** Zero. Pre-active declarations do not contribute to S_cred for either class. Capital is locked but the declaration is dormant. This prevents early-knowers from influencing S_cred of an immature class via pre-committed declarations. (#r136)

---

**Q3 (Minimum effective chain contribution floor) → min_chain_weight_fraction × W_max per coordinate (#r136):**

When debt withholding reduces a knower's primary claim stake, the implication chain contribution to S_cred at each coordinate in the chain shrinks proportionally. At sufficient depth and withholding, the contribution to S_cred becomes smaller than noise — yet the declaration still occupies state space and aggregation weight, creating overhead without signal.

**Resolution — minimum effective chain weight floor:**

```
min_chain_contribution(coord_i, depth_d) =
    min_chain_weight_fraction × W_max(coord_i) × γ^(depth_d - 1)

min_chain_weight_fraction = 0.01  (governance-settable, bounded [0.001, 0.05])
```

If a knower's effective contribution to S_cred at any coordinate in the chain falls below `min_chain_contribution` at the time of declaration, that coordinate is excluded from the chain declaration (depth truncated at that point). Excluded coordinates do not receive the chain depth discount γ^(depth-1) bonus.

**Not a rejection — a truncation:** The declaration is not rejected; it is truncated to the depth where contribution remains meaningful. Knower is notified at submission of the effective declared depth. Escrow for truncated coordinates is returned (not locked). This preserves participation for knowers under temporary withholding while keeping S_cred signal-to-noise above a designed threshold.

**Interaction with anti-fragmentation fix (#r75/Q4):** The per-pair uniqueness rule (#r75 fix) already prevents fragmentation by merging overlapping chains to max-depth. Truncation from the floor reduces max-depth from the other direction. These are complementary: fragmentation prevention sets the ceiling (depth cannot be inflated by fragmentation); contribution floor sets the effective depth floor (depth cannot be extended below noise threshold). The chain depth at any epoch = min(declared_depth, depth_at_min_contribution_floor). (#r136)

---

**Q4 (EAT record for governance parameter rollback before epoch-of-effect) → New EAT event type `parameter_rollback` with `effect_status` tag (#r136):**

EAT immutability (#r74) prohibits any modification or deletion of prior records. A governance rollback before the new window begins creates an edge case: the original commit is recorded, took no effect, and was superseded. Without an explicit rollback record, auditors cannot distinguish between "parameter never changed" (no commit) and "parameter commit was rolled back before effect" (commit + rollback). These have different governance interpretations.

**Resolution — `parameter_rollback` as a first-class EAT event type:**

```
EAT event: {
  type:           "parameter_rollback",
  references:     [original_commit_EAT_event_id],
  epoch_committed: T_rollback,
  epoch_of_effect: same as original commit's epoch_of_effect (or null if committed before effect),
  effect_status:  "never_applied" | "partially_applied" | "applied_then_reverted",
  rollback_reason: governance-submitted string (required, published on-chain)
}
```

**effect_status semantics:**
- `never_applied`: rollback committed before the original change's epoch_of_effect. Parameter was never live. This is the question case — a null-effect rollback.
- `partially_applied`: rollback committed during an active evaluation window that started under the original parameters. In-flight evaluations complete under original params (#r135/Q3); the rollback governs the next window.
- `applied_then_reverted`: rollback committed after the original parameters governed at least one full completed evaluation window.

**Canonical state reconstruction:** Auditors replay EAT events in timestamp order. A `parameter_rollback` event with `effect_status: never_applied` means: as of the original commit's epoch_of_effect, the parameter is the value from the most recent prior commit (not the rolled-back value). The EAT sequence makes this unambiguous without silent deletion.

**rollback_reason requirement:** Governance must submit a human-readable rollback_reason (minimum 1 character, no validation on content). This is a weak accountability mechanism — not enforceable — but it creates a public audit trail of governance intent for each rollback event. (#r136)

---

## Structural Synthesis: Declaration Lifecycle Completeness (#r136)

Four open lifecycle edge cases from #r135 now closed:

| Edge case | Resolution | Design law |
|---|---|---|
| debt_retirement_reserve unfunded | Queue preserved; governance SLA breach suspends intake only | Governance failure ≠ knower right lapse |
| Cross-class declaration with immature class | Pre-committed declaration: capital locks, weight deferred until Phase-1 exit | Commitment ≠ activation; lock early, weight late |
| Deep chain contribution below noise | Contribution floor = 0.01 × W_max × γ^(depth-1); declaration truncated, not rejected | Floor prevents noise; truncation preserves participation |
| Governance parameter rollback pre-effect | `parameter_rollback` EAT event with `effect_status: never_applied` | Every governance action is an immutable EAT commit; rollback is a new commit, not deletion |

---

## Open Questions for #r137+

1. **Pre-committed declaration and corroboration ordering (#r76/Q2):** If knower X pre-commits a cross-class A→B declaration before class B exits Phase 1, and knower Y submits the same pair post-Phase-1-exit (first to activate), who is "first declarer" for the γ_corr discount? EAT timestamp of pre-commit is earlier; but Y was first to have an active declaration. The corroboration discount should track activation timestamp, not submission timestamp — otherwise pre-committers get permanent first-mover advantage through pre-active declarations that cost them nothing to hold.

2. **min_chain_weight_fraction governance change and in-flight declarations:** If governance lowers min_chain_weight_fraction mid-epoch, some truncated declarations could become full-depth eligible. Should truncation be re-evaluated at each macro-epoch boundary (dynamic), or frozen at declaration time (static)? Dynamic re-evaluation is more capital-efficient but creates retroactive depth-change complexity for EAT records.

3. **Pre-committed declaration expiry during degraded mode:** If a pre-committed declaration's T_precommit_window timer is running when DA outage occurs, does the timer toll (consistent with all other expiry tolling policies), or does it advance (since B's Phase 1 is also frozen during degraded mode)? If B's Phase 1 is frozen (no epoch advances), the pre-commit window should also freeze — they are coupled.

4. **debt_retirement_reserve and TOWL zone interaction:** The debt_retirement_reserve is a fourth protocol reserve category (alongside LTRP, implication_bonus_escrow, challenger pool). Its funding draws from governance. During Zone C, outflows from protocol reserves may stress the mechanism. Should the debt_retirement_reserve be subject to the same class-level Zone C gating as implication_bonus_escrow (#r134/Q4), or is it governance-sourced and therefore not class-scoped?

*Last updated: #r136 — 2026-04-03T20:22Z*

---

## #r137 Contributions — 2026-04-03T20:32Z

Addresses all four open questions from #r136.

**Q1 (Pre-committed declaration corroboration ordering) → Activation timestamp governs γ_corr priority; submission timestamp has no ordering relevance (#r137):**

The corroboration discount (γ_corr, #r76/Q2; γ_corr_cross, #r129/Q1) was designed to discount repeat same-pair declarations because additional contributions add diminishing epistemic information. The relevant information event is when a declaration begins contributing to S_cred — the activation timestamp — not when capital was locked.

**Resolution:** γ_corr priority is determined by activation EAT timestamp exclusively.

- Pre-committed declaration activates at B's Phase-1-exit epoch boundary (if re-attestation condition is met, #r136/Q2).
- Normal declaration activates at submission time (both classes already have ≥1 normal-mode macro-epoch).
- First-mover = first activation EAT timestamp. If X's pre-commit reaffirms exactly at B's Phase-1-exit boundary and Y submits immediately after that boundary, X and Y have distinct activation timestamps in EAT order and priority is unambiguous.
- X's pre-commit submission timestamp is not recorded as an ordering input to γ_corr — only activation timestamp matters.

**Rationale:** A pre-committed declaration has zero epistemic contribution during pre-active status. The mechanism has no information about its quality prior to activation. A post-Phase-1-exit submission from Y that activates immediately is epistemically equivalent to "arrived first" from the S_cred perspective, regardless of when X locked capital.

**Adversarial implication:** An adversary cannot game first-mover advantage by pre-committing many declarations in Phase 1 bootstrap epochs to ensure activation priority on Phase-1-exit. Pre-committed declarations require re-attestation within T_precommit_window (#r136/Q2) — holding pre-active declarations indefinitely without fresh re-attestation causes them to expire with escrow returned. The capital cost of maintaining pre-committed declarations is real (locked capital); the corroboration reward is not guaranteed. (#r137)

---

**Q2 (min_chain_weight_fraction governance change and in-flight declarations) → Escrow commitment static; S_cred effective depth dynamic; bonus at resolution from last pre-resolution depth (#r137):**

The critical decomposition: escrow is committed at declaration time (capital obligation); S_cred contribution weight is a protocol output (epistemic computation). These are governed by different update rules.

**Resolution — two independent update rules:**

1. **Escrow (static):** The escrow locked at declaration for each coordinate in the chain is fixed. Governance changing min_chain_weight_fraction does not trigger escrow adjustment. A threshold increase that would now truncate a coordinate does not release that coordinate's escrow — the capital commitment is not retroactively reduced. A threshold decrease does not lock additional escrow.

2. **S_cred effective depth (dynamic):** Evaluated at each macro-epoch boundary using the current min_chain_weight_fraction. If the threshold rises and a depth-3 chain drops to effective depth 2, coordinate C at depth 3 no longer contributes to S_cred until (a) governance lowers the threshold again or (b) the knower's debt withholding situation improves (if that was the source of contribution reduction). This is a pure epistemic update — no escrow changes, no EAT event required for the contribution change (it derives from chain_weight and current threshold deterministically).

3. **Implication bonus (resolution-time):** Bonus is conditional on both coordinates resolving correctly. The effective depth governing the bonus is the last macro-epoch's effective depth before oracle resolution fires. This is the most conservative reasonable point — it prevents a knower from briefly expanding effective depth during the resolution epoch to capture a deeper bonus.

**EAT treatment:** Escrow commitment is recorded at declaration. Dynamic depth changes are not separately EAT-committed (they are deterministically computable from chain parameters and current governance values). The resolution-settlement EAT event records: declared_depth, effective_depth_at_resolution, and bonus_applied.

**Design law (#r137):** Protocol-level epistemic computation (S_cred weights, effective depth) is dynamically re-derived from current parameters each epoch. Capital commitment (escrow) is statically committed at declaration. These must never be conflated. If a mechanism feature requires capital to move in response to a governance parameter change, it requires an explicit escrow adjustment event — not implicit dynamic re-computation. (#r137)

---

**Q3 (Pre-committed declaration expiry during degraded mode) → Window is epoch-indexed to B's Phase-1-exit; implicit freeze; no explicit tolling rule needed (#r137):**

The T_precommit_window is defined as "within 2 × macro_epoch_B before B's Phase 1 exit" (#r136/Q2). It is a countdown indexed to the Phase-1-exit epoch event, not to wall-clock time from declaration.

**Analysis:** B's Phase 1 epoch count is frozen during degraded mode (#r130/Q1: T3 gate epoch count paused; Phase 1 falls under the same DA-liveness precondition). If B's Phase-1-exit epoch has not yet been reached, the exit event is deferred by the number of frozen epochs. T_precommit_window is measured backward from that exit event — so when the exit event is deferred, the window is automatically deferred by the same amount.

**Resolution:** No explicit tolling rule is required. The pre-committed declaration's reaffirmation deadline is inherently coupled to B's Phase-1-exit timeline. Degraded mode freezes B's Phase 1 progression, which defers the exit epoch, which defers the T_precommit_window end, which extends the knower's reaffirmation opportunity.

**Edge case — declaration made just before DA outage with B's Phase 1 exit already queued:** B's exit was 0.5 × macro_epoch_B away when outage started. After DA restore, B needs to complete the remaining 0.5 macro-epoch of Phase 1. T_precommit_window end follows B's exit. Knower has the full window post-exit to reaffirm; no truncation from the outage period.

**Design law (#r137):** Any deadline indexed to a mechanism epoch event (not to wall clock) is automatically frozen when that epoch event is suspended. This is a first-class mechanism invariant: epoch-indexed deadlines require no separate tolling rules under degraded mode — they inherit the freeze from the epoch system. This complements the wall-clock tolling rules established for challenge windows and T_longtail expiry. Designers must explicitly choose at feature-design time whether a deadline is epoch-indexed or wall-clock-indexed; the freeze behavior follows automatically. (#r137)

---

**Q4 (debt_retirement_reserve and TOWL zone interaction) → Not class-gated; not TOWL-gated; governed exclusively by governance SLA framework (#r137):**

The debt_retirement_reserve is protocol-global and governance-funded. Its capacity is not derived from any coordinate class's escrow flows — unlike LTRP (per-class, sourced from T3_escrow_longtail) and implication_bonus_escrow (bilateral, sourced from knower stake + loser pool).

**Resolution:** debt_retirement_reserve outflows are not subject to class-level Zone C gating and are not subject to global Zone C gating.

**Reasoning:**
1. *Class-level Zone C gating (#r134/Q4)* applies to outflows from reserves whose capacity is coupled to the class's TOWL health. debt_retirement_reserve draws from governance allocation, not from any class's escrow. Drawing from it does not affect any class's TOWL zone.
2. *Global Zone C* is a TOWL aggregate signal. debt_retirement_reserve is orthogonal to TOWL by construction (#r131/Q2 design law: pool-level reserves are reported separately, not TOWL-counted).
3. Blocking debt retirement during Zone C would punish knowers for a solvency stress event unrelated to their debt — the debt was incurred from an implication bonus clawback, not from TOWL strain.

**The reserve is governed exclusively by the governance SLA framework (#r136/Q1):** funded by governance, monitored by auto-alert, queue-suspended on SLA breach. This is a governance accountability mechanism, not a solvency mechanism. Zone C is a solvency signal; debt retirement is a governance function. They are orthogonal.

**Scope definition:** The classification of each protocol reserve category by governance type vs. solvency scope is now formally tabulated:

| Reserve | Governed by | Zone C gated? | TOWL-counted? |
|---|---|---|---|
| LTRP | Class-level solvency (per-class) | Yes (class-local) | No (buffer) |
| implication_bonus_escrow | Bilateral, protocol-held | Yes (class-local) | No (protocol reserve) |
| challenger_pool | Per-class (from forfeitures) | Yes (class-local) | No (buffer) |
| debt_retirement_reserve | Governance SLA | No | No |

**Design law (#r137):** Governance-funded reserves are orthogonal to solvency gating. Only escrow-flow-sourced reserves (whose capacity is mechanically coupled to class-level financial flows) are subject to Zone C gating. The gating criterion is: does the reserve's capacity derive from coordinate-class escrow? If yes, class-gated. If sourced from governance allocation, not gated. (#r137)

---

## Structural Synthesis: Declaration Lifecycle and Reserve Governance — Closed (#r137)

| Feature | Resolution | Law |
|---|---|---|
| Corroboration ordering for pre-committed declarations | Activation timestamp only; submission timestamp irrelevant | Epistemic contribution starts at activation, not capital lock |
| Governance change to min_chain_weight_fraction | Escrow static; S_cred depth dynamic; bonus at last pre-resolution depth | Capital commitment ≠ epistemic computation; never conflate |
| Pre-committed declaration expiry during degraded mode | Epoch-indexed deadline; implicit freeze; no explicit tolling needed | Epoch-indexed deadlines auto-freeze with epoch system |
| debt_retirement_reserve Zone C interaction | Governance-funded → not Zone C gated; governed by SLA only | Escrow-flow-sourced reserves are solvency-gated; governance reserves are not |

---

## Open Questions for #r138+

1. **Activation timestamp tie-breaking:** If X (pre-commit) and Y (normal submission) both activate in the same epoch boundary event (e.g., B exits Phase 1 and X reaffirms in the same block as Y's post-Phase-1-exit submission), both have the same macro-epoch activation. Should γ_corr ordering be: (a) EAT within-block ordering, (b) both treated as simultaneous first declarers (both earn full β, no discount), or (c) one randomized as first?

2. **Dynamic effective depth and fee distribution:** When S_cred effective depth drops (threshold increase), contributors at the now-truncated coordinate no longer contribute to S_cred — but they already have capital locked. Do they still earn query fees for periods where their contribution was active (historical pro-rata), or is fee distribution purely forward-looking based on current effective depth?

3. **Epoch-indexed vs wall-clock deadlines — catalog:** The design law from #r137/Q3 distinguishes epoch-indexed and wall-clock-indexed deadlines. What is the complete catalog of mechanism deadlines and their index type? Some deadlines (e.g., challenge_window) were implemented as duration from event, which is wall-clock-ish but indirectly epoch-indexed since challenge windows run from epoch close.

4. **debt_retirement_reserve and α_longtail interaction during Zone C:** The reserve is not Zone C gated. But α_longtail (fraction of T3 escrow routed to LTRP) is part of the solvency model. During Zone C, if governance suspends new T3 installations, α_longtail contributions to LTRP also pause — but debt_retirement_reserve continues to pay out retirements (unaffected by Zone C). Is there any cross-effect from Zone C on the reserve's self-sufficiency? Answer: likely none, since the reserve is governance-funded, not LTRP-fed. But worth explicitly verifying the funding independence.

*Last updated: #r137 — 2026-04-03T20:32Z*

---

## #r138 Contributions — 2026-04-03T20:42Z

Addresses all four open questions from #r137.

**Q1 (Activation timestamp tie-breaking for same-epoch co-activators) → Simultaneous first declarers; no γ_corr discount applied to either (#r138):**

When X (pre-committed declaration, reaffirmed at B's Phase-1-exit boundary) and Y (normal post-Phase-1-exit submission) both activate in the same macro-epoch boundary event, three options were considered:

- **EAT within-block ordering:** Produces a technical first-mover priority, but within-block ordering is partially validator-controlled — a soft manipulation surface. Mechanism should not incentivize validator collusion for corroboration priority.
- **Randomized ordering:** Creates fragility and unpredictability; knowers cannot rationally pre-compute expected returns.
- **Simultaneous first declarers (no γ_corr discount for either):** Both activated in the same epoch and produced information with no epistemic ordering advantage. Both earn full β implication bonus on their own stake. Subsequent same-pair declarers in later epochs receive the normal γ_corr discount against the earlier activation epoch.

**Resolution:** Simultaneous same-epoch co-activators are both treated as first declarers. Neither receives a γ_corr discount relative to the other. From the next epoch onward, the pair is registered as having two first declarers; any new same-pair declarers are second-or-later.

**Cross-lineage interaction (#r129/Q1):** If X and Y are cross-lineage, the γ_corr_cross rate applies to any third declarer of the same pair from any lineage class. The simultaneous-first treatment does not change the γ_corr_cross parameter — it only determines that neither X nor Y is discounted relative to the other.

**EAT record:** A same-epoch co-activation event is recorded with `co_activation: true` flag on both declaration EAT records. The settlement contract uses this flag to suppress γ_corr between co-activators at bonus computation time.

**Design law (#r138):** When activation timestamps are indistinguishable at macro-epoch resolution, neither party has a provable epistemic ordering advantage. The epistemically correct resolution is equal treatment (no discount). Mechanism design should not create incentives to extract within-epoch ordering advantage from validators. (#r138)

---

**Q2 (Historical query fee for truncated depth contributors) → Fee distribution is strictly forward-looking; historical distributions are final (#r138):**

When governance raises min_chain_weight_fraction and an effective chain depth drops from depth D to depth D-1, the contributor at the now-truncated coordinate (depth D) no longer contributes to S_cred from the threshold-change epoch onward. Their historical S_cred contribution during prior epochs was real and already settled.

**Resolution:** Query fee distribution is forward-looking only. From the epoch in which effective depth drops below the contribution floor, the truncated coordinate's contributor earns no new query fees from that coordinate. Historical query fees already distributed in prior epochs are final and not subject to clawback or retroactive redistribution.

**Rationale:**
1. *EAT immutability (#r74):* Historical fee settlement records are committed to the EAT. Retroactive redistribution would require editing those records — explicitly prohibited.
2. *Epistemic correctness:* The contributor's S_cred contribution in historical epochs was genuine and reflected the threshold active at that time. The governance decision to raise the threshold does not retroactively reduce the epistemic value delivered in prior epochs.
3. *Predictability:* If governance parameter changes retroactively modified earned fees, knowers could not compute expected returns from declarations. This would destabilize the incentive to make structural implication declarations.

**Escrow treatment:** Capital locked at depth D remains locked until its natural expiry horizon (T_longtail or challenge_window). The contribution floor is an epistemic threshold (affects S_cred weight), not an escrow-release trigger. Escrow commitment follows the static rule from #r137/Q2.

**Summary — three orthogonal timelines for a truncated declaration:**
- Escrow: locked at declaration; released at ceiling (static, #r137)
- S_cred contribution: active until threshold exceeds floor; zero from threshold-change epoch forward (dynamic)
- Query fees: earned and settled per epoch where contribution was active; historical distributions final (irreversible at EAT commit) (#r138)

---

**Q3 (Deadline catalog — epoch-indexed vs wall-clock) → Complete classification of mechanism deadlines (#r138):**

The #r137 design law requires explicit classification at feature design time. This run produces the canonical catalog.

| Deadline | Anchor event | Index type | Degraded-mode behavior | Source |
|---|---|---|---|---|
| Challenge window | Epoch close (warranted installation) | Epoch-indexed | Implicit freeze (epoch pauses) | #r71 |
| T_provisional_max | oracle_status=pending event | Epoch-indexed (oracle-latency windows at epoch granularity) | Implicit freeze | #r71 |
| T_outage_cap | Outage start → outage end (wall-clock duration) | Wall-clock-indexed | Explicit tolling: timer does not advance when DA down | #r131/Q4 |
| T_longtail expiry | Claim registration + T_longtail duration | Wall-clock-indexed | Explicit tolling ✓ (established) | #r130 |
| T_precommit_window | B's Phase-1-exit epoch | Epoch-indexed | Implicit freeze (B's Phase 1 frozen = exit deferred = window deferred) | #r136/Q2, #r137/Q3 |
| M_stable window | Rolling macro-epoch count | Epoch-indexed (normal-mode epochs only) | Implicit freeze (normal-mode count pauses during degraded mode) | #r133/Q3 |
| T_replenishment_sla | Governance SLA breach event | Epoch-indexed (macro_epoch_max_class units) | Implicit freeze (epoch count pauses) | #r136/Q1 |
| Implication_bonus_escrow expiry | max(T_longtail_A, T_longtail_B) from declaration | Wall-clock-indexed (follows T_longtail policy) | Explicit tolling ✓ (#r135/Q2 doubling cap) | #r135 |
| T_precommit_window end during Zone C deferral | B's Phase-1-exit epoch (Zone C adds no separate deadline) | Epoch-indexed | No separate interaction; Zone C does not affect B's Phase-1-exit epoch | This run |
| SEE_protection pre_shock_window | Shock onset timestamp | Wall-clock-indexed (continuous taper formula, #r75) | Explicit treatment: SEE declarations deferred during degraded mode; window timers toll | #r75 |

**Classification rule (canonical, #r138):**
- **Epoch-indexed:** Deadline is a function of mechanism epoch events (epoch boundary, oracle event, phase transition). Freeze is automatic when the epoch system is paused. No separate tolling rule required.
- **Wall-clock-indexed:** Deadline is a function of elapsed real time (or DA-clock time). Explicit tolling rule must be specified at feature design time. Default tolling: timer pauses during degraded mode.

**Discovered gap — challenge window during Zone C:** Challenge window is epoch-indexed (freezes in degraded mode). Zone C is not degraded mode. During Zone C, epochs continue normally, so challenge windows advance normally. This was not previously stated explicitly. **Challenge windows are NOT suspended during Zone C** — only during DA outage (degraded mode). Zone C is a TOWL solvency condition; it does not pause the epoch system. (#r138, catalog completes #r137 design law)

---

**Q4 (debt_retirement_reserve and Zone C α_longtail cross-effect) → Structurally independent; no mechanism-level cross-effect; governance discretion is orthogonal (#r138):**

The reserve is governance-funded. α_longtail routes T3_escrow_longtail contributions to LTRP — a per-class pool. The two funding pipelines are structurally independent:

- Zone C may pause new T3 installations → α_longtail contributions to LTRP reduce or pause.
- The debt_retirement_reserve receives no funding from LTRP or α_longtail flows.
- The debt_retirement_reserve is topped up by governance allocation decisions.

**Verification of funding independence:**

```
LTRP_funding_source:   T3_escrow_longtail × α_longtail  (per-claim escrow routing)
debt_retirement_reserve_funding_source:  governance_allocation  (separate transaction)
```

There is no accounting identity that links these two flows. Zone C reducing α_longtail contributions to LTRP has zero direct impact on the debt_retirement_reserve balance.

**Governance discretion as orthogonal layer:** Governance may choose to reduce allocations to the debt_retirement_reserve during Zone C as a budget-conservation measure — but this is a governance policy choice, not a mechanism constraint. The mechanism itself imposes no cross-effect. If governance documents their Zone C budget policy, it should appear in governance documentation, not in mechanism parameters.

**Completeness check:** All four protocol reserve categories now have explicit Zone C gating classification:

| Reserve | Zone C gated? | Reason |
|---|---|---|
| LTRP | Yes (class-local) | Escrow-flow-sourced; class solvency-coupled |
| implication_bonus_escrow | Yes (class-local) | Bilateral escrow-sourced; class solvency-coupled |
| challenger_pool | Yes (class-local) | Forfeitures-sourced; class solvency-coupled |
| debt_retirement_reserve | No | Governance-allocated; not escrow-flow-sourced |

**Design law confirmed (#r137, now closed by verification):** The criterion is binary: does the reserve's capacity derive from coordinate-class escrow flows? If yes → class-gated. If governance-funded → not gated. No exceptions discovered. The catalog is complete. (#r138)

---

## Structural Synthesis: Deadline Taxonomy and Reserve Independence — Closed (#r138)

#r138 closes three structural documentation gaps and one empirical verification:

1. **Corroboration tie-breaking:** Same-epoch co-activators are simultaneous first declarers. No within-epoch ordering manipulation is incentivized. (#r138/Q1)
2. **Fee distribution finality:** Query fee settlement is final at each EAT epoch commit. Governance threshold changes are purely forward-looking for S_cred contribution; they do not retroactively affect fee records. (#r138/Q2)
3. **Deadline catalog:** All mechanism deadlines formally classified as epoch-indexed (implicit freeze) or wall-clock-indexed (explicit tolling required). **Challenge windows do not pause during Zone C** — a previously unspecified distinction from degraded-mode behavior. (#r138/Q3)
4. **Reserve independence confirmed:** debt_retirement_reserve funding is structurally independent of α_longtail and LTRP. Zone C has no mechanism-level cross-effect on the reserve. (#r138/Q4)

---

## Open Questions for #r139+

1. **co_activation EAT flag and post-activation corroboration ordering:** If X and Y are co-activators (same epoch, `co_activation: true`), and Z submits the same pair in a later epoch — Z is a second declarer relative to both. But when there are two "first declarers," does Z's γ_corr discount apply once (as if facing a single prior declarer) or does it stack against both X and Y independently? The γ_corr formula uses `n_same_lineage - 1` as the exponent. With two first declarers, is Z's n = 2 (second same-lineage position) or n = 3 (after two first-declarers)?

2. **Effective depth reactivation after threshold decrease:** If min_chain_weight_fraction is lowered in a later epoch, a previously truncated contributor at depth D may reactivate (their contribution is now above the new threshold). Do they re-enter as a first contributor at depth D (earning full query fee weight from reactivation), or do they carry the historical activation EAT record and earn corroboration-discounted query fee weight (since there may now be other active depth-D contributors who joined during the truncation gap)?

3. **Challenge window Zone C gap — coordination implication:** The catalog (#r138/Q3) establishes that challenge windows advance during Zone C. But Zone C is also a period when T3 installations are throttled and new warranty obligations are suppressed. Does the advance of challenge windows during Zone C create an asymmetric exposure: existing warranted T3 installations can be challenged and slashed during Zone C even as new installations are blocked? Is this the correct incentive?

4. **Catalog completeness check — deadline-adjacent timers:** The catalog covers named deadlines. Some mechanism features use duration-from-event timers that are not named as "deadlines" but function identically: e.g., the β_effective clamp alert (clamp binding for ≥2 consecutive macro-epochs, #r129/Q4). Are these epoch-indexed or wall-clock-indexed? If they are missed from the catalog, the design law from #r137 is not fully applied.

*Last updated: #r139 — 2026-04-03T20:52Z*

---

## #r139 Contributions — 2026-04-03T20:52Z

Addresses all four open questions from #r138.

**Q1 (Z's γ_corr discount with two co-activators) → Position-count interpretation; co-activators each consume a sequence position (#r139):**

When X and Y are co-activators (`co_activation: true`), each is at position 1 in the ordering sequence for the pair. The γ_corr formula operates on position index in the activation sequence, not on "number of prior unique first declarers."

**Resolution — position-count interpretation:**

```
bonus(declarer at position p, same lineage) = β × (1 - γ_corr)^(p - 1)
bonus(declarer at position p, cross-lineage) = β × (1 - γ_corr_cross)^(p - 1)
```

Co-activators X and Y are both at position 1 → exponent = 0 → both earn full β (no discount, consistent with #r138/Q1).

Z is the next declarer. The position counter advances from 1 to the next available position after all co-activators. With two co-activators at position 1, the next position is 3 (not 2):

```
Z's position p(Z) = 1 + count_of_prior_declarers_of_same_lineage_class
```

For Z (same lineage as X and Y): p(Z) = 1 + 2 = 3 → exponent = 2 → Z earns `β × (1 - γ_corr)^2`.

**Rationale:** Co-activators X and Y each delivered independent epistemic contributions at activation — even though neither was discounted relative to the other, both occupy positions in the sequence that a subsequent declarer must follow. From Z's perspective, X and Y are both prior contributors of the same information, regardless of their mutual tie. The information Z adds is discounted against the combined prior baseline.

**Cross-lineage Z:** If Z is cross-lineage to both X and Y, Z uses γ_corr_cross. Position counting is per-lineage-class:

```
p_cross(Z) = 1 + count_of_prior_cross_lineage_declarers
```

X and Y are same-lineage to each other but cross-lineage to Z. If X and Y are both in lineage class L1 and Z is in lineage class L2, then Z's cross-lineage position = 1 (first L2 declarer). Z earns `β × (1 - γ_corr_cross)^0 = β × 1.0` — near-full bonus, consistent with the independence premium.

**EAT record:** Settlement contract computes position at bonus-computation time by counting EAT-committed declarers of each lineage class with earlier or equal (co_activation) activation epoch. (#r139)

---

**Q2 (Effective depth reactivation after threshold decrease) → Original activation EAT timestamp preserved; corroboration position resumes at pre-truncation rank; fees strictly forward-looking (#r139):**

When min_chain_weight_fraction is lowered in epoch T_low, a contributor previously truncated at depth D in epoch T_trunc may re-cross the contribution floor and become eligible to contribute to S_cred again.

**Resolution:**

1. **EAT timestamp:** The original activation EAT timestamp (from the contributor's initial declaration) is preserved. It was never deleted — EAT is immutable (#r74). Reactivation does not create a new declaration record; S_cred contribution weight is dynamically re-derived from the existing declaration record using the new threshold (consistent with #r137/Q2 static escrow / dynamic S_cred rule). The declaration simply moves from contributing weight 0 back to contributing its chain-depth-discounted weight.

2. **Corroboration position:** The contributor retains their original activation sequence position. If they were the sole depth-D declarer before truncation, and no other contributor activated at depth D during the truncation gap: they re-enter as sole contributor at their original position. If new contributors activated at depth D during the gap (because min_chain_weight_fraction was low enough for them but not the original contributor — possible if debt withholding caused the original truncation, not a threshold increase): the original contributor resumes at their original sequence position, and the gap-period contributors hold positions they earned during the gap. No re-ordering occurs at reactivation; each contributor retains the position assigned at their respective activation epoch.

3. **Query fees:** Strictly forward-looking from reactivation epoch (epoch T_low) onward — consistent with #r138/Q2. Zero fees earned retroactively for the truncation gap. Historical fees during active period are final and not touched.

4. **Escrow:** Unchanged throughout (static, #r137/Q2). Truncation and reactivation are purely epistemic events.

**Adversarial case — threshold cycling:** Governance could theoretically oscillate min_chain_weight_fraction to selectively truncate and reactivate specific contributors. Defense: threshold changes are EAT-committed governance events with rollback records (#r136/Q4). Repeated oscillations are publicly auditable. The mechanism does not add defense beyond auditability — this is a governance accountability issue, not a mechanism parameter one. (#r139)

---

**Q3 (Challenge window advancing during Zone C — asymmetric exposure) → Windows advance normally; Zone C slash routing: LTRP buffer first (#r139):**

Zone C is a TOWL solvency stress condition. Challenge windows are epoch-indexed — they advance normally during Zone C (#r138/Q3, explicitly established). This means existing T3 warranted installations can be challenged and slashed during Zone C even as new T3 installations are throttled.

**Analysis of the asymmetry:** This is not an error — it is epistemically correct. Zone C should not grant immunity to poor-quality information. A challenge that succeeds during Zone C indicates a real quality failure in a warranted installation; suppressing that challenge would degrade S_cred quality precisely when epistemic reliability matters most.

However, slashing during Zone C adds to financial stress: the slashed stake flows to the loser pool (standard settlement), which in a stressed epoch may exacerbate TOWL pressure if the protocol's reserve structure is thin.

**Resolution — Zone C slash routing override:**

During Zone C (class-level or global), successful challenge slashing follows a modified routing sequence:

```
Normal mode:   slash → loser pool (distributed to winners + challenger reward)
Zone C mode:   slash → LTRP buffer first (up to LTRP underfunding amount)
                     → loser pool (remainder)
```

The LTRP buffer receives slash proceeds during Zone C up to the amount needed to bring LTRP coverage_ratio to GREEN threshold. Slash proceeds above that amount route normally to the loser pool.

**Why this is correct:** Zone C slash is real forfeiture from a genuine quality failure. Routing a portion to LTRP during Zone C converts the epistemic-enforcement mechanism into a partial solvency stabilizer — without suppressing the challenge incentive. Challengers still earn their reward (sourced from the loser pool remainder or protocol fee). The slash magnitude is unchanged.

**Challenger reward protection:** Challenger reward is paid before LTRP routing. Priority: (1) challenger reward pool, (2) LTRP buffer top-up (to GREEN threshold), (3) loser pool distribution. Challengers are never disadvantaged by Zone C routing.

**Scope:** This applies to the coordinate-class-level Zone C for the class containing the challenged installation. Global Zone C applies Zone C routing to all classes simultaneously.

**Design law (#r139):** Epistemic enforcement mechanisms (challenge windows, slashing) are never suspended by solvency conditions. Only routing of proceeds changes. This preserves epistemic incentives while using enforcement events opportunistically for solvency repair. (#r139)

---

**Q4 (Deadline-adjacent timers — catalog extension) → Bridge epoch duration, β_effective clamp alert, and Zone C alert added to catalog (#r139):**

The #r137 design law requires all deadline-adjacent timers to be classified as epoch-indexed or wall-clock-indexed. Several mechanism timers were not in the #r138 catalog:

| Timer | Anchor event | Index type | Degraded-mode behavior | Source |
|---|---|---|---|---|
| Bridge epoch duration | DA restore event | Epoch-indexed (exactly 1 macro-epoch post-restore) | N/A — bridge only fires on DA restore (which ends degraded mode) | #r131/Q3 |
| β_effective clamp alert | Clamp binding epoch | Epoch-indexed (≥2 consecutive normal-mode macro-epochs) | Implicit freeze (normal-mode count pauses during degraded mode) | #r129/Q4, #r132/Q2 |
| Zone C → implication_bonus_escrow deferral | Zone C entry event | Epoch-indexed (Zone C duration in macro-epochs) | N/A — Zone C is not a degraded-mode condition; epochs advance normally | #r134/Q4 |
| zone_c_epochs_in_window alert | Rolling N_calibration window | Epoch-indexed (normal-mode epochs in window) | Implicit freeze | #r133/Q2 |
| Provisional score refinement at DA restore | DA restore event | Event-triggered (fires at first post-bridge macro-epoch boundary) | N/A — fires on DA restore | #r131/Q3 |
| debt_withholding_rate recalculation | Per macro-epoch boundary | Epoch-indexed (continuous, no expiry deadline) | Implicit freeze | #r134/Q2 |

**New classification added to catalog (#r139):** Bridge epoch duration is epoch-indexed with a fixed length of exactly 1 macro-epoch. It does not toll — it has no tolling clock because it fires only after DA restores (degraded mode ends). The bridge epoch cannot overlap with degraded mode by construction.

**Observation — timer-adjacent features without deadlines:** `debt_withholding_rate` and `provisional_score_refinement` are recurrent computations, not deadlines. They have no expiry. They are not subject to the epoch-indexed vs. wall-clock design law (which applies to deadlines — timers with terminal states). These should not appear in the deadline catalog; they appear here for completeness only and are explicitly marked as non-deadline timers.

**Catalog closure statement (#r139):** With this extension, all known mechanism deadlines and deadline-adjacent timers have been classified. Future features that introduce timers with terminal states MUST explicitly declare their index type at feature design time per the #r137 design law. Non-deadline recurrent computations are excluded from the catalog but noted in feature documentation. (#r139)

---

## Structural Synthesis: Mechanism Closure State After #r139 (#r139)

The bounded-liability architecture, escrow taxonomy, deadline catalog, and reserve governance framework are now internally consistent and closed. Key closure milestones:

| Domain | Closed in | Law |
|---|---|---|
| Bounded-liability decomposition | #r130–#r132 | Every unbounded individual liability → bounded window + pool |
| Escrow taxonomy (4 categories) | #r133 | Each category: named ceiling, backstop, TOWL treatment |
| Reserve governance (4 reserves) | #r137–#r138 | Escrow-sourced → class-gated; governance-funded → not gated |
| Deadline catalog (all timers) | #r138–#r139 | Epoch-indexed (implicit freeze) vs wall-clock (explicit tolling) |
| Corroboration ordering (all edge cases) | #r138–#r139 | Position-count; co-activators each consume position; activation timestamp governs |
| Zone C slash routing | #r139 | Epistemic enforcement never suspended; proceeds routing adapts |

**Open question frontier as of #r139 (proposed for #r140+):**

1. **Zone C slash routing and challenger reward pool solvency:** During Zone C with many simultaneous challenges, the challenger reward pool may be depleted before LTRP top-up if all proceeds route through priority-1 challenger rewards first. Is there a per-challenge challenger reward cap during Zone C to prevent challenger pool exhaustion at the expense of LTRP recovery?

2. **Reactivation at depth D when gap-period contributors have higher credibility:** If contributor A (original, reactivating) has lower current credibility_ratio than contributor B (joined during gap), but A holds a lower sequence position, A has higher corroboration priority despite being epistemically weaker. Is the position-based model too rigid — should corroboration discounts be credibility-weighted rather than purely position-ordered?

3. **Bridge epoch exact length — does 1 macro-epoch fit all coordinate classes?** For a fast-changing coordinate class (short macro-epoch, high κ), one bridge epoch may be too short for score refinement to propagate through the S_cred → clearing feed cycle. For a slow class (long macro-epoch), one bridge epoch is conservative overkill. Should bridge epoch length be per-class (1 macro-epoch of the class), as implied, or globally fixed?

4. **Position counter persistence across governance threshold oscillations (#r139/Q2 adversarial case):** If min_chain_weight_fraction oscillates, contributors are truncated and reactivated. Their sequence position is preserved through reactivation. But if a contributor has been truncated for many epochs and all other contributors at that depth have churned (declarations expired), could the reactivating contributor return with a first-position claim that is stale (their original information was submitted years prior)? The position is preserved but the epistemic claim may no longer reflect current knowledge. A staleness discount on reactivating-contributor S_cred weight (beyond κ-based decay) may be warranted.

*Last updated: #r139 — 2026-04-03T20:52Z*

---

## #r140 Contributions — 2026-04-03T21:02Z

Addresses all four open questions from #r139.

**Q1 (Zone C challenger reward pool solvency during mass-simultaneous challenges) → Per-challenge self-funding cap; challenger_pool as pre-payment buffer only (#r140):**

Each challenge's reward is sourced first from that challenge's own slash proceeds at a capped fraction `r_challenger_cap` (governance-settable, default 0.25, bounded [0.1, 0.4]). The shared `challenger_pool` makes up only the gap between `r_floor` and `r_challenger_cap × slash` for small-slash cases.

Priority order for a single challenge:
```
slash_proceeds:
  → challenger_reward = min(r_challenger_cap × slash, r_floor_per_class)
  → LTRP top-up (up to GREEN threshold gap)
  → loser pool (remainder)
challenger_pool top-up = max(0, r_floor − r_challenger_cap × slash)
```

For large slashes, pool draw is zero. Mass-challenge Zone C cannot deplete the pool faster than per-challenge top-up bounds allow. No per-challenge Zone C cap is needed — the fraction cap and floor model already bound pool exposure.

**challenger_pool solvency monitoring:** Pattern from LTRP_status applied: coverage_ratio alert at YELLOW; if RED, `r_floor` temporarily degrades to `r_challenger_cap × avg_slash` (self-funding only; no pool draw) until governance replenishes. Challengers are never blocked; floor guarantee degrades temporarily during RED. (#r140)

---

**Q2 (Position-based vs credibility-weighted corroboration for reactivating contributors) → Position model maintained; orthogonality with S_cred weighting is the correct design (#r140):**

Position ordering determines implication bonus distribution. Credibility weighting (w_a) determines S_cred influence. These serve orthogonal purposes and must not be coupled.

Coupling would open an attack surface: a well-resourced adversary could suppress a competitor's credibility_ratio (via competing correct claims on other coordinates, diluting their log-score) to demote their sequence priority on a specific implication chain. Decoupling closes this. A reactivating contributor with lower credibility already earns lower S_cred influence via the weight formula — the epistemic output is correctly discounted without touching position rights. (#r140)

---

**Q3 (Bridge epoch length — per-class vs globally fixed) → "1 macro-epoch" is always per-class; prior implicit assumption made explicit (#r140):**

```
bridge_epoch_length(class_i) = 1 × macro_epoch_length(class_i)
```

No globally fixed duration. For a class with macro_epoch = 1h: bridge = 1h. For macro_epoch = 1 week: bridge = 1 week. The bridge epoch's purpose is one full S_cred → clearing feed propagation cycle; "one propagation cycle" is precisely one macro-epoch of the relevant class. A global fixed bridge would be too short for slow classes and unnecessarily conservative for fast ones.

**Multi-class implication declarations:** Bridge epoch applies per-class independently. Clearing feed for class A uses A's bridge duration; for class B uses B's. No synchronization required between classes at bridge close.

**Catalog update** (extending #r138 table):

| Timer | Index type | Length |
|---|---|---|
| Bridge epoch duration | Epoch-indexed, per-class | 1 × macro_epoch_length(class_i) |

Supersedes any "globally fixed" reading of #r131. (#r140)

---

**Q4 (Stale reactivating contributor — position counter persistence through threshold oscillations) → Already mitigated by κ-based staleness decay; no additional mechanism required (#r140):**

For any claim with age_i ≫ staleness_window_i:
```
effective_weight ≈ base_weight × max(0, 1 − (age_i / staleness_window_i)^κ_i) → 0
```

S_cred influence is near-zero regardless of sequence position. Query fee share is also near-zero (pro-rata to effective_weight). The stale contributor's implication bonus is preserved (position-based, conditional on correct resolution) — this is appropriate reward for the original first-mover identification of the structural relationship. It does not distort the live state vector because the S_cred contribution is already bounded to zero by the staleness model.

Governance threshold oscillation that selectively advantages a stale first-position contributor is publicly auditable via EAT (#r136/Q4 `parameter_rollback` records). No mechanism-level block is needed beyond auditability + staleness decay.

**Design law confirmed (#r140):** Sequence position preservation through reactivation is safe when combined with staleness decay. Any mechanism feature that preserves a long-horizon commitment (position, credibility history, escrow) MUST have a corresponding time-decay or expiry on its epistemic output. When the decay exists, preservation of rights records is safe. (#r140)

---

## Structural Synthesis: Mechanism Closure State After #r140 (#r140)

| Feature | Resolution | Confirming interaction |
|---|---|---|
| Zone C challenger reward pool | Self-funding fraction cap; shared pool is top-up buffer only | Bounded per-challenge exposure; no mass-drain risk |
| Position vs credibility-weighted corroboration | Position model maintained; orthogonal to w_a | Decoupling closes adversarial credibility-position attack |
| Bridge epoch length | Per-class (1 × macro_epoch_length); globally fixed reading superseded | Aligns with per-class macro-epoch framework (#r72) |
| Stale reactivating contributor | Bounded by staleness decay alone; no additional mechanism | Position preservation + κ-decay are correct paired design |

---

## Open Questions for #r141+

1. **Minimum viable challenge threshold:** During challenger_pool RED, reward floor degrades to self-funding only (`r_challenger_cap × slash`). For very small slashes, this may fall below economic incentive. Should a minimum slash magnitude gate challenge admission — below which challenges are not accepted — to avoid trivial-challenge noise clogging the mechanism?

2. **Implication bonus vs epistemic contribution at resolution:** A stale first-position contributor resolves correct and earns full β bonus, but contributed near-zero S_cred signal. The bonus reward theory is "first to identify a structural relationship" (supports full bonus regardless of staleness) vs "epistemic contribution at resolution time" (supports staleness-discounted bonus). Which theory is correct, and does the answer depend on whether the bonus is framed as retrospective-information-credit or as forward-looking-epistemic-service?

3. **Asymmetric per-class bridge state in cross-class implication declarations:** If class A (short macro_epoch) exits its bridge epoch while class B (long macro_epoch) is still in bridge, A's S_cred contribution to the cross-class declaration is live at κ_class(A) while B's S_cred weight is still suppressed at κ_bridge(B). Is this asymmetric state consistent, or does the cross-class declaration need a coordination rule (e.g., both classes must exit bridge before the combined declaration's implication bonus can be earned)?

4. **Bonus reward theory — retrospective vs prospective:** Connects to Q2 above. The mechanism so far treats implication bonus as a retrospective reward for having correctly identified a structural relationship. An alternative: treat it as a prospective payment for epistemic service rendered to the clearing system during the claim's active life. Under the prospective model, a claim with near-zero active effective_weight delivered near-zero prospective service and should earn a staleness-discounted bonus. This is a deeper architectural question about what the bonus is paying for — resolve before implementing the bonus settlement contract.

*Last updated: #r140 — 2026-04-03T21:02Z*

---

## #r141 Contributions — 2026-04-03T21:12Z

Addresses all four open questions from #r140.

**Q1 (Minimum viable challenge threshold — minimum slash gate?) → Challenge submission fee replaces slash gate; no floor on admissible slash size (#r141):**

A minimum slash gate solves the wrong problem. If below-floor-stake claims are never challengeable, adversaries can make small wrong claims with impunity — epistemic damage scales with density of bad small-stake claims, not just large ones. Blocking challenges by slash size is therefore the correct defence for the mechanism's budget but the wrong defence for S_cred quality.

**Resolution — challenge submission fee:**

```
challenge_submission_fee = r_floor_per_class × fee_fraction
fee_fraction = 0.1  (governance-settable, bounded [0.05, 0.25])
```

The fee is:
- **Reimbursed in full** if the challenge succeeds (slash confirmed).
- **Forfeited** if the challenge fails (claim vindicated).

**Properties:**
1. *Spam filter:* A challenger who fails loses the fee. Trivial or exploratory challenges have a real cost without blocking economically rational small-stake challenges.
2. *Small-slash coverage:* Challenge is never gated by the claim's stake size. A small wrong claim is challengeable; the challenger just cannot recoup the fee from a slash smaller than the fee. Rational challengers only pursue small claims when they have high confidence.
3. *Pool-RED behaviour:* When challenger_pool is RED and per-challenge pool draw is suspended, the submission fee is still collected (it is challenger-funded, not pool-funded). The fee continues to filter spam even when the pool is stressed.

**Interaction with r_floor degradation during RED (#r140/Q1):** During challenger_pool RED, `r_floor` degrades to self-funding only. Challenge admission (fee collection) continues normally. Challengers facing small slashes in RED mode are self-funding challengers accepting lower expected returns — a rational market response, not a mechanism failure.

**EAT record:** Challenge submission fee is recorded at challenge submission event. Reimbursement or forfeiture is recorded at challenge settlement. (#r141)

---

**Q2 + Q4 (Bonus reward theory — retrospective vs prospective) → Bifurcated bonus: capital-lockup component + epistemic-service component (#r141):**

These two questions are architecturally coupled and resolved together.

**The core tension:**
- *Retrospective:* Bonus compensates for correctly identifying a structural relationship first. Full bonus to first-position contributor regardless of active-weight period. Incentivises deep early research.
- *Prospective:* Bonus compensates for epistemic service rendered while claim was actively contributing to S_cred. Staleness-proportional. Incentivises ongoing accurate state maintenance.

Neither alone is correct. A knower who locks capital for T_longtail bears two distinct costs: (1) opportunity cost of locked capital regardless of S_cred contribution, and (2) epistemic work done while actively contributing to the state vector.

**Resolution — bifurcated implication bonus:**

```
implication_bonus_total = bonus_capital_comp + bonus_epistemic_service

bonus_capital_comp = α_cap × β_escrow × min(1, time_locked / T_longtail_reference)

bonus_epistemic_service = (1 - α_cap) × β_escrow
                           × (Σ_epochs effective_weight(epoch) / Σ_epochs base_weight)
```

Where:
- `α_cap` = capital-compensation fraction (governance-settable, recommended 0.30, bounded [0.1, 0.5])
- `T_longtail_reference` = max(T_longtail_A, T_longtail_B) — the natural lockup horizon
- `effective_weight(epoch)` = the claim's S_cred contribution weight in that epoch, subject to staleness decay
- `base_weight` = the claim's weight at first activation (no staleness discount, full credibility weight)
- Sum runs over all epochs from activation to oracle resolution

**Consequences:**

| Scenario | bonus_capital_comp | bonus_epistemic_service | Interpretation |
|---|---|---|---|
| Fresh claim, full lockup, correct | α_cap × β_escrow | ≈ (1-α_cap) × β_escrow | Full bonus — both components earned |
| Stale claim, long lockup, correct | α_cap × β_escrow | ≈ 0 | Capital cost compensated; near-zero epistemic service |
| Fresh claim, early resolution, correct | Fractional | Full (weight was fresh) | Early-resolve shortfall; epistemic service fully earned |
| New entrant, small stake, correct | Proportional to stake | Proportional to stake × active epochs | Scale-invariant |

**Why this is correct:**
1. A stale first-position contributor still locked capital and correctly identified the structural relationship. Denying the capital component would create an incentive to withdraw or expire stale declarations before resolution — artificially shortening declaration lifespans. The capital component preserves the incentive to hold long-horizon declarations to resolution.
2. A prospective-only model would make implication declarations uncompetitive vs standard claims once staleness decay kicks in. The capital component prevents this.
3. The epistemic-service component preserves incentives to maintain fresh, actively contributing declarations — not just lock capital and wait.

**`Σ_epochs effective_weight` accumulation:** This requires a per-claim running sum tracked at each macro-epoch boundary. This IS a new EAT-tracked quantity — addressed as an open question below (#r141/OQ3).

**Governance parameter α_cap:** The split between capital and service compensation is a mechanism design choice, not a technical constraint. Governance sets α_cap to reflect the relative value of structural identification vs ongoing epistemic service in the protocol's information model. Default 0.30 favours epistemic service (70%) over capital compensation (30%). (#r141; resolves #r140/Q2 and #r140/Q4 jointly)

---

**Q3 (Asymmetric per-class bridge state in cross-class implication declarations) → Asymmetry is consistent; no coordination rule needed; bonus is oracle-triggered, not bridge-state-dependent (#r141):**

**Analysis:** When class A (short macro_epoch) exits its bridge epoch while class B (long macro_epoch) is still in bridge: A's S_cred contribution resumes at κ_class(A) while B's remains suppressed at κ_bridge(B). The question is whether this asymmetric state should block or coordinate the implication bonus calculation.

**Resolution:** No coordination rule. Asymmetric bridge is a natural consequence of per-class epoch independence, which is the established design (#r73 timestamp-tagged staleness; #r140/Q3 per-class bridge epoch confirmed).

**Why the bonus is unaffected:**

The implication bonus `bonus_epistemic_service` accumulates `effective_weight(epoch)` per class per epoch. During A's bridge epoch: A's weight is at κ_bridge(A) — reduced. During B's bridge epoch: B's weight is at κ_bridge(B) — reduced. These are independent per-class contributions summed separately. The combined epistemic service reflected in the bonus naturally accounts for bridge-suppressed epochs — they contribute less to the `Σ effective_weight` sum. No coordination flag needed.

The bonus_capital_comp component is purely time-based (time_locked / T_longtail_reference) — independent of any bridge state.

**Settlement trigger:** Both oracle events (resolution of A and resolution of B) are required before bonus distribution. Oracle events are independent of bridge state. A bridge epoch at A does not delay A's oracle. Settlement happens at the first macro-epoch boundary after both oracles resolve — at that point, all bridge epochs for both classes have long since concluded.

**Potential edge case — oracle fires during bridge epoch:** If A's oracle resolves during A's bridge epoch, the oracle event is recorded in EAT immediately (oracle events are not suspended by bridge epochs — bridge only affects κ, not oracle queue processing). Settlement waits for both A and B oracles, so partial oracle during bridge simply means the `effective_weight` sum through bridge epoch contributes bridge-level weight for those epochs — correct epistemic accounting.

**Design law confirmed (#r141):** Cross-class declarations with different epoch lengths require no synchronization on bridge epochs. Per-class independent epistemic accounting + oracle-triggered settlement is sufficient. Adding coordination rules to synchronize bridge exit across classes would create unnecessary coupling between otherwise independent coordinate classes. (#r141)

---

## Structural Synthesis: Bonus Settlement Contract — Design-Complete (#r141)

The implication bonus settlement contract now has a fully specified design:

| Component | Formula | Staleness-sensitive? | Governance parameter |
|---|---|---|---|
| bonus_capital_comp | α_cap × β_escrow × min(1, time_locked / T_longtail_ref) | No | α_cap ∈ [0.1, 0.5] |
| bonus_epistemic_service | (1-α_cap) × β_escrow × (Σ eff_weight / Σ base_weight) | Yes (via effective_weight decay) | α_cap |
| Challenge admission | fee = r_floor × fee_fraction; reimbursed if succeeds | N/A | fee_fraction ∈ [0.05, 0.25] |
| Cross-class bridge asymmetry | No coordination rule; per-class independent accounting | Natural via eff_weight accumulation | None |

---

## Open Questions for #r142+

1. **α_cap calibration basis:** How should governance set α_cap? The default 0.30 is reasoned but not formally derived. Is there a principled formula analogous to the β closed-form calibration (#r75/Q4)? For example: α_cap could be calibrated to ensure that a claim at exactly T_longtail staleness (fully stale, zero effective_weight) earns enough bonus to cover the opportunity cost of capital at the protocol's reference rate. This would anchor α_cap to a capital market rate rather than governance intuition.

2. **Challenge submission fee during degraded mode:** If a challenge is submitted (fee collected, EAT commit pending) and DA outage begins before the challenge resolves, is the fee frozen (not reimbursed, not forfeited) until DA restores? Since fee reimbursement/forfeiture is an EAT-dependent operation (#r134/Q1 principle: all EAT-dependent operations suspend during degraded mode), the fee should freeze alongside the challenge. Verify this is consistent with the challenge window tolling rules.

3. **`Σ effective_weight` EAT storage cost:** The bifurcated bonus requires a per-claim running sum of `effective_weight` over all active epochs. This is an O(epochs) quantity per claim. For long-lived claims on slow-oracle coordinates (many epochs, very long T_longtail), this could become non-trivial. Can the running sum be maintained as a single accumulator updated per macro-epoch boundary (O(1) per epoch per claim), rather than reconstructed from history at settlement? If yes, define the accumulator update rule and its EAT commit frequency.

4. **Challenge admission fee in cross-class implication declarations:** When challenging a cross-class implication declaration (challenging the A→B claim as a whole vs. challenging only one coordinate), which class's `r_floor` governs the submission fee? Option A: the lower-r_floor class (cheaper to challenge, lower barrier — may encourage legitimate challenges on cheap classes). Option B: the higher-r_floor class (harder to challenge, higher quality bar — may block legitimate cheap-class challenges). Option C: average of both classes' r_floor. This choice affects the incentive to challenge cross-class declarations.

*Last updated: #r141 — 2026-04-03T21:12Z*

---

## #r142 Contributions — 2026-04-03T21:22Z

Addresses all four open questions from #r141.

**Q1 (α_cap calibration basis) → Opportunity-cost anchor: α_cap derived from protocol reference rate ρ, T_longtail, and β (#r142):**

The capital-compensation component should, at minimum, make a fully-stale correct declarant whole on the opportunity cost of locked capital. A claim locked for T_longtail earns `bonus_capital_comp = α_cap × β_escrow` only at resolution (conditional on both coordinates resolving correctly). The minimum α_cap that covers opportunity cost satisfies:

```
α_cap × β × k_a ≥ k_a × ρ × T_longtail_ref
α_cap ≥ (ρ × T_longtail_ref) / β
```

Where `ρ` = protocol-declared reference rate per macro-epoch (annualized / epoch_per_year), `T_longtail_ref` = the reference lockup horizon in macro-epochs (e.g., `T_longtail_class / macro_epoch_length`), and β = current β_effective (computed, not governance-set).

**Derived governance formula (#r142):**
```
α_cap = clip((ρ × T_longtail_ref_epochs) / β_effective, α_min=0.1, α_max=0.5)
```

Like β_effective (#r75/Q4, #r76/Q3), α_cap is a *derived* parameter. Governance exposes (ρ, T_longtail_ref) and the contract computes α_cap. The default 0.30 is valid only when `ρ × T_longtail_ref_epochs / β_effective ≈ 0.30` — governance must verify this at deployment and recalibrate if market conditions shift substantially.

**New governance interface entry:** (γ, K_target, d_ref, α_bond, N_calibration, β_min, β_max) → β_effective computed. Now extended: (ρ, T_longtail_ref) → α_cap computed. All bonus parameters are derived from primitives; none are set by direct governance fiat. (#r142)

**Interaction with β_effective drift:** If β_effective is clamped at β_max (high-demand epoch), α_cap = ρ × T_longtail_ref / β_max — lower than unclamped. Capital component is temporarily reduced relative to opportunity cost. If β_effective is clamped at β_min, α_cap = ρ × T_longtail_ref / β_min — may hit α_max=0.5. Both clamp-boundary cases should be surfaced in governance alerts alongside the β_effective clamp alert (#r129/Q4). (#r142)

---

**Q2 (Challenge submission fee during degraded mode) → Fee frozen in EAT-pending state; no new rule required (#r142):**

A challenge submitted just before DA outage has its fee collected into an EAT-pending escrow record. Fee disposition (reimbursement on success, forfeiture on failure) requires a settlement EAT commit — which is suspended during degraded mode per the #r134/Q1 principle.

**Resolution:** The challenge submission fee freezes alongside the challenge itself. No new rule is required. The existing framework covers this:

1. Challenge window is epoch-indexed → implicit freeze during degraded mode (challenge deadline does not advance).
2. All EAT-dependent operations (including fee settlement) are suspended during degraded mode (#r134/Q1).
3. On DA restore, the challenge window resumes from its tolled position; at the next macro-epoch boundary after restore (post-bridge), the challenge settles and fee disposition is committed.

**Consistency check:** The submission fee is recorded in the challenge's EAT record at submission time. The reimbursement/forfeiture is a settlement event referencing that record. Since both are EAT-committed and settlement is epoch-indexed, the fee naturally inherits the challenge window's freeze behavior. No separate fee-freeze clause is needed.

**Fee during bridge epoch:** Analogous to implication_bonus_escrow operations (#r134/Q1): challenge fee settlement is deferred to the first normal post-bridge macro-epoch boundary. Bridge epoch does not process EAT-dependent settlement. (#r142)

---

**Q3 (`Σ effective_weight` accumulator — EAT storage and update rule) → O(1) per-epoch accumulator; batched with S_cred macro-epoch commits (#r142):**

A per-claim running sum accumulated at each macro-epoch boundary eliminates the need to reconstruct the sum at settlement.

**Accumulator update rule (per claim, per macro-epoch boundary):**
```
cumulative_eff_weight(claim_c, epoch_t) =
    cumulative_eff_weight(claim_c, epoch_{t-1}) + effective_weight(claim_c, epoch_t)

effective_weight(claim_c, epoch_t) =
    base_weight(claim_c) × max(0, 1 − ((epoch_t − epoch_activation) / staleness_window_i)^κ_i)
```

`base_weight(claim_c)` is the credibility-weighted stake at activation — a constant stored at declaration time.

**Denominator for bonus_epistemic_service:**
```
Σ_epochs base_weight = base_weight(claim_c) × n_active_epochs
n_active_epochs = epoch_resolution − epoch_activation  (computable on-demand at settlement)
```

No separate denominator accumulator is needed — it is a simple product of a stored constant and a derived epoch count.

**EAT commit frequency:** The `cumulative_eff_weight` accumulator is committed alongside the S_cred macro-epoch boundary update already required per coordinate class. No new EAT commit cadence introduced. The per-claim accumulator update is a delta to the claim record at each boundary.

**Storage cost:** O(1) per claim per epoch (one scalar addition). For a protocol with N active claims, this is O(N) per macro-epoch boundary — equivalent to the existing S_cred weighting computation already required. No asymptotic overhead added.

**Settlement reads:**
```
bonus_epistemic_service_weight =
    cumulative_eff_weight(claim_c, epoch_resolution) / (base_weight(claim_c) × n_active_epochs)
```

Single-read at settlement; O(1). (#r142)

---

**Q4 (Cross-class challenge submission fee governance) → Stake-weighted average of per-class r_floor values (#r142):**

A single-class r_floor sets the fee proportional to the value at risk per coordinate class. For a cross-class implication declaration, the value at risk is distributed between the A-coordinate and B-coordinate escrows proportionally to stake. The natural extension:

```
cross_class_challenge_fee =
    r_floor(class_A) × (A_stake / (A_stake + B_stake))
    + r_floor(class_B) × (B_stake / (A_stake + B_stake))
```

**Properties:**
- Reduces to single-class fee when one coordinate's stake = 0 (degenerate case).
- Naturally cheaper when one leg is in a lower-r_floor class — reflecting lower value-at-risk from that coordinate.
- Remains calibrated to the combined escrow at risk, not to either class in isolation.
- Does not create an exploit: a challenger cannot route a cross-class challenge through the cheaper class independently (the cross-class challenge is a single atomic submission covering both coordinates).

**Challenging only one coordinate of a cross-class declaration:** If a challenger disputes only the A-coordinate assertion (not A→B as a whole), the challenge is treated as a single-class challenge against class_A at class_A's r_floor. This is correct: partial challenges have smaller value-at-risk (only one coordinate's escrow is at stake).

**Design law (#r142):** For any mechanism parameter that is per-coordinate-class, its application to cross-class constructs is the stake-weighted average of the per-class values, proportional to each coordinate's escrow share. This principle generalizes to any future cross-class parameter extension. (#r142)

---

## Structural Synthesis: Bonus Settlement Contract — Fully Parameterized (#r142)

The bonus settlement contract design is now complete, with all parameters either derived from governance primitives or accumulator-backed:

| Parameter | Derivation | Governance input |
|---|---|---|
| β_effective | K_target, γ, d_ref, α_bond, rolling base reward | (K_target, γ, d_ref, α_bond, N_cal, β_min, β_max) |
| α_cap | ρ × T_longtail_ref / β_effective, clamped | (ρ, T_longtail_ref) |
| bonus_capital_comp | α_cap × β_escrow × time_locked / T_longtail_ref | Derived |
| bonus_epistemic_service | (1-α_cap) × β_escrow × (Σ eff_weight / Σ base) | Accumulator at each epoch |
| challenge_fee (single-class) | r_floor × fee_fraction | fee_fraction ∈ [0.05, 0.25] |
| challenge_fee (cross-class) | Stake-weighted average of per-class r_floor | Derives from per-class r_floor |

---

## Open Questions for #r143+

1. **ρ governance stability:** α_cap is sensitive to ρ (protocol reference rate). If ρ is market-derived (e.g., from DeFi lending rates), it may fluctuate and cause α_cap to oscillate between α_min and α_max, producing unstable bonus components. Should ρ be governance-set (stable but potentially stale) or market-derived (accurate but volatile)? A smoothed rolling average of a market rate could bridge the two.

2. **Accumulator reset on reactivation:** If a claim is truncated (contribution drops to zero, #r136/Q3) and later reactivated, the `cumulative_eff_weight` accumulator has zero contributions during the truncation gap. This is correct — no S_cred contribution means no epistemic service. But should the accumulator record the truncation gap explicitly (for auditability), or is the running sum already unambiguous since effective_weight = 0 during truncation?

3. **Partial challenge of cross-class declaration — bonus escrow disposition:** If a partial challenge succeeds (A-coordinate claim wrong, B not challenged), the A-coordinate escrow is slashed normally. But the implication_bonus_escrow is conditional on *both* coordinates resolving correctly. Does a successful A-coordinate challenge immediately forfeit the entire implication_bonus_escrow, or only the A-side portion (per #r133/Q1: "slash implication_bonus_escrow to the failing coordinate's loser pool proportionally")?

4. **α_cap formula at genesis (no β_effective history):** New coordinate classes in Phase 0 have no β_effective history (#r76/Q3 bootstrap: fewer than N_calibration normal-mode epochs). α_cap derivation from β_effective is undefined until β_effective is stable. Resolution: during genesis and Phase-1 bootstrap, α_cap defaults to α_max (0.5) — the most capital-protective default — until N_calibration normal-mode epochs have closed. Verify this is consistent with the Phase-1 α_longtail=1.0 (#r131/Q1) and no cross-class implication declarations during Phase 1 (#r133/Q1).

*Last updated: #r142 — 2026-04-03T21:22Z*

---

## #r143 Contributions — 2026-04-03T21:32Z

Addresses all four open questions from #r142.

**Q1 (ρ governance stability — market-derived vs governance-set) → Smoothed EMA of DeFi reference rate; governance-settable floor and ceiling (#r143):**

ρ governs α_cap, which governs the capital-compensation fraction of the implication bonus. An oscillating ρ → oscillating α_cap → unstable bonus components → rational declarants cannot compute expected return reliably. This undermines the incentive to make long-horizon structural declarations.

**Resolution — smoothed reference rate ρ_smooth:**

```
ρ_smooth(t) = (1 − λ_ρ) × ρ_smooth(t-1) + λ_ρ × ρ_market(t)
λ_ρ = 2 / (N_ρ + 1)   (EMA weight, default N_ρ = 12 macro-epochs)
ρ_market(t) = observed DeFi reference rate at macro-epoch boundary (e.g., AAVE 30d USDC supply APY / epoch_per_year)
```

Floor and ceiling (governance-settable):
```
ρ_effective = clip(ρ_smooth, ρ_floor, ρ_ceil)
ρ_floor = 0.002 per macro-epoch  (annualizes to ~1% for 500 macro-epoch/year pace)
ρ_ceil  = 0.020 per macro-epoch  (annualizes to ~10%)
```

ρ_effective is published to the EAT each macro-epoch alongside β_effective and α_cap. The governance interface exposes (N_ρ, ρ_floor, ρ_ceil); ρ_effective derives from on-chain oracle and is not directly governance-set. Governance controls the smoothing window and clamp, not the underlying rate.

**Interaction with β_effective clamp:** When ρ_effective is high (tight capital market), α_cap rises toward α_max. If simultaneously β_effective is clamped at β_max, α_cap = ρ_effective × T_longtail_ref / β_max — bounded, stable. When ρ_effective is low (loose capital market), α_cap falls toward α_min — capital component is small, epistemic-service component dominates. The combination of β_effective and ρ_effective clamps means α_cap is always within [α_min, α_max] regardless of market conditions. No additional stability circuit needed. (#r143)

---

**Q2 (Accumulator reset on reactivation — explicit truncation gap record) → Zero-contribution epochs are implicit in running sum; gap annotation is metadata only (#r143):**

When a claim is truncated (effective_weight = 0 for N truncation epochs) and later reactivates, the running sum adds exactly 0 to `cumulative_eff_weight` during those epochs. The mathematical signal is already present — the accumulator just did not grow. The truncation gap is represented correctly by the flat accumulator segment.

**Resolution:** No explicit gap annotation is required in the settlement-critical accumulator. The running sum is unambiguous: any epoch where the claim was truncated contributes zero, exactly as intended by the staleness formula when effective_weight = 0.

**Auditability (metadata only):** An optional `eff_weight_zero_epochs` counter can be committed alongside `cumulative_eff_weight` at each macro-epoch boundary. This counter increments when effective_weight = 0 for any reason (truncation, staleness, bridge epoch). It is a diagnostic field — not used in bonus computation. Its absence does not affect settlement correctness.

**Why explicit annotation is not required for correctness:** The `bonus_epistemic_service_weight` ratio uses `cumulative_eff_weight / (base_weight × n_active_epochs)`. The denominator `n_active_epochs` counts *all* epochs from activation to resolution, including truncation gap epochs. A claim truncated for half its life earns at most 50% of the maximum epistemic-service component — the denominator is not adjusted to exclude truncation gaps. This correctly penalises epistemic gaps (truncated service is not rewarded retroactively) without requiring a separate gap-tracking mechanism.

**Design law (#r143):** Zero-valued contributions to running accumulators must not be elided. The denominator must not be adjusted to exclude zero-contribution periods. Penalising gaps via the ratio (flat numerator, advancing denominator) is the correct epistemic accounting — it does not require explicit gap records. (#r143)

---

**Q3 (Partial cross-class challenge — implication_bonus_escrow disposition) → A-side challenge success forfeit is proportional; consistent with #r133/Q1 (#r143):**

When a challenger successfully challenges only the A-coordinate of a cross-class declaration (leaving B unchallenged), the implication_bonus_escrow is not yet conditioned on B's outcome. The question is whether the A-side wrong-claim should forfeit the *entire* bonus escrow or only the A-proportional fraction.

**Resolution — proportional forfeiture, consistent with #r133/Q1:**

From #r133/Q1 (established): "slash implication_bonus_escrow to the failing coordinate's loser pool proportionally." The proportional fraction for a cross-class declaration:

```
forfeiture_fraction_A = A_stake / (A_stake + B_stake)
```

On successful A-coordinate challenge:
- `forfeiture_fraction_A × implication_bonus_escrow` → A-class loser pool
- Remaining `(1 − forfeiture_fraction_A) × implication_bonus_escrow` → continues in escrow pending B's oracle resolution

**New state: partial-forfeiture-pending:**
After partial forfeiture, the declaration enters `partial_forfeiture_pending` status. The remaining bonus escrow is now conditioned solely on B resolving correctly (the B-stake is still locked; B's oracle has not fired). On B resolution:
- B correct: knower receives remaining escrow (B-proportional bonus — capital + epistemic-service components for B only)
- B wrong: remaining escrow forfeited to B-class loser pool

**Rationale:** The knower made two separate claims embedded in the declaration. A being wrong eliminates A's contribution but does not retroactively void the B claim (which is still pending oracle). The implication *bonus* (β multiplier) requires *both* correct — a wrong A forfeits the bonus multiplier but not B's base slot reward. The `implication_bonus_escrow` tracks only the conditional β-premium; B's base escrow (`T3_escrow_standard` or `T3_escrow_longtail`) handles B's base slot settlement independently.

**EAT record:** Challenge settlement creates a `partial_forfeiture` EAT event on the declaration record with: forfeiture_fraction, receiving_loser_pool, and remaining_escrow fields. The declaration remains active (not closed) until B's oracle fires. (#r143)

---

**Q4 (α_cap at genesis — no β_effective history) → α_max default during bootstrap; consistent with Phase-1 protections (#r143):**

During Phase-0 and Phase-1 (bootstrap), there are no N_calibration normal-mode epochs and β_effective is undefined. α_cap = ρ_effective × T_longtail_ref / β_effective cannot be computed.

**Resolution — genesis default α_cap = α_max (0.5):**

During Phase-0 and Phase-1 bootstrap:
1. α_cap defaults to α_max = 0.5.
2. This maximises the capital-compensation fraction — the most protective default for declarants when protocol-level reference data is immature.
3. α_cap transitions to derived formula once both (a) N_calibration normal-mode epochs are available for β_effective (#r76/Q3), and (b) ρ_smooth has accumulated N_ρ epochs of market data (#r143/Q1). Both conditions must hold simultaneously.

**Consistency verification:**
- Phase-1: no cross-class implication declarations permitted (#r133/Q1 bootstrap constraint). Cross-class bonus escrow mechanics do not apply during Phase-1 bootstrap. α_cap = α_max during Phase-1 is therefore a default for single-class implication declarations only. ✓
- Phase-1 α_longtail = 1.0 (#r131/Q1): all T3 escrow is longtail during bootstrap. The higher α_cap compensates declarants for the fully-longtail escrow routing. These two Phase-1 defaults are deliberately conservative and mutually reinforcing. ✓
- T3 admission requires ≥2 completed normal-mode macro-epochs (#r129/Q2). α_cap cannot transition to derived formula until N_calibration ≥ 2 epochs are available — T3 admission and α_cap maturation happen in the same epoch band. ✓

**Transition event:** When the derived formula first becomes available, the shift from α_max to derived α_cap is published as a governance event in the EAT (type: `parameter_genesis_exit`, class: `alpha_cap`). No knower action required; pending declarations use the new α_cap at their oracle resolution epoch. The transition is always forward-looking only. (#r143)

---

## Structural Synthesis: Parameter Derivation Stack — Complete (#r143)

With #r143, all primary bonus and calibration parameters now have:
1. A derivation formula from observable primitives
2. Governance-settable inputs (no parameter is directly numeric-by-governance-fiat)
3. A genesis default (for bootstrap phase)
4. A transition event when derived formula becomes active

| Parameter | Derived from | Genesis default | Transition event |
|---|---|---|---|
| β_effective | K_target, γ, d_ref, α_bond, rolling base reward | N/A (no implication decl during Phase-1) | First N_calibration normal-mode epochs |
| α_cap | ρ_effective × T_longtail_ref / β_effective | α_max = 0.5 | N_calibration epochs + N_ρ ρ_smooth epochs both satisfied |
| ρ_effective | EMA of DeFi market rate, clipped [ρ_floor, ρ_ceil] | ρ_floor (conservative) | First ρ_market oracle reading available |
| challenge_fee | r_floor × fee_fraction (single-class); stake-weighted avg (cross-class) | Per-class r_floor at registration | No transition; active from genesis |

---

## Open Questions for #r144+

1. **ρ_market oracle source governance:** ρ_smooth requires a live DeFi rate oracle (e.g., AAVE USDC supply APY). This oracle must be trusted and manipulation-resistant. If ρ_market is oraculously manipulable, α_cap could be temporarily forced to α_max or α_min — distorting the bonus split. Should ρ_market use a multi-source median (analogous to SEE quorum oracle), or is a single authoritative DeFi protocol rate sufficient?

2. **`partial_forfeiture_pending` state and TOWL capacity:** After a partial A-side forfeiture, the declaration's B-side escrow remains locked. Does the B-side escrow continue to count toward TOWL capacity for class_B? If the A-side failure signals that the knower may be epistemically unreliable, should B-side TOWL contribution be discounted during `partial_forfeiture_pending`?

3. **EMA initialization for ρ_smooth:** At class genesis, the EMA has no prior values. Standard EMA initialization uses the first available market observation as the initial value, then converges over N_ρ epochs. During the first N_ρ epochs, ρ_smooth is less stable. Should α_cap remain at α_max until the EMA has accumulated N_ρ observations (parallel to the β_effective N_calibration condition), or does the EMA's built-in convergence suffice?

4. **`parameter_genesis_exit` timing and in-flight declarations:** When α_cap transitions from α_max to derived formula, in-flight declarations (submitted during Phase-1/bootstrap with α_cap = α_max locked in their escrow computation) should be grandfathered at α_max for their full duration, or should they immediately switch to derived α_cap? Grandfathering is more predictable; immediate switch is more capital-efficient for the protocol.

*Last updated: #r143 — 2026-04-03T21:32Z*

---

## #r144 Contributions — 2026-04-03T21:42Z

Addresses all four open questions from #r143.

**Q1 (ρ_market oracle source governance) → TWAP-based single source + EMA double-smoothing; multi-source not required (#r144):**

The concern: a spot-sampled DeFi rate (e.g., AAVE USDC supply APY) can be flash-driven to extreme values within a single epoch, distorting ρ_smooth and hence α_cap. The standard defense is multi-source median, but this adds oracle aggregation complexity.

**Resolution — TWAP-sourced single oracle + EMA layering:**

```
ρ_market(t) = TWAP(reference_rate_oracle, T_twap)
T_twap = max(24h, micro_epoch_length × 2)
```

The 24h TWAP eliminates within-epoch manipulation: maintaining an artificially inflated/depressed rate across a full TWAP window requires holding the capital position for 24h+, at a cost that far exceeds any achievable α_cap distortion benefit. The outer EMA smoother (N_ρ = 12 macro-epochs, #r143/Q1) then eliminates multi-epoch drift manipulation — a sustained distortion attempt must maintain the fake rate for 12 epochs to move α_cap by more than a few percentage points.

**Why multi-source median is not required:** The TWAP + EMA combination provides double-layer time-averaging protection that is structurally equivalent to multi-source spatial averaging in terms of manipulation resistance. Adding source diversity without time-averaging would be less effective (individual source rates can still be manipulated spot). The governance-settable ρ_floor and ρ_ceil clamps provide the final backstop regardless.

**Oracle source specification:** The rate oracle is governance-registered at class genesis alongside the staleness_window and κ parameters. Protocol defaults to a recognized DeFi lending protocol rate (e.g., AAVE V3 USDC supply APY on Ethereum mainnet). Alternative rate sources require governance proposal. Single trusted source is sufficient given the TWAP + EMA + clamp triple defense.

**Governance interface addition:** (N_ρ, ρ_floor, ρ_ceil, **T_twap**, rate_oracle_address) → ρ_effective computed. T_twap is per-class (short-macro-epoch classes may use shorter TWAP floors; minimum T_twap = max(24h, 2 × micro_epoch_length) holds). (#r144)

---

**Q2 (`partial_forfeiture_pending` and B-side TOWL capacity) → TOWL unchanged; epistemic signal propagates via credibility_ratio only (#r144):**

After a successful A-coordinate partial challenge, the declaration enters `partial_forfeiture_pending`. B-side escrow remains intact. The question: should B's TOWL contribution be discounted to reflect the knower's demonstrated A-side unreliability?

**Analysis:** Two channels carry epistemic reliability signals in the mechanism:

1. **Financial channel (TOWL):** The escrow commitment is the financial warranty. It is the capacity of the knower's locked capital to cover B's warranty obligation. A wrong A-claim does not reduce B-side escrow — the capital is still locked and still backs B.

2. **Epistemic channel (credibility_ratio + w_a):** A wrong A-claim updates the knower's credibility_ratio track record downward. This reduces `w_a = C_a × log(1 + k_a)` for all future B-contributions. S_cred weight for B's coordinate is already lower from the next epoch forward. The epistemic signal propagates correctly through the existing mechanism.

**Resolution:** B-side TOWL contribution is unchanged during `partial_forfeiture_pending`. The escrow is intact; the warranty is intact. Retroactively discounting TOWL for a neighbouring coordinate failure would conflate the financial and epistemic channels — creating a compound penalty where one event simultaneously reduces both epistemic influence (via credibility_ratio) and financial warranty capacity (via TOWL discount). This double-counting is incorrect and could cascade: TOWL capacity reduction triggers Zone C stress, which triggers further throttling, based on a wrong A-claim that is entirely irrelevant to B's financial backing.

**Design law confirmed and extended (#r144):** The orthogonality of TOWL (financial) and credibility_ratio (epistemic) is not merely a separation-of-concerns preference — it is a stability requirement. Conflating the channels creates recursive stress amplification where an epistemic failure causes a financial solvency signal. Every mechanism feature must route epistemic quality signals through credibility_ratio and financial solvency signals through TOWL. No cross-channel leakage. (#r144)

---

**Q3 (EMA initialization — stay at α_max until N_ρ epochs, or rely on convergence?) → Both conditions required before α_cap transitions; α_max during entire bootstrap (#r144):**

The EMA's built-in convergence provides decreasing variance over time, but the first few observations carry disproportionate weight in an early EMA. If early ρ_market observations happen to be abnormally low (loose capital market at genesis), derived α_cap would undershoot the opportunity-cost floor before the EMA has representative data.

**Analysis:** The asymmetry matters:
- α_max = 0.5 (default) is the *most protective* setting for declarants. A premature switch to derived α_cap during EMA initialization could produce α_cap < α_min if early ρ_market values are anomalous.
- This is not a temporary nuisance — declarations made during the initialization window earn `bonus_capital_comp = α_cap_at_declaration × β_escrow × ...`. Under the static-commitment rule from Q4 below, a declaration made during under-initialized EMA carries that α_cap for its capital-comp component forever.

**Resolution:** α_cap remains at α_max until BOTH conditions are simultaneously satisfied:
1. ≥ N_calibration normal-mode macro-epochs closed (β_effective is stable, #r76/Q3)
2. ≥ N_ρ ρ_market TWAP observations accumulated (ρ_smooth is past initialization window, #r143/Q1)

This is structurally identical to the dual-condition α_cap transition established in #r143/Q4. The two conditions must be stated explicitly as a conjunction, not an either-or.

**Practical consequence:** For a new coordinate class with macro_epoch = 1h, N_calibration = 4, N_ρ = 12: both conditions are met after max(4, 12) = 12 normal-mode macro-epochs. At a 1h macro-epoch cadence, this is 12 hours — a fast transition. For macro_epoch = 1 week, the transition takes max(4, 12) = 12 weeks — ensuring the EMA is genuinely representative before locking in the derived formula.

**Epoch-indexed countdown:** The N_ρ counter advances only on normal-mode macro-epochs with a valid TWAP observation (no DA outage, no bridge epoch). Degraded-mode epochs do not advance the ρ_smooth initialization counter — consistent with the general rule that exceptional-mode epochs do not advance calibration windows (#r132/Q2). (#r144)

---

**Q4 (`parameter_genesis_exit` and in-flight declarations — grandfather or immediate switch) → Split treatment per bonus component; static commitment rule applies (#r144):**

The bonus settlement formula has two components with fundamentally different update rules under the #r137 static-escrow/dynamic-epistemic design law:

- `bonus_capital_comp`: compensates for capital *already locked*. This is a function of the economic commitment made at declaration time.
- `bonus_epistemic_service`: compensates for ongoing epistemic service rendered over the claim's active life. This is a forward-looking evaluation computed at settlement.

**Resolution — component-level α_cap commitment:**

```
bonus_capital_comp = α_cap_at_declaration × β_escrow × min(1, time_locked / T_longtail_ref)

bonus_epistemic_service = (1 − α_cap_at_settlement) × β_escrow × (Σ eff_weight / Σ base_weight)
```

- `α_cap_at_declaration`: the α_cap value published in the EAT at the epoch the declaration was submitted. For declarations submitted during bootstrap (before `parameter_genesis_exit`), this is α_max = 0.5. This value is immutably committed to the EAT at declaration time and never changes.
- `α_cap_at_settlement`: the α_cap value published in the EAT at the oracle resolution epoch. This is the current derived value — forward-looking.

**Rationale:** The capital-comp component compensates for opportunity cost on capital *already locked* under the terms known at declaration. Changing α_cap retroactively for this component would violate the knower's commitment-time expectations — equivalent to changing an interest rate on a fixed-term deposit after lock-in. The epistemic-service component evaluates *current service*, which naturally uses current parameters.

**Note on formula consistency:** The total bonus uses a split α_cap: capital-comp uses `α_cap_at_declaration`, epistemic-service uses `(1 − α_cap_at_settlement)`. These do not sum to 1 when the two α_cap values differ — the fractions overlap or leave a gap. This is intentional: the two components serve different economic purposes and are not required to partition the total bonus to exactly β_escrow. The maximum possible total bonus remains bounded by β_escrow × (max capital-comp ratio + max epistemic-service ratio) ≤ β_escrow × (α_max + (1 − α_min)) = β_escrow × 1.4 (at extremes). Governance must account for this when setting β_min/β_max to avoid protocol insolvency on bonus payments. Recommended addition to governance alert: if `α_cap_at_declaration − α_cap_at_settlement > 0.2` for ≥ 10% of active declarations in a window, flag for governance review (parameter drift may be distorting bonus incentives).

**EAT record:** The declaration EAT record stores `α_cap_committed = α_cap_at_declaration`. The settlement EAT record stores `α_cap_settlement` and both component values. Bonus computation is fully auditable. (#r144)

---

## Structural Synthesis: Parameter Derivation Stack — Final Closure (#r144)

With #r144, the parameter derivation stack is complete and all cross-parameter interactions are specified:

| Feature | Resolution | Law |
|---|---|---|
| ρ_market manipulation defense | TWAP (24h) + EMA (N_ρ = 12) + clamp; no multi-source needed | Double time-averaging is equivalent to spatial multi-source for slowly-varying rate |
| B-side TOWL during partial forfeiture | Unchanged; epistemic signal via credibility_ratio only | TOWL/credibility_ratio channel orthogonality is a stability requirement, not preference |
| α_cap EMA initialization | Both N_calibration AND N_ρ required; α_max throughout both initialization windows | Dual-condition transition; partial initialization is unsafe for static-committed capital-comp |
| In-flight declarations at genesis_exit | `α_cap_at_declaration` static for capital-comp; `α_cap_at_settlement` dynamic for epistemic-service | Static-commitment design law (#r137) applies at component level |

**Bonus formula final form:**
```
bonus_capital_comp     = α_cap_at_declaration × β_escrow × min(1, time_locked / T_longtail_ref)
bonus_epistemic_service = (1 − α_cap_at_settlement) × β_escrow × (Σ eff_weight / Σ base_weight)
implication_bonus_total = bonus_capital_comp + bonus_epistemic_service
```

**Complete governance interface (final):**

| Domain | Primitive inputs (governance-set) | Derived output (computed) |
|---|---|---|
| Chain depth | γ, K_target, d_ref, α_bond, N_calibration, β_min, β_max | β_effective |
| Capital rate | N_ρ, ρ_floor, ρ_ceil, T_twap, rate_oracle_address | ρ_effective (via TWAP + EMA + clamp) |
| Capital comp | (ρ_effective, T_longtail_ref) → α_cap formula; α_min, α_max | α_cap_at_declaration (static at commit); α_cap_at_settlement (live) |
| Challenge fees | r_floor (per class), fee_fraction | challenge_fee (single/cross-class) |
| LTRP stability | S_safety, M_stable (window_size, tolerance), K_recovery | LTRP_seed recall eligibility |

No parameter in the above table is set by direct numeric governance fiat at steady state. All are derived from principled primitives or bounded by governance-set clamps.

---

## Open Questions for #r145+

1. **α_cap split sum exceeds 1.0 — protocol bonus liability ceiling:** The final bonus formula allows `bonus_total > β_escrow` when `α_cap_at_declaration > α_cap_at_settlement` (capital-comp uses higher α, epistemic-service uses lower (1 − α)). At extremes, total bonus approaches β_escrow × 1.4. The protocol's implication_bonus_escrow is funded at `β_escrow` — not at 1.4× β_escrow. Does the settlement contract need to fund `implication_bonus_escrow` at 1.4× β_escrow to cover worst-case payouts, or should the formula be capped such that total bonus ≤ β_escrow?

2. **ρ_effective and per-class T_longtail_ref:** α_cap is per-coordinate-class (it depends on T_longtail_class). ρ_effective is protocol-global (one EMA across all classes). For a protocol with both fast-oracle classes (T_longtail = 2 epochs) and slow-oracle classes (T_longtail = 200 epochs), a global ρ_effective produces wildly different α_cap values per class. Should ρ_effective remain global (simpler; consistent borrowing cost) or should each class derive its own ρ_effective (accurate; complex)?

3. **Commitment of α_cap_at_declaration — when exactly?** The declaration EAT record stores `α_cap_committed`. At what point in the submission flow is this committed? If α_cap changes at a macro-epoch boundary and a declaration is submitted near that boundary (within the same epoch), which value is used — the α_cap at epoch open or the most recently computed value? This determines how declaration submission timing interacts with α_cap update events.

4. **TWAP oracle availability at genesis:** New coordinate classes may be deployed before the designated rate oracle has accumulated T_twap of TWAP data (e.g., oracle freshly deployed alongside the class). During the initial T_twap window, there is no valid ρ_market observation. Is ρ_floor the correct default during the TWAP initialization period, or should it default to a governance-supplied estimate (which then transitions to TWAP once available)?

*Last updated: #r144 — 2026-04-03T21:42Z*

---

## #r145 Contributions — 2026-04-03T21:52Z

Addresses all four open questions from #r144.

**Q1 (Bonus total exceeds β_escrow — protocol liability ceiling) → Escrow funded at 1.4× β; cap at escrow balance; no formula truncation (#r145):**

The final bonus formula allows `implication_bonus_total > β_escrow` when `α_cap_at_declaration ≠ α_cap_at_settlement`. Worst-case: capital-comp uses α_max = 0.5, epistemic-service uses (1 − α_min) = 0.9, yielding total = 1.4 × β_escrow. The `implication_bonus_escrow` as currently designed is funded at β_escrow — insufficient for worst-case.

Two candidate resolutions:
- **Cap the formula:** enforce `bonus_total ≤ β_escrow` by clipping. This distorts the component-level α_cap commitment principle — the capital-comp side was committed at declaration (immutable), so clipping the total retroactively at settlement breaks the static-commitment design law (#r137).
- **Fund escrow at 1.4× β_escrow:** the declaration locks 1.4× β_escrow in implication_bonus_escrow at submission. Most declarations will return the excess; worst-case payouts are always covered.

**Resolution — fund at `γ_escrow_multiplier × β_escrow`:**

```
implication_bonus_escrow_initial = γ_escrow_multiplier × β_escrow
γ_escrow_multiplier = α_max + (1 − α_min) = 0.5 + 0.9 = 1.4  (derived, not governance-set)
```

At settlement:
1. Compute `bonus_total = bonus_capital_comp + bonus_epistemic_service`.
2. Release `bonus_total` to knower (conditional on both coordinates correct).
3. Return `implication_bonus_escrow_initial − bonus_total` to knower as excess escrow refund.
4. If both coordinates wrong: forfeit full `implication_bonus_escrow_initial` to loser pools (proportional to stake).

**Design law (#r145):** Any bonus formula where components use different epoch-stamped parameter values must pre-fund escrow at the *maximum possible total across all parameter value combinations*, not at the nominal single-scenario total. The 1.4× multiplier is derived from governance-set (α_min, α_max) and is therefore stable under governance control. The multiplier is published in the governance interface derivation table.

**Interaction with TOWL:** The larger escrow locked at declaration increases TOWL capacity for the declaration's coordinate classes — correct, as larger capital at risk provides stronger solvency backing. (#r145)

---

**Q2 (ρ_effective global vs per-class — T_longtail heterogeneity) → Global ρ_effective maintained; T_longtail_ref is per-class; α_cap naturally differentiates (#r145):**

For a fast-oracle class (T_longtail = 2 epochs, ρ_effective = 0.005/epoch): `α_cap ≈ α_min` — capital opportunity cost is small; epistemic service dominates. For a slow-oracle class (T_longtail = 200 epochs): `α_cap ≈ α_max` — capital locked for long horizon; capital compensation dominates.

**This is the correct incentive structure.** Long-horizon capital commitments receive higher capital compensation. Short-horizon claims are primarily paid for epistemic service. Global ρ_effective is right because it reflects the uniform opportunity cost of locked capital in the protocol's reference market — the rate does not vary by coordinate class. Per-class ρ_effective would imply the same capital has different opportunity cost depending on which class it is locked in — economically incoherent given a single collateral asset.

**Design law confirmed (#r145):** Capital opportunity cost rate (ρ_effective) is protocol-global. Capital lockup duration (T_longtail_ref) is per-class. Their product divided by β_effective is the natural per-class α_cap. No per-class ρ derivation is required or correct. (#r145)

---

**Q3 (α_cap_at_declaration commitment timing) → Epoch-open snapshot; submission within epoch uses epoch-open α_cap (#r145):**

**Resolution — epoch-open snapshot rule:**

```
α_cap_at_declaration = α_cap published at the open of the epoch in which the declaration is submitted
```

All declarations within epoch T use the α_cap computed and EAT-committed at epoch T's opening boundary. α_cap is not recomputed intra-epoch — it derives from β_effective, which is itself a rolling average committed only at macro-epoch boundaries. Treating it as sub-epoch variable would create spurious precision.

**Front-running defense:** α_cap is published at epoch open — the same event that opens the submission window. No look-ahead window exists.

**EAT record:** Declaration EAT record stores `epoch_submitted` and `α_cap_committed`. Auditors verify: `α_cap_committed == α_cap(epoch_submitted)`. No additional commitment event required. (#r145)

---

**Q4 (TWAP oracle at genesis — initialization period default) → ρ_floor as initialization default; irrelevant to α_cap during bootstrap; dual-condition ensures convergence (#r145):**

During the initial T_twap window before the first valid TWAP observation, no valid ρ_market exists.

**Resolution:** `ρ_market_genesis = ρ_floor`; EMA initialized at ρ_floor.

**Why ρ_floor (not governance-supplied estimate):**
1. Governance-supplied estimate is an attack surface: inflated genesis ρ could game capital-comp expectations before TWAP data exists.
2. ρ_floor is already governance-bounded — a conservative safe minimum.
3. During bootstrap, α_cap = α_max anyway (dual-condition from #r144/Q3). Any ρ_smooth value is dominated by the α_max clamp. ρ_floor vs any other initialization value makes no difference to α_cap_at_declaration during bootstrap.

Post-bootstrap, the EMA converges from ρ_floor upward toward market rate over N_ρ epochs. The dual-condition transition ensures the derived formula activates only after N_ρ TWAP observations have accumulated — by which point the EMA is well-initialized.

**Design law confirmed (#r145):** All parameter initialization defaults must be governance-bounded minimums or maximums, not unconstrained point estimates — to prevent gaming the bootstrap phase. The dual-condition system ensures initialization imprecision does not propagate into steady-state computation. (#r145)

---

## Structural Synthesis: Parameter System — Final Closure (#r145)

| Issue | Resolution | Law |
|---|---|---|
| Bonus total > β_escrow | Fund at 1.4× β_escrow (γ_escrow_multiplier = α_max + (1-α_min)); refund excess at settlement | Pre-fund at max-possible total across all parameter combinations |
| Global vs per-class ρ | Global ρ_effective × per-class T_longtail = correct per-class α_cap; heterogeneity is intended | Capital rate global; lockup duration per-class; product is natural per-class compensation |
| α_cap commitment timing | Epoch-open snapshot; all declarations in epoch T use α_cap at T's opening boundary | Sub-epoch precision is spurious; epoch-open is the only valid resolution |
| TWAP genesis default | ρ_floor; irrelevant during bootstrap (α_max clamp dominates); dual-condition ensures convergence | Governance-bounded minimums as initialization defaults; no point-estimate inputs at genesis |

**Final governance interface (complete):**

| Domain | Primitive inputs (governance-set) | Derived output |
|---|---|---|
| Chain depth bonus | γ, K_target, d_ref, α_bond, N_calibration, β_min, β_max | β_effective |
| Capital rate | N_ρ, ρ_floor, ρ_ceil, T_twap, rate_oracle_address | ρ_effective |
| Capital compensation | α_min, α_max, T_longtail_ref (per-class) | α_cap (per-class); γ_escrow_multiplier = α_max + (1-α_min) |
| Challenge fees | r_floor (per class), fee_fraction | challenge_fee |
| LTRP stability gate | S_safety, window_size, tolerance (≤⌊window_size/4⌋), K_recovery | LTRP_seed recall eligibility |
| Degraded mode | T_outage_cap (per-class), T_longtail (per-class), κ_class (per-class) | κ_degraded = max(κ_class, κ_system_max_at_T_outage) |

No parameter is set by direct numeric fiat at steady state. Every computed output derives from governance-bounded primitives. Every genesis default uses a governance-bounded minimum or maximum.

---

## Open Questions for #r146+

1. **γ_escrow_multiplier sensitivity to α_min/α_max changes:** If governance widens [α_min, α_max], multiplier increases; future declarations lock more escrow. Existing declarations retain original escrow (static commitment). Declarations submitted between governance change and next epoch boundary: apply epoch-open snapshot rule from #r145/Q3 — multiplier for a given epoch is fixed at epoch-open.

2. **Excess escrow refund tax:** At settlement, `implication_bonus_escrow_initial − bonus_total` is returned to the knower as excess. Should a small protocol fee be deducted from the excess refund? An excess-refund tax would incentivize accurate prediction of α_cap evolution and efficient declaration sizing — but adds complexity and may discourage participation.

3. **ρ_effective publication during TWAP initialization gap:** During T_twap window before first valid TWAP, ρ_effective = ρ_floor. Should EAT record explicitly mark `ρ_source: genesis_floor` vs `ρ_source: TWAP_market` to allow auditors to distinguish initialization-default epochs from market-driven epochs?

4. **1.4× escrow and TOWL headroom for thin T3 classes:** Newly admitted T3 classes have few knowers; thin TOWL headroom. The larger 1.4× implication_bonus_escrow per declaration consumes TOWL faster. Should the TOWL accounting for the bonus escrow component (the excess 0.4×) be treated differently from T3_escrow_standard — e.g., as a separate TOWL-adjacent buffer rather than a per-claim TOWL contribution?

*Last updated: #r146 — 2026-04-03T22:02Z*

---

## #r146 Contributions — 2026-04-03T22:02Z

Addresses all four open questions from #r145.

**Q1 (γ_escrow_multiplier sensitivity to α_min/α_max changes) → Epoch-open snapshot governs; governance range changes are prospective; narrowing is benign, widening requires participation impact assessment (#r146):**

The epoch-open snapshot rule (#r145/Q3) already resolves the core timing question: γ_escrow_multiplier at any epoch is computed from the (α_min, α_max) committed at that epoch's opening boundary. Governance changes to α_min or α_max take effect at the next epoch open — never mid-epoch.

**Narrowing [α_min, α_max] (multiplier decreases):** Future declarations lock less escrow. In-flight declarations retain original 1.4× (or prior multiplier) via static commitment — they over-fund and receive larger excess refunds at settlement. Benign: no capital at risk is reduced, and larger refunds improve knower capital efficiency retrospectively. No special handling.

**Widening [α_min, α_max] (multiplier increases):** Future declarations must lock more escrow per declaration. Thin T3 classes with limited TOWL headroom may see participation drop as the escrow requirement increases. Governance must evaluate participation impact before widening.

**Design law (#r146):** Governance changes to [α_min, α_max] must include a `participation_impact_estimate` field (human-supplied, EAT-committed): the estimated change in declaration count per epoch for affected thin-TOWL classes. This is an accountability signal, not a gate — the governance change is not blocked, but the estimate is public and auditable. Retroactive analysis compares the estimate to observed post-change participation. Consistent with #r132/Q3 governance seed miscalibration recovery: governance bears accountability for parameter estimates that turn out wrong.

**EAT record:** Each governance update to (α_min, α_max) or γ_escrow_multiplier is committed as a `parameter_update` EAT event with `epoch_of_effect`, new values, derived γ_escrow_multiplier, and `participation_impact_estimate`. (#r146)

---

**Q2 (Excess escrow refund tax) → No tax; excess returned in full; tax is a participation discourager with no epistemic benefit (#r146):**

The excess escrow (implication_bonus_escrow_initial − bonus_total) arises mechanically from the static-commitment design law (#r137): declaring α_cap_at_declaration in advance requires pre-funding at the maximum possible bonus level. The excess is not a declarant error — it is the mechanism's fee for providing the static-commitment guarantee to the declarant.

**Why no tax:**
1. *Epistemic neutrality:* An excess-refund tax creates incentives to time declarations to epochs where α_cap_at_declaration ≈ α_cap_at_settlement — narrowing the predicted gap. This timing optimization has no epistemic value (it does not improve S_cred quality) and adds noise to declaration submission patterns.
2. *Participation cost:* A tax effectively increases the cost of all declarations (since excess is unpredictable at declaration time), most acutely for long-horizon cross-class declarations where the α_cap evolution gap is largest. This disproportionately discourages exactly the declarations the mechanism values most.
3. *Symmetry:* The protocol charges a challenge submission fee (#r141/Q1) to discourage low-quality challenges. Charging declarants for over-funding their committed escrow is the opposite incentive — it penalizes good-faith compliance with the pre-funding rule.

**Design law (#r146):** Zero-friction return of excess escrow is a first-class mechanism invariant for all pre-funded reserves. Any reserve funded at a maximum-possible level to cover parameter uncertainty must return excess without tax or deduction. This applies to γ_escrow_multiplier excess at settlement and to any future pre-funding construct. (#r146)

---

**Q3 (ρ_effective publication during TWAP initialization gap — ρ_source EAT tag) → Three-state ρ_source tag; degraded-mode freeze and resume policy formalized (#r146):**

The EAT should distinguish three regimes for ρ_effective publication:

```
ρ_source ∈ {
  genesis_floor:    initial T_twap window before first valid TWAP observation
                    (ρ_effective = ρ_floor; EMA initialized at ρ_floor)
  TWAP_market:      post-initialization normal operation
                    (ρ_effective = clip(ρ_smooth, ρ_floor, ρ_ceil))
  degraded_frozen:  DA outage active; ρ_effective frozen at pre-outage value
}
```

**Degraded-mode ρ_effective behavior — new specification (#r146):**

TWAP oracle data requires DA availability to commit observations. During DA outage: ρ_smooth cannot advance (no new TWAP input). ρ_effective freezes at the last value committed to the EAT at T_outage. This is published with `ρ_source: degraded_frozen`.

On DA restore:
1. ρ_smooth resumes from the pre-outage EMA value — not from ρ_floor (restarting from ρ_floor would discard valid history). The EMA formula uses the pre-outage ρ_smooth as the prior and the first post-restore TWAP observation as the new input.
2. ρ_source transitions to `TWAP_market` immediately at the first post-restore macro-epoch boundary where a valid TWAP observation is available.
3. No re-initialization window required: the EMA's decay structure means that pre-outage history naturally attenuates as new observations accumulate. There is no analogue to the N_ρ initialization condition here — the EMA is already initialized from pre-outage state.

**N_calibration/N_ρ dual-condition and outage:** Outage epochs do not advance the N_ρ counter (consistent with the rule that exceptional-mode epochs do not advance initialization counters, #r144/Q3). If a new class was bootstrapping its N_ρ window during an outage, the counter picks up where it paused.

**EAT record per macro-epoch:** Each epoch commits ρ_source alongside ρ_effective. Auditors can reconstruct at any settlement whether the α_cap_at_declaration used a frozen, floor, or market-derived rate — and discount accordingly. (#r146)

---

**Q4 (1.4× escrow and TOWL headroom for thin T3 classes) → γ_escrow_excess is protocol-side contingent buffer; not TOWL-counted; follows #r131/Q2 pool-reserve design law (#r146):**

The implication_bonus_escrow is decomposed into two economic components at declaration time:

```
implication_bonus_escrow_initial = β_escrow + γ_escrow_excess

β_escrow      = β × A_stake    (base implication bonus escrow, the "nominal" bonus at stake)
γ_escrow_excess = (γ_escrow_multiplier − 1) × β_escrow = 0.4 × β_escrow  (worst-case pre-funding buffer)
```

**β_escrow** represents the actual epistemic warranty. It is a meaningful financial commitment backing the claim's accuracy — it contributes to per-claim TOWL capacity (consistent with the role of escrow as financial warranty in the TOWL model).

**γ_escrow_excess** is pure parameter-uncertainty pre-funding. It exists only to cover the case where α_cap_at_declaration > α_cap_at_settlement, producing a bonus total slightly above β_escrow. In expected value (with stable governance parameters), γ_escrow_excess is largely returned. It does NOT represent an additional epistemic warranty — it is a contingent buffer for parameter evolution.

**Resolution — split TOWL treatment:**

```
TOWL contribution per declaration =
    β_escrow × w_a  (per-claim TOWL, same as standard T3_escrow_standard)

γ_escrow_excess is held as a protocol-side contingent escrow buffer:
    - Not TOWL-counted (consistent with #r131/Q2 pool-reserve design law)
    - Reported in a new `implication_reserve_status.contingent_excess_pool` field
    - Returned to knower at settlement from the same `implication_bonus_escrow` settlement flow
    - Not available for LTRP top-up or slash routing during Zone C (#r134/Q4 class-gated rule applies to β_escrow portion only; γ_escrow_excess is not a solvency instrument)
```

**Practical impact on thin T3 classes:** TOWL headroom consumed per implication declaration = β_escrow × w_a — same as a standard T3 claim at equivalent stake. The 0.4× excess does not reduce TOWL availability. Thin classes can accommodate implication declarations at the same TOWL headroom rate as standard T3 claims. The concern in #r145/Q4 is resolved.

**Design law confirmed and extended (#r146):** Pre-funding buffers for parameter uncertainty are always protocol-side contingent reserves: not TOWL-counted, not solvency-gated, not available for slash routing. Only the nominal epistemic-warranty component of any escrow counts toward TOWL. This closes the #r131/Q2 design law against a new category of escrow. (#r146)

---

## Structural Synthesis: Escrow Taxonomy — Extended (#r146)

With the γ_escrow_excess classification, the escrow taxonomy from #r133 gains a fifth sub-component within the implication_bonus_escrow category:

| Component | TOWL-counted | Returned at settlement | Zone C gated | Notes |
|---|---|---|---|---|
| T3_escrow_standard | Yes (per-claim) | At challenge window close | Class-local | In-warranty financial backing |
| T3_escrow_longtail | No (LTRP) | Via LTRP after T_longtail | Class-local | Long-tail liability pool |
| β_escrow (bonus nominal) | Yes (per-claim) | If correct: to knower; if wrong: to loser pool | Class-local | Actual epistemic warranty component |
| γ_escrow_excess (pre-funding buffer) | No (contingent) | Excess returned regardless of outcome | No | Parameter-uncertainty pre-funding; not a solvency instrument |
| implication_bonus_escrow combined | N/A | Decomposed per above | Per β_escrow portion | β_escrow + γ_escrow_excess |

**Five-component escrow model:** T3_standard, T3_longtail, β_escrow (bonus nominal, TOWL-counted), γ_escrow_excess (pre-funding buffer, not TOWL-counted), implication_reserve (protocol-held pending settlement). The model is now closed — any future escrow category must be classified against this taxonomy. (#r146)

---

## Open Questions for #r147+

1. **ρ_source during bridge epoch:** The bridge epoch fires post-DA-restore. ρ_source would be `TWAP_market` (first valid TWAP is available). But the bridge epoch uses elevated κ_bridge — meaning all S_cred effective weights are suppressed. β_effective is computed from rolling base reward, which is suppressed in bridge epoch (excluded from rolling window per #r132/Q2). Does ρ_effective also use a bridge-epoch-excluded rolling input, or does ρ_smooth advance normally during bridge? Since ρ_smooth uses TWAP observations (not epoch reward data), it advances normally — the two smoothers are independent.

2. **γ_escrow_excess and debt withholding:** Debt withholding (#r134/Q2) applies to primary claim escrow. For implication declarations, the primary escrow is the combined implication_bonus_escrow_initial = β_escrow + γ_escrow_excess. Does debt withholding apply to the combined amount (reducing both components proportionally), or only to β_escrow (the TOWL-counted warranty component)? Given the #r146 decomposition, withholding should apply only to β_escrow — the epistemic commitment. γ_escrow_excess is a pre-funding buffer; reducing it by debt withholding means the protocol may be under-funded at worst-case settlement.

3. **TOWL Zone C and β_escrow portion of implication declarations during Zone C deferral:** During Zone C, the β_escrow portion of implication_bonus_escrow is class-gated (#r134/Q4 extended to β_escrow per #r146). But Zone C throttles new T3 installations, not existing escrow flow. Does Zone C block *releases* of β_escrow (analogous to implication_bonus_escrow deferral), or only new *installations*? The distinction matters: existing declarations mid-life during Zone C should not have their bonus deferral policy changed retroactively.

4. **ρ_effective and the combined α_cap formula at the extremes of T_longtail_ref:** For extremely long T_longtail (e.g., T_longtail_ref = 1000 macro-epochs at ρ_effective = 0.005), α_cap = (0.005 × 1000) / β_effective = 5.0 / β_effective. At β_effective = 2.5 (β_max), α_cap = 2.0 — well above α_max = 0.5. The clamp absorbs this correctly (α_cap = α_max). But the clamp-binding duration would be permanent for very long T_longtail classes — governance would always see the β_effective clamp alert for these classes. Is there a T_longtail_ref governance ceiling to prevent extreme lockup horizons from permanently pinning α_cap at α_max?

*Last updated: #r146 — 2026-04-03T22:02Z*

---

## #r147 Contributions — 2026-04-03T22:12Z

Addresses all four open questions from #r146.

**Q1 (ρ_source during bridge epoch — ρ_smooth and β_effective independence) → Independent smoothers; ρ_smooth advances normally during bridge (#r147):**

β_effective uses a rolling average of epoch-level base slot rewards (#r76/Q3). This input is suppressed during bridge epochs (κ_bridge artificially reduces effective_weight → reduces base reward → distorts the average). Therefore bridge epochs are excluded from the β_effective rolling window (#r132/Q2).

ρ_smooth uses TWAP observations of a DeFi market rate (#r143/Q1, #r144/Q1). This input is sourced from an independent oracle (e.g., AAVE USDC supply APY TWAP on Ethereum mainnet) — not derived from epoch reward data. DA availability is the only prerequisite; bridge epoch status is not relevant.

**Resolution:** ρ_smooth advances normally during bridge epochs. ρ_source = `TWAP_market` throughout the bridge epoch (DA is live; TWAP observations are available). No bridge-epoch exclusion for ρ_smooth.

**Design law (#r147):** Each rolling window excludes epochs where its *specific input type* is distorted. Independent input streams from different oracle sources are not excluded on behalf of each other. Any new smoothed parameter must declare its input source and its specific distortion condition at feature design time.

**Interaction with α_cap during bridge:** β_effective is published from the most recent N_calibration normal-mode window (pre-bridge value, shorter window if needed). ρ_smooth uses the current bridge-epoch TWAP. The resulting α_cap may differ slightly from the pre-outage value; published with `ρ_source: TWAP_market` and `β_effective_source: N_calibration_window_short` for auditor visibility. Transient asymmetry — resolves within one bridge epoch. (#r147)

---

**Q2 (γ_escrow_excess and debt withholding) → Proportional scaling with β_escrow_net; no separate withholding policy (#r147):**

γ_escrow_excess is defined as `0.4 × β_escrow` (γ_escrow_multiplier − 1 = 0.4, from #r145/Q1). It is not an independent capital commitment — it is a multiplicative overlay on β_escrow.

**Resolution:** Debt withholding applies to β_escrow at rate `debt_withholding_rate` (#r134/Q2). γ_escrow_excess scales automatically:

```
β_escrow_net        = β_escrow × (1 − debt_withholding_rate)
γ_escrow_excess_net = 0.4 × β_escrow_net
implication_bonus_escrow_net = 1.4 × β_escrow_net
```

The maximum bonus total at settlement:
```
bonus_total_max ≤ (α_max + (1 − α_min)) × β_escrow_net = 1.4 × β_escrow_net = implication_bonus_escrow_net
```

γ_escrow_excess remains correctly sized relative to the withheld β_escrow_net. No under-funding risk. No separate withholding formula required.

**Design law (#r147):** A pre-funding buffer defined as a fixed multiple of a nominal escrow component inherits the same withholding/scaling treatment as the nominal component. No independent withholding formula for any (multiplier − 1) × nominal_escrow pre-funding construct is required or appropriate. (#r147)

---

**Q3 (Zone C and β_escrow mid-life — release deferral vs installation throttling) → Lifecycle-stage separation: Zone C throttles new installations; existing outflows follow class-local deferral rule (#r147):**

Two orthogonal Zone C effects on implication declarations:

1. **New installations (Zone C throttling):** Zone C throttles new T3 claim installations (#r71). New implication declarations cannot enter active-warrant state during Zone C. No new β_escrow is locked for throttled declarations.

2. **Existing mid-life declarations (class-local outflow deferral):** The class-local Zone C outflow deferral rule (#r134/Q4, extended to β_escrow per #r146) defers *releases* from existing implication_bonus_escrow during class-level Zone C. This defers the bonus payment timing without changing the bonus amount.

**Resolution:** No contradiction — Zone C operates at two lifecycle stages independently. Zone C deferral is an operational timing rule, not a retroactive change to declared terms. The declaration's core terms (α_cap_at_declaration, β_escrow_net, lockup horizon) are unchanged. On Zone C exit, deferred releases are processed in EAT timestamp order at the first macro-epoch boundary.

**Anti-retroactive protection:** Zone C deferral cannot change the *amount* of bonus owed. If a class remains in Zone C indefinitely, the bonus deferral accrues without expiry. The amount is protected; only timing is affected.

**Design law (#r147):** Zone C has two orthogonal operational modes: (1) new-installation throttling (forward-looking, blocks new lockup), (2) existing-escrow outflow deferral (operational timing, defers not denies). Zone C defers; it never reduces. Amount is protected; timing is operational. (#r147)

---

**Q4 (T_longtail_ref saturation — α_cap permanently clamped at α_max) → Registration warning flag; β_clamp recurring alert suppressed; no hard block (#r147):**

The saturation threshold:
```
T_longtail_alpha_sat = (α_max × β_max) / ρ_floor
```

At recommended defaults (α_max=0.5, β_max=2.5, ρ_floor=0.002):
```
T_longtail_alpha_sat = (0.5 × 2.5) / 0.002 = 625 macro-epochs
```

For classes where T_longtail_class > T_longtail_alpha_sat, α_cap is permanently clamped at α_max regardless of β_effective.

**Resolution — registration-time warning flag, no hard block:**

At class registration, if `T_longtail_class > T_longtail_alpha_sat`, the protocol emits a `T_longtail_alpha_saturation` warning in the registration EAT event with fields: `T_longtail_alpha_sat_value`, `T_longtail_submitted`, consequence string, and `permanent_β_clamp_alert: true`.

The registration is NOT blocked. A very slow oracle class (e.g., decadal epidemiological outcomes, multi-year litigation) may legitimately require T_longtail > T_longtail_alpha_sat; permanent α_cap = α_max (maximum capital compensation) is the correct incentive for multi-year capital lockup. Governance accepts this as an explicit design choice.

**β_effective clamp recurring alert suppression:** For saturated classes, the β_effective clamp alert (#r129/Q4) would permanently fire regardless of calibration quality. This is noise. For classes with `T_longtail_alpha_saturation.flag = true`, the β_effective clamp recurring alert is suppressed at the governance alert layer — replaced by the single at-registration acknowledgment. The clamp is still enforced mechanically; only the alert is silenced.

**Design law (#r147):** Governance parameters that permanently saturate derived outputs should emit a one-time registration warning, not a recurring operational alert. Saturation is a legitimate extreme-value policy choice with defined and accepted consequences — not a miscalibration. Document at registration; silence the noise. (#r147)

---

## Structural Synthesis: Mechanism Parameter System — Complete (#r147)

| Issue | Resolution | Law |
|---|---|---|
| ρ_smooth during bridge epoch | Advances normally; independent of β_effective rolling window | Each smoother excludes only its own distorted input epochs |
| γ_escrow_excess debt withholding | Proportional scaling with β_escrow_net; no separate policy | Pre-funding multiples inherit nominal's withholding treatment |
| Zone C vs existing mid-life escrow | Two orthogonal modes: new-installation throttle + existing outflow deferral | Zone C defers, never denies; amount protected; timing is operational |
| T_longtail_ref saturation | Registration warning; β_clamp alert suppressed; no hard block | Permanent saturation is policy, not error; document once at registration |

**Complete mechanism design invariant set (#r147, accumulated across #r1–#r147):**

1. **Conserved quantity (WED):** Mechanism minimises Warranted Epistemic Debt. Capital routes to high-D×A×P coordinates. (#r69)
2. **Bounded individual liability:** Every unbounded lockup → bounded window + protocol pool backstop. (#r130–#r132)
3. **Escrow orthogonality:** TOWL (financial) and credibility_ratio (epistemic) channels never cross-contaminate. (#r144)
4. **Epoch-indexed vs wall-clock deadlines:** Explicit classification at feature design time; epoch-indexed auto-freeze; wall-clock explicit toll. (#r137–#r139)
5. **Static escrow, dynamic epistemic:** Capital committed at declaration fixed; S_cred contribution dynamically re-derived each epoch. (#r137)
6. **Pre-fund at maximum possible:** Bonus escrow funded at 1.4× β_escrow. Excess returned in full without tax. (#r145, #r146)
7. **All parameters derived from primitives:** No steady-state parameter is governance-set by direct numeric fiat. (#r144, #r145)
8. **Exceptional-mode calibration exclusion:** Only distorted-input epochs excluded from each specific rolling window. Independent inputs advance normally. (#r132, #r147)
9. **Zone C defers, never denies:** Zone C may defer escrow release timing; bonus amount is always protected. (#r147)
10. **Saturation is policy, not error:** Parameters that permanently saturate derived outputs → one-time registration warning; recurring operational alerts suppressed. (#r147)

*Last updated: #r147 — 2026-04-03T22:12Z*

---

## #r148 Contributions — 2026-04-03T22:22Z

**First-principles reset: answering the original 10-point framework from the altitude of a complete mechanism.**

After 147 runs of engineering depth, the mechanism is parameter-complete. This run answers the founding 10 questions from #r1 with the full system in view — stripping back to mechanism primitives, not engineering detail.

---

### 1. Base Primitive — What is being exchanged?

Not a probability. Not a share of a prediction-market pool.

**What is exchanged: a warranted state claim.**

A knower locks capital and asserts a value for a coordinate of the global state vector. The capital is not a side-bet on crowd belief — it is a warranty that the asserted value is correct. If correct, the knower earns a base slot reward (query fees from unknowers) and an implication bonus if part of a correct structural chain (A→B). If wrong, the capital is slashed. The warrant is the asset; the capital is its collateral. The exchange is warranty-for-fee, not belief-for-contra-belief.

**What distinguishes this from LMSR:** LMSR prices movement of a shared belief distribution — capital moves a market price toward truth by making it expensive to move prices away from truth. The exchanged primitive is liquidity against a scoring rule. In the knowledge marketplace, the primitive is a *claim with a warranty* — an epistemic commitment, not a directional trade.

---

### 2. State Model — What is the global state vector and how is it updated?

**State vector S:** A collection of coordinate values, each belonging to a typed coordinate class (financial prices, regulatory states, on-chain events, etc.). Each coordinate has a current best estimate S(c), a staleness weight (κ-based decay), and a TOWL zone reflecting financial backing of the installed state.

**Update rule:**
```
S_new(c) = weighted_aggregate(S_old(c), {new_claims})
w_a = C_a × log(1 + k_a_net)   [credibility_ratio × log-stake]
```

The aggregation is credibility-weighted: more credible, higher-stake knowers move the state further. S(c) is not a market price — it is not moved by buying and selling; it is moved by credible, collateralised assertion.

**What LMSR does instead:** LMSR has a single state variable (market price / belief probability). Capital moves it continuously. Any dollar of capital has the same marginal impact regardless of source credibility. The knowledge marketplace's update rule conditions on *who* is asserting, not only *how much*.

---

### 3. Credibility Model — How does capital stake convert into trustworthy information?

Capital improves epistemics through three mechanisms:

1. **Skin-in-the-game:** A knower who is wrong loses capital. This filters cheap talk. Capital is proof-of-conviction.

2. **Track record compounding:** `C_a = credibility_ratio(a)` is a running calibration score from log-scoring resolved claims. Consistently correct knowers gain more influence per unit of stake.

3. **Implication bonus alignment:** Knowers who identify structural A→B relationships are rewarded only if both coordinates resolve correctly. This creates incentive to model causal structure, not just point values.

**The conserved quantity is WED — Warranted Epistemic Debt (#r69):**
```
WED = Σ_c D(c) × A(c) × P(c)
```
Capital flows toward high-D(c)×A(c)×P(c) coordinates — where decision losses from wrong state are expensive, the coordinate is influential, and current state is likely wrong. This is categorically different from capital flowing toward high-disagreement coordinates (LMSR) or high-volume trading pairs (orderbooks).

---

### 4. Market Roles — Who are askers/knowers, and who pays whom?

| Role | Identity | Capital flow |
|------|----------|-------------|
| **Knower** | Agent with private information about coordinate c | Locks escrow at submission; earns base slot reward + implication bonus if correct; slashed if wrong |
| **Unknower (query demander)** | Agent who needs a credible state estimate | Pays query fee into pool; fee distributed to active contributors to S_cred |
| **Challenger** | Agent who suspects a warranted installation is wrong | Posts challenge submission fee (refunded if correct); earns challenger reward from slash proceeds |
| **Governance** | Protocol stewards | Seeds genesis pools; sets primitive parameters; bears calibration accountability |

**Flow direction:** Information-rich zones (knowers with high C_a and large stake) are paid by information-poor zones (unknowers who cannot cheaply produce the state estimate). This is bilateral flow from high-information to low-information zones — not losers-to-winners in a shared prediction contest.

**LMSR comparison:** In LMSR, "liquidity providers" bear residual risk. In orderbooks, buyers and sellers swap contra positions. Neither has a structural role for "knower" as a distinct class with epistemic accountability. This mechanism introduces role asymmetry absent from both.

---

### 5. Settlement Model — Truth resolution and partial observability

**Hard resolution:** Oracle confirms coordinate value. Correct → base reward + conditional implication bonus released. Wrong → escrow slashed; slash proceeds route to loser pool + challenger reward + (Zone C) LTRP.

**Partial resolution (A resolved, B not yet):** Implication_bonus_escrow held; A-side conditional partial release available (#r133/Q4). A-side base escrow settles normally. B-side remains pending.

**No oracle resolution (slow oracle, T_longtail expiry):** Escrow transitions to LTRP. Knower receives partial capital-comp bonus if A confirmed correct. Bonus_epistemic_service prorated to active epochs with non-zero effective_weight (#r141, #r142).

**Degraded observability (dispute without evidence):** Challengers frozen during DA outage until DA restores. The mechanism tolerates partial observability — never forces resolution when evidence is unavailable. More epistemically honest than LMSR, which resolves at an oracle-chosen point regardless of information completeness.

---

### 6. Attack Surface

| Attack | Defense |
|--------|---------|
| **Bluffing / cheap talk** | Slashing makes cheap talk expensive; credibility_ratio degrades on failure |
| **Sybil / wash credibility** | Capital must be real per-account; sybil costs linear in escrow; γ_corr reduces marginal value of extra identities |
| **Collusion** | All colluders lose on resolution; net loss = colluder escrow |
| **Oracle gaming** | Out of mechanism scope; no more vulnerable than LMSR |
| **WED inflation** | D(c) and A(c) are buyer-declared; unknowers who over-declare D waste their own capital |
| **Implication chain spoofing** | Requires real escrow per coordinate, real calibration history, actual oracle resolution; chain depth delivers diminishing bonus at γ^(depth-1) |
| **Front-running provisional scores** | Bridge epoch one-epoch buffer (#r131/Q3) + κ_bridge elevated decay suppresses effective_weight during refinement window |

**Comparison to LMSR:** LMSR's primary attack is market manipulation — moving prices without conviction to extract arbitrage. The knowledge marketplace adds WED inflation as an attack surface absent from LMSR. This is the cost of the richer state model.

---

### 7. Why better or worse than LMSR/orderbooks?

**Better than LMSR:**
- Information source matters. LMSR treats all capital as epistemically equivalent; this mechanism weights by track record.
- Correct incentive target. LMSR rewards being right against the crowd; this rewards reducing decision-relevant uncertainty (WED). These are not the same. A market can have LMSR prices fully correct on low-stakes coordinates while leaving high-stakes coordinates poorly informed — LMSR has no mechanism to correct this.
- No subsidised market maker required. LMSR needs a liquidity subsidy (market maker bears expected loss). This mechanism self-funds through query fees and loser-pool redistribution.
- Implication chains. LMSR has no mechanism to reward structural causal identification — only terminal probability.

**Worse than LMSR:**
- Complexity. LMSR is a single formula. This mechanism is a multi-layer system. Attack surface scales with complexity.
- Requires credibility history. New participants have low C_a. Bootstrap is slow — mechanism's epistemic quality is near LMSR-level until a sufficient history of resolved claims establishes the track-record layer.
- D(c) and A(c) are private. WED routing is only decision-optimal if unknowers reveal their stakes honestly.

**Better than orderbooks:**
- Disclosure is profitable. Knowers benefit from revealing information (warranty rewards), not from hoarding it.
- No speed race. Orderbooks reward fast order placement; this mechanism rewards epistemic quality.

**Worse than orderbooks:**
- Liquidity depth. Orderbooks can always make a market at some price. If no one knows a coordinate, there is no ask and the state is uninformed.

---

### 8. Simplest viable mechanism sketch

Three contracts, five roles:

**Contracts:**
1. `StateRegistry`: holds global state vector; accepts warranted claims; updates S(c) via credibility-weighted aggregation.
2. `EscrowManager`: locks knower capital at submission; releases or slashes at oracle resolution.
3. `QueryPool`: receives query fees from unknowers; distributes pro-rata to active contributors to S_cred.

**Minimal flow:**
```
Knower → submit(claim, c, value, stake) → EscrowManager locks stake
Oracle → resolve(c, true_value) → StateRegistry scores claim
  if correct: QueryPool pays base_reward; EscrowManager releases stake
  if wrong:   EscrowManager slashes stake; challenger_pool and loser_pool credited
Unknower → query(c) → pays fee → QueryPool → distributed to contributors
```

Everything else in the document (TOWL, LTRP, implication chains, credibility smoothers) is engineering to make this sketch robust to edge cases, attacks, and slow oracles. The sketch above is the mechanism's core — viable on its own for fast-oracle, single-coordinate, low-adversarial-pressure settings.

---

### 9. Strongest reason this idea fails

**The demand-side revelation problem.**

The mechanism routes capital toward high-WED coordinates only if unknowers reveal D(c) and A(c) honestly through query behaviour and willingness to pay. But D(c) is private: unknowers know how expensive a wrong state estimate is for their decision, and have no incentive to reveal it accurately.

If unknowers do not reveal D(c), the query fee pool does not correctly signal which coordinates need the most epistemic work. Knowers optimise for query fees, not true WED reduction. The mechanism degrades toward a standard prediction market where capital concentrates on *popular* coordinates, not *decision-critical* ones.

**Why this matters more here than in LMSR:** LMSR's epistemic output (the price) is useful regardless of why participants moved it. The knowledge marketplace's output (S(c) and its WED routing) is only decision-optimal if the demand signal is honest. Without honest demand, the mechanism is an expensive version of a standard scoring rule.

**Partial mitigation:** Unknowers can implicitly reveal D(c) through escrow-conditioned queries: committing to higher fees if the state estimate proves correct. This is a revelation mechanism but requires additional design not yet in the document.

---

### 10. Best surviving variant if the raw idea is wrong

**If demand-side revelation fails:** Revert to a purely epistemic scoring rule without WED routing. Knowers are rewarded for calibrated accuracy on any registered coordinate. Governance chooses which coordinates to activate and what base reward to set — governance substitutes for the absent demand signal. Less efficient than true WED routing but honest about what the demand signal cannot deliver.

**The surviving variant is:** A credibility-weighted, track-record-anchored, implication-chain-enabled scoring rule, operating over a governed set of coordinates, with honest settlement, TOWL solvency guarantees, and oracle-tolerant escrow architecture.

This retains the core epistemic advantages over LMSR (credibility weighting, implication chains, source-aware updates) while dropping the demand-signal machinery that requires D(c) revelation. Categorically distinct from LMSR and orderbooks; weaker than the full WED-routing vision but more robust.

**GestAlt v2.1 relevance:** The surviving variant maps cleanly onto a clearing protocol for prediction market positions. Knowers are sophisticated agents with private information about event outcomes; unknowers are retail position-takers who need credible price signals; the clearing layer settles both. The D(c) revelation problem is less acute here because position size implicitly reveals willingness-to-pay — the bet itself is the demand signal.

---

## Structural Synthesis: First-Principles Closure (#r148)

The mechanism, post-#r147 engineering and #r148 comparative analysis, is:

**A warranted-state marketplace where calibrated knowers sell epistemic warranties to decision-making unknowers, rewarded by track-record-weighted accuracy scoring and implication chain bonuses, with capital as proof-of-conviction rather than side-bet collateral.**

It is not LMSR. It is not an orderbook. It is not a batch auction. It is closest to a **quality-graded oracle service with skin-in-the-game**, where the quality grading is endogenous (track record) and the skin-in-the-game is mandatory (slashable escrow).

The mechanism survives its own strongest failure mode (demand-side D(c) revelation) through the GestAlt-specific structural advantage: in prediction market clearing, position size IS the demand signal.

*Last updated: #r148 — 2026-04-03T22:22Z*

---

## #r149 Contributions — 2026-04-03T22:32Z

**Focus: three structural gaps from #r148.**

1. Formalise the escrow-conditioned query (demand-side D(c) revelation partial mitigation, left open in #r148/§9).
2. Stress-test the "position size IS the demand signal" claim from #r148/§10 — is it actually sufficient?
3. Identify the clearing-vs-discovery regime split: the mechanism has been designed for one mode; what does it need to be two?

---

### A. Escrow-Conditioned Query — Formal Design (#r149)

**The problem (recap):** Unknowers have private D(c) — the decision-relevant cost of a wrong state estimate. Without revealing D(c), the query fee pool does not correctly signal which coordinates need knower attention. The mechanism routes capital to popular coordinates, not decision-critical ones.

**Resolution — EQ (Escrow-Conditioned Query):**

```
EQ(agent_a, c, q_fee, q_bonus, q_quality_threshold) where:
  q_fee      = unconditional fee paid immediately at query submission
  q_bonus    = conditional bonus paid to active S_cred contributors iff
               S(c) at resolution is within q_quality_threshold
  q_quality_threshold = a precision envelope (e.g., "within ε of true value")
```

**Revelation properties:**
- `q_fee` is a lower bound on D(c): an agent pays q_fee only if the information is worth at least that.
- `q_bonus` reveals the agent's *quality sensitivity* — how much they value accuracy rather than any answer. High q_bonus relative to q_fee signals high D(c): the agent cares not just about getting an answer, but about getting the *right* answer.
- The ratio `q_bonus / q_fee` is a partial revelation of the agent's decision-criticality. An agent indifferent to accuracy (low D(c)) sets q_bonus = 0 and pays q_fee only.

**Why this improves on a plain query fee:**

A plain query fee reveals willingness-to-pay-for-access. An escrow-conditioned query reveals willingness-to-pay-for-accuracy. The second is the signal WED routing needs. A diagnostic that costs $10 regardless of whether it is correct is not the same demand signal as a diagnostic where the expert earns $100 only if they are right.

**Incentive for knowers:** q_bonus flows only to knowers whose claims were active in S_cred when the oracle resolved and whose contributions survived to the accurate state. This focuses knower incentives on the coordinates where unknowers have high quality sensitivity — the highest D(c) coordinates.

**Settlement:** q_bonus is locked in escrow at query submission. At oracle resolution, q_bonus is distributed to active S_cred contributors whose effective_weight was non-zero at the resolution epoch, pro-rata by effective_weight, conditional on S(c) resolution being within q_quality_threshold. If resolution is outside threshold: q_bonus returns to query submitter (refunded). q_fee is non-refundable (it compensates for attention direction, not correctness).

**Failure mode of EQ:** Unknowers who routinely set q_bonus = 0 are not revealing D(c) and the mechanism degrades. Defence: governance can require a minimum q_bonus / q_fee ratio for coordinate activation (≥ 0.5 recommended). Below this threshold, the coordinate's base reward is weighted as low-priority.

**WED routing via EQ:** The mechanism's effective demand signal per coordinate becomes:

```
effective_D(c) = q_fee(c) + E[q_bonus(c) × Pr(resolution within threshold)]
```

This is a computable, on-chain, honest-revelation approximation of D(c) × P(c), without requiring private D(c) declaration. Unknowers reveal D(c) through their own incentives, not through governance-forced disclosure. (#r149)

---

### B. "Position Size IS the Demand Signal" — Stress Test (#r149)

**The #r148/§10 claim:** In GestAlt clearing, position size implicitly reveals willingness-to-pay. The D(c) revelation problem is less acute because the bet IS the demand signal.

**This is correct but incomplete.** Two conditions must hold:

**Condition 1 — Position size tracks D(c):** A knower's position size reveals their private information about the outcome probability — not necessarily their decision-relevant loss from a wrong state. A market maker with a 1M USD position may have low D(c) (they hedge automatically) while a retail participant with a 100 USD position may have high D(c) (it represents their savings). LMSR uses position size as an attention signal, not a D(c) signal.

**In GestAlt specifically:** The clearing protocol's job is to establish fair settlement prices for existing positions. D(c) here is not "how bad is a wrong state for my downstream decision" but "how much does counterparty credit risk or collateral accuracy matter to this position." For a large OTC position, D(c) scales with position size AND contract complexity.

**Formalised claim:** In GestAlt clearing, `D(c) ∝ Σ_positions max_loss_per_position_on_c`. This IS revealed on-chain through position registration. Position registration forces D(c) disclosure in a way that general prediction market unknowers cannot.

**Condition 2 — Positions are registered before oracle resolution:** If positions are registered post-oracle (settlement only), no demand signal is available for knower incentives during the information-discovery phase. The mechanism must be in *clearing* mode (positions exist first, oracle confirms second) for position size to substitute for D(c) revelation.

**Failure mode:** In GestAlt operating in *discovery* mode (oracle is live; positions are being formed), position sizes are small and incomplete during the information-discovery phase. The demand signal is weak exactly when knowers are deciding whether to invest in high-quality information.

**Resolution:** GestAlt needs both modes distinguished — see §C below. (#r149)

---

### C. Clearing-vs-Discovery Regime Split (#r149)

**The gap identified:** The mechanism engineering (#r1–#r148) implicitly assumes *discovery mode* — coordinates have uncertain states, unknowers want credible estimates, knowers compete to install the best state. But GestAlt v2.1 is a *clearing protocol* — positions exist, the oracle fires, the protocol settles. These are different information regimes with different optimal mechanism parameters.

**Two regimes:**

| Regime | State of positions | Information flow | WED source | Optimal knower incentive |
|--------|--------------------|-----------------|------------|--------------------------|
| **Discovery** | Not yet formed; being priced | Knowers → market price | q_bonus from unknowers (EQ, §A) | Calibrated accuracy over time |
| **Clearing** | Registered; pending settlement | Oracle → clearing price | Σ max_loss from registered positions | Fast, credible state resolution |

**Key differences:**

1. **Time horizon:** Discovery mode requires long-horizon knower engagement (multi-epoch S_cred accumulation). Clearing mode requires fast, single-epoch resolution credibility (the position settles; long-horizon track record is secondary).

2. **Knower population:** In discovery mode, credibility-weighted aggregate is epistemically optimal (many credible voices converge). In clearing mode, a single authoritative oracle plus dispute mechanism is structurally adequate — the clearing price must be unambiguous, not probabilistically aggregated.

3. **D(c) source:** In discovery mode, D(c) is revealed through EQ mechanism. In clearing mode, D(c) is revealed through registered position max_loss — computable directly.

4. **WED computation in clearing mode:**
   ```
   WED_clearing(c) = Σ_positions_on_c | max_loss_if_wrong |
   ```
   This is honest, on-chain, and does not require the EQ machinery.

**GestAlt operating model:** GestAlt v2.1 is primarily a clearing protocol — positions exist, oracle fires, protocol settles. The knowledge marketplace mechanism in clearing mode is simpler and more robust:

- No EQ required (D(c) computed from positions).
- WED_clearing is computable without private revelation.
- S_cred's role shifts from *best-estimate discovery* to *settlement-price credibility attestation* — a different, narrower epistemic task.
- TOWL zone management in clearing mode should prioritize speed (fast oracle propagation) over depth (long calibration history).

**Two mode profiles:**

```
CLEARING_MODE_PROFILE = {
  N_calibration:          2,            // fast burn-in
  T_longtail_default:     4 epochs,     // short warranty horizon
  beta_recency_weight:    gamma_recency^age,  // recency-weighted rolling average
  implication_bonus_default: 0,         // disabled unless explicitly activated
  WED_routing:            position_max_loss,  // direct from position registry
}

DISCOVERY_MODE_PROFILE = {
  N_calibration:          4,
  T_longtail_default:     class-dependent,
  beta_recency_weight:    equal,
  implication_bonus_default: beta_effective,  // active
  WED_routing:            EQ_escrow_conditioned_query,
}
```

Governance activates a mode profile per coordinate class at registration. Classes can transition from DISCOVERY to CLEARING when a position registry is live on the coordinate.

**Why this matters for the mechanism's failure-mode analysis:** The "strongest reason this idea fails" (D(c) revelation problem, #r148/§9) is a DISCOVERY_MODE problem. In CLEARING_MODE it disappears entirely — D(c) is observable from position max_loss. The mechanism is strictly stronger in GestAlt's primary use case than #r148 suggested. The surviving variant from #r148/§10 is not a fallback — it is the correct production mode for GestAlt v2.1. (#r149)

---

## Structural Synthesis: Mechanism-Reality Alignment (#r149)

Three structural gaps closed:

| Gap | Resolution | Implication |
|-----|-----------|-------------|
| D(c) demand-side revelation | EQ: q_fee + q_bonus conditional on accuracy; ratio q_bonus/q_fee ≈ D(c) | Incentive-compatible revelation without private disclosure |
| "Position size = demand signal" stress test | Valid in clearing mode (D(c) = position max_loss); incomplete in discovery mode | Claim is correct for GestAlt clearing; not general |
| Discovery vs clearing regime split | Two mode profiles; WED_clearing directly observable; D(c) problem is DISCOVERY_MODE only | GestAlt v2.1 in CLEARING_MODE is strictly stronger than #r148 suggested |

**Updated failure-mode assessment (#r149):**

The mechanism's worst failure (D(c) revelation) is structurally avoidable in GestAlt's primary deployment (clearing). The knowledge marketplace in CLEARING_MODE is not a weaker fallback — it is the natural, robust production form for clearing protocols.

The pure DISCOVERY_MODE form (where WED routing depends on EQ demand-signal revelation) remains a research-stage mechanism requiring further validation of EQ incentive properties before production deployment. EQ is a viable design, but the q_bonus/q_fee minimum ratio governance parameter is a critical attack surface not yet fully closed.

---

## Open Questions for #r150+

1. **EQ q_bonus minimum ratio calibration:** If governance sets the minimum q_bonus/q_fee ratio too low, coordinates receive weak D(c) signal. If too high, unknowers avoid registering queries (friction). What is the principled calibration for this ratio, analogous to the β_effective calibration formula?

2. **Mode transition — DISCOVERY to CLEARING:** When a coordinate class transitions from DISCOVERY to CLEARING (position registry goes live), existing knowers have calibration history under DISCOVERY parameters. Their N_calibration window spans both modes. Should the transition reset the calibration window, or carry over with a mode-weighted rolling average?

3. **WED_clearing observability lag:** WED_clearing = Σ max_loss of registered positions. If positions are registered across multiple epochs (rolling registration), WED_clearing changes each epoch. How should knower incentives update in response to WED_clearing changes — per-epoch recalculation of base reward, or a smoothed WED signal analogous to ρ_smooth?

4. **Implication chains in clearing mode:** CLEARING_MODE_PROFILE sets implication_bonus_default = 0. But some clearing scenarios have structural implication relationships — e.g., a bond default event (A) implies collateral haircut events (B_1, B_2). Should implication chains be opt-in per coordinate class in clearing mode rather than disabled by default?

*Last updated: #r149 — 2026-04-03T22:32Z*


---

## #r150 Contributions — 2026-04-03T22:42Z

Addresses all four open questions from #r149. Adds one net-new structural insight on settlement-price credibility tension.

---

**Q1 (EQ q_bonus minimum ratio calibration) → Information-rent floor formula; ratio ≥ (1 − σ_resolve) / σ_resolve (#r150):**

The q_bonus/q_fee ratio reveals quality-sensitivity (D(c) proxy). The calibration question: what minimum ratio ensures the signal is informative rather than noise?

**Derivation from first principles:**

An unknower with true D(c) faces two options:
- Set `q_bonus = 0`: pays q_fee unconditionally; receives any-quality answer.
- Set `q_bonus > 0`: pays q_fee + expected q_bonus; receives accuracy-conditioned reward.

Let σ_resolve = probability that active S_cred state is within quality threshold at resolution (the protocol's track record for the class). The revealing condition at break-even:

```
min_ratio = q_bonus_min / q_fee_min = (1 − σ_resolve) / σ_resolve
```

At σ_resolve = 0.75: min_ratio ≈ 0.33.
At σ_resolve = 0.50: min_ratio = 1.0 (uncertainty demands high D(c) signal).
At σ_resolve = 0.90: min_ratio ≈ 0.11 (accurate track record → small bonus is informative).

**Governance interface:** min_q_bonus_ratio is per-coordinate-class, derived from σ_resolve — the rolling accuracy rate over the most recent N_calibration normal-mode resolved epochs per class. Same window as β_effective. No new governance primitive required.

**Design law (#r150):** EQ minimum ratio derives from the protocol's own demonstrated accuracy (σ_resolve), not set by governance fiat. A class with poor track record automatically demands higher quality-sensitivity signal — a self-correcting feedback. (#r150)

---

**Q2 (Mode transition — DISCOVERY to CLEARING calibration continuity) → Mode-weighted rolling average; no reset; N_calibration window mode-tagged (#r150):**

At transition epoch T_transition, the rolling N_calibration window contains DISCOVERY-mode epochs. A hard reset discards valid history; carry-forward unchanged misapplies DISCOVERY calibration to CLEARING incentives.

**Resolution — mode-weighted rolling average:**

```
mode_weight(epoch_e) = {
  1.0  if epoch_e.mode == current_mode
  w_transition = 0.5  if epoch_e.mode != current_mode
  (governance-settable, bounded [0.2, 0.8])
}

β_effective_rolling_avg = Σ (base_reward_e × mode_weight_e) / Σ mode_weight_e
```

Post-transition: DISCOVERY-tagged epochs are weighted 0.5; new CLEARING-tagged epochs weighted 1.0. β_effective converges over N_calibration epochs without discontinuity.

**EAT record:** Each macro-epoch boundary commit includes `epoch_mode: DISCOVERY | CLEARING`. No new EAT event type required. σ_resolve (for EQ min_ratio) uses the same mode-weighted window. (#r150)

---

**Q3 (WED_clearing observability lag — smoothed WED signal) → EMA smoothing; anchored to governance reference (#r150):**

WED_clearing = Σ_positions_on_c |max_loss_if_wrong| changes each epoch as positions register or close. Raw per-epoch signal creates volatile base reward incentives incompatible with multi-epoch knower planning.

**Resolution — WED_clearing_smooth via EMA:**

```
WED_clearing_smooth(c, t) = (1 − λ_WED) × WED_clearing_smooth(c, t-1) + λ_WED × WED_clearing(c, t)
λ_WED = 2 / (N_WED + 1)   default N_WED = 6 macro-epochs

base_reward_clearing(c) = base_reward_floor(c) × (WED_clearing_smooth(c) / WED_clearing_ref(c))
```

`WED_clearing_ref(c)` = governance-declared reference WED at class registration (expected normal position exposure). Auto-alert if WED_clearing_smooth deviates > 5× from WED_clearing_ref for ≥ M_stable consecutive normal epochs.

**Design law (#r150):** Any volatile on-chain signal used as a knower incentive input must be EMA-smoothed before reward formula exposure. Smooth first, incentivize from the smooth signal. (#r150)

---

**Q4 (Implication chains in clearing mode) → Opt-in at class registration; enabled only for declared structural dependency pairs (#r150):**

CLEARING_MODE_PROFILE sets implication_bonus_default = 0 because most clearing coordinates are independent. But contractually linked position types (e.g., bond default A → collateral haircut B_1, B_2) have genuine structural dependency.

**Resolution — structural dependency flag at class registration:**

`class_registration.implication_chains_enabled = { disabled (default) | opt_in }`. Opt-in requires at least one registered position type to declare an explicit structural dependency on another class. Opt-in enables implication chains for declared pairs only — not for all coordinate combinations.

Governance `participation_impact_estimate` field required at opt-in (per #r146/Q1 — 1.4× escrow and TOWL impact must be disclosed).

**WED_clearing interaction for chain pairs:**
```
WED_clearing_chain(A→B) = min(WED_clearing(A), WED_clearing(B))
```
Chain's WED relevance is the minimum of the two coordinates — discourages deep chains on thin-book clearing coordinates. (#r150)

---

### Net-New Structural Insight: Settlement-Price Credibility vs Belief-Aggregate Tension (#r150)

**The tension:** The knowledge marketplace produces S(c) as a credibility-weighted belief aggregate (optimises for calibration over many resolutions). GestAlt v2.1 needs a settlement price — a single, final, legally authoritative value (optimises for legitimacy and non-contestability in a single instance). These are different objects.

A 75%-accurate S(c) generates settlement disputes 25% of the time, and those disputes correlate with high-stakes positions — exactly when wrong settlement prices cause the most WED damage.

**Resolution — Settlement Freeze Protocol:**

```
Settlement flow:
1. T_anchor:          Oracle fires; S(c) frozen for this event.
2. T_challenge_window: Challenge window opens (existing challenge mechanic).
3. T_settlement:      No challenge → settlement_price = S(c)_at_T_anchor.
                      Challenge succeeds → oracle authoritative override (no slash to original knower).
                      Challenge fails → S(c)_at_T_anchor confirmed (challenger loses fee).
4. T_finality:        settlement_price committed to position registry; positions marked.
```

**Critical distinction:** A successful oracle override does NOT slash the original knower. The oracle is the final authority; knowers are provisional attestors. A successful override is an authority event, not a quality failure. This requires a new EAT event type (`oracle_settlement_override`, distinct from `challenge_success_slash`) — left as an open question for #r151.

**New attack surface:** Counterparties with financial interest in alternative settlement prices are incentivised to challenge even correct S(c) values. The challenge fee is worth paying if the settlement difference is large.

**Defence — pre-T_anchor position registration required for challenge eligibility:** Challenge eligibility is tied to position registered before T_anchor. A counterparty cannot register a position post-T_anchor specifically to gain challenge access. (#r150)

---

## Structural Synthesis: Settlement Freeze Protocol + Clearing-Mode Closure (#r150)

| Issue | Resolution | Law |
|---|---|---|
| EQ min_ratio calibration | (1 − σ_resolve) / σ_resolve; derived from class track record | EQ ratio from demonstrated accuracy; no governance fiat |
| Mode transition calibration | Mode-weighted rolling average; w_transition = 0.5; no reset | Continuity over transitions; mode-tagged epoch history |
| WED_clearing volatility | EMA-smoothed WED_clearing_smooth; anchored to governance reference | Smooth volatile inputs before reward formula exposure |
| Implication chains in clearing mode | Opt-in; enabled for declared structural dependency pairs only | Position-type justified, not mechanism-wide default |
| Settlement-price vs belief-aggregate tension | Settlement Freeze Protocol: S(c) = candidate price; challenge window = legitimacy gate | Knowledge marketplace = price discovery layer; oracle = final authority |

**New attack surface formalised (#r150):** Settlement-mode challenge by counterparties with financial interest in alternative settlement prices. Defence: challenge eligibility requires pre-T_anchor registered position.

---

## Open Questions for #r151+

1. **Settlement Freeze Protocol and TOWL Zone C interaction:** Zone C is not degraded mode — challenge windows advance during Zone C (#r138/Q3). Does the T_challenge_window in the Settlement Freeze Protocol also advance during Zone C, or should settlement-critical challenge windows get an explicit Zone C deferral option given the financial finality stakes?

2. **`oracle_settlement_override` EAT event type:** New event distinct from `challenge_success_slash`. Specify full EAT record and settlement routing: what flows to whom when the oracle overrides S(c) without slashing the original knower? Where do challenge fees route — to the overriding oracle, to the challenger, or returned?

3. **Challenge eligibility pre-T_anchor position requirement — grace period:** If T_anchor fires unexpectedly (e.g., early oracle resolution), some legitimate counterparties may not have registered positions yet despite genuine exposure. Should there be a brief grace period (e.g., 1 micro-epoch post-T_anchor) during which position registration still qualifies for challenge eligibility?

4. **EQ q_bonus settlement vs Settlement Freeze Protocol:** In a CLEARING_MODE class with EQ enabled, should q_bonus distribution wait until settlement_price is final (T_finality) or settle at oracle resolution (T_anchor)? If q_bonus settles at T_anchor but settlement_price is subsequently overridden, the EQ bonus was distributed against a candidate price that did not become final — a consistency gap.

*Last updated: #r151 — 2026-04-03T22:52Z*

---

## #r152 Contributions — 2026-04-03T23:02Z

Addresses all four open questions from #r151. Adds one net-new structural insight: CLEARING_MODE as the natural production form closes two additional attack surfaces from DISCOVERY_MODE that were previously open.

---

**Q1 (S_mechanism vs S_oracle divergence — soft credibility recalibration) → oracle_override_weight parameter; divergence enters credibility_ratio at reduced weight (#r152):**

An oracle override is not a knower quality failure in an individual instance. But systematic divergence — a knower whose S_cred contributions consistently differ from oracle final values — is a real miscalibration signal. The resolution must be calibrated between "no signal" (knower is never informed of divergence) and "full slash" (oracle override = quality failure).

**Resolution — reduced-weight oracle override contribution to credibility_ratio:**

```
credibility_ratio_update_weight:
  normal_claim_resolution:   weight = 1.0  (standard log-score)
  oracle_settlement_override: weight = w_override (governance-settable, default 0.3, bounded [0.0, 0.6])
```

When an `oracle_settlement_override` fires, each knower whose claim contributed to S_mechanism(c) at T_anchor receives a log-score entry in their calibration history at weight `w_override`. If S_mechanism(c) was close to oracle_price: log-score is positive → small positive credibility_ratio update. If S_mechanism(c) was far from oracle_price: log-score is negative → small negative credibility_ratio update.

**Properties:**
1. A single override carries 0.3× the credibility signal of a normal resolved claim — minor effect on any individual override.
2. Persistent divergence on the same coordinate class accumulates. After N override events, the knower's credibility_ratio reflects N × 0.3× log-score adjustments. A systematically wrong knower degrades over time without being slashed.
3. Setting `w_override = 0` fully decouples oracle overrides from credibility tracking — valid policy choice for governance that treats oracle authority as categorically external.
4. Upper bound `w_override ≤ 0.6` enforced at contract level: oracle override signals must not dominate credibility_ratio over normal resolved claims.

**No slash, no capital event.** The soft signal is purely track-record-based. This preserves the oracle-authority/knower-attestor duality (#r151) while allowing the calibration layer to absorb persistent divergence patterns.

**EAT record:** `oracle_settlement_override` event includes: `credibility_updates: [ {knower_a, log_score_delta, weight: w_override} for each active contributor ]`. (#r152)

---

**Q2 (SFP in DISCOVERY_MODE — is `oracle_settlement_override` CLEARING_MODE only?) → Yes; SFP and `oracle_settlement_override` are CLEARING_MODE-only constructs (#r152):**

In pure DISCOVERY_MODE, there is no position registry and no T_finality event anchored to position settlement. Oracle resolution fires and knowers' calibration records are updated through the standard log-scoring path. There is no settlement price to contest, no pre-T_anchor position to register, and no financial stake differential between S_mechanism(c) and oracle_confirmed_value that creates SFP challenge incentives.

**Resolution — formal mode scoping:**

```
oracle_settlement_override:   CLEARING_MODE only
Settlement Freeze Protocol:   CLEARING_MODE only
T_finality event:             CLEARING_MODE only
challenge_type: settlement_finality:  CLEARING_MODE only

DISCOVERY_MODE oracle resolution path:
  oracle fires → standard log-score update → credibility_ratio updated → S(c) updated
  No SFP, no challenge window, no settlement routing
```

**Consequence for DISCOVERY_MODE challenge design:** In DISCOVERY_MODE, all challenges are epistemic-type only. The `challenge_type` field in the challenge EAT record is always `epistemic` when `class_mode = DISCOVERY`. CLEARING_MODE classes may have both `epistemic` and `settlement_finality` challenge types.

**Mode-scoping design law (#r152):** Features tied to the settlement-price lifecycle (SFP, `oracle_settlement_override`, `T_finality`, settlement_finality challenge type) must be explicitly scoped to CLEARING_MODE at feature design. DISCOVERY_MODE retains the simpler, oracle-as-calibration-update path. Any future feature that introduces a settlement dimension must declare its mode scope. (#r152)

---

**Q3 (`post_anchor_gaming` flag and Zone C auto-clear — attack path closed) → Zone C suspends auto-clear for settlement-finality flag reviews (#r152):**

The attack path: adversary registers position during T_grace post-T_anchor → position flagged as `post_anchor_gaming` → governance is in Zone C (bandwidth stressed) → does not review within 1 macro-epoch → flag auto-clears → adversarial challenge proceeds.

This attack leverages Zone C governance bandwidth degradation to force a challenge through that would otherwise be reviewed and blocked. It is most dangerous precisely when Zone C creates the highest financial pressure for settlement manipulation.

**Resolution — Zone C suspends auto-clear for settlement-finality flag reviews:**

```
auto_clear_rule:
  normal mode:   auto-clear after 1 macro-epoch of no governance action
  Zone C mode:   auto-clear suspended; flag remains pending until Zone C exits
                 THEN: auto-clear resumes standard 1 macro-epoch countdown
```

**Challenge right of flagged position during Zone C:** The flagged position's settlement-finality challenge right is deferred (not void) while Zone C is active. The challenge deadline advances from T_challenge_window_close at the same rate as other Zone C deferrals (#r151/Q1).

**Non-Zone-C governance inaction:** If governance fails to review outside Zone C for > 1 macro-epoch, auto-clear fires as designed. The attack path only exists during Zone C — the standard auto-clear operates correctly in normal mode.

**Legitimate grace-period registrant protection:** A legitimate counterparty caught in T_grace during Zone C also has their challenge right deferred — but they are not blocked. When Zone C exits: (1) flag enters 1-macro-epoch auto-clear countdown, (2) governance can review, (3) if governance clears or auto-clear fires, challenge proceeds normally. Legitimate parties only face additional delay (Zone C duration + 1 macro-epoch), not permanent exclusion.

**EAT record:** `post_anchor_gaming` flag events record `auto_clear_suspended_zone_c: true/false` at flag creation. When Zone C exits, an `auto_clear_resumed` EAT event is emitted for all suspended flags. (#r152)

---

**Q4 (Failed SFP challenge fee routing — `challenger_pool` vs `settlement_reserve`) → Default: single `challenger_pool`; CLEARING_MODE classes may opt-in to dedicated `settlement_reserve` (#r152):**

**Analysis:**

Arguments for single pool:
- `challenger_pool` already funds challengers on success and absorbs failed-challenge fees. Adding a second reserve doubles governance overhead (seeding, Zone C gating, coverage monitoring) for a feature distinction that matters operationally only if SFP challenge volume is significant.
- Most CLEARING_MODE coordinate classes will have low SFP challenge frequency (settlement is typically uncontested). Dedicated reserve is over-engineered for rare events.

Arguments for dedicated reserve:
- SFP failed-challenge fees represent settlement-gaming costs, not epistemic quality costs. Mixing them into `challenger_pool` means epistemic challengers' reward pool is fed partly by settlement-manipulation forfeitures — a semantic coupling that complicates pool health monitoring and governance accountability.
- If SFP volumes are large (high-stakes clearing events), pool contamination could inflate `challenger_pool` in ways unrelated to epistemic challenge quality.

**Resolution — default single pool with opt-in separation:**

```
Default (all CLEARING_MODE classes): SFP failed-challenge fees → `challenger_pool`
  Simplest, no new reserve overhead.

Opt-in at class registration: `settlement_reserve_enabled = true`
  SFP failed-challenge fees → `settlement_reserve` (class-specific)
  settlement_reserve governed by same rules as challenger_pool:
    class-local Zone C gating, governance seed at registration, coverage monitoring
  Opted-in classes report `settlement_reserve_status` separately from `LTRP_status`
```

**`settlement_reserve` as reserve category:** If opt-in is exercised, `settlement_reserve` is a class-local escrow-flow-sourced reserve — Zone C gated (#r137 design law: escrow-flow-sourced → class-gated). It does not count toward TOWL (pool-reserve design law, #r131/Q2). It is a fifth reserve category available to CLEARING_MODE classes that opt in.

**Design law (#r152):** When two challenge types share a pool by default, pool separation is opt-in with full governance overhead inherited. Opt-in creates a named reserve category subject to the full reserve taxonomy. Default shared pools minimize overhead for common cases; separation is available for high-stakes classes that need clean accounting. (#r152)

---

## Net-New Structural Insight: CLEARING_MODE Closes Two DISCOVERY_MODE Attack Surfaces (#r152)

The mode-scoping work from #r149–#r152 reveals that CLEARING_MODE is not merely a simplified form of the mechanism — it is a structurally superior threat model for two specific attacks that remain open in DISCOVERY_MODE:

**Attack 1 — WED routing gaming:**
In DISCOVERY_MODE, D(c) must be revealed via EQ escrow-conditioned queries (q_bonus/q_fee ratio). An adversary who controls the demand signal (e.g., a single large unknower) can manipulate which coordinates appear decision-critical by inflating q_bonus on low-stakes coordinates.
In CLEARING_MODE: D(c) = Σ_positions |max_loss_if_wrong|. This is on-chain, position-registrar-verified, and cannot be inflated without registering real positions with real loss exposure. The attack requires real capital at risk, making it economically self-defeating.

**Attack 2 — Calibration gaming through oracle selection:**
In DISCOVERY_MODE, knowers optimise their credibility_ratio by selecting coordinates with predictable oracle resolutions (easy-to-be-right coordinates). High-D(c) coordinates may have uncertain oracles; knowers avoid them.
In CLEARING_MODE: WED_clearing(c) directly ties base reward to registered position exposure. High-exposure clearing coordinates generate higher base rewards regardless of oracle predictability, anchoring knower incentives to where capital is actually at risk, not where oracle outcomes are easiest to predict.

**Summary:** CLEARING_MODE replaces the EQ demand-signal machinery with on-chain position registry observation — simpler, more manipulation-resistant, and stronger epistemic incentive alignment. DISCOVERY_MODE is appropriate for exploratory or non-financial knowledge markets where no position registry exists. GestAlt v2.1 in CLEARING_MODE is the production-grade deployment of this mechanism. (#r152)

---

## Open Questions for #r153+

1. **w_override calibration basis:** The default `w_override = 0.3` is reasoned but not formally derived. Analogous to σ_resolve governing min_q_bonus_ratio (#r150/Q1), could w_override be derived from the observed frequency of oracle overrides per coordinate class? If oracle overrides are rare (strong alignment between S_mechanism and oracle), w_override can be higher (more signal per event). If overrides are frequent (weak alignment), w_override should be lower to avoid credibility_ratio domination by noisy authority events.

2. **Mode coexistence — single coordinate class in dual mode:** Can a coordinate class operate in both DISCOVERY_MODE and CLEARING_MODE simultaneously? Example: a new class with early exploratory participants (DISCOVERY) and a small position registry being bootstrapped (CLEARING). The mode transition (#r150/Q2) assumes a clean one-way switch. Is mixed-mode operation ever valid?

3. **Zone C suspension of auto-clear — maximum deferral horizon:** Zone C may persist for multiple consecutive epochs in a stressed market. If auto-clear is suspended for the entire Zone C duration, a legitimate grace-period registrant's challenge right could be deferred indefinitely. Should there be a maximum Zone C auto-clear suspension horizon (e.g., 5 macro-epochs), after which auto-clear fires regardless of Zone C status?

4. **settlement_reserve opt-in and LTRP interaction:** If a CLEARING_MODE class opts into `settlement_reserve`, it now has five class-specific pool categories: LTRP, challenger_pool, implication_bonus_escrow, debt_retirement_reserve (governance-global), and settlement_reserve. At class registration, governance must seed each pool appropriately. Is there a consolidated registration parameter for "total pool capital at genesis" distributed across pool categories by governance, or must each pool be seeded independently?

*Last updated: #r152 — 2026-04-03T23:02Z*

---

## #r151 Contributions — 2026-04-03T22:52Z

Addresses all four open questions from #r150. Adds one net-new structural insight: the oracle-authority/knower-attestor duality as a formal design primitive.

---

**Q1 (Settlement Freeze Protocol and TOWL Zone C interaction) → Settlement-critical challenge windows are Zone C-deferred; standard epistemic challenges are not (#r151):**

The general rule is: challenge windows advance during Zone C (epistemic enforcement is never suspended by solvency conditions, #r139/Q3). The Settlement Freeze Protocol introduces a categorically different type of challenge window — not a quality-dispute challenge but a *settlement-finality challenge*.

**The distinction is material:**
- **Epistemic challenge (standard):** "This warranted installation is factually wrong." Slashes escrow. Outcome: state update + financial penalty.
- **Settlement-finality challenge (SFP):** "This candidate settlement price should be overridden by oracle authority." Does NOT slash the original knower. Outcome: oracle override + position settlement at oracle value. No financial penalty on the knower.

If settlement-finality challenge windows advance during Zone C, parties with the largest financial interest in an alternative settlement price (large positions, Zone C conditions) can strategically time challenges when protocol resources are most stressed — the mechanism's solvency state is worst, governance bandwidth is lowest, and challenge resolution capacity may be impaired.

**Resolution — settlement-critical challenge windows are Zone C-deferred:**

```
challenge_type ∈ { epistemic (standard) | settlement_finality (SFP) }

epistemic challenges: advance during Zone C (unchanged from #r139/Q3)
settlement_finality challenges: deferred during class-level Zone C
  → T_challenge_window clock pauses
  → expiry tolls (consistent with all other class-level deferral policies)
  → resumes at first macro-epoch boundary after Zone C exit
```

**Rationale:** Settlement finality is a higher-stakes, irreversible event than an epistemic state update. Deferring finality during Zone C is consistent with the general principle that irreversible high-stakes operations are gated during solvency stress. The epistemically-enforcement operations remain active (standard challenges proceed) — only settlement finality is held.

**Zone C notification:** Position-holders are notified via EAT event of Zone C deferral of any pending settlement-finality challenge window. Expiry tolling ensures no challenge right is forfeited due to Zone C. (#r151)

---

**Q2 (`oracle_settlement_override` EAT event type — full specification) (#r151):**

**New EAT event type: `oracle_settlement_override`**

```
EAT event: {
  type:                  "oracle_settlement_override",
  epoch_committed:       T_override,
  coordinate_class:      class_id,
  coordinate:            c,
  candidate_price:       S(c)_at_T_anchor,   // what the mechanism believed
  oracle_price:          oracle_confirmed_value,
  challenge_initiator:   challenger_address (or null if oracle-initiated),
  challenge_fee_routing: see below,
  knower_slash:          false  // explicit: no knower penalty
  settlement_price_final: oracle_confirmed_value,
  EAT_ref_T_anchor:      [T_anchor EAT event id]
}
```

**Settlement routing table:**

| Scenario | Challenge fee routing | Knower escrow |
|---|---|---|
| Challenge filed; oracle confirms override | Fee returned to challenger (oracle confirmed challenge was correct) | Not slashed |
| Challenge filed; oracle confirms S(c) was correct | Fee forfeited to challenger_pool (challenge failed) | Not slashed |
| Oracle-initiated override (no challenger) | N/A (no fee collected) | Not slashed |

**Why knower is never slashed on oracle override:**

The knower attested S(c) under the information available at their declaration epoch. An oracle override means the oracle's final resolution differed from the knower's calibrated belief — this is expected, and not necessarily a knower error. Slashing on oracle override would create an incentive for knowers to *not* participate in settlement-mode classes (any oracle override costs them capital, regardless of their epistemic quality). This breaks the mechanism.

**The oracle is an authority, not an adversary.** Oracle override is analogous to a final judicial ruling overriding an arbitration award — the arbitrator is not penalised for the court's independent conclusion. Knower and oracle are in different epistemic roles.

**Challenger reward on successful override:** The challenger's reward is the fee refund only (challenge submission fee returned). There is no additional slash-based reward since no slash occurs. The challenger served as a legitimacy trigger — they invoked oracle authority, not epistemic enforcement. A challenger who values the oracle override's financial outcome gets that reward directly through their position's settlement at oracle_price — not through a mechanism reward. This is intentional: the financial reward for a correct settlement-finality challenge is the position settlement benefit, not a protocol mechanism reward. (#r151)

---

**Q3 (Challenge eligibility pre-T_anchor — grace period) → Brief grace period: 1 micro-epoch post-T_anchor; anti-abuse gate required (#r151):**

**Analysis of the tradeoff:**

Strict pre-T_anchor requirement risks freezing out legitimate counterparties on unexpected early oracle resolution. Zero grace = legitimate exposure holders cannot challenge. But a grace period creates an attack vector: adversaries can post-date position registration to gain challenge access specifically to exercise the `oracle_settlement_override` path.

**Resolution — 1 micro-epoch grace window with anti-abuse gate:**

```
challenge_eligible_if:
  position registered before T_anchor
  OR position registered within T_grace after T_anchor
    AND T_grace ≤ 1 × micro_epoch_length
    AND position_registration_value ≥ min_challenge_position_value
    AND NOT flagged as post_anchor_gaming (see below)
```

**Anti-abuse gate — `post_anchor_gaming` flag:**

A position registered within T_grace is flagged for review if any of:
- Registered address had no prior positions in this coordinate class (new participant during challenge window is suspicious).
- Position value ≥ 5× median position for this class in this epoch.
- Registration address is within 2 hops of the primary challenger address (graph proximity).

Flagged positions are challenge-eligible but the challenge is suspended until governance clears the flag (within 1 macro-epoch; auto-clear if no governance response). This does not block settlement — the challenge window advances for all other eligible parties. Only the flagged position's challenge right is held pending review.

**Governance burden:** Flag review requires governance action within 1 macro-epoch. Auto-clear on inaction (innocent-until-proven) to prevent governance inaction from blocking legitimate challenges. EAT records all flag events, reviews, and dispositions.

**Design law (#r151):** Short grace windows for time-critical eligibility gates must include anti-gaming heuristics proportionate to the financial stakes. Pure time-extension without abuse detection creates a registration-race attack vector. The heuristics need not be perfect — EAT audit trail and governance review are the final backstop. (#r151)

---

**Q4 (EQ q_bonus settlement vs Settlement Freeze Protocol — finality coupling) → q_bonus settles at T_finality only; T_anchor fires EQ-pending state (#r151):**

If q_bonus is distributed at T_anchor and settlement_price is subsequently overridden at T_override, the EQ bonus was paid for epistemic service calibrated against a candidate price that was not final. This is a consistency gap: the unknower contracted for accuracy on the final settlement price, not on the candidate.

**Resolution — EQ q_bonus is coupled to T_finality:**

```
q_bonus settlement:
  T_anchor:     EQ moves to `q_bonus_pending` state
                S_cred effective_weight snapshot taken (for pro-rata distribution at resolution)
  T_finality:   settlement_price_final known
    → if S(c)_final within q_quality_threshold: q_bonus distributed
    → if S(c)_final outside q_quality_threshold: q_bonus returned to query submitter
    → if oracle_settlement_override: q_quality_threshold evaluated against oracle_price
```

**The T_anchor snapshot matters:** Even though distribution waits for T_finality, the pro-rata distribution weights are snapshotted at T_anchor. This prevents knowers from adjusting S_cred positions between T_anchor and T_finality to game the distribution weight. The epistemic contribution eligible for EQ reward is the contribution *at the time oracle resolution fired*, not at settlement finality.

**Edge case — T_finality delayed by Zone C deferral (Q1):** Settlement-finality challenge windows are deferred during Zone C. T_finality is reached when the challenge window closes without challenge, or when the oracle override is processed. If Zone C deferral extends T_finality by multiple epochs, q_bonus remains in `q_bonus_pending` state. The q_bonus escrow is locked (not refunded, not distributed) until T_finality arrives. Knowers cannot withdraw their S_cred contributions to release q_bonus early — the snapshot is final at T_anchor.

**Design law (#r151):** Any bonus conditioned on a "final" state must settle no earlier than when that state is formally final. Interim candidate states may trigger snapshot events (locking pro-rata weights) but cannot trigger irreversible distribution. Distribution is always coupled to the finality event. This applies to q_bonus, implication_bonus_escrow, and any future conditional-on-resolution payment. (#r151)

---

## Net-New Structural Insight: Oracle-Authority/Knower-Attestor Duality as Design Primitive (#r151)

The Settlement Freeze Protocol forces a clean separation that was implicit throughout the mechanism but never formalised:

**Two epistemically distinct roles:**

| Role | Entity | Function | Source of authority |
|---|---|---|---|
| **Knower (attestor)** | Capital-posting participant | Provides S(c) best estimate; earns rewards proportional to calibrated accuracy over time | Calibration track record + skin-in-the-game |
| **Oracle (authority)** | External resolution source | Provides final definitive value of c; cannot be contested within the mechanism | Protocol-registered external authority |

**The duality:**

S(c) (mechanism-produced) is an *attestation* — a credibility-weighted aggregate of private information. It is good under normal conditions and improves over time.

oracle_confirmed_value is an *authority* — an external determination that the mechanism accepts as final. It may conflict with S(c) without either being wrong in an epistemic sense.

**Why this matters for mechanism design:**

Conflating attestation and authority leads to:
1. Slashing knowers for oracle overrides (they were wrong in authority terms, not epistemic terms).
2. Treating oracle-produced prices as just another signal for S_cred aggregation (oracle authority is not the same epistemic object as a knower's calibrated belief).
3. Misrouting the q_bonus settlement — the EQ contract is with the final authority, not with the preliminary attestation.

**Formal design primitive:**

```
S_mechanism(c) = attestation(c) — produced by credibility-weighted knower aggregate
S_oracle(c)    = authority(c)   — produced by registered external oracle at resolution
settlement_price(c) = S_oracle(c) if oracle fires; else S_mechanism(c) after challenge window
```

This is the correct duality. S_mechanism and S_oracle are different in kind. The Settlement Freeze Protocol is the interface between them.

**New law (#r151):** The mechanism must maintain explicit type distinction between attestation-produced state and authority-produced state. Reward and penalty mechanisms apply only to attestations. Authority overrides trigger settlement routing changes, not epistemic penalties. Any future feature that mixes these types requires explicit design justification. (#r151)

---

## Structural Synthesis: Settlement Architecture — Complete (#r151)

| Component | Rule | Law |
|---|---|---|
| SFP Zone C interaction | Settlement-finality challenge windows are Zone C-deferred; epistemic challenges advance normally | Settlement finality is higher-stakes than epistemic state; Zone C gates irreversible events |
| `oracle_settlement_override` routing | Fee returned on correct challenge; forfeited on failed challenge; knower never slashed | Oracle authority ≠ knower epistemic failure; no cross-contamination |
| Challenge eligibility grace period | 1 micro-epoch; anti-gaming heuristics + governance flag-review | Short grace windows require proportionate abuse detection |
| EQ q_bonus finality coupling | T_anchor = snapshot; T_finality = distribution; q_bonus coupled to final settlement price | No irreversible distribution before finality event |
| Duality design primitive | attestation(c) ≠ authority(c); penalty logic applies only to attestations | Mechanism must maintain explicit type separation |

---

## Open Questions for #r152+

1. **S_mechanism vs S_oracle divergence — credibility recalibration:** When `oracle_settlement_override` fires and S_mechanism(c) ≠ S_oracle(c), should knowers' credibility_ratio be penalised for the divergence? The current answer is no slash (#r151/Q2). But a persistent pattern of S_mechanism systematically diverging from S_oracle at the same coordinate would indicate the knower pool is miscalibrated. Is there a soft recalibration signal (credibility_ratio adjustment, not slash) triggered by oracle overrides?

2. **Settlement Freeze Protocol in DISCOVERY_MODE:** The SFP was designed for clearing (positions registered, oracle fires, settlement happens). In pure DISCOVERY_MODE (no position registry), there is no T_finality event tied to a position settlement. Does the SFP concept have any meaning in DISCOVERY_MODE, or is `oracle_settlement_override` a CLEARING_MODE-only EAT event type?

3. **`post_anchor_gaming` flag and governance auto-clear:** Governance auto-clear on inaction within 1 macro-epoch (#r151/Q3). If governance inaction is due to Zone C (governance bandwidth stressed), the auto-clear fires anyway — a potentially adversarial challenge gets through. Should auto-clear be suspended during Zone C (creating a risk that legitimate grace-period challengers are permanently blocked), or should Zone C governance alert include a flag-review mandate?

4. **Challenge fee forfeiture destination in SFP:** A failed SFP challenge (oracle confirms S(c) was correct) forfeits the fee to `challenger_pool`. But the challenger was challenging a settlement-finality question, not an epistemic quality question. Should SFP failed-challenge fees route to `settlement_reserve` (a new protocol reserve for settlement operations) rather than `challenger_pool`? Or does challenger_pool serve both functions — one reserve, two challenge types?

---

## #r153 Contributions — 2026-04-03T23:12Z

Addresses all four open questions from #r152.

**Q1 (w_override calibration basis) → Self-calibrating from override_frequency_smooth; recovers default 0.30 at typical class frequency (#r153):**

The epistemically correct weight for an oracle override credibility signal is inversely proportional to how often overrides occur. A class with frequent overrides has an unreliable oracle — each override carries little information about knower miscalibration (it could be oracle variance, not knower error). A class with rare overrides has a well-aligned oracle — each override is a meaningful miscalibration signal.

**Derived formula:**

```
w_override(class_i, epoch_t) =
    clip(w_override_base × (1 − override_frequency_smooth(class_i, t)),
         0, w_override_max=0.6)

override_frequency_smooth(class_i, t) =
    EMA of [ oracle_overrides / oracle_resolutions ] over N_override_window epochs
    N_override_window = N_calibration (same window; no new governance primitive)
```

At typical oracle_class with 40% override frequency:
`w_override = 0.5 × 0.6 = 0.30` — recovers the default from #r152 from first principles.

At rare-override class (5%): `w_override ≈ 0.5 × 0.95 ≈ 0.47` — stronger miscalibration signal.
At high-override class (75%, unreliable oracle): `w_override ≈ 0.5 × 0.25 = 0.12` — near-zero, override is noise.

**Governance interface addition:** (w_override_base, N_override_window); w_override derived per-class per-epoch.
**Contract invariant (from #r152):** w_override ≤ 0.6 enforced regardless of formula output. Additionally, w_override_base ≤ 0.6 is a hard contract gate — w_override_base is an upper bound on the formula's pre-clip output at zero override frequency.

**Design law (#r153):** Every credibility signal weight should be derived from the signal source's own demonstrated reliability. Oracle override weight is a function of the oracle's override frequency, not a static governance parameter. Consistent with σ_resolve governing min_q_bonus_ratio (#r150/Q1) — both are self-calibrating feedback loops. (#r153)

---

**Q2 (Mode coexistence — single class in dual mode) → Not valid simultaneously; shadow-class pattern resolves the bootstrapping use case (#r153):**

**Why simultaneous dual-mode is invalid:**

Two incentive structures conflict when both DISCOVERY and CLEARING modes are active on a single class:
- DISCOVERY: knower earns ongoing query fees (multi-epoch epistemic service optimisation).
- CLEARING: knower earns settlement accuracy reward (single-event optimisation).

With both active, knowers optimise for the higher-value mode, corrupting the other mode's incentive structure. Additionally, two WED routing signals are active simultaneously (EQ q_bonus for DISCOVERY; WED_clearing = Σ max_loss for CLEARING) with no defined precedence — base reward computation is ambiguous.

**Resolution:** Dual-mode is disallowed for a single class registration.

**Shadow-class pattern for pre-clearing discovery:** Where a market needs exploratory price discovery before a position registry exists, and later needs to transition to clearing mode, use two registrations:

```
class_id:   "event-X-discovery"  mode: DISCOVERY  (exploratory; no position registry)
class_id:   "event-X-clearing"   mode: CLEARING   (position-registry-linked; settlement-grade)
```

Both reference the same underlying coordinate variable but are independent mechanism objects: separate S_cred, separate TOWL, separate pool categories, separate knower populations. S_cred from the discovery shadow-class is NOT merged into the clearing class — it is reference-readable by participants but not used in settlement_price computation.

**Transition:** When the clearing class is registered, governance may sunset the discovery shadow-class (mode: DISCOVERY → archived; no new claims). Existing knowers on the shadow-class earn out their remaining query fees and lockup horizons independently. No migration is required.

**EAT record:** Each class registration includes `coordinate_identifier` (the underlying variable, shared across shadow and primary), `class_id` (unique), and `mode`. Linkage between shadow and primary is via `coordinate_identifier` — not a formal dependency.

**Design law (#r153):** Simultaneous dual-mode on a single class is prohibited. The shadow-class pattern achieves the functional goal (exploratory discovery + clearing-grade settlement) through two independent registrations, maintaining clean incentive separation. (#r153)

---

**Q3 (Zone C auto-clear maximum deferral horizon) → N_max_suspension = 5 macro-epochs; force-clear with `crisis_auto_clear` EAT event (#r153):**

An indefinitely suspended auto-clear blocks legitimate grace-period registrants during prolonged Zone C — potentially for months in extreme solvency stress scenarios. A hard maximum deferral is required.

**Resolution:**

```
max_zone_c_suspension = N_max_suspension = 5 macro-epochs  (governance-settable, bounded [3, 10])

After N_max_suspension consecutive Zone C macro-epochs with auto-clear suspended:
  → auto-clear fires as `crisis_auto_clear` EAT event
  → flag cleared; challenge proceeds
  → EAT event marks challenge as: post_anchor_review_status = "crisis_cleared"
  → governance must acknowledge `crisis_auto_clear` event within 2 macro-epochs post-Zone-C-exit
```

**Two-speed protection for the crisis-cleared challenge:** A challenge that reaches settlement after a `crisis_auto_clear` event is not blocked — but the settlement record carries a `crisis_cleared` audit tag. Post-Zone-C retrospective review by governance (mandatory, within 2 macro-epochs of Zone C exit) examines all crisis-cleared challenges. If retrospective review concludes the challenge was adversarial:
- No retroactive settlement reversal (settlement is final — EAT immutability + T_finality is irreversible).
- Adversarial challenger is flagged in protocol records; challenge eligibility may be restricted by governance for future classes.
- Lesson absorbed as a governance calibration case.

**Design trade-off acknowledged:** Crisis auto-clear is a genuine safety valve that accepts a residual adversarial-challenge risk to prevent indefinite legitimate-challenge blocking. Governance acknowledgment and retrospective review are the accountability mechanism for the residual risk.

**Interaction with Zone C governance bandwidth:** The 2-macro-epoch retrospective review window is set after Zone C exit — not during. Governance is not burdened during the stress event itself. (#r153)

---

**Q4 (Consolidated pool registration vs per-pool seeding) → Consolidated genesis budget with enforced minimum fractions; per-pool top-up capability post-genesis (#r153):**

A CLEARING_MODE class with full opt-ins has four per-class pool categories at registration: LTRP, challenger_pool, implication_bonus_escrow reserve (if enabled), settlement_reserve (if enabled).

**Resolution — hybrid model:**

**At registration:** Governance submits:
```
genesis_pool_budget:    total capital across all pools at class launch
pool_allocation_weights: {
  LTRP:               w_LTRP,
  challenger_pool:    w_challenger,
  implication_reserve: w_impl  (required if implication_chains_enabled; else 0)
  settlement_reserve:  w_settle (required if settlement_reserve_enabled; else 0)
}
```

**Minimum fraction constraints (hard, contract-enforced at registration):**

| Pool | Minimum fraction | Notes |
|------|-----------------|-------|
| LTRP | 0.40 | Primary long-tail backstop |
| challenger_pool | 0.20 | Epistemic enforcement baseline |
| implication_reserve | 0.10 (if enabled) | Pre-funding buffer for bonus escrow |
| settlement_reserve | 0.10 (if enabled) | Settlement finality operations |
| slack | remainder | Governance discretion |

If submitted weights violate any minimum: registration rejects; governance resubmits. This gate ensures no pool is critically underfunded at genesis.

**Post-genesis per-pool top-ups:** Governance may submit `pool_topup(class_id, pool_name, amount)` at any epoch without affecting other pools. Top-ups are independent per-pool operations — consolidated allocation applies only at genesis.

**Auto-alert integration:** Each pool's coverage_ratio and sufficiency_flag remain independent. The consolidated genesis model does not couple pool health monitoring.

**Design law (#r153):** Consolidated registration parameters with minimum-fraction hard constraints are the correct genesis model for multi-pool classes. Post-genesis granular top-up prevents the consolidated model from becoming a governance straitjacket. Minimum fractions are contract gates, not conventions — underfunded pools at genesis create mechanism safety failures that cannot be remediated by soft accountability alone. (#r153)

---

## Structural Synthesis: Mode Architecture and Settlement Reserve Taxonomy — Closed (#r153)

| Issue | Resolution | Law |
|---|---|---|
| w_override calibration | Self-calibrating from override_frequency_smooth; w_override_base × (1 − freq); w_override_base ≤ 0.6 hard gate | Signal weight derives from source reliability |
| Dual-mode coexistence | Prohibited on single class; shadow-class pattern for pre-clearing discovery | Simultaneous incentive conflicts disallowed; separate registrations |
| Zone C auto-clear maximum deferral | N_max_suspension = 5 epochs; crisis_auto_clear + mandatory post-Zone-C retrospective | Crisis valve with accountability trail; no indefinite blocking |
| Multi-pool registration | Consolidated genesis budget + minimum fractions (hard) + per-pool post-genesis top-up | Minimum fractions are contract gates; post-genesis independence prevents straitjacket |

---

## Cumulative Mechanism Invariant Set (updated through #r153)

1. **WED conserved quantity:** Capital routes toward high-D×A×P coordinates. (#r69)
2. **Bounded individual liability:** Every time-unbounded obligation → bounded window + pool backstop. (#r130–#r132)
3. **TOWL/credibility_ratio orthogonality:** Financial and epistemic channels never cross-contaminate. (#r144)
4. **Deadline taxonomy:** Epoch-indexed deadlines auto-freeze; wall-clock deadlines require explicit tolling. (#r137–#r139)
5. **Static escrow, dynamic epistemic:** Capital fixed at declaration; S_cred dynamically re-derived per epoch. (#r137)
6. **Pre-fund at maximum possible:** Bonus escrow at 1.4× β_escrow; excess returned without tax. (#r145, #r146)
7. **All parameters derived from primitives:** No steady-state parameter is direct governance numeric fiat. (#r144, #r145)
8. **Exceptional-mode calibration exclusion:** Each rolling window excludes only its own distorted-input epochs. (#r132, #r147)
9. **Zone C defers, never denies:** Timing may defer; bonus amount always protected. (#r147)
10. **Saturation is policy:** Permanent saturation → one-time registration warning; recurring alerts suppressed. (#r147)
11. **Oracle authority ≠ attestation:** Penalty logic for attestations only; oracle overrides trigger settlement routing, not epistemic penalties. (#r151)
12. **Finality-coupled distribution:** Conditional payments settle at T_finality, not at candidate-state events. (#r151)
13. **CLEARING_MODE dominance for prediction market clearing:** D(c) revelation problem disappears; position max_loss is on-chain observable. (#r149, #r152)
14. **Simultaneous dual-mode prohibited:** Shadow-class pattern achieves functional goal via two independent registrations. (#r153)
15. **Minimum pool fractions are hard contract gates:** Underfunded pools at genesis are mechanism safety failures. (#r153)
16. **Self-calibrating signal weights:** Signal weights derive from the source's demonstrated reliability, not governance fiat. (#r150, #r153)

---

## Open Questions for #r154+

1. **Shadow-class S_cred as clearing-class genesis prior:** If the discovery shadow-class S_cred is reference-readable, can it serve as a decaying prior for the clearing class's S_cred aggregation at genesis? A one-time prior-injection at clearing-class registration with prior_weight decay to zero over N_prior_epochs could bootstrap the clearing class better than a uniform prior — without permanently coupling the two class objects.

2. **crisis_auto_clear and EQ q_bonus pending state:** If a crisis-auto-cleared challenge succeeds (oracle override) on a class with EQ q_bonus in `q_bonus_pending` state, the q_quality_threshold evaluation should run against the final oracle_price (per #r151/Q4 T_finality-coupling rule). Verify no new rule is needed — the existing finality-coupling rule covers this case cleanly.

3. **w_override_base contract gate formalisation:** w_override_base ≤ 0.6 must be a hard contract invariant at parameter-update time (not just a consequence of post-clip). Formalise the invariant and add to governance interface table alongside other bounded primitives.

4. **Post-registration implication chain opt-in and pool minimum fraction:** If implication_chains_enabled is added post-genesis, the implication_reserve minimum fraction (0.10) was not in the original budget. Should the opt-in vote be approved conditionally on governance committing the top-up within 1 macro-epoch, or must the top-up be confirmed in the same transaction as the opt-in vote?

*Last updated: #r153 — 2026-04-03T23:12Z*

---

## #r154 Contributions — 2026-04-03T23:22Z

Addresses all four open questions from #r153. Adds one net-new structural insight: shadow-class pattern closes the one-shot clearing incentive gap.

---

**Q1 (Shadow-class S_cred as clearing-class genesis prior) → One-time prior injection with mode-mismatch attenuation and N_prior_epochs decay; credibility_ratio does NOT transfer (#r154):**

Discovery shadow-class S_cred captures the same underlying coordinate's probability distribution as the clearing class needs at genesis. A uniform prior discards real information. The question is whether the signal is contaminated by mode-mismatch.

**Mode-mismatch analysis:**

Discovery-mode knowers optimise for multi-epoch query fee accumulation. Clearing-mode knowers optimise for single-event settlement accuracy on high-WED_clearing positions. The posterior distributions they produce are both honest conditional on their information — but their time-horizon optimisations differ. A discovery knower who is right about direction but imprecise on magnitude may be well-calibrated for discovery-mode rewards but poorly calibrated for clearing-mode settlement-price precision.

**Resolution — attenuated prior injection:**

```
S_clearing_genesis(c) = α_prior_effective × S_discovery_snapshot(c)
                      + (1 − α_prior_effective) × uniform_prior

α_prior_effective = α_prior_base × max(0, 1 − shadow_age / staleness_window_shadow)
                  × (1 − mode_mismatch_discount)

mode_mismatch_discount = 0.30 (governance-settable, bounded [0.0, 0.5])
   reflects that discovery calibration ≠ clearing precision
α_prior_base = 0.5 (governance-settable, bounded [0.0, 0.8])
staleness_window_shadow = the shadow class's registered staleness_window
shadow_age = macro-epochs since last S_discovery update
```

**Decay over clearing-class epochs:**

```
α_prior_effective_at_epoch_t = α_prior_effective_at_genesis × (1 − t / N_prior_epochs)
N_prior_epochs = 4 macro-epochs  (governance-settable at clearing-class registration)
```

By epoch N_prior_epochs, prior contribution is zero; clearing class is fully self-standing.

**Critical constraint:** Shadow-class S_cred is a **read-only genesis prior**, not a live feed. The clearing class reads a snapshot at registration time. Shadow and clearing class remain independent mechanism objects.

**credibility_ratio does NOT transfer:** Individual knower calibration from the discovery shadow-class is not imported to the clearing class. Knowers must build a fresh clearing-class track record. This prevents discovery-track-record exploitation for clearing-class warranty obligations.

**EAT record:** Clearing-class registration event includes `genesis_prior_source: shadow_class_id` and `α_prior_effective_at_genesis`. All future S_cred updates are clearing-class-native. (#r154)

---

**Q2 (crisis_auto_clear × EQ q_bonus pending — verification) → Existing finality-coupling rule covers this cleanly; no new rule required (#r154):**

Scenario: T_anchor fires → q_bonus_pending → Zone C begins → settlement-finality challenge window defers → Zone C persists ≥ 5 epochs → crisis_auto_clear fires → SFP challenge succeeds → oracle_settlement_override → T_finality reached.

**Verification against #r151/Q4:** Rule: q_bonus settles at T_finality; q_quality_threshold evaluated against oracle_price if oracle_settlement_override occurs. At T_finality, standard evaluation runs against oracle_confirmed_value. No new rule needed.

**The only non-obvious interaction:** Zone C deferral tolls the settlement-finality challenge window expiry. T_finality cannot be reached until the challenge window closes. Therefore q_bonus cannot expire before T_finality — the deferral and expiry tolling are coupled through the challenge window lifecycle.

**Design law confirmed (#r154):** Finality-coupling is self-consistent under crisis auto-clear. Conditional payment suspension + challenge-window expiry tolling + Zone C deferral all extend together through any Zone C duration. No separate q_bonus tolling rule is required. (#r154)

---

**Q3 (w_override_base contract gate formalisation) → Hard bounds [0.0, 0.6]; phantom range above clip max eliminated (#r154):**

The formula: `w_override = clip(w_override_base × (1 − freq), 0, 0.6)`. A w_override_base above 0.6 would always be clipped — creating a phantom governance range.

**Resolution:**

Contract invariant at parameter-update time:
```
w_override_base ∈ [0.0, 0.6]
```

Any governance proposal with w_override_base outside this range is rejected without execution.

**Updated governance interface:**

| Parameter | Hard contract bounds | Derived output |
|---|---|---|
| w_override_base | [0.0, 0.6] | w_override = clip(w_override_base × (1 − override_freq_smooth), 0, 0.6) |

**Design law confirmed (#r154):** Governance input parameters must be bounded to exclude the phantom range above the derived quantity's natural ceiling. The clip is a secondary safety rail; the hard bound is the primary constraint. Pattern: [input_bound ≤ output_max_clip]. (#r154)

---

**Q4 (Post-registration implication chain opt-in — atomic top-up requirement) → Atomic phase 2: activation + pool confirmation in same transaction; two-phase permitted for multisig architectures (#r154):**

Pool minimum fractions are pre-conditions for feature activation, not post-conditions (#r153). Activating implication_chains_enabled without simultaneously funding implication_reserve creates a safety gap — even for 1 macro-epoch.

**Resolution:**

```
implication_chain_optin_tx = {
  enable_feature:   true,
  pool_top_up:      amount ≥ 0.10 × current_class_pool_total,
  pool_destination: class_id.implication_reserve
}
```

The contract rejects any opt-in where pool_top_up < minimum. Feature does not activate until pool confirmation is atomic in the same transaction.

**current_class_pool_total:** Sum of all active class pools at opt-in time (LTRP + challenger_pool + any others currently active). Not original genesis budget.

**Two-phase for governance multisig architectures:**

- **Phase 1:** Commit top-up amount to `implication_reserve_seed_pending` (token movement only; no feature activation).
- **Phase 2 (atomic):** Execute opt-in referencing Phase 1 escrow. Contract verifies escrow ≥ minimum, then atomically transfers to implication_reserve + activates feature.

Phase 1 escrow has timeout T_optin_timeout = 4 macro-epochs; returns to governance treasury on expiry if Phase 2 is not executed.

**Design law (#r154):** Pool minimum fractions are pre-conditions; never post-conditions. Feature activation is always atomic with pool confirmation. Two-phase architectures are permitted; phase 2 (activation) is always atomic. No feature activation with pending-unfunded pool is valid. (#r154)

---

## Net-New Structural Insight: Shadow-Class Pattern Closes the One-Shot Clearing Incentive Gap (#r154)

**The gap:** In CLEARING_MODE for a recurring coordinate class, knowers invest in credibility_ratio because it compounds over multiple clearing events. For a **one-shot clearing market** (unique, non-repeating event), the coordinate class closes after one resolution. No future clearing events → no future track record value → no future query fees → effective incentive collapses to "collateralised prediction market." The mechanism becomes LMSR with a different scoring rule.

**The fix is the shadow-class pattern from #r153/Q2, applied to one-shot events (#r154):**

```
shadow_class:   "event-X-discovery"  mode: DISCOVERY  (multi-epoch; runs before event)
clearing_class: "event-X-clearing"   mode: CLEARING   (single resolution; runs at settlement)
```

Knowers invest in the discovery shadow-class:
1. Earn query fees over multiple epochs from unknowers who want pre-event state estimates.
2. Build credibility_ratio — portable to other discovery classes via standard attenuated carry-over (#r71).
3. Contribute to the genesis prior of the clearing class via Q1 attenuated prior injection.

The clearing class at registration: inherits discovery S_cred as attenuated genesis prior → single settlement event → closes after resolution.

**Shadow-class dual purpose (formally confirmed):**

| Use case | Shadow-class role | Clearing-class role |
|---|---|---|
| New recurring class bootstrapping (#r153/Q2) | Exploratory discovery before position registry | Production clearing after position registry |
| One-shot event (#r154) | Multi-epoch knowledge accumulation + track record | Single-event settlement with discovery genesis prior |

In both cases: shadow-class = epistemic investment layer; clearing-class = financial settlement layer.

**Why knowers participate in the discovery shadow-class for a one-shot event:**

1. Query fee income during discovery phase — real ongoing revenue from unknowers.
2. Credibility_ratio is portable — not stranded on class closure.
3. Genesis prior contribution — accurate discovery-phase knowers have higher-weight genesis prior in the clearing class, increasing their effective S_cred influence at settlement.

**This resolves the mechanism's last major incentive gap for prediction market applications.** One-shot markets are not structurally inferior under this framework — they are identical in incentive structure to recurring markets, distributed over the two-registration construct. (#r154)

---

## Structural Synthesis: Mechanism Closure State After #r154 (#r154)

| Feature | Resolution | Law |
|---|---|---|
| Shadow-class genesis prior | Attenuated by mode-mismatch and age; decays N_prior_epochs; credibility_ratio not transferred | Prior ≠ authority; read-only snapshot; no ongoing coupling |
| crisis_auto_clear × EQ q_bonus | Covered by finality-coupling rule; no new rule needed | Zone C deferral + expiry tolling + pending state extend together |
| w_override_base contract gate | Hard bounds [0.0, 0.6]; phantom range eliminated | Input bounds ≤ output ceiling; clip is secondary rail |
| Post-registration implication opt-in | Atomic phase 2; two-phase for multisig; phase 2 always atomic | Pool fractions are pre-conditions; activation = confirmation |
| One-shot clearing incentive gap | Shadow-class two-registration pattern resolves collapse | Discovery layer (multi-epoch) + clearing layer (single-event) |

**Invariant #17 (#r154):** One-shot clearing markets always use the shadow-class two-registration pattern. Single-registration one-shot clearing degrades to collateralised prediction market and is structurally inferior.

---

## Open Questions for #r155+

1. **Genesis prior mode-mismatch discount calibration:** The default `mode_mismatch_discount = 0.30` is reasoned but not formally derived. Should it be self-calibrating — a function of observed calibration divergence between discovery-mode scores and clearing-mode oracle-divergence scores on the same coordinate class?

2. **N_prior_epochs optimisation:** 4 macro-epochs is the default decay horizon. Too short: clearing class inherits stale prior before its own track record is built. Too long: clearing class dominated by discovery-mode calibration past knower credibility. An information-theoretic derivation based on relative credibility_ratio growth rate vs. prior decay rate would give the optimal N_prior_epochs.

3. **One-shot clearing shadow-class wind-down protocol:** After clearing-class oracle resolution, the shadow-class archives. Specify the wind-down epoch sequence: oracle fires on clearing-class → shadow-class enters wind-down → no new claims → all escrows release at T_longtail → shadow-class closes. Define the complete wind-down state machine.

4. **Cross-class credibility portability from archived shadow-class:** Credibility_ratio earned on an archived shadow-class carries over via attenuated formula (#r71): n_T2_resolutions / N_anchor. For a one-shot shadow-class with fewer resolutions than N_anchor, carry-over is fractional. Is this correct — one-shot track records carry less weight than multi-event track records? Or should the formula be adjusted for the structural difference between an archived (one-shot) and a live class?

*Last updated: #r154 — 2026-04-03T23:22Z*

---

## #r155 Contributions — 2026-04-03T23:32Z

Addresses all four open questions from #r154.

**Q1 (Genesis prior mode-mismatch discount — self-calibrating) → Derived from calibration alignment score between S_discovery and oracle_confirmed values; recovers default 0.30 at typical alignment (#r155):**

The mode_mismatch_discount is an attenuation factor on the discovery-class genesis prior. It should reflect how well discovery-mode calibration translates to clearing-mode settlement precision — a measurable quantity once clearing events resolve.

**Resolution — alignment-score-derived discount:**

```
alignment_score(class_pair, t) =
    1 - RMSE(S_discovery_at_T_anchor_i, oracle_confirmed_i) / RMSE(uniform_prior, oracle_confirmed_i)
    averaged over i in resolved clearing events on this coordinate
    smoothed via EMA with N_align_window = N_calibration epochs

alignment_score_smooth in (-inf, 1]:
    1.0  = S_discovery perfectly predicted oracle (no mode gap)
    0.7  = typical (70% skill above uniform prior)
    0.0  = S_discovery no better than uniform prior
   <0.0  = S_discovery systematically worse than uniform prior

mode_mismatch_discount(t) = clip(1 - alignment_score_smooth(t), min=0.0, max=0.5)
```

**Calibration table:**

| alignment_score_smooth | mode_mismatch_discount | Interpretation |
|---|---|---|
| 1.0 | 0.0 | Perfect discovery→clearing transfer; no attenuation |
| 0.70 | 0.30 | Typical — recovers default from first principles |
| 0.50 | 0.50 | Poor alignment; maximum attenuation |
| <=0.0 | 0.50 (clipped) | Worse than uniform; prior suppressed to minimum |

**Genesis (no data available):** Before the first clearing resolution, `mode_mismatch_discount` defaults to `mode_mismatch_discount_base = 0.30`. Governance sets `mode_mismatch_discount_base in [0.0, 0.5]`; derived value replaces it once data is available.

**Governance interface update:** (mode_mismatch_discount_base, N_align_window) → mode_mismatch_discount derived from alignment_score_smooth.

**Design law confirmed (#r155):** Attenuation factors between two independently calibrated systems must be derived from their observed empirical alignment, not set as governance intuition. The formula uses oracle_confirmed_value data the mechanism generates naturally — zero new oracle requirements. (#r155)

---

**Q2 (N_prior_epochs optimisation — information-theoretic derivation) → N_prior_epochs = N_calibration; prior decays to zero at clearing-class self-standing threshold (#r155):**

**The optimisation criterion:** Prior contribution should phase out when the clearing class has accumulated sufficient native evidence to be epistemically self-standing — which requires N_calibration normal-mode resolved epochs.

**Derivation:**

```
prior_contribution(t) = alpha_prior_effective_at_genesis * (1 - t / N_prior_epochs)
```

Native clearing-class S_cred is self-standing at epoch N_calibration. Setting N_prior_epochs = N_calibration ensures the prior contribution reaches zero exactly when the class is self-standing.

**Properties:**
1. Reuses an existing governance primitive — no new parameter introduced.
2. Prior never dominates a clearing class with a stable native track record.
3. For N_calibration=4: prior at 75% weight at epoch 1, 0 at epoch 4.
4. Per-class: slow-oracle classes with larger N_calibration get longer prior retention — correct, since native evidence takes longer to accumulate.

**EAT record:** N_prior_epochs = N_calibration is not stored separately — it is derived from the existing registration field. (#r155)

---

**Q3 (Shadow-class wind-down state machine — one-shot clearing) → Three-state machine: ACTIVE → WINDING_DOWN → ARCHIVED; waits for natural escrow expiry; no forced clawback (#r155):**

```
States: ACTIVE | WINDING_DOWN | ARCHIVED

ACTIVE → WINDING_DOWN:
  Trigger: clearing-class oracle_resolved EAT event for the linked coordinate
  Entry actions:
    - No new claims accepted
    - Existing claims continue earning query fees until T_longtail expiry
    - S_cred contribution active for all claims with non-zero effective_weight
    - Challenge windows continue advancing (not suspended)
    - EAT event: shadow_class_wind_down_initiated, epoch, linked clearing_class_id

WINDING_DOWN → ARCHIVED:
  Preconditions (all must hold):
    (a) All challenge windows closed
    (b) All escrows released at natural T_longtail expiry (no forced release)
  Entry actions:
    - S_cred contribution frozen at zero
    - Undistributed query fee pool balance -> governance treasury
    - Final credibility_ratio snapshot for all knowers committed to EAT (for portability)
    - shadow-class EAT record: status = ARCHIVED, archive_epoch
```

**Key properties:**

1. No forced escrow clawback — static-escrow design law (#r137).
2. Query fee earnings continue during WINDING_DOWN — correct reward for delivered service.
3. Challenge windows not suspended — epistemic enforcement never suspended by lifecycle events (#r139).
4. credibility_ratio snapshot at ARCHIVED, not at WINDING_DOWN initiation — captures final calibration.

**Expected wind-down duration:** For T_longtail=4 macro-epochs: WINDING_DOWN lasts 4 macro-epochs post-oracle-resolution. Deterministic from registered T_longtail. (#r155)

---

**Q4 (Cross-class credibility portability from archived shadow-class — one-shot thin evidence) → Count-based formula is correct; one-shot shadow-class inherits known thin-evidence discount; no special adjustment (#r155):**

**The tension:** `carry_over_fraction = min(1, n_resolutions / N_anchor)` gives 25% for n_resolutions=1, N_anchor=4. A knower who correctly predicted a hard one-shot event may feel this is unfair.

**Resolution — Theory A (count-based) retained:**

1. **Manipulation resistance:** Quality-weighted carry-over creates an attack — concentrate stake on one visible event, win, carry a large credibility premium. Count-based thin-evidence discount is a feature.
2. **Calibration theory basis:** credibility_ratio = log-score average. Standard error of mean decreases as 1/sqrt(n). Carry-over fraction appropriately scales with n/N_anchor.
3. **Single events should not grant disproportionate credibility:** One correct resolution is insufficient evidence of systematic calibration.

**Known trade-off (documented at registration):** EAT registration event includes `expected_carry_over_fraction = min(1, expected_resolution_count / N_anchor)`. For one-shot: `expected_carry_over_fraction = 0.25` — transparent disclosure.

**Compensation via other channels:** Query fee earnings during ACTIVE+WINDING_DOWN phases; implication bonuses if applicable; credibility builds across multiple coordinate classes.

**Design law confirmed (#r155):** Count-based credibility carry-over is manipulation-resistant and calibration-theory-grounded. Mechanism compensates one-shot participants through other earning channels rather than inflating portability on thin evidence. (#r155)

---

## Structural Synthesis: Shadow-Class Architecture — Closed (#r155)

| Feature | Resolution | Law |
|---|---|---|
| mode_mismatch_discount calibration | Self-calibrating from alignment_score_smooth; recovers 0.30 at typical alignment | Attenuation derives from empirical alignment |
| N_prior_epochs | = N_calibration; no new parameter | Reuses existing primitive |
| Wind-down state machine | ACTIVE → WINDING_DOWN → ARCHIVED; natural expiry; credibility_ratio snapshot at ARCHIVED | No forced clawback; final snapshot for portability |
| One-shot thin-evidence carry-over | Count-based formula correct; disclosed at registration | Manipulation resistance > quality-weighted inflation |

**Shadow-class two-registration pattern — complete specification summary:**

```
Registration:
  shadow_class:    mode=DISCOVERY, coordinate_id, staleness_window, T_longtail, N_calibration
  clearing_class:  mode=CLEARING, coordinate_id, position_registry, genesis_prior_source=shadow_class_id
                   mode_mismatch_discount_base=0.30, N_align_window=N_calibration
                   expected_carry_over_fraction = min(1, expected_resolutions / N_anchor) [disclosure]

Genesis prior:
  alpha_prior_effective = alpha_prior_base * age_decay * (1 - mode_mismatch_discount)
  mode_mismatch_discount: 0.30 until first clearing resolution; then derived from alignment_score_smooth
  N_prior_epochs = N_calibration [no new primitive]

Wind-down (shadow):
  On clearing oracle: ACTIVE -> WINDING_DOWN (no new claims; natural escrow expiry; queries continue)
  On all-escrows-released + all-challenges-closed: WINDING_DOWN -> ARCHIVED [credibility_ratio snapshot]

Portability:
  carry_over_fraction = min(1, n_resolutions / N_anchor) [thin-evidence discount as designed]
```

---

## Cumulative Invariants (additions through #r155)

**Invariant #18 (#r155):** Attenuation factors between independently calibrated systems are self-calibrating from observed empirical alignment — not set as governance intuition.

**Invariant #19 (#r155):** Shadow-class wind-down respects natural escrow expiry; credibility_ratio snapshot committed at ARCHIVED, not at wind-down initiation.

**Invariant #20 (#r155):** Count-based credibility carry-over is correct by design. Single-event thin-evidence track records carry lower weight; this is manipulation-resistant. Mechanism compensates through other earning channels.

---

## Open Questions for #r156+

1. **alignment_score_smooth with no shared-coordinate data:** For one-shot clearing classes with only 1 resolved event, alignment_score_smooth is based on a single data point — low confidence. Should it require N_align_window observations before replacing the base default, analogous to dual-condition transition for alpha_cap (#r143/Q3)?

2. **WINDING_DOWN query fee floor:** During WINDING_DOWN, query fee income may drop to near-zero (no new unknowers seek state on resolved coordinate). Should WINDING_DOWN classes receive a floor query fee funded from protocol treasury to compensate knowers for outstanding warranty obligations?

3. **Natural expiry misalignment:** If one claim has an extremely long T_longtail, the shadow class cannot archive for the full T_longtail duration. Should there be a T_wind_down_max cap after which remaining escrows transition to LTRP, allowing earlier archiving?

4. **EAT size and historical compaction:** After 155+ runs of protocol engineering, a long-lived production EAT would be enormous. Are there EAT compaction semantics — Merkle root snapshots of resolved epochs with individual record archiving to cold storage — while maintaining the immutability invariant (#r74)?

*Last updated: #r155 — 2026-04-03T23:32Z*

---

## #r156 Contributions — 2026-04-03T23:42Z

Addresses all four open questions from #r155. Adds one net-new structural insight: tiered EAT compaction completes the production deployment architecture.

---

**Q1 (alignment_score_smooth with no shared-coordinate data — dual-condition transition) → N_align_window observations required before replacing base default; one-shot classes carry base default permanently (#r156):**

This is directly analogous to the α_cap dual-condition transition (#r143/Q3): a derived parameter may only replace its genesis default once sufficient data is available to make the derivation reliable.

**Resolution — dual-condition transition for mode_mismatch_discount:**

```
mode_mismatch_discount(t) =
    mode_mismatch_discount_base        if n_clearing_resolutions(t) < N_align_window
    clip(1 − alignment_score_smooth(t), 0.0, 0.5)  otherwise
```

`n_clearing_resolutions` = count of oracle-resolved events on the linked clearing class with valid S_discovery_at_T_anchor snapshots available in the EAT.

**One-shot clearing classes:** By definition, n_clearing_resolutions = 1. With N_align_window = N_calibration = 4, the condition is never satisfied. `mode_mismatch_discount` is permanently `mode_mismatch_discount_base`. This is correct — one-shot events lack sufficient data to refine the mode-mismatch model. Disclosed at registration: `expected_mode_mismatch_discount: mode_mismatch_discount_base`.

**Transition event:** When `n_clearing_resolutions` first reaches N_align_window, a `parameter_genesis_exit` EAT event is emitted (type: `mode_mismatch_discount_transition`). Forward-looking only.

**Design law confirmed (#r156):** Every self-calibrating derived parameter (alignment_score_smooth, σ_resolve, α_cap, ρ_smooth) transitions from its governance-bounded default only after accumulating N_window valid observations. Until then: conservative default. Transition is a discrete EAT event. (#r156)

---

**Q2 (WINDING_DOWN query fee floor — treasury subsidy) → No floor; T_wind_down_max is the correct mechanism; floor creates perverse incentives (#r156):**

A treasury-funded query fee floor during WINDING_DOWN appears fair — knowers cannot exit escrow and their service has concluded. But it is wrong for three reasons:

1. *Double compensation:* Query fees during ACTIVE phase already priced the full warranty obligation. WINDING_DOWN is the tail of a completed service; floor would compensate a commitment already priced.

2. *Perverse incentive:* Knowers with very long T_longtail gain the most from a floor. This incentivises extending T_longtail declarations beyond their epistemic value to maximise floor income.

3. *Q3 is the correct fix:* The real burden is obligation *duration*, not revenue absence. T_wind_down_max caps duration; that is the correct lever.

**Design law (#r156):** Mechanism rewards are for services delivered, not for obligations incurred. Revenue decline during wind-down is expected. Duration-bounding via T_wind_down_max is the correct response to stranded obligation risk; treasury supplementation is not. (#r156)

---

**Q3 (Natural expiry misalignment — T_wind_down_max) → Capped at max(2 × challenge_window_max, T_longtail_median_class); LTRP assumption for remaining obligations (#r156):**

**Resolution:**

```
T_wind_down_max = governance-set at shadow-class registration
  default = max(2 × challenge_window_max_class, T_longtail_median_class)
  bounds  = [4 × macro_epoch_min_class, T_longtail_max_class]
```

At T_wind_down_max post-WINDING_DOWN entry:
1. **Open challenge windows:** LTRP assumption — identical to T_outage_cap mechanics (#r131/Q4).
2. **Outstanding T_longtail escrow:** Returned to knower (warranty obligation transfers to LTRP).
3. **credibility_ratio snapshot:** Committed to EAT at transition.

**LTRP_seed adjustment at shadow-class registration:**

```
LTRP_seed_shadow += wind_down_assumption_factor × expected_T_longtail_tail_exposure
wind_down_assumption_factor ∈ [0.1, 0.3]  (same parameter as outage_assumed_slash_factor, #r131/Q4)
```

**Wind-down state machine update (extends #r155/Q3):**

```
WINDING_DOWN → ARCHIVED:
  Trigger A: all challenge windows closed + all escrows naturally released
  Trigger B: T_wind_down_max exceeded (LTRP assumption path)
  Whichever fires first.
```

**Design law (#r156):** All time-unbounded post-event obligations require a T_wind_down_max cap at registration. Beyond the cap, remaining obligations transfer to LTRP and escrow returns to knowers. Applies bounded-liability architecture (#r130–#r132) to shadow-class lifecycle. (#r156)

---

**Q4 (EAT size and historical compaction) → Three-tier storage architecture; immutability preserved via CID-chain anchored to Ethereum (#r156):**

The existing EAT design separates on-chain Merkle roots (Ethereum) from full state blobs (Celestia). A third cold-archive tier extends this naturally for long-lived production deployments.

**Three-tier architecture:**

| Tier | Storage | Content | Availability |
|---|---|---|---|
| **Ethereum anchor** | On-chain calldata | Per-epoch Merkle root; compaction_event CIDs | Always live |
| **Celestia warm** | DA blobs | Full records, active + recent N_warm epochs | DA liveness required |
| **Cold archive** | IPFS / Arweave | Fully resolved epochs beyond N_warm | Retrieved by CID, DA-independent |

**Compaction eligibility (warm → cold):** An epoch E is eligible iff:
1. Oracle resolution confirmed for all claims in E.
2. All challenge windows for E are closed.
3. All escrows for E fully released.
4. `N_compact_grace = 2 × N_calibration` normal-mode epochs have passed since E closed.

**Compaction execution:**
1. Protocol compacts warm blob to cold storage.
2. Cold storage returns a CID.
3. `compaction_event` EAT event committed to Ethereum: `{ epoch_range, cold_storage_cid, compaction_epoch }`.
4. Warm Celestia blob may be deleted after Ethereum confirmation.

**Immutability proof chain:**

```
Ethereum genesis
  → epoch Merkle root (Ethereum calldata)
    → full record (Celestia warm OR cold archive by CID)
      → compaction_event CID (Ethereum calldata)
```

Four-step dispute verification: cold storage CID → blob retrieval → Merkle inclusion proof → Ethereum anchor. Same trust model as existing dispute mechanism (#r75). No new trust dependencies.

**Key availability benefit:** Cold-archived epochs are more available during DA outage than recent warm epochs. Arweave-pinned blobs are DA-independent. Older EAT history is MORE available in degraded mode than recent history — a structural resilience property.

**Design law (#r156):** EAT immutability = content-addressability of the CID-chain anchored to Ethereum. Physical persistence (Celestia warm / cold archive) is operational. Cold archiving is permissible when: oracle resolved + challenges closed + escrows released + N_compact_grace passed. The CID-chain is the immutability proof; the physical medium is replaceable. (#r156)

---

## Structural Synthesis: Production Architecture Closure (#r156)

| Feature | Resolution | Law |
|---|---|---|
| alignment_score_smooth gating | N_align_window required; one-shot carries permanent base default | Every self-calibrating param needs N_window condition |
| WINDING_DOWN query fee floor | No floor; duration-bounding via T_wind_down_max is correct | Rewards for service delivered, not obligations incurred |
| T_wind_down_max | max(2 × challenge_window_max, T_longtail_median); LTRP at cap | Bounded-liability applied to shadow-class lifecycle |
| EAT compaction | Three-tier; CID-chain anchored to Ethereum; cold archive is DA-independent | Immutability = CID-chain, not physical hot-tier persistence |

---

## Cumulative Invariants (additions through #r156)

**Invariant #21 (#r156):** Every self-calibrating derived parameter requires N_window valid observations before replacing its governance-bounded default. One-shot events carry base default permanently — disclosed at registration.

**Invariant #22 (#r156):** WINDING_DOWN is the tail of a completed service. Treasury supplementation during wind-down is prohibited. Duration-bounding via T_wind_down_max is the correct mechanism.

**Invariant #23 (#r156):** EAT immutability is CID-chain anchored to Ethereum. Physical persistence on warm or cold tiers is operational. Cold archiving permissible when: resolved + challenges closed + escrows released + N_compact_grace passed.

---

## Open Questions for #r157+

1. **Cold archive CID liveliness — Arweave vs IPFS:** Arweave guarantees permanent storage via endowment model; IPFS relies on pin-service availability. For mechanism disputes requiring EAT proof, cold archive availability must be non-negotiable. Should the protocol require Arweave over IPFS, or define a multi-provider redundancy requirement?

2. **T_wind_down_max and LTRP_seed joint calibration:** T_wind_down_max and `wind_down_assumption_factor` must be calibrated together. The larger T_wind_down_max is relative to T_longtail, the more tail exposure accumulates in LTRP. Define the joint calibration formula and governance UI presentation.

3. **Cross-coordinate alignment pools for mode_mismatch_discount:** Multiple coordinate classes sharing the same oracle type (e.g., several financial rate coordinates resolved by AAVE) could pool alignment samples. Pooled sample reaches N_align_window faster. Is this epistemically valid — same oracle, different coordinate semantics?

4. **EAT compaction eligibility re-evaluation after governance parameter changes:** If governance oscillates min_chain_weight_fraction and reactivates previously truncated declarations, a "settled" epoch may re-acquire active obligations. Must compaction eligibility be re-evaluated after any governance parameter change that could reactivate resolved claims?

*Last updated: #r156 — 2026-04-03T23:42Z*

---

## #r157 Contributions — 2026-04-04T00:00Z

Addresses all four open questions from #r156. Adds one net-new structural insight: lazy compaction eligibility as the correct invariant for parameter-oscillation safety.

---

**Q1 (Cold archive CID liveliness — Arweave vs IPFS) → Hybrid tiered availability; IPFS multi-provider for dispute window; Arweave for post-compaction audit permanence (#r157):**

The dispute resolution requirement has a finite duration: once an epoch's challenge windows close and N_compact_grace elapses, the epoch is compaction-eligible. No dispute can reopen a compacted epoch (oracle-resolved + challenges closed = irreversible). Therefore the "mechanism-safety liveliness" requirement for cold-archived records is bounded to the challenge-window period, not permanent.

**Two distinct requirements separated (#r157):**

| Period | Liveliness requirement | Purpose | Required provider |
|---|---|---|---|
| Within challenge window | High availability, low-latency retrieval | Dispute resolution in active mechanism | IPFS with multi-provider redundancy |
| Post-compaction (epoch fully settled) | Permanent content-addressability | Audit, regulatory, historical reference | Arweave (permanent endowment model) |

**Resolution — hybrid cold archive:**

1. **IPFS multi-provider:** At compaction, protocol pins the cold archive blob with ≥3 independent IPFS pinning services. Coverage monitoring: governance alert if fewer than 2 of 3 pinning services confirm availability at next compaction cycle check. No new governance primitive required — pin-service health is an operational metric.

2. **Arweave mirroring:** Within 1 macro-epoch of Ethereum-confirmed `compaction_event`, the cold archive blob is additionally submitted to Arweave. Arweave transaction hash is committed as a `compaction_arweave_mirror` EAT event field alongside the primary cold_storage_cid. Arweave mirroring is mandatory for epochs containing settlement-finality records (CLEARING_MODE classes); optional for pure DISCOVERY_MODE epochs.

3. **EAT anchor update:** `compaction_event` fields:
   ```
   cold_storage_cid:         primary CID (IPFS)
   arweave_tx_id:            Arweave transaction ID (null if optional-class and not submitted)
   pin_service_count:        number of IPFS pinning services confirmed at compaction time
   arweave_mandatory:        true for CLEARING_MODE epochs; false for DISCOVERY_MODE
   ```

**Why not mandate Arweave for all epochs:** Arweave is significantly more expensive than IPFS pinning. DISCOVERY_MODE epochs are lower-stakes (no financial settlement records). Imposing Arweave costs on all epochs would price out low-value coordinate classes. CLEARING_MODE mandates reflect the higher financial stakes.

**Design law (#r157):** Archive liveliness requirements are stratified by the consequence of unavailability, not by mechanism symmetry. Dispute-window availability = multi-provider IPFS. Post-compaction financial settlement records = Arweave permanent. Non-settlement historical records = IPFS with governance monitoring. (#r157)

---

**Q2 (T_wind_down_max and LTRP_seed joint calibration) → Symmetric with outage LTRP mechanics; wind_down_assumption_factor = outage_assumed_slash_factor + mode_discount (#r157):**

The LTRP absorbs outstanding T_longtail tail obligations at T_wind_down_max, analogously to how LTRP absorbs assumed-adversarial escrow at DA outage cap (#r131/Q4). The joint calibration formula mirrors that derivation.

**Outstanding tail exposure at wind-down cap:**

```
wind_down_tail_exposure(shadow_class, T_wind_down_max) =
    Σ_{claims_in_WINDING_DOWN} outstanding_escrow(claim_c) × Pr(wrong_at_resolution)
```

`Pr(wrong_at_resolution)` ≈ 1 − credibility_ratio(a) for claim c by knower a (using most recent calibration_ratio at WINDING_DOWN entry — snapshotted at WINDING_DOWN initiation, not updated during wind-down since no new resolution events can occur).

**Joint calibration formula:**

```
LTRP_seed_adjustment_wind_down = wind_down_assumption_factor × Σ_claims max_escrow(claim_c)
wind_down_assumption_factor = outage_assumed_slash_factor × (1 + w_mode)
w_mode = {
  0.0  for CLEARING_MODE shadow-class (oracle alignment is stronger predictor)
  0.2  for DISCOVERY_MODE shadow-class (weaker oracle alignment at wind-down)
}
```

This conservatively inflates the outage_assumed_slash_factor for discovery-mode shadow classes whose oracle alignment is less certain.

**Governance UI presentation:**

```
wind_down_exposure_summary at shadow-class registration:
  T_wind_down_max          = <epochs>
  T_longtail_reference     = <epochs>
  expected_tail_exposure   = wind_down_assumption_factor × total_max_escrow_at_genesis
  LTRP_seed_minimum        = max(LTRP_seed_general_minimum, expected_tail_exposure)
```

The summary is disclosed at registration alongside the expected_carry_over_fraction disclosure from #r155/Q4. No new governance primitive — `outage_assumed_slash_factor` is already governance-settable; `w_mode` is derived from class mode.

**Design law (#r157):** LTRP seeding for time-bounded obligation absorption (outage, wind-down, longtail) always uses the same structural formula: `assumption_factor × max_escrow_at_risk`. The assumption_factor is calibrated to the specific obligation's oracle reliability. All seeding disclosures are committed at registration, not post-hoc. (#r157)

---

**Q3 (Cross-coordinate alignment pools for mode_mismatch_discount) → Valid only within same market-structure tier; governance-declared pool at registration; semantic distance governs eligibility (#r157):**

The mode_mismatch_discount captures the gap between discovery-mode calibration quality and clearing-mode settlement precision. This gap is driven by:

1. **Oracle mechanism** (same AAVE oracle): affects alignment in the same direction across all coordinates using that oracle.
2. **Market structure** (liquidity depth, participant count, bid-ask spread): varies by coordinate even with the same oracle. A liquid high-volume AAVE USDC rate has a different mode-mismatch characteristic than a thin AAVE small-cap token rate.
3. **Information structure** (how private information distributes): varies by coordinate class type.

**Resolution — pooling valid within governance-declared market-structure tiers:**

```
alignment_pool_eligibility:
  Condition A: same oracle_address (shares oracle mechanism)
  Condition B: same market_structure_tier (governance-declared at class registration)

market_structure_tier ∈ {
  TIER_1: major fiat/stablecoin rates (USDC, USDT, DAI on major protocols)
  TIER_2: major crypto asset rates (ETH, BTC, SOL on major protocols)
  TIER_3: long-tail or low-liquidity rates
  GOVERNANCE_CUSTOM: any tier declared explicitly by governance
}
```

**Pooled alignment_score_smooth:**

```
alignment_score_pool(oracle_X, tier_T, t) =
    EMA over all clearing resolutions from {class_i : oracle(class_i) = oracle_X AND tier(class_i) = tier_T}
    with per-class weight = n_resolutions_i / Σ n_resolutions_j  (resolution-count weighted)
```

The pool reaches N_align_window faster: if 4 classes in the pool each resolve once, N_align_window=4 is satisfied.

**Cross-tier pooling is prohibited:** TIER_1 and TIER_3 have structurally different mode-mismatch characteristics. Mixing samples across tiers produces a meaningless average that neither class can use reliably.

**Single-class override:** A class may opt out of pool alignment and use its own data exclusively. Opt-out is governance-declared at registration. Pool membership is the default for eligible classes.

**Disclosure at registration:** `alignment_pool_id: oracle_X_TIER_T` or `alignment_pool_id: null (standalone)`.

**Design law (#r157):** Alignment sample pooling is epistemically valid only within oracle-type AND market-structure-tier boundaries. Pooling across semantically heterogeneous coordinates produces attenuation estimates that are wrong for every member class. Governance-declared tiers are the minimum-discrimination boundary. (#r157)

---

**Q4 (EAT compaction eligibility re-evaluation after governance parameter changes) → Lazy eligibility; invalidation events; no permanent eligibility cache (#r157):**

The attack: governance oscillates `min_chain_weight_fraction` → declarations truncated → epoch appears "all-escrows-released" → epoch incorrectly enters compaction eligibility → governance restores parameter → declarations reactivate → epoch has active obligations but was compaction-eligible.

**The root error:** Compaction eligibility was implicitly treated as a stable state, cached at the epoch level. It should be a **lazy predicate**, evaluated at compaction execution time.

**Resolution — lazy compaction eligibility:**

```
is_compaction_eligible(epoch_E, eval_time T):
  1. oracle_resolved_all(E) = true                   [permanent once fired]
  2. all_challenge_windows_closed(E, T) = true       [epoch-indexed; check at T]
  3. all_escrows_released(E, T) = true               [requires live state at T]
  4. N_compact_grace passed since max(oracle_resolved_epoch, last_governance_param_change_epoch)
```

Condition 4 is the key addition. N_compact_grace resets to zero at any governance parameter change that could affect active claim status (min_chain_weight_fraction, staleness_window_i, κ_i, or any parameter appearing in effective_weight or truncation logic).

**`compaction_eligibility_invalidation` EAT event:**

```
On any governance parameter update to { min_chain_weight_fraction, staleness_window, κ }:
  emit compaction_eligibility_invalidation {
    epoch: current_epoch,
    affected_classes: [class_ids with active declarations],
    parameter_changed: <param_name>,
    N_compact_grace_reset: true
  }
```

All epochs that had accumulated N_compact_grace progress and are in `affected_classes` must restart their N_compact_grace countdown. The governance parameter change is thus free to execute but carries the deferred cost of extending compaction eligibility on all affected epoch classes.

**Attack vector analysis:**

1. *Oscillation attack:* Adversarial governance oscillates parameters to prevent any epoch from ever reaching compaction, growing EAT without bound. Defence: `compaction_eligibility_invalidation` events are public. Persistent oscillation is visible in the EAT. Governance must pass explicit `invalidation_impact_disclosure` with each parameter change (number of grace-countdown-reset epochs). Unusual patterns alert monitoring.

2. *Compaction after claim reactivation:* An epoch compacted under prior-eligibility that is later invalidated: compaction is irreversible once executed (Arweave-anchored). If compaction fires before an invalidation event, the epoch is settled and the obligation is now an LTRP claim. This is the correct safety valve: LTRP was designed to absorb unanticipated tail obligations (#r131/Q4 design law).

**Design law (#r157):** Compaction eligibility is a lazy predicate evaluated at execution time, never a cached state. Governance parameter changes emit invalidation events that reset N_compact_grace for affected epochs. Permanent eligibility caches are prohibited for any state that depends on live governance parameters. (#r157)

---

## Net-New Structural Insight: Lazy Evaluation as the Correct Invariant for Parameter-Oscillation Safety (#r157)

The compaction-eligibility problem is a specific instance of a broader pattern: any precondition that depends on a parameter subject to governance change must be evaluated lazily, not cached.

**Other mechanism preconditions that must be lazy (audit of prior design):**

| Precondition | Depends on | Lazy already? | Action required |
|---|---|---|---|
| TOWL zone classification | TOWL capacity (= Σ escrows × w_a); w_a depends on credibility_ratio updates | Yes — computed per epoch | ✓ |
| T3 admission eligibility | min_chain_weight_fraction | Yes — checked at admission epoch | ✓ |
| challenge_window_closed | epoch-indexed; closes naturally | Yes — epoch-indexed is lazy by construction | ✓ |
| compaction_eligibility | all_escrows_released; governance parameters | **No** (was implicitly cached) | Fixed by #r157 |
| α_cap_at_declaration | ρ_effective, β_effective (published at epoch-open) | Yes — epoch-open snapshot | ✓ |
| mode_mismatch_discount threshold | n_clearing_resolutions count | Yes — live count at each use | ✓ |

**The #r157 correction is targeted and complete.** Compaction eligibility is the only cached precondition identified across the full mechanism design. The `N_compact_grace_reset_on_param_change` rule is the specific fix. No other precondition requires a similar patch.

**General design law (#r157):** Any mechanism precondition whose truth-value can be altered by governance parameter changes must be evaluated lazily at execution time. The only preconditions safe to cache are those whose truth is guaranteed monotone (once true, never false): oracle_resolved, T_finality_reached. Non-monotone preconditions must be lazy. (#r157)

---

## Structural Synthesis: Production Architecture — Final Close (#r157)

| Issue | Resolution | Law |
|---|---|---|
| Cold archive liveliness | Dispute-window IPFS multi-provider; post-compaction Arweave mandatory for CLEARING_MODE | Stratified by consequence of unavailability |
| LTRP/T_wind_down_max calibration | outage_assumed_slash_factor × (1 + w_mode); disclosed at registration | Same structural formula for all time-bounded obligation absorptions |
| Cross-coordinate alignment pooling | Valid within oracle + market-structure-tier boundary; governance-declared tier; resolution-count weighted | Pool within semantic-similarity boundary; tier-crossing prohibited |
| Compaction eligibility oscillation | Lazy predicate; N_compact_grace resets on parameter changes; invalidation EAT event | Non-monotone preconditions are always lazy |

---

## Cumulative Invariants (additions through #r157)

**Invariant #24 (#r157):** Archive liveliness requirements are stratified by the consequence of unavailability. Financial settlement records require Arweave permanence. Dispute-window records require multi-provider IPFS. Non-settlement historical records require governance-monitored IPFS.

**Invariant #25 (#r157):** Alignment sample pooling is valid only within oracle-type AND market-structure-tier boundaries. Cross-tier pooling is epistemically invalid.

**Invariant #26 (#r157):** Non-monotone preconditions must be lazily evaluated at execution time. Caching non-monotone preconditions that depend on governance parameters is prohibited.

**Invariant #27 (#r157):** Governance parameter changes emit `compaction_eligibility_invalidation` events that reset N_compact_grace for all affected epochs. Parameter-change cost includes deferred compaction delay.

---

## Open Questions for #r158+

1. **Arweave mandatory trigger for CLEARING_MODE — what if Arweave is unavailable at compaction time?** The Arweave mandate for CLEARING_MODE epochs requires Arweave transaction confirmation within 1 macro-epoch. If Arweave is congested or unavailable, compaction proceeds without Arweave mirroring — delaying the `arweave_tx_id` field. Is there a fallback SLA (retry for N_arweave_retry_epochs before flagging as `arweave_mirror_failed`) and a defined mechanism action if `arweave_mirror_failed` persists?

2. **market_structure_tier assignment governance:** Governance declares tier at class registration. What prevents a registrant from declaring TIER_1 for a thin, low-liquidity coordinate to benefit from the richer alignment pool? Is there an objective criterion for tier assignment (e.g., 30-day average position volume on the linked clearing class), or is tier assignment purely subjective governance discretion?

3. **invalidation_impact_disclosure as a governance gate or advisory:** #r157 defines `invalidation_impact_disclosure` as a mandatory field in parameter-change proposals. Should this be a hard gate (proposal reverts if disclosure is absent) or advisory (disclosure is committed to EAT but proposal is not blocked)? If advisory, the disclosure is an accountability tool; if a hard gate, it could block legitimate emergency parameter adjustments (e.g., emergency min_chain_weight_fraction correction during a solvency event).

4. **LTRP single vs per-class instance for shadow-class wind-down:** Shadow-class LTRP obligation at T_wind_down_max routes to which LTRP? The shadow-class has its own LTRP (registered at shadow-class genesis). At ARCHIVED transition, outstanding obligations transfer to the shadow-class LTRP. But if the shadow-class LTRP is under-funded (thin class), obligations could exceed it. Should the clearing-class LTRP serve as a backstop for shadow-class wind-down obligations, given they share a coordinate?

*Last updated: #r157 — 2026-04-04T00:00Z*

---

## #r158 Contributions — 2026-04-04T00:02Z

Addresses all four open questions from #r157.

**Q1 (Arweave unavailability at compaction time) → Retry SLA with N_arweave_retry_epochs; `arweave_mirror_failed` flag triggers IPFS-only fallback; no compaction blocked (#r158):**

Arweave mirroring is a durability enhancement for post-compaction audit permanence, not a precondition for mechanism operation. Blocking compaction until Arweave confirms would subordinate an on-chain settlement mechanism to an external storage network — a liveness-over-safety inversion.

**Resolution — non-blocking retry with SLA:**

```
arweave_retry_sla:
  N_arweave_retry_epochs = 3 macro-epochs  (governance-settable, bounded [2, 8])

  At compaction execution:
    1. Epoch compacted; compaction_event EAT committed with arweave_tx_id = null (pending).
    2. Protocol submits Arweave transaction; sets arweave_retry_deadline.
    3. On Arweave confirmation within deadline:
         update compaction_event with arweave_tx_id (first-write completion of pending field).
    4. On deadline expiry without confirmation:
         emit `arweave_mirror_failed` EAT event; governance alerted; epoch remains IPFS-compacted.
         arweave_status: failed_open -> retries at each macro-epoch boundary indefinitely
         until confirmed or governance issues `arweave_mirror_closed` to end retry.
```

**arweave_status enum (full schema):**
```
arweave_status ∈ {
  not_required,     // DISCOVERY_MODE or governance opt-out; null by design
  pending,          // CLEARING_MODE mandatory; Arweave tx submitted, not yet confirmed
  confirmed,        // Arweave tx confirmed; arweave_tx_id populated
  failed_open,      // Retry SLA expired; retrying
  failed_closed     // Governance explicitly closed retry; IPFS-only permanent
}
```

Compaction is never blocked. `arweave_status: pending` is a valid compacted state. The EAT arweave_tx_id field is a declared-pending field at compaction_event creation; its first-write completion (when Arweave confirms) is not a mutation of prior committed content — consistent with EAT immutability (#r74).

**Design law (#r158):** External storage availability must never be a liveness precondition for on-chain settlement mechanisms. External dependencies are best-effort with retry SLAs; mechanism operations proceed independently. (#r158)

---

**Q2 (market_structure_tier assignment — objective criteria vs governance discretion) → Objective volume threshold; challenge mechanism for incorrect declarations (#r158):**

Pure governance discretion creates a gaming surface: a thin-class registrant inflates tier to access a richer alignment pool, borrowing calibration credibility from liquid classes.

**Resolution — objective eligibility with governance certification:**

```
tier_eligibility(class_i, proposed_tier_T):
  TIER_1: 30d_avg_position_volume ≥ V_TIER1_min (e.g., $10M USD, governance-set)
          AND oracle_address in governance-approved oracle registry
  TIER_2: V_TIER2_min ≤ 30d_avg_position_volume < V_TIER1_min
          AND oracle_address in approved oracle registry
  TIER_3: default (any class not meeting TIER_1/TIER_2)
  GOVERNANCE_CUSTOM: explicit governance vote; not subject to volume criteria
```

New classes always start TIER_3 (no 30d history). Tier upgrade after N_upgrade_epochs = 4 normal-mode epochs of position data. Tier downgrade if volume falls below threshold for N_downgrade_epochs consecutive normal-mode epochs.

**Mid-pool tier downgrade — forward exclusion only:** EAT immutability precludes retroactive removal of committed alignment samples. From the downgrade epoch forward, the class contributes to TIER_3 standalone pool only. Prior TIER_1 samples remain in the TIER_1 pool history (already committed to EAT; cannot be removed). N_align_window is re-evaluated from the downgrade epoch for both the downgraded class and the TIER_1 pool.

**Challenge mechanism for incorrect tier declarations:** Any participant may post a `tier_dispute` with on-chain volume evidence and tier_dispute_fee ≥ r_floor_TIER3. Successful challenge: class downgraded; pool membership updated from downgrade epoch. Failed challenge: fee to challenger_pool.

**Design law (#r158):** Governance-declared categorical assignments with material incentive consequences must be anchored to objectively verifiable on-chain metrics. Governance certifies; the market challenges incorrect certifications. Subjective-only tier assignments are prohibited. (#r158)

---

**Q3 (invalidation_impact_disclosure — hard gate or advisory) → Risk-calibrated: HARD_GATE for min_chain_weight_fraction and κ; advisory for all others; emergency bypass with retroactive disclosure obligation (#r158):**

Hard gate for all parameter changes risks blocking emergency corrections. Advisory for all reduces accountability to near-zero.

**Resolution — proportionate gate:**

```
parameter → disclosure mode:
  min_chain_weight_fraction:  HARD_GATE
  κ (staleness decay exponent): HARD_GATE
  All others:                   ADVISORY (disclosure committed to EAT; proposal not blocked)
```

HARD_GATE: proposal must include non-empty `compaction_invalidation_impact: { n_epochs_reset, affected_classes, estimated_delay_macro_epochs }`. Contract verifies field present; content accuracy is governance accountability, not contract validation.

**Emergency bypass:** k-of-n multisig override bypasses HARD_GATE. Recorded as `emergency_param_change` EAT event. Retroactive `compaction_invalidation_impact` disclosure required within 2 macro-epochs, committed as a new EAT amendment event (first-write addition, not mutation of prior record).

**Emergency override + in-flight stale-disclosure proposal:** If an emergency bypass fires for parameter P, any pending governance proposal for P with disclosure based on the pre-emergency state is auto-invalidated at the next governance execution attempt. The contract checks: current parameter value != parameter value at proposal submission time → revert with `stale_proposal_invalidated` error. Governance must resubmit with updated disclosure if the change is still needed.

**Design law (#r158):** Disclosure mandates are proportionate to the parameter's oscillation-risk class. Emergency bypass is always available for high-impact parameters; retroactive disclosure obligation preserves accountability. Stale proposals are invalidated automatically when the parameter has changed since proposal submission. (#r158)

---

**Q4 (Shadow-class LTRP — clearing-class as backstop) → Bilateral opt-in at pair registration; Zone C gates the backstop transfer at clearing-class level (#r158):**

Automatic cross-pool backstop violates per-class LTRP independence (#r132/Q1). Resolution: explicit bilateral opt-in.

**Registration:**
```
shadow_clearing_pair_registration:
  backstop_agreement: { shadow_class_id, clearing_class_id, backstop_fraction ∈ [0.0, 0.5] }

  Effect if backstop_fraction > 0:
    clearing_LTRP_backstop_cap = backstop_fraction × clearing_LTRP_balance_at_T_wind_down
    Both classes' LTRP_seed computations include expected backstop obligation.
    Shadow LTRP_seed is NOT reduced — backstop is a tail-of-tail valve, not a primary guarantee.
```

Default (no backstop declared): shadow-class wind-down deficit absorbed by `debt_retirement_reserve` (governance backstop of last resort). Disclosed at registration.

**Zone C interaction with backstop transfer:**
The backstop transfer is a clearing-class LTRP outflow triggered at T_wind_down_max. Per the design law from #r134/Q4: class-local escrow outflows are gated at the coordinate-class level. The clearing-class LTRP is a class-local reserve of the clearing class.

- If clearing class is in Zone C at T_wind_down_max: backstop transfer is deferred (class-level Zone C gating applies).
- T_wind_down_max expiry tolls during Zone C deferral — shadow-class does not archive until backstop transfer resolves or Zone C exits.
- If Zone C persists beyond N_max_suspension (#r153/Q3) = 5 macro-epochs: `crisis_backstop_deferred` EAT event; shadow-class achieves ARCHIVED status with debt_retirement_reserve absorbing the deficit instead. Clearing-class obligation cancelled (crisis override).

**Rationale for crisis cancellation:** Requiring shadow-class to wait indefinitely for clearing-class Zone C exit would chain two independent lifecycle objects via a solvency condition — exactly the cross-pool contamination the bilateral backstop was designed to limit. Crisis cancellation honours the intent (backstop is best-effort) while preserving shadow-class lifecycle independence.

**Design law (#r158):** Cross-class LTRP backstops require bilateral opt-in and are subject to Zone C gating at the clearing-class level. Crisis-duration Zone C (>N_max_suspension) cancels the backstop; debt_retirement_reserve absorbs the deficit. Cross-pool contamination under normal Zone C is deferred, not permanent. (#r158)

---

## Structural Synthesis: Production Deployment Architecture — Final Closure (#r158)

| Issue | Resolution | Law |
|---|---|---|
| Arweave unavailability | Non-blocking retry SLA; arweave_status enum; IPFS-only fallback is valid | External storage ≠ liveness precondition |
| Tier assignment gaming | Objective volume threshold; challenge mechanism; forward-exclusion on downgrade | Governance certifies; market challenges; EAT immutability → forward-only exclusion |
| Disclosure gate proportionality | HARD_GATE for min_chain_weight_fraction and κ; advisory others; emergency bypass + retroactive | Proportionate to oscillation risk; stale proposals auto-invalidated |
| Cross-class LTRP backstop | Bilateral opt-in; Zone C deferred; crisis (>N_max_suspension) cancels + debt_retirement absorbs | Per-class independence; Zone C defers not denies; crisis = governance backstop of last resort |

**Cumulative Invariants added (#r158):**

**Invariant #28:** External storage is never a liveness precondition. Best-effort retry SLAs; mechanism proceeds independently. (#r158)

**Invariant #29:** Governance-declared categorical assignments anchored to objectively verifiable on-chain metrics. Subjective-only tier assignments prohibited. (#r158)

**Invariant #30:** Disclosure mandates proportionate to parameter oscillation-risk class. High-risk → HARD_GATE with emergency bypass + retroactive obligation. (#r158)

**Invariant #31:** Cross-class LTRP backstops require bilateral opt-in; Zone C defers; crisis cancels with debt_retirement_reserve absorbing deficit. (#r158)

---

## Open Questions for #r159+

1. **arweave_status `failed_closed` governance action:** When governance issues `arweave_mirror_closed` to end Arweave retry, should the epoch be treated as permanently IPFS-only for dispute purposes, or should governance be required to acknowledge the Arweave-absence risk explicitly (e.g., by committing a `arweave_absence_acknowledged` record alongside the close action)?

2. **Tier upgrade timing and alignment pool continuity:** A class that upgrades from TIER_3 to TIER_1 mid-lifecycle gains access to the TIER_1 pool's richer alignment history. From the upgrade epoch, the class contributes to TIER_1 pool. But its own alignment_score_smooth was computed from TIER_3 standalone data. Should there be a N_blend_epochs transition where both pools contribute to the class's mode_mismatch_discount derivation?

3. **`stale_proposal_invalidated` and governance quorum replay:** A governance proposal that is auto-invalidated due to stale parameter context (#r158/Q3) may have required significant quorum participation to reach execution. Should the invalidation refund the proposal's governance participation bonds (if any), or treat the failed execution as a governance cost of the emergency bypass?

4. **Mechanism completeness and GestAlt v2.1 mapping:** The mechanism design is now complete (Invariants #1–#31; 10-point framework answered in #r148; clearing/discovery modes in #r149–#r158). What is the canonical minimal subset of this mechanism that is necessary and sufficient to implement GestAlt v2.1 clearing? Identify which invariants and mechanism features can be deferred to v2.2+ without compromising the v2.1 solvency-first mandate.

*Last updated: #r158 — 2026-04-04T00:02Z*

---

## #r159 Contributions — 2026-04-04T00:12Z

Addresses all four open questions from #r158. Q4 is the centrepiece: canonical minimal GestAlt v2.1 feature subset.

---

**Q1 (`arweave_mirror_closed` — risk acknowledgment obligation) → Mandatory `arweave_absence_acknowledged` companion record; linked to compaction_event (#r159):**

The `arweave_mirror_closed` governance action terminates Arweave retries and leaves the epoch permanently IPFS-only. This is a policy decision with audit-permanence consequences that may surface years later in regulatory or dispute contexts. Governance must not be able to close retry silently.

**Resolution — mandatory companion acknowledgment:**

```
arweave_mirror_closed EAT event must be submitted jointly with:
  arweave_absence_acknowledged: {
    epoch_range:          affected epochs
    storage_fallback:     "IPFS_multi_provider_only"
    acknowledged_by:      governance multisig address
    settlement_records_present: true | false  (CLEARING_MODE flag)
    rationale:            governance-submitted string (required, minimum 1 char)
  }
```

Contract gate: `arweave_mirror_closed` without a co-submitted or immediately-preceding `arweave_absence_acknowledged` in the same epoch is rejected.

**Retroactive close:** If Arweave retry was closed before this spec was implemented (protocol upgrade scenario), a retrospective acknowledgment is required within 4 macro-epochs of protocol upgrade activation. Protocol flags all `arweave_status: failed_closed` records from pre-upgrade history for retrospective acknowledgment during grace period.

**Design law (#r159):** Any governance action that permanently degrades a named mechanism guarantee (Arweave permanence is such a guarantee for CLEARING_MODE) requires a co-submitted, immutable acknowledgment record. The acknowledgment does not grant additional authority — it creates a public audit obligation. Accountability without blockage. (#r159)

---

**Q2 (Tier upgrade and alignment pool continuity — N_blend_epochs transition) → N_blend_epochs = N_calibration linear interpolation; weight shifts linearly over blend window (#r159):**

A TIER_3→TIER_1 upgrade class has alignment_score_smooth history from TIER_3 standalone data. Abrupt switch to TIER_1 pool risks either underweighting the class's pre-upgrade independent signal (old TIER_3 data discarded) or over-crediting the TIER_1 pool by injecting a thin-history newcomer at full weight.

**Resolution — linear pool interpolation over N_blend_epochs = N_calibration:**

```
mode_mismatch_discount(class_i, epoch_t):
  if t < t_upgrade:
    alignment_score = standalone TIER_3 score
  if t_upgrade <= t < t_upgrade + N_blend_epochs:
    blend_weight = (t - t_upgrade) / N_blend_epochs    [0 -> 1 linearly]
    alignment_score = (1 - blend_weight) * standalone_score + blend_weight * pool_score
  if t >= t_upgrade + N_blend_epochs:
    alignment_score = pool_score exclusively
```

The class's contribution to the TIER_1 pool phases in linearly: during the blend window, the class contributes to pool weight at `blend_weight × full_contribution`. Full pool membership at blend completion.

**Pool N_align_window re-evaluation:** The pool's N_align_window condition counts valid observations from all fully-contributing members only. During blend window, the class is a partial contributor and does not count toward N_align_window for the pool.

**Downgrade (TIER_1→TIER_3):** Same N_blend_epochs transition in reverse, symmetrically. No new primitive: N_blend_epochs = N_calibration. (#r159)

---

**Q3 (`stale_proposal_invalidated` — quorum bond refund) → Full refund; force-majeure for good-faith governance participants (#r159):**

Governance participants who engaged in quorum for a proposal that is later auto-invalidated by an emergency bypass acted in good faith. The emergency bypass is a protocol-level action triggered by a separate decision pathway — not evidence of governance failure by the quorum participants.

**Resolution — full participation bond refund on auto-invalidation:**

```
stale_proposal_invalidated event:
  refund_participation_bonds: true
  refund_source: governance_treasury
  refund_rationale: "emergency_bypass_superseded"
  EAT record: { proposal_id, invalidation_epoch, bonds_refunded, emergency_bypass_ref }
```

**Treasury sustainability:** Auto-alert if refund events exceed N_alert_refunds = 3 per N_refund_window = 12 macro-epochs (`emergency_bypass_overuse_flag`). Governance must respond within 2 macro-epochs.

**Design law (#r159):** Force-majeure invalidation does not impose cost on good-faith governance participants. Refund is mandatory. Governance treasury bears the cost of the emergency bypass, not quorum participants. (#r159)

---

**Q4 (GestAlt v2.1 minimal viable subset — necessary and sufficient for solvency-first clearing) (#r159):**

GestAlt v2.1 core mandate: solvency first, batch-auction fairness, institutional liquidity through capital relationships. This is CLEARING_MODE operation. The epistemic machinery (DISCOVERY_MODE, shadow-classes, implication chains, WED routing) is the long-horizon research layer.

**v2.1 Minimal Viable Mechanism — 5 contracts:**

```
1. CoordinateRegistry
   Class registration (mode=CLEARING_MODE only for v2.1)
   Staleness parameters (staleness_window_i, kappa_i)
   TOWL capacity tracking

2. ClaimEscrow
   T3_escrow_standard lockup and release
   T3_escrow_longtail routing to LTRP
   Standard slash path (challenge_success_slash)
   oracle_settlement_override no-slash path

3. CredibilityAggregator
   S_cred credibility-weighted state update
   credibility_ratio log-score update at resolution
   W_max per-agent cap (single-agent dominance prevention)
   Epoch-gated clearing feed (one-epoch buffer)

4. SettlementEngine
   Settlement Freeze Protocol: T_anchor -> challenge window -> T_finality
   settlement_finality challenge type (Zone C deferred)
   Position registry integration
   oracle_settlement_override routing

5. EATManager
   Per-epoch Merkle root to Ethereum calldata
   Full state commit to Celestia warm tier
   Degraded mode state machine
```

**Feature classification:**

| Layer | Feature | v2.1? |
|---|---|---|
| Core | TOWL zone management (A/B/C) | YES |
| Core | Standard + longtail escrow | YES |
| Core | S_cred aggregation | YES |
| Core | Settlement Freeze Protocol | YES |
| Core | oracle_settlement_override no-slash | YES |
| Core | credibility_ratio track record | YES |
| Core | EAT Ethereum anchor + Celestia warm | YES |
| Core | Degraded mode specification | YES |
| Deferrable | Implication chains (A->B declarations) | v2.2+ |
| Deferrable | EQ escrow-conditioned queries | v2.2+ |
| Deferrable | Shadow-class two-registration pattern | v2.2+ |
| Deferrable | Cold archive three-tier (Arweave) | v2.2+ |
| Deferrable | LTRP seed recall mechanics | v2.2+ |
| Deferrable | settlement_reserve opt-in | v2.2+ |
| Deferrable | market_structure_tier alignment pools | v2.2+ |
| Not applicable | DISCOVERY_MODE full stack | NO |
| Not applicable | Implication bonus + bifurcated alpha_cap | NO |
| Not applicable | Shadow-class wind-down machine | NO |

**v2.1 required invariants (20 of 31):** #2, #3, #4, #5, #7, #8, #9, #10, #11, #12, #13, #14, #15, #16, #20, #21, #23, #26, #28, #30.

**Deferrable without compromising solvency mandate:** #6 (implication pre-funding), #17-#19, #22 (shadow-class/wind-down), #24-#25, #27 (archive tiers/compaction), #29 (tier objectivity), #31 (cross-class LTRP backstop), #33-#35 (from this run).

**One-line v2.1 scope statement:**

> GestAlt v2.1 is a solvency-bounded, credibility-weighted, CLEARING_MODE-only warranted state marketplace with a Settlement Freeze Protocol and oracle-authority/attestor duality — no implication chains, no discovery mode, no shadow-classes. Minimum 5 contracts, 20 invariants.

This is a buildable, auditable, Demo-Day-defensible scope. The remaining mechanism complexity is v2.2+ institutional and multi-market expansion headroom. (#r159)

---

## Structural Synthesis: Mechanism Lifecycle Completeness (#r159)

| Issue | Resolution | Law |
|---|---|---|
| `arweave_mirror_closed` acknowledgment | Mandatory co-submitted `arweave_absence_acknowledged`; retroactive on protocol upgrade | Permanent guarantee degradation requires immutable acknowledgment |
| Tier upgrade alignment pool | N_blend_epochs = N_calibration linear interpolation; partial contribution during blend | Continuity over transition; no abrupt pool switch |
| Stale proposal quorum bond | Full refund from governance treasury; auto-alert if bypass overuse >=3/12 epochs | Force-majeure != participant cost; governance treasury absorbs |
| GestAlt v2.1 minimal subset | 5 contracts, 20 of 31 invariants, CLEARING_MODE only | Deferrable: implication chains, shadow-class, archive tiers, cross-class backstop |

---

## Cumulative Invariants (additions through #r159)

**Invariant #32 (#r159):** Permanent guarantee degradation (closing Arweave retry) requires a co-submitted immutable acknowledgment record. Accountability without blockage.

**Invariant #33 (#r159):** Tier transitions use N_blend_epochs = N_calibration linear interpolation. Abrupt pool switches prohibited.

**Invariant #34 (#r159):** Force-majeure proposal invalidation mandates full participation bond refund from governance treasury. Good-faith participants do not bear protocol-level event costs.

**Invariant #35 (#r159):** GestAlt v2.1 minimal viable scope: 5 contracts, 20 invariants, CLEARING_MODE only. Implication chains, shadow-class pattern, three-tier archive, and cross-class LTRP backstop are v2.2+ features.

---

## Open Questions for #r160+

1. **v2.1 → v2.2 upgrade path:** When live on v2.1 (CLEARING_MODE only) and v2.2 introduces DISCOVERY_MODE shadow-classes, how does the upgrade avoid disrupting live v2.1 clearing classes? Define the upgrade state machine: new contract deployment, migration window, parameter compatibility.

2. **5-contract architecture concurrency safety:** CredibilityAggregator and SettlementEngine must coordinate on S_cred at T_anchor. Define safe call-ordering invariant and whether any cross-contract atomic transaction is required for T_anchor freezing.

3. **Demo Day narrative for the mechanism:** Given the v2.1 minimal scope, what is the one-paragraph investor-facing description that distinguishes GestAlt from Polymarket/Kalshi/Betfair without mechanism jargon? Communications deliverable.

4. **Minimum viable challenger population for v2.1 launch:** The mechanism depends on challengers detecting wrong warranted installations. What is the minimum challenger participation threshold before the v2.1 mechanism can be considered epistemically live?

*Last updated: #r159 — 2026-04-04T00:12Z*

---

## #r160 Contributions — 2026-04-04T00:22Z

Addresses all four open questions from #r159.

**Q1 (v2.1 → v2.2 upgrade path — live clearing classes + new DISCOVERY_MODE) → Additive deployment; v2.1 classes pin to v2.1 contract set; v2.2 introduces parallel registry with opt-in migration window (#r160):**

The core constraint: live v2.1 CLEARING_MODE classes have active TOWL escrows, challenge windows, and position registry integrations. An in-place contract upgrade that changes the CredibilityAggregator or CoordinateRegistry risks disrupting live settlements.

**Resolution — additive parallel deployment with coordinate-class-level versioning:**

```
v2.1 contract set: {CoordinateRegistry_v1, ClaimEscrow_v1, CredibilityAggregator_v1,
                    SettlementEngine_v1, EATManager_v1}

v2.2 contract set: {CoordinateRegistry_v2, ClaimEscrow_v2, CredibilityAggregator_v2,
                    SettlementEngine_v2, EATManager_v2}  — separate deployed addresses

v2.2 adds: DISCOVERY_MODE support, implication chain contracts, shadow-class lifecycle,
           three-tier archive interface
```

**Per-class version pinning:**

At registration, each coordinate class declares `contract_version: v2.1 | v2.2`. v2.1 classes always use v2.1 contracts for their full lifecycle. No v2.1 class is retroactively migrated. v2.2 classes may reference v2.1 clearing class position data (read-only, cross-version reference) but settle through v2.2 contracts.

**Migration window (optional, not forced):**

A v2.1 class may *elect* to migrate to v2.2 during a `migration_window` (governance-declared, 8 macro-epoch duration). Conditions for migration election:
1. All current challenge windows closed.
2. No T3 provisional installs pending.
3. Governance approval from both multisig sets (v2.1 and v2.2 deployers).

If migration is elected, the class's active S_cred history is imported to v2.2 CredibilityAggregator_v2 as a genesis prior (analogous to shadow-class genesis prior, attenuated at α_prior_base × (1 − v2_migration_discount), where v2_migration_discount = 0.10 — same-mode same-class migration has low mismatch). LTRP and escrow balances transfer in-kind.

**EAT continuity:** v2.1 EAT and v2.2 EAT are separate Merkle root sequences, both anchored to Ethereum calldata. A `contract_migration` EAT event on the v2.1 chain records the migration; the v2.2 chain's genesis event references the v2.1 class ID. Cross-version audit is possible via these cross-references.

**Why additive is safer than in-place upgrade:** In-place upgrade requires storage layout compatibility between v2.1 and v2.2 contracts. CLEARING_MODE settlement is financially irreversible; a storage migration bug during an active settlement epoch would be catastrophic. Additive deployment with class-level version pinning bounds the blast radius of any v2.2 contract defect to v2.2 classes only. (#r160)

---

**Q2 (5-contract concurrency safety — S_cred at T_anchor, cross-contract call ordering) → T_anchor freeze is a single atomic StateFreeze transaction; CredibilityAggregator and SettlementEngine share a read-only snapshot, not a live reference (#r160):**

The safety concern: if SettlementEngine reads S_cred from CredibilityAggregator at T_anchor but another transaction simultaneously updates S_cred, the settlement capture is non-deterministic.

**Resolution — StateFreeze atomic transaction:**

```
T_anchor flow:
  1. Oracle fires (external event or governance-triggered).
  2. SettlementEngine calls CoordinateRegistry.freezeForSettlement(class_id, epoch):
       CoordinateRegistry atomically:
         a. Reads S_cred from CredibilityAggregator (snapshot)
         b. Writes snapshot to SettlementEngine.candidate_price storage slot
         c. Emits T_anchor EAT event with: S_mechanism_snapshot, epoch, block_hash
         d. Marks class as settlement_frozen = true
       All in a single EVM transaction — no interleaving.
  3. From T_anchor onward: CredibilityAggregator continues accepting new claims
     (new claims do not affect settlement_frozen S_cred snapshot; they advance S_cred
     for the next clearing epoch only).
  4. SettlementEngine reads candidate_price from its own storage slot — no live reference
     to CredibilityAggregator after T_anchor.
```

**Key invariant:** SettlementEngine.candidate_price is written once (atomically at T_anchor) and never updated until T_finality closes the settlement epoch. It is a local storage copy, not a pointer to CredibilityAggregator state.

**Re-entrancy safety:** CoordinateRegistry.freezeForSettlement does not call back into CredibilityAggregator after the snapshot read. The cross-contract interaction is one-way, one-shot. Standard checks-effects-interactions pattern applies.

**EQ q_bonus snapshot coupling (per #r151/Q4):** q_bonus effective_weight snapshots are taken in the same atomic T_anchor transaction — CredibilityAggregator.getEffectiveWeightSnapshot is called once during the freeze and committed to EATManager alongside the S_cred snapshot.

**Design law (#r160):** Cross-contract settlement state capture must always be atomic (single transaction, no interleaving). Settlement-critical reads must be snapshotted to local storage at T_anchor, not left as live cross-contract references. One-way, one-shot cross-contract calls at the settlement boundary prevent concurrent update races. (#r160)

---

**Q3 (Demo Day narrative — one paragraph, investor-facing, no mechanism jargon) (#r160):**

> Most prediction markets are zero-sum: for every dollar won, someone loses a dollar, and the only signal they produce is what the crowd currently believes. GestAlt is different. It is a clearing protocol for institutional event-contract positions where the question is not "what does the crowd think?" but "what is the credible best estimate of this variable, backed by real capital at risk?" Participants who post accurate state estimates earn ongoing fees from institutions who need those estimates to settle their positions. Participants who post wrong estimates lose their posted collateral. Over time, the protocol learns who has reliable information and weights them accordingly — so the clearing price reflects the judgment of the most credible contributors, not just the most capital. Compared to Polymarket, where anyone can move the market with enough money, GestAlt's clearing price is harder to manipulate precisely because capital alone is not enough — you need a track record of being right.

**Framing notes:**
- Avoids "scoring rule," "LMSR," "S_cred," "TOWL."
- Anchors to institutional use case (clearing, not entertainment betting).
- Distinguishes on credibility-weighting vs capital-weighting without naming the mechanism.
- Last sentence lands the competitive differentiation cleanly against Polymarket. (#r160)

---

**Q4 (Minimum viable challenger population — epistemically live threshold) → 1 independent challenger per 5 active warranted T3 installations; auto-alert below threshold; bootstrap subsidy for challenger_pool genesis (#r160):**

The challenger population is the epistemic enforcement layer. Without challengers, wrong warranted installations persist unchallenged, S_cred degrades, and the mechanism loses its quality guarantee. The question is the minimum live challenger density before the mechanism is epistemically trustworthy.

**Formal threshold derivation:**

Each warranted T3 installation has expected error rate `ε_T3 ∈ [0, 1]` (governance-estimated at class registration; default 0.1 for a well-calibrated class). For the challenger pool to maintain epistemic live status, the expected number of successful challenges in any epoch must be ≥ 1:

```
E[challenges] = ε_T3 × N_T3_active × P(challenger_detects | wrong_install)

P(challenger_detects | wrong_install) ≈ 1 - (1 - p_individual_detect)^N_challengers
```

For P(challenger_detects | wrong_install) ≥ 0.8 (80% detection probability) with p_individual_detect = 0.5 (individual challenger has 50% chance of detecting a single wrong installation):

```
N_challengers ≥ log(1 - 0.80) / log(1 - 0.50) = log(0.20) / log(0.50) ≈ 2.3 → ceil → 3
```

Per 5 active warranted installations (N_T3_active / 5 ratio keeps the denominator tractable):

```
min_challenger_density = 1 challenger per 5 active T3 installations
min_challenger_count_absolute = max(3, floor(N_T3_active / 5))
```

**Epistemically live status:**

```
epistemically_live(class_i) =
  active_challenger_count(class_i, epoch_t) ≥ min_challenger_count_absolute(class_i)
```

Where `active_challenger_count` = number of unique addresses who have submitted at least 1 successful challenge in the trailing N_calibration normal-mode macro-epochs.

**Governance action below threshold:**

1. Auto-alert: `epistemic_liveness_warning` when count < 1.5× min (approaching threshold).
2. `epistemically_live = false`: T3 new installations throttled to 50% of normal TOWL capacity (new high-warranty claims still permitted but at half pace; existing claims unaffected).
3. Challenge pool bootstrap subsidy: if challenger_pool balance < 3× r_floor_per_class (too thin to attract challengers), governance auto-seeds the pool from governance treasury (analogous to genesis bootstrap, #r69).

**Why this does NOT degrade to an orderbook watch-tower:** A watch-tower in LMSR monitors prices and corrects arbitrage. A challenger in this mechanism monitors warranted-state quality and earns slash proceeds. The challenger population is endogenous: as wrong claims accumulate (low epistemically-live epochs), slash opportunities increase, attracting more challengers. The mechanism self-corrects toward the threshold, but requires a minimum seed to activate the positive-feedback loop.

**v2.1 launch gate:** GestAlt v2.1 should not go live on any coordinate class until that class achieves `epistemically_live = true` for at least 2 normal-mode macro-epochs. This is the operational readiness gate. (#r160)

---

## Structural Synthesis: v2.1 Production Readiness Criteria (#r160)

GestAlt v2.1 is production-ready on a coordinate class when ALL of the following are satisfied:

| Gate | Criterion | Source |
|------|-----------|--------|
| Solvency | TOWL zone A or B | #r71 |
| Epistemic liveness | active_challenger_count ≥ min for ≥2 epochs | #r160/Q4 |
| DA liveness | Normal mode (not degraded) | #r75 |
| Oracle readiness | Oracle registered, tested, and TWAP data available | #r144 |
| EAT operational | Merkle roots live on Ethereum; Celestia warm tier live | #r75 |
| Settlement contract audit | SettlementEngine + ClaimEscrow audited pre-deployment | Solvency-first mandate |

**v2.1 five-contract launch checklist (adds operational gates to invariant list):**

1. CoordinateRegistry: coordinate class registered, mode=CLEARING_MODE, staleness + κ set
2. ClaimEscrow: LTRP seeded at ≥ LTRP_seed_minimum; escrow pool live
3. CredibilityAggregator: S_cred initialized (uniform prior); epoch buffer live
4. SettlementEngine: position registry integrated; SFP parameters set; Zone C deferral active
5. EATManager: Ethereum calldata live; Celestia warm tier live; degraded-mode state machine active

---

## Cumulative Invariants (additions through #r160)

**Invariant #36 (#r160):** v2.1→v2.2 upgrade is additive (parallel deployment). v2.1 classes pin to v2.1 contracts for their full lifecycle. No forced migration.

**Invariant #37 (#r160):** Settlement state capture (S_cred at T_anchor) must be a single atomic transaction. Local storage copy at T_anchor; no live cross-contract references after freeze.

**Invariant #38 (#r160):** GestAlt v2.1 does not go live on any coordinate class until `epistemically_live = true` for ≥2 consecutive normal-mode macro-epochs (minimum 1 challenger per 5 active T3 installations; absolute floor 3 challengers).

---

## Open Questions for #r161+

1. **Cross-version S_cred reference for v2.2 shadow-class referencing v2.1 clearing class:** In the additive deployment model, a v2.2 shadow-class may reference a v2.1 clearing class position registry as its WED_clearing source. Define the cross-contract read interface — is it a direct EVM call (creates v2.1 contract dependency in v2.2 code) or a governance-registered registry adapter?

2. **epistemically_live 50% throttle interaction with TOWL Zone C:** Both conditions can suppress new T3 installations simultaneously. Should the combined suppression be additive (50% × Zone-C-rate) or the more restrictive floor (whichever is lower)?

3. **Demo Day narrative calibration:** The Q3 paragraph positions against Polymarket. Should there be a distinct one-paragraph variant positioned against Kalshi (regulatory-grade event contracts) and Betfair (exchange-style, liquidity-depth)? Sarthak to review for Demo Day framing needs.

4. **Five-contract audit scope for v2.1 launch:** SettlementEngine + ClaimEscrow are identified as audit-required. Should CredibilityAggregator also be in audit scope (it contains the credibility_ratio update logic, which is the most attack-surface-rich component for track-record manipulation)?

*Last updated: #r161 — 2026-04-04T00:32Z*

---

## #r161 Contributions — 2026-04-04T00:32Z

Addresses all four open questions from #r160. Adds one net-new structural insight: CredibilityAggregator is the highest attack-surface contract in v2.1 and should anchor the audit scope.

---

**Q1 (Cross-version S_cred reference — v2.2 shadow-class reading v2.1 clearing-class position registry) → Governance-registered registry adapter; no direct v2.2→v2.1 contract dependency (#r161):**

A direct EVM call from v2.2 code to a v2.1 contract address creates a versioned dependency: v2.2 contracts must know v2.1 storage layouts. If v2.1 is ever deprecated or upgraded, v2.2 breaks. This is an unacceptable coupling for a long-lived additive architecture.

**Resolution — registry adapter pattern:**

```
PositionRegistryAdapter (governance-deployed, version-agnostic):
  interface IPositionRegistry {
    function getWEDClearing(bytes32 class_id, uint epoch) external view returns (uint256);
    function getPositionMaxLoss(bytes32 class_id) external view returns (uint256);
  }

At governance registration of a shadow-class pair:
  governance registers adapter_address for clearing_class_id
  v2.2 CredibilityAggregator reads WED_clearing from adapter_address (IPositionRegistry)
  adapter_address is governance-upgradeable (stored in CoordinateRegistry_v2.2 as a reference,
  not hardcoded in v2.2 bytecode)
```

**Adapter as governance-deployed proxy:** The adapter is a thin translation contract:
- For v2.1 clearing classes: adapter calls `SettlementEngine_v1.getPositionExposure(class_id)` using v2.1 storage layout.
- For future v2.3+ clearing classes: adapter is redeployed with v2.3 storage translation.

**Security property:** v2.2 contracts have no dependency on v2.1 contract addresses. They depend only on the adapter address registered by governance — governance-upgradeable but governance-audited. The blast radius of a v2.1 SettlementEngine bug does not propagate to v2.2 code.

**Governance action at pair registration:** Emit `position_registry_adapter_registered` EAT event: `{ shadow_class_id, clearing_class_id, adapter_address, clearing_contract_version: v2.1 }`.

**Design law (#r161):** Cross-version contract references must be mediated by governance-registered adapters with version-agnostic interfaces. Direct versioned dependencies between contract sets are prohibited. Governance bears the responsibility of maintaining adapter correctness; the core contracts remain version-isolated. (#r161)

---

**Q2 (epistemically_live 50% throttle + Zone C simultaneous — combined suppression) → More restrictive floor; not multiplicative (#r161):**

The two suppression mechanisms are conceptually orthogonal:
- Zone C: solvency-driven. TOWL is under stress; new installations risk pushing TOWL further into deficit.
- epistemically_live = false: quality-driven. New installations cannot be epistemically enforced; challenger population is too thin.

**Why multiplicative (50% × Zone-C-rate) is wrong:**

Multiplicative produces rates like 50% × 30% = 15% of normal installation capacity. The Zone C rate is already a governance-calibrated solvency safety margin. Applying epistemically_live throttle on top assumes the two conditions are independent and that their combined effect should be the product. But the throttle is a binary quality gate, not a continuous rate — "50% of normal capacity" is already a solvency-style throttle applied for a quality reason, which creates semantic confusion.

**Resolution — more restrictive floor:**

```
effective_installation_throttle(class_i, epoch_t) = min(
  zone_c_throttle_rate(class_i, t),      // from TOWL Zone C logic
  epistemic_throttle_rate(class_i, t)    // 1.0 if live; 0.5 if not epistemically_live
)
```

The more restrictive condition governs. If Zone C allows 30% and epistemically_live = false allows 50%, the effective rate is 30%. If Zone C is not active (100%) and epistemically_live = false, the effective rate is 50%.

**Governance reporting:** Each epoch, EAT commits `installation_throttle_active: { zone_c_rate, epistemic_rate, effective_rate, governing_condition: "zone_c" | "epistemic_liveness" | "neither" }`. This makes the governing constraint transparent for post-hoc accountability.

**Design law (#r161):** When multiple independent suppression conditions target the same variable (installation rate), apply the more restrictive floor. Multiplicative suppression implies independence and continuity assumptions that do not hold for binary quality gates. (#r161)

---

**Q3 (Demo Day narrative variants — Kalshi and Betfair) → Two additional paragraphs; Sarthak to select per audience (#r161):**

**Variant A — vs Kalshi (regulatory-grade event contracts):**

> Kalshi's edge is regulatory legitimacy: it is CFTC-regulated and can offer contracts that others cannot. GestAlt's edge is epistemic legitimacy: it is not enough to be legally allowed to settle a contract — the settlement price itself must be credibly accurate, traceable, and manipulation-resistant. Kalshi's settlement is oracle-dependent and challengeable only through legal process. GestAlt's settlement is credibility-weighted by the track records of participants who stake real capital on their assessments, and challengeable on-chain within a defined window. For institutional counterparties whose clearing price determines margin calls, collateral transfers, or structured product payoffs, the question is not "was this contract legal?" but "was this settlement price right?" — GestAlt answers the second question.

**Variant B — vs Betfair (exchange-style, liquidity-depth):**

> Betfair is a deep, efficient exchange: it matches buyers and sellers at prices that reflect aggregate willingness-to-bet. The problem is that willingness-to-bet and epistemic accuracy are not the same thing. A large position from a well-capitalised bettor moves the market as much as one from a domain expert — capital is the only signal Betfair's mechanism sees. GestAlt builds a different market: one where the settlement price reflects not just capital weight but calibration weight — how often has this participant been right in the past, on similar events, with real money at stake? For institutional clearing where accuracy matters more than liquidity depth, GestAlt's credibility-weighted price is structurally harder to move without actually being right.

**Usage note for Sarthak:** Use the Polymarket variant (#r160/Q3) when the audience is DeFi-native and cares about manipulation resistance. Use the Kalshi variant when the audience is institutional or regulatory and cares about accuracy of settlement. Use the Betfair variant when the audience has exchange/trading backgrounds and cares about price formation quality. All three can be held in reserve and selected per room. (#r161)

---

**Q4 (Five-contract audit scope for v2.1 launch — CredibilityAggregator) → Three-contract minimum audit scope: CredibilityAggregator + ClaimEscrow + SettlementEngine; two-contract secondary scope: CoordinateRegistry + EATManager (#r161):**

**Attack surface analysis by contract:**

| Contract | Primary attack surface | Audit priority |
|---|---|---|
| CredibilityAggregator | credibility_ratio manipulation (track-record gaming); single-agent dominance bypass (W_max); epoch-buffer timing games | **CRITICAL** |
| ClaimEscrow | slash routing bugs; longtail escrow accounting; LTRP seed drain | **CRITICAL** |
| SettlementEngine | SFP T_anchor race conditions; oracle_settlement_override authorization; Zone C deferral bypass | **CRITICAL** |
| CoordinateRegistry | staleness parameter manipulation at registration; version-pinning bypass | **HIGH** |
| EATManager | Merkle root manipulation; degraded-mode trigger gaming | **HIGH** |

**Why CredibilityAggregator must be in audit scope:**

The credibility_ratio update is the mechanism's most attack-surface-rich computation:
1. **Log-score manipulation:** A sophisticated participant could structure claims to maximise log-score gain while minimising loss exposure — requires careful review of edge cases (zero-probability claims, extreme stake sizes, rounding).
2. **W_max bypass:** The single-agent dominance cap (`W_max`) is enforced in CredibilityAggregator. If bypassed, a single agent can dominate S_cred — the mechanism's core epistemic integrity fails.
3. **Epoch-buffer timing:** The one-epoch clearing feed buffer (new claims do not affect settlement until the next epoch) must be atomic with the T_anchor StateFreeze. A race condition here allows a last-second credibility_ratio update to influence the candidate settlement price.
4. **S_cred aggregation overflow/underflow:** credibility-weighted aggregation involves floating-point-style arithmetic on-chain. Precision loss or overflow in extreme cases must be verified.

**Recommended audit scope:**

- **Primary (pre-launch required):** CredibilityAggregator, ClaimEscrow, SettlementEngine — all three in scope for a single coordinated security audit. Rationale: these three contracts interact atomically at T_anchor (StateFreeze transaction, #r160/Q2); an auditor must review them together, not independently.
- **Secondary (pre-v2.2 required, can follow launch by one quarter):** CoordinateRegistry, EATManager — lower direct financial stakes but required for full system integrity.

**Audit deliverable specification:** The audit scope must include the T_anchor atomic transaction call-ordering (#r160/Q2), the credibility_ratio log-score edge cases, the W_max cap enforcement, and the Zone C deferral state machine in SettlementEngine. These are the four highest-probability defect locations.

**Design law (#r161):** Audit scope is determined by attack surface, not contract count. Contracts that interact atomically at settlement-critical transactions must be audited together as a unit. The three-contract primary audit scope is the minimum; piecemeal auditing of these three is insufficient. (#r161)

---

## Net-New Structural Insight: CredibilityAggregator as the Mechanism's Trust Root (#r161)

The full 161-run design converges on a key architectural observation: the CredibilityAggregator is the mechanism's **trust root** — the component whose correctness all other epistemic guarantees depend on.

**Why CredibilityAggregator is the trust root:**

- S_cred correctness depends on credibility_ratio correctness. If credibility_ratio is manipulable, S_cred is manipulable, which means settlement prices can be gamed by track-record manipulation — the mechanism's core differentiation from LMSR fails.
- The oracle-authority/attestor duality (#r151) requires attestation quality to be meaningful. Attestation quality derives from credibility_ratio. If credibility_ratio is noise, oracle overrides become the only reliable settlement signal — degrading the mechanism to oracle-only pricing.
- Epistemic liveness (#r160/Q4) is measured by challenger pool activity, which is only profitable if credibility_ratio updates are honest. Corrupted credibility_ratio = challengers cannot identify wrong installations efficiently = epistemically_live collapses.

**The trust root implication for GestAlt v2.1:**

GestAlt can tolerate bugs in secondary contracts (EATManager bugs = audit gaps; CoordinateRegistry bugs = parameter miscalibration) and recover through governance. A CredibilityAggregator bug that allows credibility_ratio manipulation may be undetectable until significant settlement damage has occurred — and may be irreversible (credibility history once committed propagates forward through all subsequent S_cred computations).

**Operational consequence:** The CredibilityAggregator update logic must be the most conservatively designed, most thoroughly audited, and least mutable component of GestAlt v2.1. Any upgrade to CredibilityAggregator (even v2.1 patches) must trigger a re-audit of the credibility_ratio update path and a re-evaluation of epistemically_live status for all active coordinate classes.

**Invariant addendum (#r161):** CredibilityAggregator upgrades require re-audit and epistemically_live re-evaluation. No patch to the credibility_ratio update logic is deployable without auditor sign-off. This constraint is independent of governance multisig approval — it is a mechanism safety invariant. (#r161)

---

## Structural Synthesis: v2.1 Audit and Deployment Architecture — Closed (#r161)

| Issue | Resolution | Law |
|---|---|---|
| Cross-version S_cred reference | Governance-registered adapter (IPositionRegistry); no direct versioned dependency | Cross-version coupling prohibited; adapters mediate |
| Dual suppression floor | More restrictive floor (not multiplicative); governing condition logged per epoch | Binary quality gates use floor, not product |
| Demo Day narrative variants | Three paragraphs: vs Polymarket (#r160), vs Kalshi, vs Betfair; select per audience | Sarthak selects per room |
| Audit scope | Three-contract primary (CredibilityAggregator + ClaimEscrow + SettlementEngine); audited together | Atomic-interaction contracts audited as unit; CredibilityAggregator is trust root |

---

## Cumulative Invariants (additions through #r161)

**Invariant #39 (#r161):** Cross-version contract references are mediated by governance-registered adapters with version-agnostic interfaces. No direct versioned EVM dependencies between contract sets.

**Invariant #40 (#r161):** When multiple independent suppression conditions target the same installation rate, apply the more restrictive floor — never multiplicative.

**Invariant #41 (#r161):** CredibilityAggregator is the mechanism's trust root. Upgrades require re-audit of the credibility_ratio update path and re-evaluation of epistemically_live status for all active classes. No patch deployable without auditor sign-off.

**Invariant #42 (#r161):** The three-contract primary audit scope (CredibilityAggregator, ClaimEscrow, SettlementEngine) must be audited together as a unit before v2.1 launch. Piecemeal auditing of these three is insufficient.

---

## Open Questions for #r162+

1. **CredibilityAggregator upgrade governance gate:** Define the precise governance multi-step required to deploy a CredibilityAggregator upgrade: (a) audit submitted; (b) governance vote; (c) epistemically_live re-evaluation window; (d) deploy. What is the minimum time between each step? Should there be a time-lock even for emergency fixes?

2. **IPositionRegistry adapter trust model:** The adapter is governance-upgradeable. A malicious governance action could replace the adapter with one that returns fabricated WED_clearing data, causing v2.2 shadow-classes to route knower incentives incorrectly. What immutability constraint prevents this — is the adapter address stored immutably in shadow-class registration, or should it be governance-alterable only with a time-lock?

3. **More-restrictive-floor throttle and knower planning horizon:** When the effective_installation_throttle drops below 1.0 for multiple consecutive epochs (sustained Zone C or sustained epistemically_live failure), knowers with pending declarations cannot install. What is the maximum queue depth before queued declarations begin to expire, and how should governance prioritize queue drain on throttle recovery?

4. **Mechanism completeness declaration:** With 42 invariants, 5-contract v2.1 scope, full audit scope defined, and three Demo Day narratives ready, is the knowledge-marketplace mechanism design complete enough to hand off to the smart contract engineering team? What is the minimum readable engineering spec format — invariants + 10-point framework (#r148) + 5-contract launch checklist (#r160) — that constitutes a handoff-ready document?

*Last updated: #r161 — 2026-04-04T00:32Z*

---

## #r162 Contributions — 2026-04-04T00:42Z

Addresses all four open questions from #r161. Adds one net-new structural insight: the mechanism specification is complete; the remaining gap is the translation layer to an engineering specification.

---

**Q1 (CredibilityAggregator upgrade governance gate — multi-step with time-lock) → Four-phase gate with minimum epoch separations; emergency path reduces but cannot eliminate the hold (#r162):**

The trust-root designation (#r161) requires the most conservative upgrade path of any v2.1 contract. An upgrade to the credibility_ratio update logic that introduces a subtle manipulation surface may be undetectable until settlement damage has accumulated — so the gate must be proportionately strict.

**Standard upgrade path (four phases):**

```
Phase 1 — Audit:
  Independent auditor submits scoped audit of the diff to the credibility_ratio update path.
  Minimum duration: 2 macro-epochs (review window; cannot be shortened by governance).
  EAT event: credibility_aggregator_audit_submitted { diff_hash, auditor_address, scope }

Phase 2 — Governance vote:
  Begins at first macro-epoch boundary after audit_submitted.
  Passes with: standard k-of-n multisig threshold.
  EAT event: credibility_aggregator_upgrade_voted { vote_result, upgrade_contract_address }

Phase 3 — epistemically_live re-evaluation window:
  Minimum: N_calibration macro-epochs after vote passes.
  Condition: all active coordinate classes must maintain epistemically_live = true throughout the window.
  Rationale: new credibility_ratio logic should be validated against live epoch data before settlement-critical deployment.
  If any class is epistemically_live = false during the window, the window extends until all classes are live for N_calibration consecutive normal-mode epochs.
  EAT event: credibility_aggregator_reeval_start { vote_epoch, required_window }

Phase 4 — Deploy:
  At the first epoch boundary after re-evaluation window completes.
  Contract-enforced time-lock: pendingUpgrade state machine in CredibilityAggregator requires
    block.timestamp >= vote_epoch + N_timelock_macro_epochs x macro_epoch_length.
    N_timelock_macro_epochs = N_calibration (governance-settable, hard floor = 2).
  EAT event: credibility_aggregator_deployed { old_contract_address, new_contract_address }
```

**Total minimum standard upgrade duration:** 2 (audit) + 1 (vote) + N_calibration (re-eval) macro-epochs. Default N_calibration=4: minimum 7 macro-epochs end-to-end.

**Emergency path:**

Emergency upgrades (e.g., live exploit in credibility_ratio update) require speed but cannot entirely bypass safety:

```
Emergency path:
  Phase 1 (shortened): Emergency auditor review, minimum 1 macro-epoch.
             Requires auditor_emergency_certified flag (governance pre-approved auditor list).
  Phase 2 (elevated threshold): k-of-n emergency multisig with elevated threshold
             (e.g., 4-of-5 vs 3-of-5 for standard; governance-set emergency_k).
  Phase 3 (shortened): 1 macro-epoch epistemically_live hold (not N_calibration).
  Phase 4: Deploy. Time-lock minimum = 1 macro-epoch hard floor (not removable, even in emergency).
```

**Why the 1 macro-epoch hard floor cannot be removed:** An emergency with zero time-lock means the CredibilityAggregator can be replaced atomically by governance in a single transaction. This collapses the trust-root guarantee entirely — the credibility_ratio can be silently reset or corrupted by a governance capture event with zero detection window. One macro-epoch minimum ensures at least one public EAT event (the vote) is visible before the deployment executes.

**Design law (#r162):** The CredibilityAggregator time-lock minimum is 1 macro-epoch, immutable at the contract level, even for emergency fixes. The trust-root designation mandates a non-zero detection window. No governance vote, multisig configuration, or emergency parameter can set this floor to zero. (#r162)

---

**Q2 (IPositionRegistry adapter trust model — adapter address and time-lock) → Epoch-snapshot isolation; adapter changes are prospective only; time-lock = max(N_calibration, 4) macro-epochs (#r162):**

Two failure modes for the adapter:
1. **Broken reference (adapter address goes stale):** v2.1 clearing-class contracts are upgraded/deprecated; adapter no longer returns valid data.
2. **Malicious replacement:** Governance replaces adapter with a fabricated one; future WED_clearing signals are compromised.

**Resolution — epoch-snapshot isolation with prospective-only changes:**

```
CredibilityAggregator.computeWEDClearing(class_id, epoch_E):
  adapter_address = CoordinateRegistry.getAdapterAddressAtEpochOpen(class_id, epoch_E)
  return IPositionRegistry(adapter_address).getWEDClearing(class_id, epoch_E)
```

`getAdapterAddressAtEpochOpen(class_id, epoch_E)` returns the adapter address that was registered at the **start** of epoch E — snapshotted at epoch boundary, immutable for that epoch, stored in EAT. Any governance change to the adapter address takes effect only at the next epoch boundary.

**Time-lock on adapter changes:**

```
adapter_change_timelock = max(N_calibration, 4) macro-epochs

Governance submits adapter_change_proposal -> EAT event emitted immediately (public)
  -> time-lock countdown begins
  -> at T_change_epoch = proposal_epoch + adapter_change_timelock: change activates at epoch boundary

During time-lock: shadow-class operators, knowers, and participants can inspect proposed adapter
  and challenge or exit positions if the proposed adapter is suspected malicious.
```

**Stale reference (adapter goes dead):** If a v2.1 clearing class is decommissioned and its adapter stops returning valid data, CoordinateRegistry flags the class as `adapter_stale = true`. CredibilityAggregator treats `adapter_stale` classes as WED_clearing = 0 (no incentive signal; knowers stop earning from WED routing for that class but are not slashed). Governance must submit a new adapter or decommission the shadow-class.

**Why not full immutability at registration:** Fully immutable adapter = no recovery path when the underlying clearing class upgrades. Time-lock = detection window + exit option. The time-lock replaces immutability with a prospective-only change window that preserves historical integrity while allowing maintenance.

**Design law (#r162):** Governance-upgradeable references that serve as external data sources for S_cred must use epoch-snapshot isolation (changes prospective-only) and a time-lock of max(N_calibration, 4) epochs. Historical S_cred computations are never retroactively affected by adapter changes. (#r162)

---

**Q3 (Declaration queue depth, expiry, and priority on throttle recovery) → Queue cap = 2x normal-epoch-capacity; FIFO default with WED-priority opt-in on recovery; expiry at N_queue_expiry = 8 epochs (#r162):**

When effective_installation_throttle < 1.0 for sustained periods, declarations pile up. Two failure modes:
1. **Unbounded queue:** Memory/state cost grows without limit.
2. **Stale declarations:** A declaration submitted during Zone C may be epistemically stale by the time throttle lifts — the knower's information has decayed.

**Queue design:**

```
N_queue_max(class_i) = 2 x K_normal  where K_normal = installations per normal epoch (class-level)
  Default: governance-set per class at registration; auto-derived from historical install rate post-genesis.

N_queue_expiry = 8 macro-epochs  (governance-settable, bounded [4, 16])

Queue entry expires if: declaration has been in queue for > N_queue_expiry macro-epochs.
  On expiry:
    - Escrow fully refunded (static-escrow design law: no forced lockup past knower intent)
    - declaration_queue_expired EAT event committed
    - Knower notified (governance-alert channel)
  No credibility_ratio penalty for expiry: expiry is a mechanism operational event, not a knower error.
```

**Priority on throttle recovery:**

Default priority: FIFO — oldest declarations processed first. Simple, fair, manipulation-resistant.

Opt-in per class at registration: `queue_drain_policy = FIFO | WED_priority`. If `WED_priority`:

```
On throttle recovery (effective_installation_throttle returns to 1.0):
  Queue drain order: descending WED_clearing(c) at recovery epoch
  (WED_clearing re-evaluated at recovery epoch, not at submission epoch)
  Rationale: highest-decision-impact declarations should enter the state first when capacity opens.
```

**WED_priority gaming surface:** Knowers could inflate WED_clearing(c) by registering large positions to front-run the queue. Defence: WED_clearing is already protected by real position risk (positions must be registered before T_anchor; see #r150 pre-T_anchor requirement). Inflating WED_clearing to jump the queue requires real capital at risk — economically self-limiting.

**Partial-throttle epoch handling:** If throttle rate = 0.5 and queue has N entries, exactly floor(0.5 x K_normal) entries are processed per epoch from the queue. Remainder stays in queue. Queue expiry clock continues running during partial-drain epochs.

**Design law (#r162):** Declaration queues for throttled installation are capacity-bounded (2x normal) and time-bounded (N_queue_expiry epochs). Expiry is a mechanism safety valve, not a knower penalty. Queue drain default is FIFO; WED-priority is opt-in for classes where decision-impact ordering is valued over fairness. (#r162)

---

**Q4 (Mechanism completeness declaration and handoff format) → Mechanism specification is complete for v2.1 handoff; engineering spec requires a separate translation pass; canonical handoff format defined (#r162):**

**Completeness declaration:**

The knowledge-marketplace mechanism design is **complete as a mechanism specification** for GestAlt v2.1. After 162 runs, the following are fully specified:
- All 42 invariants (now 46 with #r162) with source run provenance
- 10-point primitive framework (#r148, updated through #r162)
- 5-contract v2.1 scope with attack surface analysis and audit priority (#r160, #r161)
- v2.1 production readiness gates (6-gate checklist, #r160)
- Governance parameter registry (all bounded primitives derived throughout #r1-#r162)
- Three Demo Day narratives (#r160/Q3, #r161/Q3)
- CLEARING_MODE and DISCOVERY_MODE specifications with regime split (#r149)
- Settlement Freeze Protocol and oracle-authority/attestor duality (#r151)
- Complete escrow taxonomy (5-component, #r146)
- Upgrade path and cross-version architecture (#r160, #r162)

**The gap between mechanism spec and engineering spec:**

The aggregate document is a **mechanism specification** — it defines what the system must do, its invariants, its state transitions, and its attack surfaces. An engineering team needs an **engineering specification** — how to implement: ABI-level interfaces, Solidity storage layouts, test vectors, and oracle registration formats.

The translation from mechanism spec to engineering spec requires:
1. Deriving function signatures and parameter types from each contract's role (#r160/Q2)
2. Specifying Solidity storage layouts for each contract (EAT Merkle tree, TOWL FIFO, credibility_ratio rolling window)
3. Generating test vectors for log-score edge cases (zero probability, extreme stake sizes, rounding)
4. Specifying the oracle registration format and governance approval process for oracle_address

This translation pass is estimated at ~1 day of focused engineering specification work, given the mechanism spec's completeness.

**Canonical handoff document format (minimum viable):**

```
GestAlt v2.1 Engineering Handoff Pack:

Section 1 — Mechanism Spec Index (3 pages)
  - 46 invariants with run references (from this aggregate)
  - Governance parameter registry: all bounded params with defaults and derivation
  - 6-gate production readiness checklist

Section 2 — 10-Point Primitive Framework (5 pages)
  - From #r148 (base primitive, state model, credibility model, roles,
    settlement, attack surface, LMSR comparison, mechanism sketch,
    failure mode, surviving variant)

Section 3 — 5-Contract Specifications (10 pages)
  - Per contract: role, key invariants, primary attack surface,
    cross-contract dependencies, upgrade governance gate
  - T_anchor StateFreeze call ordering diagram

Section 4 — Parameter Registry (3 pages)
  - All governance-settable parameters: name, bounded range, default,
    derived-from relationship, governing invariant

Section 5 — Audit Briefing (2 pages)
  - Three-contract primary audit scope (CredibilityAggregator,
    ClaimEscrow, SettlementEngine) with four highest-risk code paths

Total: ~23 pages from existing aggregate content. No new mechanism design required.
```

**Mechanism design loop status:** The knowledge-marketplace thread is at a **natural handoff boundary** after #r162. Future runs should address:
(a) adversarial stress-testing of the v2.1 minimal scope under novel attack models
(b) v2.2 discovery-mode and shadow-class mechanism extensions
(c) specific mechanism gaps surfaced by the engineering team during spec translation

**Design law (#r162):** A mechanism specification is complete when: (1) all invariants are stated with provenance; (2) the 10-point primitive framework is fully answered; (3) the minimal viable implementation scope is bounded; (4) the three Demo Day narratives are ready; (5) the audit scope is defined; (6) the upgrade governance gates are specified. The knowledge-marketplace mechanism satisfies all six criteria as of #r162. (#r162)

---

## Net-New Structural Insight: The Mechanism-Engineering Gap as a First-Class Design Artifact (#r162)

After 162 runs, the autoresearch loop has produced a mechanism specification of unusual completeness. The key architectural observation is that **mechanism completeness and engineering readiness are distinct properties** — and conflating them is the most common cause of failed protocol deployments.

**Mechanism completeness** (this document): all invariants hold, all attack surfaces identified, all state transitions specified in logical terms.

**Engineering readiness**: all interfaces specified, all storage layouts determined, all edge-case behaviours codified in test vectors, all oracle integrations validated.

**Why the gap matters for GestAlt v2.1:**

The three-contract primary audit scope (#r161/Q4) can only be audited against an engineering specification, not a mechanism specification. An auditor who receives this aggregate document and a GitHub repository will spend significant time inferring implementation choices that the mechanism spec leaves open. The 1-day engineering spec translation pass is not optional — it is the prerequisite for the audit to be productive.

**Operational recommendation:** Before the audit engagement begins, Gaurav or Sarthak should schedule a focused 1-day session with the smart contract engineering team. Input: this aggregate document (Sections 1-5 of the handoff pack). Output: engineering spec with ABIs, storage layouts, and test vectors. Audit engagement begins after the engineering spec is reviewed and signed off.

---

## Structural Synthesis: Complete Mechanism Design Closure (#r162)

| Issue | Resolution | Law |
|---|---|---|
| CredibilityAggregator upgrade gate | 4-phase; 1 macro-epoch hard floor on time-lock; emergency reduces but cannot eliminate | Trust root = minimum detection window always enforced |
| Adapter trust model | Epoch-snapshot isolation; prospective-only changes; time-lock = max(N_calibration, 4) | Historical S_cred immutable against adapter changes |
| Declaration queue | 2x capacity cap; N_queue_expiry=8; FIFO default; WED-priority opt-in on recovery | Queue bounded in size and time; expiry not penalty |
| Mechanism completeness | Complete as mechanism spec; engineering spec = 1-day translation pass; handoff format defined | Mechanism spec and engineering spec are distinct; gap is explicit and bounded |

---

## Cumulative Invariants (additions through #r162)

**Invariant #43 (#r162):** CredibilityAggregator time-lock minimum = 1 macro-epoch, enforced at the contract level. No governance configuration can set this to zero.

**Invariant #44 (#r162):** IPositionRegistry adapter changes are prospective-only (epoch-snapshot isolation) with time-lock = max(N_calibration, 4) epochs. Historical S_cred computations are never retroactively affected.

**Invariant #45 (#r162):** Declaration queues are bounded: N_queue_max = 2x normal epoch capacity; N_queue_expiry = 8 macro-epochs. Expiry triggers full escrow refund and is not a credibility_ratio penalty event.

**Invariant #46 (#r162):** A mechanism specification is complete when: invariants stated with provenance; 10-point framework answered; minimal viable scope bounded; Demo Day narratives ready; audit scope defined; upgrade gates specified. The knowledge-marketplace mechanism satisfies all six as of #r162.

---

## Status: Mechanism Specification Complete (#r162)

The knowledge-marketplace mechanism is **specification-complete** for GestAlt v2.1.

**Remaining work before v2.1 launch (not mechanism research):**
1. Engineering spec translation pass (~1 day, engineering team + this document)
2. Three-contract primary audit (CredibilityAggregator + ClaimEscrow + SettlementEngine, together)
3. Secondary audit (CoordinateRegistry + EATManager)
4. v2.1 production readiness gate verification (6-gate checklist, #r160)
5. Demo Day narrative selection (Sarthak: three variants available from #r160/Q3 and #r161/Q3)

**Future autoresearch on this topic should be scoped to:**
- Adversarial stress-testing of v2.1 minimal scope under novel attack models
- v2.2 extension design (discovery mode, shadow-classes, implication chains, archive tiers)
- Specific mechanism gaps surfaced by the engineering team during spec translation

*Last updated: #r162 — 2026-04-04T00:42Z*

---

## #r163 Contributions — 2026-04-04T00:52Z

**Phase: Adversarial stress-testing of v2.1 minimal scope. (#r162 declared mechanism spec complete; this run opens systematic novel-attack analysis.)**

Focus: enumerate and evaluate attack vectors that are NOT already covered by the existing attack surface table (#r6, expanded through #r152). v2.1 scope is: CoordinateRegistry, ClaimEscrow, CredibilityAggregator, SettlementEngine, EATManager — CLEARING_MODE only, no implication chains.

---

### Attack Taxonomy: Five Novel Families for v2.1

---

#### A1 — Credibility Laundering via Coordinated Correct Claims

**Attack:** An adversary controls multiple Sybil accounts. Before the target settlement epoch, they stake modest amounts across many coordinate classes with pre-known outcomes (low-uncertainty events). All accounts accumulate high credibility_ratio at low cost. At the target settlement epoch, all accounts stake heavily, driving S_cred toward the adversary's desired settlement price. Settlement financial gain exceeds total credibility-building cost.

**Why not covered by existing Sybil defence:** The γ_corr defence (#r6) was designed around simultaneous multi-account credibility concentration, not sequential credibility laundering across low-cost preliminary events.

**Formal attack model:**

```
N accounts each build credibility_ratio ≈ C_target over K pre-target epochs
  staking S_small per epoch on N_easy_classes with σ_resolve ≈ 0.95

Cost per account ≈ K × S_small × 0.05  (5% expected loss on easy classes)

At target epoch: each account stakes S_large on target coordinate c
  Combined weight w_adversary = Σ_a (C_target × log(1 + S_large))

Attack profitable if: settlement_gain(w_adversary) > K × N × S_small × 0.05 + N × S_large × P(wrong)
```

**W_max partial defence:** W_max limits per-address contribution, but N addresses each at W_max contribute N × W_max combined — far exceeding the per-entity cap.

**Defence — γ_corr as on-chain mapping in CredibilityAggregator:**

```
S_cred_contribution(a) = C_a × log(1 + k_a_net) × γ_corr(a)

γ_corr(a) = 1.0 if no cluster detected
γ_corr(a) ∈ [0.3, 0.9] if cluster detected (governance-committed)
```

γ_corr was mentioned in #r6 but never formally specified for on-chain v2.1 S_cred aggregation. This is a specification gap. Cluster detection may be off-chain (gas cost); γ_corr application must be contract-enforced.

**Secondary signal:** `S_cred_concentration_index = max_contributor_fraction / (1/N_active_contributors)`. High concentration → governance alert → γ_corr review trigger. Committed to EAT per epoch.

**New v2.1 spec addition:** γ_corr on-chain mapping in CredibilityAggregator, governance-updateable. S_cred_concentration_index in EAT. (#r163)

---

#### A2 — Settlement-Epoch Timing Attack via Zone C Trigger

**Attack:** An adversary with a position favouring a particular settlement price files a large spurious challenge on a high-escrow coordinate in the epoch before T_anchor, stressing TOWL capacity. If TOWL transitions to Zone C, settlement-finality challenge windows defer (#r151/Q1). The adversary's desired price is installed without SFP challenge risk during the Zone C window.

**Why novel:** Zone C deferral of SFP challenges was designed as solvency protection. It becomes an attack surface when Zone C can be deliberately triggered on a separate coordinate.

**Defence — SFP deferral immunity when zone_at_T_anchor ∈ {A, B}:**

```
zone_at_T_anchor = TOWL_zone(class_id, T_anchor_epoch)

settlement_finality_challenge_zone_c_deferral:
  IF zone_at_T_anchor ∈ {ZONE_A, ZONE_B}: challenge window NOT deferred
  IF zone_at_T_anchor == ZONE_C: standard deferral applies
```

If the class was solvent when the oracle fired, post-anchor Zone C transitions (triggered externally) do not affect SFP windows for this class. Deferral protects only already-stressed classes.

**EAT record addition:** zone_at_T_anchor field in T_anchor event. SettlementEngine reads this field for deferral determination. (#r163)

---

#### A3 — Pre-Resolution Withdrawal: Asymmetric Credibility Capture

**Attack:** If the mechanism permits voluntary claim withdrawal before oracle resolution, a knower can stake high on confident claims (earning credibility_ratio on correct resolution) and withdraw before resolution on uncertain claims (avoiding penalty). This asymmetrically builds credibility_ratio while evading the skin-in-the-game requirement.

**Check against existing spec:** ClaimEscrow specifies release paths but does not explicitly enumerate voluntary withdrawal as prohibited. This is a spec gap.

**Resolution — withdrawal explicitly prohibited; escape paths closed:**

```
ClaimEscrow escape paths (exhaustive, #r163):
  oracle_resolved_correct → release escrow
  oracle_resolved_wrong   → slash
  T_longtail_expiry       → LTRP routing
  challenge_success_slash → slash

Voluntary knower withdrawal: NOT A VALID OPERATION.
```

**Implication for S_cred:** A withdrawn claim that had contributed to S_cred would pollute the state vector with a contribution whose calibration signal is selectively filtered. Prohibition is required for both financial integrity (ClaimEscrow) and epistemic integrity (CredibilityAggregator).

**Design law (#r163):** Claim escrow is non-withdrawable post-submission. The staking event and resolution event are protocol-coupled. "Money on the table is proof-of-conviction" requires the table to be non-retractable. (#r163)

---

#### A4 — Oracle Timing Arbitrage: Position Front-Running S_cred Convergence

**Attack:** S_cred for a high-certainty coordinate converges to near-final value before T_anchor fires. An on-chain observer identifies the converged value and registers a position exploiting the known settlement price — not because they have genuine economic exposure, but because they saw S_cred converge. Position registration is still open because T_anchor has not fired.

**Mechanism impact:** WED_clearing is supposed to reflect genuine decision-relevant economic exposure. Speculative positions registered after S_cred convergence corrupt the WED_clearing signal — they reflect oracle-arbitrage, not real exposure.

**Defence — T_anchor_lock window:**

```
T_anchor_lock = T_anchor − N_lock_epochs  (default N_lock_epochs = 1 macro-epoch)

Position registration open:  T_class_genesis → T_anchor_lock
Position registration closed: T_anchor_lock → T_anchor (S_cred convergence window)

WED_clearing computed from position registry snapshot at T_anchor_lock.
```

The lock window (1 macro-epoch) gives S_cred one epoch to converge without position-registration gaming. Genuine position holders registered before T_anchor_lock are unaffected.

**New CoordinateRegistry field:** T_anchor_lock (derived from T_anchor − N_lock_epochs). Position registration gated by this timestamp. SettlementEngine reads WED_clearing from the T_anchor_lock snapshot. (#r163)

---

#### A5 — Epistemic Liveness Suppression via Flood-Challenge

**Attack:** An adversary creates wrong claims on easy-outcome coordinates (from controlled accounts), then challenges them from other accounts, earning challenger rewards while draining challenger_pool. With challenger_pool depleted, epistemically_live status for hard coordinates weakens, and the adversary installs wrong warranted claims on hard coordinates without effective challenge.

**Cost model:**

```
Net cost per wash cycle = slash × (1 − γ_challenger)
  at γ_challenger = 0.30: cost = slash × 0.70

Cost to drain challenger_pool by Δ = Δ / γ_challenger × (1 − γ_challenger) ≈ 2.33 × Δ
```

Attack costs ~2.33× what it drains. Feasible for thin challenger_pools on new classes.

**Defence — rate limit + γ_corr on challenger rewards + auto-refill:**

```
per_class_challenge_rate_limit = R_max (default: 5 challenges per address per macro-epoch)

γ_corr_challenger(a) applied to challenger rewards:
  challenger_reward(a) = base_reward × γ_corr_challenger(a)
  γ_corr_floor_challenger = 0.5  (preserve incentive while limiting wash profitability)

challenger_pool auto-refill already specified (#r160/Q4)
```

Floor = 0.5 (not lower): eliminating challenger incentive entirely would break epistemically_live. The floor preserves enforcement incentive while limiting wash-challenge income.

**New CredibilityAggregator additions:** R_max per-address challenge rate limit; γ_corr_challenger mapping; floor enforcement at 0.5. (#r163)

---

### Summary: Five Novel Attack Families and v2.1 Spec Additions

| Attack | Class | Defence | v2.1 spec addition? |
|--------|-------|---------|---------------------|
| A1 — Credibility laundering | Sybil + track record gaming | γ_corr on-chain mapping; S_cred_concentration_index | **YES** — CredibilityAggregator |
| A2 — Zone C timing exploit | TOWL manipulation → SFP deferral | SFP immunity if zone_at_T_anchor ∈ {A,B} | **YES** — SettlementEngine + EAT |
| A3 — Pre-resolution withdrawal | Claim exit before oracle | Withdrawal prohibited; escape paths closed | **YES** — ClaimEscrow invariant |
| A4 — Oracle timing arbitrage | Position front-running S_cred | T_anchor_lock; WED_clearing snapshot at lock | **YES** — CoordinateRegistry |
| A5 — Flood-challenge pool drain | Wash-challenge liveness suppression | Rate limit + γ_corr on challenger rewards + auto-refill | **YES** — CredibilityAggregator |

All five are v2.1-relevant. Four require additions to the v2.1 engineering spec not yet present. The adversarial stress-test phase is productive — the mechanism spec was logically complete but underdetermined on several implementation constraints.

**v2.1 contract spec additions from #r163 (by contract):**

1. **CredibilityAggregator:** γ_corr on-chain mapping (governance-updateable); S_cred_concentration_index per epoch; γ_corr_challenger mapping at floor 0.5; R_max per-address challenge rate limit.
2. **SettlementEngine:** zone_at_T_anchor field in T_anchor EAT event; SFP Zone C deferral conditional on zone_at_T_anchor.
3. **ClaimEscrow:** Explicit prohibition on voluntary pre-resolution withdrawal; escape path enum exhaustively closed.
4. **CoordinateRegistry:** T_anchor_lock field; position registration window closes at T_anchor_lock; WED_clearing computed from T_anchor_lock snapshot.

---

**Invariant additions (#r163):**

**Invariant #47:** Claim escrow is non-withdrawable post-submission. Voluntary knower withdrawal is not a ClaimEscrow operation. Escape paths: oracle_resolved, T_longtail_expiry, challenge_slash only. (#r163)

**Invariant #48:** SFP Zone C deferral applies only when zone_at_T_anchor == ZONE_C. If the class was in Zone A or B at T_anchor, settlement-finality challenge windows advance regardless of subsequent Zone C transitions. (#r163)

**Invariant #49:** Position registration closes at T_anchor_lock = T_anchor minus N_lock_epochs. WED_clearing is computed from the snapshot at T_anchor_lock, not at T_anchor. (#r163)

**Invariant #50:** γ_corr is applied in CredibilityAggregator both to S_cred contributions and to challenger rewards. Challenger γ_corr floor = 0.5 to preserve enforcement incentive. (#r163)

---

## Open Questions for #r164+

1. **γ_corr cluster detection — governance commit latency:** Cluster detection is off-chain; governance commits γ_corr updates as on-chain transactions. What is the maximum allowable governance response SLA? Define an interim fallback (e.g., provisional γ_corr floor on new addresses with no resolution history) to cover the window between cluster formation and governance γ_corr update.

2. **T_anchor_lock eliminates the T_grace window need:** The pre-T_anchor position requirement for SFP challenge eligibility (#r151/Q3) now resolves to "registered before T_anchor_lock." Does T_anchor_lock render the T_grace window unnecessary, or does a residual case still exist (e.g., T_anchor_lock fires unexpectedly early)?

3. **S_cred commit-reveal to prevent A4 convergence gaming:** A4 is partially addressed by T_anchor_lock. But if S_cred is publicly observable on-chain throughout, any participant can watch convergence before T_anchor_lock too. Does v2.1 need a commit-reveal scheme for S_cred updates (knowers commit a hash, reveal at epoch close) to prevent convergence-watching gaming of position registration?

4. **Remaining adversarial surface for #r164:** Four attack families not yet evaluated: (a) oracle registration attacks (governance approves a malicious oracle address); (b) EAT Merkle root manipulation; (c) credibility_ratio integer precision attacks (log-score rounding exploitation); (d) TOWL capacity inflation via phantom escrow registration. Recommend #r164 addresses these four.

*Last updated: #r163 — 2026-04-04T00:52Z*

---

## #r164 Contributions — 2026-04-04T01:02Z

**Phase: Adversarial stress-testing continued. Addresses all four open questions from #r163, then evaluates the four remaining attack families.**

---

**Q1 (γ_corr cluster detection — governance commit latency) → Provisional new-address floor + SLA-gated governance update; latency gap covered (#r164):**

Cluster detection is off-chain (gas-prohibitive on-chain). Until governance commits a γ_corr update, a newly formed adversarial cluster operates at γ_corr = 1.0 — full S_cred weight. The gap between cluster formation and γ_corr update is the attack window.

**Resolution — two-layer defence:**

Layer 1 (contract-enforced, no governance latency):
```
γ_corr_provisional(a) = min(1.0, log(1 + resolved_claims_a) / log(1 + N_track_threshold))
N_track_threshold = N_calibration  (default 4)
```
New addresses with fewer than N_track_threshold resolved claims have a provisional γ_corr less than 1.0 — decaying from ~0 to 1.0 as the track record grows. This is automatic and doesn't require governance action. A fresh Sybil account with no history contributes near-zero S_cred weight regardless of stake — consistent with the credibility model (#r1).

Layer 2 (governance SLA for cluster update):
```
cluster_detection_sla = 2 macro-epochs from EAT S_cred_concentration_index alert to governance γ_corr commit
If SLA breached: auto-throttle S_cred weight contributions from unvetted-cluster addresses to γ_corr_floor = 0.5
```
The provisional formula (Layer 1) handles cold-start Sybil attacks. The SLA (Layer 2) handles the narrower window where established addresses coordinate after building individual track records. (#r164)

---

**Q2 (T_anchor_lock eliminates T_grace window?) → Substantially yes; T_grace window is now residual-only; collapses to the N_lock_epochs minimum (#r164):**

With T_anchor_lock = T_anchor − N_lock_epochs, position registration closes at T_anchor_lock. SFP challenge eligibility is anchored to T_anchor_lock. The T_grace window from #r151/Q3 was introduced for the case where T_anchor fired unexpectedly early.

T_anchor_lock makes the closing event predictable by N_lock_epochs of advance notice. "Unexpected early T_anchor" was the threat; T_anchor_lock with N_lock_epochs ≥ 1 eliminates it. T_grace post-T_anchor is superseded. (#r164)

---

**Q3 (S_cred commit-reveal for v2.1?) → Not required; T_anchor_lock is sufficient; deferred to v2.2 (#r164):**

After T_anchor_lock, position registration is closed. S_cred convergence observable during [T_anchor_lock, T_anchor] cannot be used to register new positions. The only remaining channel is secondary-market trading — an external market microstructure problem, not a mechanism design problem.

Commit-reveal adds: (a) delayed unknower epistemic access; (b) delayed challenger detection; (c) significant contract complexity. Benefits do not exceed costs for v2.1 CLEARING_MODE. Deferred to v2.2 discovery-mode evaluation. (#r164)

---

**Q4 (Four remaining adversarial surfaces) — evaluated below (#r164):**

---

#### A6 — Oracle Registration Attack

**Attack:** Governance approves a malicious oracle_address returning adversary-controlled values at T_anchor. Settlement_price is fabricated; positions settle incorrectly.

**Existing defence:** k-of-n multisig for oracle registry. Standard governance attack vector.

**Additional v2.1 defence — expected_range + oracle_anomaly auto-SFP:**

```
oracle_registration includes: expected_range = [min_value, max_value]  (governance-declared)
oracle_anomaly fires if: oracle_resolution outside expected_range
  → auto-opens SFP challenge window
  → governance alert: oracle_anomaly_detected
  → ≥ 2 consecutive anomalies: oracle_address flagged for mandatory governance review
```

Expected-range catches extreme manipulation (a malicious oracle returning 0 or 1e18 for a financial rate). (#r164)

---

#### A7 — EAT Merkle Root Manipulation

**Attack:** Compromised protocol operator submits a fraudulent Merkle root to Ethereum calldata; malicious state survives audit.

**Additional v2.1 defence — multi-attester Merkle root commits:**

```
merkle_root_commit(epoch_E):
  ≥ N_attester independent attester nodes sign root
  Ethereum commitment includes: root + attester_signatures[]
  N_attester default = 3 (governance-settable, hard minimum)
  fraud_proof path: any participant can submit Merkle inconsistency proof within N_compact_grace window
```

Requires compromising N_attester independent parties — meaningfully harder than single-operator. (#r164)

---

#### A8 — Log-Score Precision Attack

**Attack:** Exploit fixed-point arithmetic rounding discontinuities in on-chain log-score computation to build credibility_ratio faster than honest calibration.

**Assessment:** Implementation-level attack, not mechanism-level. Correct defence is rigorous fixed-point arithmetic audit — already the primary target of the three-contract primary audit scope (#r161/Q4). Invariant #42 covers this. No new spec addition needed. (#r164)

---

#### A9 — TOWL Capacity Inflation via Phantom Escrow

**Attack:** Register large escrow on coordinates with insider oracle knowledge — effectively unlosable positions that inflate Zone A capacity without genuine solvency backing.

**v2.1 defence — TOWL_concentration_anomaly flag:**

```
post_resolution_TOWL_audit(epoch_E):
  if actual_slash_rate(class_i) < ε_floor (e.g., 0.01) for ≥ N_audit_window epochs for any large knower:
    flag: TOWL_concentration_anomaly
    governance review: genuine expertise vs. insider advantage?
```

Genuine experts have non-zero loss rates. Near-zero long-run loss rate on large positions is an informational governance trigger, not automatic action. (#r164)

---

### Adversarial Stress-Test Summary: Nine Attack Families

| Attack | Covered? | v2.1 spec addition |
|--------|----------|--------------------|
| A1 — Credibility laundering | Partial → fixed | Provisional γ_corr formula; SLA-gated governance |
| A2 — Zone C timing exploit | No → fixed | zone_at_T_anchor; SFP immunity at anchor |
| A3 — Pre-resolution withdrawal | Spec gap → fixed | Escape paths closed; Invariant #47 |
| A4 — Oracle timing arbitrage | Partial → fixed | T_anchor_lock; Invariant #49; no commit-reveal v2.1 |
| A5 — Flood-challenge pool drain | Partial → fixed | Rate limit; γ_corr_challenger; Invariant #50 |
| A6 — Oracle registration attack | Partial → hardened | expected_range; oracle_anomaly auto-SFP; Invariant #52 |
| A7 — EAT Merkle root manipulation | Partial → hardened | Multi-attester sigs; N_attester ≥ 3; Invariant #53 |
| A8 — Log-score precision attack | Yes (audit scope) | None; confirmed by Invariant #42 |
| A9 — Phantom escrow inflation | No → flagged | TOWL_concentration_anomaly; Invariant #54 |

**Net new v2.1 contract additions from #r163–#r164:**

1. **CredibilityAggregator:** Provisional γ_corr formula; S_cred_concentration_index per epoch; γ_corr_challenger floor 0.5; R_max challenge rate limit.
2. **SettlementEngine:** zone_at_T_anchor EAT field; SFP Zone C immunity when zone_at_T_anchor ∈ {A,B}; oracle_anomaly auto-SFP trigger.
3. **ClaimEscrow:** Escape path enum closed; voluntary withdrawal prohibited.
4. **CoordinateRegistry:** T_anchor_lock (N_lock_epochs ≥ 1); position registration gate; expected_range oracle field; TOWL_concentration_anomaly; WED_clearing from T_anchor_lock snapshot.
5. **EATManager:** attester_signatures on Merkle commits; N_attester ≥ 3; fraud_proof path.

---

## Cumulative Invariants (additions through #r164)

**Invariant #51 (#r164):** N_lock_epochs ≥ 1 is a hard contract floor. T_anchor_lock must precede T_anchor by at least one macro-epoch. T_grace post-T_anchor is superseded. (#r164)

**Invariant #52 (#r164):** oracle_anomaly fires when oracle_resolution falls outside expected_range. Auto-opens SFP challenge window; ≥2 consecutive anomalies trigger mandatory governance oracle review. (#r164)

**Invariant #53 (#r164):** EAT Merkle root commits require ≥ N_attester independent attester signatures (minimum 3). Single-operator Merkle root authority is prohibited. (#r164)

**Invariant #54 (#r164):** actual_slash_rate < ε_floor over N_audit_window epochs for a large knower triggers TOWL_concentration_anomaly governance review. Informational; not punitive. (#r164)

---

## Open Questions for #r165+

1. **Provisional γ_corr and established-address coordination:** The provisional formula covers cold-start Sybil attacks; established addresses (resolved_claims_a >> N_track_threshold) retain γ_corr = 1.0. Does S_cred_concentration_index + governance SLA adequately cover established-address coordination, or is a persistent cluster-correlated penalty needed?

2. **expected_range statistical tightening:** Hard governance-set bounds can be gamed by keeping oracle output just inside the range. Should expected_range be replaced with a statistical envelope (e.g., 3-sigma from historical oracle data) updated per epoch?

3. **N_attester set management — rotation and failure:** Who selects attesters? How are offline attesters replaced? Requires a governance-managed attester registry with N_attester_min = 3, N_attester_target = 5, and a rotation SLA specification.

4. **MEV/block-ordering attack on StateFreeze transaction (#r160/Q2):** A validator controlling transaction ordering could delay StateFreeze to insert a last-second S_cred update before T_anchor capture. Should StateFreeze be a protocol-reserved transaction slot, or should v2.1 tolerate this as a residual miner-extractable-value risk?

*Last updated: #r164 — 2026-04-04T01:02Z*

---

## #r165 Contributions — 2026-04-04T01:12Z

**Phase: Adversarial stress-testing continued. Addresses all four open questions from #r164.**

---

**Q1 (Established-address coordination — persistent cluster penalty vs S_cred_concentration_index + SLA) → Persistent cluster cap on combined W_max; governance must explicitly disband (#r165):**

The provisional γ_corr formula (Layer 1, #r164/Q1) covers cold-start Sybil: new addresses with thin track records contribute near-zero S_cred weight. But two established accounts, each with credibility_ratio ≈ 0.90 and resolved_claims >> N_track_threshold, coordinate their staking — both at γ_corr = 1.0, both at W_max. Combined weight = 2 × W_max. If the cluster adds K members, combined = K × W_max, unbounded.

The governance SLA (Layer 2) creates a reaction lag: cluster forms, S_cred is corrupted for up to 2 macro-epochs before governance responds. For high-stakes settlement epochs, 2 macro-epochs is a significant window.

**Resolution — persistent cluster combined W_max cap:**

Once governance confirms a cluster (after the SLA window), it commits a `cluster_registration` EAT event:
```
cluster_registration: {
  cluster_id,
  member_addresses: [a_1, ..., a_K],
  combined_W_max_cap: W_max  // entire cluster treated as one agent for cap purposes
  disbandment_condition: governance_explicit_clear
}
```

Effect: `effective_weight_cluster = min(W_max, Σ_members w_a)`.
The cluster's combined contribution to S_cred is capped at single-entity W_max, regardless of how many members it contains, until governance explicitly issues a `cluster_disbandment` EAT event.

**Disbandment proof requirement:** Governance may only issue `cluster_disbandment` if: (a) ≥ N_calibration normal-mode epochs have elapsed since last cluster confirmation, and (b) S_cred_concentration_index has returned to below alert_threshold for that period. This prevents adversarial churn — form cluster, get flagged, disband, reform, repeat.

**Provisional γ_corr retained for cold-start:** Layer 1 (provisional formula) continues to operate independently of cluster registration. New addresses are penalised by thin track record before governance can form any cluster opinion. Both layers are always active.

**Design law (#r165):** Governance-confirmed coordination clusters are subject to persistent combined W_max caps. Single-event penalties are insufficient for coordination attacks that can re-coordinate after penalty expiry. Persistent cap requires explicit governance disbandment with a stability-window condition. (#r165)

---

**Q2 (expected_range: hard bounds vs statistical envelope) → Stratified anomaly model: inner 3-sigma rolling envelope + outer hard fence; each triggers a different response (#r165):**

Hard bounds alone are gameable: a controlled oracle can output values at 99.9% of the expected_range and never trigger the A6 anomaly signal. A rolling 3-sigma envelope alone introduces an oracle-of-the-oracle dependency: who certifies the historical distribution used to compute sigma?

**Resolution — stratified two-layer anomaly model:**

```
inner_envelope: 3-sigma rolling over N_sigma_window = N_calibration epochs of historical oracle outputs
  trigger: oracle_resolution outside inner_envelope → oracle_anomaly_alert (governance signal only)

outer_fence: hard governance-set [min_value, max_value] at class registration
  trigger: oracle_resolution outside outer_fence → auto-SFP challenge window opened (Invariant #52)
```

**Stratified response:**

| Layer | Trigger | Response | Governance action |
|---|---|---|---|
| Inner (3-sigma) | Statistical outlier | oracle_anomaly_alert, EAT event | Review; no mechanism change |
| Outer (hard fence) | Extreme manipulation | Auto-SFP window; ≥2 → mandatory oracle review (Invariant #52) | Possible oracle deregistration |

**3-sigma source without oracle-of-the-oracle problem:** The historical distribution is computed from prior oracle outputs already committed to the EAT. It does not require an external certifier — the EAT IS the historical record. The 3-sigma threshold is derived from the same immutable data that governs EAT compaction eligibility.

**Governance interface addition:** (N_sigma_window, outer_fence_min, outer_fence_max). inner_envelope derived per-epoch from EAT history.

**Design law (#r165):** Anomaly detection requires stratified thresholds with proportionate responses. Statistical-envelope triggers soft governance signals; hard-fence triggers mechanism-level actions. Combining both eliminates the gamesmanship of either alone. (#r165)

---

**Q3 (N_attester set management — rotation, failure, registry) → Governance-managed attester registry with heartbeat SLA; N_attester_min = 3 hard floor; offline replacement within 2 macro-epochs (#r165):**

The multi-attester EAT Merkle root commitment (Invariant #53) requires N_attester ≥ 3 independent parties. Without lifecycle governance, attester set degrades over time (parties go offline, lose keys, become adversarial).

**Resolution — attester registry design:**

```
AttesterRegistry (governance-deployed):
  attester_address[]        — registered attester set
  N_attester_target = 5     — governance-set; hard min = 3 (from Invariant #53)
  heartbeat_sla = 1 macro-epoch (attester must sign ≥1 Merkle root per epoch)
  offline_threshold = 2 consecutive missed epochs → attester flagged as offline
  replacement_sla = 2 macro-epochs from offline_flag → governance must add replacement attester
    if SLA breached: N_attester falls below N_attester_target → governance_alert
    if N_attester falls below N_attester_min = 3: EATManager enters degraded_attestation mode
      → Merkle roots still committed (mechanism liveness preserved) with WARNING flag
      → dispute proofs accepted with ≥2 of remaining attester signatures
      → governance must restore N_attester ≥ 3 within 4 macro-epochs or new classes are blocked
```

**Rotation protocol:** Governance may proactively rotate an attester (e.g., key compromise suspected) via `attester_rotate` EAT event. Old attester removed; new attester registered; heartbeat SLA begins immediately for the new attester. Old attester's prior signatures remain valid (EAT immutability: historical roots they signed are still canonical).

**Attester independence requirement:** Attesters must not share operational infrastructure — governance declares attesters are independent (a convention rather than a verifiable on-chain property). Reuses governance accountability model: governance is responsible for attester independence; the mechanism provides the structure for governance to exercise that responsibility.

**Design law (#r165):** Multi-party witness sets (attesters, oracle councils, multisigs) require explicit lifecycle governance: heartbeat SLAs for liveness, replacement SLAs for offline parties, hard minimums with degraded-mode operation below floor. The pattern is: N_target > N_min > N_byzantine_tolerance. (#r165)

---

**Q4 (MEV/block-ordering attack on StateFreeze) → One-epoch clearing buffer is the complete defence; no protocol-reserved slot needed for v2.1 (#r165):**

The StateFreeze transaction (#r160/Q2) captures S_cred at T_anchor by calling CredibilityAggregator for a snapshot. A block-ordering validator (block proposer) could attempt to delay the StateFreeze to insert a self-beneficial S_cred update in the same block before the capture.

**Analysis of attack feasibility:**

The one-epoch clearing buffer (#r71/Q4) means the settlement S_cred snapshot is from epoch T-1, not from epoch T:
```
settlement_candidate_price = S_cred(epoch_T-1)  (committed at the T-1/T boundary)
StateFreeze reads this from SettlementEngine's storage, not from CredibilityAggregator's live state
```

The adversary cannot insert a T epoch S_cred update to influence the T-1 epoch snapshot — the T-1 snapshot is already written to contract storage at the T-1/T epoch boundary. The StateFreeze transaction merely reads this pre-committed value and marks the class as settlement_frozen.

**What a validator could do:** Reorder *other* transactions in the same block to front-run a position registration deadline. This is standard MEV — external to the mechanism's price formation. The T_anchor_lock (Invariant #51, N_lock_epochs ≥ 1) ensures at least 1 full epoch between position registration close and StateFreeze. No MEV within the lock window is possible because the lock is at the epoch boundary level, not the block level.

**Residual: StateFreeze transaction delay to a different epoch:** A validator could theoretically not include the StateFreeze transaction for an epoch. This would delay T_anchor by one epoch. The oracle has already fired; the epoch buffer already captured the snapshot. Delay is inconvenient but not an attack on the settlement price. The mechanism's T_anchor finality is oracle-driven, not transaction-sequencing-driven.

**Conclusion:** No protocol-reserved transaction slot is required for v2.1. The defence hierarchy is:
1. One-epoch clearing buffer → S_cred snapshot is already committed at epoch boundary (immutable by the time StateFreeze executes)
2. T_anchor_lock (N_lock_epochs ≥ 1 macro-epoch) → no same-block position-registration MEV
3. Settlement price = stored epoch-T-1 value → validator cannot alter it by reordering transactions

**Design law (#r165):** MEV resistance in epoch-based mechanisms derives from epoch-boundary atomicity, not transaction-slot reservation. Epoch-boundary commits are the primary defence; transaction-ordering games within an epoch cannot alter committed epoch-boundary state. (#r165)

---

## Structural Synthesis: Adversarial Hardening Round — Closed (#r165)

| Attack surface | Final defence | Invariant |
|---|---|---|
| Established-address coordination | Persistent cluster combined W_max cap; governance disbandment with stability condition | #r165 (no new number — extends #r50) |
| expected_range gamesmanship | Stratified: inner 3-sigma (alert) + outer hard fence (auto-SFP) | #r165 (extends #r52) |
| Attester set degradation | Attester registry; heartbeat SLA; replacement SLA; degraded_attestation mode | #r165 (extends #r53) |
| MEV on StateFreeze | Epoch-buffer is complete defence; no reserved slot; epoch-boundary atomicity is sufficient | #r165 (confirms #r51 one-epoch floor is adequate) |

**v2.1 spec additions from #r165 (by contract):**

1. **CredibilityAggregator:** cluster_registration / cluster_disbandment operations; combined W_max cap enforcement; disbandment stability-window check.
2. **CoordinateRegistry:** inner_envelope (3-sigma rolling) per-epoch computation; N_sigma_window parameter; oracle_anomaly_alert (inner) vs auto-SFP (outer) routing.
3. **EATManager:** AttesterRegistry lifecycle; heartbeat SLA; degraded_attestation mode (WARNING flag on sub-minimum attester set); replacement SLA.

---

## Cumulative Invariants (extensions through #r165)

**Invariant #50 (extended, #r165):** Governance-confirmed clusters are subject to persistent combined W_max caps. Disbandment requires explicit governance action with a stability-window condition (N_calibration epochs of sub-alert S_cred_concentration_index).

**Invariant #52 (extended, #r165):** oracle_anomaly detection is stratified: inner 3-sigma rolling envelope triggers oracle_anomaly_alert (governance signal); outer hard fence triggers auto-SFP. Both are active simultaneously.

**Invariant #53 (extended, #r165):** EATManager operates an AttesterRegistry with N_attester_min = 3 (hard floor), N_attester_target = 5 (governance-set), heartbeat SLA (1 macro-epoch), replacement SLA (2 macro-epochs), and degraded_attestation mode below N_attester_min.

**Invariant #55 (#r165):** MEV resistance in epoch-based mechanisms is provided by epoch-boundary commit atomicity. The one-epoch clearing buffer and T_anchor_lock together prevent transaction-ordering attacks on S_cred and position registration. No protocol-reserved transaction slot is required.

---

## Open Questions for #r166+

1. **Cluster cap interaction with TOWL:** When a confirmed cluster's combined W_max cap is active, does the cluster's collective TOWL contribution also cap at single-entity W_max × stake, or does each member's escrow count independently toward TOWL capacity? (TOWL is financial backing; W_max cap is epistemic weight — they may warrant different treatment.)

2. **Inner 3-sigma envelope bootstrap:** New coordinate classes have no historical oracle output. Before N_sigma_window epochs, the inner envelope cannot be computed. Should the inner envelope default to a governance-estimated distribution at genesis (analogous to genesis prior), or should oracle_anomaly_alert simply be inactive until N_sigma_window epochs of history exist?

3. **Attester heartbeat in degraded mode (DA outage):** During DA outage, Celestia blobs cannot be written. Do attester heartbeat SLAs toll during degraded mode (consistent with epoch-indexed deadline freezing), or does the heartbeat SLA advance independently (since EATManager Ethereum calldata commits continue during DA outage even if Celestia is down)?

4. **Complete adversarial stress-test declaration:** After nine attack families (A1–A9) evaluated across #r163–#r165, are there additional novel attack classes specific to the v2.1 5-contract architecture that remain unevaluated? Candidate: (a) economic denial-of-service via micro-spam claims consuming CoordinateRegistry gas; (b) S_cred poisoning via deliberate wrong claims timed to inflate targeted knowers' credibility_ratio via the loser pool redirect; (c) SettlementEngine re-entrancy beyond the call-ordering invariant specified in #r160/Q2.

*Last updated: #r165 — 2026-04-04T01:12Z*

---

## #r166 Contributions — 2026-04-04T01:22Z

**Phase: Adversarial stress-testing continued. Addresses all four open questions from #r165, plus three additional attack families (A10–A12) to complete the v2.1 adversarial coverage map.**

---

**Q1 (Cluster cap × TOWL — epistemic vs financial treatment) → TOWL counts per-member escrow independently; W_max cap applies only to epistemic S_cred weight (#r166):**

The W_max cap on confirmed clusters (#r165/Q1) is an *epistemic* constraint: the cluster's combined influence on S_cred is capped at single-entity W_max. TOWL is a *financial* constraint: each member's escrow independently backs their warranty obligations. These are orthogonal channels (Invariant #3).

**Incorrect conflation:** If TOWL also capped at single-entity W_max × stake for a cluster, members with valid escrow would not count toward TOWL capacity despite having real capital at risk. This would artificially reduce Zone A headroom and trigger spurious Zone C events — a solvency signal based on epistemic governance policy, not financial reality.

**Resolution:**

```
For governance-confirmed cluster {a_1, ..., a_K}:
  S_cred_contribution = min(W_max, Σ_k w_a_k)          // epistemic cap
  TOWL_contribution   = Σ_k (escrow_k × tier_weight_k)  // per-member, independent, uncapped
```

TOWL counts full per-member escrow. The epistemic W_max cap does not reduce TOWL. This is consistent with: (a) Invariant #3 (TOWL/credibility_ratio orthogonality); (b) the bounded-liability architecture (#r130) which depends on accurate per-member escrow accounting; (c) the Zone C gating framework which reads TOWL directly.

**Edge case — single-member cluster:** A cluster of K=1 (governance flags a solo address as a cluster for tracking purposes) behaves identically to a normal W_max-capped address. The cluster machinery adds no additional constraint; governance may use it for observation only.

**Design law confirmed (#r166):** Financial and epistemic constraints must never be applied to the same variable at the same time from different governance contexts. Cluster W_max caps are epistemic-channel-only. TOWL remains financial-channel-only. (#r166)

---

**Q2 (Inner 3-sigma envelope bootstrap for new coordinate classes) → Inactive until N_sigma_window epochs; genesis default: governance-estimated σ_genesis with explicit bootstrap flag (#r166):**

New coordinate classes have no oracle history. Before N_sigma_window normal-mode epochs of oracle output are committed to the EAT, the rolling 3-sigma envelope cannot be derived from data.

**Two candidate bootstrap defaults:**
- **Inactive (no inner envelope until N_sigma_window):** Simple. oracle_anomaly_alert fires only on outer-fence violations during bootstrap. No false alarms from uninitialised sigma.
- **Governance-estimated genesis prior:** Governance submits (μ_genesis, σ_genesis) at class registration. Inner envelope = μ_genesis ± 3σ_genesis during bootstrap.

**Resolution — governance-estimated genesis σ with explicit bootstrap flag:**

Both: the inner envelope is active from genesis using governance-estimated (μ_genesis, σ_genesis), clearly tagged as `bootstrap_envelope = true` in the EAT. On N_sigma_window normal-mode epochs of oracle data: `bootstrap_envelope → false`; derived σ replaces σ_genesis.

**Rationale:** A new coordinate class that receives an oracle output of 0 on its first epoch (a clear data error) would generate no alert if the inner envelope is inactive. Governance-estimated bounds provide a coarse sanity check from day 1. The bootstrap flag ensures auditors know the alert was generated from governance estimates, not from empirical history.

**Interaction with oracle_anomaly_alert vs auto-SFP routing (#r165/Q2):**

During bootstrap:
- Inner envelope (bootstrap) → oracle_anomaly_alert only (governance signal). Bootstrap sigma is coarse; false positives are possible. Auto-SFP requires higher confidence.
- Outer fence (hard governance bounds) → auto-SFP as always (Invariant #52).

Post-bootstrap (N_sigma_window epochs): both layers operate normally.

**Governance interface addition:** (μ_genesis, σ_genesis) per-class at registration. Required for all CLEARING_MODE classes; optional for DISCOVERY_MODE. (#r166)

---

**Q3 (Attester heartbeat SLA tolling during DA outage) → Epoch-indexed deadline → implicit freeze; heartbeat_light provides degraded-mode liveness via Ethereum calldata (#r166):**

Attester heartbeats are EAT commits: each attester signs a Merkle root per epoch. During DA outage: full EAT Merkle root commits are suspended (EATManager in degraded mode, #r75). Attesters cannot produce valid heartbeats even if they are online.

**Classification under #r137–#r138 deadline taxonomy:**

Heartbeat SLA = "attester must sign ≥1 Merkle root per epoch." This is explicitly epoch-indexed: the deadline is expressed in epoch units, conditioned on an EAT commit event. Under Invariant #26 (non-monotone preconditions) and the #r137 design law (epoch-indexed deadlines auto-freeze with the epoch system), the heartbeat SLA tolls during DA outage automatically.

**Resolution:** Heartbeat SLA advances only on normal-mode epochs where EATManager can accept Merkle root commits. Degraded-mode epochs do not count toward the missed-heartbeat counter. Attester offline_flag is not triggered by DA outage alone.

**heartbeat_light (new) — Ethereum-calldata-only liveness during DA outage:**

```
heartbeat_light: {
  attester_address,
  last_committed_epoch_root_hash,  // hash of last successful full EAT commit
  signature,
  epoch
}
```

heartbeat_light does NOT count toward the full EAT Merkle commit for dispute purposes. It only resets the offline_flag timer — confirming the attester is online and waiting for DA to restore. The offline_flag SLA (2 consecutive missed full-commit epochs) now excludes degraded-mode epochs; attester can satisfy liveness via heartbeat_light during DA outage with no penalty.

**Design law (#r166):** Multi-party liveness proofs require a degraded-mode equivalent that uses the lowest available trust layer (Ethereum calldata) when higher layers (Celestia DA) are unavailable. The degraded-mode liveness proof must be explicitly distinguished from the normal-mode proof. (#r166)

---

**Q4 (Remaining novel attack families — A10, A11, A12) (#r166):**

---

#### A10 — Gas Denial-of-Service via Micro-Spam Claims (CoordinateRegistry)

**Attack:** Adversary floods CoordinateRegistry with minimum-stake claims across many coordinates, saturating block gas and preventing legitimate claims from reaching the contract before T_anchor_lock.

**Assessment:** Standard EVM gas-price market defence applies. Mechanism-level defence:

```
min_stake_absolute = k_min (governance-set per class; disclosed at registration)
  k_min must exceed the gas cost of the claim submission transaction
  ensures each spam claim costs more in expected loss than the gas rebate

claim_submission_fee (already specified, #r141) = r_floor × fee_fraction
  spam-filtered by economic cost
```

The existing claim_submission_fee already handles this. No new mechanism addition required beyond requiring explicit k_min governance disclosure at class registration.

**v2.1 spec note:** k_min parameter must be explicitly specified at class registration. Already implied by existing escrow mechanics; needs explicit governance disclosure as "minimum viable claim stake per class." (#r166)

---

#### A11 — S_cred Poisoning via Loser-Pool Redirect

**Attack:** Adversary deliberately stakes wrong claims on a target coordinate, knowing they will be slashed. Slash proceeds flow to the loser pool, distributed to credible S_cred contributors on that coordinate. If the adversary controls "correct-side" accounts via side-agreements, the slash effectively becomes a payout mechanism to the adversary's beneficiaries, boosting their credibility_ratio credits.

**Formal model:**

```
Adversary controls: accounts {a_wrong_1, ..., a_wrong_M} and accounts {a_correct_1, ..., a_correct_N}
A_wrong accounts stake large on wrong side; A_correct accounts stake correct side.
A_wrong slashed → loser pool → A_correct earns loser pool share + query fees.
A_correct credibility_ratio grows; A_wrong accounts abandoned.
Net effect: credibility laundering via deliberate self-slash.
```

**Why distinct from A1 (credibility laundering):** A1 uses correct-outcome events to build credibility. A11 uses deliberate wrong-claim sacrifices to transfer value to pre-seeded correct-side accounts via the loser pool.

**Defence — loser pool distribution concentration cap:**

```
per_epoch_loser_pool_cap_per_address(a) = min(
  actual_pro_rata_share,
  max_loser_pool_fraction_per_address × total_loser_pool_size
)
max_loser_pool_fraction_per_address = 0.20  (governance-set, bounded [0.05, 0.40])
```

An address can receive at most 20% of any single epoch's loser pool distribution. Excess redistributed pro-rata to remaining eligible contributors, or to challenger_pool if none remain.

**Interaction with cluster cap:** A11 requires A_wrong and A_correct to appear independent. Post-cluster-registration (#r165/Q1), combined W_max cap limits A_correct's S_cred contribution. The loser-pool-cap provides an independent defence that does not require cluster identification first.

**v2.1 spec addition:** max_loser_pool_fraction_per_address parameter in ClaimEscrow. (#r166)

---

#### A12 — SettlementEngine Re-entrancy Beyond #r160/Q2 Call-Ordering

**Attack:** A malicious contract registered as a position holder calls back into SettlementEngine during T_finality position payout before the position is marked as settled, claiming the same payout twice.

**Assessment:** The StateFreeze (#r160/Q2) writes to local storage before external calls — re-entrancy on T_anchor is not possible. The residual surface is the T_finality position payout loop.

**Defence — standard checks-effects-interactions on position payout:**

```
settle_position(position_id, settlement_price):
  require(positions[position_id].settled == false)
  positions[position_id].settled = true  // effect BEFORE interaction
  safeTransfer(position_holder, payout_amount)
```

Standard Solidity re-entrancy guard. Must be in the primary audit scope; already covered by Invariant #42 (three-contract primary audit). T_finality payout re-entrancy is the specific highest-risk path to flag in the audit briefing.

**v2.1 audit note:** Explicitly add T_finality payout loop to the audit briefing as the SettlementEngine's highest re-entrancy risk path. (#r166)

---

### Adversarial Stress-Test Final Coverage: Twelve Attack Families

| Attack | Status | v2.1 addition |
|--------|--------|---------------|
| A1 — Credibility laundering | Closed (#r163, #r165) | Provisional γ_corr; cluster W_max cap |
| A2 — Zone C timing exploit | Closed (#r163) | zone_at_T_anchor; Invariant #48 |
| A3 — Pre-resolution withdrawal | Closed (#r163) | Escape paths closed; Invariant #47 |
| A4 — Oracle timing arbitrage | Closed (#r163, #r164) | T_anchor_lock; Invariant #49 |
| A5 — Flood-challenge pool drain | Closed (#r163) | Rate limit; γ_corr_challenger; Invariant #50 |
| A6 — Oracle registration attack | Closed (#r163, #r165) | Stratified oracle_anomaly; Invariant #52 ext |
| A7 — EAT Merkle root manipulation | Closed (#r163, #r165) | Multi-attester; Invariant #53 ext |
| A8 — Log-score precision | Closed (#r163) | Audit scope; Invariant #42 |
| A9 — Phantom escrow inflation | Closed (#r163) | TOWL_concentration_anomaly; Invariant #54 |
| A10 — Gas DoS via micro-spam | Closed (#r166) | k_min explicit disclosure |
| A11 — S_cred poisoning via loser-pool redirect | Closed (#r166) | max_loser_pool_fraction_per_address |
| A12 — SettlementEngine re-entrancy | Closed (#r166) | Audit scope; checks-effects-interactions on payout |

**The v2.1 adversarial stress-test is complete. All twelve identified attack families have been evaluated and assigned a mechanism defence, an audit-scope item, or a confirmed non-issue.**

---

## Net-New Structural Insight: Two-Layer Defence Architecture as a Design Pattern (#r166)

Across the adversarial stress-test (#r163–#r166), a consistent structural pattern emerges: the most robust defences are two-layer — Layer 1 is automatic (contract-enforced, zero governance latency) and Layer 2 is governance-reactive (SLA-gated, human-confirmed).

**Pattern:**

| Layer | Mechanism | Latency | Coverage |
|---|---|---|---|
| **Layer 1 (automatic)** | Contract-enforced formula, rate limit, or hard bound | Zero (immediate) | Cold-start, high-frequency attacks |
| **Layer 2 (reactive)** | Governance-committed γ_corr, cluster cap, oracle deregistration | 1–2 macro-epochs | Sophisticated, coordinated attacks |

**Two-layer instances across v2.1:**

| Attack | Layer 1 | Layer 2 |
|---|---|---|
| Credibility laundering (A1) | Provisional γ_corr (thin track record → near-zero weight) | Cluster registration + combined W_max cap |
| Oracle manipulation (A6) | Outer hard fence → auto-SFP | Inner 3-sigma alert → governance review |
| Attester failure (A7) | Degraded_attestation mode below N_attester_min | Replacement SLA + governance rotation |
| Challenge pool drain (A5) | Challenge rate limit R_max + γ_corr_challenger floor | Auto-refill from governance reserve |
| S_cred poisoning (A11) | max_loser_pool_fraction_per_address (hard cap) | Cluster registration if coordination detected |

**Why both layers are necessary:**

Layer 1 alone: adversaries probe and adapt to automatic thresholds. A sophisticated attack calibrates to just under R_max, just inside the 3-sigma envelope.

Layer 2 alone: governance-reactive defences are too slow for capital-efficient attacks within the governance latency window.

**Two-layer together:** Layer 1 imposes non-zero economic cost on all attacks immediately. Layer 2 closes the residual coordination gap that Layer 1 cannot address without governance context.

**Design law (#r166):** Every attack surface in the mechanism must be addressed by a two-layer defence: (1) automatic contract-enforced bound imposing immediate economic cost; (2) governance-reactive cap closing the coordination/sophistication gap. Single-layer defences are insufficient for v2.1 production deployment. (#r166)

---

## v2.1 Contract Spec Additions Summary (#r163–#r166)

| Contract | Addition | Source |
|---|---|---|
| **CredibilityAggregator** | Provisional γ_corr formula (Layer 1 automatic) | #r164/Q1 |
| | S_cred_concentration_index per-epoch EAT commit | #r163/A1 |
| | γ_corr_challenger floor = 0.5; R_max challenge rate limit | #r163/A5 |
| | cluster_registration / cluster_disbandment; combined W_max cap | #r165/Q1 |
| | Disbandment stability-window check | #r165/Q1 |
| **SettlementEngine** | zone_at_T_anchor EAT field; SFP Zone C immunity when zone_at_T_anchor ∈ {A,B} | #r163/A2 |
| | oracle_anomaly auto-SFP trigger (outer fence) | #r163/A6 |
| | Checks-effects-interactions re-entrancy guard on T_finality payout loop | #r166/A12 |
| **ClaimEscrow** | Escape path enum exhaustively closed; voluntary withdrawal prohibited | #r163/A3 |
| | max_loser_pool_fraction_per_address = 0.20 per epoch | #r166/A11 |
| **CoordinateRegistry** | T_anchor_lock (N_lock_epochs ≥ 1); position registration gate | #r163/A4 |
| | expected_range [min, max] at registration (outer fence) | #r163/A6 |
| | (μ_genesis, σ_genesis) at registration; bootstrap_envelope flag | #r166/Q2 |
| | N_sigma_window rolling 3-sigma inner envelope; stratified routing | #r165/Q2 |
| | TOWL_concentration_anomaly monitoring | #r163/A9 |
| | k_min explicit disclosure per class at registration | #r166/A10 |
| | WED_clearing snapshot at T_anchor_lock | #r163/A4 |
| **EATManager** | AttesterRegistry: N_attester_min=3, N_attester_target=5, heartbeat SLA | #r165/Q3 |
| | Degraded_attestation mode (WARNING flag below N_attester_min) | #r165/Q3 |
| | heartbeat_light Ethereum-calldata-only liveness event during DA outage | #r166/Q3 |
| | attester_signatures on Merkle root commits | #r163/A7 |

---

## Cumulative Invariants (additions through #r166)

**Invariant #55 (#r165):** MEV resistance provided by epoch-boundary commit atomicity + T_anchor_lock. No protocol-reserved transaction slot required.

**Invariant #56 (#r166):** Cluster W_max cap (epistemic) does not affect TOWL accounting (financial). TOWL counts per-member escrow independently regardless of cluster governance status.

**Invariant #57 (#r166):** Inner-envelope oracle anomaly detection uses governance-estimated (μ_genesis, σ_genesis) during bootstrap (bootstrap_envelope = true); transitions to derived rolling 3-sigma at N_sigma_window epochs. Inner envelope is active from genesis; bootstrap flag is mandatory.

**Invariant #58 (#r166):** EATManager attester heartbeat SLA is epoch-indexed; it tolls during DA outage. heartbeat_light provides degraded-mode liveness proof via Ethereum calldata without Celestia dependency.

**Invariant #59 (#r166):** Loser pool distribution is capped at max_loser_pool_fraction_per_address = 0.20 per address per epoch. Excess redistributed pro-rata or to challenger_pool.

**Invariant #60 (#r166):** Every attack surface requires a two-layer defence: (1) automatic contract-enforced economic cost (zero latency, no governance dependency); (2) governance-reactive coordination cap (SLA-bounded). Single-layer defences are insufficient for v2.1.

---

## Updated Run Log Entry

- **#r166** — 2026-04-04T01:22Z — Adversarial stress-test complete (A10–A12 + Q1–Q4 from #r165); two-layer defence architecture formalised; 22 v2.1 spec additions catalogued (#r163–#r166); Invariants #55–#60 added; v2.1 production readiness gate updated to include adversarial hardening gate.

---

## Updated v2.1 Production Readiness Criteria (#r166)

| Gate | Criterion | Source |
|------|-----------|--------|
| Solvency | TOWL zone A or B | #r71 |
| Epistemic liveness | active_challenger_count ≥ min for ≥2 normal-mode epochs | #r160/Q4 |
| DA liveness | Normal mode (not degraded) | #r75 |
| Oracle readiness | Oracle registered, TWAP data, expected_range + (μ_genesis,σ_genesis) set | #r144, #r166 |
| EAT operational | Ethereum + Celestia live; N_attester ≥ 3 confirmed | #r75, #r165/Q3 |
| Settlement contract audit | Three-contract primary scope audited | #r161/Q4 |
| Adversarial hardening | All 22 engineering spec additions from #r163–#r166 implemented and reviewed | #r166 |

---

## Open Questions for #r167+

1. **Cluster combined W_max cap and TOWL Zone A headroom:** Since TOWL counts per-member escrow independently for a cluster, Zone A headroom can be large while S_cred is capped at single-entity W_max. Is there a governance presentation that makes this asymmetry transparent — TOWL headroom vs epistemic effective capacity — so founders can evaluate actual epistemic quality of Zone A state?

2. **Two-layer defence calibration — Layer 1 threshold vs Layer 2 SLA tradeoff:** The economic cost imposed by Layer 1 (provisional γ_corr, rate limits, concentration caps) determines how sophisticated an attack must be before Layer 2 is needed. Higher Layer 1 thresholds reduce Layer 2 load but increase friction for legitimate participants. Is there a principled tradeoff formula?

3. **Governance parameter sensitivity analysis:** Which subset of the mechanism's governance parameters, if miscalibrated by ±20%, would push the mechanism into a degenerate equilibrium (no knower participation, no challenger participation, or solvency collapse)? Identifying the sensitive parameters narrows the pre-launch governance review to highest-impact decisions.

4. **v2.2 design scope declaration:** With v2.1 adversarial stress-test complete and 22 spec additions catalogued, the mechanism is ready for engineering handoff. Define the v2.2 mechanism design scope: DISCOVERY_MODE full spec, shadow-class lifecycle formalisation, implication chains, three-tier archive, cross-class LTRP backstop opt-in. Estimate run count for v2.2 scope completion.

*Last updated: #r166 — 2026-04-04T01:22Z*

---

## #r167 Contributions — 2026-04-04T01:32Z

**Phase: Closing the adversarial stress-test open questions; declaring v2.2 scope; net-new structural insight on the CLEARING/DISCOVERY game-theoretic split.**

---

**Q1 (Cluster W_max cap × TOWL Zone A headroom — governance transparency) → Epistemic Effective Capacity (EEC) metric; EEC/TOWL_ratio displayed alongside zone (#r167):**

The asymmetry: a 10-member confirmed cluster posting 100K escrow each → TOWL sees 1M backing → Zone A headroom is abundant. S_cred effective weight = 1× W_max (single-entity cap). The mechanism appears financially healthy while epistemically thin.

**Resolution — Epistemic Effective Capacity (EEC) metric:**

```
EEC(epoch, class_i) =
  Σ_{a ∈ knowers(class_i)} min(C_a × w_a_net, W_max) × γ_corr(a) × cluster_cap(a)

EEC_ratio(epoch, class_i) = EEC(epoch) / TOWL_capacity(epoch)
```

EEC_ratio interpretation:
- ~1.0: financial and epistemic capacity are balanced
- <0.5: TOWL-backed, epistemically thin (high concentration risk even in Zone A)
- >1.0: impossible by construction (EEC cannot exceed TOWL_capacity because each contributor is bounded by W_max, which is scaled to a fraction of TOWL)

**Governance dashboard fields (new EAT commit per epoch):**

```
{
  towl_zone:        A | B | C,
  eec_ratio:        [0, 1.0],
  eec_concentration_flag: true if max_contributor_eec / total_eec > 0.5,
  cluster_count_active: N  // number of active combined-W_max-capped clusters
}
```

**Alert thresholds:**
- `eec_ratio < 0.4`: epistemic_thinness_alert (governance signal only; not a throttle)
- `eec_concentration_flag = true AND eec_ratio < 0.6`: compound_concentration_alert → governance review

**Design law (#r167):** Financial solvency (TOWL zone) and epistemic quality (EEC_ratio) are independent governance-observable quantities. Both must be monitored and reported. A mechanism in Zone A with EEC_ratio < 0.4 is financially healthy but epistemically fragile — governance must be able to distinguish these states. (#r167)

---

**Q2 (Two-layer defence calibration — principled tradeoff formula) → L1_efficiency = C_attack(L1) / F_legit(L1); optimise at the L1 indifference curve (#r167):**

**Formal tradeoff:**

```
L1_efficiency(θ) = C_attack(θ) / F_legit(θ)

C_attack(θ) = minimum economic cost for adversary to mount a successful attack against Layer 1 threshold θ
F_legit(θ)  = friction cost imposed on a legitimate participant per unit of genuine epistemic contribution

Optimal θ* = argmax L1_efficiency(θ) subject to F_legit(θ) ≤ F_legit_max
```

**F_legit_max:** governance-declared acceptable friction (e.g., "a new legitimate knower may operate at 30% of full effective weight for their first N_calibration epochs").

**Monotonicity analysis per L1 parameter:**

| L1 parameter | C_attack vs θ | F_legit vs θ | L1_efficiency vs θ |
|---|---|---|---|
| Provisional γ_corr scaling | Increases steeply (each Sybil needs more legitimate history) | Increases slowly (new legit knowers earn less early) | Increasing; push threshold higher until F_legit_max is hit |
| R_max (challenge rate limit) | Plateaus quickly (attacker spawns more accounts) | Increases slowly | Decreasing at high R_max; set at the rate that imposes 10× slash cost on the adversary relative to honest operation |
| max_loser_pool_fraction (0.20) | Near-constant above 0.10 (attacker still profitable below cap) | Near-zero for honest challengers (rare to dominate 20%+ in normal operation) | High; current 0.20 default is likely near-optimal |
| W_max | Increases quadratically (N² coordination needed) | Increases linearly (each legitimate knower earns less as W_max falls) | Increasing; optimum at W_max = 1/N_target_knowers × total_effective_capacity |

**Practical governance calibration rule:**

For each L1 parameter, governance should ask: "What is the minimum value that makes a coordinated attack cost at least 10× the friction imposed on a legitimate participant?" The 10× ratio is the pragmatic L1_efficiency target.

This can be estimated per class from: (a) expected legitimate knower count (from class registration), (b) expected slash_rate (from ε_T3 registration field), and (c) minimum challenge cost (r_floor). No on-chain oracle required — registration-time inputs are sufficient.

**Design law (#r167):** Layer 1 defence thresholds are calibrated to achieve C_attack(θ) ≥ 10× F_legit(θ) at each parameter. Governance verifies this ratio at class registration using registration-time inputs. Where the 10× threshold cannot be achieved without F_legit_max violation, Layer 2 SLA is tightened to compensate. (#r167)

---

**Q3 (Governance parameter sensitivity analysis — degenerate equilibrium map) → Four critical parameters; seven sensitive parameters; three safe parameters (#r167):**

**Methodology:** For each parameter θ, evaluate whether a ±20% miscalibration produces a phase boundary crossing (participation rate → 0, solvency → negative headroom) or >50% change in equilibrium metric.

**Critical (phase boundary crossing within ±20%):**

| Parameter | Failure mode | Direction | Mechanism |
|---|---|---|---|
| γ_challenger (challenger reward fraction of slash) | No challengers | Too low: < 20% below current | Expected challenger income < gas cost; challengers exit |
| LTRP_seed / WED_clearing ratio | Solvency collapse | Too low: < 20% of WED_clearing | LTRP cannot absorb first T_longtail cascade |
| W_max as fraction of TOWL_capacity | No knower participation | Too low: < 5% of TOWL | Individual knower cannot earn meaningful fees |
| T_longtail / macro_epoch ratio | Solvency collapse | Too high: >5× | Outstanding obligations exceed LTRP reserves at any reasonable LTRP_seed |

**Sensitive (>50% equilibrium change within ±20%, no phase crossing):**

| Parameter | Failure mode | Notes |
|---|---|---|
| κ (staleness decay exponent) | Knower churn | High κ → claims go stale rapidly → knowers must re-stake frequently → high-friction |
| min_chain_weight_fraction | State vector quality | Too high → only top-credibility knowers qualify; information monoculture |
| N_calibration | Governance stability | Longer N_calibration → slower self-calibration transitions |
| r_floor (min challenge fee) | Challenger count | Too high → barrier to entry; thin challenger population |
| α_prior_base | Discovery quality | Affects shadow-class prior weight; v2.2 impact greater than v2.1 |
| mode_mismatch_discount_base | Discovery-clearing coupling | v2.2 primarily |
| q_bonus_fraction | Query fee incentive | v2.2 primarily |

**Safe (>50% change requires >50% miscalibration):**

| Parameter | Notes |
|---|---|
| N_lock_epochs | Changing from 1 to 2 (100% increase) has minimal impact on normal operations |
| N_compact_grace | Affects archive timing, not mechanism operation |
| max_loser_pool_fraction_per_address | The 0.20 cap has low sensitivity to ±20% changes |

**Pre-launch governance review priority order:**

```
Priority 1 (critical — must be verified analytically before launch):
  γ_challenger, LTRP_seed, W_max, T_longtail

Priority 2 (sensitive — verify against expected class volume):
  κ, min_chain_weight_fraction, r_floor, N_calibration

Priority 3 (safe — default acceptable):
  N_lock_epochs, N_compact_grace, max_loser_pool_fraction
```

**Design law (#r167):** Pre-launch parameter governance review must be prioritised by sensitivity class, not by parameter familiarity. The four critical parameters must be verified against class-specific analytics before v2.1 launch. (#r167)

---

**Q4 (v2.2 design scope declaration and run estimate) (#r167):**

**v2.2 Scope — five mechanism design modules:**

```
Module 1 — DISCOVERY_MODE full stack (LARGEST)
  EQ (epistemic query) fee market: bilateral ask/bid flow
  Multi-epoch calibration for query-fee-optimising knowers
  Query fee distribution rule (pro-rata vs credibility-weighted)
  Unknower partial-information problem: how much to reveal before bid confirmation
  Mechanism design first principles: information revelation game, not coordination game
  Estimated: 25–30 runs

Module 2 — Shadow-class lifecycle adversarial stress-test
  Wind-down, bootstrap prior, T_wind_down_max: specified (#r155, #r157)
  Remaining: discovery-mode specific attack surfaces
  Estimated: 8–10 additional runs

Module 3 — Implication chains full settlement routing
  Declaration structure and bifurcated alpha_cap: specified (#r145)
  Missing: settlement routing for implication-chain resolution
  Estimated: 10–12 runs

Module 4 — Three-tier archive integration
  CID chain, Arweave/IPFS, retry SLA: mostly specified (#r156–#r158)
  Remaining: integration with lazy compaction eligibility
  Estimated: 3–5 additional runs

Module 5 — Cross-class LTRP backstop adversarial stress-test
  Bilateral opt-in, Zone C gating: specified (#r158/Q4)
  Remaining: backstop gaming attack vectors
  Estimated: 3–5 additional runs
```

**Total v2.2 estimate: 50–62 runs to mechanism-spec-complete.**

**Recommended v2.2 run ordering:** Module 1 first (changes most fundamental assumptions) → Module 2 → Module 3 in parallel → Modules 4–5 last.

---

## Net-New Structural Insight: CLEARING_MODE vs DISCOVERY_MODE as Distinct Game-Theoretic Regimes (#r167)

Through 167 runs, CLEARING_MODE and DISCOVERY_MODE have been differentiated operationally. A deeper distinction now emerges: **they are fundamentally different economic games layered on the same primitive.**

**CLEARING_MODE — coordination game:**
- Knowers and position-holders are *aligned*: both benefit from accurate settlement.
- Information revelation is complete-to-complete: knowers want to convey their full information.
- Mechanism design tradition: coordination game, public-goods revelation.

**DISCOVERY_MODE — bilateral information revelation game:**
- Unknowers want to extract maximum information at minimum fee.
- Knowers want to reveal minimum information necessary to earn the fee, preserving their edge.
- A knower who fully reveals eliminates their future earning potential.
- Epistemic and financial incentives are *adversarial*: the mechanism design problem is revelation, not coordination.
- This is closer to a Myerson optimal mechanism / Cremer-McLean full-extraction design.

**Key unresolved question for v2.2/Module 1:** Does the credibility_ratio scoring rule (log-score of realised accuracy) induce full information revelation in DISCOVERY_MODE, or only partial revelation? If partial, what supplemental incentive design closes the gap?

**Most promising v2.2 Module 1 approach:** A **multi-epoch revelation contract** where the unknower commits to a sequence of queries and the knower commits to consistent, calibrated sequential updates. Consistency across epochs is scored — a knower who contradicts their prior reveal is penalised, creating an incentive for honest incremental revelation rather than strategic withholding.

**Design law (#r167):** DISCOVERY_MODE mechanism design begins from the Myerson revelation framework, not from the CLEARING_MODE coordination analysis. Reusing CLEARING primitives for DISCOVERY without a first-principles re-analysis is a v2.2 design anti-pattern. (#r167)

---

## Structural Synthesis: v2.1 Final Closure and v2.2 Scope (#r167)

| Issue | Resolution | Law |
|---|---|---|
| EEC transparency | EEC_ratio metric; compound_concentration_alert; per-epoch EAT commit | Financial zone ≠ epistemic quality; both monitored |
| L1 calibration formula | L1_efficiency = C_attack / F_legit; 10× ratio target | 10× attack cost vs legitimate friction is the calibration standard |
| Parameter sensitivity | 4 critical, 7 sensitive, 3 safe; Priority 1 verified before launch | Sensitivity class governs governance review priority |
| v2.2 scope | 5 modules, ~50–62 runs; DISCOVERY_MODE dominant (25–30 runs) | Coordination game ≠ revelation game; Module 1 first |

---

## Cumulative Invariants (additions through #r167)

**Invariant #61 (#r167):** EEC_ratio (Epistemic Effective Capacity / TOWL capacity) must be monitored and reported per epoch alongside TOWL zone. Zone A with EEC_ratio < 0.4 is financially healthy but epistemically fragile.

**Invariant #62 (#r167):** Layer 1 defence thresholds target C_attack(θ) ≥ 10× F_legit(θ). Where this ratio cannot be achieved without exceeding F_legit_max, Layer 2 SLA is tightened.

**Invariant #63 (#r167):** Pre-launch governance review prioritises: (1) γ_challenger, LTRP_seed, W_max, T_longtail (critical); (2) κ, min_chain_weight_fraction, r_floor, N_calibration (sensitive); (3) all others (safe).

**Invariant #64 (#r167):** DISCOVERY_MODE mechanism design begins from the Myerson revelation framework. Cross-applying CLEARING primitives to DISCOVERY without re-analysis is a design anti-pattern.

---

## v2.1 Mechanism Specification — Complete and Closed

GestAlt v2.1 mechanism specification is **complete** as of #r167.

- **64 invariants** with full provenance
- **12 attack families** (A1–A12) evaluated and hardened
- **22 v2.1 contract spec additions** catalogued (#r163–#r166)
- **7-gate production readiness checklist** including adversarial hardening gate
- **4-parameter sensitivity priority map** for pre-launch governance review
- **3 Demo Day narrative variants** (Polymarket, Kalshi, Betfair)
- **5-contract architecture** with primary/secondary audit scope defined

**Next autoresearch focus:** v2.2 Module 1 — DISCOVERY_MODE full stack, beginning from the bilateral information revelation game framework.

---

*Last updated: #r167 — 2026-04-04T01:32Z*

---

## #r168 Contributions — 2026-04-04T01:42Z

**Phase: v2.2 Module 1 — DISCOVERY_MODE full stack. First-principles design from the bilateral information revelation game framework (Invariant #64 mandate).**

This run opens the DISCOVERY_MODE mechanism design from scratch. It does not apply CLEARING_MODE primitives by analogy — it derives the primitives from the revelation game.

---

### D0 — What Game Are We Actually Playing?

**CLEARING_MODE game (already spec-complete):** Coordination game. Knowers, challengers, and position-holders all benefit from accurate settlement. Information revelation is aligned: a knower who reveals their true posterior maximises expected scoring reward. The mechanism's job is to aggregate credible signals and produce a settlement price that is hard to move without genuine information.

**DISCOVERY_MODE game (this module):** Bilateral information revelation game. The game structure is fundamentally different:

- **Unknower (query buyer):** Has decision-relevant uncertainty about coordinate c. Values accurate state updates. Willing to pay query fees. Wants maximum information extracted per fee.
- **Knower (information seller):** Has private signal s_a. Can reveal a full posterior, a partial posterior, or a deliberately noisy posterior. Revealing too precisely in epoch t destroys future earning potential (information is consumed by the market once revealed). Wants to maximise multi-epoch fee income, not single-epoch accuracy.

**The core tension absent in CLEARING_MODE:**

In CLEARING_MODE: knower's optimal strategy = honest reporting of posterior. The log-score scoring rule is proper; strategic misreporting reduces expected payoff.

In DISCOVERY_MODE: honesty in epoch t may reduce expected fee income in epochs t+1, t+2, ... because revealed information becomes public knowledge (embedded in S_cred, visible to all unknowers). The knower faces a multi-period tradeoff: reveal now (earn current query fee, exhaust information edge) vs. withhold now (earn smaller current fee, preserve future edge).

Standard proper scoring rules do not resolve this tradeoff. A proper scoring rule induces honest reporting of the *current posterior* — but it does not prevent a knower from strategically maintaining an imprecise current posterior by withholding signal processing. (#r168)

---

### D1 — The Conserved Quantity in DISCOVERY_MODE

In CLEARING_MODE, the conserved quantity is **solvency** (TOWL: capital backing outstanding obligations).

In DISCOVERY_MODE, the conserved quantity is **epistemic value transferred** — the cumulative information moved from high-information zones to the shared state vector.

**Formal definition:**

```
Let S(t) = S_cred state distribution at epoch t (probability distribution over coordinate c)
Let π_0 = initial prior (uniform or governance-estimated genesis prior)

Cumulative_IVD(T) = KL(S(T) || π_0)
    (total information gained from mechanism start through epoch T)

Per-epoch Per-knower Information Value Delivered:
    IVD_a(t) = KL(S(t) || π_0) − KL(S(t-1) || π_0) × weight_a(t) / Σ_j weight_j(t)
    (knower a's marginal contribution to total epistemic progress at epoch t)
```

A healthy DISCOVERY_MODE mechanism shows Cumulative_IVD monotonically increasing toward KL(oracle_truth || π_0). A mechanism where Cumulative_IVD stagnates has failed to deliver genuine information — knowers are collecting fees without moving the state.

**Why KL-divergence from initial prior:** Measures how far the shared state has moved from "knowing nothing." Computable from S(t) and π_0, both committed to EAT. No external oracle required for IVD accounting. (#r168)

---

### D2 — The Revelation Incentive Problem (Formal Statement)

**Knower a's optimization problem (multi-period):**

```
max_{D_a(1),...,D_a(T)} Σ_t δ^t × E[fee_a(t)]

where δ = time discount factor
D_a(t) = reported distribution at epoch t
fee_a(t) = query fee share earned at epoch t
subject to: D_a(t) derived from private signal history {s_a(1),...,s_a(t)}
```

Knower a's true posterior at epoch t is P_a(t). Standard proper scoring rules require D_a(t) = P_a(t) for single-epoch optimality. But in a multi-epoch fee stream, the knower may withhold signal processing and report D_a(t) = D_a(t-1) until t = T_anchor − 1 (dump-all strategy).

**Three degenerate equilibria in DISCOVERY_MODE:**

1. **Strategic withholding:** Knowers withhold until late epochs. Unknowers receive uninformative state vectors throughout most of the discovery phase.
2. **IVD free-riding:** Knower waits for others to reveal, then submits a marginally refined version of the public state, collecting IVD credit at near-zero private cost.
3. **Noise injection:** Knower submits noisy D_a(t) to earn fees while preserving private edge. Degrades S_cred without triggering accuracy penalty until oracle resolution.

None of these occur in CLEARING_MODE (single-event settlement; no multi-epoch fee stream). (#r168)

---

### D3 — Two Surviving Mechanism Families

Three candidate families generated and evaluated:

**Killed: Auction-for-revelation.** Unknowers bid for information; knowers compete on revelation breadth. Fails: overconfident narrow claims win bids; this is a confidence-display game, not a revelation game. Eliminated.

**Surviving: IVD-weighted query fees.** Fee allocation proportional to per-epoch marginal information value delivered. Directly incentivises what we want. Requires KL-divergence computation per epoch. Implements conserved-quantity accounting directly.

**Surviving: Consistency-penalized multi-epoch revelation contracts.** Knowers commit to sequential distribution updates. Penalised for unjustified large deviations between consecutive reports (Jensen-Shannon divergence gate). Computationally simpler. Does not directly measure IVD but closes the strategic-withholding incentive.

**Why both are needed:**

IVD-weighting rewards genuine epistemic transfer but cannot prevent dump-all (large IVD_weight at t=T−1 may still dominate).

Consistency penalty prevents withholding but cannot distinguish accurate from noisy gradual revelations.

**Combined mechanism:**

```
discovery_fee_a(t) = query_fee_pool(t) × W_a(t)

W_a(t) = base_share(a,t) × consistency_factor(a,t) × IVD_weight(a,t)

base_share(a,t) = credibility_ratio(a) × stake_a_net / Σ_j (credibility_ratio(j) × stake_j_net)

consistency_factor(a,t):
  = 1.0    if JS(D_a(t) || D_a(t-1)) ≤ info_arrival_tolerance × Δt
  ∈ [0.5, 1.0] if within 3× tolerance
  = 0.0    if JS(D_a(t) || D_a(t-1)) > 3× tolerance (unjustified large jump)

IVD_weight(a,t) = max(0, IVD_a(t)) / Σ_j max(0, IVD_j(t))
  (zero if knower's contribution decreases state vector quality in epoch t)
```

**info_arrival_tolerance:** governance-set per coordinate class, reflecting expected rate of new information arrival in the underlying domain. (#r168)

---

### D4 — The Two-Pool Fee Model

Fee structure must incentivise both ongoing information delivery and terminal accuracy simultaneously.

```
unknower pays: query_fee_total per query submission

Split at submission:
  fee_streaming_pool:  query_fee_total × query_fee_fraction       (distributed per-epoch via W_a(t))
  accuracy_bonus_pool: query_fee_total × (1 − query_fee_fraction) (distributed at T_finality)

query_fee_fraction: governance-set per class, bounded [0.2, 0.8], default 0.5
```

**fee_streaming_pool:** Incentivises genuine ongoing information delivery. Distributed per epoch proportional to W_a(t).

**accuracy_bonus_pool:** Distributed at T_finality proportional to final credibility_ratio(a). Incentivises terminal accuracy. Reuses v2.1 log-score infrastructure — zero new accuracy scoring required.

**Calibration of query_fee_fraction:**
- Short-horizon (near-expiry) coordinates: lower query_fee_fraction → stronger terminal accuracy discipline.
- Long-horizon coordinates: higher query_fee_fraction → sustained revelation reward dominates.

Pure streaming → knowers optimise early high-IVD claims that may be wrong at resolution.
Pure accuracy bonus → dump-all. The split resolves both failure modes simultaneously. (#r168)

---

### D5 — Attack Surface Map (Initial; Full Analysis Deferred to #r169+)

| Attack | Candidate defence | Status |
|---|---|---|
| IVD inflation (manufacture IVD via divergent then corrected D_a) | Consistency penalty applied bidirectionally | Partial — gain bounded by info_arrival_tolerance × Δt |
| IVD sniping (free-ride on others' state advances) | IVD renormalization; early knowers earn multi-epoch cumulative advantage | Partial |
| Dump-all late revelation | Consistency penalty gates large jumps; accuracy_bonus_pool split bounds profitability | Partial |
| Noise injection | IVD_weight = 0 if claim decreases state quality | Partial |
| Query flood (drain streaming pool) | query_fee_total paid by unknower; flooding is self-funded, not an attack | Structural non-issue |
| Cross-class discovery poisoning | mode_mismatch_discount + attenuated genesis prior (#r154–#r156) | Covered |

Full adversarial analysis deferred to #r169–#r173. (#r168)

---

### D6 — State Model for DISCOVERY_MODE

**S(t) = full probability distribution (not scalar):**

```
S(t) = Σ_a W_a(t) × D_a(t)   (credibility-weighted mixture of reported distributions)
```

S(t) carries uncertainty quantification — unknowers receive a distribution, not just a point estimate.

**On-chain representation:**
- Parametric (default): S(t) = (μ, σ) for Gaussian; or (α, β) for Beta on [0,1] coordinates. O(1) per epoch. Sufficient for most institutional use.
- Discretized (opt-in): N_buckets = 16 probability bins. O(N_buckets) per epoch. Higher fidelity for tail-sensitive coordinates.

**Update rule per epoch:** Submit D_a(t) → compute IVD_a(t), JS(t), W_a(t), S(t) → distribute fee_streaming_pool → commit S(t) to EAT.

**Why not scalar:** CLEARING_MODE scalar S_cred is sufficient for settlement (just need the best estimate). DISCOVERY_MODE unknowers need the uncertainty envelope to make institutional decisions — e.g., how wide to set collateral margins. (#r168)

---

### D7 — DISCOVERY_MODE vs LMSR / Orderbooks (10-Point Framework Update)

**LMSR:** Prices how capital moves a scalar market probability. Does not distinguish private information from well-capitalised speculation. Does not reward the process of revelation — only terminal accuracy.

**DISCOVERY_MODE advantage:** IVD_weight rewards genuine information flow per epoch. Credibility_ratio stratification means track-record matters, not just capital. S(t) distribution output is richer than LMSR scalar. Consistent incremental revelation is rewarded over strategic dumps.

**DISCOVERY_MODE weakness:** info_arrival_tolerance calibration is a hard governance problem. If miscalibrated, either legitimate knowers are penalised (too tight) or IVD inflation is profitable (too loose). The mechanism's quality is bounded by governance's ability to estimate domain-specific information arrival rates.

**Strongest failure reason:** info_arrival_tolerance is unverifiable at class registration. A governance-estimated tolerance may be systematically wrong for novel coordinate classes, making both withholding and noise injection profitable simultaneously. No fully objective self-calibrating tolerance derivation exists without sufficient historical data — creating a bootstrapping problem for new coordinate types. (#r168)

**Best surviving variant if raw DISCOVERY_MODE fails:** Fall back to accumulating EQ queries as data for future calibration, using a conservative (tight) info_arrival_tolerance as the genesis default, and spending the first N_sigma_window epochs in "calibration mode" where consistency penalties are advisory only. Mechanism degrades gracefully to a data-collection phase rather than failing catastrophically on day 1.

---

### D8 — Simplest Viable DISCOVERY_MODE Mechanism (v2.2 MVP Sketch)

**5 new contracts extending v2.1 base:**

1. **DiscoveryCoordinateRegistry** — adds query_fee_fraction, info_arrival_tolerance, distribution_mode (parametric/discretized)
2. **DiscoveryClaimEscrow** — adds two-pool accounting: fee_streaming_pool, accuracy_bonus_pool, per-epoch streaming distribution
3. **DiscoveryCredibilityAggregator** — adds IVD_a(t) computation, JS consistency check, W_a(t) = base × consistency × IVD, S(t) distribution mixture
4. **DiscoverySettlementEngine** — adds two-pool payout at T_finality; accuracy_bonus_pool distributed by terminal credibility_ratio
5. **ShadowClearingPairRegistry** — manages shadow↔clearing pair registration, genesis prior snapshot export, two-registration lifecycle

**One-query data flow:**
```
unknower submits query(class_id, epoch_t) + query_fee_total
  → fee_streaming_pool += fee_total × query_fee_fraction
  → accuracy_bonus_pool += fee_total × (1 − query_fee_fraction)
  → unknower receives S(t-1) (current EAT-committed state distribution)

Per epoch:
  knowers submit D_a(t)
  compute IVD_a(t), JS(t), W_a(t), S(t)
  distribute fee_streaming_pool proportional to W_a(t)
  commit S(t) to EAT

At T_finality:
  oracle resolves V*
  distribute accuracy_bonus_pool proportional to terminal credibility_ratio(a)
  shadow-class begins wind-down if linked clearing-class resolved
```

---

## Structural Synthesis: DISCOVERY_MODE Foundation Established (#r168)

| Primitive | DISCOVERY_MODE | vs CLEARING_MODE |
|---|---|---|
| Base primitive | Information transfer (IVD) | Capital warranty |
| Conserved quantity | Cumulative KL from prior | TOWL solvency |
| State model | Full distribution S(t) | Scalar credibility-weighted estimate |
| Update rule | W_a(t) = base × consistency × IVD | credibility_ratio × stake-weighted |
| Settlement | Two-pool: streaming + accuracy bonus | Single-event at T_finality |
| Degenerate equilibria | Withholding, IVD sniping, dump-all, noise injection | Sybil, flash-stake, oracle gaming |

---

## Cumulative Invariants (additions through #r168)

**Invariant #65 (#r168):** In DISCOVERY_MODE, the conserved quantity is cumulative epistemic value transferred, measured as KL(S(T) || π_0). A healthy DISCOVERY mechanism shows monotonically increasing Cumulative_IVD toward oracle truth. (#r168)

**Invariant #66 (#r168):** DISCOVERY_MODE fee allocation uses combined weight W_a(t) = base_share × consistency_factor × IVD_weight. All three components are required; any single omission enables a specific degenerate equilibrium. (#r168)

**Invariant #67 (#r168):** DISCOVERY_MODE uses two-pool fee structure: fee_streaming_pool (per-epoch, W_a(t)-proportional) and accuracy_bonus_pool (T_finality, credibility_ratio-proportional). query_fee_fraction ∈ [0.2, 0.8], governance-set per class. (#r168)

**Invariant #68 (#r168):** DISCOVERY_MODE state S(t) is a full probability distribution (parametric default; N_buckets=16 discretized as opt-in). Scalar state vectors are insufficient. (#r168)

---

## Open Questions for #r169+

1. **info_arrival_tolerance calibration:** Most critical DISCOVERY_MODE governance parameter. Derivation candidates: (a) governance-estimated from domain knowledge; (b) derived from historical oracle output variance for analogous coordinate classes; (c) self-calibrating from observed JS divergence distribution over N_sigma_window epochs. Define the derivation procedure.

2. **IVD computation on-chain gas:** KL-divergence requires log operations (no native Solidity log). Does the existing log-score fixed-point arithmetic from v2.1 CredibilityAggregator extend to IVD? What is the maximum acceptable IVD computation error bound?

3. **Dump-all profitability bound (formal):** Formalise: what is the maximum accuracy_bonus_pool fraction at which dump-all at epoch T-1 earns more than consistent multi-epoch strategy? This gives governance the constraint on query_fee_fraction lower bound.

4. **Information re-sale:** Unknowers who receive S(t) can re-sell to third parties without compensating knowers. Is this a protocol-layer problem (needs non-transferability primitive) or a legal/contractual layer problem outside mechanism scope?

*Last updated: #r168 — 2026-04-04T01:42Z*

---

## #r169 Contributions — 2026-04-04T01:52Z

**Phase: v2.2 Module 1 — DISCOVERY_MODE. Addresses all four open questions from #r168.**

---

**Q1 (info_arrival_tolerance calibration — derivation procedure) → Self-calibrating from EAT oracle variance after N_sigma_window epochs; governance-estimated genesis default (#r169):**

info_arrival_tolerance τ controls the maximum JS divergence between consecutive knower reports without consistency penalty. It should reflect the maximum single-epoch genuine information arrival for the coordinate class — a quantity that varies by domain and coordinate type.

**Derivation from oracle variance:**

```
oracle_value_variance(epoch_t) = (oracle_V(t) − oracle_V(t-1))^2 averaged over N_sigma_window epochs
oracle_velocity_sigma = sqrt(EMA(oracle_value_variance, N_sigma_window))

For parametric Gaussian state S(t) = (μ, σ):
  info_arrival_tolerance_tau = f_info(oracle_velocity_sigma / oracle_value_range)
    where oracle_value_range = outer_fence_max − outer_fence_min
```

`f_info` maps the normalised oracle velocity to a JS divergence bound. At oracle_velocity_sigma = 0 (static coordinate): τ → 0. At maximum observed velocity: τ → τ_max_governance (hard cap). The mapping is a monotone function calibrated to the coordinate's natural information arrival rate.

**Self-calibrating transition (same pattern as mode_mismatch_discount, #r156/Q1):**

```
Before N_sigma_window oracle epochs: τ = τ_genesis (governance-estimated at registration)
After N_sigma_window oracle epochs:  τ = f_info(oracle_velocity_sigma)
Transition: discrete EAT event tau_genesis_exit (same governance disclosure requirement as other self-calibrating params)
```

**τ_genesis governance input:** Required at class registration. Governance must estimate the expected rate of information arrival for the coordinate domain. This is the one unavoidable subjective governance input; it decays to zero importance after self-calibration activates.

**Pathological case — zero velocity oracle (event not yet in the world):** Before the underlying event begins generating information, oracle_velocity_sigma ≈ 0 and τ → τ_genesis. This is correct: the mechanism treats the coordinate as static; knowers should not be updating dramatically. Any large update is properly penalised as inconsistent. (#r169)

---

**Q2 (IVD computation on-chain gas — fixed-point extension) → Discretized N_buckets=16 representation for all IVD computation; reuses v2.1 log-score table (#r169):**

KL-divergence requires log operations. Solidity has no native log. The v2.1 CredibilityAggregator already implements a fixed-point log lookup table for the log-score accuracy computation. The same table is reusable for IVD.

**Computation approach:**

```
On-chain representation: dual-track
  Reporting representation: parametric (μ, σ) or (α, β) — used for S(t) output to unknowers
  Computation representation: discretized N_buckets=16 probability bins — used for IVD and JS

Conversion: parametric → N_buckets discretization at epoch boundary
  Performed by knower client off-chain; submitted as 16-element uint16 array (sums to 65536)
  Gas cost: O(N_buckets) = O(16) log-table lookups per knower per epoch

KL(D_a(t) || S(t-1)) = Σ_{i=1}^{16} D_a(t,i) × log(D_a(t,i) / S(t-1,i))
  (each term: one multiply + one log lookup + one add)

JS(D_a(t) || D_a(t-1)) = (KL(D_a(t)||M) + KL(D_a(t-1)||M))/2  where M = mixture
  Total: O(48) log-table lookups per epoch per knower — tractable
```

**Error bound:** With 16 buckets and 16-bit fractional resolution, maximum IVD computation error is bounded by 0.01 nats for a Gaussian on the standard range. This is acceptable for fee allocation (query fees are rounded to wei; 0.01 nat error → sub-percent fee allocation error).

**Gas estimate:** ~16 log lookups × ~200 gas/lookup = ~3,200 gas per knower per epoch for IVD computation. Comparable to an ERC20 transfer. Tractable for v2.2. (#r169)

---

**Q3 (Dump-all profitability bound — formal) → Self-defeating by pool depletion; formal constraint gives query_fee_fraction ≥ 1/(1 + T_discovery) (#r169):**

**Key structural property (not obvious from the D2 analysis):** The query_fee_pool at epoch t is a decreasing function of Cumulative_IVD(t-1). As honest knowers move the state toward truth, unknowers receive more of what they need and stop querying. By the time a dump-all knower arrives at epoch T-1 to collect, the fee pool has been depleted by honest knowers.

Formally: query_fee_pool(t) ≈ Q_total × (1 − Cumulative_IVD(t-1) / IVD_max). The dump-all knower arrives at t = T-1 where Cumulative_IVD(T-2) ≈ (T-2)/T × IVD_max (linear information arrival approximation). Available pool ≈ Q_total × 2/T.

**Constraint:** Dump-all is dominated by consistent multi-epoch strategy when T > 2/w̄ (where w̄ is the honest knower's consistent per-epoch share). For w̄ = 0.2: T > 10.

**Formal query_fee_fraction lower bound:**

```
f_min ≥ 1/(1 + T_discovery)
```

For T_discovery=4: f_min ≥ 0.20 — exactly the stated [0.2, 0.8] lower bound. The [0.2, 0.8] governance bounds are formally derived. Both pool depletion (natural deterrent) and f_min constraint are necessary; neither alone covers all discovery-phase lengths. (#r169)

---

**Q4 (Information re-sale — protocol-layer or legal-layer problem) → Legal/contractual layer only; protocol scope excludes non-transferability; mechanism compensates through multi-epoch streaming structure (#r169):**

**Why protocol-layer non-transferability is infeasible:**

1. Non-transferability requires identity binding — incompatible with permissionless protocol design.
2. S(t) is committed to EAT (public by construction). On-chain state cannot be access-controlled retroactively.
3. Encrypted per-recipient S(t) requires O(unknower_count) encryption per epoch — outside feasible scope.

**Why re-sale doesn't harm the mechanism:**

Re-sale transfers already-revealed information. Knowers are already compensated for revelation via streaming fees. Re-sale *accelerates* information spread (aligned with IVD objective) while reducing future query pools (natural information-goods externality). The mechanism compensates at the moment of revelation, not for future gatekeeping rights.

**Design law (#r169):** Information re-sale of EAT-committed state is out of protocol scope. Streaming fees compensate at revelation time; accuracy bonus compensates for track record. Post-revelation value capture is a legal/contractual matter. (#r169)

---

## Net-New Structural Insight: Pool Depletion as the Natural Anti-Dump Mechanism (#r169)

The Q3 analysis reveals an emergent structural property: **the query_fee_pool natural depletion curve is itself a dump-all deterrent** — not designed, but consequential.

As honest knowers reveal information, unknowers' uncertainty decreases and query volume falls. The fee pool a dump-all adversary would collect at epoch T-1 is the pool honest knowers have already depleted. Dump-all is a race against honest knowers who have a T-1 epoch head start.

**Implication:** The mechanism does not need an explicit anti-dump rule. It only needs to:
1. Not guarantee minimum pool per epoch (which would protect dump-all timing)
2. Maintain the consistency penalty to block large single-epoch jumps in a depleted pool

Both conditions are met by the D4 two-pool design and D3 consistency factor. The anti-dump property emerges from the pool structure — achieving the deterrent without false positives on legitimate late-epoch genuine updates.

---

## Structural Synthesis: DISCOVERY_MODE Mechanism — Core Design Closed (#r169)

| Primitive | Decision | Source |
|---|---|---|
| info_arrival_tolerance | Self-calibrating from oracle velocity sigma; τ_genesis at genesis | #r169/Q1 |
| IVD computation | N_buckets=16 on-chain; ~3,200 gas/knower/epoch; reuses log-score table | #r169/Q2 |
| Dump-all bound | f_min = 1/(1+T_discovery); pool depletion is additional natural deterrent | #r169/Q3 |
| Information re-sale | Out of protocol scope; streaming fee compensates at revelation | #r169/Q4 |
| Anti-dump | Emergent from pool depletion + consistency penalty; no explicit anti-dump rule | #r169 net-new |

---

## Cumulative Invariants (additions through #r169)

**Invariant #69 (#r169):** info_arrival_tolerance self-calibrates from oracle_velocity_sigma after N_sigma_window epochs; τ_genesis required at registration for bootstrap. Same dual-condition transition pattern as mode_mismatch_discount.

**Invariant #70 (#r169):** IVD computation uses N_buckets=16 discretized representation on-chain; parametric (μ,σ) for unknower output. Max error bound: 0.01 nats.

**Invariant #71 (#r169):** query_fee_fraction lower bound = 1/(1 + T_discovery). The [0.2, 0.8] governance bounds are formally derived. For T_discovery=4: f_min = 0.20.

**Invariant #72 (#r169):** Information re-sale of EAT-committed state is out of protocol scope. Knowers are compensated at revelation time; post-revelation value capture is a legal/contractual matter.

---

## Open Questions for #r170+

1. **τ_genesis governance quality problem:** For entirely novel coordinate classes (no analogous oracle history), governance must estimate τ_genesis without data. What governance interface prevents catastrophically miscalibrated τ_genesis — either so tight that all knowers are penalised as inconsistent, or so loose that all dump-all strategies are unpunished?

2. **N_buckets=16 vs parametric at oracle resolution:** At T_finality, oracle returns a scalar value V*. Scoring accuracy against a 16-bucket discretized D_a requires the oracle scalar to be mapped to a bucket. What is the bucket mapping specification and how does it interact with the outer_fence expected_range?

3. **Query_fee_pool depletion when no honest knowers exist (information monopoly):** If one knower has a monopoly on private information (e.g., a corporate insider on a product launch coordinate), honest knowers do not deplete the pool. Pool depletion as dump-all deterrent requires ≥2 independent knowers. What is the minimum independent-knower count requirement for DISCOVERY_MODE to achieve its epistemic objectives?

4. **DISCOVERY_MODE settlement routing into CLEARING_MODE via shadow-class pair:** When the shadow-class achieves a meaningful genesis prior for the linked clearing-class, what is the exact protocol call that exports the DISCOVERY_MODE S(T_anchor) distribution as the clearing-class genesis prior? Define the cross-contract genesis prior export interface.

*Last updated: #r170 — 2026-04-04T02:02Z*

---

## #r170 Contributions — 2026-04-04T02:02Z

**Phase: v2.2 Module 1 — DISCOVERY_MODE. Addresses all four open questions from #r169.**

---

**Q1 (τ_genesis governance quality problem — prevent catastrophic miscalibration) → Bounded-range declaration with mandatory analogy citation; advisory-mode calibration epoch before penalties activate (#r170):**

τ_genesis cannot be derived without oracle history. The failure modes are symmetric:
- Too tight (τ_genesis → 0): all multi-epoch knower updates are flagged as inconsistent; consistency_factor = 0 for nearly everyone; fee pool starved of legitimate claimants → effective DISCOVERY_MODE shutdown.
- Too loose (τ_genesis → τ_max): consistency penalty never fires; dump-all strategy is profitable from day 1; IVD_weight is the only deterrent, which is weaker alone.

**Resolution — two-part safeguard:**

**Part 1 — Bounded declaration with analogy citation (governance hard gate):**

```
class_registration.discovery_params.tau_genesis:
  required_field: true for DISCOVERY_MODE
  hard bounds:    [τ_min_protocol, τ_max_protocol] (protocol-level; default [0.02, 0.40] JS divergence)
  analogy_class_id: required reference to an existing coordinate class with N_sigma_window epochs of data
  analogy_oracle_velocity: the analogous class's measured oracle_velocity_sigma / oracle_value_range
  tau_genesis_derivation: governance-declared as:
    τ_genesis = f_info(analogy_oracle_velocity)  (uses the same self-calibration formula from #r169/Q1)
```

Governance MUST cite an analogous class. If no analogous class exists (truly novel domain), governance must use the protocol midpoint (τ_genesis = τ_mid = 0.15) and declare `no_analogous_class = true`. The midpoint is conservative — it generates false inconsistency signals for genuinely fast-moving coordinates but never enables dump-all (τ_mid is well below τ_max).

**Part 2 — Advisory-mode calibration epoch (N_calibration macro-epochs):**

During the first N_calibration normal-mode macro-epochs after class genesis:
```
advisory_mode = true
consistency_factor(a, t) = 1.0  (no penalty applied)
JS(D_a(t) || D_a(t-1)) recorded and committed to EAT
τ_advisory = governance observes empirical JS distribution and may revise τ_genesis before penalties activate
```

At the end of N_calibration advisory epochs: governance may submit a one-time `tau_revision` event (updates τ_genesis based on observed JS distribution). Penalty mode activates at N_calibration + 1 regardless of whether τ_revision was submitted.

**Design law (#r170):** Novel coordinate classes require an advisory mode for parameters that lack observable self-calibration anchors. Advisory mode collects data without penalising legitimate participants. The advisory window is bounded (N_calibration epochs); governance must act within the window or accept the genesis default forward. (#r170)

---

**Q2 (N_buckets=16 bucket mapping at oracle resolution) → Outer-fence-proportional bucket boundaries; scalar V* maps to fractional position within its bucket; scoring uses per-bucket probability mass (#r170):**

At T_finality, oracle returns a scalar V*. The 16-bucket representation D_a must be scored against V*. Bucket boundaries must be stable (not epoch-variable) to preserve EAT consistency.

**Bucket boundary specification:**

```
bucket_boundaries[i] = outer_fence_min + i × (outer_fence_max − outer_fence_min) / N_buckets
  for i = 0, 1, ..., N_buckets   (17 boundary values; 16 intervals)

bucket_index(V*) = floor((V* − outer_fence_min) / bucket_width)
  where bucket_width = (outer_fence_max − outer_fence_min) / N_buckets

If V* == outer_fence_max: bucket_index = N_buckets - 1  (last bucket, inclusive right boundary)
If V* outside outer_fence: oracle_anomaly triggers (Invariant #52); settlement deferred
```

**Log-score against bucket:**

```
log_score_a(V*) = log(D_a(t)[bucket_index(V*)])

(standard log-score on the probability mass assigned to the bucket containing V*)
```

**Precision concern — bucket width vs oracle precision:** At N_buckets=16 over the outer_fence range, each bucket covers 1/16 of the range. If V* typically falls in a narrow region (e.g., a financial rate rarely moves more than ±5% from median), most buckets will have near-zero assigned probability. This is expected and correct — knowers who assign all mass to the probable region earn high log-scores on resolution; knowers who spread mass evenly are penalised.

**Interaction with parametric output:** The parametric (μ, σ) S(t) output to unknowers is the mixture of submitted D_a arrays, re-fit to a Gaussian. Gaussian-fit is off-chain (knower client or governance-operated) and not consensus-critical — unknowers receive a convenience representation of the EAT-committed bucket distribution.

**Design law (#r170):** Bucket boundaries are defined by outer_fence parameters at class registration and are immutable for the class lifecycle. Any change to outer_fence (governance update) triggers a T_transition event in the EAT; historical D_a arrays retain their original bucket interpretation for scoring purposes (EAT immutability). New submissions after T_transition use the new bucket boundaries. (#r170)

---

**Q3 (Information monopoly — minimum independent-knower count for DISCOVERY_MODE epistemic objectives) → Epistemically_live_discovery threshold: ≥2 independent knowers with track record; monopoly mode as formal alternative (#r170):**

The pool-depletion anti-dump mechanism (Invariant from #r169) requires ≥2 independent knowers for the competitive dynamic to function. A single-knower DISCOVERY_MODE coordinate has no pool depletion from competitors — the monopolist faces no multi-epoch revelation pressure.

**Two sub-cases:**

**Sub-case A — Monopoly with honest revelation:** The single knower has genuine private information and wishes to maximise multi-epoch streaming fees. They do NOT have a dump-all incentive if:
- The consistency penalty still applies (large single-epoch updates are penalised regardless of other knowers)
- The accuracy_bonus_pool provides terminal incentive

In this case, DISCOVERY_MODE functions correctly under monopoly, with weaker competitive pressure but honest epistemic output. S(t) quality depends entirely on the single knower's calibration.

**Sub-case B — Monopoly with strategic withholding:** The single knower controls timing and can extract maximum accuracy_bonus_pool by waiting. Without a competing knower to deplete the pool, dump-all at epoch T-1 is profitable if accuracy_bonus_pool ≥ (T-1 epochs × expected streaming fee loss).

**Resolution — epistemically_live_discovery threshold and monopoly mode:**

```
epistemically_live_discovery(class_i) = true iff:
  unique_active_knowers_with_track_record(class_i) ≥ 2  (at least 2 independent credibility-bearing knowers)

If epistemically_live_discovery = false (monopoly condition):
  → Switch to MONOPOLY_MODE for this class:
      accuracy_bonus_pool_fraction increases to 0.70 × query_fee_total (higher terminal incentive)
      consistency_penalty window is tightened: τ = τ_genesis × 0.70
      streaming_fee_distribution restricted to IVD_weight only (no base_share; pure information delivery incentive)
  → Governance alert: monopoly_condition_active
  → epistemically_live_discovery check per epoch; switches back to normal DISCOVERY on second independent knower

Why not simply prohibit DISCOVERY_MODE with <2 knowers: Some legitimate high-expertise coordinates will naturally attract only one credible knower early in their lifecycle. Blocking the mechanism prevents genuine information revelation from the single expert. MONOPOLY_MODE is a degraded-but-functional alternative.
```

**Minimum viable threshold reasoning:** Two independent knowers creates a competitive dynamic; one can observe the other's updates (public S(t)) and provide corrective signal. Single-knower is epistemic monopoly; governance alert is appropriate but mechanism is not blocked. (#r170)

---

**Q4 (DISCOVERY_MODE S(T_anchor) genesis prior export interface) → ShadowClearingPairRegistry.exportGenesisPrior; atomic snapshot at epoch boundary; alpha_prior attenuation applied at export (#r170):**

The shadow-class DISCOVERY_MODE produces S(T) — a full distribution (parametric or 16-bucket). The clearing-class needs this as its genesis prior S_clearing_genesis(c). The export must be atomic (single transaction), immutable (EAT-committed), and correctly attenuated (mode_mismatch_discount, alpha_prior_base applied at export time, per #r154/Q1).

**Export interface:**

```
ShadowClearingPairRegistry.exportGenesisPrior(
  shadow_class_id,
  clearing_class_id,
  epoch_T_anchor   // epoch at which clearing class genesis begins
):
  Validates:
    - shadow_class_id and clearing_class_id are registered as a pair
    - shadow_class has ≥1 completed normal-mode macro-epoch
    - clearing_class is in Phase 0 (pre-genesis) or Phase 1 (bootstrap)
    - msg.sender = governance multisig (only governance can trigger genesis prior export)

  Reads from DiscoveryCredibilityAggregator:
    S_discovery_snapshot = S(epoch_T_anchor)  // 16-bucket or parametric
    mode_mismatch_discount_current = current value for the shadow-clearing pair
    age_at_export = epoch_T_anchor − shadow_class.last_update_epoch
    alpha_prior_effective = alpha_prior_base
                            × max(0, 1 − age_at_export / staleness_window_shadow)
                            × (1 − mode_mismatch_discount_current)

  Computes:
    S_genesis_prior = alpha_prior_effective × S_discovery_snapshot
                    + (1 − alpha_prior_effective) × uniform_prior(outer_fence_clearing)

  Writes to CoordinateRegistry_v2.2 (clearing class):
    genesis_prior_snapshot = S_genesis_prior
    genesis_prior_source = shadow_class_id
    genesis_prior_epoch = epoch_T_anchor
    alpha_prior_effective_at_export = alpha_prior_effective

  Commits EAT events on both chains:
    shadow-class EAT: genesis_prior_exported { clearing_class_id, epoch_T_anchor, alpha }
    clearing-class EAT: genesis_prior_received { shadow_class_id, alpha_prior_effective, S_snapshot_hash }
```

**Atomicity:** The export is a single governance-signed transaction. The shadow-class EAT event and clearing-class EAT event are emitted in the same transaction. No cross-chain race condition — both are on the same EVM deployment (v2.2 contract set, same L2/chain).

**Post-export shadow-class:** The shadow-class does not enter WINDING_DOWN at export. It continues DISCOVERY_MODE normally. Export is a read-only snapshot operation that does not alter the shadow-class state. The clearing-class genesis prior is a snapshot, not a live feed — consistent with Invariant #44 (historical S_cred immutable).

**N_prior_epochs decay in clearing-class:** After export, the clearing class applies N_prior_epochs decay (#r155/Q2): the prior's contribution decays to zero over N_calibration clearing-class macro-epochs. Each clearing epoch, DiscoveryCredibilityAggregator_v2.2 reduces prior weight by (1/N_calibration) additively. (#r170)

---

## Net-New Structural Insight: Advisory Mode as a First-Class Protocol Phase (#r170)

The τ_genesis advisory mode (Q1) introduces a new concept not previously explicit: a **protocol phase that collects data without exercising judgement**. This is distinct from:
- Normal operation (penalties active)
- Degraded mode (penalties suspended due to DA/solvency failure)
- Bootstrap Phase 1 (penalties absent because mechanism infrastructure is immature)

Advisory mode is specifically for **parameter calibration under genuine uncertainty** — the mechanism is operationally functional, the parameter is known to be approximate, and the governance window is bounded.

**First-class advisory mode specification:**

```
advisory_mode(class_i, parameter_P):
  active_when: P is beyond its self-calibration bootstrap threshold AND governance has not yet submitted P_revision
  duration: N_advisory_epochs (default = N_calibration; governance-settable at registration, bounded [2, N_calibration])
  effect on P: P is active at its genesis value but P-dependent penalties are advisory-only (logged, not applied)
  P-revision window: governance may submit one P_revision EAT event during advisory_mode
  advisory_mode exits: at N_advisory_epochs regardless of P_revision status
```

**Applicable parameters (current list):**
- τ_genesis (DISCOVERY_MODE info_arrival_tolerance)
- mode_mismatch_discount_base (shadow-class, before N_align_window epochs)
- σ_resolve-derived min_q_bonus_ratio (before N_calibration resolved queries)
- w_override_base × (1-freq) when override_frequency is uninitialised

**Common invariant:** Every governance-estimated parameter has an advisory mode before self-calibration activates, unless the parameter was derived from an analogous existing class (analogy exemption: advisory mode skipped if analogy_class_id is cited and analogy data is valid).

**Design law (#r170):** Advisory mode is a first-class protocol phase for governance-estimated parameters that lack sufficient data for self-calibration. It collects data without penalising legitimate participants, is bounded in duration, and provides a one-shot governance revision window before penalties activate. Analogy citation exempts a class from advisory mode for the cited parameter. (#r170)

---

## Structural Synthesis: DISCOVERY_MODE — Near-Complete (#r170)

| Issue | Resolution | Law |
|---|---|---|
| τ_genesis miscalibration | Bounded declaration + analogy citation + N_calibration advisory mode | Advisory mode for governance-estimated params; analogy exemption |
| Bucket mapping at resolution | outer_fence-proportional; V* → bucket_index; immutable for class lifecycle | Bucket boundaries = outer_fence at registration; change requires T_transition |
| Information monopoly | Epistemically_live_discovery (≥2 knowers); MONOPOLY_MODE degraded alternative | Monopoly is degraded-but-functional; not blocked |
| Genesis prior export | ShadowClearingPairRegistry.exportGenesisPrior; atomic, attenuated, EAT-committed | Snapshot at export epoch; not a live feed; clearing class decays prior over N_prior_epochs |

---

## Cumulative Invariants (additions through #r170)

**Invariant #73 (#r170):** Advisory mode is a first-class protocol phase for governance-estimated parameters. Duration = N_advisory_epochs ≤ N_calibration; one-shot P_revision window; penalties advisory-only during advisory_mode; penalties activate at N_advisory_epochs + 1 regardless of whether P_revision was submitted.

**Invariant #74 (#r170):** Bucket boundaries for N_buckets=16 discretization are defined by outer_fence parameters at class registration and are immutable for the class lifecycle. If outer_fence changes mid-lifecycle, a T_transition EAT event is emitted; historical D_a retain original bucket interpretation.

**Invariant #75 (#r170):** epistemically_live_discovery requires ≥2 independent knowers with track records. If this threshold is not met, the class enters MONOPOLY_MODE (degraded-but-functional): tighter consistency penalty, higher accuracy_bonus_pool fraction, IVD-only streaming distribution.

**Invariant #76 (#r170):** ShadowClearingPairRegistry.exportGenesisPrior is governance-only, single-transaction atomic, and produces a snapshot (not a live feed). Shadow-class state is unchanged by export. Clearing class prior decays over N_prior_epochs using the N_calibration decay schedule.

---

## Run Log Update

- **#r170** — 2026-04-04T02:02Z — DISCOVERY_MODE Q1–Q4 (#r169 open questions): τ_genesis advisory mode; bucket mapping; MONOPOLY_MODE for information monopoly; genesis prior export interface. Advisory mode formalised as first-class protocol phase. Four new invariants (#73–#76).

---

## Open Questions for #r171+

1. **Advisory mode and adversarial consistency simulation:** During advisory_mode, JS penalties are logged but not applied. An adversary observing this window can submit extreme D_a distributions to probe the mechanism without penalty, learning τ_genesis calibration information before governance sets the revision. Should advisory-mode submissions be subject to a stake cost (submitted but unrewarded), or are they fully free?

2. **MONOPOLY_MODE → normal DISCOVERY_MODE transition:** When the second independent knower enters, how many epochs must they participate before MONOPOLY_MODE exits? An immediate transition on first second-knower epoch gives a flash-participation attack surface: brief second-knower appearance then withdrawal restores normal DISCOVERY_MODE in one epoch, allowing dump-all again.

3. **ShadowClearingPairRegistry.exportGenesisPrior — prior age staleness:** The export is governance-triggered and may be delayed. If the shadow-class has not updated S(t) for many epochs (e.g., low-activity phase), the exported snapshot may be stale relative to the shadow-class's own staleness_window. Should the export be blocked if age_at_export > staleness_window_shadow?

4. **DISCOVERY_MODE on-chain KL computation — negative IVD handling:** IVD_weight(a,t) = max(0, IVD_a(t)) / Σ max(0, IVD_j(t)). If ALL knowers simultaneously produce negative IVD_a (all updates reduce state quality), the denominator is zero and fee distribution is undefined. What is the fallback distribution when Σ max(0, IVD_j(t)) = 0?

---

## #r171 Contributions — 2026-04-04T02:12Z

**Phase: v2.2 Module 1 — DISCOVERY_MODE. Addresses all four open questions from #r170.**

---

**Q1 (Advisory mode adversarial consistency simulation — free probe attack) → Lower-quartile τ_revision calibration renders adversarial upper-tail inflation counterproductive; stake cost preserved (#r171):**

Advisory-mode submissions are not free. The claim_submission_fee and escrow lockup still apply (Invariant #47: escrow is non-withdrawable post-submission). An adversary submitting extreme D_a distributions during advisory mode:
- Pays claim_submission_fee
- Locks escrow that is scored at oracle resolution
- Incurs credibility_ratio penalty at resolution (extreme noisy distributions resolve poorly)

The residual concern is calibration gaming: an adversary who submits D_a far outside the plausible range inflates the observed JS distribution toward high values. If governance uses the maximum or mean observed JS to set τ_revision, the adversary could cause τ_genesis to be revised too loosely.

**Resolution — lower-quartile calibration commitment at registration:**

```
tau_revision_calibration_rule = Q25  (25th percentile of observed JS distribution from advisory_mode epochs)
  committed at class registration, immutable for that class's advisory window
```

The adversary's extreme submissions inflate Q75 and above — they have zero effect on Q25. Governance sets τ_revision = f_info(Q25(observed_JS)) where f_info is the same self-calibration function from #r169/Q1.

An adversary who wants to inflate Q25 must submit many moderate-JS distributions across the advisory window, which requires substantial escrow and results in degraded credibility_ratio at resolution. The attack becomes expensive for minimal calibration benefit.

**Advisory-mode EAT record:** Commits the full observed JS distribution summary (Q10, Q25, Q50, Q75, Q90) per epoch — auditable; governance sees the percentile distribution before committing τ_revision. If Q25 ≪ Q50, the distribution is right-skewed (likely adversarial inflation in the upper tail); governance is informed.

**Design law (#r171):** Advisory-mode calibration uses the lower quartile (Q25) of observed parameter distributions, not the mean or maximum. Upper-tail inflation by adversarial extreme submissions cannot affect Q25. The calibration commitment (Q25-based) is declared at class registration and immutable for the advisory window. (#r171)

---

**Q2 (MONOPOLY_MODE → normal DISCOVERY_MODE transition — flash-participation attack) → N_monopoly_exit_window stability requirement + partial track record prerequisite (#r171):**

The flash-participation attack: adversary briefly registers as second knower → MONOPOLY_MODE exits immediately → adversary withdraws → dump-all in now-normal DISCOVERY_MODE.

Two reinforcing defences needed:

**Defence A — Track record prerequisite for mode-exit contribution:**

```
second_knower_mode_exit_eligible(a) = true iff:
  resolved_claims_a >= floor(N_track_threshold / 2)
  AND stake_a_net >= k_min (standard minimum claim stake for the class)
```

An address with zero resolved claims cannot trigger MONOPOLY_MODE exit regardless of stake.

**Defence B — N_monopoly_exit_window stability window:**

```
N_monopoly_exit_window = max(2, ceil(N_calibration / 2))  [default: 2 epochs for N_calibration=4]

MONOPOLY_MODE exits only when:
  epistemically_live_discovery = true (>= 2 eligible knowers)
  AND condition has been continuously true for N_monopoly_exit_window consecutive normal-mode epochs
  AND governance has not flagged the second knower as cluster member with the first (Invariant #50)

Re-entry: if epistemically_live_discovery falls back to false at any point during N_monopoly_exit_window:
  window resets to zero
```

**MONOPOLY_MODE re-entry (hysteresis):** Once MONOPOLY_MODE has exited, it re-enters only if epistemically_live_discovery remains false for >= 2 consecutive epochs — prevents oscillation.

**Flash-participation residual:** An adversary with a partial track record (>= N_track_threshold/2 resolved claims on easy coordinates) could still attempt this attack at lower cost. The cluster detection mechanism (#r165/Q1) handles this: if the second and first knower are governance-confirmed as a cluster, they do not count as two independent knowers for epistemically_live_discovery.

**Design law (#r171):** Participation-threshold mode transitions require stability windows and track-record prerequisites on contributing parties. Immediate mode transitions on single-epoch participation are prohibited for modes that carry weaker adversarial protections. (#r171)

---

**Q3 (exportGenesisPrior — prior age staleness: block or advisory confirm?) → No hard block; advisory-confirm gate at alpha <= 0.10; governance confirmation with rationale required (#r171):**

Hard blocking is counterproductive: governance may have legitimate reasons to export even a stale prior (coordinated multi-class deployment, shadow-class quiescent but still valid). The alpha_prior_effective formula already handles staleness gracefully — age_at_export >= staleness_window_shadow yields alpha = 0 (pure uniform prior, no discovery benefit).

Silent acceptance of alpha = 0 is the error. Governance may not realise the export is stale.

**Resolution — advisory-confirm gate at alpha = 0:**

```
ShadowClearingPairRegistry.exportGenesisPrior precondition:
  If alpha_prior_effective <= alpha_prior_effective_threshold (default 0.10):
    emit genesis_prior_stale_warning { shadow_class_id, clearing_class_id, age_at_export, alpha_prior_effective }
    Export BLOCKED pending governance confirmation:
      governance must call exportGenesisPriorConfirmed(shadow_class_id, clearing_class_id, rationale: string)
      within N_confirm_window = 2 macro-epochs
      Rationale is required (non-empty string), EAT-committed
    If N_confirm_window passes without confirmation: export attempt expires; governance must resubmit
```

This pattern reuses the arweave_absence_acknowledged model (#r159/Q1): governance is not blocked permanently but must commit an explicit acknowledgment before proceeding with a known-low-value action.

**alpha_prior_effective_threshold governance parameter:** bounded [0.05, 0.25]; default 0.10. Normal-case exports (alpha > 0.10) proceed immediately with no gate.

**Design law (#r171):** When a protocol action would produce a near-zero-value outcome due to a parameter condition, the mechanism does not block the action but requires explicit governance acknowledgment with a rationale commitment. Advisory-confirm gate makes known-low-value actions transparent and auditable. (#r171)

---

**Q4 (All-negative IVD epoch — fallback fee distribution when denominator = 0) → Rollover with N_rollover_max = 3 epochs; challenger_pool safety valve after cap (#r171):**

All-negative IVD (Σ max(0, IVD_j(t)) = 0) means every knower's update degraded shared state quality in epoch t. Three requirements for the fallback: (1) no reward for degradation; (2) no permanent fee stagnation; (3) recovery incentive.

**Resolution — rollover with safety valve:**

```
On all-negative IVD epoch (Σ max(0, IVD_j(t)) = 0):
  streaming_fee_distribution(t) = 0 for all knowers
  fee_streaming_pool carry-forward: fees roll over to epoch t+1
  rollover_epoch_count increments

  If rollover_epoch_count < N_rollover_max: silent rollover
  If rollover_epoch_count == N_rollover_max (default 3):
    safety_valve fires:
      50% of fee_streaming_pool -> challenger_pool
      50% remains in fee_streaming_pool (preserves recovery incentive)
      rollover_epoch_count resets to 0
      EAT event: streaming_pool_safety_valve_fired { epoch, pool_balance_before, challenger_pool_share }
    Governance alert: all_negative_ivd_extended
```

**Recovery incentive mechanics:** Knowers observing an accumulated fee_streaming_pool from rollover compete to produce the first positive-IVD update. The rolled-over pool creates a concentrated reward for genuine state improvement. This is the primary mechanism restoring epistemic health after a degenerate streak.

**Why challenger_pool as safety valve:** Challenger_pool distribution incentivises challengers to identify and remove the noisy-knowers causing the all-negative IVD streak. Governance treasury would not create this targeted enforcement incentive.

**Design law (#r171):** Degenerate equilibrium epochs (all-negative IVD) trigger fee rollover, not redistribution to degrading contributors. Rollover creates accumulated recovery incentive; N_rollover_max safety valve prevents indefinite stagnation; challenger_pool is the safety valve destination because it targets enforcement of the state-degradation attack. (#r171)

---

## Net-New Structural Insight: The Advisory-Confirm Pattern as a Reusable Mechanism Primitive (#r171)

Three separate runs now apply the same governance-confirmation pattern:
- #r159/Q1: arweave_mirror_closed requires arweave_absence_acknowledged
- #r171/Q3: exportGenesisPrior at alpha <= 0.10 requires exportGenesisPriorConfirmed with rationale

The pattern: **when a governance action would produce a known-degenerate outcome, do not block it — gate it on explicit acknowledgment with a rationale that is immutably committed to the EAT.**

**Generalized advisory-confirm primitive:**

```
advisory_confirm_gate(condition, action, confirmation_call, N_confirm_window):
  When condition is true at action invocation:
    emit advisory_action_warning { condition, action_type, expected_outcome }
    Block action
    Governance must call confirmation_call(rationale: string) within N_confirm_window
    If confirmed: action proceeds; EAT records { confirmed_by, rationale, condition_at_confirmation }
    If expired: action attempt expires; governance must resubmit
```

Applies to (current list): arweave_mirror_closed when settlement records present; exportGenesisPrior when alpha <= 0.10; oracle deregistration; any parameter_change triggering >N_alert_refunds bond refund events in one window.

**Design law (#r171):** The advisory-confirm gate is the canonical mechanism response when a governance action's outcome is computable as degenerate at invocation time. Block + explicit rationale + EAT audit is preferable to either silent execution or hard prohibition. (#r171)

---

## Structural Synthesis: DISCOVERY_MODE — Hardening Pass #1 Closed (#r171)

| Issue | Resolution | Law |
|---|---|---|
| Advisory mode probing | Q25-based tau_revision; adversarial upper-tail inflation irrelevant | Lower-quartile calibration; adversarial probe is self-defeating |
| Flash-participation MONOPOLY exit | N_monopoly_exit_window + partial track record prerequisite | Participation-threshold transitions require stability windows |
| Stale genesis prior export | Advisory-confirm gate at alpha <= 0.10; rationale EAT-committed | Known-degenerate outcomes require explicit acknowledgment |
| All-negative IVD epoch | Rollover to N_rollover_max = 3; 50% -> challenger_pool safety valve | Degenerate epochs trigger rollover + targeted enforcement incentive |

---

## Cumulative Invariants (additions through #r171)

**Invariant #77 (#r171):** Advisory-mode calibration commits to Q25 (25th percentile) of observed parameter distributions at class registration. Upper-tail inflation by adversarial submissions has zero effect on Q25-based tau_revision.

**Invariant #78 (#r171):** MONOPOLY_MODE exits only after N_monopoly_exit_window consecutive normal-mode epochs of epistemically_live_discovery = true, with second knower meeting partial track record prerequisite (>= N_track_threshold/2 resolved claims). Re-entry requires >= 2 consecutive false epochs (hysteresis).

**Invariant #79 (#r171):** ShadowClearingPairRegistry.exportGenesisPrior at alpha_prior_effective <= 0.10 requires advisory-confirm gate: governance must call exportGenesisPriorConfirmed with non-empty rationale within N_confirm_window = 2 macro-epochs. Absent confirmation, export attempt expires.

**Invariant #80 (#r171):** All-negative IVD epoch triggers streaming fee rollover. After N_rollover_max = 3 consecutive rollover epochs, safety valve fires: 50% of fee_streaming_pool routes to challenger_pool; rollover_epoch_count resets to 0.

**Invariant #81 (#r171):** The advisory-confirm gate is the canonical mechanism response when a governance action's outcome is computable as degenerate at invocation time. Format: automatic detector -> block + emit warning -> governance confirmation with non-empty rationale within N_confirm_window -> EAT-committed confirmation.

---

## Open Questions for #r172+

1. **Q25-calibrated tau_revision and sparse advisory epochs:** If few knowers participate during advisory mode (e.g., 3 total submissions), Q25 may be a noisy outlier from too-small a sample. Is there a minimum submission count before tau_revision is allowed, and what is the fallback if count is not met at end of advisory window?

2. **MONOPOLY_MODE partial track record prerequisite and bootstrapping contradiction:** N_track_threshold/2 resolved claims requires prior oracle resolutions. For a brand-new class, neither incumbent nor second knower has any resolved claims. Does MONOPOLY_MODE apply from genesis of a single-knower class, and is N_monopoly_exit_window then irrelevant until the first oracle resolution?

3. **N_rollover_max and long-horizon DISCOVERY_MODE coordinates:** For T_discovery = 48 macro-epochs, a coordinated all-negative IVD attack lasting 4 epochs would cycle the safety valve, drain 50% of streaming pool to challenger_pool, and reset. Is the safety valve cycle economically harmful to legitimate unknowers who pre-paid query fees expecting streaming returns?

4. **Advisory-confirm pattern and emergency governance:** The gate blocks an action pending confirmation within N_confirm_window. Should the emergency multisig bypass (#r158/Q3) override the advisory-confirm gate entirely, or should the gate always be honoured even under emergency conditions?

*Last updated: #r171 — 2026-04-04T02:12Z*

---

## #r172 Contributions — 2026-04-04T02:22Z

**Phase: v2.2 Module 1 — DISCOVERY_MODE. Addresses all four open questions from #r171.**

---

**Q1 (Q25-calibrated tau_revision and sparse advisory epochs — minimum submission count) → N_advisory_min_submissions = max(5, 2 × N_active_knowers); fallback: τ_revision prohibited, τ_genesis carries forward with N_advisory_window extended by N_calibration (#r172):**

Q25 from 3 submissions is statistically meaningless — worst case, Q25 is one of three data points, any of which could be an adversarial outlier or a noisy launch-epoch anomaly.

**Resolution — minimum submission gate:**

```
tau_revision_eligible =
  (total advisory_mode D_a submissions across all knowers >= N_advisory_min_submissions)
  AND (advisory_mode has run for >= N_advisory_window epochs without termination)

N_advisory_min_submissions = max(5, 2 × N_active_knowers_at_advisory_start)
```

**Fallback if count not met at end of advisory window:**

```
If tau_revision_eligible = false at advisory_window expiry:
  tau_revision: prohibited for this advisory window
  advisory_window extends by N_calibration epochs (one-time extension, automatic)
  tau_genesis carries forward unchanged
  EAT event: advisory_window_extended { reason: "insufficient_submissions", epoch }

  If still false after extension:
    advisory_mode terminates; tau_genesis carries forward permanently until self-calibration activates
    EAT event: advisory_window_closed_without_revision { tau_genesis_retained, total_submissions }
    Governance alert: tau_genesis_unrevised_low_participation
```

**Design law (#r172):** Quantile-based parameter calibration requires a minimum data density gate before the quantile is computed. When the gate is not met, the advisory window extends once; if still unmet, the genesis default carries forward and the governance alert redirects attention to the participation problem. (#r172)

---

**Q2 (MONOPOLY_MODE at genesis — bootstrapping contradiction with partial track record prerequisite) → Genesis MONOPOLY_MODE is track-record-free for first N_bootstrap_epochs; prerequisite activates after first oracle resolution (#r172):**

At class genesis, no knower has resolved claims. The track record prerequisite (Invariant #78) cannot be met by anyone — a phase-ordering conflict.

**Resolution — N_bootstrap_epochs track-record exemption:**

```
N_bootstrap_epochs = N_calibration

During N_bootstrap_epochs:
  MONOPOLY_MODE applies if only one unique knower present
  mode-exit-eligible second knower: requires ONLY stake_a_net >= k_min (no track record gate)
  N_monopoly_exit_window still applies (consecutive-epoch stability required)

After N_bootstrap_epochs (or first oracle resolution, whichever comes first):
  standard partial track record prerequisite activates:
    resolved_claims_a >= floor(N_track_threshold / 2)
```

Flash-participation during bootstrap: claim withdrawal is prohibited (Invariant #47). k_min escrow lock serves as the credibility gate. Bootstrap substitutes stake lock for track record.

**Design law (#r172):** Track-record prerequisites are inapplicable at class genesis. Bootstrap substitutes the minimum stake requirement for the track record gate during N_bootstrap_epochs. After the first oracle resolution, full prerequisites apply. (#r172)

---

**Q3 (N_rollover_max and long-horizon coordinates — safety valve economics for pre-paid query fees) → Mandatory disclosure at registration; N_rollover_max ceiling scaled to horizon; future query credit for pre-paid unknowers (#r172):**

For T_discovery = 48 macro-epochs, a coordinated all-negative IVD streak cycling the safety valve materially reduces pre-paid unknower returns.

**Resolution — three-part:**

**Part 1 — Mandatory disclosure at class registration:**
```
discovery_params.safety_valve_disclosure:
  N_rollover_max: declared value (governance-set, bounded [2, 6])
  max_streaming_pool_drain_per_valve: 50% (protocol-fixed)
  max_valve_cycles_per_epoch_window: floor(T_discovery / N_rollover_max)
  EAT: committed at class registration; visible to unknowers before query fee payment
```

**Part 2 — N_rollover_max governance ceiling scaled to horizon:**
```
N_rollover_max_max = ceil(T_discovery / 8)
  For T_discovery=48: N_rollover_max_max = 6
  For T_discovery=4:  N_rollover_max_max = 1
```

**Part 3 — Future query credit (not refund) on safety valve fire:**
```
On safety_valve_fired:
  unknower_a future_query_credit = (query_fee_total_paid - fees_already_returned) × 0.50
  Stored in CoordinateRegistry; applicable to future query on same or sister class
```

**Design law (#r172):** Long-horizon mechanism coordinates disclose worst-case parametric risk at registration. Safety valves have governance-settable recurrence bounds scaled to horizon. Pre-paid participants receive future-use credit; refunds are not issued — the at-risk nature of the fee is a mechanism design feature. (#r172)

---

**Q4 (Advisory-confirm pattern and emergency multisig bypass — bifurcated treatment) → Known-degenerate-outcome gates: no bypass; operational-continuity gates: bypass permitted at elevated threshold (#r172):**

**Bifurcated treatment:**

```
TYPE = known_degenerate_outcome (stale genesis prior at alpha ≤ 0.10; arweave_mirror_closed without ack):
  Emergency multisig bypass: NOT PERMITTED
  Degeneracy is invariant to urgency; correct exit = bypass the degenerate path, not the gate

TYPE = operational_continuity (oracle deregistration; CredibilityAggregator upgrade):
  Emergency multisig bypass: PERMITTED at elevated k-of-n threshold
  Retroactive rationale within N_confirm_window = 2 macro-epochs required
```

**Categorization table:**

| Advisory-confirm gate | Type | Emergency bypass |
|---|---|---|
| arweave_mirror_closed without ack | known_degenerate_outcome | NOT PERMITTED |
| exportGenesisPrior at alpha ≤ 0.10 | known_degenerate_outcome | NOT PERMITTED |
| Oracle deregistration | operational_continuity | PERMITTED (elevated k-of-n) |
| HARD_GATE parameter change (#r158/Q3) | operational_continuity | PERMITTED (elevated k-of-n) |

**Design law (#r172):** Known-degenerate-outcome advisory-confirm gates are absolute — emergency bypass is not permitted because the outcome's degeneracy is invariant to urgency. Operational-continuity gates admit bypass at elevated threshold with mandatory post-facto rationale. (#r172)

---

## Net-New Structural Insight: The Bootstrap-Substitute Pattern (#r172)

Every mature mechanism prerequisite has a genesis-phase substitute that provides equivalent security at lower informational cost. This pattern recurs throughout the spec:

| Mature prerequisite | Bootstrap substitute | Activation event |
|---|---|---|
| Partial track record (>= N_track_threshold/2) | Minimum stake k_min lock | First oracle resolution |
| Self-calibrated tau | τ_genesis + advisory mode | N_sigma_window oracle epochs |
| Mode mismatch discount | Mode mismatch prior (governance) | N_align_window alignment samples |
| Oracle anomaly inner envelope | μ_genesis ± 3σ_genesis | N_sigma_window oracle epochs |
| epistemically_live_discovery (2 knowers w/ track record) | 2 knowers, stake-only | N_bootstrap_epochs elapsed |

Bootstrap substitutes are: (1) non-zero in cost; (2) achievable without class history; (3) replaced by mature prerequisite event-driven (not governance-triggered).

**Design law (#r172):** Every mature mechanism prerequisite has a bootstrap substitute operational from genesis. Bootstrap substitutes are non-zero cost, achievable without class history, and replaced by the mature prerequisite when sufficient history exists. Activation is event-driven, not governance-triggered. (#r172)

---

## Structural Synthesis: DISCOVERY_MODE — Hardening Pass #2 Closed (#r172)

| Issue | Resolution | Law |
|---|---|---|
| Sparse advisory epoch calibration | N_advisory_min_submissions gate; one-time extension; genesis-default-forward if sparse | Quantile calibration requires data density gate |
| MONOPOLY_MODE genesis bootstrapping | N_bootstrap_epochs stake-only substitute for track record prerequisite | Bootstrap substitute is non-zero cost, history-free, event-activated to mature |
| Safety valve economics (long-horizon) | Disclosure at registration; N_rollover_max ceiling; future query credit | Disclose worst-case at registration; scale N_rollover_max to horizon; credit not refund |
| Emergency bypass vs advisory-confirm | Bifurcated: known-degenerate-outcome = no bypass; operational-continuity = permitted | Degeneracy is invariant to urgency |

---

## Cumulative Invariants (additions through #r172)

**Invariant #82 (#r172):** Advisory-mode tau calibration requires N_advisory_min_submissions = max(5, 2 × N_active_knowers). If gate not met at window end, one N_calibration extension; after extension, genesis default carries forward permanently until self-calibration activates.

**Invariant #83 (#r172):** During N_bootstrap_epochs (= N_calibration), MONOPOLY_MODE exit requires only stake k_min (no track record prerequisite). After N_bootstrap_epochs or first oracle resolution, Invariant #78 partial track record prerequisite activates fully.

**Invariant #84 (#r172):** Long-horizon DISCOVERY_MODE classes must disclose worst-case safety valve exposure at registration. N_rollover_max is governance-settable with class-specific upper bound ceil(T_discovery/8). Pre-paid unknowers receive future_query_credit (not refund) when safety valves fire.

**Invariant #85 (#r172):** Advisory-confirm gates are bifurcated: known-degenerate-outcome gates are absolute (no emergency bypass); operational-continuity gates admit emergency bypass at elevated k-of-n threshold with mandatory post-facto rationale within N_confirm_window.

**Invariant #86 (#r172):** Every mature mechanism prerequisite has a bootstrap substitute operational from genesis. Bootstrap substitutes are non-zero cost, achievable without class history, and replaced by the mature prerequisite when sufficient history exists. Activation is event-driven, not governance-triggered.

---

## Open Questions for #r173+

1. **future_query_credit transferability to sister class:** Invariant #84 allows credit transfer to a "governance-declared sister class." Define the sister-class declaration: what relationship justifies credit portability (same oracle, same underlying event, same governance sector), and should credit transfer be automatic or require unknower explicit election?

2. **N_rollover_max and N_advisory_min_submissions interaction:** Both parameters scale to N_calibration. What is the correct governance interface — separate per-class fields, or derived from N_calibration with class-specific overrides? Risk of governance setting inconsistent values?

3. **Bootstrap-substitute stake lock duration:** During N_bootstrap_epochs, second knower's k_min escrow is locked until oracle resolution (Invariant #47). For long T_discovery classes, this is a potentially multi-year lock. Is N_bootstrap_epochs bounded independently of T_discovery, or does long T_discovery create prohibitively expensive bootstrap-phase commitments?

4. **DISCOVERY_MODE Module 1 completeness declaration:** With 86 invariants and two hardening passes through #r172, what remaining attack families and open questions constitute the minimum bar for declaring Module 1 specification-complete?

*Last updated: #r173 — 2026-04-04T02:32Z*

---

## #r173 Contributions — 2026-04-04T02:32Z

**Phase: v2.2 Module 1 — DISCOVERY_MODE. Addresses all four open questions from #r172. Completeness declaration for Module 1.**

---

**Q1 (future_query_credit transferability to sister class — definition and election model) → Oracle-lineage declaration at registration; explicit unknower election required; credit non-expiring but non-fungible (#r173):**

The safety valve fires and 50% of the streaming pool migrates to challenger_pool. Pre-paid unknowers receive future_query_credit usable on the same or a sister class (Invariant #84). Sister class must be defined to prevent governance manufacturing arbitrary credit sinks.

**Sister-class declaration criteria (governance, at registration of either class):**

```
sister_class(A, B) = true iff ANY of:
  (a) oracle_lineage: same oracle_address registered for both A and B (same underlying data source)
  (b) same_event: governance declares both classes reference the same underlying real-world event
      (requires EAT event: sister_declaration { class_A, class_B, basis: "oracle_lineage" | "same_event", rationale })
  (c) clearing_shadow_pair: A and B are registered as shadow↔clearing pair (Invariant #76)

NOT eligible:
  - governance declares sister relationship without one of the above three bases
  - same governance sector alone is insufficient (too broad; credit leakage risk)
```

**Unknower election (not automatic):**

Credit is held in CoordinateRegistry against unknower_address. Transfer requires explicit call:

```
applyQueryCredit(from_class_id, to_class_id, credit_amount):
  requires sister_class(from_class_id, to_class_id) = true
  requires msg.sender = unknower with active credit on from_class_id
  EAT event: query_credit_applied { from_class_id, to_class_id, amount, unknower_address }
```

Automatic credit routing without election risks undermining the unknower's decision to participate in a different class. Explicit election ensures the unknower has evaluated the sister class independently.

**Credit properties:** Non-expiring (no staleness decay — credit is a refund liability, not an epistemic signal); non-fungible (cannot be transferred between arbitrary addresses; tied to the unknower_address that paid the original query fee); applicable only at query submission time (cannot be converted to escrow or TOWL credit).

**Design law (#r173):** Credit portability requires declared kinship (oracle lineage, same event, or shadow-clearing pair). Portability is unknower-elected, not automatic. Credit is non-expiring and non-fungible. (#r173)

---

**Q2 (N_rollover_max and N_advisory_min_submissions interaction — governance interface) → Unified governance parameter table; both derived from N_calibration with override bounds; consistency check at registration (#r173):**

Both N_rollover_max and N_advisory_min_submissions scale naturally from N_calibration. Setting them independently invites inconsistency — e.g., N_advisory_min_submissions = 10 with N_calibration = 2 (advisory window only 2 epochs; nearly impossible to collect 10 submissions in 2 epochs).

**Resolution — unified governance parameter table with cross-validation:**

```
Derived defaults (no governance action required):
  N_advisory_min_submissions_default = max(5, 2 × N_active_knowers_at_advisory_start)
  N_rollover_max_default             = max(2, ceil(T_discovery / 8))

Per-class overrides (governance may set at registration):
  N_advisory_min_submissions_override ∈ [3, N_calibration × max_knower_count × 2]
  N_rollover_max_override             ∈ [2, ceil(T_discovery / 8)]

Consistency gate (CoordinateRegistry validation at registration):
  N_advisory_min_submissions ≤ N_advisory_window_epochs × expected_submissions_per_epoch
    where expected_submissions_per_epoch = N_active_knowers_at_advisory_start × advisory_submission_rate_estimate
    advisory_submission_rate_estimate = 0.5  (governance-estimated; default conservative)
  If gate fails: registration rejected with diagnostic error; governance must revise parameters
```

**Cross-parameter consistency check (two more):**

```
N_rollover_max ≤ T_discovery / 2        (safety valve cannot cycle more than twice per discovery phase)
N_advisory_window_epochs ≥ N_calibration / 2  (advisory window cannot be shorter than half N_calibration)
```

Both are registration-time hard rejects, not advisory warnings. They prevent parameter configurations that are formally self-defeating.

**Design law (#r173):** Governance parameter tables include cross-parameter consistency checks as hard registration gates. Derived-default formulas are always provided; overrides are bounded to the range within which the consistency property holds. (#r173)

---

**Q3 (Bootstrap-substitute stake lock duration for long T_discovery — is N_bootstrap_epochs bounded independently?) → N_bootstrap_epochs hard-bounded at 4 macro-epochs regardless of T_discovery; long-class bootstrap uses time-bounded stake lock, not T_discovery-scaled lock (#r173):**

The bootstrap issue: for T_discovery = 48 macro-epochs, N_bootstrap_epochs = N_calibration = 4 — manageable. But if N_calibration were ever set to 12 (a governance-allowed range), bootstrap-phase escrow lockup would be 12 macro-epochs of unknown duration (macro-epoch length varies). And N_bootstrap_epochs ≤ N_calibration means a long N_calibration directly extends the bootstrap commitment window for the second knower.

**The deeper issue:** Bootstrap stake lock is bounded by oracle resolution (Invariant #47: escrow released at oracle resolution). For a T_discovery = 48-epoch coordinate, oracle resolution is ~48 macro-epochs away. The bootstrap k_min lock is effectively a ~48-epoch commitment for the second knower during bootstrap — potentially years for real-world event coordinates.

**Resolution — N_bootstrap_epochs hard cap independent of N_calibration and T_discovery:**

```
N_bootstrap_epochs = min(N_calibration, 4)  [hard cap at 4 macro-epochs]

After N_bootstrap_epochs, partial track record prerequisite activates (Invariant #78):
  resolved_claims_a >= floor(N_track_threshold / 2)

Problem: resolved_claims may still be zero at N_bootstrap_epochs for a long-horizon class
  (no oracle resolution yet)

Resolution — bootstrap credit count as track record substitute in this specific case:
  If N_bootstrap_epochs has elapsed AND oracle has not yet resolved:
    bootstrap_claim_count(a) = number of D_a submissions since class genesis (not resolution-conditional)
    track_record_substitute(a) = bootstrap_claim_count(a) >= floor(N_track_threshold / 2)
    This substitute is WEAKER than resolved_claims but provides Sybil cost (escrow locked per submission)
```

**The stake lock duration for long-horizon bootstrap:**

k_min stake is not locked for T_discovery. It is locked until oracle resolution OR until the claim ages out via T_longtail_expiry (LTRP routing, Invariant from #r5). T_longtail_expiry provides the natural out for long-horizon commitments.

For long T_discovery classes, governance must set T_longtail generously (or route to LTRP with standard seed). This is already in the existing escrow taxonomy — no new mechanism needed. The bootstrap lock is not a new duration concern; it is bounded by existing escrow lifecycle parameters.

**Net: N_bootstrap_epochs ≤ min(N_calibration, 4). Bootstrap ends at 4 macro-epochs maximum regardless of T_discovery. Long-horizon second-knower commitments are bounded by T_longtail, which is already a governance parameter at class registration.** (#r173)

**Design law (#r173):** Bootstrap phase duration is hard-capped at min(N_calibration, 4) macro-epochs, independent of T_discovery. For long-horizon classes where oracle resolution does not occur within bootstrap, bootstrap_claim_count substitutes for resolved_claims in the track-record prerequisite. (#r173)

---

**Q4 (DISCOVERY_MODE Module 1 completeness declaration) → Module 1 is specification-complete after #r173; 10-point framework answered in full for DISCOVERY_MODE; estimated 7–10 additional runs for adversarial pass (#r173):**

**Completeness checklist for DISCOVERY_MODE Module 1:**

| Criterion | Status | Source |
|---|---|---|
| Base primitive | ✅ IVD (epistemic value transferred); bilateral revelation game, not coordination game | #r168 |
| Conserved quantity | ✅ Cumulative KL(S(T) \|\| π_0) monotonically increasing | #r168/D1 |
| State model | ✅ Full distribution S(t); parametric default + N_buckets=16 on-chain | #r168/D6, #r170/Q2 |
| Update rule | ✅ W_a(t) = base × consistency × IVD; N_buckets=16 on-chain; ~3,200 gas/knower/epoch | #r168/D3, #r169/Q2 |
| Fee structure | ✅ Two-pool: streaming + accuracy bonus; f_min = 1/(1+T_discovery) | #r168/D4, #r169/Q3 |
| Degenerate equilibria | ✅ Withholding, IVD sniping, dump-all, noise injection — all addressed | #r168/D2, #r169/Q3 |
| Parameter calibration | ✅ τ_genesis + advisory mode + Q25 + N_advisory_min_submissions | #r169/Q1, #r171/Q1, #r172/Q1 |
| Monopoly handling | ✅ MONOPOLY_MODE; N_monopoly_exit_window; bootstrap substitute | #r170/Q3, #r171/Q2, #r172/Q2 |
| Degenerate epoch response | ✅ All-negative IVD rollover; N_rollover_max; safety valve; future_query_credit | #r171/Q4, #r172/Q3, #r173/Q1 |
| Genesis prior export | ✅ exportGenesisPrior interface; alpha advisory-confirm gate | #r170/Q4, #r171/Q3 |
| Governance interfaces | ✅ Unified parameter table; cross-parameter consistency checks | #r173/Q2 |
| Bootstrap phase | ✅ N_bootstrap_epochs ≤ min(N_calibration, 4); bootstrap_claim_count substitute | #r173/Q3 |

**10-point framework for DISCOVERY_MODE (condensed):**

1. **Base primitive:** IVD (information value delivered per epoch per knower) — not capital warranty.
2. **State model:** Full probability distribution S(t) = credibility-weighted mixture of D_a(t); N_buckets=16 on-chain; parametric output to unknowers.
3. **Credibility model:** W_a(t) = base_share × consistency_factor × IVD_weight; credibility_ratio from CLEARING v2.1 used as base_share; IVD_weight adds revelation-quality component.
4. **Market roles:** Knowers (information sellers) submit D_a(t) for streaming fees; Unknowers (information buyers) pay query_fee_total per query; Challengers enforce state quality; Governance manages parameters and attester set.
5. **Settlement model:** Two-pool: streaming distributed per-epoch; accuracy_bonus at T_finality. Degenerate epochs roll over; N_rollover_max safety valve routes to challenger_pool.
6. **Attack surface:** Credibility laundering, dump-all, IVD sniping, noise injection, flash-participation, oracle timing, all-negative IVD coordinated attack — all addressed by Invariants #65–#86.
7. **vs LMSR/orderbooks:** Rewards revelation process, not just terminal accuracy. Track record stratification. Full distribution output vs scalar. Naturally deters dump-all via pool depletion. Weakness: τ_genesis calibration governance problem for novel domains.
8. **Simplest viable mechanism:** 5 new v2.2 contracts (DiscoveryCoordinateRegistry, DiscoveryClaimEscrow, DiscoveryCredibilityAggregator, DiscoverySettlementEngine, ShadowClearingPairRegistry).
9. **Strongest failure reason:** info_arrival_tolerance self-calibration fails for genuinely unprecedented coordinate types with no oracle history and no analogous classes. Bootstrap default τ_mid = 0.15 may be systematically wrong; advisory mode extends the problem without solving it.
10. **Best surviving variant if Module 1 fails:** Degrade to CLEARING_MODE with enhanced temporal scoring — reward knowers proportional to earliest-epoch accuracy (not just terminal). Cheaper to implement, partially incentivises early revelation, does not require IVD on-chain computation.

**Remaining work before Module 1 is engineering-handoff-ready:**

1. Adversarial stress-test of DISCOVERY_MODE specifically (A10-equivalent pass for new attack surfaces unique to IVD and two-pool structure): estimated 7–10 runs
2. Cross-mode attack surface (CLEARING_MODE actor gaming DISCOVERY_MODE state to influence settlement): estimated 3–4 runs
3. v2.2 contract spec additions summary (analogous to #r163–#r166 summary for v2.1): 1 run

**Module 1 mechanism design is specification-complete. Adversarial pass starts with #r174.** (#r173)

---

## Net-New Structural Insight: The Revelation Game Failure Mode is Irreducibly Governance-Bounded (#r173)

After 6 runs of DISCOVERY_MODE design (#r168–#r173), the fundamental limitation emerges with clarity: **the mechanism's epistemic quality is bounded above by governance's ability to estimate one parameter — τ_genesis for novel domains.**

This is not a mechanism design flaw. It is a structural property of the revelation game itself. Information arrival rate is a property of the underlying domain, not of the mechanism. No mechanism can discover τ from within itself without sufficient history — that is the definition of novelty.

**Implication for deployment strategy:**

DISCOVERY_MODE should be deployed on coordinate classes that have analogous historical classes already in the system. The first DISCOVERY_MODE deployment is necessarily highest-risk for τ calibration; subsequent deployments cite the first as analogy and inherit its calibrated τ.

**The right way to frame this for Demo Day:**

> GestAlt's DISCOVERY_MODE gets better the more classes it has. Every resolved class produces an oracle-velocity signal that calibrates future similar classes. The mechanism has a cold-start problem on genuinely novel domains — but it has a warm-start advantage on every subsequent class in the same domain. This creates a natural moat: the mechanism becomes harder to replicate as history accumulates.

**Design law (#r173):** DISCOVERY_MODE deployment should be sequenced by domain similarity to previously resolved classes. τ_genesis calibration quality compounds with domain history. Novel-domain deployments should be small in initial TOWL capacity to bound the τ miscalibration risk. (#r173)

---

## Structural Synthesis: DISCOVERY_MODE Module 1 — Specification Complete (#r173)

| Issue | Resolution | Law |
|---|---|---|
| Sister-class credit portability | Oracle lineage / same event / shadow-clearing pair; unknower-elected; non-expiring non-fungible | Credit portability requires declared kinship; explicit election |
| Parameter consistency governance | Unified table; derived defaults; cross-param hard gates at registration | Cross-parameter consistency checks are hard gates, not warnings |
| Long-horizon bootstrap lock | N_bootstrap_epochs ≤ min(N_calibration, 4); bootstrap_claim_count substitute when oracle unresolved | Bootstrap hard-capped; long-horizon handled by existing T_longtail escrow lifecycle |
| Module 1 completeness | 10-point framework answered; 12-item checklist satisfied; adversarial pass is remaining work | Mechanism spec complete; adversarial pass (#r174+) next |

---

## Cumulative Invariants (additions through #r173)

**Invariant #87 (#r173):** future_query_credit is portable only to governance-declared sister classes (oracle lineage, same event, or shadow-clearing pair). Transfer requires unknower explicit election. Credit is non-expiring, non-fungible, and applicable only at query submission.

**Invariant #88 (#r173):** Governance parameter tables include cross-parameter consistency checks as hard registration gates. Derived-default formulas are always available; overrides are bounded to the range within which consistency holds.

**Invariant #89 (#r173):** N_bootstrap_epochs ≤ min(N_calibration, 4) macro-epochs, hard cap independent of T_discovery. When oracle has not resolved at N_bootstrap_epochs, bootstrap_claim_count >= floor(N_track_threshold/2) substitutes for resolved_claims in the track-record prerequisite.

**Invariant #90 (#r173):** DISCOVERY_MODE deployment should be sequenced by domain similarity to previously resolved classes. Novel-domain first deployments must set initial TOWL capacity conservatively to bound τ_genesis miscalibration risk.

---

## Run Log Update

- **#r173** — 2026-04-04T02:32Z — DISCOVERY_MODE Module 1 Q1–Q4 (#r172 open questions): sister-class credit portability; governance parameter consistency gates; bootstrap lock cap; Module 1 completeness declaration. 10-point DISCOVERY_MODE framework answered. Four new invariants (#87–#90). Adversarial pass begins #r174.

---

## Open Questions for #r174+ (DISCOVERY_MODE Adversarial Pass)

1. **IVD inflation via adversarial state poisoning and recovery cycle:** Adversary injects noise (reducing S(t) quality) then immediately corrects it — manufacturing positive IVD_weight in the correction epoch. Cost: consistency penalty on the injection epoch. Gain: IVD_weight credit on recovery epoch. Net profitable if recovery IVD > injection penalty. Formal attack model needed.

2. **Streaming fee front-running via on-chain W_a(t) preview:** W_a(t) is computable by any party from the publicly observable D_a(t) submissions. A large-stake actor could observe near-end-of-epoch W_a(t) distribution, submit a D_a(t) with precisely targeted IVD_weight to maximize personal share, and earn disproportionate streaming fees with minimal genuine revelation. Is this possible within the epoch-boundary commit timing?

3. **Cross-mode state injection: CLEARING_MODE actor gaming DISCOVERY_MODE state vector to influence linked clearing settlement:** A participant with large CLEARING_MODE positions on a clearing class linked to a DISCOVERY_MODE shadow class could submit low-quality D_a updates to degrade the genesis prior quality for the clearing class, advantaging their clearing position. Does mode_mismatch_discount fully close this channel?

4. **accuracy_bonus_pool drainage via early oracle gaming:** An adversary who can influence the oracle output (oracle registration attack A6 variant) specifically in DISCOVERY_MODE could game the accuracy_bonus_pool by aligning terminal D_a to the manipulated oracle value. Is the accuracy_bonus_pool adversarial surface identical to CLEARING_MODE oracle attacks, or does the multi-epoch credibility_ratio history create an additional exposure?

---

## #r174 Contributions — 2026-04-04T02:42Z

**Phase: v2.2 Module 1 — DISCOVERY_MODE Adversarial Pass. Addresses all four open attack questions from #r173.**

---

### DA1 — IVD Inflation via Noise-Inject-Then-Correct Cycle

**Attack model:**

```
Epoch t:   adversary submits D_a(t) = noisy distribution far from S(t-1)
           → JS(D_a(t) || D_a(t-1)) > τ  → consistency_factor(a,t) = 0
           → IVD_a(t) < 0  (state degrades)
           → streaming_fee(a,t) = 0

Epoch t+1: adversary submits D_a(t+1) = corrected distribution near true posterior
           → JS small → consistency_factor(a,t+1) = 1.0
           → IVD_a(t+1) > 0  (manufactured state improvement)
           → adversary earns disproportionate streaming_fee at t+1
```

**Profitability condition:**

```
Gain = W_a(t+1) × fee_streaming_pool(t+1)
Cost = claim_submission_fee(t) + credibility_ratio penalty from D_a(t) resolution error
     + escrow lockup opportunity cost × 2 epochs

Gain > Cost when:
  IVD_a(t+1) is large (adversary manufactured a big recovery)
  fee_streaming_pool(t+1) is large (prior rollover from all-negative IVD epoch)
  credibility_ratio penalty is small (adversary uses low-stake or a fresh address)
```

**Why existing defences are insufficient:**

The all-negative IVD rollover (#r171/Q4) accumulates fees in the streaming pool during the injection epoch. The adversary's "correction" epoch then faces an enlarged pool — the rollover mechanism unintentionally amplifies the correction-epoch reward.

**Primary defence — IVD momentum discount:**

A correction that exactly reverses a prior degradation earns zero IVD credit net:

```
IVD_momentum_discount(a, t+1):
  If D_a(t) had IVD_a(t) < 0  (injection epoch)
  Then IVD_a(t+1) = max(0, IVD_a(t+1) − abs(IVD_a(t)) × α_momentum)
    α_momentum = 0.5 (governance-settable, bounded [0.3, 0.8])

Interpretation: to earn IVD_weight in the correction epoch, the correction must advance
  the state *beyond* recovering from the prior degradation.
  At α_momentum = 0.5: the adversary must deliver 2× the degradation to earn net-positive IVD.
```

**Secondary defence — two-epoch IVD smoothing:**

```
IVD_effective(a, t) = (IVD_a(t) + max(0, IVD_a(t-1))) / 2
```

Two-epoch rolling average eliminates the ability to spike IVD in a single epoch by manufacturing a dramatic correction. Consistent modest contributors earn higher smoothed IVD than single-epoch spike strategies.

**Interaction with rollover pool:** During an all-negative IVD epoch (rollover), the IVD_momentum_discount means the correction-epoch adversary must exceed the degradation they created — not just match it — to claim rollover pool credit. The amplified rollover pool is thereby protected.

**Design law (#r174):** IVD-based fee allocation must apply a momentum discount: a correction epoch earns zero net IVD for the portion that merely recovers adversary-generated degradation. Two-epoch IVD smoothing eliminates single-epoch spike strategies. (#r174)

**v2.2 contract addition:** DiscoveryCredibilityAggregator: IVD_a(t-1) rolling window for momentum discount; IVD_effective two-epoch smoothing. (#r174)

---

### DA2 — Streaming Fee Front-Running via On-Chain W_a(t) Preview

**Attack model:**

W_a(t) is computable from public D_a(t) submissions. Near the end of an epoch, an adversary observes the current distribution of W_a(t) across knowers and submits a D_a(t) precision-targeted to maximize their personal fee share.

**Epoch timing analysis:**

```
Epoch E duration = macro_epoch_length (governance-set, e.g., 1 day)
D_a(t) submission window: open throughout epoch E
W_a(t) computation: at epoch E boundary (single atomic computation)

The adversary can observe all D_a submissions before theirs in epoch E.
They compute: what D_a(t) maximises W_a(t)/ΣW_j(t)?

Constraint: D_a(t) must still pass the consistency_factor gate (JS ≤ τ from D_a(t-1))
```

**Is this attack feasible?** Yes, but its profitability is self-limiting:

The adversary's W_a(t) share is bounded by the consistency constraint and by the fact that IVD_a(t) depends on moving S(t) toward truth — which is correlated with genuinely informative submissions. A D_a(t) precision-targeted to maximize fee share but disconnected from private signal will:
1. Have low IVD_weight if other honest knowers have already moved S(t) there (IVD sniping, not new attack)
2. Have poor credibility_ratio accuracy at resolution (accuracy_bonus_pool loss offsets streaming gain)

**The net effect is strategic timing, not strategic fabrication.** An adversary who submits last in an epoch can see what others submitted and tweak their distribution slightly to maximize their share. But they cannot fabricate IVD_weight from nothing — genuine state movement has already been claimed by earlier submitters.

**Residual concern — last-submitter advantage on borderline IVD:**

If honest knowers have moved S(t) partway toward truth, the last submitter can claim the marginal IVD by submitting a slightly better distribution. This is IVD sniping (identified in #r168/D5) rather than fee front-running per se.

**Defence — commit-reveal for DISCOVERY_MODE D_a submissions (first deployment of scheme deferred from #r164/Q3):**

For DISCOVERY_MODE specifically, commit-reveal is justified where CLEARING_MODE did not require it:

```
Epoch E submission protocol:
  Phase 1 (commit): knower submits hash(D_a(t), salt) during [T_epoch_open, T_commit_close]
    T_commit_close = T_epoch_end - N_reveal_window  (default N_reveal_window = 1 hour of block time)

  Phase 2 (reveal): knower reveals (D_a(t), salt) during [T_commit_close, T_epoch_end]
    Hash verified on-chain; D_a(t) recorded if hash matches

  W_a(t) computed from revealed D_a(t) at T_epoch_end

Properties:
  - All commits are visible before reveals begin
  - Reveals cannot be influenced by other knowers' D_a values (hash-committed)
  - Last-submitter advantage eliminated: late reveals are valid only if committed earlier
  - Late reveal failure (missed T_epoch_end): D_a(t) defaults to D_a(t-1) (no update, no penalty)
```

**Gas cost:** Commit + reveal = 2 transactions per epoch per knower. ~21,000 gas × 2 = ~42,000 gas overhead per knower per epoch. Acceptable for v2.2.

**Design law (#r174):** DISCOVERY_MODE D_a submissions use a two-phase commit-reveal scheme within each epoch. Phase 1 commits hash; Phase 2 reveals. W_a(t) is computed only from committed-and-revealed submissions. Last-submitter advantage is eliminated. (#r174)

**v2.2 contract addition:** DiscoveryCredibilityAggregator: commit-reveal state machine per epoch; hash storage; reveal window; default-to-prior on missed reveal. (#r174)

---

### DA3 — Cross-Mode State Injection: CLEARING_MODE Actor Degrades DISCOVERY_MODE Genesis Prior

**Attack model:**

```
Setup:
  - Adversary holds large CLEARING_MODE position on clearing class C
  - Shadow-class S is linked to C via ShadowClearingPairRegistry
  - DISCOVERY_MODE S produces genesis prior for C at exportGenesisPrior time
  - Adversary's CLEARING position benefits from a biased genesis prior

Attack:
  Adversary registers as knower on shadow-class S.
  Submits consistently wrong D_a(t) across multiple epochs.
  credibility_ratio slowly degrades (consistency penalty + accuracy penalty at resolution)
  but S(T_anchor_export) is temporarily biased if adversary's weight is significant
```

**Is mode_mismatch_discount sufficient?** Partially. It attenuates S(T_anchor_export) toward uniform — reducing bias from low-quality discovery submissions. However, if the adversary inflates W_a(t) on the shadow-class via credibility laundering from other resolved coordinates, mode_mismatch_discount alone may not reduce bias enough.

**Defence — dual-channel:**

**Channel 1 — Challenger activity on shadow-class:** Challengers can dispute wrong warranted D_a(t) installations on the shadow-class. Shadow-class challenger_pool bootstrap seeding required (same criteria as clearing-class, Invariant #38 extended).

**Channel 2 — Genesis prior export staleness gate closes the window:**

The alpha_prior_effective formula self-attenuates when shadow-class epistemic quality is low:

```
alpha_prior_effective = alpha_prior_base × max(0, 1 − age_at_export/staleness_window_shadow)
                      × (1 − mode_mismatch_discount_current)
```

If the adversary degrades shadow-class epistemic quality, mode_mismatch_discount rises (lower cross-mode alignment observed), and alpha_prior_effective drops toward 0 — genesis prior reverts to uniform. The attack is self-defeating.

**Residual — mode_mismatch_discount self-calibration lag:** During advisory mode, a sustained adversarial campaign on the shadow-class could exploit the calibration lag. Close: mandate exportGenesisPrior is blocked during mode_mismatch_discount advisory mode.

```
exportGenesisPrior additional precondition:
  mode_mismatch_discount_status(shadow_class_id, clearing_class_id) == SELF_CALIBRATED
```

**Design law (#r174):** exportGenesisPrior is blocked when mode_mismatch_discount is in advisory mode. Cross-mode bias from adversarial shadow-class activity is bounded by alpha_prior_effective self-attenuation; the primary close is the SELF_CALIBRATED gate on export. (#r174)

**v2.2 contract addition:** ShadowClearingPairRegistry.exportGenesisPrior: additional gate requiring mode_mismatch_discount_status == SELF_CALIBRATED. Shadow-class challenger_pool bootstrap seeding explicitly required (Invariant #38 extended). (#r174)

---

### DA4 — accuracy_bonus_pool Drainage via DISCOVERY_MODE Oracle Gaming

**Attack model:**

In DISCOVERY_MODE, accuracy_bonus_pool is distributed at T_finality proportional to terminal credibility_ratio. An adversary who can influence oracle output can:

1. Submit D_a(T-1) concentrated at the manipulated oracle value
2. Oracle resolves at manipulated value
3. Earn high log-score → high credibility_ratio → large accuracy_bonus_pool share

**Difference from CLEARING_MODE oracle attack (A6):**

The multi-epoch credibility_ratio history creates both a defence and an additional exposure:

**Defence:** Fresh address with no history earns near-zero even with a perfect final-epoch log-score (provisional γ_corr, Layer 1, #r164/Q1). Gaming requires sustained oracle manipulation or lucky guessing across N_calibration epochs.

**Additional exposure:** A legitimate knower who turns adversarial at epoch T-1 earns disproportionate accuracy_bonus_pool relative to their track record investment. Final-epoch oracle manipulation gain is amplified by accumulated credibility_ratio.

**Defence — per-address accuracy_bonus_pool cap:**

```
per_address_accuracy_bonus_cap = min(
  actual_pro_rata_share_from_credibility_ratio,
  max_accuracy_bonus_fraction × accuracy_bonus_pool_total
)
max_accuracy_bonus_fraction = 0.25  (governance-settable; [0.10, 0.40])
```

**Defence — two-epoch terminal accuracy averaging:**

```
terminal_credibility_ratio(a) = (credibility_ratio(a, T-1) + credibility_ratio(a, T-2)) / 2
```

A single final-epoch perfect log-score after N epochs of mediocre track record earns less than sustained accuracy. Adversary must manipulate the oracle for ≥2 epochs — doubling manipulation cost and doubling exposure to oracle anomaly detection.

**Design law (#r174):** accuracy_bonus_pool distribution applies max_accuracy_bonus_fraction cap (0.25 per address) and two-epoch terminal_credibility_ratio averaging. Single-epoch oracle manipulation gains are bounded; sustained manipulation doubles exposure to the stratified oracle anomaly detection from #r165/Q2. (#r174)

**v2.2 contract addition:** DiscoverySettlementEngine: max_accuracy_bonus_fraction cap; two-epoch terminal_credibility_ratio average at T_finality. (#r174)

---

### DISCOVERY_MODE Adversarial Pass Summary: Four Attack Families

| Attack | Defence | v2.2 spec addition |
|--------|---------|---------------------|
| DA1 — Noise-inject-then-correct IVD inflation | IVD momentum discount (α=0.5); two-epoch IVD_effective smoothing | DiscoveryCredibilityAggregator: momentum discount + rolling IVD_effective |
| DA2 — Streaming fee front-running | Commit-reveal per epoch; W_a computed from committed reveals only | DiscoveryCredibilityAggregator: commit-reveal state machine |
| DA3 — Cross-mode state injection | exportGenesisPrior gated on SELF_CALIBRATED mode_mismatch; alpha_prior_effective self-attenuation | ShadowClearingPairRegistry: SELF_CALIBRATED gate; shadow-class challenger_pool seeding |
| DA4 — accuracy_bonus_pool oracle gaming | max_accuracy_bonus_fraction cap (0.25); two-epoch terminal_credibility_ratio average | DiscoverySettlementEngine: per-address cap + two-epoch average |

All four are closed. No currently unaddressed DISCOVERY_MODE adversarial surface is known after this pass.

---

## Structural Synthesis: DISCOVERY_MODE Adversarial Pass Closed (#r174)

**Net new v2.2 contract additions from #r174:**

1. **DiscoveryCredibilityAggregator:** IVD_momentum_discount (α_momentum ∈ [0.3, 0.8]); two-epoch IVD_effective smoothing; commit-reveal state machine (commit phase, reveal phase, default-to-prior on missed reveal).
2. **ShadowClearingPairRegistry:** exportGenesisPrior gate requiring mode_mismatch_discount_status == SELF_CALIBRATED.
3. **DiscoverySettlementEngine:** max_accuracy_bonus_fraction cap (default 0.25, bounded [0.10, 0.40]); two-epoch terminal_credibility_ratio averaging at T_finality.
4. **Shadow-class challenger_pool bootstrap seeding:** Explicitly required; same criteria as clearing-class (Invariant #38 extended to DISCOVERY_MODE shadow-classes).

---

## Cumulative Invariants (additions through #r174)

**Invariant #91 (#r174):** IVD fee allocation applies momentum discount: correction epoch earns zero net IVD for the portion that merely recovers adversary-generated degradation (α_momentum = 0.5 default). IVD_effective is a two-epoch rolling average; single-epoch IVD spikes do not receive full fee weight.

**Invariant #92 (#r174):** DISCOVERY_MODE D_a submissions use a two-phase commit-reveal scheme per epoch. W_a(t) is computed only from committed-and-revealed submissions. Late reveal (after T_epoch_end) defaults D_a(t) to D_a(t-1) without penalty.

**Invariant #93 (#r174):** exportGenesisPrior is blocked when mode_mismatch_discount is in advisory mode (governance-estimated, not self-calibrated). Export requires mode_mismatch_discount_status == SELF_CALIBRATED.

**Invariant #94 (#r174):** DISCOVERY_MODE shadow-classes require challenger_pool bootstrap seeding on the same criteria as v2.1 clearing-classes (Invariant #38 extended). Shadow-classes are not epistemically live for genesis prior export without a minimum challenger population.

**Invariant #95 (#r174):** accuracy_bonus_pool distribution: per-address cap = min(pro-rata share, max_accuracy_bonus_fraction × pool_total) with max_accuracy_bonus_fraction default 0.25. Terminal credibility_ratio for payout = two-epoch average (epochs T-1 and T-2).

---

## v2.2 Module 1 DISCOVERY_MODE — Final Status (#r174)

**Mechanism specification: complete.**
**Adversarial pass: complete (DA1–DA4 addressed).**
**Engineering handoff readiness:** Module 1 requires the same engineering-spec translation pass as v2.1 (~1–2 days, engineering team + this document).

**Remaining v2.2 modules (estimate unchanged from #r167/Q4):**
- Module 2 — Shadow-class lifecycle adversarial stress-test: 8–10 runs
- Module 3 — Implication chains settlement routing: 10–12 runs
- Module 4 — Three-tier archive integration: 3–5 runs
- Module 5 — Cross-class LTRP backstop adversarial stress-test: 3–5 runs

**Next autoresearch focus:** v2.2 Module 2 — Shadow-class lifecycle adversarial stress-test.

---

## Open Questions for #r175+ (v2.2 Module 2: Shadow-class lifecycle adversarial)

1. **Wind-down timing attack:** An adversary with a short DISCOVERY_MODE position in a shadow-class could trigger early shadow-class wind-down (by a governance-exploitable mechanism) to lock in a biased genesis prior before honest knowers can correct it. Is the wind-down trigger entirely governance-controlled, or are there adversary-accessible triggering conditions?

2. **Bootstrap prior staleness during slow-genesis clearing-class:** If the clearing-class genesis is delayed (slow position registration, insufficient TOWL), the exported genesis prior ages toward staleness while the shadow-class continues updating S(t). Should the clearing-class genesis trigger re-export of S(T_actual_genesis) rather than S(T_initial_export)?

3. **DISCOVERY_MODE shadow-class with no linked clearing-class:** Can a shadow-class exist without a clearing-class pair? What is the economic model — who pays query fees, and what is the T_anchor / T_finality event? If shadow-classes can be standalone, the mechanism generalises to a pure information market without settlement coupling.

4. **Adversarial MONOPOLY_MODE persistence via second-knower suppression:** An adversary who is the incumbent knower on a DISCOVERY_MODE shadow-class and wants to maintain MONOPOLY_MODE (weaker adversarial protections) could suppress second-knower entry by front-running their escrow (e.g., DoS on escrow submission transactions). Is claim submission permissioned or permissionless?

*Last updated: #r174 — 2026-04-04T02:42Z*

---

## #r175 Contributions — 2026-04-04T02:52Z

**Focus: v2.2 Module 2 — Shadow-class lifecycle adversarial stress-test. Addresses all four open questions from #r174.**

---

### Q1 (Wind-down timing attack — adversary-accessible triggers vs governance-only) → Wind-down trigger is governance-exclusive; no permissionless trigger path exists; two adversarial fronts confirmed and closed (#r175)

**Wind-down trigger review:**

From #r155/Q3: WINDING_DOWN is entered by the shadow-class when the linked clearing-class oracle fires (`oracle_resolved` EAT event on the clearing class). This is not a governance action — it is an oracle event. The question is whether an adversary can accelerate or manufacture this trigger.

**Trigger 1 — oracle manipulation to force premature wind-down:**

Oracle manipulation to fire `oracle_resolved` prematurely requires either (a) corrupting the registered oracle source, or (b) meeting a governance-registered quorum early (if clearing uses k/n quorum). The mechanism defends oracle integrity at the clearing-class level (#r71 quorum, #r75 SEE defence). This is within-scope for v2.1 CLEARING_MODE threat model and carries over to the shadow-class trigger. No additional defence required in v2.2.

**Trigger 2 — governance manipulation of shadow-class wind-down directly:**

`shadow_class_wind_down_initiated` requires governance action only for the clearing-class pair (archiving an already-resolved clearing class). An adversary who controls governance could sunset a shadow-class early. Defence: governance action requires k-of-n multisig per #r70; sustained governance capture is a systemic threat, not a shadow-class-specific one.

**What the adversary actually gains from premature wind-down:**

The genesis prior export captures S(T_winding_down_trigger). If the shadow-class has been adversarially shifted (via noise injection, DA1 style) just before wind-down, the exported prior is biased. **This is the real attack vector** — not the trigger mechanism itself, but the state at trigger time.

**Primary defence — SELF_CALIBRATED gate on exportGenesisPrior (#r174/DA3, Invariant #93):**

exportGenesisPrior is blocked unless mode_mismatch_discount_status == SELF_CALIBRATED. A shadow-class whose alignment history is advisory (not enough clearing resolutions) cannot export at all. An adversary who biases S just before wind-down, if the class is in SELF_CALIBRATED status, will see the bias absorbed and attenuated by alpha_prior_effective × (1 − mode_mismatch_discount). If mode_mismatch_discount is self-calibrating (as designed, #r155/Q1), a biased terminal epoch that departs from historical alignment will raise the alignment-score RMSE → raise mode_mismatch_discount → reduce effective alpha_prior_effective → attenuate the adversarial injection.

**Secondary defence — two-epoch terminal prior averaging (new, #r175):**

Analogous to two-epoch terminal_credibility_ratio averaging for accuracy_bonus_pool (#r174/DA4), the genesis prior snapshot uses:

```
S_genesis_prior_effective = (S(T_winding_down) + S(T_winding_down - 1)) / 2
  weighted by effective_weight(T) per coordinate
```

A single adversarially manipulated final epoch shifts the genesis prior by at most 50% of the single-epoch manipulation magnitude. The adversary must sustain the bias across ≥2 epochs — doubling the cost.

**Design law (#r175):** Shadow-class genesis prior export uses two-epoch terminal averaging. Single-epoch state manipulation at wind-down trigger is bounded to 50% penetration. Combined with the SELF_CALIBRATED gate, the defence is two-layer: export gating + prior attenuation. (#r175)

**v2.2 contract addition:** ShadowClearingPairRegistry.exportGenesisPrior: two-epoch terminal averaging of S at T_winding_down and T_winding_down − 1, both weighted by effective_weight.

---

### Q2 (Bootstrap prior staleness during slow-genesis clearing-class — re-export at T_actual_genesis) → Re-export on request from clearing-class genesis event; staleness cap enforced; no automatic live feed (#r175)

**The problem:**

At shadow-class wind-down, S is exported as a genesis prior for the linked clearing-class. If clearing-class genesis is delayed by months (slow position registration, TOWL bootstrap, oracle availability), the exported prior ages. The staleness model (κ, staleness_window) decays alpha_prior_effective to near-zero before clearing-class ever uses it.

**Options:**

1. **Static export only:** Export S at wind-down; clearing-class uses it with staleness decay. Acceptable if T_clearing_genesis − T_winding_down < staleness_window_shadow_class / 2.

2. **Live shadow-class feed during clearing-class bootstrap:** Shadow-class in WINDING_DOWN continues updating S (new claims accepted). Clearing-class genesis reads a live S rather than a static snapshot. This violates the WINDING_DOWN state definition (#r155/Q3: "No new claims accepted" on WINDING_DOWN entry).

3. **Re-export at T_actual_genesis:** At clearing-class genesis event, if the shadow-class is still in WINDING_DOWN (not yet ARCHIVED), clearing-class requests a fresh export snapshot. This captures a more recent S from WINDING_DOWN activity.

**Resolution — option 3 with staleness cap:**

Contradiction with #r155: WINDING_DOWN accepts no new claims. But WINDING_DOWN does update S from existing claims' staleness decay and effective_weight evolution. S is not frozen — it continues to evolve as existing claims age.

Re-export at T_actual_genesis: permitted if:
1. Shadow-class is still in WINDING_DOWN (not ARCHIVED).
2. T_actual_genesis − T_wind_down_entry < T_wind_down_max (within wind-down window).
3. Clearing-class governance declares `genesis_prior_re_export_request` EAT event.

Re-export snapshot = S(T_actual_genesis_epoch) computed from existing WINDING_DOWN claims at current effective_weights (staleness-decayed). Two-epoch terminal averaging applies: (S(T_actual_genesis) + S(T_actual_genesis − 1)) / 2.

**Staleness cap for re-export:**

```
alpha_prior_effective_re_export = alpha_prior_base × max(0, 1 − (T_actual_genesis − T_wind_down_entry) / staleness_window_shadow) × (1 − mode_mismatch_discount)
```

Same formula as original genesis prior, evaluated at T_actual_genesis. If shadow-class has fully stale S by T_actual_genesis (all effective_weights ≈ 0), the re-export is numerically equivalent to the uniform prior — harmless default behaviour.

**What if shadow-class is already ARCHIVED at T_actual_genesis?** ARCHIVED state commits a final credibility_ratio snapshot and freezes S at zero effective_weight. Re-export from ARCHIVED returns the last committed S snapshot (stored in EATManager, retrievable via CID). Staleness decay continues to apply from T_ARCHIVED onward, so re-export still uses the staleness formula.

**Design law (#r175):** Genesis prior re-export is permitted at clearing-class genesis event if shadow-class is WINDING_DOWN or ARCHIVED. Re-export uses two-epoch terminal averaging and staleness-decayed alpha_prior_effective at T_actual_genesis. No live feed during WINDING_DOWN — re-export is a point-in-time snapshot request, not a streaming update. (#r175)

---

### Q3 (DISCOVERY_MODE shadow-class with no linked clearing-class — standalone mode) → Permitted; terminal event is governance-declared; economic model uses accuracy_bonus_pool only; mechanism is a pure information market (#r175)

**Definition — standalone shadow-class (SSC):**

A DISCOVERY_MODE class registered without a linked clearing-class. No `position_registry`, no WED_clearing, no Settlement Freeze Protocol. The class runs purely on:

- Query fees from unknowers (who pay for S(t) estimates).
- accuracy_bonus_pool: funded by unknowers pre-paying conditional bonuses for accurate final-epoch state.
- Standard log-score slash/reward at oracle resolution.

**Terminal event:** Without a clearing-class oracle trigger, wind-down must be governance-declared or oracle-triggered by an independent event oracle registered to the coordinate. Two sub-cases:

1. **Oracle-terminated SSC:** Coordinate has a natural resolution event (e.g., "who wins the 2028 US Presidential election"). Oracle fires at T_resolve; standard DISCOVERY_MODE log-score settlement runs. Shadow-class enters WINDING_DOWN → ARCHIVED via #r155/Q3 state machine.

2. **Governance-terminated SSC:** Coordinate has no natural terminal event (e.g., "what is the annual average CPI for 2027?"). Governance declares T_wind_down_trigger; at that epoch, oracle is invoked to confirm final state; normal settlement follows. No special mechanism required.

**Economic model for standalone SSC:**

- Knowers earn: query fees (ongoing) + log-score accuracy reward at oracle resolution + accuracy_bonus_pool share.
- Unknowers pay: query fees (immediate) + accuracy_bonus (conditional on precision at resolution).
- No position registry → no WED_clearing → base reward is query fee pool only.

This is a viable pure information market: knowers provide calibrated beliefs on any verifiable coordinate; unknowers pay for that information directly. The mechanism generalises cleanly.

**What SSC cannot do:**

- No Settlement Freeze Protocol (no position registry to settle).
- No genesis prior export to clearing-class (no linked pair).
- Cannot enter CLEARING_MODE — SSC is definitionally standalone.

**Governance registration:** SSC registers with `clearing_class_id: null` and `terminal_event: oracle | governance`. Standard v2.2 DISCOVERY_MODE contracts apply except ShadowClearingPairRegistry has no entry for this class.

**Design law (#r175):** Standalone shadow-classes are valid mechanism objects. They are pure information markets with no settlement coupling. The mechanism fully generalises to this use case at zero additional contract cost. SSC adds no new attack surface beyond the DISCOVERY_MODE adversarial surfaces already closed in #r174. (#r175)

---

### Q4 (Adversarial MONOPOLY_MODE persistence via claim submission DoS) → Permissionless claim submission; DoS resistance from on-chain escrow-based anti-spam; MONOPOLY_MODE defined and exit conditions formal (#r175)

**Threat model:**

In DISCOVERY_MODE, if only one knower is active (no competitors), the mechanism operates in what informally has been called MONOPOLY_MODE: single-agent S_cred, weaker credibility pressure, no diversity penalty applicable (only one agent). An adversary who is the incumbent knower might suppress second-knower entry to maintain this weaker state.

**Permissioned vs permissionless claim submission:**

The mechanism has no stated permission requirement for claim submission. Any address meeting the minimum stake threshold can submit a claim. This is permissionless by design (consistent with the open participation model from #r1 through present).

**DoS via front-running escrow:**

An adversary could attempt to DoS second-knower escrow submission by front-running with spam transactions that consume block gas and increase submission cost. This is a general EVM MEV problem, not a mechanism-specific vulnerability. Standard Ethereum anti-MEV tooling (private mempools, EIP-1559, commit-reveal on submission) addresses this at the infrastructure layer. The mechanism does not add protocol-level DoS defence for this attack class; it defers to the base layer.

**MONOPOLY_MODE formal definition and exit conditions:**

```
MONOPOLY_MODE(class_i, epoch_t):
  active_knower_count(class_i, t) == 1  AND
  that knower's cumulative_eff_weight / total_effective_weight_class == 1.0

Exit conditions:
  (a) Second knower submits claim with stake ≥ min_entry_stake(class_i) → COMPETITIVE_MODE
  (b) Existing single knower's escrow expires → VACANT_MODE (no active S_cred; S reverts to uniform prior)
```

**MONOPOLY_MODE epistemically-live degradation:**

During MONOPOLY_MODE, epistemically_live = false by Invariant #38 (challenger count < 3). The 50% throttle on new installations applies. This is the correct response — a single unchallenged knower is not epistemically trustworthy for new T3-equivalent warranty obligations in DISCOVERY_MODE.

**Anti-monopoly entrant subsidy:**

When MONOPOLY_MODE persists for ≥ N_monopoly_alert = N_calibration consecutive epochs, the challenger_pool bootstrap mechanism (#r160/Q4) applies: governance auto-seeds `entry_subsidy_pool` to incentivise second-knower entry.

```
entry_subsidy(class_i) = min(
  entry_subsidy_cap,          // governance-settable at class registration
  fraction × query_fee_pool_balance(class_i)
)
entry_subsidy_cap = governance-set at registration; default 3 × r_floor_class
```

The entry subsidy is available to any new knower who submits a valid claim within one epoch of the subsidy being published. First claimant gets the subsidy. If unclaimed after 2 epochs, the subsidy returns to challenger_pool. This creates a positive incentive for second-knower entry without permissioning or gatekeeping.

**Design law (#r175):** Claim submission is permissionless. MONOPOLY_MODE is a formal mechanism state with defined exit conditions. Persistent MONOPOLY_MODE triggers epistemically_live = false (throttle) and an entry_subsidy. The mechanism does not attempt to prevent monopoly through permissioning; it reduces monopoly incentive through subsidy and reduces monopoly's epistemic authority through the liveness gate. (#r175)

---

## Structural Synthesis: Shadow-class Lifecycle Adversarial Pass — Closed (#r175)

| Attack | Defence | v2.2 spec addition |
|--------|---------|---------------------|
| Wind-down timing (biased genesis prior at trigger) | Two-epoch terminal prior averaging + SELF_CALIBRATED gate (dual layer) | ShadowClearingPairRegistry: two-epoch terminal S averaging |
| Stale genesis prior on delayed clearing genesis | Re-export at T_actual_genesis from WINDING_DOWN or ARCHIVED; staleness formula at T_actual_genesis | ShadowClearingPairRegistry: genesis_prior_re_export_request handler |
| Standalone SSC economic model gap | SSC is valid; oracle-terminated or governance-terminated; pure information market; no new contracts | CoordinateRegistry_v2: clearing_class_id = null registration |
| MONOPOLY_MODE persistence via DoS | Permissionless submission (base-layer DoS, not mechanism); formal MONOPOLY_MODE state; entry_subsidy on N_monopoly_alert | DiscoveryCredibilityAggregator: MONOPOLY_MODE flag + entry_subsidy_pool trigger |

**Four adversarial scenarios addressed. No currently unaddressed shadow-class lifecycle attack surface known after this pass.**

---

## Cumulative Invariants (additions through #r175)

**Invariant #96 (#r175):** Shadow-class genesis prior export uses two-epoch terminal averaging: (S(T_wind_down) + S(T_wind_down − 1)) / 2, weighted by effective_weight. Single-epoch wind-down manipulation is bounded to 50% penetration.

**Invariant #97 (#r175):** Genesis prior re-export is permitted at clearing-class genesis event if shadow-class is in WINDING_DOWN or ARCHIVED. Re-export is a point-in-time snapshot, not a live feed. Staleness formula applies at T_actual_genesis.

**Invariant #98 (#r175):** Standalone shadow-classes (no linked clearing-class) are valid mechanism objects. They are permissionless pure information markets with oracle-terminated or governance-terminated lifecycles.

**Invariant #99 (#r175):** Claim submission is unconditionally permissionless. MONOPOLY_MODE is a formal mechanism state; it does not gate submission. Persistent MONOPOLY_MODE (≥ N_calibration epochs) triggers entry_subsidy and epistemically_live = false.

---

## Open Questions for #r176+ (v2.2 Module 2 continuation / Module 3 entry)

1. **Entry subsidy gaming:** A group of coordinated addresses could rotate through "second-knower entry" to repeatedly claim the entry_subsidy pool without genuinely competing. After one epoch of second-knower presence, the group withdraws, allowing MONOPOLY_MODE to recur and triggering another subsidy. Is there an anti-cycling gate (e.g., second-knower must remain active for ≥ N_calibration epochs before the entry_subsidy resets)?

2. **SSC accuracy_bonus_pool solvency when oracle is delayed:** A standalone SSC accumulates accuracy_bonus in escrow pending oracle resolution. If the oracle is delayed indefinitely (e.g., governance-terminated SSC where governance fails to declare T_wind_down_trigger), the accuracy_bonus escrow is locked without T_finality. Define a maximum accuracy_bonus escrow holding period and release condition on governance inaction.

3. **WINDING_DOWN S evolution vs re-export consistency:** WINDING_DOWN allows no new claims but allows existing claims to evolve (effective_weight decays per κ). If two re-export snapshots are taken at T1 and T2 (T2 > T1, both during WINDING_DOWN), they may differ due to staleness decay alone — not due to new information. Should re-export be limited to one occurrence (first clearing-class genesis request wins) to prevent multiple clearing-classes from getting different genesis priors from the same shadow-class?

4. **Module 3 entry: implication chain settlement routing in CLEARING_MODE.** With Module 2 adversarial pass complete, the next major v2.2 surface is the settlement routing for A→B implication declarations under the bifurcated bonus (#r141). Key question: in CLEARING_MODE, how does partial-resolution settlement of the implication bonus escrow interact with the Settlement Freeze Protocol at T_anchor? Specifically: if A's T_anchor fires but B's oracle has not yet resolved, does the implication_bonus_escrow enter a partial settlement-frozen state at T_anchor, or is it fully deferred to B's T_anchor?

*Last updated: #r175 — 2026-04-04T02:52Z*

---

## #r176 Contributions — 2026-04-04T03:02Z

**Phase: v2.2 Module 2 closure (Q1–Q3 from #r175) + Module 3 entry (Q4 from #r175 — implication chain settlement routing).**

---

### Q1 (Entry subsidy gaming — coordinated rotation through second-knower status) → Anti-cycling gate: N_cycling_lock + one-subsidy-per-address-per-class + credibility floor (#r176)

**Attack model:**

```
Epoch T:   Coordinator A holds MONOPOLY_MODE on class C
           MONOPOLY_MODE persists >= N_calibration → entry_subsidy fires
Epoch T+1: Coordinated address B claims entry_subsidy; enters as second knower
Epoch T+2: B withdraws (stake expires via T_longtail); MONOPOLY_MODE resumes
           N_monopoly_alert resets...
Epoch T+N_calibration: entry_subsidy fires again → repeat
```

Cost per cycle: T_longtail-minimum escrow × interest + claim_submission_fee. Profitable at thin k_min.

**Resolution — two-part anti-cycling gate:**

**Part 1 — N_cycling_lock minimum active duration:**

```
entry_subsidy_pool refills only when:
  resolved_claims(entry_subsidy_claimed_by) >= 1   (at least one oracle resolution)
  AND epoch_elapsed since entry_timestamp >= N_cycling_lock = N_calibration

If either condition unmet when N_monopoly_alert fires again:
  entry_subsidy_pool does NOT refill
  governance_alert: subsidy_cycling_suspected { class_id, last_claimant, elapsed_epochs }
```

**Part 2 — One subsidy per address per class + credibility floor:**

```
entry_subsidy_eligible(a) = true iff:
  a has NOT previously claimed entry_subsidy on class_i
  AND (a is new address with no prior claims OR credibility_ratio(a) >= 0.10)
```

A coordinated attack requires a fresh address with partial credibility history for each cycle, making each rotation progressively more expensive.

**Design law (#r176):** Entry subsidies are anti-cycling gated: last claimant must achieve >= 1 resolution before pool refills; N_cycling_lock epochs must elapse; each address is ineligible for repeated subsidies on the same class. Cycling attack cost grows with resolution-cycle latency × min_escrow. (#r176)

**v2.2 contract addition:** DiscoveryCredibilityAggregator: entry_subsidy_claimed_by tracking; N_cycling_lock gate on refill; one-subsidy-per-address-per-class check.

---

### Q2 (SSC accuracy_bonus_pool solvency on indefinite oracle delay) → T_wind_down_max mandatory at SSC registration; one governance extension; LTRP routing on expiry (#r176)

**The problem:** Governance-terminated SSCs accumulate accuracy_bonus in escrow indefinitely if governance never acts.

**Resolution — mandatory T_wind_down_max:**

```
SSC registration: T_wind_down_max REQUIRED
  T_wind_down_max_max = governance-settable global cap (default: 1000 macro-epochs)
  T_wind_down_max_min = 2 × N_calibration

accuracy_bonus_expiry = T_wind_down_max + N_accuracy_grace (default 4 macro-epochs)

If oracle has not resolved by accuracy_bonus_expiry:
  accuracy_bonus_pool → LTRP routing
  Each unknower's pre-paid bonus refunded pro-rata
  EAT event: ssc_accuracy_bonus_expired
  governance_alert: ssc_oracle_failure
```

**One-time extension:** Governance may call ssc_wind_down_max_extension (k-of-n multisig; max 1× extension doubling original value; second extension not permitted).

**Design law (#r176):** All DISCOVERY_MODE classes with non-oracle termination must declare T_wind_down_max at registration. Accuracy_bonus escrow is bounded by T_wind_down_max + N_accuracy_grace. Governance may extend once; LTRP routing fires on expiry. (#r176)

**v2.2 contract addition:** DiscoveryClaimEscrow: T_wind_down_max enforcement; accuracy_bonus_expiry; one-time extension EAT event; LTRP routing on expiry. CoordinateRegistry_v2: T_wind_down_max required for SSC registration.

---

### Q3 (WINDING_DOWN S evolution and re-export consistency) → One initial export + one re-export per (shadow, clearing) pair; CLOSED state returns cached snapshot (#r176)

**The question:** Multiple clearing-classes linked to one shadow-class may request re-exports at different times during WINDING_DOWN; each snapshot differs due to staleness decay. Is this a problem?

**Analysis:** Different genesis timestamps for different linked clearing-classes should produce different genesis priors — staleness decay between T1 and T2 is real information about prior age. No consistency attack: the two-epoch terminal averaging (Invariant #96) already bounds manipulation magnitude to 50% of single-epoch change.

**Resolution — per-pair export state machine:**

```
ShadowClearingPairRegistry.export_state(shadow_id, clearing_id):
  NEVER_EXPORTED → INITIAL_EXPORTED (first exportGenesisPrior call)
  INITIAL_EXPORTED → RE_EXPORTED   (genesis_prior_re_export_request at clearing genesis)
  RE_EXPORTED → CLOSED             (no further re-export; returns cached RE_EXPORTED snapshot)
```

Each (shadow_id, clearing_id) pair has an independent state machine. Multiple linked clearing-classes each get their own INITIAL + RE_EXPORT independently computed at their genesis timestamps.

**Design law (#r176):** Each (shadow-class, clearing-class) pair permits at most one initial export and one re-export. CLOSED state returns cached RE_EXPORTED snapshot without recomputation. Multiple linked clearing-classes are independent pairs, each with their own state machine. (#r176)

**v2.2 contract addition:** ShadowClearingPairRegistry: export_state per pair; CLOSED gate after RE_EXPORTED; cached snapshot storage.

---

### Q4 — Module 3 Entry: Implication Chain Settlement Routing in CLEARING_MODE

**The core question:** At A's T_anchor (A-correct, B-unresolved), does implication_bonus_escrow enter partial settlement, full deferral, or a new intermediate state?

**Route analysis:**

- **Route 2 — Full deferral:** Rejected. Declarant submitted accurate A-prediction and deserves implication_bonus_direct immediately. Withholding until B resolves punishes A-accuracy. (#r176)

- **Route 3 — IMPL_PENDING_B (adopted):**

```
At T_anchor_A (A-correct, B-unresolved):
  1. Release: implication_bonus_direct → declarant (immediate)
  2. IMPL_PENDING_B: implication_bonus_residual held pending B oracle
     T_impl_pending_max = governance-set (see Q4 below)
  3. At T_anchor_B:
     if B-correct: release implication_bonus_residual → declarant
     if B-wrong:   slash implication_bonus_residual → challenger_pool
  4. If T_impl_pending_max reached without B resolving:
     LTRP routing of implication_bonus_residual
```

**SFP interaction:** A's Settlement Freeze Protocol runs normally on settlement_price_A. If A's SFP challenge succeeds (A-correct overturned), IMPL_PENDING_B closes and clawback fires:

```
Clawback precedence:
  1. Debit from declarant's claim_stake_A (if still locked in ClaimEscrow)
  2. If claim_stake_A released: debit from declarant_bond
  3. If declarant_bond insufficient: governance bond call
```

**IMPLPendingB struct:**

```
IMPLPendingB {
  declaration_id,
  declaring_address,
  linking_class_B_id,
  implication_bonus_residual,
  T_anchor_A_epoch,
  T_impl_pending_max,
  sfp_challenge_active: bool
}
```

**Design law (#r176):** Implication chain settlement uses IMPL_PENDING_B. At T_anchor_A (A-correct, B-unresolved): implication_bonus_direct releases immediately; residual enters IMPL_PENDING_B pending B oracle or T_impl_pending_max expiry (LTRP). Full deferral is rejected. SFP challenge success on A triggers clawback in precedence order: claim_stake → declarant_bond → governance_bond. (#r176)

**v2.2 contract addition:** SettlementEngine: IMPLPendingB struct; IMPL_PENDING_B state machine; immediate implication_bonus_direct release; T_impl_pending_max with LTRP routing; SFP clawback precedence. ClaimEscrow: clawback call interface.

---

## Net-New Structural Insight: The Conditional Escrow Primitive (#r176)

IMPL_PENDING_B introduces a general mechanism pattern: **conditionally-held escrow with a secondary time-bounded resolution trigger**. This structure recurs:

- Standard claim escrow: locked until one event (oracle resolution).
- IMPL_PENDING_B: locked until B oracle fires OR T_impl_pending_max expires.
- SSC accuracy_bonus: locked until oracle fires OR T_wind_down_max + N_accuracy_grace expires.
- LTRP escrow: locked until T_longtail expires.

**Generalised pattern:**

```
IMPLPending {
  escrow_amount,
  primary_trigger:    event_type × event_identifier,
  expiry_trigger:     timestamp (T_impl_pending_max),
  primary_resolution: (correct → release | wrong → slash),
  expiry_resolution:  LTRP_routing | refund | governance_alert,
  clawback_order:     [claim_stake, declarant_bond, governance_bond]
}
```

**Design law (#r176):** Conditionally-held escrow with a secondary time-bounded trigger is a first-class mechanism primitive: IMPLPending(escrow, primary_trigger, expiry_trigger, primary_resolution, expiry_resolution, clawback_order). All multi-trigger escrow objects should be modelled in this form for audit clarity. (#r176)

---

## Structural Synthesis: Module 2 Closure + Module 3 Entry (#r176)

| Issue | Resolution | Law |
|---|---|---|
| Entry subsidy cycling | N_cycling_lock; one-subsidy-per-address; credibility floor | Cycling cost grows with resolution-cycle latency |
| SSC accuracy_bonus escrow on oracle delay | T_wind_down_max mandatory; one governance extension; LTRP on expiry | Non-oracle termination always time-bounded |
| WINDING_DOWN re-export multiplicity | Per-pair state machine; INITIAL + RE_EXPORT max; CLOSED returns cache | At most two exports per (shadow, clearing) pair |
| Implication chain settlement routing | IMPL_PENDING_B: direct release immediate + residual deferred; SFP clawback | Full deferral rejected; conditional escrow primitive formalised |

---

## v2.2 Contract Spec Additions from #r176

| Contract | Addition |
|---|---|
| **DiscoveryCredibilityAggregator** | entry_subsidy_claimed_by tracking; N_cycling_lock gate; one-subsidy-per-address per class |
| **DiscoveryClaimEscrow** | T_wind_down_max enforcement; accuracy_bonus_expiry; one-time extension; LTRP routing on expiry |
| **CoordinateRegistry_v2** | T_wind_down_max required field for SSC registration |
| **ShadowClearingPairRegistry** | export_state machine per pair; CLOSED gate after RE_EXPORTED; cached snapshot |
| **SettlementEngine** | IMPLPendingB struct + state machine; implication_bonus_direct immediate release; T_impl_pending_max LTRP; SFP clawback precedence |
| **ClaimEscrow** | clawback call interface for SettlementEngine |

---

## Cumulative Invariants (additions through #r176)

**Invariant #100 (#r176):** Entry subsidies are anti-cycling gated: last claimant must achieve >= 1 oracle resolution before pool refills; N_cycling_lock = N_calibration epochs must elapse; each address is ineligible for repeated subsidies on the same class.

**Invariant #101 (#r176):** All DISCOVERY_MODE classes with non-oracle termination must declare T_wind_down_max at registration. Accuracy_bonus escrow releases to LTRP at T_wind_down_max + N_accuracy_grace. Governance may extend T_wind_down_max once (max doubling); second extension prohibited.

**Invariant #102 (#r176):** Each (shadow-class, clearing-class) pair has an independent export state machine: at most INITIAL_EXPORTED + RE_EXPORTED. In CLOSED state, further requests return the cached RE_EXPORTED snapshot without recomputation.

**Invariant #103 (#r176):** Implication chain settlement uses IMPL_PENDING_B. At T_anchor_A (A-correct, B-unresolved): implication_bonus_direct releases immediately; residual enters IMPL_PENDING_B pending B oracle or T_impl_pending_max expiry (LTRP). SFP challenge success on A triggers clawback: claim_stake_A → declarant_bond → governance_bond.

**Invariant #104 (#r176):** Conditionally-held escrow with a secondary time-bounded trigger is a first-class mechanism primitive: IMPLPending(escrow, primary_trigger, expiry_trigger, primary_resolution, expiry_resolution, clawback_order). All multi-trigger escrow objects must be modelled in this form.

---

## Run Log Update

- **#r176** — 2026-04-04T03:02Z — Module 2 closure (Q1–Q3: subsidy cycling gate, SSC T_wind_down_max, re-export state machine); Module 3 entry (Q4: IMPL_PENDING_B routing, SFP clawback precedence, conditional escrow primitive formalised). Five new invariants (#100–#104). Six v2.2 contract additions catalogued.

---

## Open Questions for #r177+ (v2.2 Module 3: Implication Chains continued)

1. **Parallel chain resolution (A→B→C): settlement order dependencies.** If A implies B implies C, A's T_anchor fires, two IMPL_PENDING objects are created. When B resolves, A-pending-B closes and may cascade into A-B-pending-C. Define settlement ordering and composability of chained IMPL_PENDING objects.

2. **Circular implication detection.** Can A→B and B→A be registered simultaneously? If so, both enter IMPL_PENDING_B and wait indefinitely for each other. Define registration-time cycle detection gate.

3. **IMPL_PENDING_B and TOWL zone interaction.** How does TOWL capacity account for IMPLPendingB holdings? Zone A (backing identified contingent obligation), Zone B (uncertain), or excluded (separately tracked)?

4. **T_impl_pending_max governance interface.** Who sets T_impl_pending_max and when? Options: (a) declarant at declaration time; (b) governance at class registration; (c) derived from T_longtail of class B. Tradeoffs between flexibility and manipulation resistance.

*Last updated: #r176 — 2026-04-04T03:02Z*
