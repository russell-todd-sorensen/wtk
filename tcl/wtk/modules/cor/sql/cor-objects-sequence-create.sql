-- CREATE [ TEMPORARY | TEMP ] SEQUENCE name [ INCREMENT [ BY ] increment ]
--     [ MINVALUE minvalue | NO MINVALUE ] [ MAXVALUE maxvalue | NO MAXVALUE ]
--     [ START [ WITH ] start ] [ CACHE cache ] [ [ NO ] CYCLE ]
--     [ OWNED BY { table.column | NONE } ]

CREATE SEQUENCE cordb.cor_object_id_seq
    INCREMENT BY 1
    MINVALUE 1 MAXVALUE 2000000000
    -- CYCLE
    START WITH 10000000 -- 10million
    OWNED BY cordb.cor_objects.object_id;

--CREATE SEQUENCE cordb.test_seq
--    INCREMENT BY 1
--    MINVALUE 1 MAXVALUE 5
--    CYCLE
--    START WITH 2;
