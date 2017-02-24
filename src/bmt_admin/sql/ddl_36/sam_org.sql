CREATE TABLE sam_org
(
  orgcd character(7) NOT NULL, -- ����ڵ�
  orgnm character varying(100) NOT NULL, -- �����
  org_ennm character varying(100), -- ���������
  org_shtnm character varying(100) NOT NULL, -- ��������
  pstno character(6), -- �����ȣ
  sd character varying(30), -- �õ�
  sgng character varying(30), -- �ñ���
  twmd character varying(30), -- ���鵿
  ri_or_lrdlp character varying(50), -- ��/�뷮���ó
  dtadr character varying(100), -- ���ּ�
  org_flgcd character(10) NOT NULL, -- ��������ڵ�
  org_tpcd character(10) NOT NULL, -- ��������ڵ�
  org_spcd character(10) NOT NULL, -- ���Ư���ڵ�
  org_stcd character(10) NOT NULL, -- ��������ڵ�
  org_stb_rscd character(10) NOT NULL, -- ������������ڵ�
  org_stbdt date NOT NULL, -- �����������
  org_clo_rscd character(10), -- ����������ڵ�
  org_clodt date NOT NULL, -- ����������
  bkcd character(10), -- �����ڵ�
  actno character varying(20), -- ���¹�ȣ
  orghd_stfno character(7), -- �����������ȣ
  orghd_apodt date, -- �����߷�����
  ppr_orgcd character(7), -- ��������ڵ�
  rcapm_org_yn character(1) NOT NULL, -- �ⳳ�������
  rcapm_orgcd character(7), -- �ⳳ����ڵ�
  act_org_yn character(1) NOT NULL, -- ȸ��������
  act_orgcd character(7), -- ȸ�����ڵ�
  rv_org_yn character(1) NOT NULL, -- �����������
  rv_orgcd character(7), -- ��������ڵ�
  jrd_uofcd character(10), -- ���Ұ�û�ڵ�
  crp_eqdtx_pymbj_yn character(1), -- ���αյ����ֹμ����δ�󿩺�
  insbz_lictx_pymbj_yn character(1), -- ��������㼼���δ�󿩺�
  pdwkp_txpym_bj_yn character(1), -- ����һ���Ҽ����δ�󿩺�
  ofwk_stf_apo_yn character(1), -- ���������߷ɿ���
  bz_strdt date, -- ������������
  tm_kndcd character(10), -- �������ڵ�
  vl_gp_flgcd character(10), -- �򰡱׷챸���ڵ�
  mncs_gp_flgcd character(10), -- ���׷챸���ڵ�
  are_flgcd character(10), -- ���������ڵ�
  org_rl_flgcd character(10) NOT NULL, -- ������������ڵ�
  trn_tm_flgcd character(10), -- �����������ڵ�
  inp_usr_id character(7) NOT NULL, -- �Է»����ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  fr_rgt_cmpcd character(10), -- ���ʵ��ȸ���ڵ�
  fire_orgcd character(7), -- ȭ�����ڵ�
  vl_adm_stfno character(7), -- �򰡰���������ȣ
  vl_adm_stf_apodt date, -- �򰡰��������߷�����
  vl_ppr_orgcd character(7), -- �򰡻�������ڵ�
  ref_it character varying(100), -- �����׸�
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (orgcd);