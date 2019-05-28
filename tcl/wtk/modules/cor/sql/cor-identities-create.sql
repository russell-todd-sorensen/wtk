-- =========================================
-- Create table cor_identities
-- =========================================

CREATE TABLE cordb.cor_identities
(
 identity_id int
  CONSTRAINT cor_idt_identity_id PRIMARY KEY
  CONSTRAINT cor_idt_ident_id_fk references cordb.cor_objects(object_id)
  CONSTRAINT cor_idt_ident_id_nn NOT NULL,
 ident_type_id int
  CONSTRAINT cor_idt_ident_type_id_fk references cordb.cor_identity_types(type_id)
  CONSTRAINT cor_idt_ident_type_id_nn NOT NULL,
 ident_domain_id int
  CONSTRAINT cor_idt_ident_domain_id_fk references cordb.cor_domains(domain_id)
  CONSTRAINT cor_idt_ident_domain_id_df DEFAULT 1
  CONSTRAINT cor_idt_ident_domain_id_nn NOT NULL,
 ident_name varchar(128)
  CONSTRAINT cor_idt_ident_name_nn NOT NULL,
 ident_login_name varchar(128)
  CONSTRAINT cor_idt_ident_login_name_nn NOT NULL,
 ident_password_hash varchar(512)
  CONSTRAINT cor_idt_ident_pw_hash_nn NOT NULL
  CONSTRAINT cor_idt_ident_pw_hash_df DEFAULT 'XXXXXXXX',
 ident_password_salt varchar(512)
  CONSTRAINT cor_idt_ident_pw_salt_df DEFAULT '12345678'
  CONSTRAINT cor_idt_ident_pw_salt_nn NOT NULL,
 encryption_method_id int
  CONSTRAINT cor_idt_encr_method_id_fk references cordb.cor_encryption_methods(method_id)
  CONSTRAINT cor_idt_encr_method_id_df DEFAULT 1
  CONSTRAINT cor_idt_encr_method_id_nn NOT NULL,
 ident_descr text
  CONSTRAINT cor_idt_descr_text_nn NOT NULL,
 CONSTRAINT cor_idt_idt_grp_id_name_un UNIQUE (ident_domain_id, ident_login_name)
);
