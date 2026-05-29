-- PostgreSQL Relational SQL Schema for Aurora PostgreSQL
-- H0: Hack the Zero Stack — Robot Fleet Control-Plane
-- Author: Forenly PM Automation Setup

-- 1. Create Status Enum Types
CREATE TYPE robot_status AS ENUM ('ONLINE', 'OFFLINE', 'CHARGING', 'MAINTENANCE', 'EMERGENCY_STOP');
CREATE TYPE task_status AS ENUM ('PENDING', 'IN_PROGRESS', 'COMPLETED', 'FAILED', 'CANCELLED');
CREATE TYPE finding_severity AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL');
CREATE TYPE approval_status AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- 2. Robots Table (Tracks robot fleet state)
CREATE TABLE robots (
    robot_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    status robot_status DEFAULT 'OFFLINE',
    battery_level INT CHECK (battery_level >= 0 AND battery_level <= 100),
    latitude NUMERIC(9, 6),
    longitude NUMERIC(9, 6),
    current_area VARCHAR(100),
    last_ping TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Inspection Tasks Table (Tracks high-level missions)
CREATE TABLE inspection_tasks (
    task_id VARCHAR(50) PRIMARY KEY,
    robot_id VARCHAR(50) REFERENCES robots(robot_id) ON DELETE CASCADE,
    title VARCHAR(150) NOT NULL,
    status task_status DEFAULT 'PENDING',
    started_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    operator_notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. Inspection Findings Table (Tracks detected anomalies requiring HITL approvals)
CREATE TABLE inspection_findings (
    finding_id VARCHAR(50) PRIMARY KEY,
    task_id VARCHAR(50) REFERENCES inspection_tasks(task_id) ON DELETE CASCADE,
    robot_id VARCHAR(50) REFERENCES robots(robot_id) ON DELETE CASCADE,
    category VARCHAR(100) NOT NULL, -- e.g., 'STRUCTURAL_DEFECT', 'WIRING_FAULT'
    severity finding_severity DEFAULT 'LOW',
    description TEXT,
    evidence_url VARCHAR(500), -- S3 Bucket URI for photos/videos
    confidence NUMERIC(3, 2) CHECK (confidence >= 0.0 AND confidence <= 1.0),
    
    -- Human-In-The-Loop (HITL) Gate fields
    approval_state approval_status DEFAULT 'PENDING',
    reviewed_by VARCHAR(100), -- Operator Name
    reviewed_at TIMESTAMP WITH TIME ZONE,
    reviewer_notes TEXT,
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. Audit Logs Table (Immutable log for compliance auditing)
CREATE TABLE audit_logs (
    log_id SERIAL PRIMARY KEY,
    event_type VARCHAR(100) NOT NULL, -- e.g., 'ROBOT_DISPATCH', 'HITL_APPROVAL_GRANTED'
    robot_id VARCHAR(50) REFERENCES robots(robot_id) ON DELETE SET NULL,
    actor_id VARCHAR(100) NOT NULL, -- Username or Bot ID
    description TEXT NOT NULL,
    metadata JSONB, -- Dynamic event details
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 6. Insert Sample Seed Data for Fleet Verification
INSERT INTO robots (robot_id, name, model, status, battery_level, latitude, longitude, current_area) VALUES
('BOT-S1-001', 'Sentinel Patrol X1', 'Ground Rover v2', 'ONLINE', 85, 39.7392, -104.9903, 'Aisles A1-A4'),
('BOT-S1-002', 'Sentinel Patrol X2', 'Ground Rover v2', 'CHARGING', 15, 39.7391, -104.9910, 'Charging Bay 1'),
('BOT-S1-003', 'Scout Drone D5', 'Disaster Drone Quad', 'MAINTENANCE', 100, 39.7395, -104.9890, 'Hangar B');

INSERT INTO inspection_tasks (task_id, robot_id, title, status, started_at) VALUES
('TSK-2026-0001', 'BOT-S1-001', 'Structural & Wiring Audit Aisle A3', 'IN_PROGRESS', CURRENT_TIMESTAMP - INTERVAL '15 minutes');

INSERT INTO inspection_findings (finding_id, task_id, robot_id, category, severity, description, evidence_url, confidence, approval_state) VALUES
('FND-2026-0001', 'TSK-2026-0001', 'BOT-S1-001', 'WIRING_FAULT', 'HIGH', 'Misrouted power bus cable touching chassis edge.', 's3://forenly-telemetry/findings/fnd-0001.jpg', 0.94, 'PENDING');

INSERT INTO audit_logs (event_type, robot_id, actor_id, description, metadata) VALUES
('ROBOT_STATUS_CHANGED', 'BOT-S1-001', 'system', 'Robot Sentinel Patrol X1 status changed from OFFLINE to ONLINE', '{"battery": 85}'),
('TASK_DISPATCHED', 'BOT-S1-001', 'operator_bahadir', 'Dispatched inspection task TSK-2026-0001', '{"area": "Aisle A3"}');
