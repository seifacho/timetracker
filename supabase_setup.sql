create table public.user_data (
  user_id uuid references auth.users(id) primary key,
  state jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.user_data enable row level security;

create policy "Users can view own data" on public.user_data
  for select using (auth.uid() = user_id);

create policy "Users can insert own data" on public.user_data
  for insert with check (auth.uid() = user_id);

create policy "Users can update own data" on public.user_data
  for update using (auth.uid() = user_id);
