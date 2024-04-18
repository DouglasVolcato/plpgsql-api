CREATE OR REPLACE FUNCTION min_length_validator(data jsonb, property_name text, required_length integer)
RETURNS boolean AS $$
DECLARE
  value TEXT;
BEGIN
  value = data -> property_name;
  RETURN (length(value::TEXT) - 2) >= required_length;
END;
$$ LANGUAGE plpgsql;
