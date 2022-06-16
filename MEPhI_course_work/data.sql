INSERT INTO Client values (9, 'author');
INSERT INTO IP_addr values ('1.9.44.1', 9);
INSERT INTO IP_addr values ('1.9.44.2', 9);
INSERT INTO IP_addr values ('1.9.44.3', 9);
INSERT INTO IP_addr values ('1.9.44.4', 9);

SELECT * FROM ip_addr;

SELECT COUNT(ip) FROM IP_addr WHERE id_client = 9;

INSERT INTO Document values (9, 'author');

INSERT INTO Author(info_auth, theme) values ('auth1', 'theme1');
INSERT INTO Author(info_auth, theme) values ('auth2', 'theme1');
INSERT INTO "User"(login, info, access_level, isblocked) values ('user1', 'info1', 'vip', FALSE);
INSERT INTO "User"(login, info, access_level, isblocked) values ('user2', 'info2', 'vip', FALSE);

INSERT INTO ip_addr(ip, id_client) values ('1.2.3.4', 1);
INSERT INTO ip_addr(ip, id_client) values ('1.2.3.4', 2);
INSERT INTO ip_addr(ip, id_client) values ('1.2.3.4', 3);

INSERT INTO ip_addr(ip, id_client) values ('1.2.3.5', 1);
INSERT INTO ip_addr(ip, id_client) values ('1.2.3.5', 2);


INSERT INTO Document(coauth, auth, doc_type, doc_theme)
VALUES (1, 2, 'type1', 'theme1');

INSERT INTO Document(coauth, auth, doc_type, doc_theme, parent_number)
VALUES (2, 1, 'type1', 'theme1', 1);

INSERT INTO Document(coauth, auth, doc_type, doc_theme)
VALUES (null, 1, 'type1', 'theme1');

INSERT INTO Document(coauth, auth, doc_type, doc_theme)
VALUES (null, 2, 'type1', 'theme1');

INSERT INTO seen
VALUES (null, 2, 'type1', 'theme1');

DELETE FROM seen;