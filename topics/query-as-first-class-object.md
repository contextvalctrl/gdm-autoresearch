# GDM Knowledge Marketplace — #r69

## Run metadata
- Run: #r69
- Date: 2026-04-03
- Status: BLOCKED on Google Doc write (no gog auth / no Google credentials on host)
- Prior run recovered from: Google Doc export (txt), last entry was #r68

## Net-new reasoning for #r69

**Theme: the conserved quantity problem — what is actually invariant in this mechanism?**

The standing instruction has always asked: "what is the conserved quantity, what is the update rule, what is the source of truth, and why does capital improve epistemics rather than just reallocate PnL?"

After 68 runs, the mechanism has accumulated a very rich state-schema — 10+ typed fields per coordinate — but has never formally named the conserved quantity. This is the gap #r69 addresses.

### 1. Base primitive (#r69 contribution)
The conserved quantity candidate is **decision-relevant epistemic coverage** (DREC) per coordinate, not capital and not probability mass. Capital in this mechanism is not conserved; it flows from low-information actors (demanders) to high-information actors (updaters, challengers) as payment for a service. What should be conserved — or at least non-decreasing over time — is the coverage of decision-relevant state: the fraction of the coordinate's applicability domain that is maintained inside the contracted error envelope under active warranty.

This has a direct implication: the mechanism is not primarily a market for beliefs; it is a maintenance-of-coverage service. Capital enters only because maintenance has a cost and uncertainty about coverage creates a fee opportunity. The conserved object is "deployed warrant coverage over state space," not probability estimates or trading PnL.

### 2. State model (#r69 contribution)
The update rule should be: DREC(c, t+1) = DREC(c, t) + coverage_gain(new_update) − coverage_lost(expired_warranty) − coverage_voided(challenger_slash).

An update that replaces stale coverage with fresher coverage does not increase net DREC unless it genuinely extends the domain or narrows the error envelope. A challenger that slashes an incumbent decreases DREC temporarily until a replacement is accepted — this is the cost of correction and should be minimized by making challenges fast and replacement seamless.

This distinguishes the mechanism sharply from LMSR: in LMSR the conserved (or managed) object is the market maker's scoring-rule budget. Here the conserved object is coverage; the market maker's analog is the escrow pool that guarantees replacement continuity.

### 3. Credibility model (#r69 contribution)
Capital improves epistemics because DREC is expensive to manufacture: observation cadence, access rights, domain expertise, and challenge monitoring all cost real resources. A seller who posts stake is asserting "my coverage is genuine and I will defend it." The stake's epistemic function is to make DREC non-trivial to fake: without liability, anyone can claim coverage. With liability, coverage claims are bounded by the seller's willingness to underwrite them.

The prior runs (#r18, #r22, #r25) identified that liability should scale with authority delta, capacity, and operative stakes. The #r69 addition: liability should also scale with the *area of DREC being claimed* — a large-domain update that covers more of the state space should require proportionally more escrow because the coverage claim is riskier and harder to defend.

### 4. Market roles (#r69 contribution)
No new roles, but a sharper payment logic: demanders pay proportionally to the DREC value they are consuming (how much of their decision space the coordinate covers, weighted by decision-loss sensitivity). Updaters earn proportionally to DREC delivered and maintained. Challengers earn the DREC recovery premium — the value of restoring coverage that was degraded by a failing incumbent. This framing makes the marketplace a DREC insurance and maintenance system rather than a betting market.

### 5. Settlement model (#r69 contribution)
When truth resolves: compare the DREC that was under warranty (contracted coverage) against the DREC that was actually delivered (realized coverage inside error envelope). Slash proportionally to coverage gap, not to point error. A seller who maintained wide intervals honestly but whose intervals contained the truth loses nothing; a seller who claimed narrow point coverage that missed loses proportionally to the gap between claimed precision and actual coverage.

Partial observability: grade on sampled coverage verification. If truth is partially observed over a random sample of the coordinate's applicability domain, DREC can be estimated statistically. This is a significant advantage over binary prediction market resolution.

### 6. Attack surface (#r69 contribution)
The DREC framing opens a new attack: **coverage inflation** — sellers claim wide domains and loose error envelopes to make their warranty appear large while actually providing little information. Mitigant: DREC must be weighted by decision-relevance density (not flat domain area). A seller claiming coverage over a low-decision-density region earns little. This mirrors the issue in insurance markets where policies with huge nominal coverage over irrelevant risks are nearly worthless.

Existing attacks from prior runs still apply. The #r69 addition is that sybil credibility and wash credibility attacks are specifically coverage-inflation variants.

### 7. Better/worse than LMSR/orderbooks (#r69 contribution)
LMSR manages a probability budget; it does not have a coverage concept. This mechanism manages a DREC budget: it can be explicit about *where* in the state space knowledge is thin, patchy, or stale. That is a stronger epistemic product for decision support because buyers can see the coverage map, not just a price signal. The cost is that DREC is harder to measure than price, and coverage audits require more institutional infrastructure than trade matching.

### 8. Simplest viable mechanism sketch (#r69 contribution)
Add a `drec_weight` field to each coordinate declaration: this is the buyer-declared decision-relevance density over the coordinate's applicability domain. Payment to the updater = installation fee × drec_weight × coverage_quality_score. Holdback = f(drec_weight, authority_tier, correction_latency). Challenger reward = DREC recovered × drec_weight.

Minimal addition to existing schema: one field + one scoring function. No new roles.

### 9. Strongest reason this fails (#r69 contribution)
DREC is hard to measure objectively. Decision-relevance density requires the buyer to specify their utility function over state space, which they may not know precisely or may not reveal truthfully (strategic underreporting to reduce fees). Without a credible DREC measurement, the coverage framing collapses back into qualitative judgment.

### 10. Best surviving variant (#r69 contribution)
Use DREC only as a conceptual anchor for pricing and slashing logic, not as a precisely measured quantity. Approximate it with three coarse buckets: high decision-relevance (auto-binding or action-gating coordinates), medium (decision-support), low (advisory/observatory). Map holdback and slash rates to these buckets. The exact DREC formula is optional; the conceptual shift — that capital is buying coverage, not probability shares — is the durable contribution.

(ref: #r69; integrates conserved-quantity thread from standing instructions; builds on #r1, #r4, #r8, #r9, #r18, #r22, #r25, #r31, #r32, #r33)

---

## Pending: Doc write blocked

Need gog auth (OAuth credentials for team@valctrl.com) to write #r69 to:
https://docs.google.com/document/d/1Z1sbL9WgBHTxs-4YWlVZWfJy-ZsHwdPZu6qCuT_42e0/edit

Action for Gaurav: run `gog auth add team@valctrl.com --services docs` on this host, or provide service account JSON.
