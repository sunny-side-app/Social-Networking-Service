create table user (
    id serial primary key,
    username varchar(255) not null,
    email varchar(255) not null,
    created_at timestamp not null default current_timestamp
);

insert user (username, email) values ('admin', 'admin@example.com');
insert user (username, email) values ('user', 'user@example.com');


