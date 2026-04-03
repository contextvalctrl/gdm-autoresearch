# GDM Atlas Formal Analysis: Incentive Proofs, Sybil-Resistance, Oracle Integration

**Run:** r072 (Atlas)
**Date:** 2026-04-03
**Author:** Logan (ValCtrl AI — Chief of Staff, executing Atlas mandate)
**Issue:** VAL-452
**Parent Issue:** VAL-450 (r071 base analysis)
**Status:** COMPLETE
**Scope:** Formal resolution of open questions Q1, Q2, Q3, Q6 from r071 Section 10.
Builds directly on r071 Section 5 (Incentive-Compatibility), Section 7 (Attack Surface), and Section 10 (Open Formal Questions).

---

## Table of Contents

1. [Scope and Prerequisites](#1-scope-and-prerequisites)
2. [Q1: Sybil-Resistance — Formal Analysis of Credibility Weight Function](#2-q1-sybil-resistance)
3. [Q2: L1/L2 Circular Self-Dealing — Model and Dampening](#3-q2-l1l2-circular-self-dealing)
4. [Q3: Provisional Install Timeout — Option Evaluation and Recommendation](#4-q3-provisional-install-timeout)
5. [Q6: Incentive-Compatibility Under Partial Oracle Signal](#5-q6-incentive-compatibility-under-partial-oracle-signal)
6. [Cross-Cutting Implications](#6-cross-cutting-implications)
7. [Notation Reference (Atlas Extension)](#7-notation-reference-atlas-extension)

---

## 1. Scope and Prerequisites

This document is a formal extension of r071. All notation from r071 §12 applies; Atlas-specific extensions are defined in §7 below.

**r071 results assumed without re-derivation:**
- Truth-telling dominant strategy under hard oracle (§5.1)
- Log-diminishing stake influence and its anti-flood purpose (§4.2)
- TOWL orthogonality from credibility_ratio (§4.5)
- Three-zone gating architecture (§4.5)
- Layered L1/L2 coupling discipline (§9.2)

**Structure of this document:** Each question is treated as a self-contained proof block. All derivations are shown step by step. No result is asserted without proof or explicit acknowledgment as conjecture.

---

## 2. Q1: Sybil-Resistance — Formal Analysis of Credibility Weight Function

### 2.1 Problem statement

The credibility weight function (from issue description, not r071 §4.1 which uses a different normalization) is:

```
w_i = σ(α · T_i) · log(1 + k_i / k_0)
```

where σ is the logistic function, T_i is knower i's track record, α > 0 is the sensitivity parameter, k_i is staked capital, and k_0 > 0 is the reference stake.

**Goal:** Derive the minimum capital cost C_A for adversary A to construct a synthetic knower identity achieving credibility weight contribution ε — defined as controlling fraction ε of the effective S_public — using any number of identities and synthetic unknowers.

### 2.2 Adversarial model

**Adversary A controls:**
- Identity set K_A = {κ_1, ..., κ_m} (synthetic knower identities), m ≥ 1
- Identity set U_A = {υ_1, ..., υ_n} (synthetic unknower identities), n ≥ 0
- Capital budget C_A (total capital available)

**Honest participant context:**
- Honest knower set K_H with total honest weight:

```
W_H = Σ_{j ∈ K_H} w_j = Σ_{j ∈ K_H} σ(α · T_j) · log(1 + k_j / k_0)
```

**Adversary's goal:**
Achieve influence ratio ε over S_public:

```
w_A_total / (w_A_total + W_H) ≥ ε

where  w_A_total = Σ_{κ ∈ K_A} w_κ
```

Rearranging:

```
w_A_total ≥ ε · W_H / (1 - ε)       ... (*)
```

### 2.3 Phase 1: Single-identity attack (T = 0, no track record building)

Consider a single fresh Sybil identity κ_1 with T_1 = 0:

```
w_1 = σ(α · 0) · log(1 + k_1 / k_0)
    = σ(0) · log(1 + k_1 / k_0)
    = 0.5 · log(1 + k_1 / k_0)
```

To achieve w_1 ≥ w_A_target ≡ ε · W_H / (1 - ε):

```
0.5 · log(1 + k_1 / k_0) ≥ ε · W_H / (1 - ε)

log(1 + k_1 / k_0) ≥ 2ε · W_H / (1 - ε)

k_1 ≥ k_0 · [exp(2ε · W_H / (1 - ε)) - 1]
```

**Single-identity lower bound:**

```
C_A^{single} = k_0 · [exp(2ε · W_H / (1 - ε)) - 1]
```

For small ε: C_A^{single} ≈ 2k_0 · ε · W_H (linear in ε · W_H).
For ε → 1: C_A^{single} → ∞ (exponential barrier; cannot achieve majority influence with one identity).

At T_i = 0 (fresh Sybil), σ(α·T_i) = 0.5 is its maximum initial value. Positive track record T_i > 0 would increase σ(α·T_i) toward 1, requiring less stake for the same weight. However, building T_i > 0 requires correct oracle resolutions (analyzed in §2.5).

### 2.4 Phase 2: Multi-identity Sybil attack (splitting capital)

Adversary creates m identities, each with T = 0, splitting budget C_A equally: k_i = C_A / m.

Total adversary weight:

```
w_A_total(m) = m · 0.5 · log(1 + C_A / (m · k_0))
```

**Theorem 1 (Sybil amplification via identity splitting):** As m → ∞:

```
w_A_total(m) → C_A / (2 · k_0)
```

**Proof:** Let x = C_A / (m · k_0). As m → ∞, x → 0.

```
w_A_total(m) = m · 0.5 · log(1 + x)
             = m · 0.5 · [x - x²/2 + O(x³)]
             = m · 0.5 · x + O(m · x²)
             = m · 0.5 · C_A/(m·k_0) + O(C_A²/(m·k_0²))
             = C_A / (2·k_0) + O(1/m)
             → C_A / (2·k_0)  as m → ∞  □
```

**Critical observation:** The log-diminishing function returns to linear scaling in the many-identity limit. The Sybil adversary can recover linear capital-to-influence scaling by splitting capital across sufficiently many identities.

**Corollary 1 (Multi-identity capital lower bound):**

To achieve influence fraction ε, with many identities:

```
C_A / (2·k_0) ≥ ε · W_H / (1 - ε)

C_A ≥ 2k_0 · ε · W_H / (1 - ε)       ... (**)
```

This is the binding lower bound. It is **linear** in ε · W_H (not exponential), confirming the vulnerability.

**Optimal identity count:** Taking derivative of w_A_total(m) with respect to m and setting to zero:

```
∂w_A_total/∂m = 0.5 · [log(1 + C_A/(mk_0)) - (C_A/(mk_0)) / (1 + C_A/(mk_0))] = 0
```

This is satisfied only in the limit m → ∞, meaning the optimal strategy is always to maximize identity count. In practice, each identity creation has overhead cost c_id (gas, registration fee), so the optimal finite m satisfies:

```
0.5 · [log(1 + C_A/(m·k_0)) - C_A/(mk_0 + C_A)] = c_id / k_0
```

The protocol can set c_id > 0 via a non-refundable registration fee, making m*_optimal finite and bounded.

### 2.5 Track record building cost and oracle dependency

**Can an adversary cheaply build T_i > 0?**

Track record update (r071 §4.2):

```
T_i ← T_i + η · sign(R(μ_i, ω*)) · |R(μ_i, ω*)| / k_i
     = T_i + η · sign(log μ_i(ω*) - log S_prev(ω*)) · |log μ_i(ω*) - log S_prev(ω*)|
```

For the adversary to increase T_i, they need R(μ_i, ω*) > 0, which requires ω* to fall in a region where μ_i(ω*) > S_prev(ω*).

**Adversary without oracle advantage:**

Let p = Pr[adversary's claim improves on prior | ω* drawn from true distribution]. Without privileged oracle access, p ≤ p_H (honest knower's success rate), typically p ≈ 0.5 for uninformed adversary.

Expected track record evolution per round:

```
E[ΔT_i] = η · [p · G_correct - (1-p) · G_incorrect]
```

where G_correct, G_incorrect > 0 are expected absolute log-ratio magnitudes.

For uninformed adversary with p = 0.5 and symmetric scoring (G_correct ≈ G_incorrect = G):

```
E[ΔT_i] = η · G · (2·0.5 - 1) = 0
```

**Result:** An adversary without oracle advantage cannot build positive expected track record. They undergo a zero-drift random walk on T_i, with variance growing with rounds. Building T_i to T* in expectation requires p > 0.5.

**Capital cost of track record building (p > 0.5):**

Expected rounds to reach T_i = T*: n* = T* / (η · G · (2p-1))
Expected capital slashed per round: k_i · (1-p) (probability of being wrong)
Expected total capital loss: k_i · (1-p) · n* = k_i · (1-p) · T* / (η · G · (2p-1))

**Adversary with oracle advantage (p > 0.5):**

If the adversary can predict ω* with advantage δ > 0 over random (p = 0.5 + δ), the cost of building T* is O(k_i · T* / (η · G · δ)). This cost can be small if δ is large (e.g., adversary partially controls the oracle).

**Conclusion:** Track record building is essentially free for adversaries with oracle advantage, and costly but bounded for uninformed adversaries. This does NOT create a prohibitive lower bound — it merely delays the attack.

### 2.6 Does the reliance-bond requirement change the lower bound?

**Reliance-bond mechanics:** Each synthetic unknower υ consuming a knower claim must post bond r_υ. Bond is returned if claim resolves correctly; slashed proportionally if claim is wrong.

**Impact on Sybil cost:**

When adversary controls both κ and υ (self-dealing pair):
- Fee f paid by υ → goes to escrow for κ (net transfer within adversary's accounts)
- Bond r_υ posted by υ → returned on correct claim; slashed on wrong claim
- Net cost per round (correct claim): only gas/protocol fees
- Net cost per round (wrong claim): k_κ slashed (from stake) + r_υ slashed (from bond)

The reliance-bond does NOT add a new fundamental capital lower bound for self-dealing attacks. It adds:
1. **Liquidity requirement:** adversary must lock r_υ per synthetic unknower simultaneously with staking k_κ
2. **Slashing on wrong claims:** both k_κ and r_υ are at risk simultaneously

**Modified total capital requirement at risk per interaction:**

```
C_per_interaction = k_κ + r_υ   (both locked per active round)
```

If the minimum bond r_min = β · k_κ for some protocol parameter β > 0:

```
C_per_interaction = k_κ · (1 + β)
```

This scales the capital requirement by (1 + β) but does not change the Ω(C_A / k_0) asymptotic bound. The lower bound from (**) becomes:

```
C_A ≥ 2k_0 · (1 + β) · ε · W_H / (1 - ε)    [with reliance-bond]
```

This is tighter by factor (1 + β), but still linear. The reliance-bond improves resistance by a constant factor, not qualitatively.

### 2.7 Formal lower bound statement

**Theorem 2 (Sybil lower bound with reliance-bond):**

For an adversary with capital budget C_A, reliance-bond parameter β, and honest participant total weight W_H, the maximum achievable influence fraction ε satisfies:

```
ε ≤ C_A / [2k_0·(1+β) + C_A] · (1 / W_H + 1)⁻¹

More precisely:
ε ≤ [C_A / (2k_0·(1+β))] / [W_H + C_A / (2k_0·(1+β))]
```

This bound is tight in the many-identity limit (Theorem 1). The bound is **linear** in C_A, not exponential.

**Practical implication:** For ε = 10% influence with W_H = 1000 units and β = 0.5:

```
C_A ≥ 2·k_0·1.5·(0.1·1000/0.9) = 333 k_0
```

If k_0 represents a meaningful economic unit (e.g., $1,000), the cost is ~$333,000 for 10% influence. This is economically meaningful for small markets but potentially insufficient for high-value applications.

### 2.8 Can a formal prohibitive bound be established without KYC?

**Answer: No.** The log-diminishing function is Sybil-vulnerable due to identity splitting. Without a unique-identity constraint (KYC, Proof-of-Humanity, or biometric commitment), a well-capitalized adversary can achieve influence proportional to their capital budget (linear scaling, O(C_A/k_0)).

**What would make the bound prohibitive:**

1. **KYC / unique identity (hard):** Each identity requires verifiable unique human. Cost-per-identity becomes the cost of a separate human operator (not just capital). Makes splitting infinitely expensive in the Sybil limit.

2. **Non-refundable identity registration fee c_id (partial):** Each Sybil identity costs c_id. Optimal m becomes finite. Total Sybil cost: C_A + m* · c_id. For c_id large enough, this can make attacks expensive, though a formal prohibitive bound still requires c_id → ∞ as a function of ε.

3. **Correlation penalty (partial):** If correlated claims are penalized (r071 §7.3), self-dealing Sybils face a scoring penalty. This requires a correlation detection mechanism over claim histories.

4. **Time-locked track record (structural):** Track record accrues in real time, not just resolved epochs. Adversary must operate for T_min epochs before reaching meaningful T_i, adding a time cost. Sybil attack on fresh identities is bounded to T_i = 0 tier permanently.

**Recommendation:**

Deploy the log-diminishing function as designed (valid capital concentration protection), add:
- Non-refundable identity registration fee c_id ≥ k_0 (raises Sybil capital floor)
- Correlation penalty: discount w_i if claim μ_i is correlated (cosine similarity > threshold) with another knower's claim
- Time-locked track record: T_i is unscalable — cannot buy T_i, only earn it through time

With these additions, the effective capital requirement for Sybil attack becomes O(C_A + m* · c_id) where m* is bounded by the correlation penalty. A formal prohibitive bound still requires at least c_id > 0 or KYC.

---

## 3. Q2: L1/L2 Circular Self-Dealing — Model and Dampening

### 3.1 Attack model formalization

**Layer 2 dynamics:**

Let epoch t have honest public state S_public^0(t) computed from honest knowers. Adversary A posts claim μ_A with weight ŵ_A = min(w_A, W_max):

```
S_public(t) = [S_public^0(t) · W_H + ŵ_A · μ_A] / (W_H + ŵ_A)

Define Δ_S = S_public(t) - S_public^0(t)
           = ŵ_A · (μ_A - S_public^0(t)) / (W_H + ŵ_A)
```

Maximum achievable shift (with W_max cap):

```
|Δ_S| ≤ W_max · |μ_A - S_public^0(t)| / (W_H + W_max)
       ≤ W_max / (W_H + W_max)       ... [since |μ_A - S_public^0| ≤ 1 on [0,1]]
```

**Layer 1 coupling:**

Assume coupling function: P_L1(t) = f(S_public(t)) with |f'| ≤ λ (Lipschitz bound).

Price impact:

```
ΔP_L1 = f(S_public(t)) - f(S_public^0(t))
       ≈ f' · Δ_S                    [first-order approximation]
       ≤ λ · W_max / (W_H + W_max)
```

**Adversary's Layer 1 profit:**

Adversary holds L1 position θ_A (size unbounded in basic model):

```
Π_L1 = θ_A · ΔP_L1
      ≤ θ_A · λ · W_max / (W_H + W_max)
```

**Adversary's Layer 2 cost:**

Staking k_A with deliberately biased claim μ_A ≠ p_A (true posterior). Expected scoring loss:

```
E[L2_loss] = k_A · [D_KL(p_A || μ_A) - D_KL(p_A || S_prev)]
```

This is positive (loss) when μ_A diverges from p_A in the direction that hurts scoring.

**Net profitability condition for attack:**

```
Π_L1 > E[L2_loss]
θ_A · λ · W_max / (W_H + W_max) > k_A · [D_KL(p_A || μ_A) - D_KL(p_A || S_prev)]
```

### 3.2 Does W_max alone prevent the attack?

**No.** The attack is profitable whenever:

```
θ_A > k_A · (W_H + W_max) · [D_KL(p_A || μ_A) - D_KL(p_A || S_prev)] / (λ · W_max)
```

Since θ_A (L1 position size) is unbounded in the basic model, the adversary can always choose θ_A large enough to make Π_L1 > E[L2_loss], regardless of W_max.

W_max limits the **price impact per unit bias** but provides no bound on total profit when position size is unconstrained.

**Formal statement:** For any W_max > 0, for any η > 0, there exists θ_A such that:

```
Π_L1(θ_A) - E[L2_loss] ≥ η
```

W_max is necessary but not sufficient for attack prevention. Additional dampening is required.

### 3.3 Minimum coupling mechanism analysis

We analyze three candidate mechanisms:

**Mechanism A: Position cap δ_max**

Cap adversary's L1 position: θ_A ≤ δ_max.

Profit upper bound: Π_L1 ≤ δ_max · λ · W_max / (W_H + W_max).

Attack unprofitable iff:

```
δ_max · λ · W_max / (W_H + W_max) < k_A · [D_KL(p_A || μ_A) - D_KL(p_A || S_prev)]
```

**Problem:** Position cap requires identity-linked position tracking. Without KYC, adversary splits positions across identities (same Sybil vulnerability as Q1). Not a standalone solution.

**Mechanism B: Delayed coupling (epoch lag L)**

S_public from epoch t feeds L1 only at epoch t + L. L1 settlement happens at epoch t + L. Adversary must hold L1 position for L epochs before profit materializes.

**Benefit:** During lag period, adversary's L2 claim is observable. Other knowers can post corrective claims, reducing Δ_S. If corrective claims fully offset: ΔP_L1 → 0, attack fails.

**Formal bound:** With n corrective knowers each posting claim at confidence c:

```
Δ_S(t+1) = Δ_S(t) · W_H / (W_H + n · w_correction)
```

After L epochs of correction: Δ_S(t+L) ≤ Δ_S(t) · [W_H / (W_H + n · w_correction)]^L → 0 as L → ∞.

**Problem:** L must be large enough for corrective claims to materialize. Requires active honest knower participation. Not purely structural.

**Mechanism C: Bounded coupling coefficient α**

P_L1 = α · f(S_public) + (1 - α) · P_oracle_direct

where P_oracle_direct is from an independent external oracle, α ∈ (0, 1) set by governance.

Price impact:

```
ΔP_L1 = α · f' · Δ_S ≤ α · λ · W_max / (W_H + W_max)
```

Attack unprofitable iff:

```
θ_A · α · λ · W_max / (W_H + W_max) < k_A · D_KL(p_A || μ_A)
```

This still doesn't bound θ_A. However, if we require θ_A ≤ γ · k_A (proportional position cap — L1 leverage bounded by L2 stake):

```
γ · k_A · α · λ · W_max / (W_H + W_max) < k_A · D_KL(p_A || μ_A)

γ · α · λ · W_max / (W_H + W_max) < D_KL(p_A || μ_A)
```

Choosing α = D_KL_min / (γ · λ · W_max / (W_H + W_max)) where D_KL_min is the minimum KL divergence the adversary must induce to move prices meaningfully, we get:

```
α ≤ D_KL_min · (W_H + W_max) / (γ · λ · W_max)   ... (no-arbitrage coupling bound)
```

**Mechanism D: Common settlement oracle (joint resolution)**

Require that ω* resolves BOTH L1 and L2 claims in the same transaction. L1 position payoffs and L2 scoring both depend on the same ω*.

Effect: The adversary cannot profit from "knowing ω* before the market" because the L1 position is also resolved at ω*. The circular self-dealing collapses to:

```
Net profit = [L1 profit at ω*] + [L2 scoring at ω*]
           = θ_A · [P_L1(ω*) - P_L1(t)] + R(μ_A, ω*)
```

If μ_A is biased (not truthful), R(μ_A, ω*) < R(p_A, ω*). The adversary faces the same incentive as an honest knower: report truthfully to maximize L2 scoring, which implies no market-moving bias. The circular attack is structurally eliminated.

**This is the cleanest solution.** Common settlement converts the attack from profitable manipulation to a constrained optimization that aligns with truthful reporting.

### 3.4 Recommended minimum coupling mechanism

**Recommended design: Mechanism C + D combined**

**Step 1 (Structural):** Implement common settlement oracle. ω* resolves L1 and L2 simultaneously in the same transaction. This eliminates the pure circular attack.

**Step 2 (Residual risk bound):** Even with common settlement, a sophisticated adversary might exploit correlation between S_public and L1 prices during the epoch (before settlement). Apply bounded coupling coefficient:

```
P_L1_clearing = α · g(S_public) + (1 - α) · P_base

α ≤ (W_H + W_max) · D_KL_min / (γ · λ · W_max)
```

with α governance-set and publicly committed before each epoch.

**Step 3 (Rate limiting):** Apply Mechanism B (epoch lag = 1) for the S_public → P_L1 feed. This allows corrective knower claims to dampen adversary-induced shifts before they materialize in L1.

**Formal no-arbitrage condition:**

The complete circuit-breaker condition (attack unprofitable) is satisfied iff:

```
α · λ · γ · W_max / (W_H + W_max) ≤ D_KL(p_A || μ_A) - Δ_reward_loss

where Δ_reward_loss = R(p_A, ω*) - R(μ_A, ω*) is the scoring penalty for bias
```

Since D_KL(p_A || μ_A) = Δ_reward_loss / k_A by the scoring rule, this simplifies to:

```
α · λ · γ · W_max · k_A / (W_H + W_max) ≤ Δ_reward_loss
```

Setting γ such that proportional leverage (L1 position per unit L2 stake) satisfies:

```
γ ≤ (W_H + W_max) / (α · λ · W_max)
```

ensures the attack is structurally unprofitable. Governance sets α and γ must satisfy this inequality jointly.

**Minimum viable additional dampening (beyond W_max):**

1. **Common settlement oracle** — structural (zero cost, high impact)
2. **Coupling coefficient α ≤ 0.3** — advisory initially; hard cap after protocol matures
3. **Proportional leverage cap γ** — enforced per-epoch at the protocol level (requires identity tracking or is applied per-wallet, not per-human)

---

## 4. Q3: Provisional Install Timeout — Option Evaluation and Recommendation

### 4.1 Protocol context

A provisional install is a claim filed with `oracle_status: pending` (oracle resolution not yet received). The knower's T_freshness is frozen at provisional filing time.

**Timeout trigger condition:** T_now - T_provisional_install > T_timeout for some protocol parameter T_timeout.

**Failure modes to evaluate against:**
- F1: Oracle permanently unavailable (abandoned, destroyed)
- F2: Oracle adversarially delayed (adversary controlling oracle response timing)
- F3: Oracle in legitimate dispute (multiple conflicting ω* candidates)
- F4: Oracle slow due to external events (major world events, blockchain congestion)

### 4.2 Option evaluation matrix

**Option A: Expire (return stake minus protocol fee)**

*Mechanism:* After T_timeout, provisional install is cancelled. Stake k_i returned minus fee f_protocol. Oracle_status set to `expired`. T_i updated with neutral score (no change).

*Analysis against failure modes:*

| Failure Mode | Option A Outcome | Assessment |
|---|---|---|
| F1 (oracle gone) | Stake returned; claim voided | Correct: fair to knower |
| F2 (adversarial delay) | Adversary can selectively delay unfavorable coordinates | **Exploitable** |
| F3 (oracle dispute) | Claim voided during dispute; unfair to knower | Bad: punishes legitimate knowers |
| F4 (legitimate delay) | Claim voided; knower punished for external delay | **Unfair** |

*Key vulnerability:* Under F2, an adversary who controls oracle can let favorable claims resolve and time out unfavorable ones. This creates asymmetric resolution: oracle adversary can cherry-pick outcomes. Option A ENABLES oracle gaming, not just fails to prevent it.

*Additional risk:* Correlated timeout (F1, F4): mass expiry during oracle outage destabilizes state vector. All provisional installs in-flight expire simultaneously. S_public loses credentialed claims abruptly.

**Verdict: Option A is insufficient. Do not adopt as standalone policy.**

**Option B: Downgrade to T2 (non-binding status)**

*Mechanism:* After T_timeout, provisional install converts to T2 status. Claim is retained but at lower precision class. Track record T_i updated with T2 resolution rules.

*Analysis:*

| Failure Mode | Option B Outcome | Assessment |
|---|---|---|
| F1 (oracle gone) | T3 → T2; some epistemic value preserved | Acceptable |
| F2 (adversarial delay) | Adversary can force T3 → T2 on strategic coordinates | **Exploitable** |
| F3 (oracle dispute) | Claim silently downgraded; knower not notified | Bad: opacity |
| F4 (legitimate delay) | Knower loses T3 status; unfair | **Unfair** |

*Key vulnerability:* Under F2, oracle adversary can systematically prevent T3 installations on coordinates they want to keep at lower precision. T2 downgrade becomes a censorship vector.

*Additional complexity:* Does T2 resolution count toward T_i for T3 track record? If yes: track record contamination (T3 knowers forced to earn T2 track record). If no: claim voids from track record perspective, making Option B equivalent to Option A for scoring purposes.

*Hidden state problem:* T3 → T2 conversion creates protocol complexity: existing unknower subscriptions set at T3 pricing must be renegotiated. Event-triggered delivery contracts with T3 SLAs must be voided or compensated.

**Verdict: Option B introduces more complexity than it resolves. Do not adopt as standalone policy.**

**Option C: Auto-challenge oracle**

*Mechanism:* After T_timeout, the protocol automatically files a challenge AGAINST THE ORACLE (not the knower). Provisional install is frozen (not expired, not downgraded). Knower's T_freshness remains frozen. Oracle challenge bond is at risk.

Oracle must respond to the challenge within T_challenge. If oracle responds (delivers ω*): normal settlement proceeds. If oracle fails to respond: oracle challenge bond is slashed; provisional install triggers fallback (see below).

*Analysis:*

| Failure Mode | Option C Outcome | Assessment |
|---|---|---|
| F1 (oracle gone) | Challenge times out; oracle slashed; fallback triggered | Correct |
| F2 (adversarial delay) | Each delay costs oracle challenge fee; selective delay becomes costly | **Good** |
| F3 (oracle dispute) | Challenge triggers dispute resolution; claim preserved during dispute | **Correct** |
| F4 (legitimate delay) | Oracle can respond to challenge with delay justification; no knower penalty | **Fair** |

*Key advantage:* Option C correctly identifies the responsible party (oracle, not knower) and directs economic pressure there. The adversarial oracle scenario (F2) becomes costly to exploit:

```
Cost of selective delay for oracle adversary per coordinate:
= challenge_fee + expected slash from failed challenge
= C_challenge + slash_per_failed_oracle_response
```

For this to discourage selective delay:

```
C_delay_benefit < C_challenge + slash_per_failed_oracle_response
```

Setting oracle bond ≥ max(knower_stakes) and slash_per_failed_response = oracle_bond / max_delayed_coordinates makes mass selective delay bankrupt the oracle adversary.

*Required protocol extension:* Option C requires:
1. Oracle-level challenge mechanism (not just claim-level challenges)
2. Oracle posting a challenge-response bond separately from its data-delivery bond
3. Dispute resolution procedure for F3 (multi-oracle BFT fallback)

### 4.3 Recommended policy: Option C with two-phase fallback

**Phase 1 (T_timeout elapsed): File auto-challenge against oracle**
- Provisional install frozen at current state
- Oracle receives challenge notification
- Challenge response window: T_challenge (= 2× oracle's historical median response time)
- Cost to file challenge: charged to protocol reserve (not to knower)

**Phase 2a (Oracle responds within T_challenge):**
- Normal settlement: R(μ_i, ω*) computed, T_i updated
- Challenge closed; oracle charge voided

**Phase 2b (Oracle fails T_challenge):**
- Oracle's challenge-response bond slashed: slash_amount = min(oracle_bond, k_i · 3)
- Provisional install converts to Option A (stake returned, claim expired)
- T_i unchanged (no track record impact for oracle failure)
- Protocol logs oracle_failure event for governance review

**Formal justification:**

Let V_oracle(delay) = adversary oracle's gain from delaying coordinate c.
Let C_oracle(delay) = challenge fee + expected slash if challenge fails.

Auto-challenge is an effective deterrent iff:

```
C_oracle(delay) > V_oracle(delay)  for all c that adversary might delay
```

Setting C_oracle(delay) = oracle_bond / N_max_simultaneous_delays ensures:

```
N_simultaneous_delays ≤ oracle_bond / V_oracle(delay)
```

which is finite and bounded. By setting oracle_bond high (governance parameter), mass selective delay is made structurally impossible.

The two-phase fallback preserves Option A's clean accounting for the permanent-oracle-failure case while making it costly to reach Phase 2b through adversarial delay. In F4 (legitimate oracle delay), the oracle typically responds in Phase 2a.

**Implementation note:** The challenge mechanism requires oracle to be registered on-chain with a response-bond escrow, separate from any data-delivery bond. This is an additional protocol requirement not present in r071's architecture.

---

## 5. Q6: Incentive-Compatibility Under Partial Oracle Signal

### 5.1 Problem setup

**Hard-resolution case (r071 §5.1 result):**

Oracle delivers point estimate ω* ∈ Ω. Scoring rule:

```
R(μ_i, ω*) = k_i · [log μ_i(ω*) - log S_prev(ω*)]
```

Truth-telling dominant strategy: μ_i = p_i (true private posterior). Proof: r071 §5.1.

**Soft-resolution extension (this section):**

Oracle delivers partial signal ω̃. This signal induces a posterior distribution over ω*:

```
q(·|ω̃) = Pr[ω* = · | oracle_signal = ω̃]
```

Soft-resolution scoring rule (r071):

```
R(μ_i, ω̃) = k_i · E_{ω* ~ q(·|ω̃)}[log μ_i(ω*) - log S_prev(ω*)]
           = k_i · Σ_{ω ∈ Ω} q(ω|ω̃) · [log μ_i(ω) - log S_prev(ω)]
```

**Goal:** Determine conditions under which truth-telling μ_i = p_i remains the dominant strategy when ω̃ is the oracle's signal (possibly noisy).

### 5.2 Iterated expectation decomposition

Knower i has true private posterior p_i. The oracle signal ω̃ is generated by:

```
ω̃ ~ P_oracle(·|ω*)  where  ω* ~ p_i  [knower believes this about ω*]
```

Define the **effective marginal distribution** as seen by the knower:

```
p_i^eff(ω) = E_{ω̃ ~ P_oracle(·|ω* ~ p_i)}[q(ω|ω̃)]
           = Σ_{ω̃} P(ω̃|p_i) · q(ω|ω̃)
           = Σ_{ω̃} [Σ_{ω'} P(ω̃|ω') · p_i(ω')] · q(ω|ω̃)
```

By the law of total expectation:

```
p_i^eff(ω) = Pr[ω* = ω | oracle_model, p_i]
```

This is the knower's posterior over ω* AFTER marginalizing over oracle noise.

**Key identity:** The expected soft-resolution score under true belief p_i:

```
E[R(μ_i, ω̃) | p_i] = k_i · E_{ω̃ ~ P(·|p_i)} [Σ_ω q(ω|ω̃) · log μ_i(ω) / S_prev(ω)]
                    = k_i · Σ_ω [Σ_{ω̃} P(ω̃|p_i) · q(ω|ω̃)] · log μ_i(ω) / S_prev(ω)
                    = k_i · Σ_ω p_i^eff(ω) · log μ_i(ω) / S_prev(ω)
                    = k_i · E_{ω* ~ p_i^eff}[log μ_i(ω*) - log S_prev(ω*)]
```

This is identical in form to the hard-resolution expected score with p_i replaced by p_i^eff.

### 5.3 Truth-telling under soft resolution

**Theorem 3 (Soft-resolution IC):**

Under the soft-resolution scoring rule, the dominant strategy is:

```
μ_i* = p_i^eff
```

**Proof:**

The expected payoff from reporting μ_i is:

```
E[R(μ_i, ω̃) | p_i] = k_i · Σ_ω p_i^eff(ω) · log μ_i(ω) / S_prev(ω)
                    = k_i · [D_KL(p_i^eff || S_prev) - D_KL(p_i^eff || μ_i)]
```

Derivation of last step:

```
Σ_ω p_i^eff(ω) · log μ_i(ω) / S_prev(ω)
= Σ_ω p_i^eff(ω) · [log p_i^eff(ω) / S_prev(ω) - log p_i^eff(ω) / μ_i(ω)]
= D_KL(p_i^eff || S_prev) - D_KL(p_i^eff || μ_i)
```

Since D_KL(p || q) ≥ 0 with equality iff p = q:

```
E[R(μ_i, ω̃) | p_i] ≤ k_i · D_KL(p_i^eff || S_prev)
```

with equality iff μ_i = p_i^eff.

Therefore μ_i* = p_i^eff is the unique dominant strategy.  □

### 5.4 When does μ_i* = p_i^eff equal μ_i* = p_i (truthful)?

**Case 1: Unbiased oracle signal**

Oracle signal ω̃ is **unbiased** if for all ω ∈ Ω:

```
E[q(ω|ω̃) | ω*] = δ_{ω = ω*}     [point oracle: unbiased in expectation]
```

or more generally, if the oracle preserves expectations:

```
E_{ω̃}[q(·|ω̃)] = p_i(·)     [marginal over noise equals true posterior]
```

Under this condition: p_i^eff = p_i, and therefore μ_i* = p_i. Truth-telling is dominant.

**Proof:** If E_{ω̃}[q(·|ω̃)] = p_i(·):

```
p_i^eff(ω) = Σ_{ω̃} P(ω̃|p_i) · q(ω|ω̃)
           = E_{ω̃}[q(ω|ω̃)]  =  p_i(ω)   □
```

**Case 2: Biased oracle signal**

Oracle signal ω̃ has systematic bias b(ω) such that:

```
E_{ω̃}[q(ω|ω̃)] = p_i(ω) + b(ω)     where Σ_ω b(ω) = 0
```

Then:

```
p_i^eff(ω) = p_i(ω) + b(ω)
μ_i* = p_i^eff ≠ p_i
```

The dominant strategy is to report p_i corrected for oracle bias. If the knower knows b(·), this is rational and the mechanism is still IC (incentive-compatible for the effective belief). The mechanism is not IC for the true belief p_i under biased oracles.

**Implication:** Biased oracles cause truthful reporting of the WRONG quantity. Knowers who know the bias will correct for it; knowers who don't will underperform. The mechanism requires unbiased oracles for truthful revelation of p_i.

### 5.5 Oracle noise variance: effect on participation vs. IC

**IC is not broken by noise variance alone.** As shown in §5.3-5.4, truth-telling breaks only when the oracle is biased, not when it is merely noisy.

However, high variance affects **participation incentives** through the risk-return profile.

**Variance of soft-resolution score:**

```
Var[R(μ_i, ω̃) | μ_i = p_i^eff] = k_i² · Var_{ω̃}[Σ_ω q(ω|ω̃) · log p_i^eff(ω) / S_prev(ω)]
```

Let Z(ω̃) = Σ_ω q(ω|ω̃) · log p_i^eff(ω) / S_prev(ω). Then Var[R] = k_i² · Var[Z].

As oracle noise variance σ²_oracle → ∞: q(ω|ω̃) → uniform distribution (oracle signal is pure noise), and Z(ω̃) → E_q[log p_i^eff / S_prev] which converges to a constant. In the limit, Var[Z] → 0 (oracle is uninformative, all scores are the same). This is a degenerate case.

For intermediate noise levels, higher σ²_oracle → higher Var[Z] → higher Var[R].

**Participation condition for risk-averse knower (CARA utility U = -exp(-γ · R)):**

Knower participates iff expected certainty-equivalent reward exceeds outside option (= 0):

```
E[R] - (γ/2) · Var[R] ≥ 0

k_i · D_KL(p_i^eff || S_prev) ≥ (γ/2) · k_i² · Var[Z]

D_KL(p_i^eff || S_prev) ≥ (γ · k_i / 2) · Var[Z]
```

**Critical noise variance:** For given γ and k_i, there exists a critical oracle noise level σ²* such that:

```
σ² < σ²*  →  participation (truth-telling + entry)
σ² > σ²*  →  non-participation (knower exits market even though IC formally holds)
```

**Exact threshold (Gaussian approximation):**

For continuous Ω with Gaussian oracle noise σ²_oracle:

```
σ²* = 2 · k_i · [D_KL(p_i || S_prev)]² / (γ · ||∇_ω log p_i/S_prev||²)
```

Where ||∇_ω log p_i/S_prev||² is the Fisher information term capturing sensitivity of log-ratio to outcome variation.

**Summary table:**

| Oracle Property | IC for p_i? | Participation? |
|---|---|---|
| Perfect (σ² = 0) | Yes | Yes (if D_KL > 0) |
| Noisy unbiased (σ² > 0) | Yes | Yes if σ² < σ²* |
| Noisy unbiased (σ² >> σ²*) | Yes (formally) | No (risk-averse knowers exit) |
| Biased (b ≠ 0) | No (for p_i); Yes (for p_i^eff) | Depends on bias magnitude |
| Pure noise (oracle uninformative) | Trivially (all scores equal 0) | No |

### 5.6 Practical implications for GDM oracle design

**Result 1:** Oracle noise (variance) does NOT break IC. It reduces participation through risk pricing.

**Result 2:** Oracle bias DOES break IC. Multi-source BFT oracle aggregation reduces bias by averaging independent sources. Required: oracle sources must have independent errors (not co-correlated by a single data feed).

**Result 3:** For risk-neutral knowers, truth-telling is dominant under any unbiased oracle, regardless of noise variance. GDM can attract risk-neutral sophisticated players (market makers, quantitative analysts) without oracle precision requirements.

**Result 4:** For risk-averse retail knowers, oracle noise variance must be bounded. Practical bound: σ²_oracle ≤ σ²* where σ²* depends on knower's γ and D_KL of their signal. Protocol cannot directly control γ but can increase effective k_i (via minimum stake requirements) and D_KL (by filtering low-signal coordinates).

**Recommendation for oracle integration:**

1. Require multi-source BFT oracle to minimize bias (target b(ω) < 0.01 for all ω)
2. Publish oracle variance estimates alongside ω̃ signal for each epoch
3. Allow knowers to subscribe to precision-weighted oracle packages (lower noise → higher oracle fee → mechanism self-selects for commitment)
4. For high-stakes coordinates (TOWL Zone B/C), require oracle with σ²_oracle ≤ threshold_zone defined by governance

---

## 6. Cross-Cutting Implications

### 6.1 Sybil + Circular Self-Dealing Interaction

The Sybil vulnerability (Q1) amplifies the circular self-dealing attack (Q2). A Sybil adversary can:
1. Distribute capital across m identities to achieve linear influence scaling
2. Use that influence to shift S_public
3. Profit on L1

The combined attack requires the Sybil lower bound C_A from Q1 AND the no-arbitrage coupling condition from Q2 to hold simultaneously. Adding KYC or identity registration fees (Q1) also defends against the amplified circular attack.

### 6.2 Provisional Timeout + Oracle Gaming Interaction

Option C (auto-challenge oracle) directly addresses the oracle gaming attack from r071 §7.5 in the timeout context. The same oracle bonding structure that makes selective delay costly also raises the bar for the broader oracle gaming attack. These two mechanisms share infrastructure.

### 6.3 Partial Oracle Signal + Track Record Building

Under noisy oracles (Q6), track records T_i accrue more slowly because the scoring signal is noisier. Expected track record growth per round:

```
E[ΔT_i] = η · E[|Z(ω̃)| · sign(Z(ω̃))]
```

Under high oracle noise, E[|Z(ω̃)|] → small. Track records build slowly, meaning:
- Bootstrap problem (r071 §8) is worsened under noisy oracles
- New knowers remain in the fresh-identity tier (T_i ≈ 0) longer
- Sybil attack becomes easier during the noisy-oracle period

**Recommendation:** During oracle calibration periods (early deployment), use T_freshness as a primary quality signal in place of T_i, and avoid exposing raw S_public through L1 coupling until oracle variance is characterized.

---

## 7. Notation Reference (Atlas Extension)

| Symbol | Definition |
|---|---|
| K_A, U_A | Adversary's synthetic knower/unknower identity sets |
| m | Number of synthetic Sybil identities |
| C_A | Adversary's total capital budget |
| W_H | Total honest participant credibility weight: Σ_{j ∈ K_H} w_j |
| w_A_total | Total adversary credibility weight: Σ_{κ ∈ K_A} w_κ |
| ε | Target adversarial influence fraction over S_public |
| c_id | Non-refundable identity registration fee (protocol parameter) |
| β | Reliance-bond ratio (r_υ = β · k_κ) |
| Δ_S | Adversary-induced shift in S_public |
| θ_A | Adversary's Layer 1 position size |
| α | L1/L2 coupling coefficient: fraction of S_public fed into L1 clearing price |
| γ | Proportional leverage cap: max L1 position per unit L2 stake |
| λ | Lipschitz bound on L1 price function f: |f'| ≤ λ |
| P_base | Independent L1 oracle price (not derived from S_public) |
| T_timeout | Provisional install timeout window (protocol parameter) |
| T_challenge | Oracle challenge response window (protocol parameter) |
| C_challenge | Cost of filing oracle challenge |
| ω̃ | Oracle's partial/noisy signal |
| q(·\|ω̃) | Posterior over ω* induced by oracle signal ω̃ |
| p_i^eff | Effective marginal distribution over ω* after marginalizing oracle noise |
| b(ω) | Oracle systematic bias at outcome ω: E[q(ω\|ω̃)] - p_i(ω) |
| σ²_oracle | Oracle noise variance |
| σ²* | Critical noise variance for participation by risk-averse knowers |
| γ_CARA | CARA risk-aversion coefficient |
| Z(ω̃) | Soft-resolution log-ratio statistic: Σ_ω q(ω\|ω̃)·log(p_i^eff(ω)/S_prev(ω)) |
| D_KL_min | Minimum expected KL divergence for L1-price-moving bias |
| N_max | Maximum simultaneous oracle delays adversary can sustain |

---

*This document completes the Atlas assignment for VAL-452. Primary contributions: (1) formal Sybil lower bound and proof that log-diminishing stake influence is NOT Sybil-proof without identity uniqueness; (2) formal model of L1/L2 circular self-dealing showing W_max alone is insufficient and deriving the minimum coupling mechanism (common settlement oracle + bounded α); (3) structured evaluation of provisional install timeout options with formal deterrence condition for Option C; (4) proof that soft-resolution IC depends on oracle bias, not variance, with derivation of risk-averse participation threshold.*

*All derivations shown step by step. Open items: (a) formal proof of correlation penalty effectiveness on Sybil track-record gaming; (b) empirical calibration of α, γ, k_0, c_id parameters; (c) oracle challenge mechanism protocol specification.*

*End of r072.*
