CREATE TABLE m_org_bz_orgn
(
  stfno character(7) NOT NULL, -- ������ȣ
  stfnm character varying(100), -- ������
  rsno character varying(40), -- �ֹι�ȣ
  nm character varying(100), -- ����
  bz_part_flgcd character(10), -- �����ι������ڵ�
  bz_part_flgnm character varying(100), -- �����ι����и�
  hdqt_orgcd character(7), -- ���α���ڵ�
  hdqnm character varying(100), -- ���θ�
  hdqt_org_ordr numeric(5), -- ���α������
  hdqt_org_spcd character(10), -- ���α��Ư���ڵ�
  hdqt_org_tpcd character(10), -- ���α�������ڵ�
  br_orgcd character(7), -- ��������ڵ�
  brnm character varying(100), -- ������
  br_org_ordr numeric(5), -- �����������
  br_org_spcd character(10), -- �������Ư���ڵ�
  br_org_tpcd character(10), -- ������������ڵ�
  bzp_orgcd character(7), -- �����ұ���ڵ�
  bzp_nm character varying(100), -- �����Ҹ�
  bzp_org_ordr numeric(5), -- �����ұ������
  bzp_org_spcd character(10), -- �����ұ��Ư���ڵ�
  bzp_org_tpcd character(10), -- �����ұ�������ڵ�
  tm_orgcd character(7), -- ������ڵ�
  tmnm character varying(100), -- ����
  tm_org_ordr numeric(5), -- ���������
  tm_org_spcd character(10), -- �����Ư���ڵ�
  tm_org_tpcd character(10), -- ����������ڵ�
  tm_kndcd character(10), -- �������ڵ�
  org_rgt_cmpcd character(10), -- �����ȸ���ڵ�
  stfno_grtdt date, -- ������ȣ�ο�����
  ntrdt date, -- �Ի�����
  retdt date, -- �������
  stadt date, -- ��������
  stf_bz_stcd character(10), -- �������������ڵ�
  sexcd character(10), -- �����ڵ�
  age numeric(3), -- ����
  wdg_yn character(1), -- ��ȥ����
  indc_stfno character(7), -- ��ġ��������ȣ
  indc_relcd character(10), -- ��ġ�ڰ����ڵ�
  stf_flgcd character(10), -- ���������ڵ�
  fnl_edbcd character(10), -- �����з��ڵ�
  apo_stb_mmthr numeric(5), -- ���˰�������
  adm_orgcd character(7), -- ��������ڵ�
  ppr_adm_orgcd character(7), -- ������������ڵ�
  atch_yn character(1), -- ���ӿ���
  bdtcd character(10), -- �����ڵ�
  dtycd character(10), -- ��å�ڵ�
  agy_quf_grdcd character(10), -- �븮���ڰݵ���ڵ�
  agy_pntcd character(10), -- �븮���ΰ��ڵ�
  admr_stfno character(7), -- ������������ȣ
  admr_stf_nm character varying(100), -- ��������������
  st_stfno character(7), -- ����������ȣ
  intr_tpcd character(10), -- ���������ڵ�
  ins_crr_btpcd character(10), -- �����¾����ڵ�
  scil_crrcd character(10), -- ��ȸ����ڵ�
  bz_atrcd character(10), -- �����Ӽ��ڵ�
  psn_grdcd character(10), -- ���ε���ڵ�
  bz_fml_tmnd_grdcd character(10), -- ���������������ڵ�
  bz_fml_qufcd character(10), -- ���������ڰ��ڵ�
  pstn_chccd character(10), -- �źк����ڵ�
  pstn_chcdt date, -- �źк�������
  rapo_yn character(1), -- �����˿���
  club_mbr_grdcd character(10), -- Ŭ���������ڵ�
  onfml_pf_yn character(1), -- �Ѱ�����뿩��
  adm_stfno character(7), -- ����������ȣ
  stf_rsdpl_sd character varying(30), -- �����������õ�
  stf_rsdpl_sgng character varying(30), -- �����������ñ���
  stf_rsdpl_twmd character varying(30), -- �������������鵿
  xstf_bz_flgcd character(10), -- ���������������ڵ�
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (stfno);