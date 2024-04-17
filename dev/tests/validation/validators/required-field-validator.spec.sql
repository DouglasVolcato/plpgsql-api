CREATE OR REPLACE FUNCTION required_field_validator_spec() RETURNS BOOLEAN AS $$
DECLARE
    result BOOLEAN;
BEGIN
    SELECT required_field_validator('{"valid_property": "value"}'::JSONB, 'valid_property') INTO result;
        IF result IS FALSE THEN
            RAISE EXCEPTION 'required_field_validator should return true if property exists';
        END IF;

    SELECT required_field_validator('{"invalid_property": "value"}'::JSONB, 'valid_property') INTO result;
        IF result IS TRUE THEN
            RAISE EXCEPTION 'required_field_validator should return false if property does not exist';
        END IF;
        
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

SELECT required_field_validator_spec();
