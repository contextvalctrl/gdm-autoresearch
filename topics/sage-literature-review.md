# GDM Research: Academic Literature Synthesis — Epistemic Bond Layer

**Maintainer:** Sage (ValCtrl AI — Research Analyst); executed by Logan (Chief of Staff, covering for Sage error-state)
**Issue:** VAL-454
**Parent Issue:** VAL-450
**Predecessor documents:** `fundamental-analysis-epistemic-bond-layer.md` (r071), `atlas-formal-analysis.md` (r072), `knowledge-marketplace-primitive.md`, `query-as-first-class-object.md` (r69/r70)
**Last updated:** 2026-04-03
**Status:** COMPLETE

---

## Abstract

The GestAlt Decentralized Marketplace (GDM) epistemic bond mechanism introduces a market primitive in which capital bonds credentialed belief updates — claims about the distribution over outcomes — rather than directional bets or price-impact positions. This literature review situates the GDM design against four bodies of academic work: (1) mechanism design foundations, including market scoring rules, proper scoring rules, and incentive-compatibility theory; (2) Bayesian belief aggregation and calibration; (3) information asymmetry, adverse selection, and signaling; and (4) gap analysis identifying the mechanism's novel contributions and the most likely peer-review objections. We conclude that the epistemic bond is a genuine theoretical contribution — most novel in its bilateral information routing structure and its dissociation of epistemic value from directional bet profit — but faces non-trivial peer-review challenges on bootstrap/thin-market dynamics, Sybil-resistance, and the absence of a unified equilibrium proof for the joint L1/L2 market.

---

## Table of Contents

