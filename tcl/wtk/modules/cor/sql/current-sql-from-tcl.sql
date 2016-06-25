CREATE DATABASE mydb
  WITH OWNER = russell
       TEMPLATE = template1
       ENCODING = 'UTF-8';

-- connect to mydb

\c mydb

create schema cordb;

-- COR Classes table

CREATE TABLE cordb.cor_classes (
  class_id integer
    CONSTRAINT cor_cla_class_id_nn NOT NULL,
  class_name varchar(128)
    CONSTRAINT cor_cla_class_name_nn NOT NULL
    CONSTRAINT cor_cla_class_name_un UNIQUE,
  class_desr varchar(1024)
    CONSTRAINT cor_cla_class_desr_nn NOT NULL,
  class_table name
    CONSTRAINT cor_cla_class_table_nn NOT NULL,

  CONSTRAINT cor_cla_class_id_pk PRIMARY KEY (class_id)
);

--plpgsql 
CREATE OR REPLACE FUNCTION cordb.cor_class__create (
  in out p_class_id integer,
  in     p_class_name varchar,
  in     p_class_desr varchar,
  in     p_class_table name
) returns integer
language 'plpgsql' as '
DECLARE



BEGIN


  insert into cordb.cor_classes (
    class_id,
    class_name,
    class_desr,
    class_table
  ) values (
    p_class_id,
    p_class_name,
    p_class_desr,
    p_class_table
  );

END; -- CREATE OR REPLACE FUNCTION cordb.cor_class__create
';
-- COR Objects table

CREATE TABLE cordb.cor_objects (
  object_id integer
    CONSTRAINT cor_obj_object_id_pk PRIMARY KEY
    CONSTRAINT cor_obj_object_id_nn NOT NULL,
  class_id integer
    CONSTRAINT cor_obj_class_id_fk REFERENCES cordb.cor_classes
    CONSTRAINT cor_obj_class_id_nn NOT NULL,
  obj_owner integer
    CONSTRAINT cor_obj_obj_owner_df DEFAULT 100
    CONSTRAINT cor_obj_obj_owner_nn NOT NULL,
  create_date timestamptz
    CONSTRAINT cor_obj_create_date_df DEFAULT now()
    CONSTRAINT cor_obj_create_date_nn NOT NULL,
  change_date timestamptz
    CONSTRAINT cor_obj_change_date_df DEFAULT now()
    CONSTRAINT cor_obj_change_date_nn NOT NULL,
  object_descr text
    CONSTRAINT cor_obj_object_descr_nn NOT NULL
);

--plpgsql 
CREATE OR REPLACE FUNCTION cordb.cor_object__create (
  in out p_object_id integer,
  in     p_class_id integer,
  in     p_obj_owner integer,
  in     p_create_date timestamptz,
  in     p_change_date timestamptz,
  in     p_object_descr text
) returns integer
language 'plpgsql' as '
DECLARE

  t_obj_owner integer := 100;
  t_create_date timestamptz := now();
  t_change_date timestamptz := now();

BEGIN

  if p_obj_owner is not null
    then
      t_obj_owner := p_obj_owner;
  end if;

  if p_create_date is not null
    then
      t_create_date := p_create_date;
  end if;

  if p_change_date is not null
    then
      t_change_date := p_change_date;
  end if;


  insert into cordb.cor_objects (
    object_id,
    class_id,
    obj_owner,
    create_date,
    change_date,
    object_descr
  ) values (
    p_object_id,
    p_class_id,
    t_obj_owner,
    t_create_date,
    t_change_date,
    p_object_descr
  );

END; -- CREATE OR REPLACE FUNCTION cordb.cor_object__create
';
-- COR Attributes Table

CREATE TABLE cordb.cor_attribute_types (
  attr_type_id integer
    CONSTRAINT cor_cat_attr_type_id_pk PRIMARY KEY
    CONSTRAINT cor_cat_attr_type_id_nn NOT NULL,
  attr_type_name varchar(255)
    CONSTRAINT cor_cat_attr_type_name_nn NOT NULL,
  attr_sql_type varchar(255)
    CONSTRAINT cor_cat_attr_sql_type_nn NOT NULL,
  attr_type_descr varchar(255)
    CONSTRAINT cor_cat_attr_type_descr_nn NOT NULL
);

--plpgsql 
CREATE OR REPLACE FUNCTION cordb.cor_attribute_type__create (
  in out p_attr_type_id integer,
  in     p_attr_type_name varchar,
  in     p_attr_sql_type varchar,
  in     p_attr_type_descr varchar
) returns integer
language 'plpgsql' as '
DECLARE



