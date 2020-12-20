create table departments (
                             id serial not null,
                             numd numeric,
                             name varchar(150) not null,
                             descr varchar(250)
);
create table emploeers (
                           id serial not null,
                           name varchar(150) not null,
                           surname varchar(150) not null,
                           age numeric,
                           profession varchar(50),
                           positionid integer,
                           departmentid integer
)

create table positions(
                           id serial not null primary key ,
                           name varchar(150) not null,
                           salary numeric not null
)