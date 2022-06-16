create table if not exists IP_addr(
    ip char(19) primary key not null check ( ip SIMILAR TO 'd{1,3}\.d{1,3}\.d{1,3}'),
    id_client int not null references Client(id_client)
);

drop table IP_addr;