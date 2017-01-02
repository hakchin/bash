CREATE TABLE igd_gd_cvr_acm_rk
(
  acm_rkcd character(10) NOT NULL, -- ���������ڵ�
  gdcd character(10) NOT NULL, -- ��ǰ�ڵ�
  cvrcd character(8) NOT NULL, -- �㺸�ڵ�
  ap_nddt date NOT NULL, -- ������������
  ap_strdt date NOT NULL, -- �����������
  acm_mult numeric(10,5), -- �������
  inp_usr_id character(7) NOT NULL, -- �Է»����ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������ID
  mdf_dthms timestamp(0) without time zone NOT NULL ,-- �����Ͻ�
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (acm_rkcd, gdcd, cvrcd, ap_nddt, ap_strdt);