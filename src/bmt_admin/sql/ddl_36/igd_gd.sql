CREATE TABLE igd_gd
(
  gdcd character(10) NOT NULL, -- ��ǰ�ڵ�
  ap_nddt date NOT NULL, -- ������������
  ap_strdt date NOT NULL, -- �����������
  ikd_grpcd character(10) NOT NULL, -- �������ڵ�
  ins_imcd character(10) NOT NULL, -- ���������ڵ�
  cla_lng_flgcd character(10) NOT NULL, -- ��������ڵ�
  gd_ty_flgcd character(10) NOT NULL, -- ��ǰ���±����ڵ�
  gd_slnm character varying(100) NOT NULL, -- ��ǰ�ǸŸ�
  gd_shtnm character varying(50), -- ��ǰ�����
  gd_kornm character varying(100), -- ��ǰ�ѱ۸�
  gd_ennm character varying(100), -- ��ǰ������
  gd_xpnm character varying(1000), -- ��ǰ����
  gd_per_yn character(1) NOT NULL, -- ��ǰ�ΰ�����
  gd_pernm character varying(100), -- ��ǰ�ΰ���
  gd_per_tpcd character(10), -- ��ǰ�ΰ������ڵ�
  gd_perdt date, -- ��ǰ�ΰ�����
  gd_sl_tpcd character(10), -- ��ǰ�Ǹ������ڵ�
  cr_opn_ba_hms character(4), -- ��ళ�ñ⺻�ð�
  cr_nd_ba_hms character(4), -- �������⺻�ð�
  fc_dh_yn character(1) NOT NULL, -- ��ȭ��޿���
  re_unt_flgcd character(10), -- ������������ڵ�
  pym_xmp_unt_flgcd character(10) NOT NULL, -- ���Ը������������ڵ�
  ppy_prm_prm_yn character(1), -- �����������뿩��
  ppy_prm_mxpsb_mc numeric(4), -- ����������ִ밡�ɿ���
  psncl_dbins_prm_yn character(1), -- ���κ��ߺ�������뿩��
  cv_ins_av_yn character(1), -- ��ȯ���谡�ɿ���
  auto_tf_dc_yn character(1), -- �ڵ���ü���ο���
  type_flgcd character(10), -- �������ڵ�
  type_cn_flgcd character(10), -- �����뱸���ڵ�
  spe_scr_rnw_yn character(1), -- ����ȭ�鰻�ſ���
  dv_tpcd character(10), -- ��������ڵ�
  prm_str_flgcd character(10), -- ����ᱸ�������ڵ�
  mw_rtamt_cr_flgcd character(10), -- �ߵ�ȯ�ޱݾ׹߻������ڵ�
  nd_rtamt_cr_yn character(1), -- ����ȯ�ޱݾ׹߻�����
  dgn_gd_yn character(1), -- ���ܻ�ǰ����
  auto_rnw_av_yn character(1), -- �ڵ����Ű��ɿ���
  prm_inp_flgcd character(10), -- ������Է±����ڵ�
  cu_prm_ocpym_yn character(1), -- �����������ó��Կ���
  ctu_crdtf_av_yn character(1), -- ���ī����ü���ɿ���
  cla_ln_av_yn character(1), -- ������Ⱑ�ɿ���
  sb_pym_flgcd character(10) NOT NULL, -- ��ü���Ա����ڵ�
  sb_pym_tpcd character(10), -- ��ü���������ڵ�
  age_cc_st_flgcd character(10), -- ���ɻ�����ر����ڵ�
  bz_mtdrp_csfcd character(10), -- ���������з��ڵ�
  is_pl_cht_wrtyn character(1), -- ���Լ�����Ʈ��¿���
  xtn_tpcd character(10), -- �Ҹ������ڵ�
  xtntm_rtamt_flgcd character(10), -- �Ҹ��ȯ�ޱݱ����ڵ�
  gr_is_flgcd character(10), -- ��ü���Ա����ڵ�
  gr_dc_av_yn character(1), -- ��ü���ΰ��ɿ���
  gr_mn_is_psct numeric(3), -- ��ü�ּҰ����ο���
  avg_rt_us_yn character(1), -- ��տ�����뿩��
  pr_es_prm_yn character(1) NOT NULL, -- ���Ǽ�����뿩��
  lowt_prm_mncd character(10), -- ���������ȭ���ڵ�
  lowt_prm numeric(17,2) NOT NULL, -- ���������
  cvr_prm_sgdlg_flgcd character(10), -- �㺸�����ܼ�ó�������ڵ�
  apprm_sglr_dl_flgcd character(10), -- ���뺸���ܼ�ó�������ڵ�
  sl_pl_adm_yn character(1), -- �Ǹ��÷���������
  cr_logfl_pst_info character varying(100), -- ���log������ġ����
  op_envr_cv_yn character(1) NOT NULL, -- ���ȯ����ȯ����
  ins_trm_bavl character(3), -- ����Ⱓ�⺻��
  ins_trm_lm character(3), -- ����Ⱓ�ѵ�
  pym_grc_trm character(3), -- ���������Ⱓ
  tx_pf_gd_csfcd character(10), -- ���ݿ���ǰ�з��ڵ�
  sl_pl_op_tpcd character(10), -- �Ǹ��÷���������ڵ�
  ply_out_tp_flgcd character(10), -- ����������������ڵ�
  type_ch_av_yn character(1), -- �����氡�ɿ���
  gd_dt_scr_yn character(1), -- ��ǰ����ȭ�鿩��
  dt_scr_id character(10), -- ����ȭ��id
  dc_ap_flgcd character(10), -- �������뱸���ڵ�
  dt_inpsc_xstn_yn character(1), -- ���Է�ȭ�����翩��
  dt_inpsc_id character(10), -- ���Է�ȭ��id
  mw_wdra_av_rt numeric(15) NOT NULL, -- �ߵ����Ⱑ�ɺ���
  mw_wdra_str_rndcd character(10), -- �ߵ�������۰���ڵ�
  mw_wdra_cr_cyccd character(10), -- �ߵ�����߻��ֱ��ڵ�
  mw_wdra_cr_caseq numeric(5), -- �ߵ�����߻��ֱⰡ��ȸ��
  dvpns_rpr_ikdcd character(10), -- ���߿��뺸�����ڵ�
  gd_exppr_out_yn character(1), -- ��ǰ�ؼ�����¿���
  marne_nelp_cal_metcd character(10), -- �ػ�̰��������ڵ�
  inp_usr_id character(7) NOT NULL, -- �Է»����id
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������id
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  pect_sl_mntr_bjpcd character(10), -- �����ǸŸ���͸�����ڵ�
  prm_inp_tpcd character(10), -- ������Է������ڵ�
  rntcl_dscrt_ap_yn character(1), -- ����Ⱓ�����������뿩��
  gds_mx_dc_lmrt numeric(5,2), -- ��ǰ���ִ������ѵ���
  prm_sb_pym_tpcd character(10), -- ������ü���������ڵ�
  prm_npy_sb_flgcd character(10), -- �����̳���ü�����ڵ�
  scr_idc_ordr numeric(5), -- ȭ��ǥ�ü���
  mx_mn_cc_tpcd character(10), -- �ִ��ּһ��������ڵ�
  rnwdc_fund_chek_yn character(1), -- �����������üũ����
  rmimc_rkrt_dcl_yn character(1), -- �Ǽ��Ƿ�����������ÿ���
  anul_bzprm_rt_adtm numeric(3), -- �ų⿵�����������ΰ��Ⱓ
  cc_xcpt_dlcd character(10), -- ���⿹��ó���ڵ�
  indpd_trt_tpcd character(10), -- ����Ư�������ڵ�
  indpd_trt_incld_yn character(1), -- ����Ư�����Կ���
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (gdcd, ap_nddt, ap_strdt);