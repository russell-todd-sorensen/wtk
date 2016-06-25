-- =========================================
-- Create table cor_encryption_methods
-- =========================================

CREATE TABLE cordb.cor_encryption_methods
(
 method_id int
  CONSTRAINT cor_enc_method_id_pk PRIMARY KEY
  CONSTRAINT cor_enc_method_id_nn NOT NULL,
 method_name varchar(128)
  CONSTRAINT cor_enc_method_name_un UNIQUE
  CONSTRAINT cor_enc_method_name_nn NOT NULL,
 method_descr varchar(1024)
  CONSTRAINT cor_enc_method_descr_nn NOT NULL
);

insert into cordb.cor_encryption_methods values 
(1, 'None', 'No Encryption'),
(2, 'sha1', 'Secure Hash Algorithm 1 256 bits'),
(3, 'sha512', 'Secure Hash Algorithm 512 bits');

