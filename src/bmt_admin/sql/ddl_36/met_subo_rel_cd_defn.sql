CREATE TABLE met_subo_rel_cd_defn
(
  subo_rel_tpcd character(5) NOT NULL, -- ���Ӱ��������ڵ�
  lvl_1_dtcd character(10) NOT NULL, -- ����1�����ڵ�
  lvl_2_dtcd character(10) NOT NULL, -- ����2�����ڵ�
  lvl_3_dtcd character(10) NOT NULL, -- ����3�����ڵ�
  lvl_4_dtcd character(10) NOT NULL, -- ����4�����ڵ�
  lvl_5_dtcd character(10) NOT NULL, -- ����5�����ڵ�
  ap_nddt date NOT NULL, -- ������������
  ap_strdt date NOT NULL, -- �����������
  scr_idc_ordr numeric(5), -- ȭ��ǥ�ü���
  inp_usr_id character(7) NOT NULL, -- �Է»����ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (subo_rel_tpcd, lvl_1_dtcd, lvl_2_dtcd, lvl_3_dtcd, lvl_4_dtcd, lvl_5_dtcd, ap_nddt, ap_strdt);
