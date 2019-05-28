
-- create classes for:
-- 2. cor_attributes
-- 3. cor_domains
-- 4. cor_identities
-- 5. cor_users

insert into cordb.cor_objects values (2, 1, 100, now(), now(), 'COR Attributes class');
insert into cordb.cor_classes values (2, 'Attribute', 'COR Attribute Class', 'cor_attributes');

insert into cordb.cor_objects values (3, 1, 100, now(), now(), 'COR Domains class');
insert into cordb.cor_classes values (3, 'Domain', 'COR Domains Class', 'cor_domains');

insert into cordb.cor_objects values (4, 1, 100, now(), now(), 'COR Identities class');
insert into cordb.cor_classes values (4, 'Identity', 'COR Identities Class', 'cor_identities');

insert into cordb.cor_objects values (5, 1, 100, now(), now(), 'COR Users class');
insert into cordb.cor_classes values (5, 'User', 'COR Users Class', 'cor_users');

insert into cordb.cor_objects values (50, 4, 100, now(), now(), 'Admin Group');
--insert into cordb.cor_objects values (100, 4, 100, now(), now(), 'User: Russell Sorensen');
