CREATE TABLE m_org_mthy_bz_orgn
(
  cls_yymm character(6) NOT NULL, -- �������
  stfno character(7) NOT NULL, -- ������ȣ
  stfnm character varying(100), -- ������
  rsno character varying(40), -- �ֹι�ȣ
  nm character varying(100), -- ����
  bz_part_flgcd character(10), -- �����ι������ڵ�
  bz_part_flgnm character varying(100), -- �����ι����и�
  hdqt_orgcd character(7), -- ���α���ڵ�
  hdqnm character varying(100), -- ���θ�
  br_orgcd character(7), -- ��������ڵ�
  brnm character varying(100), -- ������
  bzp_orgcd character(7), -- �����ұ���ڵ�
  bzp_nm character varying(100), -- �����Ҹ�
  tm_orgcd character(7), -- ������ڵ�
  tmnm character varying(100), -- ����
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
  sty_yn character(1), -- ��������
  xstf_bz_flgcd character(10), -- ���������������ڵ�
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (cls_yymm, stfno)