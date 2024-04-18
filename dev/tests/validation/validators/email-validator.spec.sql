CREATE OR REPLACE FUNCTION email_validator_spec() RETURNS BOOLEAN AS $$
DECLARE
    result BOOLEAN;
BEGIN
    SELECT email_validator('{"valid_email": "douglasvolcato@gmail.com"}'::JSONB, 'valid_email') INTO result;
        IF result IS FALSE THEN
            RAISE EXCEPTION 'email_validator should return true if email is valid';
        END IF;

    SELECT email_validator('{"invalid_email": "douglasvolcatogmail.com"}'::JSONB, 'invalid_email') INTO result;
        IF result IS TRUE THEN
            RAISE EXCEPTION 'email_validator should return false if @ is missing';
        END IF;

    SELECT email_validator('{"invalid_email": "douglas@volcatogmailcom"}'::JSONB, 'invalid_email') INTO result;
        IF result IS TRUE THEN
            RAISE EXCEPTION 'email_validator should return false if . is missing';
        END IF;

    SELECT email_validator('{"valid_email": "douglasvolcato@email.com.br"}'::JSONB, 'valid_email') INTO result;
        IF result IS FALSE THEN
            RAISE EXCEPTION 'email_validator should allow email to have country dominium at the end';
        END IF;

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

SELECT email_validator_spec();
