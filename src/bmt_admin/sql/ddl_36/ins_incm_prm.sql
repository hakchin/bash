CREATE TABLE ins_incm_prm
(
  plyno character varying(16) NOT NULL, -- ���ǹ�ȣ
  incm_prm_cr_seqno numeric(5) NOT NULL, -- ���Ժ����߻�����
  pym_seq numeric(5) NOT NULL, -- ����ȸ��
  ndsno character(4), -- �輭��ȣ
  fnl_pym_yymm character(6), -- �������Գ��
  pyp_t_seq numeric(5), -- �г���ȸ��
  rp_prm numeric(15) NOT NULL, -- ���������
  ap_prm numeric(15) NOT NULL, -- ���뺸���
  dp_cascd character(10) NOT NULL, -- �Աݿ����ڵ�
  dp_dt_cascd character(10) NOT NULL, -- �Աݼ��ο����ڵ�
  rv_sbno character varying(20), -- ��������ȣ
  ccldt date, -- �������
  ccl_flgcd character(10), -- ��ұ����ڵ�
  ppdt date, -- �������
  pym_cyccd character(10), -- �����ֱ��ڵ�
  dh_stfno character(7) NOT NULL, -- ���������ȣ
  usrno character(7), -- ����ι�ȣ
  rp_admno character varying(20), -- ����������ȣ
  mncd character(10), -- ȭ���ڵ�
  fc_ap_prm numeric(17,2) NOT NULL, -- ��ȭ���뺸���
  usd_cv_ap_prm numeric(17,2) NOT NULL, -- ��ȭȯ�����뺸���
  xcrt_flgcd character(10), -- ȯ�������ڵ�
  fc_ap_xcrt numeric(12,6) NOT NULL, -- ��ȭ����ȯ��
  usd_ap_xcrt numeric(12,6) NOT NULL, -- ��ȭ����ȯ��
  fc_condt_t_prm numeric(17,2) NOT NULL, -- ��ȭ�����μ��Ѻ����
  condt_t_prm numeric(15) NOT NULL, -- �����μ��Ѻ����
  udrtk_tycd character(10), -- �μ������ڵ�
  otcm_mg_cmpcd character(10), -- Ÿ�簣��ȸ���ڵ�
  cnn_incm_prmcr_seqno numeric(5), -- ���ü��Ժ����߻�����
  hscs_hs_flgcd character(10), -- ����񰡰豸���ڵ�
  pyp_ad_cs numeric(17,2) NOT NULL, -- �г��߰����
  ba_cvr_prm numeric(15) NOT NULL, -- �⺻�㺸�����
  trt_prm numeric(15) NOT NULL, -- Ư�ຸ���
  cu_prm numeric(15) NOT NULL, -- ���������
  flpy_cvr_trt_prm numeric(15) NOT NULL, -- �Ͻó��㺸Ư�ຸ���
  dcbf_cu_prm numeric(15) NOT NULL, -- ���������������
  cu_nprm numeric(15) NOT NULL, -- �����������
  ppy_yn character(1), -- ��������
  ppy_dc_yn character(1), -- �������ο���
  nwfsq_flgcd character(10), -- �����������ڵ�
  auto_tf_dc_yn character(1), -- �ڵ���ü���ο���
  rvi_nt numeric(15) NOT NULL, -- ��Ȱ����
  du_ar_flgcd character(10), -- ���翬ü�����ڵ�
  prm_diss_yn character(1), -- �������ؿ���
  cvr_prm_disbj_yn character(1), -- �㺸�������ش�󿩺�
  dcbf_prm numeric(15) NOT NULL, -- �����������
  sb_flgcd character(10), -- ��ü�����ڵ�
  onds_dp_tpcd character(10), -- ���輭�Ա������ڵ�
  bkcd character(10), -- �����ڵ�
  bk_brcd character(10), -- ���������ڵ�
  bk_extn_qfp character(10), -- �������ڰ���
  bk_ipps character(10), -- �����Է���
  bnc_admr character(7), -- ��ī������
  pym_dudt date, -- ������������
  dbl_paym_yn character(1), -- ���ߺ��Կ���
  ac_tf_yn character(1), -- �渮��ü����
  uc_prm_yn character(1), -- �̼�����Ῡ��
  co_crt_rv_flgcd character(10), -- ��������ڼ��������ڵ�
  ikd_grpcd character(10) NOT NULL, -- �������ڵ�
  ccl_wdr_rtn_nt numeric(15) NOT NULL, -- ���öȸȯ������
  payao_yn character(1), -- ��úҿ���
  amt_ndscd character(10), -- �ݾ׹輭�ڵ�
  crt_relpc_seqno numeric(10), -- ����ڰ����ڼ���
  tincm_prm_cr_seqno numeric(5), -- ������Ժ����߻�����
  co_crt_yn character(1), -- ��������ڿ���
  pyno_whpy_bjno character(10), -- ���޹�ȣ/�����޴���ȣ
  cu_st_rpdt date, -- �������ؿ�������
  inp_usr_id character(7) NOT NULL, -- �Է»����ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  self_cr_yn character(1), -- �ڱ��࿩��
  rdch_cr_yn character(1), -- ��ȯ��࿩��
  rv_dldt date , -- ����ó������
  load_dthms timestamp(0) without time zone

)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno)