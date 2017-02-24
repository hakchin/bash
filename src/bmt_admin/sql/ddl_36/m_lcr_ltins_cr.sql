CREATE TABLE m_lcr_ltins_cr
(
  plyno character varying(16) NOT NULL, -- ���ǹ�ȣ
  cnrdt date, -- �������
  cr_yymm character(6), -- �����
  fnl_cr_stcd character(10), -- �����������ڵ�
  fnl_cr_st_chdt date, -- ���������º�������
  fnl_dt_cr_stcd character(10), -- �������ΰ������ڵ�
  fnl_pym_seq numeric(5), -- ��������ȸ��
  fnl_pym_yymm character(6), -- �������Գ��
  ce_evmm numeric(5), -- ��������
  ce_seq numeric(10), -- ����ȸ��
  ply_lvl_flgcd character(10), -- ���Ƿ��������ڵ�
  ins_imcd character(10), -- ���������ڵ�
  gdcd character(10), -- ��ǰ�ڵ�
  prm_str_flgcd character(10), -- ����ᱸ�������ڵ�
  ins_st date, -- ����ñ�
  ins_st_yymm character(6), -- ����ñ���
  ins_clstr date, -- ��������
  ins_clstr_yymm character(6), -- ����������
  t1_prm numeric(15), -- 1ȸ�����
  ins_days numeric(5), -- �����ϼ�
  holo_sign_yn character(1), -- ���ʼ�����
  dv_yn character(1), -- ��翩��
  pym_trm numeric(3), -- ���ԱⰣ
  rl_pym_trm numeric(3), -- �ǳ��ԱⰣ
  rl_nd_trm numeric(3), -- �Ǹ���Ⱓ
  pym_trm_flgcd character(10), -- ���ԱⰣ�����ڵ�
  pym_trmcd character(10), -- ���ԱⰣ�ڵ�
  ce_rowcd character(10), -- ���������ڵ�
  nd_flgcd character(10), -- ���ⱸ���ڵ�
  ndcd character(10), -- �����ڵ�
  cr_chncd character(10), -- ���ä���ڵ�
  plcd character(10), -- �÷��ڵ�
  bm_stfno character(7), -- BM������ȣ
  bkcd character(10), -- �����ڵ�
  bk_brcd character(10), -- ���������ڵ�
  bk_extn_qfp character(10), -- �������ڰ���
  mn_nrdps_ctmno character(9), -- ���Ǻ����ڰ���ȣ
  mn_nrdps_is_age numeric(3), -- ���Ǻ����ڰ��Կ���
  mn_nrdps_age numeric(3), -- ���Ǻ����ڿ���
  mn_nrdps_sexcd character(10), -- ���Ǻ����ڼ����ڵ�
  mn_nrdps_injr_rnkcd character(10), -- ���Ǻ����ڻ��ر޼��ڵ�
  mn_nrdps_jbcd character(10), -- ���Ǻ����������ڵ�
  dh_stfno character(7), -- ���������ȣ
  dh_usr_no character(7), -- ��޻���ι�ȣ
  ce_bz_part_flgcd character(10), -- ���������ι������ڵ�
  ce_hdqt_orgcd character(7), -- �������α���ڵ�
  ce_br_orgcd character(7), -- ������������ڵ�
  ce_bzp_orgcd character(7), -- ���������ұ���ڵ�
  ce_tm_orgcd character(7), -- ����������ڵ�
  ce_stfno character(7), -- ����������ȣ
  ce_usrno character(7), -- ��������ι�ȣ
  cer_stf_flgcd character(10), -- ���������������ڵ�
  spccf_cr_yn character(1), -- Ư�ΰ�࿩��
  clm_yn character(1), -- �����
  clmct numeric(7), -- ���Ǽ�
  crt_ctm_tpcd character(10), -- ����ڰ������ڵ�
  crt_ctmno character(9), -- ����ڰ���ȣ
  crt_ctm_flgcd character(10), -- ����ڰ������ڵ�
  crrnm character varying(100), -- ����ڸ�
  crt_is_age numeric(3), -- ����ڰ��Կ���
  crt_sexcd character(10), -- ����ڼ����ڵ�
  crt_adr_sd character varying(30), -- ������ּҽõ�
  crt_adr_sgng character varying(30), -- ������ּҽñ���
  crt_ltrm_jbcd character(10), -- �������������ڵ�
  cm_mtdcd character(10), -- ���ݹ���ڵ�
  pym_cyccd character(10), -- �����ֱ��ڵ�
  rvi_yn character(1), -- ��Ȱ����
  ap_rato numeric(7,2), -- ��������
  pr_rato numeric(7,2), -- ��������
  crmrt_cr_yn character(1), -- ī�޸�Ʈ��࿩��
  self_cr_yn character(1), -- �ڱ��࿩��
  ta_cr_yn character(1), -- �̰���࿩��
  cprtb_admno character(10), -- ������������ȣ
  nsc_yn character(1), -- �迭�翩��
  ppr_plyno character varying(16), -- �������ǹ�ȣ
  cnn_cr_plyno character varying(16), -- �����ڵ������ǹ�ȣ
  vald_cr_yn character(1), -- ��ȿ��࿩��
  ar_flgcd character(10), -- ��ü�����ڵ�
  st_rato_kndcd character(10), -- �������������ڵ�
  nwcr_ctu_flgcd character(10), -- �Ű���ӱ����ڵ�
  cr_st_apdt date, -- �����½�������
  nwcr_scan_bj_yn character(1), -- �Ű�ེĵ��󿩺�
  nwcr_scan_cplt_yn character(1), -- �Ű�ེĵ�ϷῩ��
  nwcr_scan_cplt_dthms timestamp(0) without time zone, -- �Ű�ེĵ�Ϸ��Ͻ�
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (plyno);