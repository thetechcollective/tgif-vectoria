-- Insert a page about the development team
insert into docs.page (path, checksum, meta, type, source, version, last_refresh)
values (
  '/about/development-team',
  null,
  '{"title": "Development Team", "description": "Meet our talented development team."}',
  'info',
  'internal',
  gen_random_uuid(),
  now()
);

-- Insert a section with team member details
insert into docs.page_section (page_id, content, token_count, slug, heading)
select
  id,
  'Our development team consists of 3 members:

1. Alice - Enjoys hiking and painting.
2. Bob - Loves chess and cycling.
3. Carol - Passionate about photography and cooking.',
  0,
  'team-members',
  'Team Members'
from docs.page
where path = '/about/development-