create table if not exists Category(
    code int primary key not null ,
    title varchar(50) unique
                                     );

drop table Category;