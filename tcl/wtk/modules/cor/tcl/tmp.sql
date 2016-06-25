-- This is the CORDB Identities table                                                                                                                    

CREATE TABLE cordb.cor_identities (
    identity_id integer            
        CONSTRAINT cor_idt_identity_id_pk PRIMARY KEY
        CONSTRAINT cor_idt_identity_id_fk REFERENCES cordb.cor_objects(object_id)
        CONSTRAINT cor_idt_identity_id_nn NOT NULL,
    ident_type_id integer
        CONSTRAINT cor_idt_ident_type_id_fk REFERENCES cordb.cor_identity_types(type_id)
        CONSTRAINT cor_idt_ident_type_id_nn NOT NULL,
    ident_domain_id integer
        CONSTRAINT cor_idt_ident_domain_id_fk REFERENCES cordb.cor_domains(domain_id)
        CONSTRAINT cor_idt_ident_domain_id_df 1
        CONSTRAINT cor_idt_ident_domain_id_nn NOT NULL,
    ident_name varchar(128)
        CONSTRAINT cor_idt_ident_name_nn NOT NULL,
    ident_login_name varchar(128)
        CONSTRAINT cor_idt_ident_login_name_nn NOT NULL,
    ident_password_hash varchar(512)
        CONSTRAINT cor_idt_ident_password_hash_nn NOT NULL
        CONSTRAINT cor_idt_ident_password_hash_df 'XXXXXXXX',
    ident_password_salt varchar(512)
        CONSTRAINT cor_idt_ident_password_salt_nn NOT NULL
        CONSTRAINT cor_idt_ident_password_salt_df '12345678',
    encryption_method integer
        CONSTRAINT cor_idt_encryption_method_fk REFERENCES cordb.cor_encryption_methods(method_id)
        CONSTRAINT cor_idt_encryption_method_df 1
        CONSTRAINT cor_idt_encryption_method_nn NOT NULL,
    ident_descr text
        CONSTRAINT cor_idt_ident_descr_nn NOT NULL,

    CONSTRAINT cor_idt_un UNIQUE (ident_domain_id, ident_login_name)
);
