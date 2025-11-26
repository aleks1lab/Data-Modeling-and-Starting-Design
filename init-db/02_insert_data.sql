INSERT INTO users (full_name, email, password, role) VALUES
('Jim Johnson', 'jjohnson2@umbc.edu', 'password123', 'STUDENT'),
('Bob Jones', 'bjones.com', 'password456', 'STUDENT'),
('Charlie Davis', 'cdavis@yahoo.com', 'password789', 'DRIVER'),
('Diana Clark', 'dclark8@umbc.edu', 'admin123', 'ADMIN'),
('Ethan Brown', 'ebrown3@umbc.edu', 'password999', 'STUDENT'),
('Frank Wilson', 'fwilson6@umbc.edu', 'driverpass', 'DRIVER'),
('Grace Lee', 'glee1@umbc.edu', 'adminpass1', 'ADMIN'),
('Hannah Kim', 'hkim4@umbc.edu', 'studentpw8', 'STUDENT');



INSERT INTO bus_stops (stop_name, location_description, latitude, longitude) VALUES
('Walker Apartments', 'entrance to Walker Avenue Apartments', 39.258718, -76.714887),
('Library', 'road behind library', 39.256561, -76.711511),
('Patapsco Hall', 'Intersection next to Patapsco Hall', 39.255121, -76.707364),
('Performing Arts & Humanities', 'Top of the hill of UMBC', 39.251373,-76.712127),
('Retriever Activities Center', 'Next to admin building',  39.252405, -76.712003);


INSERT INTO buses (bus_id, bus_number, capacity, active) VALUES
(1, 'BUS-101', 40, TRUE),
(2, 'BUS-102', 23, TRUE),
(3, 'BUS-103', 52, FALSE),
(4, 'BUS-104', 40, TRUE),
(5, 'BUS-105', 52, TRUE),
(6, 'BUS-106', 23, TRUE),
(7, 'BUS-107', 52, TRUE),
(8, 'BUS-108', 40, FALSE),
(9, 'BUS-109', 23, TRUE),
(10, 'BUS-110', 52, TRUE);

INSERT INTO trips (trip_id, bus_id, route_name, start_time, end_time, is_emergency)
VALUES
  (1, 1, 'North Loop',      '2025-09-01 08:00:00', '2025-09-01 08:40:00', 0),
  (2, 1, 'North Loop',      '2025-09-01 09:00:00', '2025-09-01 09:40:00', 0),
  (3, 2, 'South Loop',      '2025-09-01 08:15:00', '2025-09-01 08:55:00', 0),
  (4, 3, 'Downtown Exp',    '2025-09-01 17:00:00', '2025-09-01 17:45:00', 0),
  (5, 4, 'Stadium Shuttle', '2025-09-01 19:00:00', '2025-09-01 19:30:00', 1);

-- 5. TRIP_STOP_TIMES (5 rows)
INSERT INTO trip_stop_times (trip_stop_id, trip_id, stop_id, stop_sequence, scheduled_arrival, estimated_arrival, message_sent) VALUES 
(1, 1, 4, 2, '2025-11-09 10:30:00', '2025-11-09 10:45:00', 1),
(2, 3, 3, 2, '2025-11-09 04:00:00', '2025-11-09 04:15:00', 0),
(3, 4, 2, 5, '2025-11-09 02:15:00', '2025-11-09 02:20:00', 1),
(4, 2, 3, 3, '2025-11-09 08:30:00', '2025-11-09 08:15:00', 0),
(5, 5, 1, 4, '2025-11-09 12:50:00', '2025-11-09 13:00:00', 1);

-- 6. ALERTS (5 rows)
INSERT INTO alerts (alert_id, user_id, trip_stop_id, alert_type, message_text) VALUES 
(1,1,1, 'ARRIVAL', 'Bus is Arriving At Performing Arts and Humanities'),
(2,2,2, 'DELAY', 'Bus Arriving At La Plata Dorms 15 Minutes Late'),
(3,3,2, 'DELAY', 'Bus Arriving At Commons 5 Minutes Late'),
(4,4,1, 'ARRIVAL', 'Bus is Arriving At Science Building'),
(5,5,1, 'ARRIVAL', 'Bus is Arriving At Arena');

INSERT INTO feedback (feedback_id, user_id, message_text, handled) VALUES
(1, 4, 'The 9 OClock Bus is ugly', 0),
(2, 2, 'Can the bus come 10 minutes early', 0),
(3, 3, 'This bus is always late', 1),
(4, 2, 'Can you make a new stop at humfries?', 1),
(5, 5, 'this system sucks and an app would be better', 0);

INSERT INTO bus_capacity_log (capacity_log_id, bus_id, log_time, seats_available, passengers_on_board) VALUES
(1, 2, '2025-11-09 10:30:00', 15, 5),
(2, 1, '2025-11-09 04:00:00', 20, 3),
(3, 4, '2025-11-09 02:15:00', 20, 10),
(4, 5, '2025-11-09 12:50:00', 10, 18),
(5, 3, '2025-11-09 2:15:00', 15, 17);
