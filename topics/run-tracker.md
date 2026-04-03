# GDM Knowledge Marketplace — Run Tracker

## Sync destination
**GitHub repo:** https://github.com/contextvalctrl/gdm-autoresearch
**Local repo:** /home/ubuntu/dev/contextvalctrl/gdm-autoresearch
**Sync script:** /home/ubuntu/dev/contextvalctrl/gdm-autoresearch/scripts/sync_to_github.sh (runs hourly via cron)

> ⚠️ Google Doc is deprecated as a sync target. Do not attempt gog auth or doc writes. All research output goes to the GitHub repo.

## Current run count: #r139

## Topic files (living docs in repo/topics/)
- `query-as-first-class-object.md` — demand-side structure, query as first-class object
- `knowledge-marketplace-primitive.md` — full aggregate KM mechanism spec
- `extended-reasoning-notes.md` — extended reasoning notes

## Run log
- #r1–#r68: Base primitive, state model, credibility model, market roles, settlement, attack surface, LMSR comparison.
- #r69: Participation equilibrium, thin-market failure, authority vacuum. Bootstrap underwriter role, challenger-subsidy pool, no-competition holdback haircut.
- #r70: Closed TOWL double-counting; tier migration prohibited; provisional install protocol; TOWL three-zone hard gates.
- #r71: Provisional install timeout FSM; TOWL epoch-locked demander budget; credibility_ratio carry-over under supersession; GestAlt epoch boundary as first-class clock.
- #r72: SEE systemic circuit breaker; multi-coordinate dependency architecture; micro/macro epoch structure; sybil/negative-history defense.
- #r73: Implication declarations as incentive-metadata only; timestamp-tagged staleness discount; four-layer SEE capture defense; chain-length discount.
- #r74: Per-class staleness decay exponent κ; two-tier SEE appeals; β default 1.5; SEE pre-staging defense; Epistemic Audit Trail.
- #r75: EAT DA stack (Celestia + Ethereum anchor); degraded mode spec; trustless correlation filter; anti-fragmentation fix; governance interface redesign.
- #r76: Degraded-mode κ_floor=2.0; per-pair implication bonus γ_corr=0.3; K_target normalization; genesis bootstrap 3-phase protocol.
- #r129: Lineage-bifurcated γ_corr; T3 gate = ≥2 submitted epochs; κ_degraded dynamic floor; β_effective clamp [1.0, 2.5].
- #r130: T3 gate paused in degraded mode; γ_corr_cross ≤ γ_corr invariant; Phase-1 new classes κ_system_max_at_T_outage; unbundled T3 escrow via LTRP.
- #r131: LTRP genesis seed protocol; LTRP as TOWL-separate protocol buffer; one-epoch epistemic bridge at DA restore; T3_outage_lockup_cap with LTRP assumption. Bounded-liability architecture synthesis: no infinite-lockup obligations for any participant.
- #r132: r089 fine-tune pass (VAL-494) — cross-corpus consistency check post-r088/r131; duplicate footer removed from epistemic-bond-v0-spec.md; §10 deferred-features list updated with r129–r131 Phase 3 items (LTRP, bounded-liability architecture, DA degraded mode refinements, γ_corr lineage-bifurcation, β_effective clamp). No arithmetic corrections required; r088 corpus verdict confirmed valid.
- #r133: r090 fine-tune pass (VAL-500) — cross-corpus consistency check post-r089; two header/footer metadata discrepancies resolved: (1) epistemic-bond-v0-spec.md Run/Issue header chain updated to include r089/VAL-494 entry; (2) real-world-validation.md footer signature updated from r076/VAL-461 to r076→r086→r090/VAL-500. No arithmetic corrections required; r089 corpus verdict confirmed valid.
- #r134: r091 fine-tune pass (VAL-501) — cross-corpus consistency check post-r090; two header/footer metadata discrepancies resolved: (1) epistemic-bond-v0-spec.md footer signature corrected from `r075 | VAL-460 → updated r089 | VAL-494` to include r090/VAL-500 and r091/VAL-501; Run/Issue header chain updated to include r091/VAL-501 entry; (2) real-world-validation.md Run/Issue header chain updated to include r090/VAL-500 and r091/VAL-501 entries (footer was already updated in r090 but header chain was not propagated). No arithmetic corrections required; r090 corpus verdict confirmed valid.
- #r135: r092 fine-tune pass (VAL-502) — cross-corpus consistency check post-r091; two header/footer metadata discrepancies resolved: (1) real-world-validation.md footer signature corrected from `r076 → r086 → r090 | VAL-461 → VAL-474 → VAL-500` to include r091/VAL-501 and r092/VAL-502 chain entries (r091 updated the Run/Issue headers but did not propagate to the footer — inverse of the r091 fix pattern); (2) epistemic-bond-v0-spec.md Run/Issue header chain and footer signature updated to include r092/VAL-502 entry. No arithmetic corrections required; r091 corpus verdict confirmed valid.
- #r136: r093 fine-tune pass (VAL-503) — cross-corpus consistency check post-r092; no arithmetic or structural corrections required. Run/Issue header chain and footer signature updated to include r093/VAL-503 entry in real-world-validation.md and epistemic-bond-v0-spec.md. r092 corpus verdict confirmed valid; corpus remains fully consistent and arithmetically correct at $1/unit pricing.
- #r137: r094 fine-tune pass (VAL-504) — cross-corpus consistency check post-r093; no arithmetic or structural corrections required. Run/Issue header chain and footer signature updated to include r094/VAL-504 entry in real-world-validation.md and epistemic-bond-v0-spec.md. r093 corpus verdict confirmed valid; corpus remains fully consistent and arithmetically correct at $1/unit pricing.
- #r138: r095 fine-tune pass (VAL-505) — cross-corpus consistency check post-r094; no arithmetic or structural corrections required. Run/Issue header chain and footer signature updated to include r095/VAL-505 entry in real-world-validation.md and epistemic-bond-v0-spec.md. r094 corpus verdict confirmed valid; corpus remains fully consistent and arithmetically correct at $1/unit pricing.
- #r139: r096 fine-tune pass (VAL-506) — cross-corpus consistency check post-r095; no arithmetic or structural corrections required. Run/Issue header chain and footer signature updated to include r096/VAL-506 entry in real-world-validation.md and epistemic-bond-v0-spec.md. r095 corpus verdict confirmed valid; corpus remains fully consistent and arithmetically correct at $1/unit pricing.
