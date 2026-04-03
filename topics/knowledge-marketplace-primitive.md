# Knowledge Marketplace Mechanism — Global Design Document

**GDM Research Thread | ValCtrl Internal**
Last updated: #r1 (2026-04-03)

---

## Framing

Standard prediction markets (LMSR, orderbooks, batch auctions) treat capital as the thing that moves a shared belief state. LMSR prices how capital flows through a cost function. Orderbooks match opposing positions. Batch auctions clear at a uniform price.

The question posed by this thread: what if capital is the *wrong primitive*? What if the actual scarcity being allocated is **credible information**, not probability exposure?

This document tracks the running synthesis of that question across research runs.

---

## 1. Base Primitive

**Standard PMs**: The primitive is a *position* — shares in a binary (or scalar) outcome. Capital buys exposure to a probability. The exchange is: your capital moves the shared price; you earn if the price moves toward truth.

**Knowledge Marketplace (SCM — Staked Claim Market)**: The primitive is a *staked claim* — a tuple `(θ_i, π_i, σ_i)` where `θ_i` is an asserted state value, `π_i` is the informant's precision/confidence, and `σ_i` is posted collateral. (#r1)

What is exchanged is a *credibility-backed assertion*, not a position. There is no counterparty taking the opposite side. The informant is not betting against the demander — the informant is posting a performance bond on their assertion, and the demander is paying for the service of receiving credible beliefs.

