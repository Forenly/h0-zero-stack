# Architecture — H0: Hack the Zero Stack (Forenly)

> Required at submission: a diagram showing how the application connects to its back-end components — specifically the **v0/Vercel front end → AWS Database** path. This is the skeleton; specifics land once the track and database are locked.

## High-level flow

```
        User (browser)
            │  HTTPS
            ▼
   ┌──────────────────────────────┐
   │  Vercel / v0.app             │   Next.js front end
   │  (Next.js, scaffolded in v0) │   scaffolded with v0,
   │                              │   deployed on Vercel
   │   ┌────────────────────┐     │
   │   │ Route handlers /   │     │   server-side data access
   │   │ Server Actions     │     │   (API routes, RSC)
   │   └─────────┬──────────┘     │
   └─────────────┼────────────────┘
                 │  SQL / SDK (over TLS, VPC/connection pooling)
                 ▼
   ┌──────────────────────────────┐
   │  AWS Database (pick ONE)     │
   │  • Aurora PostgreSQL         │   relational, SQL
   │  • Aurora DSQL               │   distributed, serverless SQL
   │  • DynamoDB                  │   NoSQL, single-digit-ms KV
   └──────────────────────────────┘
```

## Components

| Component | Role |
|---|---|
| **v0 / Vercel front end** | Production-ready Next.js app scaffolded in v0, deployed on Vercel. Owns UI, routing, and server-side data access (route handlers / server actions). |
| **Data access layer** | Server-side queries from Vercel to the AWS Database over TLS — connection pooling (e.g. RDS Proxy / Data API) for Aurora, or AWS SDK for DynamoDB. Credentials via Vercel env vars, never client-side. |
| **AWS Database** | The persistence layer — exactly one of Aurora PostgreSQL, Aurora DSQL, or DynamoDB. The data model is deliberate and chosen to fit the workload (relational vs. distributed-SQL vs. key-value). |

## Database choice (TBD — drives the data model)

| Option | Best when | Trade-off |
|---|---|---|
| **Aurora PostgreSQL** | Rich relational model, joins, transactions | Provisioned/serverless cluster to manage |
| **Aurora DSQL** | Active-active, multi-region, serverless SQL at scale | Newer; SQL subset constraints |
| **DynamoDB** | Million-scale, predictable single-digit-ms access | Access-pattern-first modeling, no ad-hoc joins |

## Submission artifacts this diagram backs
- **Architecture diagram** at submission (this file, refined to the locked concept).
- **Storage Configuration screenshot** from the v0/Vercel project proving the AWS Database connection.
- **Vercel Project Link + Team ID.**

_(Diagram and component detail to be refined once track, database, and concept are locked.)_
