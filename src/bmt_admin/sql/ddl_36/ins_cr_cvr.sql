CREATE TABLE ins_cr_cvr
(
  plyno character varying(16) NOT NULL, -- ���ǹ�ȣ
  cvrcd character(8) NOT NULL, -- �㺸�ڵ�
  cvr_seqno numeric(5) NOT NULL, -- �㺸����
  ap_nddt date NOT NULL, -- ������������
  ap_strdt date NOT NULL, -- �����������
  ndsno character(4) NOT NULL, -- �輭��ȣ
  vald_nds_yn character(1) NOT NULL, -- ��ȿ�輭����
  nds_ap_str_dthms timestamp(0) without time zone NOT NULL, -- �輭���ν����Ͻ�
  nds_ap_nd_dthms timestamp(0) without time zone NOT NULL, -- �輭���������Ͻ�
  ikd_grpcd character(10) NOT NULL, -- �������ڵ�
  cvr_bj_flgcd character(10), -- �㺸��󱸺��ڵ�
  relpc_oj_seqno numeric(10), -- �����ڸ���������
  cvr_ba_trt_flgcd character(10) NOT NULL, -- �㺸�⺻Ư�౸���ڵ�
  cvr_stcd character(10) NOT NULL, -- �㺸�����ڵ�
  cvr_st_chdt date, -- �㺸���º�������
  isamt numeric(15) NOT NULL, -- ���Աݾ�
  nds_isamt numeric(15) NOT NULL, -- �輭���Աݾ�
  ba_prm numeric(15) NOT NULL, -- �⺻�����
  nds_ba_prm numeric(17,2) NOT NULL, -- �輭�⺻�����
  ap_prm numeric(15) NOT NULL, -- ���뺸���
  nds_ap_prm numeric(15) NOT NULL, -- �輭���뺸���
  scd_ins_trm_apprm numeric(15) NOT NULL, -- ��2����Ⱓ���뺸���
  ins_st date, -- ����ñ�
  ins_st_hms character(4), -- ����ñ�ð�
  ins_clstr date, -- ��������
  ins_clstr_hms character(4), -- ��������ð�
  self_chamt_mncd character(10), -- �ڱ�δ��ȭ���ڵ�
  self_chamt numeric(15) NOT NULL, -- �ڱ�δ�ݾ�
  agmt_aqr_rt_flgcd character(10), -- ����������������ڵ�
  nrdps_lvlcd character(10), -- �Ǻ����ڷ����ڵ�
  rk_tpcd character(8), -- ���������ڵ�
  chbf_ap_prm numeric(15) NOT NULL, -- ���������뺸���
  chaf_ap_prm numeric(15) NOT NULL, -- ���������뺸���
  pym_cyccd character(10), -- �����ֱ��ڵ�
  pym_trmcd character(10), -- ���ԱⰣ�ڵ�
  cvr_st_st_yymm character(6), -- �㺸�ñ���س��
  pym_xmp_yn character(1), -- ���Ը�������
  pym_xmp_str_yymm character(6), -- ���Ը������۳��
  rfamt_clc_ins_st date, -- �غ�ݾ׻�������ñ�
  rfamt_clc_ins_clstr date, -- �غ�ݾ׻�����������
  auto_rnw_av_yn character(1), -- �ڵ����Ű��ɿ���
  auto_rnw_cvr_cnldt date, -- �ڵ����Ŵ㺸��������
  cvr_fnl_pym_yymm character(6), -- �㺸�������Գ��
  cvr_fnl_pym_seq numeric(5), -- �㺸��������ȸ��
  nd_flgcd character(10), -- ���ⱸ���ڵ�
  nd numeric(3), -- ����
  ndcd character(10), -- �����ڵ�
  rl_nd_trm numeric(3), -- �Ǹ���Ⱓ
  pym_trm_flgcd character(10), -- ���ԱⰣ�����ڵ�
  pym_trm numeric(3), -- ���ԱⰣ
  rl_pym_trm numeric(3), -- �ǳ��ԱⰣ
  nrdps_ap_age numeric(3), -- �Ǻ��������뿬��
  bfrnw_cvrsn numeric(5), -- �������㺸����
  bfrnw_cvrcd character(10), -- �������㺸�ڵ�
  trt_preg_rnd_wkct numeric(2), -- Ư���ӽŰ���ּ�
  db_cvr_flgcd character(10), -- �ߺ��㺸�����ڵ�
  cvr_is_tpcd character(10), -- �㺸���������ڵ�
  sb_cscd character(10), -- ��ü����ڵ�
  isamt_cd character(10), -- ���Աݾ��ڵ�
  xp_dmamt numeric(17,5) NOT NULL, -- ������ؾ�
  md_dmamt numeric(17,5) NOT NULL, -- �������ؾ�
  trt_ap_cvr_prmsm numeric(17,2) NOT NULL, -- Ư������㺸������հ�
  sys_mpv_dt date, -- ������������
  trt_ap_cvrcd character(10), -- Ư������㺸�ڵ�
  mstr_car_plyno character varying(25), -- ������ī���ǹ�ȣ
  clmp1_is_amtcd character(10), -- 1���簡�Աݾ��ڵ�
  emeg_mvo_ce_stfno character(7), -- ����⵿����������ȣ
  emeg_mvo_cnrdt date, -- ����⵿�������
  de_sel_obs_flgcd character(10), -- ����������ر����ڵ�
  itm_cvr_rk_rnk character(10), -- ǰ��㺸����޼�
  imu_trmcd character(10), -- ��å�Ⱓ�ڵ�
  agr_rt numeric(12,6) NOT NULL, -- ��������
  absc_trm_flgcd character(10), -- ����Ⱓ�����ڵ�
  agr_rest_trmcd character(10), -- ���������Ⱓ�ڵ�
  isamt_spc character varying(300), -- ���Աݾ׳���
  esrct numeric(2), -- ȣ���μ�
  bd_dlbr_rpbl_btpcd character(10), -- ��ü���ع��å�Ӿ����ڵ�
  woncr_cv_self_chamt numeric(15) NOT NULL, -- ��ȭȯ���ڱ�δ�ݾ�
  dc_rt numeric(12,6) NOT NULL, -- ��������
  act_or_actct numeric(4), -- ����/���¼�
  frc_rt_ap_yn character(1), -- �����������뿩��
  ad_self_chamt numeric(17,2) NOT NULL, -- �߰��ڱ�δ�ݾ�
  prgcs_prt_yn character(1), -- �������μ⿩��
  inp_usr_id character(7) NOT NULL, -- �Է»����ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  cvr_spqu_flgcd character(10), -- �㺸Ư�������ڵ�
  nds_prdt date, -- �輭��������
  afgst_prm_ccbj_yn character(1), -- ����ñ����ĺ��������󿩺�
  sep_cr_cn_yn character(1), -- �и�����ؾ࿩��
  flpy_cvrfs_sb_yn character(1), -- �Ͻó��㺸��ȸ��ü����
  rnw_nddt date, -- ������������
  rnw_cvr_nclm_dcamt numeric(15), -- ���Ŵ㺸��������αݾ�
  sustd_xc_rk_ndx numeric(5), -- ǥ����ü������������
  stdbd_prm numeric(15), -- ǥ��ü�����
  sustd_prm numeric(15), -- ǥ����ü�����
  dcamt numeric(15), -- ���αݾ�
  sustd_rwcvr_nclm_dcamt numeric(15), -- ǥ����ü���Ŵ㺸��������αݾ�
  stdbd_rwcvr_nclm_dcamt numeric(15), -- ǥ��ü���Ŵ㺸��������αݾ�
  load_dthms timestamp(0) without time zone

)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno)
