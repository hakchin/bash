CREATE TABLE igd_gd_csf
(
  gd_csfcd character(10) NOT NULL, -- ��ǰ�з��ڵ�
  ppr_gd_csfcd character(10), -- ������ǰ�з��ڵ�
  gd_csfnm character varying(50) NOT NULL, -- ��ǰ�з���
  gd_csf_lvl numeric(1) NOT NULL, -- ��ǰ�з�����
  fnl_lvl_yn character(1) NOT NULL, -- ������������
  scr_idc_yn character(1) NOT NULL, -- ȭ��ǥ�ÿ���
  scr_idc_ordr numeric(5), -- ȭ��ǥ�ü���
  vald_strdt date NOT NULL, -- ��ȿ��������
  vald_nddt date NOT NULL, -- ��ȿ��������
  cnn_scr_gpcd character(10), -- ����ȭ��׷��ڵ�
  cnn_scr_dt_flgcd character(10), -- ����ȭ�鼼�α����ڵ�
  inp_usr_id character(7) NOT NULL, -- �Է»����ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  main_gd_yn character(1), -- �ֿ��ǰ����
  main_gd_ordr numeric(3), -- �ֿ��ǰ����
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (gd_csfcd);