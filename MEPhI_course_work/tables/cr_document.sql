create table if not exists Document(
    doc_number int primary key not null,
    coauth int not null references Author(id_author),
    auth int not null references Author(id_author),
    doc_type varchar(50),
    doc_theme varchar(50),
    parent_number int null references Document(doc_number) on delete cascade
                                     );

drop table Document;
