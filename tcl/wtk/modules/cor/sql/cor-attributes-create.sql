-- =========================================
-- Create table cor_attributes
-- =========================================

--DROP TABLE cordb.cor_attribute_types;

CREATE TABLE cordb.cor_attribute_types 
(
 attr_type_id int
  CONSTRAINT cor_cat_attr_id_pk PRIMARY KEY
  CONSTRAINT cor_cat_attr_id_nn NOT NULL,
 attr_type_name varchar(255)
    CONSTRAINT cor_cat_attr_type_name_nn NOT NULL,
    --CONSTRAINT cor_cat_attr_type_name_fk references pg_catalog.pg_type(typname),
 attr_sql_type varchar(255)
  CONSTRAINT cor_cat_attr_sql_type_nn NOT NULL,
 attr_type_descr varchar(255)
  CONSTRAINT cor_cat_attr_type_descr_nn NOT NULL
);

insert into cordb.cor_attribute_types values
(0,'boolean','boolean','dual value type'),
(1,'char','char','single character'),
(2,'smallint','int2','2 byte integer'),
(4,'integer','integer','-2 billion to 2 billion integer, 4 byte storage'),
(8,'bigint','bigint','~18 digit integer, 8-byte storage'),
(32,'varchar','varchar(32)','31 character string'),
(64,'name','name','63-character type for storing system identifiers'),
(100,'bpchar','char(100)','100 char blank padded string'),
(101,'timestamptz','timestamptz','Timestamp (date+time) with timezone'),
(102,'numeric','numeric(10,2)','numeric'),
(128,'varchar','varchar(128)','127 character string'),
(256,'varchar','varchar(256)','255 character string'),
(512,'varchar','varchar(512)','511 character string'),
(1024,'varchar','varchar(1024)','1023 character string'),
(5000,'text','text','variable length text string up to 64k');


CREATE TABLE cordb.cor_attributes
(
 attribute_id int
  CONSTRAINT cor_att_attribute_id_pk PRIMARY KEY
  CONSTRAINT cor_att_attribute_id_nn  NOT NULL
  CONSTRAINT cor_att_attribute_id_fk references cordb.cor_objects(object_id),
 class_id int 
  CONSTRAINT cor_att_class_id_fk references cordb.cor_classes
  CONSTRAINT cor_att_class_id_nn NOT NULL,
 attr_type_id int
  CONSTRAINT cor_att_attr_type_id_nn NOT NULL
  CONSTRAINT cor_att_attr_type_id_fk references cordb.cor_attribute_types(attr_type_id),
 attr_order int
  CONSTRAINT cor_att_attr_order_nn NOT NULL,
 attr_name varchar(128) 
  CONSTRAINT cor_att_attr_name_nn NOT NULL,	
 attr_comment text
  CONSTRAINT cor_att_attr_comment_nn NOT NULL,
 CONSTRAINT cor_att_class_id_attr_name_un UNIQUE (class_id, attr_name)
);
