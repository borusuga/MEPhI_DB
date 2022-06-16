-- -- Для каждого пользователя вывести количество документов занимаемом в избранном, у
-- -- которых больше одного автора (есть соавтор)
-- select * from "User"
--     join seen s on "User".id_user = s.client_id
--     join document d on s.doc_number = d.doc_number
-- where coauth IS NOT NULL and favourites = TRUE;

select id_user, count(*) from "User"
    join seen s on "User".id_user = s.client_id
    join document d on s.doc_number = d.doc_number
where coauth IS NOT NULL and favourites = TRUE
group by id_user;

-- -- Вывести документы, у которых автор и не менее двух
-- -- пользователей используют один и тот же ip-адрес
-- -- -- на данный момент выводит соответствие для автора - все юзеры с таким же  ip адресом

select doc_number , count(distinct c.id_client) from document
    join author a on a.id_author = document.auth
    join ip_addr ip1 on ip1.id_client = a.id_author
    join ip_addr ip2 on ip2.ip = ip1.ip
    join client c on ip2.id_client = c.id_client
where c.client_type = 'user'
group by doc_number;

-- select * from ip_addr;
-- select doc_number from document
--     join author a on a.id_author = document.auth
--     join ip_addr ip1 on ip1.id_client = a.id_author
--
--
-- select doc_number from document
-- where (select count(*) from document join author a on a.id_author = document.auth
--     join ip_addr ip1 on ip1.id_client = a.id_author
--     join ip_addr ip2 on ip2.ip = ip1.ip
--     join client c on ip2.id_client = c.id_client
--     where c.client_type = 'user') >= 2;


-- -- Вывести документы, у которых последняя и
-- -- предпоследняя версия отличается на 90%
-- -- т.е. отличаются все поля
-- select * from document
--     join document prev_doc on prev_doc.doc_number = document.parent_number
-- where document.auth != prev_doc.auth and document.coauth != prev_doc.coauth and
--       document.doc_type != prev_doc.doc_type and document.doc_theme != prev_doc.doc_theme
select document.doc_number, prev_doc.doc_number from document
    join document prev_doc on prev_doc.doc_number = document.parent_number
where document.auth != prev_doc.auth and document.coauth != prev_doc.coauth and
      document.doc_type != prev_doc.doc_type and document.doc_theme != prev_doc.doc_theme;

-- -- Вывести информатора, который консультирует авторов, у которых
-- -- есть документы с 3 и более версиями

-- select informator_numb, count(*) from informator
--     join documentinfo d on informator.informator_numb = d.informator_number
--     join document d2 on d2.doc_number = d.doc_number
--     join author a on a.id_author = d2.auth
-- where (select count(*) from author
--         join document d3 on author.id_author = d3.auth
--     where author.id_author = a.id_author)
-- group by a.id_author;

-- with table1 as (select * from document where parent_number is null),
-- table2 as (select d2.doc_number, d2.auth, d2.parent_number from document d2 join table1 on table1.doc_number = d2.parent_number)
-- select doc_number, auth, parent_number from table1 except (select doc_number, auth, parent_number from document where doc_number not in (select doc_number from table2));

-- идти от самой новой до самой последней версии
-- select d2.doc_number from document d0
--     join document d1 on d1.parent_number = d0.doc_number
--     join document d2 on d2.parent_number = d1.doc_number;
-----------------
with final_ver as(
select d2.doc_number, d2.auth
from document d0
    join document d1 on d1.parent_number = d0.doc_number
    join document d2 on d2.parent_number = d1.doc_number
)
select informator0.informator_numb from final_ver
join documentinfo dinf on final_ver.doc_number = dinf.doc_number
join informator informator0 on informator0.informator_numb = dinf.informator_number;


-- -- Вывести рейтинг документов - отсортировать по числу просмотров,
-- -- и определить как часто документ попадает в избранное (%)
with rate as (
    select document.doc_number, count(seen.doc_number) as views
    from document left outer join seen on document.doc_number = seen.doc_number
    group by document.doc_number
) select rate.doc_number, rate.views, count(favourites) as favourites, case when views=0 then '-' else CAST(round(CAST(count(favourites)::float/views*100 as numeric), 2) as varchar) end as popularity from rate
    left outer join seen s on rate.doc_number=s.doc_number
    where s.favourites=true or s.favourites IS NULL
group by rate.doc_number, rate.views
having sum(views) > 2
order by views desc;
-- написать этот же запрос через where
with rate as (
    select document.doc_number, count(seen.doc_number) as views
    from document left outer join seen on document.doc_number = seen.doc_number
    group by document.doc_number
) select rate.doc_number, rate.views, count(favourites) as favourites, case when views=0 then '-' else CAST(round(CAST(count(favourites)::float/views*100 as numeric), 2) as varchar) end as popularity from rate
    left outer join seen s on rate.doc_number=s.doc_number
    where (s.favourites=true or s.favourites IS NULL) and views > 2
group by rate.doc_number, rate.views
order by views desc;

EXPLAIN ANALYSE with rate as (
    select document.doc_number, count(seen.doc_number) as views
    from document left outer join seen on document.doc_number = seen.doc_number
    group by document.doc_number
) select rate.doc_number, rate.views, count(favourites) as favourites, case when views=0 then '-' else CAST(round(CAST(count(favourites)::float/views*100 as numeric), 2) as varchar) end as popularity from rate
    left outer join seen s on rate.doc_number=s.doc_number
    where s.favourites=true or s.favourites IS NULL
group by rate.doc_number, rate.views
having sum(views) > 2
order by views desc;

EXPLAIN ANALYSE with rate as (
    select document.doc_number, count(seen.doc_number) as views
    from document left outer join seen on document.doc_number = seen.doc_number
    group by document.doc_number
) select rate.doc_number, rate.views, count(favourites) as favourites, case when views=0 then '-' else CAST(round(CAST(count(favourites)::float/views*100 as numeric), 2) as varchar) end as popularity from rate
    left outer join seen s on rate.doc_number=s.doc_number
    where (s.favourites=true or s.favourites IS NULL) and views > 2
group by rate.doc_number, rate.views
order by views desc;