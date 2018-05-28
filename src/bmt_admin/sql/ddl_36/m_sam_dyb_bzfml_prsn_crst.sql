CREATE TABLE m_sam_dyb_bzfml_prsn_crst
(
  av_yymm character(6) NOT NULL, -- �������
  av_stdt date NOT NULL, -- ������������
  stfno character(7) NOT NULL, -- ������ȣ
  apo_stbdt date, -- ���˰�������
  apo_stb_mmthr numeric(5), -- ���˰�������
  sty_yn character(1), -- ��������
  ltrm_actvt_yn character(1), -- ��Ⱑ������
  cr_actvt_yn character(1), -- �ڵ�����������
  gn_actvt_yn character(1), -- �Ϲݰ�������
  std_actvt_flgcd character(10), -- ǥ�ذ��������ڵ�
  std_act_yn character(1), -- ǥ��Ȱ������
  tmr_mnth_cnv_hms numeric(3), -- TMR����ȭ�ð�
  cm_bz_days numeric(3), -- ��������ϼ�
  ltrm_extn_av_yn character(1), -- �������������
  cr_extn_av_yn character(1), -- �ڵ�������������
  gn_extn_av_yn character(1), -- �Ϲ�����������
  edu_ntd_yymm character(6), -- �����԰����
  edu_crscd character(10), -- ���������ڵ�
  edu_prg_stcd character(10), -- ������������ڵ�
  edu_crs_vl_mmdgr numeric(5), -- ������������������
  ltrm_gnte_nwcct numeric(10), -- ��⺸�强�Ű��Ǽ�
  ltrm_cumt_nwcct numeric(10), -- ����������Ű��Ǽ�
  ltrm_gnte_nwcr_prm numeric(15), -- ��⺸�强�Ű�ຸ���
  ltrm_cumt_nwcr_prm numeric(15), -- ����������Ű�ຸ���
  ltrm_gnte_nwmcv_prm numeric(15), -- ��⺸�强�Ű�����ȯ�꺸���
  ltrm_cumt_nwmcv_prm numeric(15), -- ����������Ű�����ȯ�꺸���
  ltrm_gnte_nwccv_avamt numeric(17,2), -- ��⺸�强�Ű��ȯ������ݾ�
  ltrm_cumt_nwccv_avamt numeric(17,2), -- ����������Ű��ȯ������ݾ�
  ltrm_gnte_ctu_prm numeric(15), -- ��⺸�强��Ӻ����
  ltrm_cumt_ctu_prm numeric(15), -- �����������Ӻ����
  cr_tot_nwcct numeric(10), -- �ڵ�����ü�Ű��Ǽ�
  cr_tot_nwct numeric(10), -- �ڵ�����ü�ű԰Ǽ�
  cr_tot_avamt numeric(17,2), -- �ڵ�����ü�����ݾ�
  cr_cv_avamt numeric(17,2), -- �ڵ���ȯ������ݾ�
  gn_ins_nwcct numeric(10), -- �Ϲݺ���Ű��Ǽ�
  gn_ins_avamt numeric(17,2), -- �Ϲݺ�������ݾ�
  cmins_cv_avamt numeric(17,2), -- �Ϲݺ���ȯ������ݾ�
  ltrm_prdt_grd character(10), -- �����꼺���
  pcked_prdt_grd character(10), -- �������꼺���
  cr_vl_av numeric(15), -- �ڵ����򰡽���
  cr_cash_vl_av numeric(15), -- �ڵ��������򰡽���
  cr_crd_vl_av numeric(15), -- �ڵ���ī���򰡽���
  cr_vlct numeric(10), -- �ڵ����򰡰Ǽ�
  bz_mmthr numeric(5), -- ��������
  load_dthms timestamp(0) without time zone
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,  OIDS=FALSE)
DISTRIBUTED BY (av_yymm, av_stdt, stfno)