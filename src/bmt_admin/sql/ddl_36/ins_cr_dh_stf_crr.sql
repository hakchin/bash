CREATE TABLE ins_cr_dh_stf_crr
(
  plyno character varying(16) NOT NULL, -- ���ǹ�ȣ
  dh_stf_tpcd character(10) NOT NULL, -- ������������ڵ�
  dh_stfno character(7) NOT NULL, -- ���������ȣ
  ap_nddt date NOT NULL, -- ������������
  ap_strdt date NOT NULL, -- �����������
  ndsno character(4) NOT NULL, -- �輭��ȣ
  vald_nds_yn character(1) NOT NULL, -- ��ȿ�輭����
  nds_ap_str_dthms timestamp(0) without time zone NOT NULL, -- �輭���ν����Ͻ�
  nds_ap_nd_dthms timestamp(0) without time zone NOT NULL, -- �輭���������Ͻ�
  ikd_grpcd character(10), -- �������ڵ�
  tabf_dh_stfno character(7), -- �̰������������ȣ
  usrno character(7), -- ����ι�ȣ
  prs_dh_stf_yn character(1), -- ��ǥ�����������
  qtrt numeric(12,6) NOT NULL, -- ������
  ta_crno character varying(12), -- �̰��߻���ȣ
  pym_seq numeric(5), -- ����ȸ��
  bzcs_qtrt numeric(12,6) NOT NULL, -- �����������
  cnrdt date, -- �������
  inp_usr_id character(7) NOT NULL, -- �Է»����ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������ID
  mdf_dthms timestamp(0) without time zone NOT NULL ,-- �����Ͻ�
  load_dthms timestamp(0) without time zone
)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno)