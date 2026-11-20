create extension if not exists pgcrypto;

create table if not exists public.jarvis_a2a_inbox (
  id uuid primary key default gen_random_uuid(),
  sender_id text not null,
  context_id text not null,
  message_text text not null,
  payload jsonb not null,
  status text not null default 'submitted'
    check (status in ('submitted','working','completed','failed')),
  response jsonb,
  claimed_by text,
  attempts integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists jarvis_a2a_inbox_status_created_idx
  on public.jarvis_a2a_inbox(status, created_at);

alter table public.jarvis_a2a_inbox enable row level security;
revoke all on public.jarvis_a2a_inbox from anon, authenticated;
grant all on public.jarvis_a2a_inbox to service_role;

create or replace function public.claim_jarvis_a2a_task(p_worker_id text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  task public.jarvis_a2a_inbox%rowtype;
begin
  select * into task
  from public.jarvis_a2a_inbox
  where status = 'submitted'
  order by created_at
  for update skip locked
  limit 1;

  if not found then return null; end if;

  update public.jarvis_a2a_inbox
  set status = 'working', claimed_by = p_worker_id,
      attempts = attempts + 1, updated_at = now()
  where id = task.id
  returning * into task;

  return jsonb_build_object(
    'id', task.id, 'senderId', task.sender_id, 'contextId', task.context_id,
    'text', task.message_text, 'payload', task.payload, 'attempts', task.attempts
  );
end;
$$;

create or replace function public.complete_jarvis_a2a_task(
  p_task_id uuid, p_worker_id text, p_response jsonb, p_failed boolean default false
)
returns boolean
language plpgsql
security definer
set search_path = public
as $$
declare changed integer;
begin
  update public.jarvis_a2a_inbox
  set status = case when p_failed then 'failed' else 'completed' end,
      response = p_response, updated_at = now()
  where id = p_task_id and status = 'working' and claimed_by = p_worker_id;
  get diagnostics changed = row_count;
  return changed = 1;
end;
$$;

revoke all on function public.claim_jarvis_a2a_task(text) from public, anon, authenticated;
revoke all on function public.complete_jarvis_a2a_task(uuid,text,jsonb,boolean) from public, anon, authenticated;
grant execute on function public.claim_jarvis_a2a_task(text) to service_role;
grant execute on function public.complete_jarvis_a2a_task(uuid,text,jsonb,boolean) to service_role;
