CREATE TABLE api_routes(
    id SERIAL PRIMARY KEY,
    route TEXT,
    type TEXT,
    function TEXT
);

INSERT INTO
    api_routes (route, type, function)
VALUES
    ('/user/create', 'POST', 'create_user_route'),
    ('/user/update', 'PATCH', 'update_user_route'),
    ('/user/delete', 'DELETE', 'delete_user_route'),
    ('/user/get', 'GET', 'get_user_route');