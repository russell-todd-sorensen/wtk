
CREATE TABLE cordb.cor_domains
(
 domain_id int
  CONSTRAINT cor_grp_domain_id_pk PRIMARY KEY
  CONSTRAINT cor_grp_domain_id_fd references cordb.cor_objects(object_id)
  CONSTRAINT cor_grp_domain_id_nn NOT NULL,
 domain_name varchar(128)
  CONSTRAINT cor_grp_domain_name_nn NOT NULL,
 domain_descr varchar(1024)
  CONSTRAINT cor_grp_domain_descr_nn NOT NULL
);
