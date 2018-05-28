CREATE TABLE cus_ctm
(
  ctmno character(9) NOT NULL, -- ����ȣ
  ctm_dscno character varying(40), -- ���ĺ���ȣ
  hngl_ctmnm character varying(100) NOT NULL, -- �ѱ۰���
  eng_ctmnm character varying(100), -- ��������
  chnc_ctmnm character varying(100), -- �ѹ�����
  hngl_abrv_ctmnm character varying(100), -- �ѱ�������
  eng_abrv_ctmnm character varying(100), -- ����������
  ctm_tpcd character(10) NOT NULL, -- �������ڵ�
  cr_own_yn character(1), -- ������������
  drve_yn character(1), -- ��������
  ctm_dat_acq_ptncd character(10), -- ��������ȹ�����ڵ�
  frg_dlpl_flgcd character(10), -- ��ǰ���ó�����ڵ�
  fmllv_ctm_yn character(1), -- �������������
  hmpag_adr character varying(100), -- Ȩ�������ּ�
  cybmy character varying(50), -- ���̹��Ӵ�
  sms_rcv_yn character(1), -- sms���ſ���
  rlnm_ctfct_file_pth character varying(100), -- �Ǹ���ǥ���ϰ��
  cntrt_st_rq_yn character(1), -- ����������û����
  tl_rcv_yn character(1), -- ��ȭ���ſ���
  crdif_utl_agre_yn character(1), -- �ſ�����Ȱ�뵿�ǿ���
  mail_rcv_yn character(1), -- �̸��ϼ��ſ���
  rgbrd_flgcd character(10), -- ���ܱ������ڵ�
  mntr_bkcd character(10), -- �ְŷ������ڵ�
  mntr_bk_brcd character(10), -- �ְŷ����������ڵ�
  et_adr_flgcd character(10), -- ��Ÿ�ּұ����ڵ�
  cnn_cmpcd character(10), -- ����ȸ���ڵ�
  ctm_dscno_flgcd character(10), -- ���ĺ���ȣ�����ڵ�
  spcl_rel_ctm_yn character(1), -- Ư�������ڰ�����
  pdt_rsno character varying(40), -- ��ǥ���ֹι�ȣ
  pdtnm character varying(100), -- ��ǥ�ڸ�
  indpd_mrtmn_yn character(1), -- ���������ڿ���
  dflt_pt_yn character(1), -- ����ȯ�ڿ���
  dmrcy_518_injd_yn character(1), -- ����518�λ��ڿ���
  rltn_bzwpl_cd character(10), -- ���������ڵ�
  rltn_bzwpl_seqno numeric(5), -- �����������
  bzps_tpcd character(10), -- ����������ڵ�
  ntp_sclcd character(10), -- ����Ը��ڵ�
  bzps_bstnm character varying(100), -- ����ھ��¸�
  bzps_imnm character varying(100), -- ����������
  empct numeric(7), -- ��������
  slamt numeric(15) NOT NULL, -- �����
  capt numeric(15) NOT NULL, -- �ں���
  fnddt date, -- ��������
  clodt date, -- �������
  dlncd character(10), -- �ŷ����ڵ�
  bzwpl_own_yn character(1), -- ������������
  mn_pdt_out_pdtct numeric(7), -- �ִ�ǥ�ڿܴ�ǥ�ڼ�
  bdl_tf_pypsb_yn character(1), -- �ϰ���ü���ް��ɿ���
  std_ind_csfcd character(10), -- ǥ�ػ���з��ڵ�
  nty_tycd character(10), -- ��������ڵ�
  lstst_flgcd character(10), -- ���屸���ڵ�
  crpno character varying(13), -- ���ι�ȣ
  clgmm_flgcd character(10), -- ���������ڵ�
  gr_flgcd character(10), -- ��ü�����ڵ�
  gr_tpcd character(10), -- ��ü�����ڵ�
  bzmno character(10), -- ����ڹ�ȣ
  crp_tpcd character(10), -- ���������ڵ�
  wdg_yn character(1), -- ��ȥ����
  relgn_cd character(10), -- �����ڵ�
  fnl_edbcd character(10), -- �����з��ڵ�
  hndps_yn character(1), -- ����ο���
  hnd_grdcd character(10), -- ��ֵ���ڵ�
  hnd_grd_vald_trm character(8), -- ��ֵ����ȿ�Ⱓ
  hndnm character varying(100), -- ��ָ�
  hnd_grdpa_cd character(10), -- ��ֱ�ȣ�ڵ�
  ntn_mrtmn_yn character(1), -- ���������ڿ���
  rwxno character varying(20), -- ���ƹ�ȣ
  btplc_cd character(10), -- ������ڵ�
  grdu_sch character varying(50), -- ����б�
  slcr_flgcd character(10), -- ���������ڵ�
  rl_brtyr_mndy character(8), -- �����������
  rh_tycd character(10), -- rh�����ڵ�
  bldty_cd character(10), -- �������ڵ�
  wpcnm character varying(100), -- �����
  depnm character varying(100), -- �μ���
  ptn character varying(50), -- ����
  bdt character varying(50), -- ����
  jb_dt character varying(50), -- ������
  emp_tycd character(10), -- ��������ڵ�
  wrk_arecd character(10), -- �ٹ������ڵ�
  sexcd character(10), -- �����ڵ�
  ba_life_sadps_yn character(1), -- ���ʻ�Ȱ�����ڿ���
  smok_yn character(1), -- ������
  de_yn character(1), -- �������
  htn character varying(50), -- ����
  wot_yn character(1), -- �¹��̿���
  frg_rlnm_ctfct_flgcd character(10), -- �ܱ��νǸ���ǥ�����ڵ�
  ntlcd character(10), -- �����ڵ�
  pspno character varying(20), -- ���ǹ�ȣ
  jb_ch_seqno numeric(5), -- �����������
  jbcd character(10), -- �����ڵ�
  injr_rnkcd character(10), -- ���ر޼��ڵ�
  onw_jb_cnf_flgcd character(10), -- �ű�����Ȯ�α����ڵ�
  rltn_bzwpl_pstdt date, -- ��������Ҽ�����
  rltn_bzwpl_rgtr_flgcd character(10), -- �����������ڱ����ڵ�
  inp_usr_id character(7) NOT NULL, -- �Է»����id
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������id
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  psn_info_cvap_yn character(1), -- ���������ο�����
  rcmnm character varying(100), -- ��õ�θ�
  rcm_rsno character varying(40), -- ��õ���ֹι�ȣ
  dher_rcm_relcd character(10), -- �������õ�ΰ����ڵ�
  rlnm_cnf_flgcd character(10), -- �Ǹ�Ȯ�α����ڵ�
  ntclt_mail_rcv_yn character(1), -- �ȳ����̸��ϼ��ſ���
  bnnm character varying(300), -- ������
  bzfml_sms_lmit_yn character(1), -- ��������SMS���ѿ���
  cnv_hp_tmst_cd character(10) , -- ��ȭ����ð����ڵ�
  load_dthms timestamp(0) without time zone
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (ctmno);