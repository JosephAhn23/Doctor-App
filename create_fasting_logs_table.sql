-- Create fasting_logs table
CREATE TABLE IF NOT EXISTS public.fasting_logs (
  id BIGSERIAL PRIMARY KEY,
  date DATE NOT NULL,
  seconds INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_fasting_logs_date
ON public.fasting_logs(date);

CREATE INDEX IF NOT EXISTS idx_fasting_logs_created_at
ON public.fasting_logs(created_at DESC);

-- Enable RLS
ALTER TABLE public.fasting_logs ENABLE ROW LEVEL SECURITY;

-- Allow all (temporary, dev only)
-- Drop policy if it exists, then create it
DROP POLICY IF EXISTS "allow all" ON public.fasting_logs;

CREATE POLICY "allow all"
ON public.fasting_logs
FOR ALL
USING (true)
WITH CHECK (true);

