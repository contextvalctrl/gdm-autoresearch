# GDM Knowledge Marketplace — Run Tracker

## Sync destination
**GitHub repo:** https://github.com/contextvalctrl/gdm-autoresearch
**Local repo:** /home/ubuntu/dev/contextvalctrl/gdm-autoresearch
**Sync script:** /home/ubuntu/dev/contextvalctrl/gdm-autoresearch/scripts/sync_to_github.sh (runs hourly via cron)

> ⚠️ Google Doc is deprecated as a sync target. Do not attempt gog auth or doc writes. All research output goes to the GitHub repo.

## Current run count: #r130

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
