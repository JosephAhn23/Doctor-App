-- Create stress_logs table ($ Stress: Rec Basketball + Treadmill Running)
CREATE TABLE IF NOT EXISTS public.stress_logs (
  id BIGSERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  rec_basketball BOOLEAN DEFAULT false,
  treadmill_running BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_stress_logs_user_id
ON public.stress_logs(user_id);

CREATE INDEX IF NOT EXISTS idx_stress_logs_date
ON public.stress_logs(date);

CREATE INDEX IF NOT EXISTS idx_stress_logs_created_at
ON public.stress_logs(created_at DESC);

-- Enable RLS
ALTER TABLE public.stress_logs ENABLE ROW LEVEL SECURITY;

-- Drop old policies if they exist
DROP POLICY IF EXISTS "allow all" ON public.stress_logs;
DROP POLICY IF EXISTS "Users can view own stress logs" ON public.stress_logs;
DROP POLICY IF EXISTS "Users can insert own stress logs" ON public.stress_logs;
DROP POLICY IF EXISTS "Users can update own stress logs" ON public.stress_logs;
DROP POLICY IF EXISTS "Users can delete own stress logs" ON public.stress_logs;

-- RLS Policies: Users can only see/modify their own data
CREATE POLICY "Users can view own stress logs"
ON public.stress_logs
FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own stress logs"
ON public.stress_logs
FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own stress logs"
ON public.stress_logs
FOR UPDATE
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own stress logs"
ON public.stress_logs
FOR DELETE
USING (auth.uid() = user_id);

