create database eventmanagement
use eventmanagement

-- Create table for storing event categories 
CREATE TABLE event_categories (category_id INT PRIMARY KEY AUTO_INCREMENT,category_name VARCHAR(100) NOT NULL);

-- Insert event categories
INSERT INTO event_categories (category_name) VALUES('Technology'),
('Music'),
('Education'),
('Business')

-- Create table for storing event details
CREATE TABLE events (event_id INT PRIMARY KEY AUTO_INCREMENT,event_name VARCHAR(255) NOT NULL,event_date DATETIME NOT NULL,event_location VARCHAR(255),event_description TEXT,category_id INT,FOREIGN KEY (category_id) REFERENCES event_categories(category_id))

-- Insert values in events
INSERT INTO events (event_name, event_date, event_location, event_description, category_id)
VALUES('Tech Conference 2025', '2025-06-15 09:00:00', 'Conference Center, NY', 'A tech conference to discuss the latest in technology.', 1),
('Music Festival', '2025-07-10 12:00:00', 'Outdoor Arena, LA', 'A festival with performances from top artists.', 2),
('AI Summit 2025', '2025-09-20 09:00:00', 'Convention Center, SF', 'A summit on the future of AI and machine learning.', 1),
('Business Leaders Conference', '2025-08-15 10:00:00', 'Grand Hall, Chicago', 'A conference for business leaders and entrepreneurs.', 4)

-- Create table for storing sponsors of events
CREATE TABLE event_sponsors (sponsor_id INT PRIMARY KEY AUTO_INCREMENT,sponsor_name VARCHAR(255) NOT NULL,sponsor_logo_url VARCHAR(255))

-- Insert values for event_sponsors
INSERT INTO event_sponsors (sponsor_name, sponsor_logo_url)
VALUES('TechCorp', 'https://techcorp.com/logo.png'),
('MusicPro', 'https://musicpro.com/logo.png'),
('EduSolutions', 'https://edusolutions.com/logo.png'),
('AI Innovators', 'https://aiinnovators.com/logo.png'),
('BigCorp', 'https://bigcorp.com/logo.png')

-- Create table to link sponsors to events
CREATE TABLE event_sponsor_link (event_id INT,sponsor_id INT,PRIMARY KEY (event_id, sponsor_id),FOREIGN KEY (event_id) REFERENCES events(event_id),FOREIGN KEY (sponsor_id) REFERENCES event_sponsors(sponsor_id))

-- Insert values to event_sponsor_link
INSERT INTO event_sponsor_link (event_id, sponsor_id)
VALUES(1, 1), 
(2, 2), 
(1, 4), 
(2, 5), 
(3, 4), 
(4, 3) 

-- Create table for storing participant details
CREATE TABLE participants (participant_id INT PRIMARY KEY AUTO_INCREMENT,first_name VARCHAR(100) NOT NULL,last_name VARCHAR(100) NOT NULL,email VARCHAR(100) UNIQUE NOT NULL,phone VARCHAR(15),registration_date DATETIME DEFAULT CURRENT_TIMESTAMP)

-- Insert into participants
INSERT INTO participants (first_name, last_name, email, phone)
VALUES('John', 'Doe', 'john.doe@email.com', '123-456-7890'),
('Jane', 'Smith', 'jane.smith@email.com', '987-654-3210'),
('Samuel', 'Johnson', 'samuel.johnson@email.com', '555-1234-5678'),
('Emily', 'Davis', 'emily.davis@email.com', '555-8765-4321')

-- Create table for storing event tickets 
CREATE TABLE event_tickets (ticket_id INT PRIMARY KEY AUTO_INCREMENT,event_id INT,ticket_type VARCHAR(50) NOT NULL,price DECIMAL(10, 2) NOT NULL,total_quantity INT NOT NULL,available_quantity INT NOT NULL,FOREIGN KEY (event_id) REFERENCES events(event_id))

