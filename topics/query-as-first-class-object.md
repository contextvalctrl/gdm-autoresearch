# GDM Knowledge Marketplace — Run #r69
**Date:** 2026-04-03 15:42 UTC  
**Focus:** Capital as credibility-transfer instrument; bilateral knowledge flow; mechanism invention from first principles vs LMSR/orderbooks/batch-auctions.

---

## #r69 — Core Mechanism Reasoning: What Is Actually Being Exchanged?

Previous runs (#r36–#r68) refined the coordinate-level contract (evidence/interpretation split, semantic lock, anti-desirability, downgrade rights, comparative replacement, redundancy/corroboration, changepoint detection). This run backs up one level and asks: *what is the base exchange primitive, and does it survive first-principles scrutiny against LMSR, orderbooks, and batch auctions?*

---

### 1. Base Primitive

**Not** a prediction-market position. **Not** a limit order on a belief.

The primitive is a **warranted-state contract**: seller commits to maintaining (or updating to) a specific value of a state coordinate with declared evidence quality, precision class, service window, and failure liability — in exchange for a capital transfer from a buyer who needs that coordinate for downstream decisions.

The conserved quantity across the exchange is **decision-relevant epistemic quality per coordinate per time unit**. Capital is the mechanism that makes the seller's claim credible *before* resolution (via escrow/stake/holdback) and settles fairly *after* resolution (via graded release or slash). Money does not represent a side-bet on belief movement; it represents a service bond.

Key distinction: LMSR prices the *probability shift* a unit of capital induces on a shared distribution. A knowledge marketplace prices the *epistemic service* of maintaining a reliable state reading of a specific coordinate.

---

### 2. State Model

**Global state vector S** = { (cᵢ, vᵢ, Pᵢ, Aᵢ, Lᵢ, Tᵢ) } where:
- cᵢ = coordinate identity (semantic-locked label + schema version)
- vᵢ = current installed value (point / range / bucket / unresolved)
- Pᵢ = precision class (point > bounded range > coarse bucket > unresolved)
- Aᵢ = authority tier (primary-warrant / corroborated / advisory / contested)
- Lᵢ = lineage class(es) of current installed state (source families)
- Tᵢ = transition record (last changepoint, detection window, transition confidence)

**Update rule:** An update to (cᵢ, vᵢ, Pᵢ, Aᵢ, Lᵢ, Tᵢ) requires:
1. A challenger posts a contract with declared superiority vector (evidence tier, semantic continuity, uncertainty class, lineage, service terms).
2. Contract passes admission filter (semantic compatibility, minimum stake, schema version check).
3. If it dominates the incumbent on the precommitted dominance ladder → replacement proceeds.
4. Holdback from prior incumbent rolls forward / partially slashes per truth resolution schedule.

No continuous market-maker is required. Updates are discrete events, not continuous price paths.

**What is NOT in the state vector:** crowd-belief distribution, probability of outcome X, speculative positions. Those belong in a PM. The knowledge marketplace state vector is a maintained *claim about the world*, not a maintained *bet on the world*.

---

### 3. Credibility Model

**Capital converts to credibility via a three-layer mechanism:**

**Layer 1 — Escrow (pre-resolution stake).** Seller locks capital at contract acceptance. Size of escrow signals depth of conviction and funds the slash if the state turns out wrong. Without escrow, cheap talk dominates: any agent can assert anything.

**Layer 2 — Holdback schedule (during service window).** Payment to seller is not immediate. A fraction is held in reserve conditional on: (a) coordinate remaining unchallenged by a superior contract, (b) precision class remaining defensible (no forced downgrade), (c) transition claims holding under subsequent evidence. This converts stake into *ongoing service accountability*, not just a one-shot deposit.

**Layer 3 — Graded resolution (post-truth).** When the coordinate resolves (fully or partially), payout is graded on: endpoint accuracy, precision honesty, semantic continuity, lineage independence (for corroborated coordinates), and (where applicable) changepoint detection quality. Partial observability handled by coarse interval grading rather than point-exact comparison.

**Key property:** capital improves epistemics because *the seller's payoff is maximized by being accurately right with honest precision*, not just by being optimistically confident or strategically vague. Without the holdback and graded resolution, escrow alone is insufficient — a seller could post stake, assert a confident answer, collect partial upfront, and exit.

---

### 4. Market Roles

| Role | Function | Capital flow |
|---|---|---|
| **Asker / Demander** | Needs a coordinate maintained to decision quality. Posts a bid specifying coordinate, required precision class, authority tier, service window, max price. | Pays seller on holdback schedule |
| **Updater / Knower** | Claims ability to maintain or improve the coordinate. Posts escrow, accepts liability. | Receives holdback release + terminal payout if graded well |
| **Challenger** | Believes they can maintain the coordinate better. Posts comparative contract with dominance claim. | Receives partial incumbent holdback + new service fee if they displace and perform |
| **Corroborator** | Provides independent-lineage confirmation of installed state. Does not replace incumbent, but raises authority tier. | Receives corroboration fee (diminishing returns; first independent lineage gets most) |
| **Auditor** | Reviews semantic continuity, lineage class declarations, evidence/interpretation split. Off-chain or protocol role. | Receives fee from mechanism reserve or from demander |
| **Transition-detector** | Explicitly warrants changepoint detection on transition-sensitive coordinates. Different SLA than level-maintenance. | Receives transition detection payout if within contracted latency window |

**Who pays whom:** Demanders fund the system. Updaters earn from demander payments (via holdback schedule). Challengers earn from displacing under-performing incumbents. Corroborators earn small incremental fees. The mechanism holds escrow and enforces slashing — it does not trade against participants (unlike LMSR market-maker).

---

### 5. Settlement Model

**Full observability:** Truth oracle delivers coordinate value at resolution time. Payout = f(accuracy, precision class honesty, semantic continuity, lineage compliance). Full holdback releases or slashes.

**Partial observability (most real cases):**
- Coarse-grading: was the installed value in the correct interval? Correct bucket? Correct regime? Graded payout on ordinal distance.
- Changepoint grading: did transition detection happen within the contracted window? Binary or interval-scored.
- Semantic grading: did the coordinate definition remain stable? Auditor-verified.
- Lineage grading: was declared independence verifiable? Coarse lineage-bucket comparison, not coefficient estimation.

**Unresolvable truth:** If oracle never delivers, partial holdback releases on time-weighted service quality (no challenges survived, precision maintained, semantic integrity verified). Final slash is held in protocol reserve until resolution or governance-adjudicated release.

**Key design choice:** settlement does not require a single binary outcome. A knowledge marketplace can pay out on maintained quality over a service window even if the final "truth" is never binary-resolved, because the value delivered is operational — someone made better decisions using the coordinate during its service window.

---

### 6. Attack Surface

| Attack | Description | Defense |
|---|---|---|
| **Bluffing / cheap talk** | Assert high-quality state without real information edge. | Escrow + graded slash. Without real edge, expected value of posting is negative. |
| **Hindsight backfill** | Wait until state becomes public, then overwrite as if you detected it early. | Submission timestamp enforced on-chain; transition-window grading penalizes post-hoc transitions. |
| **Sybil corroboration** | Create multiple identities to collect corroboration fees for same lineage. | Lineage-class bucketing; same-lineage corroborations receive near-zero marginal reward. |
| **Oracle gaming** | Collude with oracle source to influence resolution in seller's favor. | Separate oracle layer; multi-oracle aggregation; oracle slashing for coordinated deviation. |
| **Semantic drift** | Quietly redefine coordinate meaning to make stale value appear correct. | Semantic-definition lock (#r35); schema-version field; schema custodian / auditor role. |
| **Precision theater** | Claim false sharpness (narrow range) to earn premium, then retreat on challenge. | Precision class has explicit holdback tied to defensibility; forced downgrade triggers partial slash. |
| **Buyer capture** | Buyer awards authority to seller who gives preferred answer. | Anti-desirability insulation (#r34); blinded scoring for high-authority coordinates. |
| **Collusion between updater and challenger** | Fake competitive cycling to extract mechanism fees. | Genuine stake required for both roles; cycling without real improvement earns nothing; auditable on-chain. |
| **Alert theater (changepoint spam)** | Overcall regime shifts to appear valuable, earning transition fees. | False-alarm slash on transition-sensitive coordinates; penalty for transitions that don't survive oracle grading. |
| **Incumbent entrenchment** | Post large escrow early; challenger cost too high to displace even mediocre state. | Comparative replacement with precommitted dominance ladder; challenger fee proportional to improvement delta, not absolute stake. |

**Core attack not fully solved yet (new in #r69):** *Demand-side manipulation.* A sophisticated buyer can post demand contracts with very specific precision/lineage requirements that only one seller can meet — effectively creating a private knowledge monopoly. Defense: mechanism should allow open submission for all coordinates; demander cannot cryptographically exclude otherwise-qualified sellers from bidding.

---

### 7. Comparison to LMSR / Orderbooks / Batch Auctions

**vs LMSR:**
- LMSR: conserved quantity is a scoring-rule-backed probability distribution. Market-maker absorbs all trades against the book. Capital moves probability. Efficient for eliciting beliefs about binary events.
- Knowledge marketplace: no market-maker. Capital is service bond, not position. State is a maintained coordinate value, not a probability. Useful when the question is not "what probability does the crowd assign to X?" but "what is the current state of X, and who is accountable for it?"
- LMSR advantage: continuous belief aggregation, deep liquidity, natural price discovery.
- Knowledge marketplace advantage: explicit accountability, precision honesty, service-window maintenance, partial-observability grading, changepoint detection. Better when you need to *use* a state reading operationally, not just bet on it.

**vs Standard Orderbooks:**
- Orderbooks: buyers and sellers post prices, matching clears. No state vector, no accountability beyond market price. Efficient for liquid two-sided markets.
- Knowledge marketplace: bilateral contract, not anonymous price match. Seller identity and lineage matter. Settlement is on accuracy, not on exit price.
- Orderbook advantage: liquidity, speed, well-understood incentives, composable with derivatives.
- Knowledge marketplace advantage: accountability cannot be anonymized away; operational-quality guarantees that orderbooks structurally cannot provide.

**vs Batch Auctions:**
- Batch auctions: aggregate orders over a window, clear at uniform price, reduce front-running.
- Knowledge marketplace: not primarily about price; about selecting the best available state contract in a comparative dominance ranking. Admitting multiple competing contracts per batch and selecting the dominant one is a natural analog.
- Batch mechanism can be *layered on top* of the knowledge marketplace for admission events: collect competing contracts per coordinate per epoch, run dominance comparison, install winner. This preserves batch-fairness without requiring continuous price competition.

**The mechanism is NOT a rename of PM matching.** The PM asks: "what probability does the crowd assign?" The knowledge marketplace asks: "who can maintain this state reading under accountability for what price?" These are different questions that require different primitives, different settlement, and different incentive structures.

---

### 8. Simplest Viable Mechanism Sketch

**Minimum viable mechanism (MVP contract spec):**

1. **Coordinate registry** — on-chain table of (cᵢ, schema version, transition-sensitivity flag, authority tier policy, lineage independence policy).

2. **Demand post** — demander posts {cᵢ, required precision class, required authority tier, service window [t₀, t₁], max price P_max, partial-observability grading rule}.

3. **Bid submission** — seller posts {contract, escrow E ≥ E_min, evidence tier declaration, lineage class declaration, transition-window declaration if applicable, price P ≤ P_max}.

4. **Admission filter** — schema version check, minimum escrow, semantic compatibility check. Batch window for competing bids.

5. **Dominance selection** — if multiple bids: rank by (evidence tier, precision class, lineage coverage, service price). Install highest-ranked.

6. **Service window** — incumbent serves. Challengers can submit comparative replacement contracts with posted escrow. Dominance check on each challenger.

7. **Partial holdback release** — at regular checkpoints: release fraction of seller payment if coordinate unchallenged and precision defensible.

8. **Oracle resolution** — at t₁ or earlier if truth available. Grade on accuracy, precision honesty, semantic continuity, lineage compliance, transition quality. Release remaining holdback or slash escrow.

9. **Slash distribution** — slashed escrow goes to: challenger who displaced (partial), mechanism reserve (partial), demander rebate (partial).

---

### 9. Strongest Reason This Idea Fails

**The oracle-coordination problem is not solved by the mechanism — it is assumed away.**

The entire credibility structure depends on truth resolving at settlement. But for the exact cases where a knowledge marketplace adds the most value — complex, slow-resolving, partially observable real-world states — oracle quality degrades. If the oracle is weak, contested, or manipulable, the graded settlement becomes arbitrary, and the escrow structure collapses into a dispute market rather than a credibility mechanism.

Prediction markets partially avoid this by selecting binary, cleanly-resolvable questions. A knowledge marketplace that handles multi-dimensional, partially observable, slow-resolving state vectors faces oracle risk across every coordinate simultaneously.

**This is not fatal, but it means:** the mechanism's value proposition is strongest for coordinates that are either (a) digitally verifiable (on-chain events, signed data), (b) multi-oracle-aggregated with its own accountability structure, or (c) resolution-graded coarsely enough that oracle disputes rarely change outcomes. For the remainder, the mechanism adds overhead without the credibility guarantee it promises.

---

### 10. Best Surviving Variant

**"Accountable State Maintenance" — narrow oracle + wide operational scope.**

Instead of trying to maintain a general-purpose global state vector with full oracle accountability, restrict the mechanism to:

1. **High-verifiability coordinates** — on-chain data, signed API endpoints, multi-oracle aggregations with slashing, or human-verifiable factual claims (company registration status, regulatory filings, observable market structure facts).

2. **Coarse-graded partial observability** — never require point-exact resolution; only require interval / regime / direction correctness. This dramatically shrinks the oracle dispute surface.

3. **Service-quality settlement as primary payoff** — most of the seller's payout comes not from final truth resolution (which may be delayed or imprecise) but from service quality during the window: unchallenged, precision-maintained, semantically stable, independently corroborated. Truth resolution adjusts the terminal payout but is not the primary payoff event.

4. **Changepoint and transition contracts on clearly event-driven coordinates** — binary-resolvable changepoints (system outage, legal status change, regulatory announcement) are the easiest oracle surface and the most operationally valuable product.

This variant survives because it anchors credibility to the parts of the mechanism that do not depend on solving the general oracle problem, while preserving the core innovation: capital as service bond, bilateral knowledge transfer accountability, and graded precision honesty. (#r69)

---

## Summary delta vs prior runs

- #r68 established transition/changepoint as a first-class product dimension.
- **#r69 (this run):** Backs up to base primitive. Synthesizes the full mechanism from first principles into a coherent single-document structure covering all 10 dimensions. Identifies demand-side manipulation (buyer-dictated exclusivity) as a new attack vector. Resolves the LMSR/orderbook/batch comparison into crisp structural distinctions. Identifies oracle coordination as the mechanism's central failure mode, not just a peripheral concern. Best surviving variant narrows deployment scope to high-verifiability coordinates + coarse grading + service-quality-primary settlement.
