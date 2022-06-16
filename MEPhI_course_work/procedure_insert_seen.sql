CREATE OR REPLACE PROCEDURE seen_registration(ptype varchar, puser_id int)
LANGUAGE plpgsql AS
$$
    DECLARE
        doc     RECORD;
        count   INT;
        curs1   CURSOR FOR SELECT doc_number FROM Document WHERE doc_type = ptype;
        _num_doc INT;
    BEGIN
        count := COUNT(id_user) FROM "User" WHERE id_user = puser_id;
        OPEN curs1;
        IF count = 1 THEN
            LOOP
                FETCH curs1 INTO _num_doc;
                IF NOT FOUND THEN EXIT; END IF;
                INSERT INTO seen VALUES (_num_doc, puser_id, current_date, FALSE);
                RAISE NOTICE '%', _num_doc;
            end loop;
--             FOR doc IN SELECT * FROM Document WHERE doc_type = ptype
--             LOOP
--                 INSERT INTO seen VALUES (doc.doc_number, puser_id, current_date, FALSE);
--             END LOOP;
            CLOSE curs1;
        end if;
    END;
$$;

CALL seen_registration(ptype := 'some_type', puser_id := 2);

SELECT doc_number FROM Document WHERE doc_type = 'some_type';