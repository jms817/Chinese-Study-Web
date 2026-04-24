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

-- 검수 결과 테이블 (로그인 불필요, anon 공개 접근)
create table if not exists public.nuance_reviews (
  id uuid primary key default gen_random_uuid(),
  reviewer_name text not null,
  item_id text not null,
  choice text,
  comment text not null default '',
  reviewed_at timestamptz not null default now(),
  unique(reviewer_name, item_id)
);

alter table public.nuance_reviews enable row level security;

create policy "anon select nuance reviews"
on public.nuance_reviews for select to anon using (true);

create policy "anon insert nuance reviews"
on public.nuance_reviews for insert to anon with check (true);

create policy "anon update nuance reviews"
on public.nuance_reviews for update to anon using (true) with check (true);
