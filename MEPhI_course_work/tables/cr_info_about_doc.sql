create table if not exists DocumentInfo(
    doc_number int not null references Document(doc_number),
    informator_number int not null references Informator(informator_numb),
    primary key (doc_number, informator_number)
                                     );