1. [Mechanism Design Foundations](#1-mechanism-design-foundations)
   - 1.1 [LMSR and Market Scoring Rules — Hanson (2003, 2006)](#11-lmsr-and-market-scoring-rules--hanson-2003-2006)
   - 1.2 [Proper Scoring Rules — Brier (1950), Good (1952), McCarthy (1956)](#12-proper-scoring-rules--brier-1950-good-1952-mccarthy-1956)
   - 1.3 [Revelation Principle — Myerson (1979, 1981)](#13-revelation-principle--myerson-1979-1981)
   - 1.4 [VCG Mechanisms — Vickrey (1961), Clarke (1971), Groves (1973)](#14-vcg-mechanisms--vickrey-1961-clarke-1971-groves-1973)
2. [Bayesian Belief Aggregation](#2-bayesian-belief-aggregation)
   - 2.1 [DeGroot Consensus (1974)](#21-degroot-consensus-1974)
   - 2.2 [Dawid Calibration (1982)](#22-dawid-calibration-1982)
   - 2.3 [Linear vs. Logarithmic Opinion Pools](#23-linear-vs-logarithmic-opinion-pools)
3. [Information Asymmetry and Adverse Selection](#3-information-asymmetry-and-adverse-selection)
   - 3.1 [Akerlof Lemons Problem (1970)](#31-akerlof-lemons-problem-1970)
   - 3.2 [Spence Signaling (1973)](#32-spence-signaling-1973)
   - 3.3 [Kyle Insider Trading Model (1985)](#33-kyle-insider-trading-model-1985)
4. [Gaps and Novel Contributions](#4-gaps-and-novel-contributions)
   - 4.1 [Where Novelty Is Strongest](#41-where-novelty-is-strongest)
   - 4.2 [Where Novelty Is Weakest](#42-where-novelty-is-weakest)
   - 4.3 [Foundational Papers a Peer Reviewer Would Cite in a Rejection](#43-foundational-papers-a-peer-reviewer-would-cite-in-a-rejection)
5. [Bibliography](#5-bibliography)

---

## 1. Mechanism Design Foundations

### 1.1 LMSR and Market Scoring Rules — Hanson (2003, 2006)

#### 1.1.1 What LMSR does

Hanson (2003) introduced the Logarithmic Market Scoring Rule (LMSR) as a mechanism for automated market making in prediction markets. A shared scoring rule is maintained across all participants; each trade updates a cost function

$$C(\mathbf{q}) = b \log \sum_{j=1}^{n} e^{q_j / b}$$

where $\mathbf{q} = (q_1, \ldots, q_n)$ is the vector of shares outstanding for each outcome $j$ and $b > 0$ is a liquidity parameter. The price of outcome $j$ is

$$p_j = \frac{e^{q_j / b}}{\sum_k e^{q_k / b}}$$

which always lies in $(0,1)$ and sums to 1 across outcomes — making prices interpretable as probabilities. The key property: a market maker following this rule has bounded total loss $b \log n$ across all possible outcomes, providing guaranteed liquidity regardless of participation.

Hanson (2006) extended the framework to show that any Bayesian agent truthfully reporting its posterior will update the shared scoring rule in expectation without loss to itself if its private information is better than the current price, connecting LMSR to the proper scoring rule literature (§1.2).

#### 1.1.2 What GDM borrows from LMSR

The GDM epistemic bond mechanism borrows three structural ideas from LMSR:

1. **Belief states as probability distributions.** Both mechanisms treat participants as reporting over $\Delta(\Omega)$ — the simplex of probability distributions over outcomes — rather than directional binary bets.
2. **Scoring against a prior.** LMSR scores a new trade against the existing price; GDM scores knower $i$'s claim $\mu_i$ against prior state $S_\text{prev}$ via KL divergence: $R(\mu_i, \omega^*) = k_i \cdot [\log \mu_i(\omega^*) - \log S_\text{prev}(\omega^*)]$.
3. **Incentive-compatibility via proper scoring.** Both mechanisms make honest reporting a dominant strategy for expected-utility-maximizing agents.

#### 1.1.3 What GDM departs from LMSR

The departures are more significant than the borrowings:

| Dimension | LMSR | GDM Epistemic Bond |
|---|---|---|
| **What is sold** | Price impact on a public scoring rule | Bilateral, credentialed belief update |
| **Capital role** | Moves shared cost function; no credibility signal | Credibility bond on a specific claim; track record accumulates |
| **Market maker** | Required; absorbs bounded loss $b \log n$ | Absent; mechanism is self-sustaining if knower population exists |
| **State update timing** | Continuous, per-trade | Batch at epoch boundary; no front-running |
| **Information routing** | Symmetric and public | Bilateral: knower → unknower; not publicly extractable |
| **Thin-market behavior** | Market maker always quotes a price; never empty | Vacuous without knower participation; no floor |
| **Knower/unknower distinction** | None; all traders are price-movers | Central organizing feature |

**GDM's core theoretical departure from LMSR** is the dissociation of information value from price impact. In LMSR, an agent profits by moving the price toward truth — but the price move is observable and appropriable by others (information leakage). In the epistemic bond mechanism, the credentialed claim is delivered bilaterally; its information content is not publicly observable from the price mechanism. This enables direct payment for private epistemic utility in a way LMSR cannot.

#### 1.1.4 Peer-review implication

A reviewer familiar with Hanson (2003) will immediately ask: *why do you need a new mechanism when LMSR already elicits truthful beliefs?* The answer must be precise: LMSR does not distinguish *who* informed the price or compensate them for *private information as such*; it compensates directional accuracy. A knower with strong private information but who is one of many traders gets diluted compensation. The epistemic bond mechanism is specifically designed for the case where the knower's identity and private information are the product being sold — not the directional bet.

---

### 1.2 Proper Scoring Rules — Brier (1950), Good (1952), McCarthy (1956)

#### 1.2.1 Definition and key results

A scoring rule $S(p, \omega)$ assigns a reward to a forecaster who reported probability distribution $p$ when outcome $\omega$ is realized. A scoring rule is **strictly proper** if

$$\omega^* \mapsto \mathbb{E}_{\omega \sim p^*}[S(p, \omega)] \text{ is uniquely maximized at } p = p^*$$

for any true distribution $p^*$. Strict propriety makes truthful reporting a strict dominant strategy.

- **Brier score** (Brier 1950): $S_\text{Brier}(p, \omega) = 1 - \sum_j (p_j - \mathbf{1}[\omega = j])^2$. Strictly proper; scores are bounded and have convenient squared-error interpretation.
- **Logarithmic score** (Good 1952; McCarthy 1956): $S_\text{log}(p, \omega) = \log p(\omega)$. Strictly proper; unbounded below; uniquely corresponds to KL divergence minimization.
- **Spherical score**: $S_\text{sph}(p, \omega) = p(\omega) / \|p\|_2$. Strictly proper; bounded.

The **characterization theorem** (Savage 1971; Gneiting & Raftery 2007) shows that all strictly proper scoring rules $S$ are of the form

$$S(p, \omega) = G(p) + \nabla G(p)^\top (e_\omega - p)$$

for a convex function $G: \Delta(\Omega) \to \mathbb{R}$, where $e_\omega$ is the indicator vector for $\omega$. The logarithmic score corresponds to $G(p) = \sum_j p_j \log p_j$ (negative entropy).

#### 1.2.2 GDM's scoring rule is the log score

The GDM reward function $R(\mu_i, \omega^*) = k_i \cdot [\log \mu_i(\omega^*) - \log S_\text{prev}(\omega^*)]$ is the **logarithmic scoring rule applied to the excess information in $\mu_i$ over the prior $S_\text{prev}$**. Specifically:

$$R(\mu_i, \omega^*) = k_i \cdot S_\text{log}(\mu_i, \omega^*) - k_i \cdot S_\text{log}(S_\text{prev}, \omega^*)$$

The second term is constant with respect to the knower's reporting choice $\mu_i$ (since $S_\text{prev}$ is fixed at report time under batch epoch discipline). Therefore, maximizing expected $R$ is equivalent to maximizing expected log score — which is maximized by setting $\mu_i = p_i$ (the knower's true posterior). This is the formal proof that truth-telling is a dominant strategy (r071 §5.1).

#### 1.2.3 Is GDM's score strictly proper?

**Yes**, conditional on: (a) $S_\text{prev}$ being fixed during the reporting decision (guaranteed by batch epoch discipline — knowers do not see intermediate claims before the epoch closes); and (b) $S_\text{prev}(\omega) > 0$ for all $\omega$ (requires $\epsilon$-smoothed priors to avoid undefined log at zero-probability outcomes).

Without condition (a) — i.e., if knowers could observe each other's claims before submitting — the scoring rule remains proper in the Bayesian Nash sense but strategic herding or counter-herding becomes possible. This motivates sealed-bid submission (commit-reveal or batch opacity), which GDM inherits from GestAlt's architecture.

Without condition (b), the score is undefined at outcomes assigned zero probability by the prior. Resolution: standard $\epsilon$-Laplace smoothing of $S_\text{prev}$ before scoring. The smoothing parameter $\epsilon$ must be disclosed ex ante to avoid manipulation.

#### 1.2.4 Comparison to KL-divergence scoring

The GDM reward $R(\mu_i, \omega^*)$ has expected value (under knower's true posterior $p_i$):

$$\mathbb{E}_{p_i}[R(\mu_i, \omega^*)] = k_i \cdot \mathbb{E}_{p_i}[\log \mu_i(\omega^*) - \log S_\text{prev}(\omega^*)]$$

Setting $\mu_i = p_i$:

$$\mathbb{E}_{p_i}[R(p_i, \omega^*)] = k_i \cdot D_\text{KL}(p_i \| S_\text{prev})$$

The **expected reward under truthful reporting equals the KL divergence from the prior to the knower's true posterior, scaled by stake**. This is strictly positive iff $p_i \neq S_\text{prev}$ and zero iff the knower has no information beyond the prior. A knower with no private signal has zero expected reward regardless of stake — correctly eliminating the incentive to stake without information.

This is a meaningful difference from LMSR, where a knower with no private signal can still profit by moving price in a direction that happens to be correct (luck vs. information). The GDM scoring rule is *epistemically sharper*.

---

### 1.3 Revelation Principle — Myerson (1979, 1981)

#### 1.3.1 The revelation principle

Myerson's revelation principle (Myerson 1979, 1981) states: for any mechanism achieving a social choice function $f$ as a Bayes-Nash equilibrium, there exists a **direct revelation mechanism** (DRM) — where agents truthfully report their types — that implements the same $f$ as a dominant-strategy equilibrium (in the dominant-strategy sense) or Bayes-Nash equilibrium.

Formally, a mechanism $\Gamma = (A_i, g)$ — where $A_i$ is agent $i$'s action space and $g: \times_i A_i \to X$ is the outcome function — can always be replaced by a DRM $\Gamma' = (\Theta_i, g \circ \sigma^*)$ where $\Theta_i$ is $i$'s type space and $\sigma^*$ is the equilibrium strategy profile of $\Gamma$, such that truthful reporting is a dominant strategy in $\Gamma'$.

#### 1.3.2 Does the GDM mechanism satisfy the revelation principle?

**Partial satisfaction.** The GDM epistemic bond mechanism is designed so that truthful reporting of $\mu_i = p_i$ is a dominant strategy (shown in §1.2 above, under batch epoch discipline). This means the mechanism already functions as a DRM for the belief-reporting dimension. Agents report their true posteriors in equilibrium; no non-truthful equilibrium strategy strictly dominates truth-telling.

**Where it departs from standard DRM:** The revelation principle applies to mechanisms with well-defined type spaces. GDM has two complications:

1. **Credibility history as type.** The knower's "type" includes not only their current private signal $p_i$ but also their track record $T_i$. Track records are private information (agents may know their own calibration but not others'). The DRM for the full type (signal + track record) would require the mechanism to also elicit $T_i$ directly — which is not current GDM design. Currently, $T_i$ is computed from on-chain settlement history, not reported.

2. **Bilateral routing with private unknower types.** The unknower's type includes their decision-loss function $L: \Omega \to \mathbb{R}$ (r69 query contract framework). The mechanism routes unknowers to knowers based on expected KL-reduction, not on $L$. This is efficient for a symmetric loss function but may be suboptimal for unknowers with asymmetric decision losses.

**Can a DRM be constructed?** Yes, with modifications. A DRM for the full GDM type space would require agents to report $(p_i, T_i)$ and unknowers to report $L_i$. The social choice function would maximize expected total epistemic welfare (sum of KL reductions weighted by decision losses). This is theoretically constructible but operationally unwieldy — requiring on-chain privacy of $L_i$ and trust in $T_i$ self-reports. Current GDM correctly avoids this complexity by computing $T_i$ from on-chain history and not requiring $L_i$ reporting, at the cost of a looser (but still satisfying) DRM claim: truthful reporting of beliefs is a dominant strategy even without full type revelation.

**Verdict:** GDM satisfies a partial form of the revelation principle — truthful belief reporting is a dominant strategy — but does not implement a full DRM over the richer type space including track records and decision-loss functions. This is not a fatal flaw; it is a modeling choice with trade-offs that should be acknowledged in any formal writeup.

---

### 1.4 VCG Mechanisms — Vickrey (1961), Clarke (1971), Groves (1973)

#### 1.4.1 VCG overview

The Vickrey-Clarke-Groves (VCG) mechanism solves the efficient public goods / combinatorial allocation problem. Each agent $i$ reports their valuation $v_i(x)$ for outcome $x$. The mechanism selects the social-welfare-maximizing outcome $x^* = \arg\max_x \sum_i v_i(x)$ and charges agent $i$ a Clarke tax:

$$t_i = \sum_{j \neq i} v_j(x^*_{-i}) - \sum_{j \neq i} v_j(x^*)$$

where $x^*_{-i}$ is the optimal outcome excluding $i$. VCG achieves: (a) efficiency (social surplus maximization), (b) incentive-compatibility (truthful valuation reporting is dominant), and (c) individual rationality.

#### 1.4.2 VCG interpretation of the epistemic bond

The epistemic bond mechanism has a natural VCG interpretation when viewed as a public information aggregation problem:

- **"Outcome"** $x$: the public state estimate $S_\text{public}$ selected after all claims are filed.
- **"Valuation"** $v_i(S_\text{public})$: unknower $i$'s reduction in decision loss from using $S_\text{public}$ vs. prior $S_\text{prev}$.
- **"Social welfare"**: $\sum_i \Delta L_i(S_\text{public})$ — total decision-loss reduction across unknowers.

Under this framing, the mechanism should:
1. Select $S_\text{public}$ to maximize total unknower welfare (rather than credibility-weighted average, which may diverge from welfare maximization).
2. Charge each unknower a Clarke tax equal to the externality their demand places on other unknowers.

**Does GDM implement VCG?** Not currently. GDM computes $S_\text{public}$ as a credibility-weighted average of knower claims:

$$S_\text{public} = \sum_i w_i \cdot \mu_i, \quad w_i = \text{stake\_influence}(k_i) \cdot \sigma(\alpha \cdot T_i)$$

This is an opinion pool (discussed in §2.3), not a social-welfare-maximizing outcome selection. A VCG-optimal $S_\text{public}$ would require solving:

$$S^*_\text{public} = \arg\max_{S \in \Delta(\Omega)} \sum_i \Delta L_i(S)$$

which requires knowledge of each unknower's $L_i$ — private information not currently elicited.

**Is there a VCG interpretation of the fee structure?** Partially. The fee $f$ paid by unknower $i$ to knower $j$ in GDM is a direct bilateral payment for epistemic utility. Clarke taxes are instead cross-subsidies between agents. GDM's fee structure is closer to a competitive market (Walrasian) than VCG. A VCG epistemic bond would: (a) compute the social-welfare-maximizing state update, (b) charge each unknower for their externality, and (c) subsidize knowers from Clarke tax revenue. This would achieve stricter efficiency but requires private type elicitation (decision-loss functions) that GDM correctly avoids for practical reasons.

**Verdict:** The epistemic bond has a VCG *interpretation* but does not implement VCG. The current fee structure is closer to competitive market pricing for information. A VCG variant could in principle be constructed but would require private type reporting infrastructure that may be impractical on-chain. The gap between GDM's design and a full VCG mechanism is a known engineering trade-off, not a theoretical failure.

---

## 2. Bayesian Belief Aggregation

### 2.1 DeGroot Consensus (1974)

#### 2.1.1 The DeGroot model

DeGroot (1974) proposed a model of social learning in which $n$ agents iteratively update their beliefs by taking weighted averages of their neighbors' beliefs. Formally, let $P^{(t)}_i$ be agent $i$'s belief at time $t$ (a scalar for simplicity; generalizes to distributions). Agents update via:

$$\mathbf{P}^{(t+1)} = W \cdot \mathbf{P}^{(t)}$$

where $W$ is a row-stochastic matrix of influence weights ($W_{ij}$ = weight agent $i$ gives to agent $j$). Under mild connectivity conditions, beliefs converge to a consensus $P^* = \mathbf{c}^\top \mathbf{P}^{(0)}$ where $\mathbf{c}$ is the stationary distribution of $W$ (the "social influence vector").

#### 2.1.2 How GDM's $S_\text{public}$ compares to DeGroot averaging

GDM's public state:

$$S_\text{public} = \sum_i w_i \cdot \mu_i, \quad \sum_i w_i = 1$$

is a **single-round DeGroot average** with weights $w_i$ determined by stake and track record, not by pairwise social trust. This is a linear opinion pool (§2.3) with data-driven weights.

**Key differences from DeGroot:**

1. **Iterative vs. one-shot.** DeGroot iterates to consensus; GDM computes a single weighted average at epoch boundaries. GDM does not model iterated social influence.
2. **Weight source.** DeGroot weights $W_{ij}$ are social trust relationships, static or slowly evolving. GDM weights $w_i$ are computed from track records and stake — endogenous to performance.
3. **Self-weighting.** In DeGroot, agents may weight themselves. In GDM, $S_\text{public}$ aggregates over all active knowers, with weights determined by market performance.
4. **No communication between knowers.** DeGroot requires agents to observe each other's beliefs. GDM uses sealed-bid submission; knowers do not see each other's claims before the epoch closes. The resulting $S_\text{public}$ is therefore an *aggregation* of independent reports, not a social influence equilibrium.

**Verdict:** $S_\text{public}$ in GDM is structurally a one-shot linear opinion pool (DeGroot with $t=1$), not a full DeGroot consensus process. DeGroot's convergence results do not apply. What GDM offers instead is epoch-by-epoch updating of the opinion pool weights based on resolved outcomes — a feedback mechanism that DeGroot lacks.

---

### 2.2 Dawid Calibration (1982)

#### 2.2.1 Calibration defined

Dawid (1982) formalized **forecaster calibration** for sequential prediction. A forecaster issuing probability forecasts $p_t$ is said to be **calibrated** if, among all occasions when the forecaster announced probability $p$, the long-run relative frequency of the event equals $p$. More formally, for any interval $[a,b]$:

$$\lim_{T \to \infty} \frac{\sum_{t=1}^T \mathbf{1}[p_t \in [a,b]] \cdot \mathbf{1}[\omega_t = 1]}{\sum_{t=1}^T \mathbf{1}[p_t \in [a,b]]} = \int_a^b p \, dF(p)$$

where $F$ is the empirical distribution of forecasts. Calibration is a frequentist property; it does not require knowledge of the true data-generating process.

#### 2.2.2 Is the credibility ratio $T_i$ a calibrated estimator?

The GDM track record update:

$$T_i \leftarrow T_i + \eta \cdot \text{sign}(R) \cdot |R| / k_i$$

where $R = k_i \cdot [\log \mu_i(\omega^*) - \log S_\text{prev}(\omega^*)]$ (so $|R|/k_i = |\log \mu_i(\omega^*) - \log S_\text{prev}(\omega^*)|$) is a **running sum of normalized log-score excess over prior**, not a calibration statistic in the Dawid sense. It measures cumulative informational accuracy, not frequency-probability alignment.

**Conditions under which $T_i$ approximates calibration:**

A knower who is perfectly calibrated — i.e., whose reported $\mu_i$ exactly matches the true data-generating process $p_i = p^*$ on each coordinate — will have:

$$\mathbb{E}[R/k_i] = D_\text{KL}(p^* \| S_\text{prev}) > 0$$

Such a knower's $T_i$ grows at rate $\eta \cdot D_\text{KL}(p^* \| S_\text{prev})$ per epoch, accumulating positive track record. A miscalibrated forecaster will, on average, have $\mathbb{E}[R/k_i] < D_\text{KL}(p^* \| S_\text{prev})$ (they are leaving expected score on the table), and depending on miscalibration direction, may have $T_i$ growth stall or turn negative.

**Limitation:** $T_i$ is not a direct calibration measure. Two knowers with identical calibration could have different $T_i$ values if $S_\text{prev}$ differed across their epochs (i.e., $T_i$ reflects both calibration and the value of the prior at epoch time). This makes $T_i$ a noisy signal of true calibration; it conflates epistemic accuracy with the difficulty of the prediction problem in each epoch.

**Recommendation (for formal writeup):** GDM should clarify that $T_i$ is a *profitability track record* (cumulative excess log-score over prior), not a Dawid calibration score. The two are correlated but distinct. A separate calibration diagnostic could be maintained in parallel (not for weighting, but for transparency) using the Dawid-Sebastiani framework.

---

### 2.3 Linear vs. Logarithmic Opinion Pools

#### 2.3.1 Opinion pool definitions

Given $n$ expert distributions $\mu_1, \ldots, \mu_n$ over $\Omega$ with weights $w_i \geq 0$, $\sum_i w_i = 1$:

- **Linear Opinion Pool (LOP):**
$$S^\text{LOP} = \sum_i w_i \cdot \mu_i$$

- **Logarithmic Opinion Pool (LogOP):**
$$S^\text{LogOP}(\omega) \propto \prod_i \mu_i(\omega)^{w_i}$$
equivalently: $\log S^\text{LogOP}(\omega) = \sum_i w_i \log \mu_i(\omega) + \text{const}$

#### 2.3.2 Which does GDM $S_\text{public}$ correspond to?

GDM computes:

$$S_\text{public} = \sum_i w_i \cdot \mu_i$$

This is a **linear opinion pool**. It is a mixture distribution — a convex combination of knower posteriors.

#### 2.3.3 Theoretical properties and implications

**Linear Opinion Pool (LOP) properties:**
- **Externally Bayesian (EB):** LOP is externally Bayesian if $w_i \propto$ prior probability of expert $i$ being correct — i.e., it is consistent with a hierarchical Bayes model where the forecaster identity is uncertain. Stone (1961) showed LOP is EB only under restrictive conditions.
- **Marginalization consistency:** LOP preserves marginals — the marginal of $S^\text{LOP}$ on any subset of $\Omega$ equals $\sum_i w_i \cdot \mu_i|_{\text{subset}}$. This is convenient for computation.
- **Does not preserve independence:** If $\mu_i$ has $A \perp B$ and $\mu_j$ has $A \not\perp B$, the mixture $S^\text{LOP}$ generally does not have $A \perp B$. Correlational structure is distorted.
- **Extremization bias:** LOP tends toward the interior of the probability simplex — it is less extreme than the most confident expert. This is a known deficiency when experts have genuinely different information (Ranjan & Gneiting 2010).

**Logarithmic Opinion Pool (LogOP) properties:**
- **Supra-Bayesian:** LogOP is equivalent to Bayesian updating on a product of likelihood ratios — each expert's likelihood ratio $\mu_i / \mu_0$ is multiplied with weight $w_i$. If experts have conditionally independent signals given $\omega$, LogOP is the Bayesian aggregate (Good 1952; Genest & Zidek 1986).
- **Not a mixture:** LogOP is a *geometric mixture* — it can assign high probability to outcomes all experts individually find plausible but in different ratios.
- **Requires overlapping support:** LogOP is undefined if any $\mu_i(\omega) = 0$ (log diverges). Requires smoothed distributions.
- **Over-confident:** If experts' signals are not conditionally independent (i.e., they share information), LogOP can produce posteriors that are more concentrated than warranted — double-counting shared evidence.

**Which is correct for GDM?** The choice between LOP and LogOP depends on the epistemic independence structure of knowers:

- **If knowers have genuinely independent private signals** (no shared information), LogOP is the Bayesian-optimal aggregation rule. GDM's LOP then systematically under-updates, leaving epistemic value on the table.
- **If knowers share some common information** (e.g., they all read the same public news), LOP is more robust — it does not double-count shared evidence.

**GDM's LOP is a pragmatic choice**: it is computationally simple, avoids the zero-support problem, and is conservative (does not over-concentrate). But it comes at the cost of sub-optimality when knower signals are genuinely independent. A hybrid approach — using LogOP for knowers with low cross-correlation (measured from historical claim agreement) and LOP for correlated knowers — would dominate, but adds significant complexity.

**Peer-review note:** A reviewer aware of Genest & Zidek (1986) or Ranjan & Gneiting (2010) will flag the LOP choice and ask why LogOP was not used given independent signals. The response should acknowledge this and reference the correlation-detection mechanism that could enable a dynamic pool-type selection.

---

## 3. Information Asymmetry and Adverse Selection

### 3.1 Akerlof Lemons Problem (1970)

#### 3.1.1 The Akerlof model

Akerlof (1970) showed that in a market with private information about quality (the used-car market), adverse selection can destroy the market entirely. Sellers know quality; buyers do not. Buyers offer a price reflecting average quality; high-quality sellers exit because the price is below their reservation value; average quality falls; price offered falls further; eventually only low-quality ("lemons") sellers remain, or the market collapses.

#### 3.1.2 Does the epistemic bond market have a lemons equilibrium?

**Yes, without credentialing — the lemons problem is real.** If unknowers cannot distinguish high-quality (well-calibrated, informed) knowers from low-quality (poorly-calibrated, luck-based) knowers ex ante, they will offer a fee reflecting average knower quality. High-quality knowers may find this fee insufficient (their private signal is worth more than the average fee). Only low-quality knowers remain. The fee offered falls further. Market collapses to a lemons equilibrium.

**How stake-credentialing prevents it:** GDM's stake requirement and track record system (credibility_ratio $T_i$) create a credibility signal observable ex ante:

1. **Stake as a barrier to entry for lemons:** A low-quality knower (no private signal) has expected payoff $\mathbb{E}[R] \approx 0$ but faces stake loss probability roughly equal to $\Pr[\text{KL-loss}]$. For a knower with no signal, this is approximately $50\%$ (a random-walk agent on the probability simplex). Low-quality knowers rationally do not stake large $k_i$ because the expected value is negative.

2. **Track record as quality signal:** $T_i$ is computed from on-chain settlement outcomes. An unknower observing $T_i > 0$ (credibility above baseline) has Bayesian evidence that the knower's past claims were above-prior informative. This is a verifiable, non-falsifiable quality signal — unlike in the Akerlof model where quality is unverifiable.

3. **Credibility weights in $S_\text{public}$:** The mechanism routes unknowers preferentially toward high-$T_i$ knowers. High-quality knowers capture more of the fee pool, reinforcing the incentive to maintain quality.

**Residual lemons risk:** The stake/track-record system mitigates but does not fully eliminate the lemons problem. In the **bootstrap period** (no track records yet), $T_i = 0$ for all knowers. The system cannot distinguish quality, and Akerlof dynamics apply. See §8 of the fundamental analysis (r071) for the bootstrap problem discussion. This is the mechanism's most acute near-term vulnerability.

Additionally, **wash credibility** (building track records on low-stakes, easy-to-predict markets and then applying that credibility to high-stakes markets with different difficulty profiles) is a form of residual lemons risk. A knower may appear high-quality on simple coordinates but be no better than chance on complex ones. Domain-stratified track records would address this but add complexity.

---

### 3.2 Spence Signaling (1973)

#### 3.2.1 The Spence model

Spence (1973) modeled education as a costless-to-productive-workers, costly-to-unproductive-workers signal. High-ability workers invest in education; low-ability workers do not (because the cost exceeds the wage premium for them). The market observes education level and offers wages accordingly. This is a **separating equilibrium** if and only if the **single-crossing condition** holds: high-ability workers' indifference curves cross low-ability workers' indifference curves exactly once in the (education, wage) space, so there exists a level of education that separates types.

#### 3.2.2 Is stake-posting a credible signal in the Spence sense?

**Yes — with important caveats.**

The GDM stake $k_i$ functions as a signal for knower quality (private information quality) in the following sense:

- **Signal:** $k_i$ (stake posted)
- **Types:** $p^*_i$ — quality of private signal (high-quality = true posterior; low-quality = prior or worse)
- **Wage analogue:** Fee revenue + scoring reward
- **Education cost analogue:** Expected stake loss $= k_i \cdot \Pr[\text{claim is net-KL-negative}]$

For the signal to be a **Spence separating signal**, the single-crossing condition must hold: the cost of staking $k_i$ must be lower for high-quality knowers than for low-quality knowers. Is this the case?

- High-quality knower: expected loss = $k_i \cdot \Pr_{p_i}[\mu_i \text{ is net-KL-negative}]$. For a truthful, well-calibrated agent with genuine private information, this probability is less than 50% (their claim improves on the prior in expectation). Expected loss is bounded.
- Low-quality knower: expected loss = $k_i \cdot \Pr[\text{random report is net-KL-negative}]$. For an uninformed agent, this is approximately 50% for symmetric priors. Expected loss $\approx 0.5 k_i$.

For the signal to be perfectly separating, we need: for any $k_i$, the expected benefit of signaling exceeds the cost for high-quality knowers but not for low-quality knowers. This holds if the fee premium for high-quality signals exceeds the cost differential in expected stake loss. Formally:

$$\underbrace{(f^H - f^L)}_{\text{fee premium}} > \underbrace{k_i \cdot (0.5 - \Pr_H[\text{KL-negative}])}_{\text{cost differential}}$$

where $f^H, f^L$ are fees earned by high and low-quality knowers respectively.

**Does single-crossing hold?** Partially. The separating equilibrium is achievable if: (a) unknowers can distinguish high/low quality from the credibility weight before paying the fee (so $f^H > f^L$); and (b) the cost differential is positive (high-quality stakers face lower expected loss than low-quality stakers). Both conditions are approximately satisfied by the GDM design. However:

- **Imperfect separation:** At $T_i = 0$ (no track record), $w_i = \sigma(0) = 0.5$ for all knowers regardless of quality. Fee premium $f^H - f^L \approx 0$ initially. Single-crossing fails in the bootstrap period.
- **Mimicry risk:** A low-quality knower can mimic a high-quality knower's stake level at cost $\approx 0.5 k_i$. If the fee premium exceeds this cost, mimicry is individually rational. The signal is not perfectly credible before track records differentiate.

**Verdict:** Stake-posting is a partially credible Spence signal — credibility increases as track records develop. Full separation is achieved in the steady state but not at launch. The bootstrap period is again the critical vulnerability.

---

### 3.3 Kyle Insider Trading Model (1985)

#### 3.3.1 The Kyle model

Kyle (1985) modeled a financial market with an **informed trader** (insider) who knows the true value $v$ of an asset, **noise traders** who trade randomly, and a **market maker** who sets prices. The insider maximizes expected profit by trading strategically, spreading information into the market gradually over time to minimize price impact. The market maker observes total order flow $y = x + u$ (informed + noise) and sets price equal to conditional expectation $p = \mathbb{E}[v | y]$.

The key result: at equilibrium, the price impact per unit of informed order is **Kyle lambda** $\lambda$:

$$\lambda = \frac{\text{Cov}(v, x)}{\text{Var}(x + u)}$$

Higher $\lambda$ means more price impact per unit of informed trading — a less liquid market.

#### 3.3.2 The GDM analogue of Kyle lambda

In GDM, the analogue of "price impact" is the **shift in $S_\text{public}$** caused by a single knower's claim. The Kyle lambda analogue $\lambda_\text{GDM}$ measures how much a single claim moves the public state:

$$\Delta S_\text{public} = w_i \cdot (\mu_i - S_\text{public,{-i}})$$

where $S_\text{public,{-i}}$ is the state without knower $i$'s claim. The "lambda" is:

$$\lambda_\text{GDM} = \frac{\|\Delta S_\text{public}\|_1}{\|\mu_i - S_\text{prev}\|_1} = w_i$$

The credibility weight $w_i$ is the GDM analogue of Kyle lambda — it controls the price impact of a single informed trader's claim.

**Key differences from Kyle lambda:**

| Dimension | Kyle lambda | GDM $\lambda_\text{GDM}$ |
|---|---|---|
| Determined by | Equilibrium between insider and market maker | Protocol design ($w_i$ function) |
| Manipulable by insider | Yes (via order size) | Partially (via stake $k_i$, log-diminishing) |
| Noise traders | Absorb some order flow; reduce $\lambda$ | No explicit noise; all claims are credentialed |
| Strategic gradual release | Insider spreads trading over time | Not modeled in GDM; single-epoch claims |
| Market maker learning | Updates $\lambda$ each period | $w_i$ updated via track record $T_i$ |

**GDM departs from Kyle most significantly** in the absence of noise traders. Kyle's noise traders provide cover for the informed trader (market maker cannot distinguish informed from noise), enabling gradual information revelation. GDM has no noise traders — every claim is credentialed and attributed. This makes GDM **more informationally efficient** (each claim is identifiable) but **less privacy-preserving** — a knower cannot hide their information provision the way a Kyle insider hides behind noise flow.

**Implication for strategic behavior:** A strategic GDM knower cannot follow the Kyle strategy of spreading information gradually to avoid frontrunning. All claims within an epoch are settled simultaneously. Inter-epoch strategic behavior (staking over multiple epochs) is possible in principle but is constrained by the track record mechanism (each epoch's claim is independently scored).

---

## 4. Gaps and Novel Contributions

### 4.1 Where Novelty Is Strongest

The GDM epistemic bond mechanism makes its strongest contribution in three areas not previously unified in a single mechanism:

**1. Bilateral private information routing with credibility bonding.**
No prior mechanism — LMSR, VCG, Kyle, orderbook prediction markets — provides a mechanism where a specific knower delivers a credentialed belief update to a specific unknower bilaterally, with stake bonding the quality of the claim, without making the information content publicly observable. LMSR routes information through a public price. Kyle's insider trades against noise flow visible to the market maker. Expert networks (GLG, Tegus) provide bilateral information but with no mechanism for incentive-compatibility or quality verification. GDM is the first mechanism design that is: (a) bilateral in routing, (b) proper-score-incentive-compatible, and (c) stake-credentialed with on-chain track records.

**2. Separation of epistemic value from directional bet profit.**
In all prior prediction market mechanisms, an informed agent's payoff is conflated with directional accuracy. In GDM, reward is proportional to KL-divergence from prior — not to whether the agent was "right" in a directional sense. A knower who correctly shifts the prior toward an unlikely outcome earns positive reward even if the outcome does not occur, if the probability update was well-calibrated. This is theoretically cleaner and rewards *information value* rather than *lucky accuracy*.

**3. Epoch-batch information aggregation with front-run resistance.**
The combination of sealed-bid submission within epochs and batch computation of $S_\text{public}$ at epoch boundaries is a novel architectural choice for information markets. It inherits front-run resistance from GestAlt's batch design while maintaining incentive-compatibility of the scoring rule. No prior academic mechanism has specified this combination.

### 4.2 Where Novelty Is Weakest

**1. Proper scoring rule incentive-compatibility.**
The use of log scoring for incentive-compatible belief elicitation is well-established (Good 1952, Hanson 2003). GDM's contribution here is *application* and *stake-scaling*, not a new theoretical result. A peer reviewer will note that the incentive-compatibility proof is a direct application of Good (1952) and Hanson (2003), not a novel derivation.

**2. Track record mechanisms for reputation.**
Reputation systems with track records have been studied extensively in mechanism design (Kreps & Wilson 1982 reputation games; Mailath & Samuelson 2006 on repeated games and reputation). GDM's $T_i$ update is a running log-score, which is novel in its specific form but not in the broader idea that track records should weight information providers. Expert network platforms (Tegus, AlphaSense) already use analyst track records for credentialing.

**3. Stake as credibility bond.**
The idea of using financial stake as a credibility mechanism appears in the prediction market literature (Pennock 2010), oracle design (UMA, Optimistic Oracle), and dispute resolution markets (Augur's REP staking). GDM's stake-credibility function is more formalized but not unprecedented.

### 4.3 Foundational Papers a Peer Reviewer Would Cite in a Rejection

A peer reviewer would likely reject or request major revisions based on the following citation gaps:

**1. Genest & Zidek (1986) — "Combining Probability Distributions: A Critique and an Annotated Bibliography."**
*Objection:* GDM uses a linear opinion pool without justifying this choice over the logarithmic pool. Genest & Zidek provide an axiomatic framework for comparing aggregation rules. A reviewer will ask: under what axioms is LOP optimal for GDM's epistemic structure? Without this, the aggregation choice appears ad hoc.

**2. Ranjan & Gneiting (2010) — "Combining Probability Forecasts."**
*Objection:* Linear combinations of calibrated forecasters are typically miscalibrated (they are over-dispersed). GDM's $S_\text{public}$ from LOP of calibrated knowers will itself be miscalibrated. A reviewer will ask: does GDM need post-hoc calibration of $S_\text{public}$?

**3. Rochet & Tirole (2003) — "Platform Competition in Two-Sided Markets."**
*Objection:* The GDM bootstrap problem is a two-sided market problem. GDM does not cite the platform economics literature on how to bootstrap two-sided markets, nor does it quantify the subsidy required. A reviewer will note this gap.

**4. Gossner (2000) — "Comparison of Information Structures."**
*Objection:* GDM claims to maximize "epistemic utility" (KL divergence reduction) without formally comparing the information structure generated by the epistemic bond market to alternatives. Gossner provides the toolkit for such comparisons.

**5. Geanakoplos (1994) — "Common Knowledge."**
*Objection:* GDM assumes that the prior $S_\text{prev}$ is common knowledge among knowers and unknowers. If $S_\text{prev}$ is not common knowledge, the incentive-compatibility proof is weakened. A reviewer may ask for a robustness analysis.

**6. Hylland & Zeckhauser (1979) — "The Impossibility of Bayesian Group Decision Making with Separate Aggregation of Beliefs and Values."**
*Objection:* GDM's attempt to aggregate beliefs (via $S_\text{public}$) separately from decision-loss functions (unknowers' values) may run into the impossibility result showing that such separation is generally infeasible in a Pareto-consistent manner.

**7. Chen & Pennock (2010) — "A Utility Framework for Bounded-Loss Market Makers."**
*Objection:* GDM should formally compare itself to bounded-loss market maker designs, including those that do not require MM subsidy (conditional on volume). The relevant theorem is that any proper scoring rule can be implemented as a bounded-loss market maker with bounded loss.

---

## 5. Bibliography

Akerlof, G. A. (1970). "The Market for 'Lemons': Quality Uncertainty and the Market Mechanism." *Quarterly Journal of Economics*, 84(3), 488–500.

Brier, G. W. (1950). "Verification of Forecasts Expressed in Terms of Probability." *Monthly Weather Review*, 78(1), 1–3.

Chen, Y., & Pennock, D. M. (2010). "A Utility Framework for Bounded-Loss Market Makers." *Proceedings of the 26th Conference on Uncertainty in Artificial Intelligence (UAI)*, 49–56.

Clarke, E. H. (1971). "Multipart Pricing of Public Goods." *Public Choice*, 11(1), 17–33.

Dawid, A. P. (1982). "The Well-Calibrated Bayesian." *Journal of the American Statistical Association*, 77(379), 605–610.

DeGroot, M. H. (1974). "Reaching a Consensus." *Journal of the American Statistical Association*, 69(345), 118–121.

Geanakoplos, J. (1994). "Common Knowledge." In R. J. Aumann & S. Hart (Eds.), *Handbook of Game Theory*, Vol. 2. Elsevier.

Genest, C., & Zidek, J. V. (1986). "Combining Probability Distributions: A Critique and an Annotated Bibliography." *Statistical Science*, 1(1), 114–135.

Gneiting, T., & Raftery, A. E. (2007). "Strictly Proper Scoring Rules, Prediction, and Estimation." *Journal of the American Statistical Association*, 102(477), 359–378.

Good, I. J. (1952). "Rational Decisions." *Journal of the Royal Statistical Society, Series B*, 14(1), 107–114.

Gossner, O. (2000). "Comparison of Information Structures." *Games and Economic Behavior*, 30(1), 44–63.

Groves, T. (1973). "Incentives in Teams." *Econometrica*, 41(4), 617–631.

Hanson, R. (2003). "Combinatorial Information Market Design." *Information Systems Frontiers*, 5(1), 107–119.

Hanson, R. (2006). "Logarithmic Markets Scoring Rules for Modular Combinatorial Information Aggregation." *Journal of Prediction Markets*, 1(1), 3–15.

Hylland, A., & Zeckhauser, R. (1979). "The Impossibility of Bayesian Group Decision Making with Separate Aggregation of Beliefs and Values." *Econometrica*, 47(6), 1521–1531.

Kreps, D. M., & Wilson, R. (1982). "Reputation and Imperfect Information." *Journal of Economic Theory*, 27(2), 253–279.

Kyle, A. S. (1985). "Continuous Auctions and Insider Trading." *Econometrica*, 53(6), 1315–1335.

Mailath, G. J., & Samuelson, L. (2006). *Repeated Games and Reputations: Long-Run Relationships*. Oxford University Press.

McCarthy, J. (1956). "Measures of the Value of Information." *Proceedings of the National Academy of Sciences*, 42(9), 654–655.

Myerson, R. B. (1979). "Incentive Compatibility and the Bargaining Problem." *Econometrica*, 47(1), 61–73.

Myerson, R. B. (1981). "Optimal Auction Design." *Mathematics of Operations Research*, 6(1), 58–73.

Pennock, D. M. (2010). "A Dynamic Pari-Mutuel Market for Hedging, Wagering, and Information Aggregation." *ACM Conference on Electronic Commerce*.

Ranjan, R., & Gneiting, T. (2010). "Combining Probability Forecasts." *Journal of the Royal Statistical Society, Series B*, 72(1), 71–91.

Rochet, J.-C., & Tirole, J. (2003). "Platform Competition in Two-Sided Markets." *Journal of the European Economic Association*, 1(4), 990–1029.

Savage, L. J. (1971). "Elicitation of Personal Probabilities and Expectations." *Journal of the American Statistical Association*, 66(336), 783–801.

Spence, M. (1973). "Job Market Signaling." *Quarterly Journal of Economics*, 87(3), 355–374.

Stone, M. (1961). "The Opinion Pool." *Annals of Mathematical Statistics*, 32(4), 1339–1342.

Vickrey, W. (1961). "Counterspeculation, Auctions, and Competitive Sealed Tenders." *Journal of Finance*, 16(1), 8–37.

---

*This document is part of the GDM autoresearch knowledge base. It synthesizes the academic literature most directly relevant to the GDM epistemic bond layer mechanism as of r071–r072. It should be read alongside `fundamental-analysis-epistemic-bond-layer.md` (primary design specification) and `atlas-formal-analysis.md` (formal proofs of Q1, Q2, Q3, Q6). Questions and challenges → GitHub Issues or Slack.*
