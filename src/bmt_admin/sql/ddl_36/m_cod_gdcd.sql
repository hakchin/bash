CREATE TABLE m_cod_gdcd
(
  gdcd character(10) NOT NULL, -- ��ǰ�ڵ�
  gdnm character varying(100), -- ��ǰ��
  ins_imcd character(10) NOT NULL, -- ���������ڵ�
  sl_chncd character(10), -- �Ǹ�ä���ڵ�
  gd_ty_flgcd character(10), -- ��ǰ���±����ڵ�
  prm_str_flgcd character(10), -- ����ᱸ�������ڵ�
  dv_tpcd character(10), -- ��������ڵ�
  gd_sl_tpcd character(10), -- ��ǰ�Ǹ������ڵ�
  ikd_grpcd character(10) ,-- �������ڵ�
  load_dthms timestamp(0) without time zone
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (gdcd);