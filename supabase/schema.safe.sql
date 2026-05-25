DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'quote_requests_postal_code_chk'
  ) THEN
    ALTER TABLE public.quote_requests
      ADD CONSTRAINT quote_requests_postal_code_chk
      CHECK (
        from_zip ~* '^[A-Z][0-9][A-Z][ -]?[0-9][A-Z][0-9]$'
        AND to_zip ~* '^[A-Z][0-9][A-Z][ -]?[0-9][A-Z][0-9]$'
      );
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'quote_requests_move_date_required_chk'
  ) THEN
    ALTER TABLE public.quote_requests
      ADD CONSTRAINT quote_requests_move_date_required_chk
      CHECK (
        (no_date = TRUE AND move_date IS NULL)
        OR (no_date = FALSE AND move_date IS NOT NULL)
      );
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'quote_requests_weekend_window_chk'
  ) THEN
    ALTER TABLE public.quote_requests
      ADD CONSTRAINT quote_requests_weekend_window_chk
      CHECK (
        move_date IS NULL OR (
          EXTRACT(ISODOW FROM move_date) IN (6, 7)
          AND move_date >= CURRENT_DATE + 14
        )
      );
  END IF;
END $$;
