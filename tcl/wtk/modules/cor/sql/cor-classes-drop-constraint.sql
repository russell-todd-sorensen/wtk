-- ADDS FOREIGN KEY CONSTRAINT AFTER INITIAL CLASS OBJECT CREATED
--

-- Add a new CHECK CONSTRAINT to the table
ALTER TABLE cordb.cor_classes
 DROP CONSTRAINT cor_cla_class_id_pk;