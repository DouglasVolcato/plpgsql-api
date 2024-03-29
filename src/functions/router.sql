CREATE OR REPLACE FUNCTION router() 
RETURNS SETOF api_routes 
AS $$ 

BEGIN 

RETURN QUERY SELECT
    id,
    path,
    type,
    function
FROM
    api_routes;

END;

$$ LANGUAGE plpgsql;