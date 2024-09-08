# snippetbox


Notes
https://bagerbach.com/books/lets-go/


https://grafana.com/blog/2024/02/09/how-i-write-http-services-in-go-after-13-years/


# SQL statement 

```
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

```




# Daily logs

Date: 05/Sep/2024 - Committed Chapter #1 & 2
Date: 06/Sep/2024 - Finished till page 83 of Chapter#3 (section logging)
Date: 07/Sep/2024 - Finished Chapter 3 (till page 95)
Date: 07/Sep/2024 - Finished till page 116 of Chapter #4
Date: 08/Sep/2024 - Finished till page 132 of Chapter #4
Next: Managing null values   - page 133