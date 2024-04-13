CREATE TABLE IF NOT EXISTS system_user(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    age INT NOT NULL
);

-- INSERT INTO
--     system_user (name, age)
-- VALUES
--     ('Douglas', 23);