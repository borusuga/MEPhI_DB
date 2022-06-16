CREATE OR REPLACE PROCEDURE doc_registration(pauth int, pcoauth int, pdoc_type varchar,
pdoc_theme varchar, pparent_number int DEFAULT NULL)
LANGUAGE plpgsql AS
$$
    BEGIN
        INSERT INTO Document(coauth, auth, doc_type, doc_theme, parent_number)
        VALUES (pcoauth, pauth, pdoc_type, pdoc_theme, pparent_number);
    END;
$$;

CALL doc_registration(pauth := 1, pcoauth := 1, pdoc_type := 'some_type', pdoc_theme := 'some_theme', pparent_number := 7);