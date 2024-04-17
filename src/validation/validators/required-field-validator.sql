CREATE OR REPLACE FUNCTION required_field_validator(data jsonb, property_name text)
RETURNS boolean AS $$
BEGIN
  RETURN data -> property_name IS NOT NULL;
END;
$$ LANGUAGE plpgsql;
