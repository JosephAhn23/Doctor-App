-- Quick fix: Add user_id columns to all existing tables
-- Run this in Supabase SQL Editor

-- Add user_id to doctor_logs
ALTER TABLE public.doctor_logs 
ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;

-- Add user_id to saas_timer_logs
ALTER TABLE public.saas_timer_logs 
ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;

-- Add user_id to stress_logs (if table exists)
ALTER TABLE public.stress_logs 
ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_doctor_logs_user_id ON public.doctor_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_saas_timer_logs_user_id ON public.saas_timer_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_stress_logs_user_id ON public.stress_logs(user_id);

-- Note: After running this, you should run setup_rls_for_all_tables.sql
-- to set up the RLS policies properly