-- Insert values for event tickets for events
INSERT INTO event_tickets (event_id, ticket_type, price, total_quantity, available_quantity)
VALUES(1, 'General', 100.00, 500, 500), 
(1, 'VIP', 250.00, 100, 100), 
(2, 'General', 50.00, 1000, 1000), 
(2, 'VIP', 150.00, 200, 200), 
(3, 'General', 120.00, 600, 600), 
(3, 'VIP', 300.00, 150, 150), 
(4, 'General', 80.00, 800, 800),
(4, 'VIP', 200.00, 150, 150)

-- Create table for storing event feedback 
CREATE TABLE event_feedback (feedback_id INT PRIMARY KEY AUTO_INCREMENT,event_id INT,participant_id INT,feedback_text TEXT,rating INT CHECK (rating BETWEEN 1 AND 5),feedback_date DATETIME DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY (event_id) REFERENCES events(event_id),FOREIGN KEY (participant_id) REFERENCES participants(participant_id))

-- Insert values for feedback
INSERT INTO event_feedback (event_id, participant_id, feedback_text, rating)
VALUES(1, 1, 'Great experience, very insightful speakers!', 5), 
(2, 2, 'Amazing performances, would love to attend again!', 4), 
(3, 3, 'The AI Summit was fantastic, very informative!', 5), 
(4, 4, 'Excellent conference for business leaders, very inspiring.', 4)

-- Create table for storing registrations (participants registering for events)
CREATE TABLE registrations (registration_id INT PRIMARY KEY AUTO_INCREMENT,participant_id INT,event_id INT,registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY (participant_id) REFERENCES participants(participant_id),FOREIGN KEY (event_id) REFERENCES events(event_id))

-- Insert values for registrations for events
INSERT INTO registrations (participant_id, event_id)
VALUES(1, 1), 
(2, 2), 
(3, 3), 
(4, 4)

-- Create table for storing event speakers 
CREATE TABLE speakers (speaker_id INT PRIMARY KEY AUTO_INCREMENT,event_id INT,speaker_name VARCHAR(255) NOT NULL,speaker_bio TEXT,FOREIGN KEY (event_id) REFERENCES events(event_id))

-- Insert values for speakers for events
INSERT INTO speakers (event_id, speaker_name, speaker_bio)
VALUES(1, 'Elon Musk', 'CEO of SpaceX and Tesla, visionary in technology and space exploration.'),
(2, 'Beyoncé', 'One of the world’s most influential musicians and performers.'),
(3, 'Dr. Andrew Ng', 'Co-founder of Google Brain, expert in machine learning and AI.'),
(4, 'Warren Buffet', 'Legendary investor and philanthropist, business magnate.')

-- Query 1: View all events with ticket prices and available quantities
SELECT e.event_name, t.ticket_type, t.price, t.available_quantity FROM events e JOIN event_tickets t ON e.event_id = t.event_id

-- Query 2: View all participants who registered for events
SELECT p.first_name, p.last_name, e.event_name, r.registration_date FROM registrations r JOIN participants p ON r.participant_id = p.participant_id JOIN events e ON r.event_id = e.event_id

-- Query 3: View all event feedback and ratings
SELECT p.first_name, p.last_name, e.event_name, f.rating, f.feedback_text FROM event_feedback f JOIN participants p ON f.participant_id = p.participant_id JOIN events e ON f.event_id = e.event_id

-- Query 4: View all events and their associated sponsors
SELECT e.event_name, s.sponsor_name FROM events e JOIN event_sponsor_link esl ON e.event_id = esl.event_id JOIN event_sponsors s ON esl.sponsor_id = s.sponsor_id 

-- Query 5: List all events in a specific category (e.g., Technology)
SELECT e.event_name, e.event_date, e.event_location FROM events e JOIN event_categories c ON e.category_id = c.category_id WHERE c.category_name = 'Technology'

