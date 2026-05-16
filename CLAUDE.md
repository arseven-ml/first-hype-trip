# Boros 30-Day Campaign Tracker

## What this project is
Dashboard tracking the 30-day HL-targeting growth campaign for Pendle Boros. Goal: 600 new activated users in 30 days, driving 7DMA fee-payers from 160 → 1,550.

## Files in this folder

| File | Purpose |
|---|---|
| `index.html` | Main dashboard — Boros dark theme, editable KPIs, Google Sheets integration, flow diagram |

## Hosting
- **GitHub repo:** https://github.com/arseven-ml/first-hype-trip
- **GitHub Pages:** enabled on `main` branch
- **Cowork artifact:** `boros-30day-campaign` (synced with file)

## Google Sheets integration
- Published CSV URL is hardcoded in `index.html`
- Sheet columns: `metric` (Column A) | `value` (Column B)
- Valid metric IDs: campDay, activatedUsers, organicUsers, feePayers7d, dailyOrderUsers, w1Retention, weeklyAwareness, dailyAwareness, convRate, postLanding, hlDepositors, nonhlDepositors, hlAvgDep, nonhlAvgDep, hlTimeDep, nonhlTimeDep, creditsIssued, qualDeposits, hlRefUsers

## Methodology (inherited from boros-funnel project)
- **New users only**: exclude wallets with balance before 2026-03-16
- **Sequential 6-stage filter**: awareness → consideration → wallet → deposit modal → deposit initiated → order submitted
- **Activation**: `boros_order_submitted` frontend event
- **Active user (fee-payer)**: ≥$0.1 in fees (swap_fees + settlement_fees), excluding MMs

## Versioning
Version footer in `index.html` — bump on any structural/format change. Current: v1.4.

## Current state — UPDATE THIS AT END OF EVERY SESSION
- **Working on:** Synced Cowork artifact with project file, added versioning
- **Last edited file:** `index.html` — fixed truncation, restored recalc() ending, added v1.4 footer
- **Cowork artifact:** `boros-30day-campaign` synced 2026-04-21
- **Version:** v1.4 (daily awareness + corrected metrics)
- **Next step:** `git push origin main` to update GitHub Pages, then keep updating Google Sheet daily
- **Open issues:** None
