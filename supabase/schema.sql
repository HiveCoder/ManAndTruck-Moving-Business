-- ============================================================
--  ManAndTruck Movers — Supabase Schema
--  Run this in the Supabase SQL editor (Project > SQL Editor)
-- ============================================================

-- Quote Requests -------------------------------------------------
CREATE TABLE IF NOT EXISTS public.quote_requests (
  id           UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at   TIMESTAMPTZ DEFAULT NOW(),
  from_zip     TEXT        NOT NULL,
  to_zip       TEXT        NOT NULL,
  move_date    DATE,
  no_date      BOOLEAN     DEFAULT FALSE,
  include_packing BOOLEAN  DEFAULT FALSE,
  name         TEXT        NOT NULL,
  phone        TEXT        NOT NULL,
  email        TEXT        NOT NULL,
  status       TEXT        DEFAULT 'new'
               CHECK (status IN ('new','contacted','quoted','booked','cancelled'))
);

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

ALTER TABLE public.quote_requests ENABLE ROW LEVEL SECURITY;
CREATE POLICY "anon_insert_quote_requests"
  ON public.quote_requests FOR INSERT TO anon WITH CHECK (true);

-- Contact Messages -----------------------------------------------
CREATE TABLE IF NOT EXISTS public.contact_messages (
  id         UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  name       TEXT        NOT NULL,
  email      TEXT        NOT NULL,
  phone      TEXT,
  subject    TEXT,
  message    TEXT        NOT NULL,
  status     TEXT        DEFAULT 'unread'
             CHECK (status IN ('unread','read','replied'))
);

ALTER TABLE public.contact_messages ENABLE ROW LEVEL SECURITY;
CREATE POLICY "anon_insert_contact_messages"
  ON public.contact_messages FOR INSERT TO anon WITH CHECK (true);

-- Services -------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.services (
  id                UUID    DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at        TIMESTAMPTZ DEFAULT NOW(),
  name              TEXT    NOT NULL,
  slug              TEXT    UNIQUE NOT NULL,
  short_description TEXT,
  description       TEXT,
  icon_key          TEXT,
  badge             TEXT,
  featured          BOOLEAN DEFAULT FALSE,
  display_order     INTEGER DEFAULT 0
);

ALTER TABLE public.services ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public_read_services"
  ON public.services FOR SELECT TO anon USING (true);

-- Blog Posts -----------------------------------------------------
CREATE TABLE IF NOT EXISTS public.blog_posts (
  id           UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at   TIMESTAMPTZ DEFAULT NOW(),
  updated_at   TIMESTAMPTZ DEFAULT NOW(),
  title        TEXT        NOT NULL,
  slug         TEXT        UNIQUE NOT NULL,
  excerpt      TEXT,
  content      TEXT,
  category     TEXT,
  published    BOOLEAN     DEFAULT FALSE,
  published_at TIMESTAMPTZ
);

ALTER TABLE public.blog_posts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public_read_published_posts"
  ON public.blog_posts FOR SELECT TO anon USING (published = TRUE);

-- Reviews --------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.reviews (
  id          UUID    DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  author_name TEXT    NOT NULL,
  location    TEXT,
  rating      INTEGER DEFAULT 5 CHECK (rating BETWEEN 1 AND 5),
  review_text TEXT    NOT NULL,
  source      TEXT    DEFAULT 'website',
  featured    BOOLEAN DEFAULT FALSE,
  approved    BOOLEAN DEFAULT FALSE
);

ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public_read_approved_reviews"
  ON public.reviews FOR SELECT TO anon USING (approved = TRUE);

-- Locations ------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.locations (
  id            UUID    DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  name          TEXT    NOT NULL,
  slug          TEXT    UNIQUE NOT NULL,
  description   TEXT,
  address       TEXT,
  phone         TEXT,
  active        BOOLEAN DEFAULT TRUE,
  display_order INTEGER DEFAULT 0
);

ALTER TABLE public.locations ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public_read_active_locations"
  ON public.locations FOR SELECT TO anon USING (active = TRUE);
