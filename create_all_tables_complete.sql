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
DROP POLICY IF EXISTS "allow all" ON public.doctor_logs;

CREATE POLICY "allow all"
ON public.doctor_logs
FOR ALL
USING (true)
WITH CHECK (true);

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

-- Create income_logs table (Income Projection)
CREATE TABLE IF NOT EXISTS public.income_logs (
  id BIGSERIAL PRIMARY KEY,
  date DATE NOT NULL,
  saas NUMERIC(6,2) DEFAULT 0,
  projects NUMERIC(6,2) DEFAULT 0,
  cgpa NUMERIC(4,2) DEFAULT 0,
  bf NUMERIC(4,1) DEFAULT 0,
  score NUMERIC(8,2) DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_income_logs_date
ON public.income_logs(date);

CREATE INDEX IF NOT EXISTS idx_income_logs_created_at
ON public.income_logs(created_at DESC);

-- Enable RLS
ALTER TABLE public.income_logs ENABLE ROW LEVEL SECURITY;

-- Allow all (temporary, dev only)
DROP POLICY IF EXISTS "allow all" ON public.income_logs;

CREATE POLICY "allow all"
ON public.income_logs
FOR ALL
USING (true)
WITH CHECK (true);

