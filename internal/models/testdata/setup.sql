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




-- Create the users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    hashed_password CHAR(60) NOT NULL,
    created TIMESTAMP NOT NULL
);

-- Add a unique constraint on the email column
ALTER TABLE users ADD CONSTRAINT users_uc_email UNIQUE (email);



INSERT INTO users (name, email, hashed_password, created) 
VALUES ('Alice Jones',
        'alice@example.com', 
        '$2a$12$NuTjWXm3KKntReFwyBVHyuf/to.HEwTy.eS206TNfkGfr6HzGJSWG', 
        '2022-01-01 09:18:24'::timestamp);