The conserved quantity is total staked collateral (minus fees). It is redistributed from incorrect to correct informants at resolution, not from losing side to winning side of a trade. (#r1)

---

## 2. State Model

**Global state vector** `S = {(θ_k, w_k)}`: a set of tracked variables, each with an associated credibility weight.

**Update rule** on new claim `(θ_new, σ_new)`:

```
w_new = σ_new * R_new / (σ_new * R_new + Σ σ_existing * R_existing)
S_new[k] = (1 - w_new) * S_old[k] + w_new * θ_new
```

Where `R_i ∈ [0,1]` is the informant's reputation multiplier derived from Brier-scored historical resolutions.

**Key departure from LMSR**: In LMSR, the state (price) moves when capital flows through the market maker — capital can move price without any assertion. In SCM, the state moves only when a claim is staked. Pure capital without assertion has no state-update effect. This means capital and belief are structurally linked rather than decoupled. (#r1)

**Key departure from orderbooks**: No matching. No counterparty. The state vector is updated by claimed beliefs, not by agreed-upon trades. (#r1)

---

## 3. Credibility Model

**Why does stake convert to trustworthy information?**

The signal extraction argument: an informed agent with private belief `P(θ|I)` substantially different from the prior will find positive EV from staking large `σ` on that belief. An uninformed agent faces symmetric expected loss from staking on any non-prior assertion. Therefore stake is a costly signal of genuine information. (#r1)

This is not just skin-in-the-game rhetoric — it is the formal claim that the participation constraint (`σ * E[gain|I] > 0`) is binding only for informed agents.

**Reputation-discounted stakes**: Raw capital dominance (wealthy agents staking large to overwhelm with wrong beliefs) is prevented by effective stake `= min(σ_i, cap) * R_i`. New agents start at `R = 1` (pure collateral trust) and their reputation adjusts with each resolved claim. This is not a complete defense against plutocracy but substantially narrows the attack window. (#r1)

---

## 4. Market Roles

**Informants (Knowers):**
- Have: private signal about `θ`
- Post: `(θ_i, π_i, σ_i)` within claim window
- Receive at resolution: share of demand-pool payment W proportional to stake × accuracy, plus forfeited stakes from incorrect informants
- Lose: `σ_i` if their claim was significantly wrong (quadratic scoring)

**Demanders (Unknowers):**
- Have: utility for credible state updates, no private signal
- Post: `(question Q, min precision π_min, payment W)`
- Receive: stake-weighted aggregated claim `θ_aggregate` at close of claim window, plus ex-post credibility audit (who was accurate)

**Payment flows** (no bilateral matching):
```
D pays W → escrow
On resolution:
  correct informants share W * (their stake / Σ stake) * accuracy_score
  incorrect informants forfeit σ_i → redistributed to correct informants + protocol fee
```

The demander always receives the aggregate before resolution — information delivery is prospective. Settlement is retrospective and affects only informant payouts. (#r1)

---

## 5. Settlement Model

**Full resolution (clean oracle):**
```
score_i = 1 - (θ_i - θ*)² / max_squared_error  (normalized quadratic)
payout_i = W * (σ_i / Σσ) * score_i  — from demand pool
slash_i  = σ_i * (1 - score_i)  — from stake
net_i    = payout_i - slash_i
```

Informants with `net_i > 0` are paid. Informants with `net_i < 0` lose a portion of stake. Total redistribution is: demand pool W flows to accurate informants; slash pool flows proportionally to accurate informants and protocol. (#r1)

**Partial resolution (fuzzy oracle):** Resolved components are settled normally. Unresolved components: stakes returned pro-rata minus time-value fee (prevents indefinite lockup exploitation). Disputed oracles: escalate to meta-oracle or adjudication layer — oracle providers are themselves staked. (#r1)

**No resolution:** Claim expires. Stakes returned minus holding cost. Demander receives partial W refund. Prevents unresolvable-question manipulation.

**Key structural point**: Settlement is NOT zero-sum between informants and demanders. D always gets the information (the product is delivered). Settlement redistributes between informants based on accuracy. (#r1)

---

## 6. Attack Surface

**Bluffing with stake**: Post large `σ` on a false claim to corrupt state vector, then exit.
→ Defense: stake lockup until resolution. Withdrawal post-claim is prohibited. (#r1)

**Sybil on credibility history**: Create many identities to wash reputation baseline.
→ Defense: reputation normalizes by per-agent capital history; fresh wallets start at R=1 (raw collateral only) with no historical amplification. (#r1)

**Wash credibility**: Collude with alt accounts to build reputation on easy questions, exploit on hard ones.
→ Defense: correlated claims receive divided reputation (if claim cluster is highly correlated, effective R is split among the cluster). Implementation requires correlation detection on claim vectors. (#r1, open problem)

**Collusion**: Coordinate to post false θ and share W, then re-stake on truth before resolution.
→ Defense: time-locked stakes, state-vector divergence detection, and claim window closure. The claim window hard-closes; you cannot revise your claim after posting. (#r1)

**Oracle gaming**: Stake on θ, then manipulate oracle to confirm.
→ Defense: multi-oracle redundancy; oracle providers are staked and subject to same slash mechanism; Schelling-point oracle design for hard-to-manipulate anchors. This remains the hardest attack surface. (#r1)

**Plutocratic dominance**: Wealthy agent overwhelms with large σ.
→ Defense: effective stake = `min(σ_i, claim_cap) * R_i`. Per-claim caps plus reputation weighting. (#r1)

**Cheap-talk pollution**: Stake minimum σ on random claims to move state.
→ Defense: minimum stake threshold; small stakes have negligible state weight. (#r1)

---

## 7. Why Better or Worse Than LMSR / Orderbooks

**vs. LMSR:**
- LMSR cannot distinguish informed from uninformed capital movement. Any capital moves price. SCM requires a staked assertion — capital without belief claim has no effect. (#r1)
- LMSR subsidizes price discovery; the subsidy pays for position-taking. SCM's payment W comes from demanders who explicitly want the information — demand is revealed, not subsidized. (#r1)
- LMSR has well-understood budget bounds (logarithmic market scoring rule). SCM's budget is endogenous to demand volume. Better for scalability; harder to bound maximum subsidy. (#r1)
- LMSR is simpler, battle-tested, and theoretically clean. SCM is more complex and requires heavier oracle machinery. (#r1)

**vs. Orderbook PM:**
- Orderbook matching requires a counterparty. You need someone to take the other side. SCM does not — informants all submit on the same question without matching against each other. (#r1)
- Orderbook reveals only price, not directional reasoning. SCM reveals the asserted state values of informants (or their commitments). (#r1)
- Orderbooks can be dominated by market makers with no informational edge (pure liquidity provision). SCM's stake-scoring mechanism disadvantages uninformed participants. (#r1)

**vs. Batch Auctions:**
- Batch auctions solve clearing fairness; they do not address the information problem. The information content of a batch auction is still only the clearing price. SCM is not a clearing mechanism — it is a belief aggregation mechanism. Fundamentally different layer. (#r1)

**SCM advantages**: Reveals private information structure; credibility-bonds informants; demander demand is explicit; ex-post audit of who was accurate is a genuine product.

**SCM disadvantages**: Higher complexity; oracle-heavy; does not provide continuous price; latency between claim and resolution reduces utility for real-time decision support; does not aggregate the public good of a price signal. (#r1)

---

## 8. Simplest Viable Mechanism Sketch

```
Protocol: Staked Claim Market (SCM) — Minimal Version

Actors:
  Demander D: question Q about scalar θ, payment W (locked at post)
  Informants I_1..I_n: each post (θ_i, σ_i) within claim window

Lifecycle:
  T=0:     D posts Q + W → escrow
  T=1..k:  Informants post (θ_i, σ_i) — stakes locked immediately
  T=k:     Claim window closes
           θ_aggregate = Σ(θ_i * σ_i * R_i) / Σ(σ_i * R_i)
           D receives θ_aggregate (information delivered)
  T=res:   Oracle fires with θ*
           For each informant i:
             score_i = 1 - (θ_i - θ*)² / max_err²
             payout_i = W * (σ_i*R_i / Σσ*R) * score_i
             slash_i  = σ_i * (1 - score_i)
             net_i    = payout_i - slash_i
           Correct informants paid. Incorrect stakes slashed and redistributed.
           D's W is fully consumed by the pool.

No orderbook. No LMSR market maker. No continuous price.
No counterparty matching. Pure: post question → receive staked beliefs → aggregate → settle.
```
(#r1)

---

## 9. Strongest Reason This Idea Fails

**Information is not rivalrous.** (#r1)

If informant I knows θ* and posts claim θ_i, they have revealed their directional belief through the state vector update. Other agents (including demanders and non-paying observers) extract the signal from the public state update without paying W.

This destroys the payment mechanism: rational demanders wait for free state updates rather than paying W. If the state vector is public, D pays for what they can observe for free by watching which informants are staking and in what direction.

This is the fundamental information economics problem: you cannot simultaneously keep a secret and sell it. The claim is revealed before resolution; the signal is already visible. (#r1)

**Partial mitigations**: Commitment schemes (sealed claims revealed only post-window), private delivery channels, or zero-knowledge proofs of claim can defer revelation. But these reduce to: D pays W to see private reasoning *after* the window closes — which delays the problem rather than solving it.

---

## 10. Best Surviving Variant

Given the fatal flaw in §9, the mechanism must separate state vector update from information delivery. (#r1)

**Variant: Private Signal Subscription (PSS)**

1. D posts `(Q, W, π_min, delivery_deadline)` — public
2. Informants post sealed commitments: `hash(θ_i || nonce_i)` — no state update yet
3. D's payment W is released to committed informants after deadline (participation fee for showing up)
4. Informants reveal `(θ_i, σ_i, nonce_i)` after deadline — private delivery to D only, not broadcast
5. D receives individual claimed values + the credibility-weighted aggregate — **not visible to others**
6. At resolution: oracle fires; scoring and stake settlement proceed as in §8
7. Public state vector only updates from the oracle, not from the claims

**Key departure from §8**: D receives private, not public, information delivery. The signal structure is not broadcast. This preserves D's payment incentive (they cannot free-ride on others' payments) and maintains the credibility bond (informants are still slashed for wrong claims). (#r1)

**What this mechanism actually is**: A *credibility-bonded private advisory market*. Not a prediction market. Not a scoring rule market. Not a clearing mechanism.

The product sold is: *a credibility-audited, privately delivered belief update*. Capital does not reallocate PnL; it backstops the credibility of the advice.

**Remaining open problems for future runs**:
- Collusion between informant and non-paying agents who extract D's private signal post-delivery
- Reputation bootstrapping: how do new informants acquire R > 0?
- Multi-variable Q: how does the SCM/PSS scale to vector-valued θ?
- Oracle mechanism design: who provides oracles, how are they staked?
- Equilibrium existence: is there a Nash equilibrium where informed agents truthfully reveal at optimal σ?

---

---

## R2 Additions — 2026-04-03

### 2a. Incentive Compatibility — Proof Sketch (#r2)

**Claim**: In SCM (§8), truthful reporting is a Bayes-Nash equilibrium under quadratic scoring.

**Setup**: Informant i has private signal `s_i` which is a noisy observation of `θ*`. Their posterior is `P(θ*|s_i)` with mean `μ_i` and variance `v_i`. They choose reported claim `θ_i`.

**Argument**:
- Expected payout from W-pool: `E[W * (σ_i*R_i / Σσ*R) * (1 - (θ_i - θ*)² / max_err²)]`
- The score is maximized in expectation when `θ_i = E[θ*|s_i] = μ_i`
- This follows directly from the standard proper scoring rule result: for any proper scoring rule S(θ_i, θ*), `E[S(θ_i, θ*)] ≤ E[S(μ_i, θ*)]` with equality iff `θ_i = μ_i`
- The stake-slash term `σ_i * (1 - score_i)` is also minimized in expectation by truth
- Therefore combined `E[net_i]` is maximized by `θ_i = μ_i`

**Caveat**: This holds for each informant *in isolation*. Strategic interaction between informants is not captured — if informant i can observe others' claims before posting, they can defect toward a consensus that maximizes their accuracy score against the aggregate rather than against truth. This is the herding problem. (#r2)

**Defense against herding**: The claim window must close without informants observing each other's claims during posting. Sealed commitments + simultaneous reveal (as in PSS) enforces independent elicitation. This is why PSS is strictly better incentive-theoretically than the open-claim version in §8. (#r2, supersedes open-claim design in §8 as preferred structure)

---

### 2b. PSS Does Not Fully Solve the Free-Rider Problem (#r2)

The r1 §10 PSS variant claims private delivery preserves D's payment incentive. This needs pressure-testing.

**Scenario**: Two demanders D1 and D2 want the same θ*. D1 pays W; D2 waits. After resolution, D2 observes the oracle θ* directly and infers informant quality from the public slash/payout outcomes.

**What D2 got for free**: Not the pre-resolution private prediction, but the post-resolution accuracy audit of each informant. Over time, D2 builds a reputation map of informants without paying. In future rounds, D2 will know which informants to weight highly and can free-ride on the credibility-building that D1's payments funded.

**This is not just the standard free-rider problem — it is a temporal free-rider**. The product that degrades is not the prediction itself but the *reputation scoring infrastructure*. D1 pays to generate informant reputation data that D2 exploits in future rounds. (#r2)

**Partial fix**: Reputation data is gated — informant history is only visible to staked participants (agents who have paid at least one W in the last N rounds). This makes reputation-access rivalrous, not free. (#r2)

**Stronger fix**: Move to a *subscription model*. D pays a recurring W for access to the reputation-weighted aggregation service. Single-question pricing degrades to free-riding; subscriptions create alignment between D's continued interest and funding the reputation infrastructure. (#r2)

---

### 2c. Multi-Variable θ Extension (#r2)

r1 treated θ as a scalar. Real systems have vector-valued state: `θ = (θ_1, θ_2, ..., θ_m)`.

**Problem**: Informants have heterogeneous expertise. Informant A has signal on θ_1 but not θ_3. If they post a full vector claim, they are forced to fabricate values for variables they don't observe, polluting the aggregate.

**Sparse claim mechanism**: Informants post *partial claims* — `(θ_j, σ_j)` for any subset of variables j. Stake is component-specific. State update is per-component:

```
S_new[j] = Σ_{i: j ∈ claim_i} θ_{i,j} * σ_{i,j} * R_{i,j} / Σ σ * R (per component)
```

Reputation `R_{i,j}` is tracked *per variable* per informant, not globally. An informant who is excellent at θ_1 and random at θ_3 accumulates high `R_{i,1}` and regresses toward 1.0 for `R_{i,3}`.

**Key property**: Per-component reputation prevents cross-variable contamination of credibility. Informants are incentivized to only stake on variables where they have genuine signal. (#r2)

**Open problem**: Correlated variables. If θ_1 and θ_2 are strongly correlated, an informant with signal on θ_1 has indirect signal on θ_2. The mechanism should detect this and allow informants to stake on implied components — or alternatively, compress the state vector via PCA and let informants claim on latent dimensions. This is an active research question. (#r2)

---

### 2d. Reputation Bootstrapping — Concrete Proposal (#r2)

r1 flagged this as an open problem. Here is a concrete design:

**Phase 0 — Genesis pool**: At protocol launch, N "seeded informants" are selected from an application pool. They receive a *genesis reputation bond* — a locked deposit (not stake) that serves as a reputational anchor. Their R is initialized at `R_genesis > 1` (e.g. 1.5) based on vetted track record. This is off-chain trust injected once.

**Phase 1 — Cold start via calibration markets**: New (unproven) informants must first stake on publicly resolvable calibration questions — questions where the truth is known ex-ante to the protocol but not revealed to the informant. These are drawn from a library of past resolved events with delayed reveal dates. Accurate performance on calibration questions raises R from 1.0 toward 2.0 in a small number of rounds. (#r2)

**Phase 2 — Decay and refresh**: Reputation decays toward 1.0 at rate δ per epoch if no claims are filed. This prevents reputation hoarding from a hot-streak followed by inactivity exploiting accumulated R in a future high-stakes claim. (#r2)

**Sybil resistance property**: Reputation is not transferable. A high-R informant cannot sell their R to another agent. R is bound to the signing key + staking history. Creating a new sybil key resets R to 1.0. The economic value of R is only realized by the agent who built it, which makes R-building a costly (time+capital) investment not easily bootstrapped with new identities. (#r2)

---

### 2e. Design Space Positioning — Where Does SCM/PSS Sit? (#r2)

A sharper characterization of the mechanism family:

```
Mechanism         | Conserved quantity  | Update trigger          | Information product       | Settlement
------------------|---------------------|-------------------------|---------------------------|----------
LMSR              | Cost function bound | Any capital flow        | Continuous probability    | PnL on positions
Orderbook PM      | Order book depth    | Matched counterparty    | Market price              | P&L on fills
Batch auction     | Aggregate demand    | Batch close             | Clearing price            | Position at uniform price
Scoring rules     | Protocol budget     | Submitted report        | Elicited forecast         | Scoring payout
SCM (§8)          | Total staked        | Asserted claim          | Credibility-weighted state| Stake redistribution
PSS (§10/r2)      | Subscription pool   | Committed+revealed      | Private advisory + audit  | Stake + subscription fee
```

**Key distinctions**:
- LMSR/orderbook/batch: capital moves price; price is the output. SCM/PSS: assertion moves state; credibility-audited belief is the output.
- Scoring rules (Hanson's peer prediction, Bayesian truth serum) are the closest cousin. SCM is a *capital-backed scoring rule market with a demand side*. The demand side (D's payment W) is what scoring rules lack.
- The canonical information market (Arrow-Debreu securities) maximizes allocative efficiency. SCM maximizes epistemic efficiency — getting the best available private signal into the aggregate. These are not the same objective. (#r2)

**Revised framing**: SCM is not a prediction market. It is a *credibility-bonded epistemic auction*. The auctioned good is a credible state update. The auctioneer is the scoring rule. Capital is the bond that makes the auction work, not the primary exchange medium. (#r2)

---

### 2f. Killing the Weak Variants (#r2)

r1 described three implicit design variants. Explicit kill analysis:

**Variant A — Open-claim SCM (§8 as written)**: KILLED. Herding incentive breaks truthfulness. Informants observe each other's claims and anchor toward a median rather than posting independent signals. Replace with sealed-commit structure (PSS). (#r2)

**Variant B — Public state-update PSS**: KILLED by temporal free-rider problem (§2b). If state vector updates are public post-resolution, reputation data is free. Subscription gating on reputation access is required for D's payment to remain incentive-compatible. (#r2)

**Variant C — PSS with reputation gating + subscription**: SURVIVES. Core mechanism: sealed commit, private delivery to subscriber, per-component reputation, subscription-gated reputation access, stake-slash on resolution. This is the strongest surviving variant. (#r2)

---

### Updated Open Problems for #r3+

1. **Correlation detection for wash-credibility** (carry from r1): How do you identify a cluster of sybil accounts building correlated fake reputation? Requires a correlation penalty on the effective-R computation.

2. **Oracle staking mechanism**: How are oracle providers incentivized? They face the same credibility problem as informants, with the added risk that oracle manipulation directly impacts informant payoffs. A meta-oracle (oracle of oracles) collapses into infinite regress — need a termination condition.

3. **Equilibrium welfare comparison**: Does PSS generate higher social welfare than LMSR on the same underlying information structure? Requires formal model. Prior expectation: PSS is better for asymmetric, private-signal environments; LMSR is better for shallow-information, many-agent environments where the crowd signal is strong.

4. **Latency problem**: PSS delivers information after claim window closes. For time-sensitive questions, this may make the mechanism useless by the time D receives the aggregate. Explore: rolling claim windows, streaming PSS with partial early revelation, or express-lane claims at higher cost.

5. **Composability**: Can SCM/PSS serve as a credibility oracle for an on-chain protocol? If GestAlt uses PSS to update its own state vector before batch auction clearing, does the credibility bond structure transfer any security guarantees to the clearing layer? (#r2)

---

*This document is cumulative. Each run adds net-new synthesis only. Superseded ideas are updated in-place with run reference tags.*

---

## R3 Additions — 2026-04-03

### 3a. Oracle Regress — Termination Condition (#r3)

r2 left the oracle staking problem open: oracle providers need to be credibility-bonded, but who bonds the meta-oracle? The infinite regress must terminate somewhere.

**The key reframe**: Regress terminates at *cost*, not at *truth*.

You do not need the oracle to be epistemically perfect. You need oracle manipulation to be more expensive than the benefit from manipulation. This is a game-theoretic termination condition, not an epistemic one. The design goal is: `cost_to_manipulate_oracle > max_gain_from_manipulation`. (#r3)

**Concrete mechanism: Dispute-bond oracle**

Oracle fires with value θ_oracle. A dispute window T_dispute opens (e.g. 24 hours). Any party can post a counter-oracle bond δ_dispute claiming θ_oracle is wrong. If δ_dispute exceeds a threshold (e.g. 10× protocol fee), a meta-review is triggered. The meta-reviewer is a multi-sig governance committee — this IS a trust anchor, but it terminates the regress. Key properties:

1. Dispute bonds must exceed the benefit of false disputes (prevents spurious disputes from informants who lost on a truthful oracle).
2. Successful disputes slash the original oracle provider's stake (not just the bond).
3. Oracle providers post a *pre-committed* stake before the claim window opens, locked until after dispute window closes. This prevents oracle providers from holding positions that benefit from their own manipulation.

**Role separation via capital lockup**: Oracle providers with locked pre-committed stake cannot also be informants in the same round (their capital is committed). This structurally separates the oracle-provider role from the informant role, preventing the "stake on θ, then manipulate oracle to confirm" attack identified in §6. Dual-role participation is possible but requires 2× capital: once for the oracle stake and once for the informant stake. The cost of the attack rises proportionally. (#r3)

**Which facts need Schelling-point vs. dispute-bond oracles**: For questions where truth is publicly observable (fed rate decision, election outcome, sports result), a pure Schelling-point oracle is sufficient — manipulation is detectable by any observer and coordination to dispute is free. No staking needed. For questions where truth is contested or privately observed (startup valuation, private company metrics, proprietary data), dispute-bond oracles with governance backstop are required. PSS should distinguish these two oracle tiers at question-posting time. (#r3)

---

### 3b. Correlation Detection — Practical Design (#r3)

r2 identified wash-credibility (sybil cluster building correlated reputation) as an open problem but provided only a heuristic correlation penalty.

**The right diagnostic**: Track *claim residual correlation* — correlation between informant claims after removing the public-signal component. Correlated claims driven by the same news are not attacks; correlated claims that cannot be explained by observable public information are suspicious.

**Operationally**: Each claim round, the protocol publishes a "public information baseline" θ_baseline (e.g. the LMSR-equivalent of current prediction-market prices). Informant i's residual is `r_i = θ_i - θ_baseline`. If agents A, B, C have high pairwise correlation in their *residuals* across N rounds (not in their raw claims), they are likely coordinating on private signal coordination or sybil-washing rather than independently observing the same public information. (#r3)

**Residual correlation penalty**:
```
ρ_ij = corr(r_i, r_j) over last N rounds
effective_R_i = R_i * (1 - max_j≠i ρ_ij * penalty_weight)
```
Where `penalty_weight ∈ [0, 1]` is a protocol parameter. Setting it to 0.5: an informant with a perfectly correlated sybil twin has effective R halved.

**Coordination timing defense**: Even if sybil agents want to coordinate claims, sealed commitments + randomized window-close timing (Poisson-distributed close signal) break the coordination timing. Sybils can pre-agree on a target θ, but if they cannot see each other's commitments until post-reveal, randomized window timing means they cannot confirm coordinated participation before the window closes. This makes coordination costly (requires pre-round communication that is off-protocol and detectable via social-layer monitoring). (#r3)

**Remaining gap**: Agents with a shared employer or common information source will naturally have correlated residuals without being sybils. The mechanism cannot distinguish "same firm, shared research" from "same person, multiple wallets." This is an accepted limitation — the protocol can penalize claim clusters without making a legal determination about their origin. (#r3)

---

### 3c. Equilibrium Welfare Conjecture — When PSS Beats LMSR (#r3)

**Informal conjecture**: In a setting where K << N agents have high-quality private signals (K much less than N), and these agents are privacy-sensitive about their signal structure, PSS achieves higher information aggregation efficiency than LMSR. (#r3)

**Argument**:
LMSR aggregates signals through price movement. Each informed trade reveals directional signal strength through price impact. A K-informed agent with strong private signal must choose: trade aggressively and reveal their signal (enabling free-riding by other agents who piggyback on their price impact), or trade conservatively and under-reveal to protect their information advantage. This is Kyle (1985)'s strategic informed trading problem. LMSR informed agents face the same tradeoff: large trades = more profit but more signal revelation.

PSS eliminates this tradeoff for informed agents. The informant's claim is delivered *privately* to the subscriber — no price signal leaks to non-subscribers. The informant still reveals their claim at resolution (for scoring), but at that point the information is already stale. Privacy-sensitive K-informants who would avoid LMSR participation (or trade minimally to hide their edge) are willing to participate in PSS because their private signal structure is not broadcast during the round.

**Implication for mechanism design**: PSS is not just "LMSR with credibility bonds." It solves a different participation problem. LMSR maximizes breadth of participation (many weak signals are aggregated). PSS maximizes depth of participation (few strong signals are elicited from privacy-sensitive agents who would not participate in LMSR). Optimal mechanism design for a given question type depends on whether the information environment is wide-shallow (many noise traders, few insiders → LMSR) or narrow-deep (few high-signal insiders → PSS). (#r3)

**Practical implication**: Questions where the best-informed agents are institutionally sensitive (e.g. regulators, company insiders, specialized analysts who cannot publicly reveal positions) favor PSS over LMSR. Questions where crowd wisdom aggregation is the primary value favor LMSR. GestAlt should support both and route question types accordingly. (#r3)

---

### 3d. Latency Solutions — Rolling Window with Express Lane (#r3)

r2 flagged latency as a potential mechanism killer for time-sensitive questions.

**Rolling-window PSS with sealed commits**: Informants post sealed commitments at any time in a rolling T_window duration window. Aggregate is only computed at window close. Window close time is probabilistic (Poisson-distributed), preventing timing games. Informants cannot observe each other's commitments during the window (sealed), preventing herding. At window close, all commitments are simultaneously revealed and the aggregate computed. This enables continuous claim availability while preserving the sealed-commit incentive properties. (#r3)

**Express lane protocol**:
- D posts question with `priority: EXPRESS` and W_express > W_standard (higher payment)
- Express window is short: T_express = 5 minutes (configurable)
- Express-lane informants must have `R_i > R_express_threshold` (e.g. R > 1.5) — gates out cold-start informants from time-sensitive rounds
- Higher W_express compensates informants for participating in a shorter window with less time to observe public signals before posting
- Protocol charges a priority fee δ_express that is distributed to informants who consistently show up for express rounds (participation incentive for maintaining express-lane readiness)

**Streaming PSS** (r4 candidate): Rather than batch windows, informants post claims continuously with an infinite time horizon, and D receives a continuously updated aggregate θ_t that decays old claims (time-weighted exponential average). This is operationally simpler but re-introduces the herding problem because later informants observe the running aggregate. Flagged for r4 analysis. (#r3)

---

### 3e. Composability with GestAlt (#r3)

r2 asked: can PSS serve as a credibility oracle feeding GestAlt's batch-auction clearing layer?

**Integration architecture**:

```
Layer 1 — PSS oracle (5-minute sealed-commit rolling windows)
  ↓ θ_aggregate with credibility signal (Σσ*R, variance, claim count)
Layer 2 — GestAlt batch clearing (e.g. hourly)
  Uses: (a) θ_aggregate from PSS + (b) order-flow-derived clearing price
  Reconciliation: if |θ_PSS - θ_orderflow| > δ_divergence, flag for dispute window before clearing
Layer 3 — Settlement
  PSS informants settle against resolution oracle
  GestAlt positions settle against clearing price
```

**What PSS adds to GestAlt's security model**: A parallel credibility signal that is independent of the order-flow price. An attacker trying to manipulate GestAlt's clearing price via order flow manipulation must also manipulate the PSS aggregate to avoid triggering the divergence flag. This requires capital on two independent layers simultaneously — significantly raising attack cost. (#r3)

**Key design question**: Does the PSS aggregate feed as a *hard constraint* on GestAlt clearing (clearing cannot deviate from θ_PSS by more than δ) or as a *soft signal* (informational input to clearing price with no hard constraint)?

**Recommendation**: Soft signal in early deployment, hard constraint after the PSS layer has accumulated sufficient reputation history to be trusted. The transition from soft to hard can be governed by a credibility threshold: when the total staked weight Σσ*R in the PSS pool exceeds a solvency-level threshold relative to the GestAlt clearing volume, upgrade to hard constraint. This is a gradual trust accumulation mechanism that avoids over-reliance on a nascent PSS layer. (#r3)

**Solvency implication**: If PSS is providing a hard oracle for GestAlt clearing, PSS informant stakes must be large enough to cover the solvency cost of a wrong oracle input. Informant stake pool must be sized relative to GestAlt's maximum clearing exposure. This creates a capital requirement for PSS participation in the hard-constraint mode — naturally gating out undercapitalized informants who shouldn't be providing hard oracles. (#r3)

---

### 3f. New Thread — BTS-PSS Hybrid for Dominant-Strategy Truthfulness (#r3)

r1-r2 achieved Bayes-Nash truthfulness via proper scoring. This is weaker than dominant-strategy truthfulness — it assumes others are also truthful. If even one informant defects strategically, the BNE can unravel.

**Bayesian Truth Serum (BTS) insight** (Prelec 2004): dominant-strategy truthfulness in multi-agent elicitation is achievable if each agent also reports a *meta-prediction* of the distribution of other agents' reports. A truthful agent's meta-prediction is more accurate (in a specific sense) than a lying agent's, enabling a payment rule that rewards truthful reporters.

**BTS-PSS hybrid structure**:
- Informant i posts: `(θ_i, σ_i, meta_i)` where `meta_i` is their prediction of the distribution of other informants' claims
- Payment rule includes a term that rewards θ_i being *surprisingly more common* than meta_i predicted
- Formally: BTS payment = `score(θ_i, θ*) + α * [log P(θ_i | others' reports) - log meta_i(θ_i)]`
- The second term is positive when your report is more common among truthful agents than you expected it to be — which is exactly what happens when you report truthfully and others are also truthful

**Why this achieves dominant-strategy truthfulness**: Lying involves posting θ_i ≠ μ_i. A liar must also post an accurate meta_i to maximize the second term. But an accurate meta_i reflects what truthful agents would report — which is centered around truth. This creates a self-defeating incentive: reporting falsely while accurately predicting that others will report truthfully maximizes the second term but loses on the first. No consistent payoff improvement from lying. (#r3)

**Practical complexity**: BTS requires informants to have a model of other informants' type distribution. This is cognitively and informationally demanding. Practical implementation may need to approximate: informants post a scalar "confidence in consensus" rather than a full distribution. Simplified BTS has weaker guarantees but preserves the directional incentive property. Flag for r4: full BTS-PSS specification with simplified meta-report structure. (#r3)

---

### Updated Open Problems for #r4+

Carried from r2 (updated status):
1. **Correlation detection** — ✅ residual correlation + randomized window timing design complete (#r3). Open: distinguishing institutional from sybil correlation.
2. **Oracle staking** — ✅ dispute-bond + oracle/informant role separation via capital lockup (#r3). Open: oracle tier selection (Schelling vs. dispute-bond) at question-posting time.
3. **Equilibrium welfare comparison** — ✅ informal conjecture + wide-shallow vs. narrow-deep routing (#r3). Open: formal model.
4. **Latency** — ✅ rolling window + express lane (#r3). Open: streaming PSS analysis.
5. **Composability** — ✅ layered architecture + soft→hard constraint migration path (#r3).

New from r3:
6. **BTS-PSS hybrid**: Full specification with simplified meta-report. What is the simplest BTS variant that is cognitively tractable for informants while still achieving dominant-strategy or near-dominant-strategy truthfulness? (#r3→r4)
7. **Capital sizing for hard-constraint PSS oracle**: What is the minimum informant stake pool size (as a function of GestAlt clearing volume and maximum oracle deviation) required for the hard-constraint upgrade to be solvency-safe? (#r3→r4)
8. **Question routing heuristic**: What observable question properties (breadth of potential informants, privacy-sensitivity of signal, time horizon, oracle type) determine whether to route to PSS vs. LMSR? Can this be automated? (#r3→r4)

---

*This document is cumulative. Each run adds net-new synthesis only. Superseded ideas are updated in-place with run reference tags.*
