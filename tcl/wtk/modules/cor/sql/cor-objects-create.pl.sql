create or replace function cordb.cor_object__create (
 in out p_object_id integer,
 in     p_object_type_name varchar,
 in     p_object_descr text
) returns integer language  'plpgsql' as '

DECLARE
 v_class_id integer;
BEGIN

  if p_object_type_name is not null
   then
    select class_id from cordb.cor_classes
    where
      UPPER(class_name) = UPPER(p_object_type_name)
    into v_class_id;
  end if;

  if p_object_id is null
   then
    select nextval(''cordb.cor_object_id_seq'') into p_object_id;
  end if;

  insert into cordb.cor_objects
   (
    object_id,
    class_id,
    obj_owner,
    create_date,
    change_date,
    object_descr
   ) values (
    p_object_id,
    v_class_id,
    999,
    now(),
    now(),
    p_object_descr
   );

  return;
END;
'

create or replace function cordb.cor_object__create (
 in out p_object_id integer,
 in     p_class_id    integer,
 in     p_obj_owner   integer,
 in     p_create_date timestamptz,
 in     p_change_date timestamptz,
 in     p_object_descr text
) returns integer

language 'plpgsql' as '
DECLARE
 t_create timestamptz;
 t_change timestamptz;
BEGIN

  if p_object_id is null
   then
    select nextval(''cordb.cor_object_id_seq'') into p_object_id;
  end if;

  if p_create_date is null
   then
    t_create := t_now;
   else
    t_create := p_create_date;
  end if;

  if p_change_date is null
   then
    t_change := t_now;
   else
    t_change := p_change_date;
  end if;

  insert into cordb.cor_objects
   (
    object_id,
    class_id,
    obj_owner,
    create_date,
    change_date,
    object_descr
   ) values (
    p_object_id,
    p_class_id,
    p_obj_owner,
    t_create,
    t_change,
    p_object_descr
   );

  return;
END;
';

create or replace function cordb.cor_object__delete (
 in p_object_id integer
) returns integer
language 'plpgsql' as '
DECLARE
 v_rows_affected integer := 0;
BEGIN

 delete
  from
 cor_objects
  where
 object_id == p_object_id;

 RETURN;

END; -- create or replace function cordb.cor_object__delete
';"

create or replace function cordb.cor_identity__create (
 in out p_identity_id integer,
 in     p_ident_type_id integer,
 in     p_ident_domain_id integer,
 in     p_ident_name varchar,
 in     p_ident_login_name varchar,
 in     p_ident_password_hash varchar,
 in     p_ident_password_salt varchar,
 in     p_encryption_method_id integer,
 in     p_ident_descr text
) returns integer

language 'plpgsql' as '
DECLARE
  t_ident_type_id integer;
  t_ident_domain_id integer;
  t_encryption_method_id integer;
BEGIN

  if p_identity_id is null
   then
    select cordb.cor_object__create(
      null,
      4,      -- object_type = identity
      999,    -- object_owner = admin
      now(),  -- create_date
      now(),  -- change_date
      p_ident_descr -- object_descr
    ) into p_identity_id;
  end if;

  if p_ident_type_id is null
   then
    t_ident_type_id := 2; -- user
   else
    t_ident_type_id := p_ident_type_id;
  end if;

  if p_ident_domain_id is null
   then
    t_ident_domain_id := 1000; -- local domain
   else
    t_ident_domain_id := p_ident_domain_id;
  end if;

  if p_encryption_method_id is null
   then
    t_encryption_method_id := 2; -- sha1
   else
    t_encryption_method_id := p_encryption_method_id;
  end if;

  insert into cordb.cor_identities
   (
    identity_id,
    ident_type_id,
    ident_domain_id,
    ident_name,
    ident_login_name,
    ident_password_hash,
    ident_password_salt,
    encryption_method_id,
    ident_descr
  ) values (
    p_identity_id,
    t_ident_type_id,
    t_ident_domain_id,
    p_ident_name,
    p_ident_login_name,
    p_ident_password_hash,
    p_ident_password_salt,
    t_encryption_method_id,
    p_ident_descr
  );

  return;

END;
';












-- in     ident_type_id integer,
-- in     ident_domain_id integer,
-- in     ident_name varchar,
-- in     ident_login_name varchar,
-- in     ident_password_hash varchar,
-- in     ident_password_sale
