-- при вставке в таблицу с ip-адресами надо проверить есть ли такой
-- юзер в таблице юзеров
-- если нет - не производить вставку
-- если есть, то посмотреть, сколько записей с таким user_id в
-- таблице с ip-адресами
-- -- если три, то не производить вставку
-- -- если меньше, то всё ок

CREATE OR REPLACE FUNCTION check_ips_fun()
RETURNS TRIGGER AS
$$
    DECLARE
        count INT;
--        ip_row RECORD;
--         client INT := 0; -- нужен был для проверки есть ли такой клиент, но это проверяется при reference
    BEGIN
--         client := COUNT(id_client) FROM Client WHERE id_client = NEW.id_client;
--         IF client != 1 THEN
--             RAISE EXCEPTION 'you cannot assign ip to the unknown client';
--         END IF;
        count := COUNT(ip) FROM IP_addr WHERE id_client = NEW.id_client;
--         FOR ip_row IN SELECT * FROM IP_addr
--         LOOP
--             IF ip_row.ip = NEW.ip THEN
--                 count := count + 1;
--             END IF;
--         END LOOP;
        IF count < 3 THEN
            RETURN NEW;
        END IF;
        RAISE WARNING 'INSERT ERROR: you cannot assign more then 3 ip to the client';
        RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER teacher_ip_restriction
    BEFORE INSERT ON IP_addr
    FOR EACH ROW EXECUTE PROCEDURE check_ips_fun();
