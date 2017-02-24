CREATE TABLE m_cod_cvrcd
(
  cvrcd character(8) NOT NULL, -- �㺸�ڵ�
  cvrnm character varying(100), -- �㺸��
  cvr_lvl_1_cd character(10), -- �㺸����1�ڵ�
  cvr_lvl_1_nm character varying(100), -- �㺸����1��
  cvr_lvl_2_cd character(10), -- �㺸����2�ڵ�
  cvr_lvl_2_nm character varying(100), -- �㺸����2��
  cvr_lvl_3_cd character(10), -- �㺸����3�ڵ�
  cvr_lvl_3_nm character varying(100), -- �㺸����3��
  cvr_lvl_4_cd character(10), -- �㺸����4�ڵ�
  cvr_lvl_4_nm character varying(100), -- �㺸����4��
  load_dthms timestamp(0) without time zone
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (cvrcd);