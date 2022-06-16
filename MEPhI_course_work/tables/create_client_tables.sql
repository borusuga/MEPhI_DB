create table if not exists Client(
    id_client int primary key not null ,
    client_type varchar(6) check ( client_type SIMILAR TO '(author)|(user)')
                                 );

drop table Client;

create table if not exists "User"(
    id_user int primary key not null references Client(id_client),
    login varchar(20) unique ,
    info varchar(200),
    access_level varchar(20),
    isBlocked bool
                                 );

drop table "User";

create table if not exists Author(
    id_author int primary key not null references Client(id_client),
    info_auth varchar(200),
    theme varchar(20)
                                 );

drop table Author;

select * from "User"