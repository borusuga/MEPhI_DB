-- после вставки в клиента, надо добавить его и в таблицу user/author
-- надо при добавлении автора сначала добавить его в клиента, а оттуда взять
-- id и уже с этим id делать добавление в таблицу авторов
CREATE OR REPLACE FUNCTION distribute_auth_fun()
RETURNS TRIGGER AS
$$
    DECLARE
        count   INT;
        person_id  INT;
    BEGIN
--     count := COUNT(id_client) FROM Client WHERE id_client = NEW.id_author;
--     IF count != 0 THEN
--         RAISE WARNING 'client with this id already exists'
--     end if;
    INSERT INTO Client(client_type) VALUES ('author');
    SELECT max(id_client) INTO person_id FROM Client;
    NEW.id_author = person_id;
    RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER teacher_client_distribution
    BEFORE INSERT ON Author
    FOR EACH ROW EXECUTE PROCEDURE distribute_auth_fun();

CREATE OR REPLACE FUNCTION distribute_user_fun()
RETURNS TRIGGER AS
$$
    DECLARE
        count   INT;
        person_id  INT;
    BEGIN
--     count := COUNT(id_client) FROM Client WHERE id_client = NEW.id_author;
--     IF count != 0 THEN
--         RAISE WARNING 'client with this id already exists'
--     end if;
    INSERT INTO Client(client_type) VALUES ('user');
    SELECT max(id_client) INTO person_id FROM Client;
    NEW.id_user = person_id;
    RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER teacher_client_distribution
    BEFORE INSERT ON "User"
    FOR EACH ROW EXECUTE PROCEDURE distribute_user_fun();