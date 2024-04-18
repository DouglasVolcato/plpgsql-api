CREATE OR REPLACE FUNCTION email_validator(data jsonb, property_name text)
RETURNS BOOLEAN AS $$
DECLARE
  email text;
  email_regex text := '([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z0-9_\-\.]+)';
BEGIN
  email := data -> property_name;
  IF email ~ email_regex THEN
    RETURN TRUE;
  END IF;
  RETURN FALSE;
END;
$$ LANGUAGE plpgsql;