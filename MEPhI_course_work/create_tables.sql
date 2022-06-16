create table if not exists Client(
    id_client serial primary key not null ,
    client_type varchar(6) check ( client_type SIMILAR TO  '(author)|(user)')
                                 );

create table if not exists "User"(
    id_user int primary key references Client(id_client),
    login varchar(20) unique not null ,
    info varchar(200),
    access_level varchar(20),
    isBlocked bool
                                 );

create table if not exists Author(
    id_author int primary key references Client(id_client),
    info_auth varchar(200),
    theme varchar(20)
                                 );

create table if not exists IP_addr(
    ip varchar(15) not null check ( ip SIMILAR TO '[1-255]\.\d{1,3}\.\d{1,3}.\d{1,3}'),
    id_client int not null references Client(id_client),
    primary key (ip, id_client)
);

create table if not exists Category(
    code serial primary key not null ,
    title varchar(50) unique
                                     );

create table if not exists Informator(
    informator_numb serial primary key not null,
    info varchar(200) not null
                                     );

create table if not exists CategoriesList(
    informator_numb int not null references Informator(informator_numb),
    category_code int not null references Category(code),
    primary key (informator_numb, category_code)
                                     );

create table if not exists Document(
    doc_number serial primary key not null,
    coauth int null references Author(id_author),
    auth int not null references Author(id_author),
    doc_type varchar(50) not null,
    doc_theme varchar(50) not null,
    parent_number int null references Document(doc_number) on delete cascade
                                     );

create table if not exists DocumentInfo(
    doc_number int not null references Document(doc_number),
    informator_number int not null references Informator(informator_numb),
    primary key (doc_number, informator_number)
                                     );

create table if not exists Seen(
    doc_number int not null references Document(doc_number),
    client_id int not null references "User"(id_user),
    date date not null,
    primary key (doc_number, client_id, date),
    favourites bool not null
);

-- create trigger three_ip after insert on IP_addr execute
-- --     for each row execute

