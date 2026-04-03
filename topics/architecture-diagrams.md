# GDM Architecture Diagrams

**Run:** r073 (Echo — synthesis pass)
**Date:** 2026-04-03
**Author:** Echo (ValCtrl AI — Research Coordinator)
**Issue:** VAL-455
**Inputs:** r071 (fundamental analysis), r072/Atlas, VAL-451/Scout, VAL-453/Lens, VAL-454/Sage
**Status:** COMPLETE

---

## Diagram 1: Epistemic Bond Lifecycle

```mermaid
stateDiagram-v2
    [*] --> ClaimFiled : Knower posts (μ_i, k_i)\nfee escrowed

    ClaimFiled --> Pending : Epoch accumulation\nS_public frozen

    Pending --> EpochBoundary : Epoch closes\nbatch recompute

    EpochBoundary --> AwaitingOracle : S_public updated\nclaims locked

    AwaitingOracle --> Provisional : Hard oracle delayed\nprovisional_status = pending\n[Provisional Install Protocol r070]

    Provisional --> OracleConfirmed : Oracle delivers ω*\nstatus → confirmed

    Provisional --> OracleContradicted : Oracle contradicts\nstatus → contradicted\nauto-challenge initiated

    AwaitingOracle --> HardResolution : Oracle delivers ω*

    OracleConfirmed --> HardResolution : Proceed to settlement

    OracleContradicted --> Slashed : Claim scored negative\nstake → slash_pool

    HardResolution --> Rewarded : R(μ_i, ω*) > 0\nKL-improving claim\nfees + stake returned\n+ pro-rata slash share

    HardResolution --> Slashed : R(μ_i, ω*) < 0\nKL-degrading claim\nstake forfeited\nfees refunded to unknowers

    Rewarded --> TrackRecordUpdate : T_i += η · |R| / k_i

    Slashed --> TrackRecordUpdate : T_i -= η · |R| / k_i

    TrackRecordUpdate --> CredibilityWeightUpdated : w_i = σ(α·T_i) · log(1 + k_i/k₀)\nnormalised in S_public

    CredibilityWeightUpdated --> [*] : Knower eligible\nfor next epoch
```

**Key lifecycle invariants:**
- Fees remain escrowed throughout; no pre-settlement cash-out
- S_public is NOT updated on individual claim arrivals — only at epoch boundaries
- Track record updates are permanent and on-chain; cannot be selectively deleted
- Staleness_detection (penalized) vs. staleness_confirmation (informational only) are tracked separately [r070]

---

## Diagram 2: L1/L2 Layered Architecture with Information Flows

```mermaid
flowchart TB
    subgraph L1["Layer 1: GestAlt Batch Clearing"]
        direction TB
        Orders["Order Batches\n(financial instruments)"]
        Solver["Batch Solver\n(surplus maximization)"]
        L1Settlement["L1 Settlement\nω* = realized outcome"]
        L1Oracle["Multi-source BFT Oracle\n(Chainlink / Pyth / UMA)"]

        Orders --> Solver
        Solver --> L1Settlement
        L1Oracle --> L1Settlement
    end

    subgraph L2["Layer 2: Epistemic Bond Layer"]
        direction TB
        Claims["Knower Claims\n(μ_i, k_i) sealed-bid"]
        EpochAgg["Epoch Aggregation\nbatch recompute at boundary"]
        Spublic["S_public\ncredibility-weighted posterior\nΣ w_i · μ_i"]
        Scoring["Scoring Engine\nR(μ_i, ω*) = k_i·[log μ_i(ω*) − log S_prev(ω*)]"]
        TrackReg["Track Record Registry\nT_i on-chain\nunforkable history"]
        FeePool["Fee Pool\nescrowed until settlement"]

        Claims --> EpochAgg
        EpochAgg --> Spublic
        L1Settlement -->|"ω* (hard oracle)"| Scoring
        Spublic --> Scoring
        Scoring --> TrackReg
        Claims --> FeePool
        Scoring --> FeePool
    end

    subgraph Consumers["Unknower (Demand) Side"]
        direction LR
        U1["Institutional Unknowers\n(hedge funds, quant shops)"]
        U2["AI Agent Consumers\n(autonomous query contracts)"]
        U3["Protocol Derivatives\n(S_public as advisory signal)"]
    end

    subgraph Producers["Knower (Supply) Side"]
        direction LR
        K1["Expert Analysts\n(domain specialists)"]
        K2["Alt-Data Providers\n(supply chain, satellite)"]
        K3["Pyth/Chainlink Operators\n(credentialed data providers)"]
    end

    K1 & K2 & K3 --> Claims
    FeePool -->|"fees + rewards"| K1 & K2 & K3
    TrackReg -->|"credibility weights w_i"| U1 & U2 & U3

    Spublic -->|"advisory signal only\n(NEVER hard anchor)"| L1
    Spublic -->|"credentialed state"| U1 & U2

    classDef advisory stroke-dasharray: 5 5
    class Spublic advisory
```

**Critical coupling discipline** [Atlas r072 / r071 §9.2]:
- S_public → Layer 1 is **advisory only** — never a hard price anchor
- One-way information flow; Layer 1 financial settlement is independent of Layer 2 epistemic state
- Prevents circular self-dealing: L2 epistemic manipulation cannot directly profit via L1 settlement

---

## Diagram 3: TOWL Zone Gating and Solvency Model

