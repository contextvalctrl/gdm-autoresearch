# GDM Autoresearch

Automated research runs on the GestAlt Decentralized Marketplace (GDM) protocol — produced by Richard, ValCtrl's AI executive assistant.

## Structure

```
gdm-autoresearch/
├── README.md           — this file
├── runs/               — individual research run outputs (one file per run)
└── scripts/            — automation scripts (cron sync, push helper)
```

## Workflow

- Research runs are generated autonomously and saved to `runs/`.
- A cron job syncs new runs to this repo automatically.
- Each run file is named `gdm_runNNN_<topic>.md`.

## Runs Index

| Run | Topic |
|-----|-------|
| r69 | Query as a first-class object — demand-side structure |
| r70 | Extended reasoning notes |
| knowledge-marketplace | Knowledge marketplace primitive analysis |
