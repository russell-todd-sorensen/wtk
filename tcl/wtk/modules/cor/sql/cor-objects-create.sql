-- =========================================
-- Create table cordb.cor_objects
-- =========================================

CREATE TABLE cordb.cor_objects (
 object_id int
  CONSTRAINT cor_obj_object_id_pk PRIMARY KEY
  CONSTRAINT cor_obj_object_id_nn NOT NULL,
 class_id int
  CONSTRAINT cor_obj_class_id_fk references cordb.cor_classes
  CONSTRAINT cor_obj_class_id_nn NOT NULL,
 obj_owner int
  CONSTRAINT cor_obj_owner_df default '100'
  CONSTRAINT cor_obj_owner_nn NOT NULL,
 create_date timestamptz
  CONSTRAINT cor_obj_create_date_df default now()
  CONSTRAINT cor_obj_create_date_nn NOT NULL,
 change_date timestamptz
  CONSTRAINT cor_obj_change_date_df default now()
  CONSTRAINT cor_obj_change_date_nn NOT NULL,
 object_descr text
  CONSTRAINT cor_obj_object_descr_nn NOT NULL
);

insert into cordb.cor_objects values (1, 1, 100, now(), now(), 'COR classes class');