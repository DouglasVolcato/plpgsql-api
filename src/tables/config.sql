CREATE TABLE IF NOT EXISTS config(
    id SERIAL PRIMARY KEY,
    secret TEXT
);

-- INSERT INTO config (secret) VALUES ('$2a$06$eWCqMzy6yenpiUemDwW4nO');