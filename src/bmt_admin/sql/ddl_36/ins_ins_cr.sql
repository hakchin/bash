CREATE TABLE ins_ins_cr
(
  plyno character varying(16) NOT NULL, -- ���ǹ�ȣ
  ap_nddt date NOT NULL, -- ������������
  ap_strdt date NOT NULL, -- �����������
  ndsno character(4) NOT NULL, -- �輭��ȣ
  vald_nds_yn character(1) NOT NULL, -- ��ȿ�輭����
  nds_ap_str_dthms timestamp(0) without time zone NOT NULL, -- �輭���ν����Ͻ�
  nds_ap_nd_dthms timestamp(0) without time zone NOT NULL, -- �輭���������Ͻ�
  fnl_cr_stcd character(10), -- �����������ڵ�
  fnl_cr_dt_stcd character(10), -- ������༼�λ����ڵ�
  fnl_cr_st_chdt date, -- ���������º�������
  cnrdt date, -- �������
  plno character varying(16), -- �����ȣ
  cgaf_ch_seqno numeric(5), -- �����ĺ������
  fnl_pym_seq numeric(5), -- ��������ȸ��
  fnl_pym_yymm character(6), -- �������Գ��
  ply_lvl_flgcd character(10) NOT NULL, -- ���Ƿ��������ڵ�
  gdcd character(10) NOT NULL, -- ��ǰ�ڵ�
  ikd_grpcd character(10) NOT NULL, -- �������ڵ�
  ins_imcd character(10), -- ���������ڵ�
  nw_rnw_flgcd character(10), -- �ű԰��ű����ڵ�
  apldt date, -- û������
  trm_sct_flgcd character(10), -- �Ⱓ���������ڵ�
  ins_st date NOT NULL, -- ����ñ�
  ins_st_hms character(4), -- ����ñ�ð�
  ins_clstr date NOT NULL, -- ��������
  ins_clstr_hms character(4), -- ��������ð�
  ins_days numeric(5), -- �����ϼ�
  condt_t_ap_prm numeric(15) NOT NULL, -- �����μ������뺸���
  pym_mtdcd character(10), -- ���Թ���ڵ�
  ce_rowcd character(10), -- ���������ڵ�
  ply_rc_mtdcd character(10), -- ���Ǽ��ɹ���ڵ�
  holo_sign_yn character(1), -- ���ʼ�����
  gr_cr_yn character(1), -- ��ü��࿩��
  cr_chncd character(10), -- ���ä���ڵ�
  cprtb_admno character(10), -- ������������ȣ
  cmpg_bj_yn character(1), -- ķ���δ�󿩺�
  nrdct numeric(9), -- �Ǻ����ڼ�
  udrtk_tycd character(10), -- �μ������ڵ�
  crycd character(10), -- ��������ڵ�
  otcm_mg_cmpcd character(10), -- Ÿ�簣��ȸ���ڵ�
  otcm_plyno character varying(25), -- Ÿ�����ǹ�ȣ
  otcm_ply_ssdt date, -- Ÿ�����ǹ�������
  agmt_aqr_rt_flgcd character(10), -- ����������������ڵ�
  nsc_yn character(1), -- �迭�翩��
  bk_admno character varying(20), -- ���������ȣ
  bk_brcd character(10), -- ���������ڵ�
  bk_extn_qfp character(10), -- �������ڰ���
  bk_ipps character(10), -- �����Է���
  hscs_hs_flgcd character(10), -- ����񰡰豸���ڵ�
  ps_cst_yn character(1), -- ����ǰ�ǿ���
  rt_aqr_rqno character varying(20), -- ���������û��ȣ
  onw_cr_flgcd character(10), -- �ű���౸���ڵ�
  rv_ccldt date, -- �����������
  fmlct numeric(5), -- ������
  bzcs_qtrt_ap_yn character(1), -- ��������������뿩��
  prort_shtm_flgcd character(10), -- ���Ҵܱⱸ���ڵ�
  same_ply_flgcd character(10), -- �������Ǳ����ڵ�
  dc_xc_ap_flgcd character(10), -- �����������뱸���ڵ�
  pypof_symb character(10), -- ���Ա���ȣ
  rglt_vltct numeric(7), -- �������ݰǼ�
  rglt_vlt_poct numeric(3), -- ������������
  rglt_vltcd character(10), -- ���������ڵ�
  is_crrcd character(10), -- ���԰���ڵ�
  spc_xccd character(10), -- Ư�������ڵ�
  dty_pym_mtdcd character(10), -- �ǹ����Թ���ڵ�
  pst_rpbl_is_yn character(1), -- ����å�Ӱ��Կ���
  gn_co_obj_flgcd character(10), -- �Ϲݰ������Ǳ����ڵ�
  co_obj_asno character varying(14), -- �������ǹ�����ȣ
  bfcr_iscmp character(2), -- ����డ��ȸ��
  bfcr_ikdcd character(2), -- ����ຸ���ڵ�
  bfcr_year character(2), -- ����࿬��
  bfcr_no character(10), -- ������ȣ
  bfcr_ins_st date, -- ����ຸ��ñ�
  bfcr_ins_clstr date, -- ����ຸ������
  bfcr_aprt numeric(12,6) NOT NULL, -- �����������
  dvpns_plyno character varying(16), -- ���߿����ǹ�ȣ
  dvpns_jbcd character(10), -- ���߿������ڵ�
  udrtk_gu_arecd character(10), -- �μ���ħ�����ڵ�
  udrtk_grdcd character(10), -- �μ�����ڵ�
  sng_cr_flgcd character(10), -- �ܵ���౸���ڵ�
  ins_itm_smccd character(10), -- ��������Һз��ڵ�
  fsti_rp_prm numeric(15) NOT NULL, -- ��ȸ���������
  dc_xc_grdcd character(10), -- ������������ڵ�
  a_sct_ct numeric(3), -- a�������
  b_sct_ct numeric(3), -- b�������
  bfcr_dc_xc_grdcd character(10), -- �����������������ڵ�
  dc_xc_same_grdyn character(1), -- �����������ϵ�޿���
  rpbl_ins_plyno character varying(16), -- å�Ӻ������ǹ�ȣ
  repy_nt_rcpdt date, -- ����������������
  repy_nt_rcp_seqno numeric(5), -- ����������������
  xacd character(10), -- ���������ڵ�
  xc_cyccd character(10), -- �����ֱ��ڵ�
  cr_tpcd character(10), -- ��������ڵ�
  hlt_ins_is_yn character(1), -- �ǰ����谡�Կ���
  unf_rt_ap_yn character(1), -- ���Ͽ������뿩��
  avg_age_flgcd character(10), -- ��տ��ɱ����ڵ�
  dpsrt numeric(12,6) NOT NULL, -- ��ġ��
  dpst_prm_cc_flgcd character(10), -- ��ġ�������ⱸ���ڵ�
  xc_prdy character(2), -- ���꿹����
  is_tpcd character(10), -- ���������ڵ�
  ssng_arecd character(10), -- ���������ڵ�
  ssst character varying(100), -- ������
  ssng_ojccd character(10), -- ��������ڵ�
  trf_ridcd character(10), -- ����¿뱸�ڵ�
  ssng_cmpnm character varying(100), -- ����ȸ���
  nrdps_adm_mtdcd character(10), -- �Ǻ����ڰ�������ڵ�
  stdsb_rk_grdcd character(10), -- �а��������ڵ�
  stdsb_flgcd character(10), -- �а������ڵ�
  rl_stdsb character varying(100), -- �����а�
  prctc_pln character varying(100), -- �ǽ�����
  prctc_nm character varying(100), -- �ǽ���
  prctc_mntct numeric(3), -- �ǽ�������
  dmgrt_md_cfcap_bzmno character(10), -- ��������������������ڹ�ȣ
  dmgrt_md_cfc_crpno character varying(13), -- ����������������ι�ȣ
  dmgrt_md_cfcap_yn character(1), -- ����������������뿩��
  fcntr_dmgrt numeric(12,6) NOT NULL, -- ��û�ڼ�����
  dmgrt_md_cfc numeric(12,6) NOT NULL, -- �������������
  fcntr_sclcd character(10), -- ��û�ڹ����ڵ�
  cc_prm numeric(15) NOT NULL, -- ���⺸���
  nkor_rs_yn character(1), -- �����ֹο���
  ins_rt_flgcd character(10), -- ������������ڵ�
  ap_cvr_flgcd character(10), -- ����㺸�����ڵ�
  chaf_annu_apprm numeric(17,2) NOT NULL, -- �����ĳⰣ���뺸���
  rt_aqr_unt_flgcd character(10), -- ����������������ڵ�
  rt_aqr_stncd character(10), -- ������������ڵ�
  bsns_chrps_stfno character(7), -- �������������ȣ
  intn_rltno character varying(30), -- ��ܿ����ȣ
  cstcp_flgcd character(10), -- �Ǽ��籸���ڵ�
  chr_admr_stfno character(7), -- ��������������ȣ
  nvgtn_arecd character(10), -- ���ر����ڵ�
  et_nvgtn_arenm character varying(200), -- ��Ÿ���ر�����
  condt_qtrt_frcap_yn character(1), -- �����μ��������������뿩��
  ss_plyct numeric(3), -- �������Ǽ�
  trspr_cmpnm character varying(100), -- �����ȸ���
  dstcd character(10), -- �Ÿ��ڵ�
  spcl_tr_dst numeric(7,2), -- Ư����۰Ÿ�
  tr_days numeric(5), -- ����ϼ�
  snddt date, -- �߼�����
  arvdt date, -- ��������
  lowt_prm_ap_yn character(1), -- ������������뿩��
  slfdt date, -- ��������
  outus_mncd character(10), -- ��¿�ȭ���ڵ�
  ivamt_prt_yn character(1), -- ���谡���μ⿩��
  bl_yn character(1), -- bl����
  vp_clm character(10), -- vp�÷�
  dc_mtdcd character(10), -- ��������ڵ�
  dvdld_ct numeric(5), -- ����Ƚ��
  xpipt_op_flgcd character(10), -- ������op�����ڵ�
  carg_dt_flgcd character(10), -- ���ϼ��α����ڵ�
  trt_yymm character(6), -- Ư����
  fltno character(8), -- ���ܹ�ȣ
  flt_dc_yn character(1), -- �������ο���
  shtm_xc_yn character(1), -- �ܱ���������
  annu_shtm_flgcd character(10), -- �����ܱⱸ���ڵ�
  op_crano character(8), -- op����ȣ
  op_cr_ch_seq numeric(3), -- op��ຯ��ȸ��
  op_cr_napc_yn character(1), -- op�������뿩��
  nv_ctmno character(9), -- �������ȣ
  nv_cprt_entp_seqno numeric(3), -- �������¾�ü����
  xc_ctmno character(9), -- �������ȣ
  xc_cprt_entp_seqno numeric(3), -- �������¾�ü����
  marne_onds_no character(9), -- �ػ󱸹輭��ȣ
  nvgtn_sct_dstcd character(10), -- ���ر����Ÿ��ڵ�
  inlwt_slng_yn character(1), -- ��������׿���
  cmpx_tr_yn character(1), -- ���տ�ۿ���
  prvsn_dcn_flgcd character(10), -- ����Ȯ�������ڵ�
  cr_objnm character varying(100), -- ��๰�Ǹ�
  pym_trm_flgcd character(10), -- ���ԱⰣ�����ڵ�
  pym_trm numeric(3), -- ���ԱⰣ
  pym_trmcd character(10), -- ���ԱⰣ�ڵ�
  rl_pym_trm numeric(3), -- �ǳ��ԱⰣ
  nd_flgcd character(10), -- ���ⱸ���ڵ�
  nd numeric(3), -- ����
  ndcd character(10), -- �����ڵ�
  rl_nd_trm numeric(3), -- �Ǹ���Ⱓ
  nd_rtamt_py_tpcd character(10), -- ����ȯ�ޱ����������ڵ�
  inr_ins_cr_strdt date, -- ���պ������������
  inr_ins_cr_nddt date, -- ���պ�������������
  pym_cyccd character(10), -- �����ֱ��ڵ�
  type_flgcd character(10), -- �������ڵ�
  dfr_trm numeric(3), -- ��ġ�Ⱓ
  mw_py_mtdcd character(10), -- �ߵ����޹���ڵ�
  rvi_nt numeric(15) NOT NULL, -- ��Ȱ����
  rvi_nt_crdt date, -- ��Ȱ���ڹ߻�����
  an_py_stdt date, -- �������޽ñ�����
  an_py_age numeric(3), -- �������޿���
  an_py_trm numeric(3), -- �������ޱⰣ
  annu_an_py_ct numeric(5), -- ������������Ƚ��
  an_pytcd character(10), -- �����������ڵ�
  an_py_girt numeric(12,6) NOT NULL, -- ��������ü����
  tx_pf_flgcd character(10), -- ���ݿ�뱸���ڵ�
  iht_yn character(1), -- ��ӿ���
  tx_pfamt numeric(15) NOT NULL, -- ���ݿ��ݾ�
  tx_pf_rgt_flgcd character(10), -- ���ݿ���ϱ����ڵ�
  tx_pf_cncd character(10), -- ���ݿ�������ڵ�
  tx_pf_cnldt date, -- ���ݿ����������
  tx_pf_gd_csfcd character(10), -- ���ݿ���ǰ�з��ڵ�
  cr_cvr_is_yn character(1), -- �����㺸���Կ���
  cv_yn character(1), -- ��ȯ����
  gr_cr_flgcd character(10), -- ��ü��౸���ڵ�
  gr_dscrt numeric(12,6) NOT NULL, -- ��ü������
  pym_xmp_stdt date, -- ���Ը����ñ�����
  avg_rt_ap_yn character(1), -- ��տ������뿩��
  man_avg_ap_age numeric(3), -- ����������뿬��
  fml_avg_ap_age numeric(3), -- ����������뿬��
  man_avg_injr_rnkcd character(10), -- ������ջ��ر޼��ڵ�
  fml_avg_injr_rnkcd character(10), -- ������ջ��ر޼��ڵ�
  man_avg_drve_tycd character(10), -- ������տ��������ڵ�
  fml_avg_drve_tycd character(10), -- ������տ��������ڵ�
  plcd character(10), -- �÷��ڵ�
  ibnf_py_tpcd character(10), -- ��������������ڵ�
  drve_tycd character(10), -- ���������ڵ�
  drve_cr_usecd character(10), -- ���������뵵�ڵ�
  embr_minsr_yn character(1), -- �¾����ǿ���
  sb_pym_rq_yn character(1), -- ��ü���Խ�û����
  befo_plyno character varying(16), -- �������ǹ�ȣ
  bdl_pym_yn character(1), -- �ϰ����Կ���
  gr_ctmno character(9), -- ��ü����ȣ
  ppr_plyno character varying(16), -- �������ǹ�ȣ
  fnl_dh_stfno character(7) NOT NULL, -- �������������ȣ
  gdxpn_ss_bj_yn character(1), -- ��ǰ���������󿩺�
  inp_usr_id character(7) NOT NULL, -- �Է»����id
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������id
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  self_cr_yn character(1), -- �ڱ��࿩��
  rdch_cr_yn character(1), -- ��ȯ��࿩��
  cr_info_cvap_yn character(1), -- ��������ο�����
  gdxpn_trnm_yn character(1), -- ��ǰ�������޿���
  nwcr_scan_bj_yn character(1), -- �Ű�ེĵ��󿩺�
  nwcr_scan_cplt_yn character(1), -- �Ű�ེĵ�ϷῩ��
  nwcr_scan_cplt_dthms timestamp(0) without time zone, -- �Ű�ེĵ�Ϸ��Ͻ�
  dc_st_flgcd character(10), -- ���α��ر����ڵ�
  gu_fire_gdcd character(10), -- ��ȭ���ǰ�ڵ�
  gu_fire_gdnm character varying(100), -- ��ȭ���ǰ��
  gu_plyno character varying(16), -- �����ǹ�ȣ
  rltn_plyno character varying(16), -- �������ǹ�ȣ
  xwpy_rtntm_ntpy_yn character(1), -- ������ȯ�޽��������޿���
  y3_clm_ct numeric(3), -- 3����Ƚ��
  apl_tycd character(10), -- û�������ڵ�
  sep_cr_flgcd character(10), -- �и���౸���ڵ�
  vlt_spc_xccd character(10), -- ����Ư�������ڵ�
  y1_clm_ct numeric(3), -- 1����Ƚ��
  y1_clm_yn character(1), -- 1��������
  ibnf_sb_pym_yn character(1), -- ����ݴ�ü���Կ���
  ibnf_sb_pym_st date, -- ����ݴ�ü���Խñ�
  rnw_nddt date, -- ������������
  sign_mtdcd character(10), -- �������ڵ�
  nd_sep_rtn_tycd character(10), -- �������ȯ�������ڵ�
  nd_sep_py_mtdcd character(10), -- ����������޹���ڵ�
  dc_plyno character varying(20), -- �������ǹ�ȣ
  load_dthms timestamp(0) without time zone


)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno)