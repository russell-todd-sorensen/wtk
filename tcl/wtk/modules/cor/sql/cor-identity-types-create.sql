-- =========================================
-- Create table cor_identity_types
-- =========================================

CREATE TABLE cordb.cor_identity_types
(
 type_id int 
  CONSTRAINT cor_itp_type_id_pk PRIMARY KEY
  CONSTRAINT cor_itp_type_id_nn NOT NULL,
 identity_type_name varchar(128)
  CONSTRAINT cor_itp_identity_type_name_un UNIQUE
  CONSTRAINT cor_itp_identity_type_name_nn NOT NULL,
 type_descr varchar(1024)
  CONSTRAINT cor_itp_type_descr NOT NULL
);

-- need to add identity types

insert into cordb.cor_identity_types values 
(1, 'basic','Basic Identity Type: no specialization'),
(2, 'user', 'User Type: maps to a real person'),
(3, 'group', 'Group Type: maps to a group of mixed identity types'),
(4, 'program', 'Program Type: maps to a program, application or process');

 