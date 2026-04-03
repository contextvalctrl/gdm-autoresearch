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

*Last updated: #r150 — 2026-04-03T22:42Z*
