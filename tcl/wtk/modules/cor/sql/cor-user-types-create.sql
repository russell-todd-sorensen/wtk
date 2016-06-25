-- =========================================
-- Create table cor_user_types
-- =========================================

CREATE TABLE cordb.cor_user_types
(
 type_id int
  CONSTRAINT cor_ust_type_id_pk PRIMARY KEY
  CONSTRAINT cor_ust_type_id_nn NOT NULL,
 type_name varchar(128)
  CONSTRAINT cor_ust_type_name_un UNIQUE
  CONSTRAINT cor_ust_type_name_nn NOT NULL,
 type_descr varchar(1024)
  CONSTRAINT cor_ust_type_descr_nn NOT NULL
);



insert into cordb.cor_user_types values 
(1,'admin','Administrative user'),
(2,'user','Normal User'),
(3,'guest','Guest User'),
(4,'disabled','Disabled User'),
(5,'deleted','Deleted User'),
(6,'suspicious','Suspicious User'),
(7,'temp','Temporary User'),
(10,'power','Power User'),
(11,'audit','Audit User'),
(12,'readonly','ReadOnly User');

