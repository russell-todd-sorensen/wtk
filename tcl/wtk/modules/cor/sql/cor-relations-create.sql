-- =========================================
-- Create table cor_relations
-- =========================================

CREATE TABLE cordb.cor_relations
(
 subject_id int 
  CONSTRAINT cor_rel_subject_id_fk references cordb.cor_objects(object_id)
  CONSTRAINT cor_rel_subject_id_nn NOT NULL, 
 object_id int 
  CONSTRAINT cor_rel_object_id_fk references cordb.cor_objects(object_id)
  CONSTRAINT cor_rel_object_id_nn NOT NULL, 
 predicate_id int 
  CONSTRAINT cor_rel_predicate_id_fk references cordb.cor_objects(object_id)
  CONSTRAINT cor_rel_predicate_id_nn NOT NULL, 
 sort_order int 
  CONSTRAINT cor_rel_sort_order_df DEFAULT 1
  CONSTRAINT cor_rel_sort_order_nn NOT NULL,
 CONSTRAINT cor_rel_sub_obj_pred_id PRIMARY KEY (subject_id, object_id, predicate_id)
);

