-- =========================================
-- Create table cordb.cor_classes 
-- =========================================

CREATE TABLE cordb.cor_classes (
class_id int 
 constraint cor_cla_class_id_nn NOT NULL,
class_name varchar(128) 
 constraint cor_cla_class_name_nn NOT NULL
 constraint cor_cla_class_name_un unique,
class_descr varchar(1024) 
 constraint cor_cla_class_descr NOT NULL,
class_table varchar(64) 
 constraint cor_cla_class_table_nn NOT NULL,
    CONSTRAINT cor_cla_pk PRIMARY KEY (class_id)
);

insert into cordb.cor_classes values (1, 'Class', 'COR Classes Class', 'cor_classes');