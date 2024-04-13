CREATE TABLE IF NOT EXISTS api_routes(
    id SERIAL PRIMARY KEY,
    path TEXT,
    type TEXT,
    function TEXT
);

-- INSERT INTO
--     api_routes (path, type, function)
-- VALUES
--     ('/user/create', 'post', 'create_user_route'),
--     ('/user/update', 'patch', 'update_user_route'),
--     ('/user/delete', 'delete', 'delete_user_route'),
--     ('/user/get', 'get', 'get_user_route');