CREATE TABLE m_ccr_cr_ins_cr
(
  plyno character varying(16) NOT NULL, -- ���ǹ�ȣ
  cr_yymm character(6), -- �����
  cnrdt date, -- �������
  ins_itm_smccd character(10), -- ��������Һз��ڵ�
  ins_imcd character(10), -- ���������ڵ�
  gdcd character(10), -- ��ǰ�ڵ�
  gd_ty_flgcd character(10), -- ��ǰ���±����ڵ�
  nw_rnw_flgcd character(10), -- �ű԰��ű����ڵ�
  ins_st date, -- ����ñ�
  ins_st_yymm character(6), -- ����ñ���
  ins_clstr date, -- ��������
  ins_clstr_yymm character(6), -- ����������
  ins_days numeric(5), -- �����ϼ�
  ap_prm numeric(17,2), -- ���뺸���
  trt_ap_cvr_prmsm numeric(17,2), -- Ư������㺸������հ�
  dty_pym_mtdcd character(10), -- �ǹ����Թ���ڵ�
  optn_pym_mtdcd character(10), -- ���ǳ��Թ���ڵ�
  holo_sign_yn character(1), -- ���ʼ�����
  cr_chncd character(10), -- ���ä���ڵ�
  same_ply_flgcd character(10), -- �������Ǳ����ڵ�
  fnl_cr_stcd character(10), -- �����������ڵ�
  nrdps_ctmno character(9), -- �Ǻ����ڰ���ȣ
  nrdps_lclcd character(10), -- �Ǻ����ڴ�з��ڵ�
  nrdps_mdccd character(10), -- �Ǻ������ߺз��ڵ�
  nrdps_smccd character(10), -- �Ǻ����ڼҺз��ڵ�
  nrdps_age numeric(3), -- �Ǻ����ڿ���
  nrdps_sexcd character(10), -- �Ǻ����ڼ����ڵ�
  nrdps_jbcd character(10), -- �Ǻ����������ڵ�
  nrdps_cr_oper_tycd character(10), -- �Ǻ������������������ڵ�
  nrdps_adr_sd character varying(30), -- �Ǻ������ּҽõ�
  nrdps_adr_sgng character varying(30), -- �Ǻ������ּҽñ���
  nrdps_adr_twmd character varying(30), -- �Ǻ������ּ����鵿
  dh_stfno character(7), -- ���������ȣ
  dh_usr_no character(7), -- ��޻���ι�ȣ
  ce_stfno character(7), -- ����������ȣ
  ce_usrno character(7), -- ��������ι�ȣ
  cer_stf_flgcd character(10), -- ���������������ڵ�
  cprtb_admno character(10), -- ������������ȣ
  nsc_yn character(1), -- �迭�翩��
  fscr_yn character(1), -- ���������
  fscr_mntct numeric(4), -- ����ళ����
  fscr_days numeric(9), -- ������ϼ�
  clmct numeric(7), -- ���Ǽ�
  crt_ctmno character(9), -- ����ڰ���ȣ
  crt_age numeric(3), -- ����ڿ���
  crt_sexcd character(10), -- ����ڼ����ڵ�
  crt_adr_sd character varying(30), -- ������ּҽõ�
  crt_adr_sgng character varying(30), -- ������ּҽñ���
  crt_adr_twmd character varying(30), -- ������ּ����鵿
  crt_jbcd character(10), -- ����������ڵ�
  prort_shtm_flgcd character(10), -- ���Ҵܱⱸ���ڵ�
  rglt_vltcd character(10), -- ���������ڵ�
  is_crrcd character(10), -- ���԰���ڵ�
  spc_xccd character(10), -- Ư�������ڵ�
  gn_co_obj_flgcd character(10), -- �Ϲݰ������Ǳ����ڵ�
  bfcr_iscmp character(2), -- ����డ��ȸ��
  bfcr_ikdcd character(2), -- ����ຸ���ڵ�
  bfcr_year character(2), -- ����࿬��
  bfcr_no character(10), -- ������ȣ
  bfcr_ins_st date, -- ����ຸ��ñ�
  bfcr_ins_clstr date, -- ����ຸ������
  bfcr_aprt numeric(12,6), -- �����������
  udrtk_gu_arecd character(10), -- �μ���ħ�����ڵ�
  pl_udrtk_grdcd character(10), -- �����μ�����ڵ�
  cr_udrtk_grdcd character(10), -- ����μ�����ڵ�
  sng_cr_flgcd character(10), -- �ܵ���౸���ڵ�
  stsus_catcd character(10), -- ���������ڵ�
  cr_yytp character(4), -- ��������
  cramt numeric(15), -- ��������
  cr_vlamt_sm numeric(17,2), -- ���������հ�
  airb_ct numeric(3), -- ����鰹��
  dspl numeric(4), -- ��ⷮ
  cnmcd character varying(11), -- �����ڵ�
  crncd character varying(20), -- ������ȣ�ڵ�
  carno_hngl character varying(50), -- ������ȣ�ѱ�
  chsno_or_tmpno character varying(30), -- �����ȣ/�ӽù�ȣ
  ap_cr_tycd character(10), -- �����������ڵ�
  dma_foma_flgcd character(10), -- ����ܻ걸���ڵ�
  cr_usecd character(10), -- �����뵵�ڵ�
  cr_prd_cmpcd character(10), -- ��������ȸ���ڵ�
  rpbl_stdrt numeric(12,6), -- å��ǥ����
  optn_stdrt numeric(12,6), -- ����ǥ����
  rpbl_spc_xcrt numeric(12,6), -- å��Ư��������
  optn_spc_xcrt numeric(12,6), -- ����Ư��������
  rglt_vltrt numeric(12,6), -- ����������
  age_lmit_trtcd character(10), -- ��������Ư���ڵ�
  drv_lmit_trtcd character(10), -- ����������Ư���ڵ�
  cmps_tr_trtcd character(10), -- ������Ư���ڵ�
  spcrt_rkgd_yn character(1), -- Ư���������蹰����
  spcrt_spcl_eqp_yn character(1), -- Ư������Ư����ġ����
  spcrt_crty_opus_yn character(1), -- Ư�����������¿���뵵����
  spc_rt_airb_yn character(1), -- Ư����������鿩��
  spcrt_abs_bag_yn character(1), -- Ư������ABS��������
  spcrt_mch_eqp_yn character(1), -- Ư�����������ġ����
  spcrt_co_us_yn character(1), -- Ư������������뿩��
  spcrt_rbpeq_rt_yn character(1), -- Ư����������������ġ��������
  spcrt_auto_yn character(1), -- Ư������AUTO����
  owcr_is_yn character(1), -- �������Կ���
  owcr_isamt numeric(17,2), -- �������Աݾ�
  ppr_plyno character varying(16), -- �������ǹ�ȣ
  cnn_ltrm_plyno character varying(16), -- ����������ǹ�ȣ
  wcvis_yn character(1), -- ���㺸���Կ���
  onoff_nw_rnw_flgcd character(10), -- ONOFF�ű԰��ű����ڵ�
  co_obj_as_yn character(1), -- �������ǹ�������
  rgsct numeric(5), -- ������
  dvpns_plyno character varying(16), -- ���߿����ǹ�ȣ
  cr_grdcd character(10), -- ��������ڵ�
  dc_xc_grdcd character(10), -- ������������ڵ�
  onw_cr_flgcd character(10), -- �ű���౸���ڵ�
  y3_clm_ct numeric(3), -- 3����Ƚ��
  y1_clm_ct numeric(3), -- 1����Ƚ��
  y1_clm_yn character(1), -- 1��������
  plcd character(10) ,-- �÷��ڵ�
  load_dthms timestamp(0) without time zone

)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno);