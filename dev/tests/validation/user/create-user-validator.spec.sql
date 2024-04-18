CREATE OR REPLACE FUNCTION create_user_validator_spec() RETURNS BOOLEAN AS $$
DECLARE
    result BOOLEAN;
BEGIN
    SELECT create_user_validator('{"name":"Douglas","email":"douglasvolcato@gmail.com","password":"1234567","age":23}') INTO result;
        IF result IS FALSE THEN
            RAISE EXCEPTION 'create_user_validator should return true if user is valid';
        END IF;

    SELECT create_user_validator('{"email":"douglasvolcato@gmail.com","password":"1234567","age":23}') INTO result;
        IF result IS TRUE THEN
            RAISE EXCEPTION 'create_user_validator should return false if name is missing';
        END IF;

    SELECT create_user_validator('{"name":"Douglas","password":"1234567","age":23}') INTO result;
        IF result IS TRUE THEN
            RAISE EXCEPTION 'create_user_validator should return false if email is missing';
        END IF;

    SELECT create_user_validator('{"name":"Douglas","email":"douglasvolcato@gmail.com","age":23}') INTO result;
        IF result IS TRUE THEN
            RAISE EXCEPTION 'create_user_validator should return false if password is missing';
        END IF;

    SELECT create_user_validator('{"name":"Douglas","email":"douglasvolcato@gmail.com","password":"1234567"}') INTO result;
        IF result IS TRUE THEN
            RAISE EXCEPTION 'create_user_validator should return false if age is missing';
        END IF;

    SELECT create_user_validator('{"name":"Douglas","email":"douglasvolcato","password":"1234567","age":23}') INTO result;
        IF result IS TRUE THEN
            RAISE EXCEPTION 'create_user_validator should return false if email is not valid';
        END IF;

    SELECT create_user_validator('{"name":"Douglas","email":"douglasvolcato@gmail.com","password":"1234567","age":"age"}') INTO result;
        IF result IS TRUE THEN
            RAISE EXCEPTION 'create_user_validator should return false if age is not a number';
        END IF;

    SELECT create_user_validator('{"name":"Douglas","email":"douglasvolcato@gmail.com","password":"12345","age":24}') INTO result;
        IF result IS TRUE THEN
            RAISE EXCEPTION 'create_user_validator should return false if password is not al least 6 characters long';
        END IF;

    return result;
END;
$$ LANGUAGE plpgsql;

select create_user_validator_spec();