# Knowledge Marketplace Mechanism — Aggregate Document

*Auto-maintained by Richard (ValCtrl). Do not edit manually.*

---

## Run Log

- **#r1** — 2026-04-03T04:32Z — Founding entry. Doc was unreadable (no gog auth, browser offline). Full first-principles analysis written from scratch.
- **#r73** — 2026-04-03T07:52Z — Cycle/deadlock elimination (implication declarations are incentive-metadata only); timestamp-tagged staleness discount for cross-epoch-class GestAlt interface; four-layer SEE capture defense; chain-length discount γ^(depth-1) for implication stacking.
- **#r74** — 2026-04-03T08:52Z — Per-class staleness decay shape κ; two-tier SEE appeals (oracle Tier A + sortition Tier B); β range [1.3, 2.0]; SEE pre-staging defense via claim consistency + query fee clawback; Epistemic Audit Trail (EAT) named as fourth integrity property.
- **#r75** — 2026-04-03T09:52Z — EAT DA stack (Celestia + Ethereum anchor); DA liveness as fifth precondition integrity property; degraded mode specification; pre_shock_window principled formula; continuous SEE taper; trustless correlation filter computation; anti-fragmentation gap in β/γ fixed; closed-form β/γ joint calibration with governance redesign.
- **#r132** — 2026-04-03T19:12Z — Multi-class LTRP attribution (per-class independent, no spillover); bridge/degraded epoch exclusion from calibration rolling windows; LTRP over-seed proactive recall (conditional 3× safety × 4-epoch gate); non-additive combined-lockup ceiling for simultaneous provisional+outage tolling; bounded-liability architecture closed.

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
