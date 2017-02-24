CREATE TABLE m_cod_bzus_ins_itm_csfcd
(
  ins_imcd character(10) NOT NULL, -- ���������ڵ�
  ins_imnm character varying(100), -- ���������
  gd_lclcd character(10), -- ��ǰ��з��ڵ�
  gd_lclnm character varying(100), -- ��ǰ��з���
  gd_mdccd character(10), -- ��ǰ�ߺз��ڵ�
  gd_mdcnm character varying(100), -- ��ǰ�ߺз���
  gd_smccd character(10), -- ��ǰ�Һз��ڵ�
  gd_smcnm character varying(100) ,-- ��ǰ�Һз���
  load_dthms timestamp(0) without time zone
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (ins_imcd);