-- Drop tables in correct order if they already exist (for re-runs)
DROP TABLE IF EXISTS alerts;
DROP TABLE IF EXISTS feedback;
DROP TABLE IF EXISTS bus_capacity_log;
DROP TABLE IF EXISTS trip_stop_times;
DROP TABLE IF EXISTS trips;
DROP TABLE IF EXISTS bus_stops;
DROP TABLE IF EXISTS buses;
DROP TABLE IF EXISTS users;

-- Users: students, bus drivers, maybe admins
CREATE TABLE users (
    user_id     SERIAL PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(100) UNIQUE NOT NULL,
    password    VARCHAR(100), -- placeholder for credentials
    role        VARCHAR(20) NOT NULL CHECK (role IN ('STUDENT', 'DRIVER', 'ADMIN')),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bus stops displayed in the app
CREATE TABLE bus_stops (
    stop_id               SERIAL PRIMARY KEY,
    stop_name             VARCHAR(100) NOT NULL,
    location_description  VARCHAR(255),
    latitude              NUMERIC(9, 6),
    longitude             NUMERIC(9, 6)
);

-- Buses that drivers operate
CREATE TABLE buses (
    bus_id      SERIAL PRIMARY KEY,
    bus_number  VARCHAR(20) NOT NULL,
    capacity    INT NOT NULL CHECK (capacity >= 0),
    active      BOOLEAN DEFAULT TRUE
);

-- A trip = one bus running a route at a certain time
-- Used for calculating arrival times and GPS route
CREATE TABLE trips (
    trip_id      SERIAL PRIMARY KEY,
    bus_id       INT NOT NULL REFERENCES buses(bus_id),
    route_name   VARCHAR(100) NOT NULL,
    start_time   TIMESTAMP NOT NULL,
    end_time     TIMESTAMP,
    is_emergency BOOLEAN DEFAULT FALSE  -- set when app recognizes an emergency
);

-- Arrival times for each stop on a trip
-- Supports "accessing arrival times", "calculates arrival
-- time for given bus stop", and the optimized path logic.
CREATE TABLE trip_stop_times (
    trip_stop_id       SERIAL PRIMARY KEY,
    trip_id            INT NOT NULL REFERENCES trips(trip_id) ON DELETE CASCADE,
    stop_id            INT NOT NULL REFERENCES bus_stops(stop_id),
    stop_sequence      INT NOT NULL, -- order along the route
    scheduled_arrival  TIMESTAMP,
    estimated_arrival  TIMESTAMP,
    message_sent       BOOLEAN DEFAULT FALSE
);

-- Alerts sent to students (arrival alerts, emergency alerts, etc.)
CREATE TABLE alerts (
    alert_id       SERIAL PRIMARY KEY,
    user_id        INT REFERENCES users(user_id),
    trip_stop_id   INT REFERENCES trip_stop_times(trip_stop_id),
    alert_type     VARCHAR(30) NOT NULL, -- e.g. 'ARRIVAL', 'EMERGENCY', 'DELAY'
    message_text   TEXT NOT NULL,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at        TIMESTAMP
);

-- Student feedback for developers
CREATE TABLE feedback (
    feedback_id   SERIAL PRIMARY KEY,
    user_id       INT REFERENCES users(user_id),
    message_text  TEXT NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    handled       BOOLEAN DEFAULT FALSE
);

-- Bus capacity updates from driver:
-- "updates the app to display bus capacity", 
-- "counts how many people boarded the bus"
CREATE TABLE bus_capacity_log (
    capacity_log_id      SERIAL PRIMARY KEY,
    bus_id               INT NOT NULL REFERENCES buses(bus_id),
    log_time             TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    seats_available      INT CHECK (seats_available >= 0),
    passengers_on_board  INT CHECK (passengers_on_board >= 0)
);
