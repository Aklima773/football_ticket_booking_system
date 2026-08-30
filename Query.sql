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
