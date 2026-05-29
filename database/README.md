# Robot Fleet Control-Plane Database Blueprints

Welcome, **Misbah Hassan**! 🚀

To give you a massive head start on the **H0: Hack the Zero Stack** hackathon, we have bootstrapped complete database schemas for both potential directions. Depending on whether you choose SQL (Relational) or NoSQL (Distributed), you have ready-made blueprints:

---

## 🗺️ Option 1: Relational SQL (`database/schema.sql`)
*   **Target AWS Database:** Amazon Aurora PostgreSQL (Serverless or Provisioned)
*   **Best for:** Core operational data, robot inventory, human-in-the-loop task assignments, and relational joins across multiple tables.
*   **What we built:**
    *   `robots` table to track live states, location, and battery level.
    *   `inspection_tasks` table to track high-level missions and telemetry.
    *   `inspection_findings` table containing the critical **Human-In-The-Loop (HITL) Gate** fields (`approval_state`, `reviewed_by`, `reviewer_notes`).
    *   `audit_logs` table for immutable auditing and compliance logging.
    *   Sample seed data ready to load.

---

## ⚡ Option 2: NoSQL Key-Value (`database/dynamodb_models.json`)
*   **Target AWS Database:** Amazon DynamoDB
*   **Best for:** High-frequency, high-velocity robot telemetry streams (GPS, speed, temperature) requiring sub-10ms response times.
*   **What we built:**
    *   A consolidated, single-table design schema.
    *   Standardized `PartitionKey` (PK) and `SortKey` (SK) design patterns.
    *   Sample payloads for standard telemetry pings and anomaly records.
    *   Pre-calculated Query Patterns for Next.js route handlers.

---

## 🎯 Next Steps:
1.  **Select your Track & Database** inside `docs/HACKATHON_REQUIREMENTS.md`.
2.  If SQL: Spin up an **Aurora PostgreSQL** database in AWS Console, run the code inside [database/schema.sql](./schema.sql) in your query editor, and hook up your Next.js project.
3.  If NoSQL: Create an **Amazon DynamoDB** table with PK and SK configuration and refer to [database/dynamodb_models.json](./dynamodb_models.json) for your object structures.

*Happy Coding! Let's hack the Zero Stack!* 🍯🐝