BEGIN


  insert into cordb.cor_attribute_types (
    attr_type_id,
    attr_type_name,
    attr_sql_type,
    attr_type_descr
  ) values (
    p_attr_type_id,
    p_attr_type_name,
    p_attr_sql_type,
    p_attr_type_descr
  );

END; -- CREATE OR REPLACE FUNCTION cordb.cor_attribute_type__create
';

CREATE TABLE cordb.cor_attributes (
  attribute_id integer
    CONSTRAINT cor_att_attribute_id_pk PRIMARY KEY
    CONSTRAINT cor_att_attribute_id_nn NOT NULL
    CONSTRAINT cor_att_attribute_id_fk REFERENCES cordb.cor_objects(object_id),
  class_id integer
    CONSTRAINT cor_att_class_id_nn NOT NULL
    CONSTRAINT cor_att_class_id_fk REFERENCES cordb.cor_classes,
  attr_type_id integer
    CONSTRAINT cor_att_attr_type_id_nn NOT NULL
    CONSTRAINT cor_att_attr_type_id_fk REFERENCES cordb.cor_attribute_types,
  attr_order integer
    CONSTRAINT cor_att_attr_order_nn NOT NULL
    CONSTRAINT cor_att_attr_order_df DEFAULT 1,
  attr_name name
    CONSTRAINT cor_att_attr_name_nn NOT NULL,
  attr_comment text
    CONSTRAINT cor_att_attr_comment_nn NOT NULL,

  CONSTRAINT cor_att_class_id_attr_name_un UNIQUE (class_id, attr_name)
);

--plpgsql 
CREATE OR REPLACE FUNCTION cordb.cor_attribute__create (
  in out p_attribute_id integer,
  in     p_class_id integer,
  in     p_attr_type_id integer,
  in     p_attr_order integer,
  in     p_attr_name name,
  in     p_attr_comment text
) returns integer
language 'plpgsql' as '
DECLARE

  v_descr text; -- for objects
  t_attr_order integer := 1;

BEGIN

  if p_attr_order is not null
    then
      t_attr_order := p_attr_order;
  end if;


  v_descr := p_attr_name || '' is '' || ''Attribute'' || '' '' || ;

  if p_attribute_id is null
    then
      select cordb.cor_object__create(
        null,
        ''attribute'',
        v_descr
      ) into p_attribute_id;
  end if;

  insert into cordb.cor_attributes (
    attribute_id,
    class_id,
    attr_type_id,
    attr_order,
    attr_name,
    attr_comment
  ) values (
    p_attribute_id,
    p_class_id,
    p_attr_type_id,
    t_attr_order,
    p_attr_name,
    p_attr_comment
  );

END; -- CREATE OR REPLACE FUNCTION cordb.cor_attribute__create
';

CREATE TABLE cordb.cor_relations (
  subject_id integer
    CONSTRAINT cor_rel_subject_id_nn NOT NULL
    CONSTRAINT cor_rel_subject_id_fk REFERENCES cordb.cor_objects(object_id),
  object_id integer
    CONSTRAINT cor_rel_object_id_nn NOT NULL
    CONSTRAINT cor_rel_object_id_fk REFERENCES cordb.cor_objects(object_id),
  predicate_id integer
    CONSTRAINT cor_rel_predicate_id_nn NOT NULL
    CONSTRAINT cor_rel_predicate_id_fk REFERENCES cordb.cor_objects(object_id),
  sort_order integer
    CONSTRAINT cor_rel_sort_order_nn NOT NULL
    CONSTRAINT cor_rel_sort_order_df DEFAULT 1,

  CONSTRAINT cor_rel_subject_id_predicate_id_object_id_pk PRIMARY KEY (subject_id, predicate_id, object_id),

  CONSTRAINT cor_rel_subject_id_object_id_predicate_id_un UNIQUE (subject_id, object_id, predicate_id),

  CONSTRAINT cor_rel_object_id_predicate_id_subject_id_un UNIQUE (object_id, predicate_id, subject_id)
);

--plpgsql 
CREATE OR REPLACE FUNCTION cordb.cor_relation__create (
  in out p_subject_id integer,
  in out p_object_id integer,
  in out p_predicate_id integer,
  in     p_sort_order integer
) returns record
language 'plpgsql' as '
DECLARE

  t_sort_order integer := 1;

BEGIN

  if p_sort_order is not null
    then
      t_sort_order := p_sort_order;
  end if;


  insert into cordb.cor_relations (
    subject_id,
    object_id,
    predicate_id,
    sort_order
  ) values (
    p_subject_id,
    p_object_id,
    p_predicate_id,
    t_sort_order
  );

