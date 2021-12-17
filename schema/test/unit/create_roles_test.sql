begin;
select plan(8);


select has_role( 'connectivity_engagement_internal', 'role connectivity_engagement_internal exists' );
select isnt_superuser(
    'connectivity_engagement_internal',
    'connectivity_engagement_internal should not be a super user'
);

select has_role( 'connectivity_engagement_external', 'role connectivity_engagement_external exists' );
select isnt_superuser(
    'connectivity_engagement_external',
    'connectivity_engagement_external should not be a super user'
);

select has_role( 'connectivity_engagement_admin', 'role connectivity_engagement_admin exists' );
select isnt_superuser(
    'connectivity_engagement_admin',
    'connectivity_engagement_admin should not be a super user'
);

select has_role( 'connectivity_engagement_guest', 'role connectivity_engagement_guest exists' );
select isnt_superuser(
    'connectivity_engagement_guest',
    'connectivity_engagement_guest should not be a super user'
);


select finish();
rollback;
