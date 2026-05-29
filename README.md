# H0: Hack the Zero Stack — Autonomous Robot Fleet Control-Plane

> Entry for the **H0: Hack the Zero Stack** hackathon (AWS + Vercel, managed by Devpost). *"Front-end in minutes. Back-end designed for scale."* Online · deadline **Jun 30, 2026** · **$80,000 cash + $80,000 AWS credits.**

**A B2B SaaS control-plane for autonomous robot fleet operations.** Fleet operators get a real-time dashboard to monitor robot status, review inspection findings, and approve or reject autonomous actions — scaffolded fast with Vercel v0 and backed by AWS databases built for scale.

## Community

Building this in the open — join the team chat on Discord: https://discord.gg/dnP3qARtjH

## The hackathon

Build a **full-stack application** that could actually go to production: scaffold a production-ready Next.js front end with **Vercel v0**, and connect it to one of three **AWS Databases** — **Amazon Aurora PostgreSQL**, **Aurora DSQL**, or **DynamoDB**. Judges are looking for **shippable software, not just demos** — real software craftsmanship, a deliberate data model, and a front-end designed in relation to the back-end.

## Track & stack

Four tracks (B2C · B2B · Million-scale global · Open innovation). Our fit is **Track 2 — Monetizable B2B app**.

- **Front end:** Vercel / v0.app (Next.js)
- **Database:** Aurora PostgreSQL (relational fleet + inspection records) or DynamoDB (high-frequency robot telemetry events) — _TBD, choice drives the data model._

## What we're building

A **robot fleet management SaaS control-plane** targeting operators of autonomous ground robots (inspection, logistics, or last-mile delivery fleets). The dashboard surfaces live robot state (location, battery, task queue), aggregates inspection findings from onboard sensors, and provides a human-in-the-loop action approval flow so operators can authorize or reject high-risk autonomous decisions before they execute.

The Vercel v0 front end lets us ship a polished, responsive operator UI fast. The AWS backend handles the scale requirements of multi-robot telemetry and the relational integrity of fleet configuration, inspection records, and audit logs.

## Architecture

See [`ARCHITECTURE.md`](./ARCHITECTURE.md) — how the v0/Vercel front end connects to the AWS Database and back-end components (required at submission).

## Requirements & source of truth

Full compiled brief — mandatory stack, tracks, submission checklist, prizes, judging criteria — in [`docs/HACKATHON_REQUIREMENTS.md`](./docs/HACKATHON_REQUIREMENTS.md).

## Submission checklist

- [ ] Text description naming the **AWS database(s)** used
- [ ] **Demo video ~3–5 min** (YouTube): problem · for whom · why · working footage · AWS DB used
- [ ] **Published Vercel Project Link + Vercel Team ID**
- [ ] **Architecture diagram** (app → back-end components)
- [ ] **Screenshots** incl. **Storage Configuration** proving AWS Database usage
- [ ] _(Bonus)_ published build content + **#H0Hackathon**
- [ ] Submitted before **Jun 30, 2026 @ 1:00 AM GMT+1**

## Status

Pre-build. No qualifier gate. Forenly already has an AWS account; next: submit the AWS + v0 credits request form, lock the track/database, scaffold the fleet dashboard in v0. See [`docs/HACKATHON_REQUIREMENTS.md`](./docs/HACKATHON_REQUIREMENTS.md).

— *Forenly · part of the [Cadence](https://github.com/Forenly) multi-hackathon initiative.*