END; -- CREATE OR REPLACE FUNCTION cordb.cor_relation__create
';

CREATE TABLE cordb.cor_identity_types (
  type_id integer
    CONSTRAINT cor_itp_type_id_nn NOT NULL
    CONSTRAINT cor_itp_type_id_pk PRIMARY KEY,
  identity_type_name varchar(128)
    CONSTRAINT cor_itp_identity_type_name_nn NOT NULL
    CONSTRAINT cor_itp_identity_type_name_un UNIQUE,
  type_descr varchar(1024)
    CONSTRAINT cor_itp_type_descr_nn NOT NULL
);

--plpgsql 
CREATE OR REPLACE FUNCTION cordb.cor_identity_type__create (
  in out p_type_id integer,
  in     p_identity_type_name varchar,
  in     p_type_descr varchar
) returns integer
language 'plpgsql' as '
DECLARE



BEGIN


  insert into cordb.cor_identity_types (
    type_id,
    identity_type_name,
    type_descr
  ) values (
    p_type_id,
    p_identity_type_name,
    p_type_descr
  );

END; -- CREATE OR REPLACE FUNCTION cordb.cor_identity_type__create
';

CREATE TABLE cordb.cor_domains (
  domain_id integer
    CONSTRAINT cor_dom_domain_id_nn NOT NULL
    CONSTRAINT cor_dom_domain_id_pk PRIMARY KEY
    CONSTRAINT cor_dom_domain_id_fk REFERENCES cordb.cor_objects(object_id),
  domain_name varchar(128)
    CONSTRAINT cor_dom_domain_name_nn NOT NULL,
  domain_descr varchar(1024)
    CONSTRAINT cor_dom_domain_descr_nn NOT NULL
);

--plpgsql 
CREATE OR REPLACE FUNCTION cordb.cor_domain__create (
  in out p_domain_id integer,
  in     p_domain_name varchar,
  in     p_domain_descr varchar
) returns integer
language 'plpgsql' as '
DECLARE

  v_descr text; -- for objects


BEGIN


  v_descr := p_domain_name || '' is '' || ''Domain'' || '' '' || p_domain_descr;

  if p_domain_id is null
    then
      select cordb.cor_object__create(
        null,
        ''domain'',
        v_descr
      ) into p_domain_id;
  end if;

  insert into cordb.cor_domains (
    domain_id,
    domain_name,
    domain_descr
  ) values (
    p_domain_id,
    p_domain_name,
    p_domain_descr
  );

END; -- CREATE OR REPLACE FUNCTION cordb.cor_domain__create
';

CREATE TABLE cordb.cor_encryption_methods (
  method_id integer
    CONSTRAINT cor_enc_method_id_nn NOT NULL
    CONSTRAINT cor_enc_method_id_pk PRIMARY KEY,
  method_name varchar(128)
    CONSTRAINT cor_enc_method_name_nn NOT NULL
    CONSTRAINT cor_enc_method_name_un UNIQUE,
  method_descr varchar(1024)
    CONSTRAINT cor_enc_method_descr_nn NOT NULL
);

--plpgsql 
CREATE OR REPLACE FUNCTION cordb.cor_encryption_method__create (
  in out p_method_id integer,
  in     p_method_name varchar,
  in     p_method_descr varchar
) returns integer
language 'plpgsql' as '
DECLARE



BEGIN


  insert into cordb.cor_encryption_methods (
    method_id,
    method_name,
    method_descr
  ) values (
    p_method_id,
    p_method_name,
    p_method_descr
  );

END; -- CREATE OR REPLACE FUNCTION cordb.cor_encryption_method__create
';
-- This is the Identities table

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
    CONSTRAINT cor_idt_ident_domain_id_df DEFAULT 1
    CONSTRAINT cor_idt_ident_domain_id_nn NOT NULL,
  ident_name varchar(128)
    CONSTRAINT cor_idt_ident_name_nn NOT NULL,
  ident_login_name varchar(128)
    CONSTRAINT cor_idt_ident_login_name_nn NOT NULL,
  ident_password_hash varchar(512)
    CONSTRAINT cor_idt_ident_password_hash_nn NOT NULL
    CONSTRAINT cor_idt_ident_password_hash_df DEFAULT 'XXXXXXXX',
  ident_password_salt varchar(512)
    CONSTRAINT cor_idt_ident_password_salt_nn NOT NULL
    CONSTRAINT cor_idt_ident_password_salt_df DEFAULT '12345678',
  -- Default encryption method is sha1
  encryption_method integer
    CONSTRAINT cor_idt_encryption_method_fk REFERENCES cordb.cor_encryption_methods(method_id)
    CONSTRAINT cor_idt_encryption_method_df DEFAULT 1
    CONSTRAINT cor_idt_encryption_method_nn NOT NULL,
  ident_descr text
    CONSTRAINT cor_idt_ident_descr_nn NOT NULL,

  CONSTRAINT cor_idt_ident_domain_id_ident_login_name_un UNIQUE (ident_domain_id, ident_login_name)
);

