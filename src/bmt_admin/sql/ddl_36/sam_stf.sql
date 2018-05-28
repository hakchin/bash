CREATE TABLE sam_stf
(
  stfno character(7) NOT NULL, -- ������ȣ
  stf_bz_stcd character(10) NOT NULL, -- �������������ڵ�
  stadt date NOT NULL, -- ��������
  rsno character varying(40) NOT NULL, -- �ֹι�ȣ
  nm character varying(100) NOT NULL, -- ����
  mail_id character varying(50), -- �̸��Ͼ��̵�
  mail_domn character varying(50), -- �̸��ϵ�����
  hmpag_adr character varying(100), -- Ȩ�������ּ�
  blog_adr character varying(100), -- ��α��ּ�
  bkcd character(10), -- �����ڵ�
  actno character varying(20), -- ���¹�ȣ
  actno_chdt date, -- ���¹�ȣ��������
  ntrdt date, -- �Ի�����
  retdt date NOT NULL, -- �������
  incb_rscd character(10), -- ���˻����ڵ�
  stf_flgcd character(10) NOT NULL, -- ���������ڵ�
  fnl_edbcd character(10), -- �����з��ڵ�
  hnor_cmp_stf_yn character(1), -- ��������������
  adm_orgn_wrk_strdt date, -- ���������ٹ���������
  adm_orgn_wrk_nddt date, -- ���������ٹ���������
  rl_brtyr_mndy character(8), -- �����������
  slcr_flgcd character(10), -- ���������ڵ�
  apo_flgcd character(10), -- ���˱����ڵ�
  crnt_orgcd character(7), -- �������ڵ�
  crnt_tm_orgcd character(7), -- ����������ڵ�
  adm_orgcd character(7), -- ��������ڵ�
  relco_stfno character(7), -- ����ȸ��������ȣ
  scil_crrcd character(10), -- ��ȸ����ڵ�
  photo_pth character varying(256), -- �������
  crnt_pst_apodt date, -- ����Ҽӹ߷�����
  bdtcd character(10), -- �����ڵ�
  bdt_apodt date, -- �����߷�����
  dtycd character(10), -- ��å�ڵ�
  dty_apodt date, -- ��å�߷�����
  ptncd character(10), -- �����ڵ�
  ptn_apodt date, -- �����߷�����
  clpcd character(10), -- �����ڵ�
  pays_cd character(10), -- ȣ���ڵ�
  grdpa_apodt date, -- ��ȣ�߷�����
  rtm_rscd character(10), -- ���������ڵ�
  wdg_yn character(1), -- ��ȥ����
  drve_lic_own_yn character(1), -- ���������������
  indc_stfno character(7), -- ��ġ��������ȣ
  indc_relcd character(10), -- ��ġ�ڰ����ڵ�
  atr_flgcd character(10), -- ��ġ�����ڵ�
  befo_stfno character(7), -- ����������ȣ
  adm_stfno character(7), -- ����������ȣ
  stfno_grtdt date, -- ������ȣ�ο�����
  intr_tpcd character(10), -- ���������ڵ�
  bz_atrcd character(10), -- �����Ӽ��ڵ�
  bz_atr_chdt date, -- �����Ӽ���������
  psn_grdcd character(10), -- ���ε���ڵ�
  psn_grd_grtdt date, -- ���ε�޺ο�����
  psn_grd_nddt date, -- ���ε����������
  bz_fml_qufcd character(10), -- ���������ڰ��ڵ�
  quf_dlgdt date, -- �ڰ���������
  bz_fml_tmnd_grdcd character(10), -- ���������������ڵ�
  quf_grd_chdt date, -- �ڰݵ�޺�������
  quf_grd_nddt date, -- �ڰݵ����������
  pstn_chccd character(10), -- �źк����ڵ�
  pstn_chcdt date, -- �źк�������
  club_mbr_grdcd character(10), -- Ŭ���������ڵ�
  club_mbr_grd_grtdt date, -- Ŭ�������޺ο�����
  club_mbr_grd_nddt date, -- Ŭ����������������
  trf_mncd character(10), -- ��������ڵ�
  attd_nd_timcd character(10), -- ��ټҿ�ð��ڵ�
  notb_own_yn character(1), -- ��Ʈ�ϼ�������
  onfml_pf_yn character(1), -- �Ѱ�����뿩��
  onfml_pf_grd_grdcd character(10), -- �Ѱ���������ڵ�
  onfml_pf_grd_grtdt date, -- �Ѱ�������޺ο�����
  onfml_pf_grd_nddt date, -- �Ѱ����������������
  atch_yn character(1), -- ���ӿ���
  atch_yn_chdt date, -- ���ӿ��κ�������
  agy_quf_grdcd character(10), -- �븮���ڰݵ���ڵ�
  agy_quf_grd_chdt date, -- �븮���ڰݵ�޺�������
  agy_pntcd character(10), -- �븮���ΰ��ڵ�
  agy_pntcd_chdt date, -- �븮���ΰ��ڵ庯������
  offc_accpt_flgcd character(10), -- �������뱸���ڵ�
  agynm character varying(100), -- �븮����
  pdtnm character varying(100), -- ��ǥ�ڸ�
  org_rgt_cmpcd character(10), -- �����ȸ���ڵ�
  cm_ap_gpcd character(10), -- ����������׷��ڵ�
  bzmno character(10), -- ����ڹ�ȣ
  admr_stfno character(7), -- ������������ȣ
  admr_apodt date, -- �����ڹ߷�����
  st_stfno character(7), -- ����������ȣ
  inp_usr_id character(7) NOT NULL, -- �Է»����id
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������id
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  aconm character varying(100), -- �����ָ�
  ltrm_aw_gpcd character(10), -- ������׷��ڵ�
  ltrm_aw_gp_chdt date, -- ������׷캯������
  fr_ntr_cmpcd character(10), -- �����Ի�ȸ���ڵ�
  fire_stfno character(7), -- ȭ��������ȣ
  brc_orgcd character(7), -- �������ڵ�
  crnt_brc_apodt date, -- ��������߷�����
  grpwr_us_yn character(1), -- �׷�����뿩��
  msngr_us_yn character(1), -- �޽�����뿩��
  bz_stch_rscd character(10), -- �������º�������ڵ�
  adm_agycd character(7), -- �����븮���ڵ�
  adm_agy_apodt date, -- �����븮���߷�����
  adm_stf_apodt date, -- ���������߷�����
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (stfno);