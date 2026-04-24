create table if not exists public.study_snapshots (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.study_snapshots enable row level security;

create policy "select own snapshot"
on public.study_snapshots
for select
to authenticated
using ((select auth.uid()) = user_id);

create policy "insert own snapshot"
on public.study_snapshots
for insert
to authenticated
with check ((select auth.uid()) = user_id);

create policy "update own snapshot"
on public.study_snapshots
for update
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);
