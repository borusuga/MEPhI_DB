create table if not exists Seen(
    doc_number int not null references Document(doc_number),
    client_id int not null references "User"(id_user),
    date date not null,
    primary key (doc_number, client_id, date),
    favourites bool not null
);

drop table Seen;