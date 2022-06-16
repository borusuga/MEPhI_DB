create table if not exists Category(
    CatID char(1) primary key not null check ( CatID similar to '[A-Z]'),
    CatName varchar(50) unique not null,
    Properties varchar(20) null
);

drop table Category;

create table if not exists COrder(
    OrderID serial primary key not null ,
    OrderCode char(8) unique not null check ( OrderCode similar to '[A-Z]{3}[0-9]{5}'),
    CreateDate date not null DEFAULT current_date,
    EmpName varchar(20) not null,
    CommonCost int DEFAULT 0 check ( CommonCost >= 0 ),
    ExecuteDate date not null check ( ExecuteDate >= COrder.CreateDate ),
    PaymentDate date not null check ( PaymentDate >= CreateDate and PaymentDate <= ExecuteDate)
);

drop table COrder;

create table if not exists Component(
    ComponentID int not null,
    CatID char(1) not null references Category(CatID) on delete no action,
    primary key (ComponentID, CatID),
    ComponentName varchar(20) not null unique ,
    Properties varchar(200) null,
    Cost int not null default 1 check ( Cost >= 0 ),
    IncreaseCost float not null check ( IncreaseCost >= 3 )
);

drop table Component;


create table if not exists OrderItem(
    ComponentID int not null ,
    CatID char(1) not null ,
    OrderID int not null references COrder(OrderID) on delete no action,
    foreign key (ComponentID, CatID) references Component(ComponentID, CatID) on DELETE no action ,
    primary key (ComponentID, CatID, OrderID),
    Comment varchar(200) null
);

drop table OrderItem;
