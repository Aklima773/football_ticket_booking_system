---1. CREATE USERS TABLE

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role VARCHAR(30) NOT NULL
        CHECK (role IN ('Ticket Manager', 'Football Fan')),
    phone_number VARCHAR(20)
);

---2. CREATE MATCHES TABLE

CREATE TABLE matches (
    match_id INT PRIMARY KEY,
    fixture VARCHAR(150) NOT NULL,
    tournament_category VARCHAR(100) NOT NULL,
    base_ticket_price NUMERIC(10, 2) NOT NULL
        CONSTRAINT positive_ticket_price CHECK (base_ticket_price >= 0),
    match_status VARCHAR(30) NOT NULL
        CONSTRAINT valid_match_status CHECK (
            match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed')
        )
);

---3. CREATE BOOKINGS TABLE
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    user_id INT NOT NULL
        REFERENCES users (user_id),
    match_id INT NOT NULL
        REFERENCES matches (match_id),
    seat_number VARCHAR(20),
    payment_status VARCHAR(20)
        CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost NUMERIC(10, 2) NOT NULL
);


-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS

INSERT INTO users (user_id, full_name, email, role, phone_number)
VALUES
    (1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
    (2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
    (3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
    (4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);


-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES

INSERT INTO matches (match_id, fixture, tournament_category, base_ticket_price, match_status)
VALUES
    (101, 'Real Madrid vs Barcelona', 'Champions League', 150, 'Available'),
    (102, 'Man City vs Liverpool', 'Premier League', 120, 'Selling Fast'),
    (103, 'Bayern Munich vs PSG', 'Champions League', 130, 'Available'),
    (104, 'AC Milan vs Inter Milan', 'Serie A', 90, 'Sold Out'),
    (105, 'Juventus vs Roma', 'Serie A', 80, 'Available');   


-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
INSERT INTO bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost)
VALUES
    (501, 1, 101, 'A-12', 'Confirmed', 150),
    (502, 1, 102, 'B-04', 'Confirmed', 120),
    (503, 2, 101, 'A-13', 'Confirmed', 150),
    (504, 2, 101, NULL, NULL, 150),
    (505, 3, 102, 'C-20', 'Pending', 120); 

    
---Q:1  Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.

SELECT match_id, fixture, base_ticket_price
FROM matches
WHERE tournament_category ='Champions League'
AND match_status = 'Available';

---Q:2 Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive)

SELECT user_id,full_name,email
FROM users
WHERE full_name LIKE 'Tanvir%'
OR full_name ILIKE '%Haque%';