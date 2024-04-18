CREATE OR REPLACE FUNCTION create_user_validator(data jsonb)
RETURNS BOOLEAN
AS $$
BEGIN
    if (select required_field_validator(data,'name')) IS FALSE THEN
        RETURN FALSE;
    END IF;
    if (select required_field_validator(data,'email')) IS FALSE THEN
        RETURN FALSE;
    END IF;
    if (select required_field_validator(data,'password')) IS FALSE THEN
        RETURN FALSE;
    END IF;
    if (select required_field_validator(data,'age')) IS FALSE THEN
        RETURN FALSE;
    END IF;
    if (select field_type_validator(data,'age','number')) IS FALSE THEN
        RETURN FALSE;
    END IF;
    if (select email_validator(data,'email')) IS FALSE THEN
        RETURN FALSE;
    END IF;
    if (select min_length_validator(data,'password',6)) IS FALSE THEN
        RETURN FALSE;
    END IF;
    return TRUE;
END;
$$ LANGUAGE plpgsql