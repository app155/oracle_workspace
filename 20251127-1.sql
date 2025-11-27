grant create view to scott;

show user;

create user backupuser identified by backup1234;
grant connect, resource to backupuser;
grant create view to backupuser;