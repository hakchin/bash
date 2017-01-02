CREATE TABLE cls_ltrm_mnrt
(
  cls_yymm character(6) NOT NULL, -- �������
  plyno character varying(16) NOT NULL, -- ���ǹ�ȣ
  cvrcd character(8) NOT NULL, -- �㺸�ڵ�
  cvr_seqno numeric(5) NOT NULL, -- �㺸����
  gdcd character(10), -- ��ǰ�ڵ�
  nrdps_dscno character varying(40), -- �Ǻ����ڽĺ���ȣ
  crt_dscno character varying(40), -- ����ڽĺ���ȣ
  cr_stcd character(10), -- �������ڵ�
  cr_dt_stcd character(10), -- ��༼�λ����ڵ�
  ins_st date, -- ����ñ�
  ins_clstr date, -- ��������
  fnl_pym_yymm character(6), -- �������Գ��
  pym_cyccd character(10), -- �����ֱ��ڵ�
  pym_ct numeric(3), -- ����Ƚ��
  rnd_mc numeric(5), -- �������
  cu_prm numeric(15), -- ���������
  gn_prm numeric(15), -- ���庸���
  ce_mpy_cvprm numeric(17,2), -- ��������ȯ�꺸���
  mn_mpy_cvprm numeric(17,2), -- ��������ȯ�꺸���
  ce_cvav_prm numeric(15), -- ����ȯ����������
  mn_cv_av_prm numeric(15), -- ����ȯ����������
  ce_bzp_orgcd character(7), -- ���������ұ���ڵ�
  ce_stfno character(7), -- ����������ȣ
  dh_bzp_orgcd character(7), -- ��޿����ұ���ڵ�
  dh_stfno character(7), -- ���������ȣ
  cm_mtdcd character(10), -- ���ݹ���ڵ�
  ce_bzp_lead_stfno character(7), -- ������������������ȣ
  ce_brma_stfno character(7), -- ����������������ȣ
  is_thtm_nrdps_age numeric(3), -- ���Դ���Ǻ����ڿ���
  cr_thtm_nrdps_age numeric(3), -- ������Ǻ����ڿ���
  nrdps_pstno character(6), -- �Ǻ����ڿ����ȣ
  nrdps_jbcd character(10), -- �Ǻ����������ڵ�
  is_thtm_crt_age numeric(3), -- ���Դ�ð���ڿ���
  cr_thtm_crt_age numeric(3), -- ����ð���ڿ���
  crt_pstno character(6), -- ����ڿ����ȣ
  crt_jbcd character(10), -- ����������ڵ�
  du_ar_flgcd character(10), -- ���翬ü�����ڵ�
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (cls_yymm, plyno, cvrcd, cvr_seqno)