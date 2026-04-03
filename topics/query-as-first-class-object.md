# GDM Run #r69 — 2026-04-03

## Pending write to: https://docs.google.com/document/d/1Z1sbL9WgBHTxs-4YWlVZWfJy-ZsHwdPZu6qCuT_42e0/edit

Last confirmed run in doc: #r68.

---

## #r69 refinement — the demand side is structurally underspecified; schema capture is the missing attack

### 1. Base primitive
The mechanism has progressively enriched the supply-side product tuple (value grammar, dependency scope, authority tier, revocation path, provenance class, inspection class, revision policy, applicability domain, residual uncertainty, challenge affordability — ref: #r29–#r33, #r36, #r40, #r42, #r52, #r68). But the demand side has a structural gap that prior runs have not addressed: buyers in a knowledge marketplace often cannot fully specify what they want *before* interacting with suppliers. In LMSR, questions are pre-defined. In an orderbook, instruments are listed. In a knowledge marketplace, part of what is being sold is the *definition of the coordinate itself*. A buyer posting "I want to reduce decision-loss around X" cannot produce a fully-typed coordinate spec without knowing what suppliers can actually offer, at what precision class, from what provenance, under what revision policy. The demand side therefore needs its own revelation mechanism, not just a wallet.

### 2. State model
The global state vector cannot be pre-populated by buyers alone. It needs a **demand declaration layer** that precedes the coordinate schema layer. Demand declarations are typed differently from coordinates: (decision context, target decision-loss, priority window, acceptable authority classes). These declarations live in the state vector as *open queries* until a schema proposal phase closes them into installed coordinates. Without this, the state vector is supplier-defined and buyer-agnostic — the mechanism fills itself with what suppliers are cheapest to produce, not what buyers most need (#r69).

### 3. Credibility model
Schema capture is a credibility attack that prior runs' escrow/holdback model does not defend against. A supplier can propose a coordinate schema that (a) looks responsive to the buyer's declared need, (b) is scoped so the supplier can fill it cheaply and accurately, and (c) minimizes the supplier's liability by restricting applicability domain, loosening precision class, or widening residual uncertainty — all while technically satisfying the published rubric. Capital attached to the resulting coordinate buys epistemic-looking authority that does not actually reduce the buyer's decision-loss. Credibility escrow only converts to epistemics if the schema itself was selected to serve buyer decision needs, not supplier fill optimization (#r69).

### 4. Market roles
A new role is needed: **demand translator / schema broker**. This actor bridges buyer-declared decision context and supplier-proposed coordinate schemas. Their function is not to do research; it is to identify whether a proposed schema genuinely covers the buyer's declared decision loss or whether it is a supplier-convenient redefinition. Compensation is a fraction of the buyer's holdback release when the installed coordinate actually reduces decision-loss as measured at truth resolution — not when the coordinate is accepted. This aligns the translator's incentives with buyer outcome, not with schema volume (#r69).

### 5. Settlement model
Settlement needs a **demand-loss retrospective** in addition to coordinate accuracy scoring. At resolution: (a) did the installed coordinate's schema cover the buyer's declared decision context? (b) did the filled value reduce the buyer's decision-loss by at least the contracted amount? (c) was the precision class actually necessary for the decision, or was it theater? Schema brokers, schema-proposing suppliers, and fill-providing suppliers are scored separately on these three dimensions. A supplier who correctly fills a schema that was irrelevant to the buyer's decision gets less credit than one whose schema + fill genuinely reduced decision-loss (#r69).

### 6. Attack surface
**Schema capture** (new — #r69): supplier designs a coordinate that is technically responsive to the buyer's query but scoped to minimize supplier risk while maximizing authority capture. Defense: demand-loss retrospective at settlement; schema broker role with outcome-tied compensation.

**Schema gaming by demand translator**: translator could favor schemas from suppliers who share revenue, or could inflate buyer decision-loss estimates to justify over-purchasing. Defense: translator compensation tied to *realized* decision-loss reduction (post-resolution), not to schema acceptance; multiple brokers allowed to propose competing schema mappings.

**Demand theater**: buyer overstates decision-loss to attract more/cheaper supply. Defense: buyer's holdback contribution is also sized to declared decision-loss, so over-declaration is self-punishing (ref: #r69; extends #r33).

### 7. Why better/worse than LMSR/orderbooks
LMSR avoids this problem by pre-defining the question. That is both its strength (no schema capture) and its weakness (no adaptation to what buyers actually need). A knowledge marketplace that only operates on pre-defined coordinates is just LMSR with more overhead. The whole point of the mechanism is that buyers can procure state the market hasn't pre-listed. But that advantage is only real if the schema selection process is buyer-outcome-aligned. Without a demand revelation + schema broker phase, the knowledge marketplace will drift toward supplier-defined questions, which is worse than LMSR because it adds complexity without the pre-definition discipline (#r69).

Standard orderbooks are even worse here: instruments are fixed, so demand revelation is impossible by design.

Batch auctions improve somewhat because clearing can aggregate demand before committing to schema, but they still require pre-defined instruments in all standard implementations.

### 8. Simplest viable mechanism sketch
Add a two-phase process per coordinate:

**Phase 1 — demand declaration**: buyer posts (decision context D, target max decision-loss L, authority classes A, priority window W, budget cap B).

**Phase 2 — schema competition**: suppliers post proposed coordinate schemas S_i that they claim would reduce decision-loss by at least delta_i if filled, with a fill-cost estimate. Schema broker (or multiple brokers) score each S_i against D. Buyer selects the schema-fill pair that maximizes estimated (decision-loss reduction / cost). Selected supplier locks in schema and fills. Broker receives a fraction of holdback contingent on realized decision-loss reduction at settlement.

For routine coordinates (low decision-loss, well-understood domain), Phase 1 is trivial and Phase 2 collapses to the existing typed-coordinate flow. Only high-authority or novel coordinates need full Phase 2 competition.

### 9. Strongest reason this fails
Decision-loss is often not measurable at truth resolution because: (a) the buyer may have already made the decision using the installed state, (b) the counterfactual (what loss would have occurred without the update) is unobservable, (c) buyers may not be honest about their decision context in Phase 1 because that would expose private strategy. If decision-loss retrospective is unverifiable, schema brokers have no scoring signal and the demand revelation phase collapses into a performative layer.

### 10. Best surviving variant
Restrict demand-loss retrospective to a coarse binary: did the buyer use the coordinate in a downstream decision, and did that decision turn out in a direction consistent with the installed state? For the rest, use a proxy: schema covers the declared decision domain if it would have changed a canonical test decision under the declared authority class. Coarse binary scoring is less precise but far more measurable and harder to manipulate than continuous decision-loss reconstruction. Reserve full loss-accounting only for high-value contracts where both parties can pre-commit to a logged decision trail (#r69; extends #r25, #r31, #r33).

---
*Status: pending write to Google Doc — gog auth not configured, browser not available.*
