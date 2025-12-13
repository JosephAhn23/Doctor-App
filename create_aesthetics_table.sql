-- Create aesthetics_logs table
CREATE TABLE IF NOT EXISTS public.aesthetics_logs (
  id BIGSERIAL PRIMARY KEY,
  date DATE NOT NULL,
  bench_press NUMERIC(6,2) DEFAULT 0,
  rows NUMERIC(6,2) DEFAULT 0,
  overhead_press NUMERIC(6,2) DEFAULT 0,
  score NUMERIC(8,2) DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_aesthetics_logs_date
ON public.aesthetics_logs(date);

CREATE INDEX IF NOT EXISTS idx_aesthetics_logs_created_at
ON public.aesthetics_logs(created_at DESC);

-- Enable RLS
ALTER TABLE public.aesthetics_logs ENABLE ROW LEVEL SECURITY;

-- Allow all (temporary, dev only)
-- Drop policy if it exists, then create it
DROP POLICY IF EXISTS "allow all" ON public.aesthetics_logs;

CREATE POLICY "allow all"
ON public.aesthetics_logs
FOR ALL
USING (true)
WITH CHECK (true);

