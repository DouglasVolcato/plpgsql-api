CREATE OR REPLACE FUNCTION field_type_validator_spec() RETURNS BOOLEAN AS $$
DECLARE
    result BOOLEAN;
BEGIN
    SELECT field_type_validator('{"valid_number_property": 123}'::JSONB, 'valid_number_property', 'number') INTO result;
        IF result IS FALSE THEN
            RAISE EXCEPTION 'field_type_validator_spec should validate number if it is valid';
        END IF;

    SELECT field_type_validator('{"invalid_number_property": "text"}'::JSONB, 'invalid_number_property', 'number') INTO result;
        IF result IS TRUE THEN
            RAISE EXCEPTION 'field_type_validator_spec should validate number if it is invalid';
        END IF;

    SELECT field_type_validator('{"valid_boolean_property": true}'::JSONB, 'valid_boolean_property', 'boolean') INTO result;
        IF result IS FALSE THEN
            RAISE EXCEPTION 'field_type_validator_spec should validate boolean if it is valid';
        END IF;

    SELECT field_type_validator('{"invalid_boolean_property": "text"}'::JSONB, 'invalid_boolean_property', 'boolean') INTO result;
        IF result IS TRUE THEN
            RAISE EXCEPTION 'field_type_validator_spec should validate boolean if it is invalid';
        END IF;

    SELECT field_type_validator('{"valid_string_property": "text1"}'::JSONB, 'valid_string_property', 'string') INTO result;
        IF result IS FALSE THEN
            RAISE EXCEPTION 'field_type_validator_spec should validate string if it is valid';
        END IF;

    SELECT field_type_validator('{"invalid_string_property": []}'::JSONB, 'invalid_string_property', 'string') INTO result;
        IF result IS FALSE THEN
            RAISE EXCEPTION 'field_type_validator_spec should validate string if it is invalid';
        END IF;

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

SELECT field_type_validator_spec();
