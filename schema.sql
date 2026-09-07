-- شغّل هذا مرة واحدة في: Supabase → SQL Editor → New query → Run
create table if not exists ijar_records (
  id          text primary key,
  col         text not null,
  data        jsonb not null,
  updated_at  timestamptz not null default now()
);

create index if not exists ijar_records_col_idx on ijar_records (col);

alter table ijar_records enable row level security;

drop policy if exists ijar_all on ijar_records;
create policy ijar_all on ijar_records
  for all to anon, authenticated
  using (true) with check (true);

alter publication supabase_realtime add table ijar_records;
