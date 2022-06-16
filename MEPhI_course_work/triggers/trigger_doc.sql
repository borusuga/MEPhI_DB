CREATE OR REPLACE FUNCTION check_parent()
RETURNS TRIGGER AS
$$
    DECLARE
        count INT;
    BEGIN
        IF NEW.parent_number IS NULL THEN
            RETURN NEW;
        end if;
        count := COUNT(doc_number) FROM Document WHERE doc_number = NEW.parent_number;
        IF count = 1 THEN
            RETURN NEW;
        END IF;
        RAISE WARNING 'INSERT ERROR: parent document not found`';
--         alter sequence document_doc_number_seq restart with NEW.doc_number - 1;
        RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER teacher_doc_add
    BEFORE INSERT ON Document
    FOR EACH ROW EXECUTE PROCEDURE check_parent();
