-- Create all tables for Life OS
-- Run this in Supabase SQL Editor

-- ================= DOCTOR LOGS (Consistency App) =================
CREATE TABLE IF NOT EXISTS public.doctor_logs (
  id BIGSERIAL PRIMARY KEY,
  date DATE NOT NULL,
  hours NUMERIC(6,2) DEFAULT 0,
  calories INTEGER DEFAULT 0,
  protein NUMERIC(6,2) DEFAULT 0,
  score NUMERIC(6,3) DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_doctor_logs_date ON public.doctor_logs(date);
CREATE INDEX IF NOT EXISTS idx_doctor_logs_created_at ON public.doctor_logs(created_at DESC);

ALTER TABLE public.doctor_logs ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "allow all" ON public.doctor_logs;
CREATE POLICY "allow all" ON public.doctor_logs FOR ALL USING (true) WITH CHECK (true);

-- ================= FASTING LOGS (SaaS Timer) =================
CREATE TABLE IF NOT EXISTS public.fasting_logs (
  id BIGSERIAL PRIMARY KEY,
  date DATE NOT NULL,
  seconds INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_fasting_logs_date ON public.fasting_logs(date);
CREATE INDEX IF NOT EXISTS idx_fasting_logs_created_at ON public.fasting_logs(created_at DESC);

ALTER TABLE public.fasting_logs ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "allow all" ON public.fasting_logs;
CREATE POLICY "allow all" ON public.fasting_logs FOR ALL USING (true) WITH CHECK (true);

-- ================= INCOME LOGS (Income Projection) =================
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

CREATE INDEX IF NOT EXISTS idx_income_logs_date ON public.income_logs(date);
CREATE INDEX IF NOT EXISTS idx_income_logs_created_at ON public.income_logs(created_at DESC);

ALTER TABLE public.income_logs ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "allow all" ON public.income_logs;
CREATE POLICY "allow all" ON public.income_logs FOR ALL USING (true) WITH CHECK (true);

