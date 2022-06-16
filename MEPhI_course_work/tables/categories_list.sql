create table if not exists CategoriesList(
    informator_numb int not null references Informator(informator_numb),
    category_code int not null references Category(code),
    primary key (informator_numb, category_code)
                                     );

drop table CategoriesList;