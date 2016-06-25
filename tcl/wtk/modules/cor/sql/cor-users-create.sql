-- =========================================
-- Create table cor_users
-- =========================================

CREATE TABLE cordb.cor_users
(
 user_id int
  CONSTRAINT cor_usr_user_id_pk PRIMARY KEY
  CONSTRAINT cor_usr_user_id_fk references cordb.cor_identities(identity_id)
  CONSTRAINT cor_usr_user_id_nn NOT NULL, 
 user_type_id int 
  CONSTRAINT cor_usr_user_type_id_fk references cordb.cor_user_types(type_id)
  CONSTRAINT cor_usr_user_type_id_nn NOT NULL
  CONSTRAINT cor_usr_user_type_id_df DEFAULT 2
);