```mermaid
flowchart LR
    subgraph TOWL_Calc["TOWL Calculation"]
        direction TB
        WC["escrow_warranted(coord_i)\nfor each active coordinate"]
        CE["Challenge Escrow\n[SEPARATE LEDGER]\nnot included in TOWL"]
        TOWL_Sum["TOWL = Σ escrow_warranted(coord_i)\n[challenge escrow excluded — r070]"]

        WC --> TOWL_Sum
        CE -. "excluded" .-> TOWL_Sum
    end

    subgraph Capacity["Protocol Capacity"]
        CAP["Total Protocol Capacity\n(governance-set ceiling)"]
        RATIO["TOWL / Capacity ratio"]

        TOWL_Sum --> RATIO
        CAP --> RATIO
    end

    subgraph Zones["Three-Zone Health Gate [r070]"]
        direction TB
        ZA["Zone A: TOWL ≤ 70% capacity\n✅ All tiers open\nNormal operations"]
        ZB["Zone B: 70% < TOWL ≤ 90%\n⚠️ T3 installs: 2× base escrow\nT1/T2 unchanged"]
        ZC["Zone C: TOWL > 90%\n🚫 T3 installs BLOCKED\nT2: 1.5× escrow\nT1 always open"]
    end

    RATIO -->|"≤ 70%"| ZA
    RATIO -->|"70–90%"| ZB
    RATIO -->|"> 90%"| ZC

    subgraph Disputes["Challenge Resolution Impact on TOWL"]
        direction TB
        ChallengeWin["Challenger Wins:\nescrow_slashed → challenger\nTOWL DECREASES by slashed amount"]
        ChallengeLose["Challenger Loses:\nchallenge_escrow → updater\nTOWL UNCHANGED"]
        PendingChallenge["Pending Challenge:\nTOWL FROZEN at pre-challenge level\n[no double-counting — r070]"]
    end

    subgraph Orthogonality["Orthogonality Rule [r070]"]
        direction LR
        NOTE["⚠️ TOWL zone does NOT affect S_cred\nCredibility weights w_i are independent\nof warranty capacity status\n\nConflating them → feedback collapse:\n(low TOWL → discounted S_cred → lower fees\n→ fewer claims → lower headroom → repeat)"]
    end

    ZB --> NOTE
    ZC --> NOTE
```

**TOWL invariants [r070]:**
- Pending challenges do NOT reduce TOWL until successful resolution
- Disputed escrow is illiquid but still counts toward solvency backing
- Zone thresholds (70%, 90%) are governance parameters, not hardcoded
- TOWL and epistemic credibility are completely orthogonal signals

---

## Diagram 4: Attack Surface Map

```mermaid
mindmap
  root((GDM Attack Surface))
    Sybil Attack
      Identity multiplication
        Adversary creates m synthetic knower IDs
        Cost: identity_reg_fee × m + stake × m
        Log-diminishing stake means linear cost scaling
        [Atlas r072 Q1: formal lower bound derived]
      Track record washing
        Synthetic unknowers validate synthetic knowers
        Defense: unknowers must post real reliance-bonds
        Defense: correlation penalty on correlated wrong claims
      Wash credibility
        Build T_i on easy domains, apply to hard ones
        Mitigation: domain-stratified track records (not yet implemented)

    Capital-Flood Disinformation
      Rich adversary stakes large wrong claims
        Accepts capital loss to degrade S_public
        Defense: log-diminishing stake influence w_i = log(1 + k_i/k₀)
        Doubling stake does NOT double influence
        [r071 §7.4 — parameters k₀ and α need empirical calibration]
      W_max ceiling
        Maximum credibility weight per knower
        [Atlas r072: W_max alone insufficient — needs common oracle + bounded α]

    Oracle Gaming
      Knower IS the oracle source
        Most severe attack — no protocol-level defense without trusted hardware
        Defense: oracle bond > max observable knower stake
        Defense: multi-source BFT oracle (independent errors)
        Defense: mandatory delay between claim posting and oracle invocation
        [r071 §7.5 — hardest attack, not fully closed]
      Biased oracle
        Systematic oracle bias b(ω) breaks truth-telling for p_i
        Truthful reporting shifts to p_i + b(ω) (effective belief)
        Defense: multi-source BFT minimizes bias; target |b(ω)| < 0.01
        [Atlas r072 Q6: formal proof — noise does NOT break IC; bias DOES]
      Selective delay
        Delay oracle delivery to game provisional status
        Defense: Option C — auto-challenge against oracle, not knower
        Cost: T_challenge challenge response window + C_challenge cost
        [Atlas r072 Q3: Option C recommended]

    Provisional Install Gaming
      Late provisional filing
        File after changepoint is semi-public; claim zero staleness
        Defense: public-source threshold rule
        If 2+ independent sources confirm → holdback = 0
        [r070 §Q3, r071 §7.6]
      Timestamp manipulation
        Millisecond-level timestamp gaming in MEV environments
        Residual risk — requires careful oracle timestamp design

    L1/L2 Circular Self-Dealing
      High-credibility knower manipulation
        1. Stake L2 claim to shift S_public
        2. Place L1 bet profiting from clearing price move
        3. Collect L2 scoring reward AND L1 bet profit
        Defense: advisory-only coupling (S_public never hard anchor)
        Defense: W_max ceiling on per-knower credibility
        Defense: common settlement oracle + bounded coupling α
        [Atlas r072 Q2: formal model — W_max alone insufficient]
        [Requires joint L1/L2 equilibrium model — OPEN]
```

---

*Diagrams produced by Echo for VAL-455. All architectural features reference the canonical specification in `fundamental-analysis-epistemic-bond-layer.md` (r071) and `atlas-formal-analysis.md` (r072). Mermaid syntax verified for GitHub rendering.*
