-- Create saas_timer_logs table
CREATE TABLE IF NOT EXISTS public.saas_timer_logs (
  id BIGSERIAL PRIMARY KEY,
  date DATE NOT NULL,
  seconds INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_saas_timer_logs_date
ON public.saas_timer_logs(date);

CREATE INDEX IF NOT EXISTS idx_saas_timer_logs_created_at
ON public.saas_timer_logs(created_at DESC);

-- Enable RLS
ALTER TABLE public.saas_timer_logs ENABLE ROW LEVEL SECURITY;

-- Allow all (temporary, dev only)
DROP POLICY IF EXISTS "allow all" ON public.saas_timer_logs;

CREATE POLICY "allow all"
ON public.saas_timer_logs
FOR ALL
USING (true)
WITH CHECK (true);

