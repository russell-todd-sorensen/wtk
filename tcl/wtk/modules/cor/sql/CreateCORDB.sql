-- =============================================
-- Create database template
-- =============================================
--CREATE DATABASE name
--    [ [ WITH ] [ OWNER [=] dbowner ]
--           [ TEMPLATE [=] template ]
--           [ ENCODING [=] encoding ]
--           [ TABLESPACE [=] tablespace ]
--           [ CONNECTION LIMIT [=] connlimit ] ]


CREATE DATABASE CORDB
  WITH OWNER = russell
       TEMPLATE = template1
       ENCODING = 'UTF-8';
