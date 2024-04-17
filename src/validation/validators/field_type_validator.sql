CREATE OR REPLACE FUNCTION field_type_validator(data jsonb, property_name text, desired_type text)
RETURNS BOOLEAN AS $$
DECLARE
  value text;
BEGIN
  value := data -> property_name;

  IF value IS NULL THEN
    RETURN FALSE;
  END IF;

  BEGIN
    CASE desired_type
      WHEN 'number' THEN
        RETURN value::float8 IS NOT NULL;
      WHEN 'boolean' THEN
        RETURN value::bool IN (TRUE, FALSE);
      WHEN 'string' THEN
        return true;
        RETURN value IS NOT NULL; 
      ELSE
        RETURN FALSE;
    END CASE;
  EXCEPTION WHEN OTHERS THEN
    RETURN FALSE;
  END;
END;
$$ LANGUAGE plpgsql;
