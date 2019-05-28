insert into cordb.cor_objects
(object_id,
 class_id,
 obj_owner,
 create_date,
 change_date,
 object_descr
)
values
(999,  4, 100, now(), now(), 'Admin Group'),
(100,  4, 100, now(), now(), 'User: Russell Sorensen'),
(1000, 3, 100, now(), now(), 'Domain: Local');

insert into cordb.cor_domains
(domain_id,
 domain_name,
 domain_descr
)
values
(1000, 'Local', 'Local Domain');

insert into cordb.cor_identities
(identity_id,
 ident_type_id,
 ident_domain_id,
 ident_name,
 ident_login_name,
 ident_password_hash,
 ident_password_salt,
 encryption_method_id,
 ident_descr
)
values
(100,
 2,
 1000,
 'Russell Sorensen',
 'russell',
 '85314791af1a35ccd141b67a881c75e069d3f0c5', --password
 '0.029968953239717034',
 2,
 'User: Russell Sorensen, login russell'),

(999,
 3,
 1000,
 'Admin',
 'admin',
 '9f2d630c26b06d1ea90088ee3bad396e1e7b6f10', --adminPassword
 '0.6881970999241793',
 2,
 'Admin Group: Admin, login admin'
);
