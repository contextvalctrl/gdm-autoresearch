# Knowledge Marketplace Mechanism Design — Aggregate Document
## GDM Autoresearch Thread | ValCtrl
---
_This file is the canonical aggregate. Each run adds net-new insight and is tagged with run references. Edit for quality, not for log-completeness._

---

## Run Log
- #r1 — 2026-04-03 07:52 UTC — First-principles cold start

---

## 1. Base Primitive — What Is Being Exchanged?

**Surviving view (#r1):**

The primitive is not a probability-weighted share in an outcome. It is a **credibility-weighted state update**.

Formally: an agent $A$ with private signal $s_A$ about world state $\omega$ "sells" a conditional belief update $\Delta\hat{\omega} = f(s_A)$ to an agent $B$ who wants to reduce uncertainty about $\omega$ and is willing to pay capital $c$ to obtain it.

The object of exchange is the **epistemic delta** — the reduction in $B$'s uncertainty — and capital is the bond that makes $A$'s claim costly to fake.

This is NOT a share in a payout pool. It is closer to: *A* certifies a signal and *B* pays for that certification, with settlement contingent on whether the signal turns out to have been informative.

**Contrast with LMSR:** LMSR exchanges shares in a scoring rule pool. Capital moves to push a public price toward truth, but the object being "sold" is price impact, not information directly. Knowers and unknowers are not distinguished; all traders are price-movers. The knowledge marketplace makes knower/unknower asymmetry the central organizing feature.

---

## 2. State Model — Global State Vector and Update Rule

**Surviving view (#r1):**

Let $\Omega$ be the true world state (unknown, revealed at resolution time $T$).

The global state vector $\hat{\omega}_t$ is the system's current best estimate of $\Omega$ at time $t$, maintained as a probability distribution over outcomes (or a point estimate + uncertainty interval).

**Update rule candidates:**

**Candidate A — Bayesian accumulation:**
Each accepted knowledge claim arrives with a posted signal $s_i$ and stake $c_i$. The update is:
$$\hat{\omega}_{t+1} = \text{BayesUpdate}(\hat{\omega}_t, s_i, w_i)$$
where weight $w_i = g(c_i, \text{track\_record}_i)$ is a credibility function combining stake size and historical accuracy.

**Candidate B — Stake-weighted average:**
Simpler. The state vector is the stake-weighted mean of all active claims. Each new claim shifts the vector proportionally to its stake. This is computable in O(1) per update.

**Candidate C — Tiered commit-reveal:**
Claims are submitted in sealed form, stakes are locked, then all claims in a batch are revealed simultaneously. The state update runs once per batch. Prevents front-running and herding.

**Best candidate for now (#r1):** Candidate C (tiered commit-reveal) with Candidate A as the aggregation function inside the reveal step. This gives manipulation resistance (sealed phase) and principled aggregation (Bayesian).

**What is conserved?** Total capital staked is conserved across the system pre-settlement. It transfers from wrong claimants to right ones and to unsatisfied bidders. No capital is created or destroyed except as platform fees.

---

## 3. Credibility Model — How Does Capital Stake Convert to Trustworthy Information?

**Surviving view (#r1):**

Core mechanism: **stake-weighted scoring with retrospective calibration.**

Step 1 — At claim time: claimant $A$ posts signal $s_A$ and locks stake $c_A$. Stake is collateral; it is not payment for placing the claim.

Step 2 — At resolution: $A$'s payout is $\text{Score}(s_A, \omega^*) \cdot c_A$ where $\omega^*$ is the resolved truth. Score is a proper scoring rule (e.g., log score, Brier score). Proper scoring rules make honest reporting dominant under expected utility maximization — this is the key.

Step 3 — Track record: Each agent accumulates a public history of $(s_i, \omega^*_i, c_i)$ tuples. Future state updates weight their claims by calibrated track record. A new claimant with no history gets downweighted.

**Why capital improves epistemics rather than just reallocating PnL:**
- Cheap talk is broken by the stake requirement. An agent who bluffs loses stake on resolution.
- Large stake + good track record = high influence on $\hat{\omega}$. This is analogous to a credibility bond.
- A well-calibrated agent earns more influence over time AND recovers stake plus profit. This creates a compounding incentive to be accurate, not just lucky.

**The key departure from LMSR:** In LMSR, anyone moving price is rewarded for being "first" or for moving in the right direction. In this mechanism, reward is tied specifically to *informational accuracy*, scored against resolution. A lucky guesser's track record doesn't compound.

---

## 4. Market Roles

**Surviving view (#r1):**

| Role | Description | Capital flow |
|------|-------------|--------------|
| **Knower (Ask side)** | Agent with private signal. Posts claim + stakes collateral. Seeks to profit from information advantage. | Stakes $c_A$. Recovers $c_A + \text{profit}$ if correct; loses partial or full stake if wrong. |
| **Unknower (Bid side)** | Agent who wants a credible state update. Posts a "question" with a bounty $b_B$. Pays for information access. | Pays bounty $b_B$. Receives updated $\hat{\omega}$ weighted by accepted claims. Does NOT receive individual signals (privacy-preserving aggregation). |
| **Validator / Oracle** | Provides the resolution signal $\omega^*$ at time $T$. | Separate trust mechanism (multisig, physical oracle, ZK proof). Receives fixed fee. |
| **Protocol** | Aggregates claims, updates state vector, settles on resolution. | Collects small % fee from settlements for solvency reserve. |

**Who pays whom?**
- Unknowers pay bounties into an escrow pool.
- Bounties are distributed to knowers proportional to their contribution to the state update (information-theoretic contribution, measurable as reduction in unknower's uncertainty).
- Knowers who were wrong forfeit stake; this goes to the solvency reserve and partially to unknowers as compensation for receiving bad information.

---

## 5. Settlement Model

**Surviving view (#r1):**

**Full resolution (truth fully observed):**
At time $T$, oracle posts $\omega^*$.
- Each knower's claim is scored: $\text{score}_i = \text{ProperScore}(s_i, \omega^*)$.
- Payout: $\text{stake}_i \cdot (\text{score}_i / \text{max\_score})$ + share of unknower bounty pool proportional to information contribution.
- Claimants with score below threshold forfeit partial stake to solvency reserve.

**Partial resolution (only some dimensions of $\omega$ are observed):**
- Score only the resolved dimensions.
- Unresolved dimensions: stakes are held in escrow. Options: (a) extend the claim window, (b) settle at current market consensus, (c) allow claims on the unresolved sub-vector to remain open.
- This is a real complexity; the mechanism must define a partial resolution schedule at market creation time.

**No resolution (oracle fails / dispute):**
- All stakes returned minus protocol fee.
- Bounties returned to unknowers.
- Track records are not updated (to avoid gaming from oracle failure).

**Key design constraint (#r1):** Partial resolution is the hardest case. A credible partial-resolution rule must be published before the market opens, or sophisticated unknowers will discount the mechanism.

---

## 6. Attack Surface

**Surviving view (#r1):**

| Attack | Description | Mitigation |
|--------|-------------|------------|
| **Bluffing / cheap talk** | Knower posts false signal hoping to collect bounty before resolution. | Proper scoring + stake forfeiture makes bluffing negative EV if stake is meaningful. |
| **Sybil claimants** | Attacker creates many low-stake identities to dilute track-record weighting. | Stake-weighted credibility — many small stakes don't add up to high influence. Identity without stake = zero signal weight. |
| **Wash credibility** | Agent builds track record on easy/low-value markets, then exploits credibility on high-value markets. | Track record should be domain-weighted and capital-weighted. Credit for easy markets decays. |
| **Collusion (knower cartel)** | Group of knowers coordinate to post the same signal to shift $\hat{\omega}$. | Diversity incentive: reward diminishes for correlated signals (log of marginal contribution). Early / independent signals earn more. |
| **Oracle gaming** | Validator manipulates $\omega^*$ to profit on staked positions. | Validator has no staked positions (barred at protocol level). Multisig / ZK oracle. |
| **Cheap unknower queries** | Unknower posts tiny bounty to extract state updates cheaply. | Minimum bounty threshold per market. State updates below threshold don't propagate to global $\hat{\omega}$. |
| **Front-running (sealed-bid broken)** | If commit-reveal has timing leaks, early reveals advantage late observers. | Cryptographic commit (hash of signal + nonce), reveal only after commit window closes. |

**Biggest unresolved attack (#r1):** **Signal laundering** — a knower with a strong private signal fragments it across many claimed "independent" signals, extracting maximum bounty while appearing to provide diverse information. Mitigation requires a correlation detection step in the aggregation layer, which adds complexity.

---

## 7. Comparison: LMSR / Orderbooks / Batch Auctions

**Surviving view (#r1):**

| Dimension | Knowledge Marketplace | LMSR | Orderbook | Batch Auction |
|-----------|----------------------|------|-----------|---------------|
| **What is exchanged** | Credibility-weighted signal | Price impact / share | Limit orders | Cleared orders per batch |
| **Who earns** | Accurate knowers + early movers | Traders who move price toward truth | Market makers + correct directional traders | Efficient allocators |
| **Role asymmetry** | Explicit (knower/unknower) | None — all are price movers | Partial (maker/taker) | None |
| **Manipulation resistance** | Stake + track record | Costly via capital, not structural | Low (spoofing, layering) | High (sealed bids) |
| **Partial truth** | Hard — must pre-define schedule | N/A — settles on binary outcome | N/A | N/A |
| **Solvency model** | Reserve from forfeited stakes | AMM reserves (always solvent by design) | Counterparty risk | Clearinghouse |
| **Epistemics** | Explicit: reward for accurate signal | Implicit: reward for correct directional price move | Implicit: reward for being on right side | Implicit |
| **Complexity** | High (track records, correlation detection, partial resolution) | Low (closed-form update) | Low (matching engine) | Medium |

**Why better:** LMSR and orderbooks reward being on the right side, but don't distinguish *why* a trader was right. A lucky guesser and a well-informed analyst get the same payoff structure. The knowledge marketplace makes informativeness structurally rewarded through proper scoring + track record compounding.

**Why worse:** Much higher complexity. Requires oracle, proper scoring rule selection, partial resolution rules, correlation detection, track record infrastructure. LMSR works with almost zero infrastructure. The gap in implementation cost is large.

---

## 8. Simplest Viable Mechanism Sketch

**Surviving view (#r1):**

**Minimal Knowledge Market (MKM):**

1. **Market creation:** Define state variable $\omega \in \{0,1\}$ (binary for simplicity), resolution time $T$, oracle address, minimum stake $c_{min}$, bounty pool $B$.

2. **Claim phase (commit):** Knower submits $H = \text{hash}(s_i || \text{nonce})$ and locks stake $c_i \geq c_{min}$. No signal is visible.

3. **Reveal phase:** At $t = T - \Delta$, commit window closes. Knowers reveal $(s_i, \text{nonce})$. Revealed signals are aggregated:
   $$\hat{\omega} = \frac{\sum_i c_i \cdot s_i}{\sum_i c_i}$$
   (stake-weighted mean, simplest aggregation).

4. **State update:** $\hat{\omega}$ is published as the market's best estimate.

5. **Resolution:** Oracle posts $\omega^*$. Payout for knower $i$:
   $$P_i = c_i + (B \cdot \frac{c_i \cdot \text{Brier}(s_i, \omega^*)}{\sum_j c_j \cdot \text{Brier}(s_j, \omega^*)}) - c_i \cdot (1 - \text{Brier}(s_i, \omega^*))$$
   Where $\text{Brier}(s, \omega^*) = 1 - (s - \omega^*)^2$ (normalized to [0,1]).

6. **Track record:** Update agent's calibration score on-chain.

This is implementable in a single smart contract. Track record oracle is the only off-chain dependency.

---

## 9. Strongest Reason This Idea Fails

**Surviving view (#r1):**

**The unknower demand problem.**

For this mechanism to work, unknowers must be willing to pay bounties for state updates they receive in aggregated, privacy-preserving form. But:

- If unknowers can observe $\hat{\omega}$ for free (public state), why pay a bounty?
- If the bounty is required to access $\hat{\omega}$, this creates a paywall on a public good (aggregate belief), which is unusual and may suppress participation.
- Real unknowers often want the *raw signal* (e.g., "who is the knower, what exactly do they know"), not the aggregated state update. The mechanism explicitly denies this.

**The result:** Unknower demand may be too low to fund sufficient knower incentives, especially when the information is partially public or derivable from other sources. The mechanism may work well in information-sparse environments but degrades as public information improves.

This is a structural demand-side failure, not just an implementation challenge.

---

## 10. Best Surviving Variant If the Raw Idea Is Wrong

**Surviving view (#r1):**

**Variant: Credibility-Gated Liquidity Provision (CGLP)**

If the bilateral knower/unknower exchange doesn't work due to demand-side failure, the best surviving variant reframes the mechanism as a *liquidity provision game* rather than an information sale:

- Knowers are **liquidity providers** who post limit orders against a shared state. Their orders are weighted by track record, not just capital.
- Unknowers are **takers** who pay a spread that is dynamically set by the knower's credibility score.
- The spread serves as the information rent: a highly credible knower quotes a tight spread (worth paying), a low-credibility knower quotes a wide spread (market disciplines them).
- Settlement is identical: proper scoring rule, stake forfeiture for wrong claims.

**Why this survives:** It reuses the familiar liquidity provision framework (unknowers already understand "pay the spread for immediacy") while embedding credibility as the determinant of spread width. It avoids the demand-side problem because takers aren't buying "information" — they're buying certainty of execution at a price, which has clear value.

**What it preserves from the core idea:**
- Knower/unknower role asymmetry
- Capital as credibility bond
- Proper scoring + track record compounding
- Stake forfeiture for inaccuracy

**What it concedes:** It reintroduces a spread/pricing mechanism, which makes it superficially similar to an AMM. The key difference is that spread is endogenously set by verified track record, not by an arbitrary curve parameter.

---

## Open Questions (tracked across runs)

- [ ] (#r1) Can partial resolution be handled without pre-commitment to a schedule? (Hard problem — likely no.)
- [ ] (#r1) What is the right proper scoring rule for continuous $\omega$ vs. binary $\omega$?
- [ ] (#r1) Signal laundering: is correlation detection computationally feasible on-chain?
- [ ] (#r1) Is CGLP variant meaningfully distinct from Uniswap v4 hooks + reputation layer, or is this just DeFi re-skinning?
- [ ] (#r1) Unknower demand: what market types (prediction markets, insurance, financial derivatives, AI training data markets) have strong enough demand to fund knower incentives?

---
_Last updated: #r1 — 2026-04-03 07:52 UTC_
