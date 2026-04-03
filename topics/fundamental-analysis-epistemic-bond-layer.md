# GDM Fundamental Analysis: The Epistemic Bond Layer

**Run:** r071  
**Date:** 2026-04-03  
**Author:** Logan (ValCtrl AI — Chief of Staff)  
**Issue:** VAL-450  
**Scope:** Full-spectrum fundamental analysis of the GestAlt Decentralized Marketplace epistemic layer concept, synthesizing prior runs r001–r070 with independent research. This document is the primary deliverable for VAL-450.

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Problem Statement and Motivation](#2-problem-statement-and-motivation)
3. [The Primitive: What Is Being Exchanged](#3-the-primitive-what-is-being-exchanged)
4. [Mechanism Architecture](#4-mechanism-architecture)
5. [Incentive-Compatibility Analysis](#5-incentive-compatibility-analysis)
6. [Comparison to Prior Art](#6-comparison-to-prior-art)
7. [Attack Surface and Failure Modes](#7-attack-surface-and-failure-modes)
8. [The Bootstrap Problem: Structural Severity Assessment](#8-the-bootstrap-problem-structural-severity-assessment)
9. [Layered Architecture: Financial Settlement + Epistemic Bond](#9-layered-architecture-financial-settlement--epistemic-bond)
10. [Open Formal Questions](#10-open-formal-questions)
11. [Research Verdict and Recommended Next Steps](#11-research-verdict-and-recommended-next-steps)
12. [Appendix: Notation Reference](#12-appendix-notation-reference)

---

## 1. Executive Summary

The GestAlt Decentralized Marketplace (GDM) epistemic layer proposal introduces a novel market primitive: the **epistemic bond** — a mechanism that exchanges credentialed belief updates (claims backed by staked capital) rather than outcome shares or price signals. Across runs r001–r070, ValCtrl's research agents developed this concept to substantial formalization. This paper synthesizes those findings, situates them in the academic literature on prediction markets, mechanism design, and information economics, and delivers a structured fundamental analysis.

**Core finding:** The epistemic bond layer is a genuinely novel contribution. It is distinct from LMSR, orderbook prediction markets, and batch auctions in its conserved quantity (epistemic utility, not price) and its bilateral information routing (knower → unknower, not public). The mechanism is theoretically incentive-compatible under truth-telling assumptions and could be self-sustaining via a fee model without market maker subsidy.

**Critical risk:** The thin-market / bootstrap problem is the mechanism's primary failure mode. Unlike LMSR — where a subsidized market maker always quotes a price — the epistemic bond market is vacuous without genuine epistemic asymmetry and credible knowers willing to stake. This is not an engineering problem; it is a structural assumption about the existence of agents with private, monetizable information.

**Recommended architecture:** Deploy the epistemic bond layer **as Layer 2 on top of GestAlt's batch clearing Layer 1**, not as a replacement. Layer 1 solves the bootstrap and liquidity problems; Layer 2 generates additional revenue from information differentiation. This hybrid architecture is the mechanism's most defensible form.

---

## 2. Problem Statement and Motivation

### 2.1 The information asymmetry gap in decentralized markets

Modern decentralized prediction markets (Polymarket, Augur, Manifold) aggregate public beliefs efficiently but fail to surface private, expert-grade information selectively. Whether using LMSR or continuous double auction, all information is treated as symmetric once entered. A forecaster with a superior private signal has no mechanism to monetize that signal directly: they can trade on it (adversarial PM), but the signal itself is uncompensated as information — only the directional bet profit matters.

This creates a structural inefficiency: **epistemic asymmetry is real and large, but current market designs have no mechanism to price or route it bilaterally.** Expert knowledge is either (a) consumed without compensation via public price observation, or (b) not entered at all (staying private).

### 2.2 The GDM design hypothesis

If we design a mechanism where capital bonds the *claim itself* rather than a directional bet, and routes that credentialed claim bilaterally to a specific consumer who pays a fee, we can:

1. Directly compensate information producers for the epistemic utility they deliver, not just their accuracy on a zero-sum bet
2. Create a self-sustaining market without a market maker subsidy (fee revenue funds rewards)
3. Produce a calibrated posterior state vector, not just a price signal distorted by liquidity effects

---

## 3. The Primitive: What Is Being Exchanged

### 3.1 Prior market primitives

| Market Type | What is Exchanged | Capital Role |
|---|---|---|
| LMSR | Outcome shares | Moves shared cost function; price = ∂C/∂q |
| Orderbook PM | Contracts between opposing bettors | Backs directional bet |
| Batch Auction | Batched orders at uniform clearing price | Backs batch order |
| **Epistemic Bond** | **Credentialed belief updates** | **Credibility bond on a specific claim** |

### 3.2 Defining the epistemic bond primitive

Let Ω be the outcome space and S ∈ Δ(Ω) be a probability distribution over outcomes. Define:

- **S_prev**: prior state distribution at start of epoch
- **S_public**: credibility-weighted posterior of all active claims
- **Claim**: a tuple (μ_i, k_i) where μ_i ∈ Δ(Ω) is knower i's reported posterior and k_i > 0 is staked capital
- **Conserved quantity**: expected KL divergence from S_prev to μ_i, weighted by stake — i.e., epistemic utility per unit capital at risk

**Definition (Epistemic Utility):**

```
EU(μ_i, S_prev) = k_i · D_KL(μ_i ‖ S_prev)
               = k_i · Σ_{ω∈Ω} μ_i(ω) · log[ μ_i(ω) / S_prev(ω) ]
```

This is zero if the claim matches the prior (no new information), positive if the claim diverges from the prior (information content), and requires ε-smoothed priors to avoid undefined values at zero-probability outcomes.

**Why this is not just renaming PM matching:** In PM matching, capital moves a public price signal visible to and influenced by all participants. Here, capital privately certifies a directional claim from a specific agent. The routing is bilateral (knower → unknower). Scoring is relative to a prior, not to an opposing order. No opposing view needs to exist — only a consumer willing to pay for a belief update.

### 3.3 Query contracts: the demand dual

*(Synthesizing r069's contribution.)* The supply primitive is the claim (μ_i, k_i). The demand primitive — underspecified before r069 — is the **query contract**:

```
QueryContract := {
  scope:            Set[coordinate_id],
  precision_class:  {T1, T2, T3},
  temporal_mode:    {snapshot | subscription | event_triggered},
  resolution_trigger: oracle_condition,
  cost_of_error:    decision_loss_function L: Ω → ℝ
}
```

Without explicit query contracts, the mechanism cannot:
- Price information delivery to heterogeneous demanders
- Differentiate snapshot buyers from subscription buyers
- Attribute reward splits when multiple buyers co-finance the same coordinate update

The **demand manifest** is an epoch-level anonymized aggregation of active query contracts:

```
DemandManifest := {
  snapshot_count:           n_s,
  subscription_count:       n_sub,
  precision_distribution:   distribution over {T1, T2, T3},
  latency_tolerance:        distribution over ℝ≥0,
  aggregate_loss_exposure:  Σ E[ L(ω) · 1_{wrong} ]
}
```

The demand manifest drives the coordination signal: which coordinates should knowers compete to update, at what precision?

---

## 4. Mechanism Architecture

### 4.1 State model

**Global state vector** S over coordinate space C. Each coordinate c_i ∈ C carries:
`(value, precision_class, evidence/interpretation split, semantic version, lineage class, transition record, provisional_status, demand_manifest)`

**Layers:**
- *Prior state* S_prev — last settled distribution
- *Pending claims layer* — {(μ_i, k_i, T_i, fees_escrowed_i)} accumulating between epoch boundaries
- *Public state estimate* S_public — epoch-level batch recomputation:

```
S_public = Σ_i  w_i · μ_i

w_i = stake_influence(k_i) · σ(α · T_i)

stake_influence(k_i) = log(1 + k_i / k_0)   [log-diminishing; normalized]
```

**Epoch discipline:** S_public is NOT updated on individual claim arrivals. Claims accumulate in the pending layer; S_public recomputes at epoch boundaries only. This prevents front-running on state updates and aligns with GestAlt's batch epoch model.

### 4.2 Credibility model

**Scoring at settlement** — for oracle-delivered ω*, knower i with claim μ_i receives:

```
R(μ_i, ω*) = k_i · [ log μ_i(ω*) − log S_prev(ω*) ]
```

- **R > 0**: claim improved on prior (KL-reducing) → knower receives reward + escrowed fees
- **R < 0**: claim degraded on prior (KL-increasing) → stake slashed; escrowed fees refunded pro-rata to reliant unknowers

**Track record update:**

```
T_i ← T_i + η · sign(R) · |R| / k_i
```

Normalized by stake to prevent high-stake calibration inflation.

### 4.3 Market roles

**Knowers (Ask side):**
- Post claims with stake. Earn: (a) fee revenue from consuming unknowers upon verified consumption; (b) scoring reward upon correct settlement.
- All fees held in escrow until settlement — no pre-settlement cash-out.
- Can post conditional claims: μ_i | Y (claim given indicator Y holds).

**Unknowers (Bid side):**
- Pay fee f to receive credentialed claim (μ_i, w_i).
- Portion of f → knower fee escrow. Portion → slash reserve.
- Option: subscribe to S_public (cheaper, less specific) or to individual knower streams.
- Post **reliance-bonds** to deter synthetic unknowing: if claim wrong and unknower relied on it, unknower receives partial compensation but also risked stake.

**Protocol layer (no market maker):**
- Claim aggregation and S_public recomputation at epoch boundaries
- Credibility-weighted matching (routes unknower to best expected KL-reduction source)
- Stake lockup and settlement
- TOWL (Total Outstanding Warranty Liability) tracking and zone gating

### 4.4 Settlement model

**Hard resolution (categorical):**

```
settle_all(ω*):
  for each claim c:
    score_c = log c.μ(ω*) − log S_prev(ω*)
    if score_c > 0:
      c.knower.receive(c.k + c.fees_escrowed + pro_rata_slash_share)
      update_track_record(c.knower, positive)
    else:
      slash_pool += c.k
      refund c.fees_escrowed to c.unknowers pro-rata by reliance
      update_track_record(c.knower, negative)
  distribute slash_pool to correct-claim unknowers pro-rata by reliance
  S_prev = δ(ω*)
  reset claims[]
```

**Soft resolution (partial oracle signal):**

```
R(μ_i, ω̃) = k_i · E_{ω* ~ ω̃}[ log μ_i(ω*) − log S_prev(ω*) ]
```

**Provisional install protocol** *(r070 contribution)*:
- Knower files provisionally before oracle confirmation: `oracle_status: pending`
- T_freshness frozen at provisional filing time — oracle latency does **not** count against staleness
- Oracle confirms → `oracle_status: confirmed`; holdback finalized
- Oracle contradicts → `oracle_status: contradicted`; auto-challenge initiated

**Two-component staleness (supersedes single scalar from r069):**

```
staleness_detection    = max(0, provisional_install_time − first_detectable_time)    // penalized
staleness_confirmation = max(0, oracle_confirm_time − provisional_install_time)       // informational only
```

Only `staleness_detection` enters holdback penalty:

```
holdback_released = holdback_base × (1 − max(0, staleness_detection / T_freshness))
```

### 4.5 TOWL and solvency gating

**TOWL definition** *(r070 closed double-counting)***:**

```
TOWL = Σ_{active coordinates} escrow_warranted(coord_i)
```

Challenge escrow is tracked on a **separate ledger** and excluded from TOWL. Pending challenges do NOT reduce TOWL until a successful resolution occurs.

**Three-zone health gate** *(r070 closed continuous-discount failure mode)*:

```
Zone A: TOWL ≤ 70% capacity  →  normal; all tiers open
Zone B: TOWL ∈ (70%, 90%)   →  T3 installs require 2× base escrow; T1/T2 unchanged
Zone C: TOWL > 90% capacity  →  T3 installs blocked; T2 require 1.5× escrow; T1 always open
```

TOWL zone does **not** discount S_cred. These are orthogonal signals (warranty capacity vs. epistemic accuracy). Conflating them creates self-reinforcing feedback collapse (see §7.2).

---

## 5. Incentive-Compatibility Analysis

### 5.1 Truth-telling as a dominant strategy

**Claim:** Under R(μ_i, ω*) = k_i · [log μ_i(ω*) − log S_prev(ω*)], truthful reporting is a Bayesian Nash Equilibrium.

**Proof sketch:**

Let knower i hold true private posterior p_i. Expected payoff from reporting μ_i:

```
E[ R(μ_i, ω*) ] = k_i · E_{ω* ~ p_i}[ log μ_i(ω*) − log S_prev(ω*) ]
                = k_i · [ H(p_i, S_prev) − H(p_i, μ_i) ]
```

where H(p, q) = −Σ_ω p(ω) log q(ω) is cross-entropy. Rewriting with KL divergence:

```
E[ R(μ_i, ω*) ] = k_i · [ D_KL(p_i ‖ S_prev) − D_KL(p_i ‖ μ_i) ]
```

The knower maximizes expected payoff by choosing μ_i to minimize D_KL(p_i ‖ μ_i). Since D_KL(p ‖ q) ≥ 0 with equality iff p = q, the unique maximizer is **μ_i = p_i**. Truth-telling is the dominant strategy. ∎

*Assumption: S_prev is fixed during the knower's decision (ensured by batch epoch discipline). Incentive-compatibility holds under sequential and simultaneous filing.*

### 5.2 Unknowers' participation constraint

An unknower pays fee f for (μ_i, w_i). Participation is rational iff:

```
E[ KL-reduction from consuming claim i ] · (value per unit uncertainty reduction) ≥ f
```

If the matching mechanism routes unknowers to the highest expected KL-reduction source at each fee level, individual rationality holds for all participating unknowers.

**Critical dependency:** Unknowers must trust that w_i is a reliable signal. If credibility weights are manipulable (see §7.3), unknowers rationally discount all w_i and participation collapses. Sybil-resistance of w_i is the critical gating precondition for unknower participation.

### 5.3 Fee equilibrium

At competitive equilibrium across multiple knowers competing for the same coordinate:

```
f* ≈ γ · k_i · ΔKL    [proportional to epistemic value delivered]
```

High-precision claims with high credibility_ratio command higher f*. Fee competition drives prices toward marginal cost of producing the private signal.

---

## 6. Comparison to Prior Art

### 6.1 LMSR (Hanson, 2003)

LMSR uses cost function C(q) = b · log Σ_j exp(q_j / b). Price of outcome j = exp(q_j / b) / Σ_k exp(q_k / b), behaving like a probability. The market maker absorbs bounded losses up to b · log N (where N = number of outcomes).

| Dimension | LMSR | Epistemic Bond |
|---|---|---|
| State update | Continuous, per-trade | Batch, per epoch |
| Liquidity | Guaranteed (MM subsidy) | Requires knower participation |
| Capital role | Moves shared cost function | Credibility bond on specific claim |
| Information routing | Symmetric, public | Bilateral, private |
| Zero-sum? | No (MM subsidizes) | No (correct knowers + unknowers both benefit) |
| Subsidy required | Yes | No (if knower population exists) |

**Epistemic bond advantage:** no subsidy; directly compensates information for epistemic value.  
**LMSR advantage:** always quotes a price; simpler; well-studied; no bootstrap dependency.

### 6.2 Orderbook Prediction Markets (Polymarket, Augur)

Polymarket uses a CLOB where opposing bettors are matched. Capital backs directional bets; profit comes from being more right than the counterparty.

**Key differences:**
- Orderbook PM is zero-sum between matched counterparties; epistemic bond is positive-sum
- No bilateral private information routing in orderbook PM
- Front-running possible in orderbook PM (mitigated in batch designs); epistemic bond batch epoch inherits GestAlt's front-run resistance

### 6.3 Batch Auction (CoW Protocol, GestAlt)

CoW Protocol collects orders off-chain, settles in batches at uniform clearing prices, auctions batches to solvers for surplus maximization. GestAlt applies this to broader market structures.

**Architectural compatibility:** The epistemic bond layer aligns naturally with GestAlt's batch epoch model. Epoch boundaries are natural settlement windows. S_public computed at each boundary can serve as an advisory oracle feed for Layer 1 instruments. This compatibility is the strongest argument for the layered architecture (§9).

### 6.4 Oracle networks (Chainlink, UMA, Pyth)

Current oracle networks aggregate data from multiple sources and report consensus values on-chain. They ensure *data availability* and *tamper-resistance* but do not reward *epistemic quality* (how much the reported value reduces uncertainty vs. a prior).

An epistemic bond layer sits **above** an oracle network: the oracle delivers ω* (Layer 2 settlement), while the epistemic bond layer rewards knowers who had better-than-prior beliefs about ω*. The two are complementary, not competing.

---

## 7. Attack Surface and Failure Modes

### 7.1 Bluffing / cheap talk

**Attack:** Stake small, earn fees before settlement, walk away even if wrong.  
**Mitigation:** All fees escrowed until settlement. Knower receives fee only if claim proves net-positive KL or stake+track-record clears threshold. Add minimum stake k_min per claim.  
**Residual:** Small marginal claims may still be profitable if fees > k_min. Managed by k_min calibration.

### 7.2 Feedback instability from TOWL–S_cred conflation

**Attack (design error, not adversarial):** Continuous TOWL discount on S_cred →
Low TOWL → S_cred discounted → unknower WTP falls → fee pool shrinks → knower reward falls → fewer quality claims → lower headroom → feedback collapse.  
**Mitigation (r070, closed):** Hard zone gates, never continuous discount. TOWL and credibility_ratio are orthogonal signals. S_cred is never modified by TOWL zone.

### 7.3 Sybil / wash credibility

**Attack:** Knower creates many identities, self-claims, builds fake track records on synthetic unknowers.  
**Mitigations:** (a) Unknowers must pay real capital — synthetic unknowing costs money. (b) Reliance-bonds double the cost of fake unknowing. (c) Correlation penalty: if two knowers' claims are highly correlated AND both wrong, neither receives scoring credit.  
**Residual (Open Q1):** Formal Sybil-attack cost lower bound has not been established. Critical gap before deployment.

### 7.4 Capital-flood disinformation

**Attack:** Rich adversary stakes large wrong claims, accepts capital loss, degrades S_public for strategic benefit.  
**Mitigation:** Log-diminishing stake influence — doubling stake does not double w_i. Persistent reputation trail makes adversarial history observable; T_i degrades multiplicatively on repeated wrong high-stake claims.  
**Residual:** Parameters k_0 and α require empirical calibration. Too steep → capital effect negligible (good for Sybil-resistance; bad for legitimate high-stake signaling). Too shallow → capital-flood attack cheaper.

### 7.5 Oracle gaming

**Attack:** Knower with oracle influence stakes, triggers favorable resolution, collects.  
**Mitigations:** (a) Oracle bonding > any possible knower stake; (b) multi-source BFT oracle; (c) mandatory delay between claim posting and oracle invocation window; (d) cross-oracle consistency requirement.  
**Status:** **Hardest attack; not fully closed.** If the knower IS the oracle source, no mechanism fully prevents manipulation without trusted hardware or long-horizon reputation. Open research problem.

### 7.6 Provisional install gaming

**Attack:** Knower delays provisional install until changepoint is semi-public, then claims zero detection staleness.  
**Mitigation:** Public-source threshold rule: if two or more independent public sources confirm the changepoint, holdback = 0 regardless of provisional_install_time. First-detectable-time must be anchored to verifiable external signals.  
**Residual:** Defining "verifiable external signal" on-chain requires careful oracle design. Timestamp manipulation is possible at millisecond scales in adversarial MEV environments.

---

## 8. The Bootstrap Problem: Structural Severity Assessment

### 8.1 The coordination equilibrium failure

The epistemic bond market has a circular dependency at launch:

1. Unknowers need credible knowers with track records before they will pay fees
2. Knowers need paying unknowers before they will stake claims
3. Before track records exist, credibility weights w_i are uninformative (all T_i = 0 → all w_i equal)
4. Rational unknowers won't pay when all claims look equally credible (uncredentialed)
5. Knowers won't stake when unknowers won't pay

This is structurally more severe than LMSR. LMSR's market maker always quotes a price regardless of participation. The epistemic bond market requires genuine epistemic asymmetry and credible knowers — neither of which exists at launch.

### 8.2 Comparison to two-sided market bootstrap

The cold-start problem in two-sided markets (Rochet & Tirole, 2003) is well-studied: platforms must subsidize one side to attract the other. The epistemic bond bootstrap problem is **harder** because the value proposition requires demonstrated track records — which require multiple resolved settlement cycles, not just the existence of knowers and unknowers. Track record divergence takes time.

### 8.3 Bootstrap strategies

| Strategy | Mechanism | Cost / Risk |
|---|---|---|
| Protocol subsidy | Subsidize knower stakes or guarantee minimum unknower fees | Capital drain; creates artificial track records |
| External credentialing | Require domain credentials as proxy for track record | Centralization risk; credentials don't map cleanly to blockchain |
| **Anchor to Layer 1** | Layer 1 provides ground truth; Layer 2 accrues track records from Layer 1 oracle resolutions | Requires Layer 1 operational first; Layer 2 value is derivative — but this is the cleanest path |
| Reputation import | Allow cross-platform track record import (e.g., Polymarket history) | Trust assumption on external platform integrity |

**Assessment:** The Layer 1 anchoring strategy is cleanest. It avoids subsidies (which distort track records) and avoids centralized credentialing (which violates decentralization). Layer 1 financial settlement provides natural oracle resolutions that bootstrap Layer 2 track records without artificial intervention.

### 8.4 The epistemic vacuum precondition

A deeper issue: LMSR extracts truth from heterogeneous *public* beliefs and doesn't require anyone to "know" things in a privileged sense. The epistemic bond market requires **genuine epistemic asymmetry** to exist and be monetizable. If no one has private information better than S_prev, the mechanism is vacuous — there is nothing to buy or sell.

**Recommendation:** Before deploying the epistemic bond layer, empirically validate that epistemic asymmetry is real and durable in the target domain. Deploy first in domains where asymmetry is structurally guaranteed — professional analysts, domain experts, or AI models with specialized training data. Avoid early deployment in near-complete-information domains.

---

## 9. Layered Architecture: Financial Settlement + Epistemic Bond

### 9.1 The case for separation

The epistemic bond layer is strongest as a **credibility and state-aggregation service layer**, not as a primary market mechanism. This conclusion is derived independently from first principles in r001 and confirmed by the bootstrap analysis in §8.

**Layer 1 — Financial Settlement (GestAlt Batch Clearing):**
- Provides: price discovery, financial settlement, liquidity, MEV resistance
- Solves: bootstrap problem (batch solver guarantees clearing)
- Ground truth source: oracle delivers ω* for Layer 1 settlement regardless of Layer 2 activity

**Layer 2 — Epistemic Bond (Credentialed Belief Layer):**
- Provides: credentialed private information routing, track record registry, S_public state aggregation
- Anchored to: Layer 1 settlement as oracle (ω* from Layer 1 resolves Layer 2 claims)
- Revenue model: subscription and per-claim fee revenue from unknowers buying credentialed state updates

### 9.2 Information flow

```
                    Layer 1: GestAlt Batch Clearing
                              │
                    Oracle resolves ω*
                              │
             ┌────────────────▼────────────────┐
             │      Layer 2 Settlement          │
             │  R(μ_i, ω*) computed             │
             │  Track records T_i updated       │
             │  S_public recomputed             │
             └────────────────┬────────────────┘
                              │
             S_public (advisory) ──► derivative instruments
                              │
             ┌────────────────▼────────────────┐
             │   Layer 1 next epoch (optional)  │
             │   S_public as advisory signal    │
             └─────────────────────────────────┘
```

**One-way coupling discipline (critical):** S_public may inform Layer 1 price discovery as an *advisory signal only* — never as a hard price anchor. Layer 1 settlement must not depend on Layer 2 in any way that allows Layer 2 epistemic manipulation to affect financial settlement.

### 9.3 Circular self-dealing risk (Open Q2)

If S_cred feeds into Layer 1 clearing price derivation, large-credibility knowers can:
1. Stake directional Layer 2 claims that move S_public
2. Simultaneously place Layer 1 bets that profit from the clearing price movement driven by their own S_public shift
3. Collect Layer 2 scoring rewards AND Layer 1 bet profits — circular self-dealing

A W_max ceiling (maximum credibility weight per knower) reduces but does not eliminate this attack. **Formal resolution requires modeling the joint L1/L2 equilibrium.** This is the most serious unresolved production risk.

### 9.4 Revenue model (conservative estimate)

At steady state, Layer 2 fee revenue per epoch:

```
Assumptions:
  - 100 active coordinates
  - avg 5 unknowers per coordinate per epoch
  - avg fee = 0.1% of avg claim stake
  - avg stake k = 1,000 units

Gross fee revenue per epoch = 100 × 5 × 1,000 × 0.001 = 500 units
Total staked = 100,000 units
Yield to knowers from fees alone ≈ 0.5% / epoch
```

Marginal but viable at daily epochs. Scoring rewards from slash pool are additive and can significantly exceed fee revenue in epochs with poor knower performance across the population.

---

## 10. Open Formal Questions

Ordered by research priority:

### Q1 (High Priority): Sybil-resistance of credibility weight

Can `w_i = σ(α · T_i) · stake_influence(k_i)` be made Sybil-proof without identity/KYC? What is the minimum cost of constructing a synthetic unknower with weight ε, as a function of ε and adversary capital? A formal lower bound on Sybil attack cost is required before deployment.

### Q2 (High Priority): L1/L2 circular self-dealing

Under what conditions can a high-credibility knower manipulate Layer 1 clearing prices via S_cred? What minimum dampening beyond W_max prevents this? Does the answer depend on the coupling mechanism (advisory vs. hard anchor)? Requires joint L1/L2 equilibrium model.

### Q3 (Medium Priority): Provisional install under adversarial oracle

If an oracle is corrupted and ω* is never delivered, a provisional install remains `oracle_status: pending` indefinitely. Timeout rule options:
- **Option A:** After T_timeout, expire provisional; return stake minus protocol fee
- **Option B:** Convert to T2 (non-binding) status
- **Option C:** Auto-challenge filed against the oracle, not the knower *(recommended — oracle failure should not penalize knowers)*

Option C requires the protocol to have oracle-level challenge capability. Design work needed.

### Q4 (Medium Priority): TOWL capacity definition — locked vs. withdrawable demander budget

If demander budgets are withdrawable within epoch, TOWL "capacity" is illusory. **Recommendation:** capacity should use locked demander budget (irrevocable within epoch) only. Define minimum lock-in period per query contract.

### Q5 (Medium Priority): Credibility_ratio under coordinate supersession

When T2 is superseded by T3, does credibility_ratio carry over? **Recommendation:** partial carry-over with continuity parameter:

```
IG_new = β · IG_old + (1 − β) · [fresh T3 IG starting at 0]
```

where β ∈ (0,1) is set by protocol governance. Prevents full retroactive tier elevation while preserving legitimate track record continuity.

### Q6 (Lower Priority): Incentive-compatibility under partial oracle signal

Under what oracle noise levels does truth-telling remain a dominant strategy? **Conjecture:** truth-telling is dominant iff the oracle's signal is an unbiased estimator of ω* with bounded variance. Formal proof needed.

---

## 11. Research Verdict and Recommended Next Steps

### 11.1 Verdict

The epistemic bond layer is a **genuine mechanism design contribution**:

- ✅ Theoretically incentive-compatible under truth-telling (§5, proof sketch)
- ✅ Distinct from LMSR, orderbook PM, and batch auctions in conserved quantity and information routing (§6)
- ✅ Self-sustaining without market maker subsidy if knower population exists (§4.3)
- ✅ Architecturally compatible with GestAlt's batch epoch model (§9)
- ✅ Positive-sum: correct knowers and unknowers both benefit (unlike zero-sum PM)

Primary risks:
- ⚠️ **Bootstrap / thin-market failure** (§8) — partially mitigated by Layer 1 anchoring
- ⚠️ **Sybil resistance** (Q1) — not formally proven; critical gap before deployment
- ⚠️ **L1/L2 circular self-dealing** (Q2) — most serious production attack; not resolved
- ⚠️ **Oracle gaming** (§7.5) — hardest attack; not fully closed without trusted hardware or long-horizon reputation

### 11.2 Recommended next steps

**Before any implementation:**

1. **Q1 (Sybil):** Derive formal Sybil-attack cost lower bound or redesign credibility weight for provable Sybil-resistance
2. **Q2 (L1/L2 coupling):** Model joint L1/L2 equilibrium with W_max ceiling; determine minimum coupling dampening
3. **Domain validation:** Empirical evidence that genuine epistemic asymmetry exists at required scale in target domain

**Near-term (parallel):**

4. Implement EpistemicBond v0 (MVP from §4.4) as simulation; test with synthetic knower populations and adversarial agents
5. Specify Q4 (TOWL capacity), Q5 (credibility_ratio under supersession), encode into protocol spec
6. Select oracle infrastructure: multi-source BFT oracle with bonding requirement > max observable knower stake

**Longer-term:**

7. Formal proof of incentive-compatibility under partial oracle signal (Q6)
8. Design and evaluate oracle timeout protocol (Q3, Option C)
9. If Layer 1 is not yet operational: design bootstrap subsidy program with track record correction mechanism to prevent artificial reputation inflation from subsidized seed period

---

## 12. Appendix: Notation Reference

| Symbol | Definition |
|---|---|
| Ω | Outcome space |
| S, S_prev, S_public | Probability distributions over Ω |
| μ_i | Knower i's reported posterior over Ω |
| k_i | Knower i's staked capital |
| T_i | Knower i's track record (rolling accuracy score) |
| w_i | Credibility weight for knower i in S_public |
| σ(·) | Logistic (sigmoid) function |
| D_KL(p ‖ q) | KL divergence from q to p |
| H(p, q) | Cross-entropy of p and q |
| EU(μ_i, S_prev) | Epistemic utility of claim μ_i given prior S_prev |
| R(μ_i, ω*) | Scoring reward for knower i given oracle outcome ω* |
| TOWL | Total Outstanding Warranty Liability |
| IG | Information Gain (cumulative KL contribution to track record) |
| T1, T2, T3 | Precision/accountability tiers |
| f | Unknower fee per credentialed claim consumed |
| k_0 | Reference stake for log-diminishing influence normalization |
| α | Sensitivity parameter for sigmoid credibility weighting |
| W_max | Maximum credibility weight per knower (anti-manipulation cap) |
| β | Continuity parameter for credibility_ratio under supersession |

---

*This analysis synthesizes GDM research runs r001–r070 with independent literature review covering LMSR mechanism design (Hanson 2003), proper scoring rules (Brier 1950; Good 1952), information market microstructure, two-sided market bootstrap theory (Rochet & Tirole 2003), oracle network design, and batch auction architecture (CoW Protocol). Primary contributions of r071: (1) formal incentive-compatibility proof sketch; (2) structured prior-art comparison table; (3) bootstrap problem severity assessment with strategic options; (4) L1/L2 layered architecture specification with coupling discipline; (5) prioritized open questions with resolution recommendations.*

*Author: Logan — ValCtrl Chief of Staff AI*
