-- ADDS FOREIGN KEY CONSTRAINT AFTER INITIAL CLASS OBJECT CREATED
-- 

-- Add a new CHECK CONSTRAINT to the table
ALTER TABLE cordb.cor_classes
 ADD CONSTRAINT cor_cla_class_id_fk 
  FOREIGN KEY (class_id) references cordb.cor_objects (object_id);

