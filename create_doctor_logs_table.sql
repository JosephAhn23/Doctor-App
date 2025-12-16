-- Create doctor_logs table (BF% App)
CREATE TABLE IF NOT EXISTS public.doctor_logs (
  id BIGSERIAL PRIMARY KEY,
  date DATE NOT NULL,
  hours NUMERIC(6,2) DEFAULT 0,
  calories INTEGER DEFAULT 0,
  protein NUMERIC(6,2) DEFAULT 0,
  gym BOOLEAN DEFAULT false,
  cal_track BOOLEAN DEFAULT false,
  protein_only BOOLEAN DEFAULT false,
  home_dumbbell BOOLEAN DEFAULT false,
  score NUMERIC(6,3) DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_doctor_logs_date
ON public.doctor_logs(date);

CREATE INDEX IF NOT EXISTS idx_doctor_logs_created_at
ON public.doctor_logs(created_at DESC);

-- Enable RLS
ALTER TABLE public.doctor_logs ENABLE ROW LEVEL SECURITY;

-- Allow all (temporary, dev only)
-- Drop policy if it exists, then create it
DROP POLICY IF EXISTS "allow all" ON public.doctor_logs;

CREATE POLICY "allow all"
ON public.doctor_logs
FOR ALL
USING (true)
WITH CHECK (true);

