CREATE TABLE customer (
    customerId INTEGER PRIMARY KEY,
    firstName TEXT,
    lastName TEXT,
    email TEXT NOT NULL
);

INSERT INTO customer VALUES
    (121, 'Katy', 'Smith', 'Katy.Smith@email.com'),
    (122, 'John', 'Wilson', 'events.corp@email.com'),
    (123, 'Mary', 'White', 'Mary.W@email.com');

CREATE TABLE service (
    serviceId INTEGER PRIMARY KEY,
    serviceName TEXT NOT NULL,
    serviceType TEXT NOT NULL,
    defaultRate REAL
);

INSERT INTO service VALUES
    (1, 'Room Over Night', 'Internal', 400.00),
    (2, 'Bar Charge', 'Internal', 0.00),
    (3, 'Restaurant Charge', 'Internal', 0.00);

CREATE TABLE hotel_complex (
    hotelComplexId INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT NOT NULL
);

INSERT INTO hotel_complex VALUES
    (1, 'Hotel Star', '100 Park Avenue, New York, NY'),
    (2, 'Hotel Dream', '200 Park Avenue, New York, NY'),
    (3, 'Hotel Delight', '300 Park Avenue, New York, NY');

CREATE TABLE building (
    buildingId INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    hotelComplexId INTEGER,
    FOREIGN KEY (hotelComplexId) REFERENCES hotel_complex(hotelComplexId)
);

INSERT INTO building VALUES
    (1, 'Earth', 1),
    (2, 'Venuse', 1),
    (3, 'Mercury', 2);

CREATE TABLE wing (
    wingId INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    buildingId INTEGER,
    proximityFeatures TEXT NOT NULL,
    handicappedAccess TEXT NOT NULL,
    smokingPolicy TEXT NOT NULL,
    FOREIGN KEY (buildingId) REFERENCES building(buildingId)
);

INSERT INTO wing VALUES
    (1, 'Wind', 1, 'Close to indoor swimming pool', 'True', 'Smoking is prohibited'),
    (2, 'Rain', 1, 'Close to parking garage', 'True', 'Smoking is prohibited'),
    (3, 'Sun', 1, 'Close to outdoor swimming pool and parking garage', 'False', 'Smoking is permitted only in specialized areas');

CREATE TABLE room (
    roomId INTEGER PRIMARY KEY,
    wingId INTEGER,
    number INTEGER,
    floor INTEGER,
    type TEXT NOT NULL,
    maxOccupancy INTEGER,
    baseRate REAL,
    smokingPolicy TEXT NOT NULL,
    hasToilet TEXT NOT NULL,
    status TEXT NOT NULL,
    FOREIGN KEY (wingId) REFERENCES wing(wingId)
);

INSERT INTO room VALUES
    (1, 1, 11, 1, 'Sleeping', 4, 100.00, 'Not Permitted', 'True', 'Available'),
    (2, 2, 21, 2, 'Sleeping', 4, 120.00, 'Not Permitted', 'True', 'Under Renovation'),
    (3, 3, 31, 3, 'Suite', 6, 250.00, 'Not Permitted', 'True', 'Available');

CREATE TABLE feature (
    featureId INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    value TEXT NOT NULL
);

INSERT INTO feature VALUES
    (1, 'Bed Type', 'King Size'),
    (2, 'Bed Type', 'Queen Size'),
    (3, 'Rollaway Beds', '1 Rollaway Beds');

CREATE TABLE reservation (
    reservationId INTEGER PRIMARY KEY,
    customerId INTEGER,
    reservationDate TEXT NOT NULL,
    depositRequired TEXT NOT NULL,
    sepeciallRequest TEXT NOT NULL,
    status TEXT NOT NULL,
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
);

INSERT INTO reservation VALUES
    (101, 121, '2025-12-03', 'False', 'Forrest view', 'Confirmed'),
    (102, 122, '2025-11-12', 'True', 'Meeting Rooms', 'Checked-In'),
    (103, 123, '2025-05-04', 'False', 'Ocean view', 'Confirmed');

CREATE TABLE stay (
    stayId INTEGER PRIMARY KEY,
    reservationId INTEGER,
    customerId INTEGER,
    checkInTime TEXT NOT NULL,
    checkOutTime TEXT NOT NULL,
    numberOfGuest INTEGER,
    FOREIGN KEY (reservationId) REFERENCES reservation(reservationId)
);

INSERT INTO stay VALUES
    (202, 101, 1, '2026-02-28', '13:20', 1),
    (203, 102, 2, '2026-02-28', '12:11', 5),
    (204, 103, 3, '2026-02-28', '15:22', 1);

CREATE TABLE billing_arrangement (
    billingId INTEGER,
    stayId INTEGER,
    billedPartyId INTEGER,
    billingType TEXT NOT NULL,
    splitPercent REAL,
    PRIMARY KEY (billingId, billedPartyId),
    FOREIGN KEY (stayId) REFERENCES stay(stayId),
    FOREIGN KEY (billedPartyId) REFERENCES customer(customerId)
);

INSERT INTO billing_arrangement VALUES
    (100, 202, 121, 'Room', 100.00),
    (101, 203, 122, 'Incedentals', 50.00),
    (102, 204, 123, 'Room', 50.00);

CREATE TABLE employee (
    employeeId INTEGER PRIMARY KEY,
    deptId INTEGER,
    firstName TEXT NOT NULL,
    lastName TEXT NOT NULL,
    position TEXT NOT NULL,
    shift TEXT NOT NULL
);