-- Query 6: Get the total number of tickets sold for an event (subtracting available from total quantity)
SELECT e.event_name, t.ticket_type,(t.total_quantity - t.available_quantity) AS tickets_sold FROM event_tickets t JOIN events e ON t.event_id = e.event_id

-- Query 7: Get the total revenue generated by ticket sales for each event
SELECT e.event_name, SUM(t.price * (t.total_quantity - t.available_quantity)) AS total_revenue FROM event_tickets t JOIN events e ON t.event_id = e.event_id GROUP BY e.event_name

-- Query 8: View the details of all VIP ticket holders for a specific event
SELECT p.first_name, p.last_name, p.email, t.ticket_type FROM registrations r JOIN participants p ON r.participant_id = p.participant_id JOIN event_tickets t ON r.event_id = t.event_id WHERE t.ticket_type = 'VIP' AND r.event_id = 1

-- Query 9: View all participants who attended a specific event (i.e., registered for the event)
SELECT p.first_name, p.last_name, p.email FROM registrations r JOIN participants p ON r.participant_id = p.participant_id WHERE r.event_id = 1 

-- Query 10: Get the number of participants per event
SELECT e.event_name, COUNT(r.participant_id) AS number_of_participants FROM events e LEFT JOIN registrations r ON e.event_id = r.event_id GROUP BY e.event_name

-- Query 11: List all events that have more than one speaker
SELECT e.event_name, COUNT(s.speaker_id) AS number_of_speakers FROM events e JOIN speakers s ON e.event_id = s.event_id GROUP BY e.event_name HAVING COUNT(s.speaker_id) > 1 

-- Query 12: Find the average rating for each event
SELECT e.event_name, AVG(f.rating) AS average_rating FROM events e JOIN event_feedback f ON e.event_id = f.event_id GROUP BY e.event_name

-- Query 13: Find all sponsors for a specific event (e.g., Tech Conference 2025)
SELECT e.event_name, s.sponsor_name FROM events e JOIN event_sponsor_link esl ON e.event_id = esl.event_id JOIN event_sponsors s ON esl.sponsor_id = s.sponsor_id WHERE e.event_id = 1

-- Query 14: List all participants who gave a rating of 5 for an event
SELECT p.first_name, p.last_name, e.event_name, f.rating FROM event_feedback f JOIN participants p ON f.participant_id = p.participant_id JOIN events e ON f.event_id = e.event_id WHERE f.rating = 5

-- Query 15: Find events with no feedback
SELECT e.event_name FROM events e LEFT JOIN event_feedback f ON e.event_id = f.event_id WHERE f.feedback_id IS NULL

-- Query 16: Show events with tickets that are sold out (where available quantity = 0)
SELECT e.event_name, t.ticket_type FROM event_tickets t JOIN events e ON t.event_id = e.event_id WHERE t.available_quantity = 0

-- Query 17: List all events with speakers and their bios
SELECT e.event_name, s.speaker_name, s.speaker_bio FROM events e JOIN speakers s ON e.event_id = s.event_id

-- Query 18: Find participants who are registered for both "Tech Conference 2025" and "AI Summit 2025"
SELECT p.first_name, p.last_name, p.email FROM registrations r1 JOIN registrations r2 ON r1.participant_id = r2.participant_id JOIN participants p ON r1.participant_id = p.participant_id WHERE r1.event_id = 1 AND r2.event_id = 3

-- Query 19: Get the number of tickets sold for each ticket type across all events
SELECT t.ticket_type, SUM(t.total_quantity - t.available_quantity) AS tickets_sold FROM event_tickets t GROUP BY t.ticket_type

-- Query 20: Find the top 3 most popular events based on the number of participants
SELECT e.event_name, COUNT(r.participant_id) AS number_of_participants FROM events e JOIN registrations r ON e.event_id = r.event_id GROUP BY e.event_name ORDER BY number_of_participants DESC LIMIT 3 
