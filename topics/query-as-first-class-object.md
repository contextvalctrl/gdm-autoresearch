# GDM Knowledge Marketplace — Run #r69
**Date:** 2026-04-03 06:22 UTC
**Status:** PENDING doc upload (Google auth unavailable — see blocker note)

---

## #r69 refinement — the query as a first-class object; demand-side structure must be explicit

**Framing problem recovered from prior runs:**
The mechanism has built rich supply-side and coordinate-side structure (precision classes, evidence/interpretation split, semantic lock, anti-desirability blinding, comparative replacement, downgrade paths, redundancy/lineage, transition timing). But the demand side — what a buyer is actually purchasing and under what temporal contract — has been underspecified. This is the first-principles gap #r69 closes.

---

### 1. Base primitive
The prior primitive was: *a warranted update* (a seller's commitment to maintain a coordinate value under liability). That is the supply primitive.

**The missing dual:** the buyer's primitive is a *query contract* — a specification of:
- **scope**: which coordinate(s), which precision class, which schema version
- **temporal mode**: one-shot snapshot OR standing maintenance subscription OR event-triggered delivery
- **resolution trigger**: when does the buyer stop paying and receive settlement?
- **cost-of-error type**: the buyer's decision loss function if the installed state is wrong in a specific direction

Without the query contract being explicit, the mechanism has no principled way to:
(a) price the cost of supplying information to heterogeneous demanders
(b) differentiate between a buyer who needed a fresh snapshot once and a buyer who needed continuous live state
(c) attribute the reward split when multiple buyers cofinance the same coordinate update

The *conserved quantity* is now visible: **decision-relevant certainty**, valued differently by each query contract type. Capital transfer is the buyer paying to move the installed state closer to their required certainty threshold on their required temporal horizon.

---

### 2. State model
Each coordinate carries (as established in prior runs): value, precision class, evidence/interpretation split, semantic version, lineage class, transition record.

**Addition (#r69):** the coordinate also carries a *demand manifest* — an anonymized aggregation of active query contracts expressing:
- how many buyers need snapshot vs. subscription vs. event-triggered delivery
- the distribution of precision requirements (what level of uncertainty is still decision-useful)
- the distribution of latency tolerances (how stale is acceptable)
- the aggregate decision-loss exposure if the coordinate is wrong

The demand manifest is not a free-form registry; it is a compact summary vector. It drives the *coordination signal* for updaters: who should compete to supply this coordinate, and at what freshness/precision?

**Update rule:** the global state vector updates in two directions simultaneously — (a) supply side: challenger displacement, downgrade, corroboration, as prior runs established; (b) demand side: query contracts open and close, changing the demand manifest and repricing the coordination signal.

---

### 3. Credibility model
Prior: capital converts to credibility through stake-backed warranty.

**Addition (#r69):** capital also signals *demand seriousness*. A buyer who posts a large query stake is not just paying for the answer; they are signaling that their decision-loss from a wrong answer is high. This improves epistemics in two ways:
- It recruits higher-quality updaters (bigger payoff for correct maintained state)
- It calibrates the precision class required: high-stake demanders can require tighter uncertainty bounds, forcing updaters to earn their fee rather than serving vague answers

**Key constraint:** buyer stakes must be locked for the duration of the query contract's temporal window. Otherwise buyers can extract coordination information (which coordinates attract competition?) without genuine skin in the game.

---

### 4. Market roles
Prior: updater, challenger, corroborator, auditor, successor, event-detector.

**Addition (#r69):** explicit demand-side roles:
- **Snapshot buyer**: purchases a one-shot extraction of the current installed state at a specified precision. Pays spot, no ongoing liability.
- **Subscription buyer**: purchases continuous access to the maintained state with a freshness SLA. Pays a periodic fee proportional to (precision required × freshness required × coordinate volatility).
- **Event-trigger buyer**: purchases delivery of a specific transition event (coordinate crosses threshold, enters regime, changes value). Pays only when the event is detected and delivered within the contracted latency window. Most closely resembles the transition-claimant role from #r68 on the supply side.
- **Cofunders**: multiple buyers can pool on one coordinate's demand manifest, splitting costs and receiving the same installed state update. Individual query stakes remain private; the mechanism only publishes the aggregate demand vector.

**Who pays whom:**
- Snapshot buyer → installed updater (spot transfer at query time)
- Subscription buyer → escrow pool funding ongoing updater holdback release
- Event-trigger buyer → event-detector / transition claimant upon verified event delivery
- Cofunders → proportional contribution to shared escrow, proportional claim on delivered state

---

### 5. Settlement model
**One-shot queries:** resolved immediately against currently installed state. No holdback complexity; risk is entirely that the installed state is stale or wrong. Buyer accepts that risk by choosing snapshot mode.

**Subscriptions:** settlement is rolling; holdback releases are gated on freshness and precision compliance (already established in prior runs). Subscription ends either by buyer cancellation (with notice period) or by coordinate going unresolved.

**Event-trigger contracts:** settlement is binary conditional — delivered within latency window vs. not. Partial observability problem: if the event is never externally confirmed, the event-detector can only claim settlement based on what the oracle knows. Grade by: (a) event confirmed within window — full payout; (b) event confirmed but missed window — partial or zero; (c) oracle reveals event never happened — slash for false alarm; (d) oracle silent indefinitely — holdback stays locked pending resolution or dispute.

**Partial truth observability:** same framework as prior runs — coarse grading by interval / regime rather than exact timestamp. Event-trigger contracts should pre-specify the oracle and the grading rule at contract creation, not at dispute time.

---

### 6. Attack surface
**New attack vectors introduced by demand-side structure:**
- **Demand signaling extraction**: buyers post large query stakes to attract updater competition, then withdraw or let stakes expire without genuine intention to buy. *Mitigation: lock stakes for the declared temporal window; partial slash on early withdrawal.*
- **Demand manifest gaming**: buyers coordinate to inflate the apparent aggregate demand for a coordinate to manipulate updater recruitment or pricing. *Mitigation: stakes must be locked at contract creation; demand manifest is aggregate only, not individually attributable.*
- **Subscription churn gaming**: subscribers cancel just before a difficult refresh is due, leaving the updater without a funded principal to pay for the maintenance effort. *Mitigation: cancellation notice period; partial holdback from subscription fees escrow remains available to updater for the notice window.*
- **Event-trigger false demand**: buyers purchase event-trigger contracts on low-probability events to force updaters to monitor and stake without a realistic payout path. *Mitigation: event-trigger contract pricing should include a monitoring fee paid upfront, separate from the success fee. Updaters are compensated for the monitoring effort even if the event never fires.*
- **Pre-existing vectors from prior runs**: sybil corroboration, semantic drift, hindsight backfill, timestamp laundering, buyer capture — all carry over unchanged.

---

### 7. Why better or worse than LMSR/orderbooks

**Against LMSR:**
LMSR has no query structure; every participant is either betting or not. There is no way to express "I need this coordinate maintained for 30 days at ±5% precision with 1-hour freshness." LMSR prices aggregate belief, not the cost of maintaining a specific epistemic service. The knowledge marketplace with explicit query contracts is *better* for institutional buyers who need SLA-backed state, *worse* if the goal is pure price discovery from anonymous agents with no ongoing accountability.

**Against standard orderbook PMs:**
Orderbooks match individual counterparties on a specific outcome. There is no concept of a maintained coordinate, a subscription, or event-trigger delivery. The knowledge marketplace is a fundamentally different product: it is selling a *service*, not a *position*. It cannot be replicated by adding limit orders to a PM.

**Against batch auctions (GestAlt's domain):**
Batch auctions solve the time-fairness problem for execution. They do not naturally model the ongoing cost of maintaining state or the heterogeneous demand structure across query contract types. The knowledge marketplace is *complementary* to a batch-clearing layer: a batch auction could be the settlement mechanism for one-shot snapshot queries (batch buyers get cleared against the current installed state in the next batch window), while subscriptions run as continuous funded contracts outside the batch.

---

### 8. Simplest viable mechanism sketch

**Minimal viable extension of the prior coordinate model:**

Each coordinate C has:
- Installed state S (with fields from prior runs: value, precision, evidence class, schema version, lineage, transition record)
- Demand manifest D = (n_snapshot, n_subscription, n_event_trigger, aggregate_stake, precision_distribution, freshness_distribution, aggregate_decision_loss)
- Supply escrow E (updater holdbacks and reward pools, as prior runs)

**New demand-side ops:**

`QUERY_SNAPSHOT(C, precision_required)` → pays spot to read current S if precision_required ≤ S.precision. Else fails or triggers updater recruitment.

`OPEN_SUBSCRIPTION(C, precision_required, freshness_sla, duration, stake)` → locks stake for duration, adds to D, triggers updater maintenance obligation. Stake released to updater in periodic tranches contingent on freshness/precision compliance.

`OPEN_EVENT_TRIGGER(C, event_spec, latency_window, stake, monitoring_fee)` → pays monitoring_fee immediately to currently installed event-detector; locks stake for contingent payout on event delivery within latency_window.

`CLOSE_SUBSCRIPTION(C, notice_period)` → starts notice window; remaining escrow held for notice_period then released.

**Coordination signal:** when D.aggregate_stake rises above an updater-recruitment threshold, the mechanism broadcasts an open RFP for updaters to bid on the supply contract. Cheapest updater who meets the required (precision, freshness, lineage) wins the next maintenance window.

---

### 9. Strongest reason this idea fails

The demand manifest requires buyers to declare their query contracts upfront with locked stakes, which creates a chicken-and-egg problem: **buyers will not stake until a credible updater exists, and updaters will not compete until credible demand exists.** The coordination failure is worse than a prediction market, where participants can arrive incrementally.

*Specific failure mode:* sparse or new coordinates never get off the ground because neither side wants to be first. A PM can bootstrap from zero because any single trader can move the price; a knowledge marketplace needs bilateral commitment to launch a coordinate.

---

### 10. Best surviving variant

Use a **seed mechanism** for new coordinates: a protocol-level demand guarantee (e.g., 10% of treasury) that temporarily backs new coordinate subscriptions, effectively acting as a subsidized first buyer. This breaks the chicken-and-egg by ensuring the first updater who meets spec gets paid. The seed guarantee expires after the first full maintenance window; by then organic demand should have arrived or the coordinate is pruned.

For existing coordinates: the full demand-manifest mechanism as described operates normally.

This is a narrow and bounded change: the seed mechanism is a bootstrap subsidy, not an ongoing intervention. It does not change the core incentive structure; it just solves the cold-start problem for new coordinate creation. (ref: #r69; builds on #r36, #r40, #r42, #r52, #r54, #r55, #r59, #r67, #r68)

---

## BLOCKER NOTE
Google Docs auth (gog) is not configured on this host. Document update for #r69 is pending manual auth setup or gog credential provision.
Local artifact saved at: /home/ubuntu/agents/richard/.openclaw/workspace/memory/gdm_r69.md
