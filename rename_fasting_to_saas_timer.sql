-- Rename fasting_logs to saas_timer_logs
-- Run this if you already have a fasting_logs table with data

ALTER TABLE public.fasting_logs
RENAME TO saas_timer_logs;

-- Rename indexes
ALTER INDEX IF EXISTS idx_fasting_logs_date
RENAME TO idx_saas_timer_logs_date;

ALTER INDEX IF EXISTS idx_fasting_logs_created_at
RENAME TO idx_saas_timer_logs_created_at;

-- Update policy (drop old, create new)
DROP POLICY IF EXISTS "allow all" ON public.saas_timer_logs;

CREATE POLICY "allow all"
ON public.saas_timer_logs
FOR ALL
USING (true)
WITH CHECK (true);

