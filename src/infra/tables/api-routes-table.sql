CREATE TABLE IF NOT EXISTS api_routes(
    id SERIAL PRIMARY KEY,
    path TEXT,
    type TEXT,
    function TEXT
);

-- INSERT INTO
--     api_routes (path, type, function)
-- VALUES
--     ('/user/create', 'post', 'fc_create_user_route'),
--     ('/user/update', 'patch', 'fc_update_user_route'),
--     ('/user/delete', 'delete', 'fc_delete_user_route'),
--     ('/user/get', 'get', 'fc_get_user_route');