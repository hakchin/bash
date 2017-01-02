CREATE TABLE m_sam_stf_srtr_orgn
(
  st_yymm character(6) NOT NULL, -- ���س��
  stfno character(7) NOT NULL, -- ������ȣ
  stfnm character varying(100), -- ������
  stf_ordcd character(7), -- ���������ڵ�
  rsno character varying(40), -- �ֹι�ȣ
  cmpcd character(10), -- ȸ���ڵ�
  cmpnm character varying(100) NOT NULL, -- ȸ���
  bzndp_orgcd character(7), -- ����α���ڵ�
  bzndp_orgnm character varying(100), -- ����α����
  hdqt_orgcd character(7), -- ���α���ڵ�
  hdqt_orgnm character varying(100), -- ���α����
  hdqt_org_ordr numeric(5), -- ���α������
  hdqt_org_stbdt date, -- ���α����������
  hdqt_org_clodt date, -- ���α���������
  hdqt_orghd_stfno character(7), -- ���α����������ȣ
  hdqt_orghd_nm character varying(100), -- ���α���强��
  spgp_orgcd character(7), -- �����ܱ���ڵ�
  spgp_orgnm character varying(100), -- �����ܱ����
  spgp_org_ordr numeric(5), -- �����ܱ������
  spgp_org_stbdt date, -- ���������������
  spgp_org_clodt date, -- ��������������
  spgp_orghd_stfno character(7), -- �����ܱ����������ȣ
  spgp_orghd_nm character varying(100), -- �����ܱ���强��
  br_orgcd character(7), -- ��������ڵ�
  br_orgnm character varying(100), -- ���������
  br_org_ordr numeric(5), -- �����������
  br_org_stbdt date, -- ���������������
  br_org_clodt date, -- ��������������
  br_orghd_stfno character(7), -- ���������������ȣ
  br_orghd_nm character varying(100), -- ��������强��
  bzp_orgcd character(7), -- �����ұ���ڵ�
  bzp_orgnm character varying(100), -- �����ұ����
  bzp_org_ordcd character(7), -- �����ұ�������ڵ�
  bzp_org_stbdt date, -- �����ұ����������
  bzp_org_clodt date, -- �����ұ���������
  bzp_orghd_stfno character(7), -- �����ұ����������ȣ
  bzp_orghd_nm character varying(100), -- �����ұ���强��
  bzp_org_tpcd character(10), -- �����ұ�������ڵ�
  bzp_org_tpnm character varying(100), -- �����ұ��������
  bzp_org_spcd character(10), -- �����ұ��Ư���ڵ�
  bzp_org_spnm character varying(100), -- �����ұ��Ư����
  stf_org_flgcd character(7), -- ������������ڵ�
  tm_orgcd character(7), -- ������ڵ�
  tmnm character varying(100), -- ����
  tm_org_ordcd character(7), -- ����������ڵ�
  tm_org_stbdt date, -- �������������
  tm_org_clodt date, -- ������������
  adm_stfno character(7), -- ����������ȣ
  adm_stfnm character varying(100), -- ����������
  adm_stf_ordcd character(10), -- �������������ڵ�
  adm_stf_ntrdt date, -- ���������Ի�����
  adm_stf_retdt date, -- ���������������
  usr_yn character(1), -- ����ο���
  prs_agyno character(7), -- ��ǥ�븮����ȣ
  prs_agynm character varying(100), -- ��ǥ�븮����
  prs_agy_ordcd character(10), -- ��ǥ�븮�������ڵ�
  prs_agy_ntrdt date, -- ��ǥ�븮���Ի�����
  prs_agy_retdt date, -- ��ǥ�븮���������
  plz_bzp_orgcd character(7), -- �����ڿ����ұ���ڵ�
  plz_bzp_orgnm character varying(100), -- �����ڿ����ұ����
  plz_bzp_org_ordr numeric(5), -- �����ڿ����ұ������
  plz_br_orgcd character(7), -- ��������������ڵ�
  plz_br_orgnm character varying(100), -- ���������������
  plz_br_org_ordr numeric(5), -- �����������������
  onl_bz_yn character(1), -- �¶��ο�������
  ntrdt date, -- �Ի�����
  retdt date, -- �������
  stfno_grtdt date, -- ������ȣ�ο�����
  stf_bz_stcd character(10), -- �������������ڵ�
  stadt date, -- ��������
  sexcd character(10), -- �����ڵ�
  indc_stfno character(7), -- ��ġ��������ȣ
  indc_relcd character(10), -- ��ġ�ڰ����ڵ�
  stf_flgcd character(10), -- ���������ڵ�
  apo_stb_mmthr numeric(5), -- ���˰�������
  atch_yn character(1), -- ���ӿ���
  bdtcd character(10), -- �����ڵ�
  dtycd character(10), -- ��å�ڵ�
  agy_quf_grdcd character(10), -- �븮���ڰݵ���ڵ�
  agy_pntcd character(10), -- �븮���ΰ��ڵ�
  pdtnm character varying(100), -- ��ǥ�ڸ�
  intr_tpcd character(10), -- ���������ڵ�
  bz_atrcd character(10), -- �����Ӽ��ڵ�
  psn_grdcd character(10), -- ���ε���ڵ�
  bz_fml_qufcd character(10), -- ���������ڰ��ڵ�
  bz_fml_tmnd_grdcd character(10), -- ���������������ڵ�
  pstn_chccd character(10), -- �źк����ڵ�
  club_mbr_grdcd character(10), -- Ŭ���������ڵ�
  onfml_pf_yn character(1), -- �Ѱ�����뿩��
  onfml_pf_grd_grdcd character(10), -- �Ѱ���������ڵ�
  sty_yn character(1), -- ��������
  clpo_bz_yn character(1), -- ���޿�������
  ltrm_actvt_yn character(1), -- ��Ⱑ������
  cr_actvt_yn character(1), -- �ڵ�����������
  gn_actvt_yn character(1), -- �Ϲݰ�������
  std_act_yn character(1), -- ǥ��Ȱ������
  std_actvt_flgcd character(10), -- ǥ�ذ��������ڵ�
  nwfac_grdcd character(10), -- ���ε���ڵ�
  pstn_chcdt date, -- �źк�������
  pstn_chc_yn character(1), -- �źк�������
  bz_tpcd character(10), -- ���������ڵ�
  gn_av_incld_yn character(1), -- �Ϲݽ������Կ���
  adm_stf_apodt date, -- ���������߷�����
  adm_agycd character(7), -- �����븮���ڵ�
  adm_agy_apodt date, -- �����븮���߷�����
  load_dthms timestamp(0) without time zone
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (st_yymm, stfno)