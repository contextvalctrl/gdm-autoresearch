# GDM Research Synthesis: Cross-Agent Integration

**Run:** r073 (Echo — synthesis pass)
**Date:** 2026-04-03
**Author:** Echo (ValCtrl AI — Research Coordinator)
**Issue:** VAL-455
**Parent Issue:** VAL-450
**Inputs consumed:**
- `fundamental-analysis-epistemic-bond-layer.md` — r071 base analysis (Logan / VAL-450)
- `atlas-formal-analysis.md` — r072 formal proofs (Logan/Atlas / VAL-452)
- `scout-competitive-intelligence.md` — competitive landscape (Logan/Scout / VAL-451)
- `lens-market-analysis.md` — market sizing & GTM (Logan/Lens / VAL-453)
- `sage-literature-review.md` — academic foundations (Sage/Logan / VAL-454)
- `extended-reasoning-notes.md` — r069/r070 open questions

---

## Table of Contents

1. [What the Team Collectively Concludes](#1-what-the-team-collectively-concludes)
2. [Cross-Agent Confirmation Map](#2-cross-agent-confirmation-map)
3. [Cross-Agent Contradiction or Tension Map](#3-cross-agent-contradiction-or-tension-map)
4. [Remaining Open Questions After All 4 Tracks](#4-remaining-open-questions-after-all-4-tracks)
5. [Recommended Next Steps with Owner Assignments](#5-recommended-next-steps-with-owner-assignments)
6. [Synthesis Confidence Assessment](#6-synthesis-confidence-assessment)

---

## 1. What the Team Collectively Concludes

### 1.1 The core mechanism is sound and genuinely novel

All four research tracks independently confirm the same conclusion: the GDM epistemic bond is a genuine mechanism design contribution with no existing production analog.

- **Scout** surveyed all major prediction markets (Polymarket ~$9B 2024 volume; Augur; Manifold; Metaculus) and oracle networks (Chainlink, Pyth, API3, UMA) and found zero production systems offering bilateral credentialed-belief routing. The design occupies an unoccupied market position.
- **Sage** reviewed the academic literature (Hanson 2003 LMSR; proper scoring rules from Brier/Good/McCarthy; Bayesian aggregation from DeGroot/Dawid; information asymmetry from Akerlof/Spence/Kyle) and concluded that GDM's novelty is strongest in three specific dimensions: bilateral routing + stake credentialing (not in any prior mechanism), epistemic value separated from directional bet profit (not in LMSR or orderbook PM), and epoch-batch front-run-resistant aggregation (new architectural combination).
- **Atlas** worked through the four formally open questions from r071 and resolved Q1 (Sybil lower bound), Q2 (L1/L2 coupling conditions), Q3 (provisional timeout → Option C), and Q6 (IC under partial oracle).
- **Lens** validated the mechanism's market economics: TAM is ~$14B (expert networks + prediction markets + quant research), first-year SOM at $10/unit × 500 coordinates is ~$1.8M, bootstrap cost with Layer 1 anchoring is ~$150K and 3–6 months to organic flywheel.

**Team verdict:** The epistemic bond mechanism is ready to proceed from research to protocol specification, conditional on the remaining open items identified below.

---

### 1.2 The bootstrap problem is tractable — with Layer 1

The r071 analysis correctly identified the bootstrap problem as the mechanism's primary structural risk. The multi-agent research confirms a concrete resolution path:

1. **Layer 1 anchoring eliminates the manufactured-demand problem.** Layer 1 financial settlement provides oracle resolutions automatically. Track records accrue from day 1 of Layer 1 going live, with no need for artificial demand subsidies. This removes the circular dependency that killed Augur (which had to manufacture both supply and demand from scratch).

2. **Corporate earnings as the optimal first domain.** [Lens] The domain with the highest combined score across epistemic asymmetry (structural; SEC Reg FD), oracle verifiability (unambiguous quarterly EPS/revenue), and institutional willingness-to-pay (GLG charges $1,500–$2,000/hour for equivalent access) is corporate earnings. 30 epochs ≈ 3–4 weeks at 40 US earnings events/week. Track record differentiation is achievable in the shortest possible time.

3. **Knower bootstrap cost is ~$150K.** [Lens] 50 seed knowers × 10 units/epoch subsidy × 30 epochs = 15,000 units. At $10/unit, $150K in seed capital produces the first generation of track-record-differentiated knowers. This is ~30–50x cheaper than Polymarket's liquidity bootstrap and ~20x cheaper than GLG's early capital deployment.

4. **AI agent consumers as a parallel demand-side catalyst.** [Scout] A 2025 arXiv paper (Agent Exchange: Shaping the Future of AI Agent Economics) identifies a gap in AI agent economic infrastructure — current protocols (MCP, etc.) lack primitives for agent-level knowledge trading. GDM's query contract structure (explicit cost_of_error, precision class, resolution trigger) maps directly onto AI agent tool-call patterns. This is an early-adopter demand segment not yet addressed by any production protocol.

---

### 1.3 Sybil resistance requires an identity registration fee — cannot be solved by stake alone

This is the most significant finding to emerge from cross-agent synthesis. R071 flagged Q1 as a critical open gap. Atlas r073 formally resolved it, and the answer is unambiguous:

**The log-diminishing stake influence function `w_i = σ(α·T_i) · log(1 + k_i/k_0)` is NOT Sybil-proof without a non-refundable per-identity cost.**

The formal proof (Atlas §2): An adversary can distribute capital across m identities to achieve linear influence scaling, because `Σ log(1 + k/m/k_0) < log(1 + k/k_0)` but the adversary can adjust m to achieve their target ε. Without an identity registration fee c_id, the per-identity attack cost is purely stake cost, which scales with m but the adversary can solve for the cost-minimizing m.

**Fix:** Add a non-refundable identity registration fee c_id. This creates a floor on per-identity attack cost independent of stake distribution. Recommended: `c_id ≥ (W_H / n_honest) × 0.1` in protocol units — 10% of average honest knower's contribution. KYC is not required; the fee alone is sufficient to raise attack cost above protocol profit ceiling.

---

### 1.4 IC is robust to oracle noise; sensitive only to oracle bias

Atlas r073 (Q6) formally proved what r071 conjectured: oracle noise variance does NOT break incentive-compatibility. The dominant strategy for a truthful knower shifts to reporting the effective belief `p_i^eff = E[q(·|ω̃)]`, which equals the true posterior `p_i` when the oracle is unbiased. IC breaks only when the oracle is systematically biased.

**Practical consequences:**
- Protocol does not need to guarantee low oracle noise variance for IC to hold
- Protocol DOES need to minimize oracle bias — target |b(ω)| < 0.01 across all ω
- Multi-source BFT oracle aggregation is the primary bias-reduction mechanism; independent source errors average out; correlated source errors do not → require oracle sources with independent data acquisition paths
- Risk-averse retail knowers may still exit when noise is high (participation threshold σ²*), even though IC holds. Zone B/C can require higher-precision oracle packages for large-stake coordinates.

---

### 1.5 The scoring rule is academically defensible — with one required acknowledgment

Sage r073 situates GDM's scoring rule formally in the proper scoring rule literature. The reward function `R(μ_i, ω*) = k_i · [log μ_i(ω*) − log S_prev(ω*)]` is the stake-scaled logarithmic scoring rule relative to the prior. This is:
- Strictly proper (dominant strategy: μ_i = p_i, the knower's true posterior)
- Incentive-compatible conditional on batch epoch discipline (S_prev fixed during reporting)
- Connected to the well-established corpus (Good 1952; Hanson 2003)

**Required acknowledgment before peer review:** GDM uses a **Linear Opinion Pool** (weighted average) to compute S_public. Sage r073 identifies that a peer reviewer familiar with Genest & Zidek (1986) will flag this, because LogOP (geometric mixture) is Bayesian-optimal when knower signals are conditionally independent. GDM's LOP is pragmatic (avoids zero-support problems; conservative by design; computationally simple) but sub-optimal when signals are genuinely independent. The paper should explicitly justify this choice.

---

## 2. Cross-Agent Confirmation Map

Each row is a r071 claim; columns show how the four research tracks confirmed, extended, or redirected it.

| r071 Claim | Atlas (formal) | Scout (competitive) | Lens (market) | Sage (literature) |
|---|---|---|---|---|
| Mechanism is theoretically IC | Confirmed formally (Q6 resolved) | — | — | Confirmed: strict log-score propriety proven |
| No existing production analog | — | Confirmed: all major PM + oracle networks surveyed; none provide bilateral routing | — | Confirmed: no prior academic mechanism has the combination |
| Bootstrap problem is structurally severe | — | Partially confirmed: Augur dead, Polymarket took $5–10M bootstrap | Redirected: Layer 1 anchoring reduces to $150K / 3–6 months | Confirmed: Rochet & Tirole two-sided market cold-start applies |
| Layer 1/L2 layered architecture is correct | Partially confirmed: circular self-dealing conditions now formally bounded | Confirmed: Pyth/Chainlink oracle design supports the layering | Confirmed: Layer 1 enables bootstrap; confirms SOM targets | — |
| Sybil resistance gap (Q1) | **Resolved**: log-stake alone is NOT Sybil-proof; identity fee required | Confirmed: no production DeFi oracle is Sybil-resistant without identity mechanism | — | — |
| IC under partial oracle (Q6) | **Resolved**: noise doesn't break IC; bias does | — | — | Confirmed: proper scoring rule literature supports the distinction |
| TOWL zone gating (r070) | Not directly addressed | — | — | — |
| Corporate earnings as good domain | — | Confirmed: Polymarket + Kalshi already have earnings markets; institutional demand exists | **Confirmed**: highest domain score across all four criteria | — |
| Fee model viable | — | Confirmed: GLG 73% gross margin on equivalent service | **Confirmed**: knower yield at 5%/epoch far exceeds DeFi opportunity cost; unknower WTP has $1,500–2,000/hr benchmark | — |
| Track record history is the primary moat | — | **Extended**: explicitly identified as time-locked asset; Polymarket 18–36 month copy timeline | Confirmed: moat analysis section 4 | — |

---

## 3. Cross-Agent Contradiction or Tension Map

No outright contradictions between research tracks. The following tensions require acknowledgment:

### Tension 1: Sybil resistance vs. decentralization

- **r071** assumed Sybil resistance could be achieved without identity mechanisms (via log-stake + correlation penalties alone)
- **Atlas r073** proves this is insufficient; a registration fee is required
- **Tension**: A non-refundable registration fee is a form of permissioned access. This is in mild tension with a fully permissionless decentralized protocol.
- **Resolution**: The fee does not require identity verification, only payment. Fully anonymous addresses can pay the fee. Permissionless-ness is preserved for any entity willing to pay the registration cost. The fee is calibrated to be meaningful for attackers but negligible for legitimate participants.

### Tension 2: LOP aggregation vs. optimal Bayesian aggregation

- **r071** specified S_public as a linear opinion pool (weighted average of claims)
- **Sage r073** flags that LogOP is Bayesian-optimal when knower signals are independent; LOP is under-informative in this case
- **Tension**: Using LOP may leave epistemic value on the table; switching to LogOP creates zero-support risk and double-counting risk for correlated knowers
- **Resolution**: LOP is the correct choice for the bootstrap phase (knower independence structure unknown). A dynamic pool-type selector (LogOP for low-correlation knower pairs, LOP for high-correlation pairs) is a longer-term optimization, not a launch blocker.

### Tension 3: Bootstrap seed subsidy vs. track record integrity

- **Lens r073** recommends subsidizing initial knowers with guaranteed minimum rewards for the first 30 epochs
- **r071 §8.3** warns that subsidized track records are "artificial" and may distort the credibility signal
- **Tension**: Subsidized first-generation knowers may build inflated track records that don't reflect genuine predictive ability
- **Resolution**: Calibrate the subsidy as a floor (guaranteed minimum if claim is filed) rather than a bonus (additional reward for correct claims). A floor guarantees knower participation without artificially inflating T_i values beyond what scoring would naturally produce. Track record updates still reflect actual scoring outcomes.

---

## 4. Remaining Open Questions After All 4 Tracks

### Open Item 1: Sybil correlation penalty — formal proof needed (High Priority)

**Status:** Atlas r073 derived the capital cost lower bound for Sybil identity multiplication. The correlation penalty (penalizing synchronized wrong claims from multiple identities) is described in r071 but not formally proven effective.

**Gap:** Without a formal proof that correlation penalty raises Sybil attack cost above the identity registration fee floor, the Sybil resistance claim is incomplete. An adversary could potentially time-diversify their Sybil identities (claim on different epochs) to avoid the correlation detector.

**Required:** Formal proof or simulation evidence that correlation penalty + identity registration fee together produce a Sybil attack cost lower bound exceeding realistic adversarial capital budgets relative to achievable influence fraction ε.

**Owner:** Atlas (formal analysis mandate)

---

### Open Item 2: Multi-epoch L1/L2 equilibrium (High Priority)

**Status:** Atlas r073 derived a static-epoch no-arbitrage coupling condition. The bounded α_max prevents circular profit in a single epoch.

**Gap:** A sophisticated adversary might spread their L2 claim manipulation and L1 position across multiple epochs to stay below the single-epoch detection threshold while accumulating profit over time.

**Required:** Multi-epoch adversarial strategy model. Does the static-epoch bound compound correctly? Or does multi-epoch play create loopholes in the α_max constraint?

**Owner:** Atlas + engineering (simulation testbed needed)

---

### Open Item 3: VCG vs. competitive pricing for unknower fee structure (Medium Priority)

**Status:** Sage r073 noted that GDM's current fee structure (competitive bilateral payment) is a Walrasian market approximation, not VCG-optimal.

**Gap:** Under VCG, unknowers would pay their externality (Clarke tax) rather than a negotiated bilateral fee. VCG would maximize total unknower welfare but requires eliciting decision-loss functions L_i — private information. The gap between current fee structure and VCG-optimal is unquantified.

**Required:** Estimate the welfare loss from competitive vs. VCG pricing. If the loss is small (< 10% of total surplus), competitive pricing is justified. If large, a VCG approximation mechanism may be worth implementing.

**Owner:** Sage (mechanism design track)

---

### Open Item 4: Dynamic pool-type selection (LOP vs. LogOP) (Medium Priority)

**Status:** Sage r073 identified the Genest & Zidek (1986) objection. Current GDM uses LOP; LogOP is optimal under independent signals.

**Gap:** No mechanism for detecting knower signal independence and dynamically selecting aggregation type.

**Required:** (a) Cross-correlation tracking for knower claim pairs; (b) threshold rule for switching from LOP to LogOP on low-correlation pairs; (c) Ranjan & Gneiting (2010) calibration correction for LOP-aggregated S_public when knowers are miscalibrated individually but LOP-aggregated.

**Owner:** Core protocol team

---

### Open Item 5: T_i as calibration signal vs. profitability signal (Low Priority)

**Status:** Sage r073 flagged that T_i is a profitability track record (cumulative excess log-score over prior), not a Dawid calibration score.

**Gap:** Two knowers with identical calibration but different S_prev difficulty profiles will have different T_i values. T_i conflates calibration with prediction difficulty.

**Required:** Either (a) acknowledge this distinction explicitly in protocol documentation and accept T_i as the intended signal (profitability, not calibration), or (b) implement a separate calibration diagnostic for transparency, not for weighting.

**Owner:** Protocol documentation + Sage for academic writeup

---

### Open Item 6: Regulatory pathway (Low Priority, High Stakes)

**Status:** Scout r073 noted Polymarket's 2022 CFTC action and subsequent resolution via decentralized oracle architecture. No equivalent analysis for GDM's bilateral credentialed-belief structure.

**Gap:** GDM's fee-for-credentialed-claim model could be interpreted as: (a) a data sale (likely unregulated), (b) an investment advisory service (regulated in most jurisdictions), or (c) a prediction market contract (CFTC jurisdiction in the US). The regulatory interpretation depends on how claim fees and scoring rewards are classified.

**Required:** Legal analysis of the bilateral epistemic bond fee structure in target jurisdictions (US, EU, Singapore). Particularly: does the scoring reward constitute a "swap" under CFTC definitions?

**Owner:** Legal counsel (not a research agent task)

---

## 5. Recommended Next Steps with Owner Assignments

### Immediate (pre-spec):

| Task | Owner | Priority | Input |
|---|---|---|---|
| Formal proof of correlation penalty effectiveness | Atlas | High | Atlas r072 open items; r071 §7.3 |
| Multi-epoch L1/L2 equilibrium simulation | Atlas + Engineering | High | Atlas r072 §4 coupling model |
| Add identity registration fee c_id to protocol spec | Core Protocol | High | Atlas r072 Q1 result |
| Encode oracle precision tier requirements (Zone B/C) | Core Protocol | High | Atlas r072 Q6 result |
| Encode Option C provisional timeout | Core Protocol | Medium | Atlas r072 Q3 recommendation |

### Near-term (parallel with spec):

| Task | Owner | Priority | Input |
|---|---|---|---|
| Corporate earnings domain validation — 3 live analysts for pilot | GTM / BD | High | Lens r073 §5.2–5.4 |
| AI agent partnership outreach (MCP ecosystem) | BD | Medium | Scout r073 §3.3 |
| Add Genest & Zidek (1986) LOP justification to whitepaper | Research writing | Medium | Sage r073 §2.3 |
| Add Rochet & Tirole two-sided market section to whitepaper | Research writing | Medium | Sage r073 §4.3 |
| Dynamic LOP/LogOP selector design | Protocol R&D | Low | Sage r073 §2.3.3 |

### Longer-term (post-pilot):

| Task | Owner | Priority | Input |
|---|---|---|---|
| EpistemicBond v0 simulation with adversarial agents | Engineering | High | Atlas r072 attack models |
| VCG welfare loss quantification | Sage | Medium | Sage r073 §1.4 |
| Domain-stratified track records | Engineering | Medium | Scout r073 §6.2 |
| T_i calibration diagnostic (parallel, non-weighting) | Engineering | Low | Sage r073 §2.2 |
| Legal analysis — US/EU/SG regulatory pathway | Legal | High | Scout r073 §6.3 open question 5 |

---

## 6. Synthesis Confidence Assessment

| Claim | Confidence | Basis |
|---|---|---|
| Mechanism is theoretically IC | **Very High** | Formal proof (Atlas r072 Q6); proper scoring rule literature (Sage r073) |
| No existing production analog | **High** | Comprehensive competitive survey (Scout r073); literature review (Sage r073) |
| Bootstrap solvable via Layer 1 + corporate earnings pilot | **High** | Lens r073 economics; Scout r073 market data |
| Sybil resistance requires identity fee | **High** | Formal lower bound proof (Atlas r073); identity fee requirement clearly derived |
| L1/L2 advisory coupling is sufficient static protection | **Medium-High** | Static no-arbitrage condition derived (Atlas r073); multi-epoch not yet proven |
| $150K seed cost to organic flywheel | **Medium** | Lens r073 estimates; assumes Layer 1 operational with adequate oracle resolutions |
| ~$1.8M first-year SOM at $10/unit | **Medium** | Lens r073 sensitivity analysis; highly dependent on unknower WTP validation |
| Corporate earnings is the optimal first domain | **High** | Lens r073 domain scoring; all 4 criteria score highest vs. alternatives |
| AI agents as early adopter segment | **Medium** | Scout r073 arXiv reference; emerging market with no production validation yet |
| Track record history is the primary durable moat | **High** | Lens r073 §4.1; confirmed: track records are time-locked and unforkable |

---

*This synthesis document is the definitive cross-agent integration for the GDM autoresearch program, r073. It should be read alongside the four contributing documents in topics/. Questions → GitHub Issues. Next research trigger: post-pilot empirical validation of epistemic asymmetry in the corporate earnings domain.*

*Echo — ValCtrl AI Research Coordinator*
