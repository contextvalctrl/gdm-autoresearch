# Knowledge Marketplace — GDM Mechanism Design
## Aggregated Working Document

**Target doc:** https://docs.google.com/document/d/1Z1sbL9WgBHTxs-4YWlVZWfJy-ZsHwdPZu6qCuT_42e0/edit
**Last sync:** Local only — pending gog auth to push to Google Doc
**Runs:** #r1 (2026-04-03)

---

## 1. Base Primitive — What is being exchanged?

In LMSR: shares in outcome states. Market maker absorbs all trades via a cost function; price is a public good.
In orderbook PM: probability-weighted contracts matched between opposing beliefs; adversarial zero-sum.
In batch auction (GestAlt-style): orders batched, cleared at uniform prices — still fundamentally price discovery.

**Knowledge marketplace primitive (distinct from all above):**
What is exchanged is *credentialed information* — a belief update with capital posted as the credential. The credential is not a side-bet on crowd belief; it is a *credibility bond* that the claimant forfeits upon being wrong.

- Ask side: agent posts a claim about world state with stake. "I claim state is μ, I put k capital behind it."
- Bid side: agent pays fee f to receive (μ, credibility_weight) and reduces their own state uncertainty.

**Conserved quantity:** epistemic utility — expected log-likelihood gain per unit capital at risk. Capital does not move prices; it weights belief updates. (#r1)

**Why this is not just renaming PM matching:** In PM matching, capital moves a price signal that is public and symmetric. Here capital privately certifies a directional claim from a specific agent. The information routing is bilateral; the scoring is relative to a prior, not to an opposing order. (#r1)

---

## 2. State Model — Global state vector and update rule

Let the global state be a probability distribution S over outcomes Ω: S ∈ Δ(Ω).

**Layers:**
- *Prior state* S_prev: last settled or initialized distribution.
- *Pending claims layer*: set of claims {(μ_i, k_i, T_i)} not yet settled. Each μ_i is a knower's reported posterior.
- *Public state estimate* S_public: reputation-staked weighted mean of pending claims:
  `S_public = Σ_i w_i * μ_i`, where `w_i = (k_i / Σk) * sigmoid(α * T_i)`
  T_i is the knower's historical track record (accuracy-weighted).
- *Resolved state*: after oracle delivery of ω*, collapses to δ(ω*). Cycle resets.

**Update rule discipline:** the public state vector is NOT updated on each individual claim arrival. Claims accumulate in the pending layer; the public state is a batch recomputation at each epoch boundary. This prevents front-running on state updates and is structurally compatible with GestAlt's batch epoch model. (#r1)

**What makes this NOT LMSR:** LMSR updates a single shared cost function continuously; price is the partial derivative of total cost. Here there is no cost function and no continuous price signal. State is a weighted posterior average, not a log-odds market price. (#r1)

---

## 3. Credibility Model — How capital converts to trustworthy information

**Mechanism:** Proper scoring rule applied bilaterally, not to a shared market state.

For each resolved claim, knower i with claim μ_i receives:
```
R(μ_i, ω*) = k_i * [log μ_i(ω*) - log S_prev(ω*)]
```
- Positive reward if claim improves on prior (positive KL contribution toward ω*).
- Capital forfeiture if claim degrades on prior.
- Magnitude proportional to stake k_i.

**Track record T_i:** rolling accuracy score over past N settled claims, weighted by stakes and KL contributions. High-stake correct calls compound reputation; high-stake wrong calls degrade it multiplicatively. (#r1)

**Credibility weight for unknowers consuming claim i:**
```
w_i = (k_i / Σk) * sigmoid(α * T_i)
```
Log-diminishing stake effect (doubling stake does not double influence) prevents capital-rich adversaries from flooding the state. (#r1)

**Key property:** This is a Bayesian-consistent aggregation. Under truth-telling equilibrium, an agent with genuine private signal μ_i has strictly positive expected payoff. Under bluffing, expected payoff is negative. Reporting is incentive-compatible. (#r1)

---

## 4. Market Roles

**Knowers (Ask side):**
- Hold private information, analytical edge, or superior models.
- Post claims with stake. Earn: (a) fees from unknowers upon verified consumption, (b) scoring reward upon correct settlement.
- Can post conditional claims: "state is X given that prior indicator Y holds."
- Fee is held in escrow until settlement — no pre-settlement cash-out of information sales.

**Unknowers (Bid side):**
- Want to reduce state uncertainty at lower cost than independent research.
- Pay fee f to receive credentialed claim (μ_i, w_i).
- Portion of fee → knower fee pool (escrowed). Portion → slash reserve.
- Option: subscribe to aggregated public state S_public (cheaper, less specific) or to individual knower streams.

**Who pays whom at settlement:**
- Correct knower ← fee pool + scoring reward (from wrong knowers' slashed stakes).
- Wrong knower → slash pool → distributed pro-rata to unknowers who relied on that claim.
- Net: capital flows from low-information zone to high-information zone when claims are correct; reverses when wrong.

**No human market maker required.** Protocol layer performs: claim aggregation, credibility-weighted state update, matching (route unknower to best expected KL-reduction source), stake lockup, and settlement. (#r1)

---

## 5. Settlement Model

**Hard resolution (binary/categorical outcome):**
- Oracle delivers ω*. All pending claims scored.
- Correct claims (KL-reducing): knower receives staked k + escrowed fees + share of slash pool.
- Wrong claims: stake slashed, distributed to unknowers who relied on them.
- State resets, cycle begins.

**Soft/partial resolution (continuous signals or uncertain oracle):**
- Oracle delivers partial signal ω̃ with confidence c ∈ [0,1] per outcome.
- Rewards proportional to KL contribution weighted by c:
  `R(μ_i, ω̃) = k_i * E_{ω* ~ ω̃}[log μ_i(ω*) - log S_prev(ω*)]`
- Unknowers may re-stake on updated state post-partial-signal. Knowers whose claims were outdated (not wrong, superseded) receive partial credit. (#r1)

**No resolution / oracle failure:**
- Stakes returned minus protocol fee.
- Track records unaffected (no signal = no calibration update).
- Unknower fees partially refunded from escrow.
- Design note: oracle failure is a known attack vector (see §6); require oracle bonding. (#r1)

---

## 6. Attack Surface

**Bluffing / cheap talk:**
- Risk: stake small, earn fees, walk away even if wrong (fees paid before settlement).
- Mitigation: all fees held in escrow until settlement. Knower only receives fee if claim proved net-positive KL OR stake+track-record clears threshold. (#r1)

**Sybil / wash credibility:**
- Risk: knower creates many identities, self-claims, builds fake track records on synthetic unknowers.
- Mitigation: unknowers must pay real capital to consume claims — synthetic unknowing costs real money. Further: require unknowers to stake reliance-bonds (if claim wrong and you relied on it, you lose some stake). Makes fake unknowing expensive. (#r1)

**Collusion (mutual credibility inflation):**
- Risk: Knower A and B exchange claims to inflate each other's track records.
- Mitigation: correlation penalty — if two knowers' claims are highly correlated AND both wrong, neither gets scoring credit. Claim similarity graph enables collusion detection. (#r1)

**Capital-flood disinformation (adversarial staking):**
- Risk: rich adversary stakes wrong claims, accepts capital loss, degrades public state.
- Mitigation: log-diminishing influence (stake doubling does not double w_i) + public reputation trail makes adversarial history observable and progressively discounts adversary's future claims. (#r1)

**Oracle gaming:**
- Risk: knower with oracle influence stakes, triggers favorable resolution, collects.
- This is the hardest attack. Mitigations: (a) oracle bonding > any possible knower stake; (b) multi-source oracle with BFT aggregation; (c) mandatory delay between claim posting and oracle invocation window; (d) cross-oracle consistency requirement. (#r1)
- **Unresolved:** if the knower IS the oracle source, no mechanism fully prevents this without trusted hardware or reputation over long time horizons. Flag as open research problem. (#r1)

**Thin market / knower starvation:**
- Risk: no unknower demand → knowers don't stake → empty market. (See §9.)

---

## 7. Comparison: LMSR / Orderbooks / Batch Auctions

| Dimension | LMSR | Orderbook PM | Batch Auction (GestAlt) | Knowledge Marketplace |
|---|---|---|---|---|
| What is exchanged | Outcome shares | Contracts between opposing bettors | Batched orders cleared at uniform price | Credentialed belief updates |
| Market maker | Required (subsidized) | None (or AMM) | None (batch clearing) | None (protocol layer) |
| Capital role | Moves shared price | Backs directional bet | Backs batch order | Credibility bond on specific claim |
| Information routing | Public, symmetric | Public, adversarial | Public, batch-fair | Bilateral, knower→unknower |
| Zero-sum? | No (MM subsidizes) | Yes | Yes (net of fees) | No (correct knowers and unknowers both benefit) |
| Thin market behavior | Always quotes price | No liquidity | No liquidity | No claims, fails |
| Adversarial | Front-run resistant if DLMSR | Front-running possible | Batch reduces front-run | Capital-flood disinformation possible |

**Knowledge marketplace advantages:**
- No MM subsidy needed — self-sustaining via fee model.
- Not zero-sum: aligned incentive for everyone to improve epistemic quality.
- Directly rewards information transfer, not just directional bet accuracy.
- State vector is a calibrated posterior, not a price signal distorted by liquidity effects. (#r1)

**Knowledge marketplace disadvantages:**
- Requires actual knowers to exist and stake credibly (bootstrap problem, §9).
- No natural continuous liquidity — discrete claim lifecycle.
- Unknown behavior under adversarial high-capital environments (open).
- Complexity vs LMSR simplicity. (#r1)

---

## 8. Simplest Viable Mechanism (MVP)

**Protocol: EpistemicBond v0**

```
State:
  S_prev: prior distribution (from last settlement or initialization)
  claims[]: pending {μ_i, k_i, fees_escrowed_i, unknowers_i[]}
  registry[]: {agent_id, track_record T_i, historical_stakes}

Lifecycle:
  1. knower.post(μ, stake k) → claim_id, lock k in escrow
  2. unknower.consume(claim_id, fee f) → receive (μ, w_i), lock f in escrow, record reliance
  3. [epoch boundary] recompute S_public = Σ w_i * μ_i (credibility-weighted mean)
  4. oracle.resolve(ω*) → settle_all()

settle_all():
  For each claim c:
    score_c = log c.μ(ω*) - log S_prev(ω*)
    if score_c > 0:
      c.knower.receive(c.k + c.fees_escrowed + pro_rata_slash_share)
      update T_c.knower += positive_update(score_c, c.k)
    else:
      slash_pool += c.k
      c.fees_escrowed → refund to unknowers_c pro-rata by reliance
      update T_c.knower += negative_update(score_c, c.k)
  distribute slash_pool to correct-claim unknowers pro-rata by reliance
  S_prev = δ(ω*)
  reset claims[]
```

No oracle bonding, no correlation penalties, no conditional claims in MVP. Add those in v1. (#r1)

---

## 9. Strongest Failure Mode

**The bootstrap / thin-knower problem:**

For unknowers to pay, credible knowers must exist with track records. For knowers to stake, paying unknowers must exist. Before track records exist, credibility weights are uninformative (all claims look the same to unknowers). Rational unknowers don't pay. Knowers don't stake. Market fails to launch.

This is structurally more severe than in LMSR (MM always quotes) or orderbook PM (liquidity from natural believers and skeptics based on pre-existing beliefs).

The knowledge marketplace requires either:
- External bootstrapping: seed period where protocol subsidizes knower stakes or guarantees minimum unknower fees. Subsidized period creates artificial track records that carry over to the live market.
- Credentialing: require knowers to present verifiable expertise credentials (domain credentials, institutional affiliation) that proxy track record before on-chain history exists.
- Neither solves the underlying problem: what if there genuinely aren't agents with superior information? The mechanism is vacuous without them.

**Root issue:** LMSR extracts truth from heterogeneous public beliefs; it doesn't require anyone to "know" things. Knowledge marketplace requires genuine epistemic asymmetry to exist and to be monetizable. This is a stronger assumption. (#r1)

---

## 10. Best Surviving Variant

**Epistemic Bond Layer on Top of Financial Settlement Layer**

Don't replace the PM settlement mechanism. Instead:

1. **Layer 1 (Financial):** Run standard batch auction / LMSR for price discovery and financial settlement. This is GestAlt's existing direction and solves the liquidity/bootstrap problem.

2. **Layer 2 (Epistemic):** Add an epistemic bond layer. Any participant who wants to publish a state claim with credibility stakes an epistemic bond. Epistemic bonds affect only the *state aggregation for downstream consumers* (oracles, derivative instruments, information buyers) — NOT the primary settlement price.

3. **Consumers of Layer 2** pay subscription fees to access credentialed state updates. Knowers build track records anchored to Layer 1 settlement truth. Layer 1 provides natural ground-truth resolution regardless of Layer 2 activity.

**Why this survives:**
- Bootstrap problem solved: Layer 1 provides liquidity regardless; Layer 2 only adds value on top.
- Truth source is clean: Layer 1 settlement resolves Layer 2 claims without oracle entanglement.
- Revenue model: Layer 2 generates subscription/fee revenue independent of Layer 1 trading volume.
- GestAlt fit: the batch clearing architecture of GestAlt provides natural epoch boundaries for epistemic bond settlement. (#r1)

**This is the strongest surviving variant:** knowledge marketplace as a credibility and state-aggregation service layer, not as a primary market mechanism. (#r1)

---

## Open Questions (to resolve in future runs)

- [ ] Can the credibility weight function w_i be made Sybil-proof without identity/KYC?
- [ ] What is the correct log-diminishing function for stake influence to deter capital-flood attacks?
- [ ] How do conditional claims (μ_i|Y) interact with the aggregation in S_public?
- [ ] Can epistemic bond layer be priced such that L2 revenue > L2 operational cost at realistic knower population sizes?
- [ ] Formal proof that truth-telling is a dominant strategy under the proposed scoring rule and bilateral fee structure.
- [ ] Oracle gaming: is there a mechanism-complete solution, or is this always a trust assumption?

---

*Local file — to be synced to Google Doc once gog auth is restored.*