--plpgsql 
CREATE OR REPLACE FUNCTION cordb.cor_identity__create (
  in out p_identity_id integer,
  in     p_ident_type_id integer,
  in     p_ident_domain_id integer,
  in     p_ident_name varchar,
  in     p_ident_login_name varchar,
  in     p_ident_password_hash varchar,
  in     p_ident_password_salt varchar,
  in     p_encryption_method integer,
  in     p_ident_descr text
) returns integer
language 'plpgsql' as '
DECLARE

  v_descr text; -- for objects
  t_ident_domain_id integer := 1;
  t_ident_password_hash varchar := ''XXXXXXXX'';
  t_ident_password_salt varchar := ''12345678'';
  t_encryption_method integer := 1;

BEGIN

  if p_ident_domain_id is not null
    then
      t_ident_domain_id := p_ident_domain_id;
  end if;

  if p_ident_password_hash is not null
    then
      t_ident_password_hash := p_ident_password_hash;
  end if;

  if p_ident_password_salt is not null
    then
      t_ident_password_salt := p_ident_password_salt;
  end if;

  if p_encryption_method is not null
    then
      t_encryption_method := p_encryption_method;
  end if;


  v_descr := p_ident_name || '', '' || p_ident_login_name || '' is '' || ''Identity'' || '' '' || p_ident_descr;

  if p_identity_id is null
    then
      select cordb.cor_object__create(
        null,
        ''identity'',
        v_descr
      ) into p_identity_id;
  end if;

  insert into cordb.cor_identities (
    identity_id,
    ident_type_id,
    ident_domain_id,
    ident_name,
    ident_login_name,
    ident_password_hash,
    ident_password_salt,
    encryption_method,
    ident_descr
  ) values (
    p_identity_id,
    p_ident_type_id,
    t_ident_domain_id,
    p_ident_name,
    p_ident_login_name,
    t_ident_password_hash,
    t_ident_password_salt,
    t_encryption_method,
    p_ident_descr
  );

END; -- CREATE OR REPLACE FUNCTION cordb.cor_identity__create
';

CREATE TABLE cordb.cor_user_types (
  type_id integer
    CONSTRAINT cor_ust_type_id_nn NOT NULL
    CONSTRAINT cor_ust_type_id_pk PRIMARY KEY,
  type_name varchar(128)
    CONSTRAINT cor_ust_type_name_nn NOT NULL
    CONSTRAINT cor_ust_type_name_un UNIQUE,
  type_descr varchar(1024)
    CONSTRAINT cor_ust_type_descr_nn NOT NULL
);

--plpgsql 
CREATE OR REPLACE FUNCTION cordb.cor_user_type__create (
  in out p_type_id integer,
  in     p_type_name varchar,
  in     p_type_descr varchar
) returns integer
language 'plpgsql' as '
DECLARE



BEGIN


  insert into cordb.cor_user_types (
    type_id,
    type_name,
    type_descr
  ) values (
    p_type_id,
    p_type_name,
    p_type_descr
  );

END; -- CREATE OR REPLACE FUNCTION cordb.cor_user_type__create
';

CREATE TABLE cordb.cor_users (
  user_id integer
    CONSTRAINT cor_usr_user_id_nn NOT NULL
    CONSTRAINT cor_usr_user_id_pk PRIMARY KEY
    CONSTRAINT cor_usr_user_id_fk REFERENCES cordb.cor_identities(identity_id),
  user_type_id integer
    CONSTRAINT cor_usr_user_type_id_nn NOT NULL
    CONSTRAINT cor_usr_user_type_id_df DEFAULT 2
    CONSTRAINT cor_usr_user_type_id_fk REFERENCES cordb.cor_user_types(type_id)
);

--plpgsql 
CREATE OR REPLACE FUNCTION cordb.cor_user__create (
  in out p_user_id integer,
  in     p_user_type_id integer
) returns integer
language 'plpgsql' as '
DECLARE

  t_user_type_id integer := 2;

BEGIN

  if p_user_type_id is not null
    then
      t_user_type_id := p_user_type_id;
  end if;


  insert into cordb.cor_users (
    user_id,
    user_type_id
  ) values (
    p_user_id,
    t_user_type_id
  );

END; -- CREATE OR REPLACE FUNCTION cordb.cor_user__create
';
