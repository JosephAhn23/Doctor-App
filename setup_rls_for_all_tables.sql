-- ============================================================================
-- Setup RLS (Row Level Security) for all tables - Model 1 (Recommended)
-- Users authenticate (or anonymous) and RLS separates their data
-- Run this in Supabase SQL Editor after creating tables
-- ============================================================================

-- ============================================================================
-- 1. Add user_id column to existing tables (if not exists)
-- ============================================================================

-- Doctor Logs (BF% App)
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                 WHERE table_schema = 'public' 
                 AND table_name = 'doctor_logs' 
                 AND column_name = 'user_id') THEN
    ALTER TABLE public.doctor_logs 
    ADD COLUMN user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;
  END IF;
END $$;

-- SaaS Timer Logs (Life OS Timer)
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                 WHERE table_schema = 'public' 
                 AND table_name = 'saas_timer_logs' 
                 AND column_name = 'user_id') THEN
    ALTER TABLE public.saas_timer_logs 
    ADD COLUMN user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;
  END IF;
END $$;

-- Stress Logs
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                 WHERE table_schema = 'public' 
                 AND table_name = 'stress_logs' 
                 AND column_name = 'user_id') THEN
    ALTER TABLE public.stress_logs 
    ADD COLUMN user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;
  END IF;
END $$;

-- ============================================================================
-- 2. Create indexes on user_id columns
-- ============================================================================

CREATE INDEX IF NOT EXISTS idx_doctor_logs_user_id ON public.doctor_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_saas_timer_logs_user_id ON public.saas_timer_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_stress_logs_user_id ON public.stress_logs(user_id);

-- ============================================================================
-- 3. Drop old "allow all" policies
-- ============================================================================

DROP POLICY IF EXISTS "allow all" ON public.doctor_logs;
DROP POLICY IF EXISTS "allow all" ON public.saas_timer_logs;
DROP POLICY IF EXISTS "allow all" ON public.stress_logs;

-- ============================================================================
-- 4. Enable RLS on all tables
-- ============================================================================

ALTER TABLE public.doctor_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.saas_timer_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.stress_logs ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- 5. Create RLS Policies for Doctor Logs (BF% App)
-- ============================================================================

DROP POLICY IF EXISTS "Users can view own doctor logs" ON public.doctor_logs;
DROP POLICY IF EXISTS "Users can insert own doctor logs" ON public.doctor_logs;
DROP POLICY IF EXISTS "Users can update own doctor logs" ON public.doctor_logs;
DROP POLICY IF EXISTS "Users can delete own doctor logs" ON public.doctor_logs;

CREATE POLICY "Users can view own doctor logs"
ON public.doctor_logs FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own doctor logs"
ON public.doctor_logs FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own doctor logs"
ON public.doctor_logs FOR UPDATE
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own doctor logs"
ON public.doctor_logs FOR DELETE
USING (auth.uid() = user_id);

-- ============================================================================
-- 6. Create RLS Policies for SaaS Timer Logs (Life OS Timer)
-- ============================================================================

DROP POLICY IF EXISTS "Users can view own saas timer logs" ON public.saas_timer_logs;
DROP POLICY IF EXISTS "Users can insert own saas timer logs" ON public.saas_timer_logs;
DROP POLICY IF EXISTS "Users can update own saas timer logs" ON public.saas_timer_logs;
DROP POLICY IF EXISTS "Users can delete own saas timer logs" ON public.saas_timer_logs;

CREATE POLICY "Users can view own saas timer logs"
ON public.saas_timer_logs FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own saas timer logs"
ON public.saas_timer_logs FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own saas timer logs"
ON public.saas_timer_logs FOR UPDATE
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own saas timer logs"
ON public.saas_timer_logs FOR DELETE
USING (auth.uid() = user_id);

-- ============================================================================
-- 7. Create RLS Policies for Stress Logs
-- ============================================================================

DROP POLICY IF EXISTS "Users can view own stress logs" ON public.stress_logs;
DROP POLICY IF EXISTS "Users can insert own stress logs" ON public.stress_logs;
DROP POLICY IF EXISTS "Users can update own stress logs" ON public.stress_logs;
DROP POLICY IF EXISTS "Users can delete own stress logs" ON public.stress_logs;

CREATE POLICY "Users can view own stress logs"
ON public.stress_logs FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own stress logs"
ON public.stress_logs FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own stress logs"
ON public.stress_logs FOR UPDATE
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own stress logs"
ON public.stress_logs FOR DELETE
USING (auth.uid() = user_id);

-- ============================================================================
-- ✅ DONE! RLS is now configured for Model 1
-- Users can only access their own data via auth.uid()
-- ============================================================================

