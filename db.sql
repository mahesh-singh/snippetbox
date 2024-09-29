-- Create a `snippets` table
CREATE TABLE snippets (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    created TIMESTAMP NOT NULL,
    expires TIMESTAMP NOT NULL
);

-- Add an index on the created column
CREATE INDEX idx_snippets_created ON snippets(created);




-- Add some dummy records
INSERT INTO snippets (title, content, created, expires) VALUES 
('An old silent pond', 'An old silent pond...\nA frog jumps into the pond,\nsplash! Silence again.\n\n– Matsuo Bashō', 
 CURRENT_TIMESTAMP AT TIME ZONE 'UTC', 
 (CURRENT_TIMESTAMP AT TIME ZONE 'UTC') + INTERVAL '365 days'
);

INSERT INTO snippets (title, content, created, expires) VALUES 
('Over the wintry forest', 'Over the wintry\nforest, winds howl in rage\nwith no leaves to blow.\n\n– Natsume Soseki', 
 CURRENT_TIMESTAMP AT TIME ZONE 'UTC', 
 (CURRENT_TIMESTAMP AT TIME ZONE 'UTC') + INTERVAL '365 days'
);

INSERT INTO snippets (title, content, created, expires) VALUES 
('First autumn morning', 'First autumn morning\nthe mirror I stare into\nshows my father''s face.\n\n– Murakami Kijo', 
 CURRENT_TIMESTAMP AT TIME ZONE 'UTC', 
 (CURRENT_TIMESTAMP AT TIME ZONE 'UTC') + INTERVAL '7 days'
);



-- Create a new user
CREATE USER web WITH PASSWORD 'pass';

-- Grant privileges on the snippetbox database
-- Assuming the database name is 'snippetbox'
GRANT CONNECT ON DATABASE snippetbox TO web;

-- Connect to the snippetbox database before running the following commands


-- Grant privileges on all tables in the public schema
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO web;

-- Grant privileges on future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO web;

-- Grant PRIVILEGES on SEQUENCES
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public to web;


----- Create User table 

-- Create the database (if it doesn't exist)
-- Note: In PostgreSQL, you typically create a database from the command line or pgAdmin
-- CREATE DATABASE snippetbox;

-- Connect to the database
-- \c snippetbox

-- Create the users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    hashed_password CHAR(60) NOT NULL,
    created TIMESTAMP NOT NULL
);

-- Add a unique constraint on the email column
ALTER TABLE users ADD CONSTRAINT users_uc_email UNIQUE (email)

-- Grant usage on the sequence
GRANT USAGE, SELECT ON SEQUENCE users_id_seq TO web;

-- Grant insert permission on the users table
GRANT INSERT ON users TO web;

-- If you also need to select from the users table:
GRANT SELECT ON users TO web;


