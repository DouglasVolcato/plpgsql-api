CREATE OR REPLACE FUNCTION min_length_validator_spec()
RETURNS boolean
AS $$
DECLARE
    result BOOLEAN;
BEGIN
    SELECT min_length_validator('{"invalid_length_property": "123"}'::JSONB, 'invalid_length_property', 5) INTO result;
        IF result IS TRUE THEN
            RAISE EXCEPTION 'min_length_validator should return false if property length is lesser than the defined length';
        END IF;

    SELECT min_length_validator('{"valid_length_property": "12345"}'::JSONB, 'valid_length_property', 5) INTO result;
        IF result IS FALSE THEN
            RAISE EXCEPTION 'min_length_validator should return true if property length is equal to the defined length';
        END IF;

    SELECT min_length_validator('{"valid_length_property": "123456"}'::JSONB, 'valid_length_property', 5) INTO result;
        IF result IS FALSE THEN
            RAISE EXCEPTION 'min_length_validator should return true if property length greater than the defined length';
        END IF;

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

SELECT min_length_validator_spec();