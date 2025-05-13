-- Creating the database
CREATE DATABASE  wedding_system;
USE wedding_system;

-- creating tables
CREATE TABLE admin (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL
);

CREATE TABLE clients (
  client_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  phone VARCHAR(15) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE venues (
  venue_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  cost INT NOT NULL,
  image VARCHAR(255)
);

CREATE TABLE catering (
  catering_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  cost INT NOT NULL,
  image VARCHAR(255)
);

CREATE TABLE weddings (
  wedding_id INT AUTO_INCREMENT PRIMARY KEY,
  client_id INT NOT NULL,
  wedding_date DATE NOT NULL,
  number_of_guests INT NOT NULL,
  venue_id INT NOT NULL,
  catering_id INT NOT NULL,
  FOREIGN KEY (client_id) REFERENCES clients(client_id),
  FOREIGN KEY (venue_id) REFERENCES venues(venue_id),
  FOREIGN KEY (catering_id) REFERENCES catering(catering_id)
);

CREATE TABLE payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  wedding_id INT NOT NULL,
  amount_paid INT NOT NULL,
  payment_date DATE NOT NULL,
  FOREIGN KEY (wedding_id) REFERENCES weddings(wedding_id)
);
  
  CREATE TABLE vendors (
    vendor_id INT AUTO_INCREMENT PRIMARY KEY,
    vendor_name VARCHAR(255),
    vendor_type VARCHAR(50), -- e.g., Photographer, Florist, DJ, etc.
    contact_info VARCHAR(100),
    status ENUM('active', 'inactive') DEFAULT 'active'
);

CREATE TABLE tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    task_description TEXT,
    due_date DATE,
    status ENUM('not started', 'in progress', 'completed') DEFAULT 'not started',
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE
);

CREATE TABLE guests (
    guest_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    guest_name VARCHAR(255),
    relationship_to_client VARCHAR(50), -- e.g., Friend, Family
    RSVP_status ENUM('pending', 'attending', 'not attending') DEFAULT 'pending',
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE
);

CREATE TABLE wedding_event_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    wedding_id INT,
    event_type VARCHAR(50), -- Ceremony, Reception, etc.
    status ENUM('not started', 'in progress', 'completed') DEFAULT 'not started',
    FOREIGN KEY (wedding_id) REFERENCES weddings(wedding_id) ON DELETE CASCADE
);

CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    vendor_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    feedback_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id)
);

CREATE TABLE invoices (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    wedding_id INT,
    amount DECIMAL(10, 2),
    due_date DATE,
    paid_date DATE,
    status ENUM('pending', 'paid', 'overdue') DEFAULT 'pending',
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (wedding_id) REFERENCES weddings(wedding_id)
);



  -- inserting data 
  -- Add admin
INSERT INTO admin (email, password) VALUES ('admin@example.com', 'securepass');

-- Add sample venue
INSERT INTO venues (name, cost, image) VALUES ('Beach Resort', 100000, 'beach.jpg');

-- Add sample catering
INSERT INTO catering (name, cost, image) VALUES ('Gourmet Foods', 50000, 'gourmet.jpg');

-- Add a client
INSERT INTO clients (full_name, phone, email) VALUES ('Alice Mwangi', '0712345678', 'alice@example.com');

-- Book a wedding
INSERT INTO weddings (client_id, wedding_date, number_of_guests, venue_id, catering_id)
VALUES (1, '2025-12-20', 150, 1, 1);

-- viewing the bookings 
SELECT 
  w.wedding_id,
  c.full_name,
  v.name AS venue,
  ca.name AS catering,
  w.wedding_date,
  w.number_of_guests
FROM weddings w
JOIN clients c ON w.client_id = c.client_id
JOIN venues v ON w.venue_id = v.venue_id
JOIN catering ca ON w.catering_id = ca.catering_id;

-- adding status tracking 
ALTER TABLE weddings
ADD COLUMN status ENUM('pending', 'confirmed', 'cancelled') DEFAULT 'pending';

-- updating  status 
-- Confirm a wedding
UPDATE weddings SET status = 'confirmed' WHERE wedding_id = 1;

-- Cancel a wedding
UPDATE weddings SET status = 'cancelled' WHERE wedding_id = 1;

-- View Wedding Status
SELECT 
  w.wedding_id,
  c.full_name,
  v.name AS venue,
  ca.name AS catering,
  w.wedding_date,
  w.number_of_guests,
  w.status
FROM weddings w
JOIN clients c ON w.client_id = c.client_id
JOIN venues v ON w.venue_id = v.venue_id
JOIN catering ca ON w.catering_id = ca.catering_id;





