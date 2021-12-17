begin;
select plan(2);

select has_table(
  'connectivity_engagement_private', 'connect_session',
  'connectivity_engagement_private.connect_session should exist, and be a table'
);

select has_index(
  'connectivity_engagement_private',
  'connect_session',
  'connectivity_engagement_private_idx_session_expire',
  'connect session has index: connectivity_engagement_private_idx_session_expire' );

select finish();
rollback;