INSERT INTO employee VALUES
    (326, 10, 'James', 'Brown', 'Front Desk Manager', 'day'),
    (327, 11, 'Lisa', 'Jay', 'Event coordinator', 'day'),
    (328, 12, 'Michael', 'Garcia', 'Housekeeper', 'day');

CREATE TABLE message (
    messageId INTEGER PRIMARY KEY,
    senderName TEXT NOT NULL,
    senderCustomerId INTEGER,
    messageContext TEXT NOT NULL,
    timeRecorded TEXT NOT NULL,
    status TEXT NOT NULL,
    confidential TEXT NOT NULL,
    FOREIGN KEY (senderCustomerId) REFERENCES customer(customerId)
);

INSERT INTO message VALUES
    (400, 'Katy Smith', 121, 'Late Check Out', '2026-02-28', 'Read', 'False'),
    (401, 'John Wilson', 122, 'Event Arrangement', '2026-02-28', 'Read', 'False'),
    (402, 'Front Desk', NULL, 'Package Delivery', '2026-02-28', 'Delivered', 'False');

CREATE TABLE customer_location (
    locationId INTEGER PRIMARY KEY,
    customerId INTEGER,
    facility TEXT NOT NULL,
    checkInTime TEXT NOT NULL,
    checkOutTime TEXT NOT NULL
);

INSERT INTO customer_location VALUES
    (1, 122, 'Gym', '12:30', '4:30'),
    (2, 123, 'Outdoor Pool', '15:30', '17:30'),
    (3, 124, 'Indoor Pool', '19:20', '19:40');

CREATE TABLE service_transaction (
    transactionId INTEGER PRIMARY KEY,
    billingId INTEGER,
    serviceId INTEGER,
    date TEXT NOT NULL,
    time TEXT NOT NULL,
    finalAmount REAL,
    authorizationStatus TEXT NOT NULL,
    FOREIGN KEY (serviceId) REFERENCES service(serviceId)
);

INSERT INTO service_transaction VALUES
    (201, 100, 1, '2026-02-28', '15:00', 200.00, 'Posted'),
    (202, 100, 2, '2026-02-28', '20:00', 24.5, 'Posted'),
    (203, 101, 1, '2026-02-28', '15:00', 200.00, 'Posted');

CREATE TABLE access_log (
    accessLogId INTEGER PRIMARY KEY,
    roomId INTEGER,
    customerId INTEGER,
    accessTime TEXT NOT NULL,
    direction TEXT NOT NULL,
    FOREIGN KEY (roomId) REFERENCES room(roomId)
);

INSERT INTO access_log VALUES
    (1, 1, 122, '11:30', 'Enter'),
    (2, 2, 123, '12:30', 'Enter'),
    (3, 3, 124, '13:30', 'Exit');

CREATE TABLE room_assignment (
    stayId INTEGER,
    roomId INTEGER,
    date TEXT NOT NULL,
    PRIMARY KEY (stayId, roomId),
    FOREIGN KEY (stayId) REFERENCES stay(stayId),
    FOREIGN KEY (roomId) REFERENCES room(roomId)
);

INSERT INTO room_assignment VALUES
    (202, 1, '2026-02-27'),
    (203, 2, '2026-02-28'),
    (204, 3, '2026-03-01');

CREATE TABLE event (
    eventId INTEGER PRIMARY KEY,
    roomId INTEGER,
    customerId INTEGER,
    billingId INTEGER,
    duration TEXT NOT NULL,
    estimatedAttendance INTEGER,
    eventName TEXT NOT NULL,
    FOREIGN KEY (roomId) REFERENCES room(roomId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
);

INSERT INTO event VALUES
    (100, 1, 121, 100, '2 hours', 100, 'art forum'),
    (101, 2, 122, 101, '4 hours', 60, 'math forum'),
    (102, 3, 123, 102, '3 hours', 90, 'lunch');

CREATE TABLE event_room_assignment (
    eventId INTEGER,
    roomId INTEGER,
    duration TEXT NOT NULL,
    usage TEXT NOT NULL,
    charge REAL,
    PRIMARY KEY (eventId, roomId),
    FOREIGN KEY (eventId) REFERENCES event(eventId),
    FOREIGN KEY (roomId) REFERENCES room(roomId)
);

INSERT INTO event_room_assignment VALUES
    (100, 1, '2 hours', 'meeting', 100.00),
    (101, 2, '4 hours', 'meeting', 120.00),
    (102, 3, '3 hours', 'lunch', 300.00);

CREATE TABLE room_feature_assignment (
    roomId INTEGER,
    featureId INTEGER,
    quantity INTEGER,
    PRIMARY KEY (roomId, featureId),
    FOREIGN KEY (roomId) REFERENCES room(roomId),
    FOREIGN KEY (featureId) REFERENCES feature(featureId)
);

INSERT INTO room_feature_assignment VALUES
    (1, 1, 2),
    (2, 3, 1),
    (3, 3, 2);

CREATE TABLE room_adjacency (
    roomId1 INTEGER,
    roomId2 INTEGER,
    adjacencyType TEXT NOT NULL,
    PRIMARY KEY (roomId1, roomId2)
);

INSERT INTO room_adjacency VALUES
    (1, 2, 'moveable wall'),
    (3, 4, 'door'),
    (5, 6, 'separate'),
    (1, 7, 'private access door'),
    (2, 5, 'moveable wall');




