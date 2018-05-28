CREATE TABLE sam_aw_cc_achv
(
  av_yymm character(6) NOT NULL, -- �������
  stfno character(7) NOT NULL, -- ������ȣ
  av_stdt date NOT NULL, -- ������������
  sty_yn character(1) NOT NULL, -- ��������
  ltrm_actvt_yn character(1), -- ��Ⱑ������
  cr_actvt_yn character(1), -- �ڵ�����������
  gn_actvt_yn character(1), -- �Ϲݰ�������
  std_actvt_flgcd character(10), -- ǥ�ذ��������ڵ�
  std_act_yn character(1), -- ǥ��Ȱ������
  cm_bz_days numeric(3), -- ��������ϼ�
  cm_inq_prse_days numeric(3), -- �����ȸ�����ϼ�
  cm_inq_prcv_days numeric(3), -- �����ȸ�����ϼ�
  cm_rtof_days numeric(3), -- ����ͼ��ϼ�
  cv_psct numeric(7,1) NOT NULL, -- ȯ���ο���
  achv_kndcd character(10) NOT NULL, -- ���������ڵ�
  ltrm_dcn_prm numeric(15) NOT NULL, -- ���Ȯ�������
  adpym_xcpt_ctu_prm numeric(15) NOT NULL, -- �߰��������ܰ�Ӻ����
  du_dcn_prm numeric(15) NOT NULL, -- ����Ȯ�������
  doamt numeric(15) NOT NULL, -- ������ݾ�
  t2_du_dcprm numeric(15) NOT NULL, -- 2ȸ����Ȯ�������
  t2_du_cmamt numeric(15) NOT NULL, -- 2ȸ������ݾ�
  ppy_xcpt_cm_av numeric(15) NOT NULL, -- �������ܼ��ݽ���
  ltrm_inr_ins_cmamt numeric(15) NOT NULL, -- ������պ�����ݾ�
  ltrm_inr_dcn_prm numeric(15) NOT NULL, -- ������պ���Ȯ�������
  ltrm_gnte_nwcct numeric(10) NOT NULL, -- ��⺸�强�Ű��Ǽ�
  ltrm_cumt_nwcct numeric(10) NOT NULL, -- ����������Ű��Ǽ�
  ltrm_gnte_nwcr_prm numeric(15) NOT NULL, -- ��⺸�强�Ű�ຸ���
  ltrm_cumt_nwcr_prm numeric(15) NOT NULL, -- ����������Ű�ຸ���
  ltrm_gnte_nwccv_av numeric(15) NOT NULL, -- ��⺸�强�Ű��ȯ�����
  ltrm_cumt_nwccv_av numeric(15) NOT NULL, -- ����������Ű��ȯ�����
  ltrm_gnte_nwmcv_prm numeric(15) NOT NULL, -- ��⺸�强�Ű�����ȯ�꺸���
  ltrm_cumt_nwmcv_prm numeric(15) NOT NULL, -- ����������Ű�����ȯ�꺸���
  ltrm_gnte_ctu_prm numeric(15) NOT NULL, -- ��⺸�强��Ӻ����
  ltrm_cumt_ctu_prm numeric(15) NOT NULL, -- �����������Ӻ����
  tmr_ltrm_vl_av numeric(15) NOT NULL, -- TMR����򰡽���
  ltrm_inr_insct numeric(10) NOT NULL, -- ������պ���Ǽ�
  ltrm_inr_ins_prm numeric(15) NOT NULL, -- ������պ��躸���
  ltinr_ins_nwmcv_prm numeric(15) NOT NULL, -- ������պ���Ű�����ȯ�꺸���
  ltinr_ins_nwccv_av numeric(15) NOT NULL, -- ������պ���Ű��ȯ�����
  vald_crgac_incm_prm numeric(15) NOT NULL, -- ��ȿ��ຸ�强������Ժ����
  vald_crsac_cv_av numeric(15) NOT NULL, -- ��ȿ������༺����ȯ�����
  o2mm_nmtn_cvav numeric(15) NOT NULL, -- 2����������ȯ�����
  nmtn_mpy_cv_prm numeric(15) NOT NULL, -- ����������ȯ�꺸���
  aw_pylts_gdct numeric(10) NOT NULL, -- �����������������ǰ�Ǽ�
  aw_pylts_gd_prm numeric(15) NOT NULL, -- �����������������ǰ�����
  ctu_ins_mpy_cvprm numeric(15) NOT NULL, -- ��Ӻ������ȯ�꺸���
  fsyr_ctupr_cv_av numeric(15) NOT NULL, -- �ʳ⵵��Ӻ����ȯ�����
  mn_aw_stamt numeric(15) NOT NULL, -- ����������ؾ�
  o16mm_ctu_cmamt numeric(15) NOT NULL, -- 16������Ӽ��ݾ�
  o25mm_ctu_cmamt numeric(15) NOT NULL, -- 25������Ӽ��ݾ�
  t4s_cv_av numeric(15) NOT NULL, -- 4ȸ��ȯ�����
  t7s_cv_av numeric(15) NOT NULL, -- 7ȸ��ȯ�����
  t13s_cv_av numeric(15) NOT NULL, -- 13ȸ��ȯ�����
  t20s_cv_av numeric(15) NOT NULL, -- 20ȸ��ȯ�����
  ltrm_tm_gd_prm numeric(15) NOT NULL, -- ���TM��ǰ�����
  ltrm_bncgd_prm numeric(15) NOT NULL, -- ����ī��ǰ�����
  rtman_xc_prm numeric(15) NOT NULL, -- �����������뺸���
  gn_ins_av numeric(15) NOT NULL, -- �Ϲݺ������
  gn_ins_cv_av numeric(15) NOT NULL, -- �Ϲݺ���ȯ�����
  carg_ins_u2030_prm numeric(15) NOT NULL, -- ���繰����2030��̸������
  carg_ins_a30c_prm numeric(15) NOT NULL, -- ���繰����30���̻����
  cmins_nwcr_av numeric(15) NOT NULL, -- �Ϲݺ���Ű�����
  gn_ins_nwcct numeric(10) NOT NULL, -- �Ϲݺ���Ű��Ǽ�
  cmins_hse_av numeric(15) NOT NULL, -- �Ϲݺ��谡�輺����
  cmins_spc_av numeric(15) NOT NULL, -- �Ϲݺ���Ư������
  cmins_carg_av numeric(15) NOT NULL, -- �Ϲݺ������Ͻ���
  cmins_fire_av numeric(15) NOT NULL, -- �Ϲݺ���ȭ�����
  cmins_vsl_av numeric(15) NOT NULL, -- �Ϲݺ��輱�ڽ���
  co_xcpt_cr_av numeric(15) NOT NULL, -- ���������ڵ�������
  cr_a_arect numeric(10) NOT NULL, -- �ڵ���A�����Ǽ�
  cr_a_are_av numeric(15) NOT NULL, -- �ڵ���A��������
  cr_b_arect numeric(10) NOT NULL, -- �ڵ���B�����Ǽ�
  cr_b_are_av numeric(15) NOT NULL, -- �ڵ���B��������
  cr_c_arect numeric(10) NOT NULL, -- �ڵ���C�����Ǽ�
  cr_c_areav numeric(15) NOT NULL, -- �ڵ���C��������
  cr_etct numeric(10) NOT NULL, -- �ڵ�����Ÿ�Ǽ�
  cr_et_av numeric(15) NOT NULL, -- �ڵ�����Ÿ����
  crcs_vlct numeric(10) NOT NULL, -- �ڵ������򰡰Ǽ�
  crcs_vl_av numeric(15) NOT NULL, -- �ڵ������򰡽���
  cr_vl_av numeric(15) NOT NULL, -- �ڵ����򰡽���
  cr_cash_vl_av numeric(15) NOT NULL, -- �ڵ��������򰡽���
  cr_crd_vl_av numeric(15) NOT NULL, -- �ڵ���ī���򰡽���
  cr_cv_av numeric(15) NOT NULL, -- �ڵ���ȯ�����
  cr_cash_cv_av numeric(15) NOT NULL, -- �ڵ�������ȯ�����
  cr_crd_cv_av numeric(15) NOT NULL, -- �ڵ���ī��ȯ�����
  cr_ppych_cv_av numeric(15) NOT NULL, -- �ڵ�����������ȯ�����
  cr_ppycr_cv_av numeric(15) NOT NULL, -- �ڵ�������ī��ȯ�����
  crmrt_xcpt_vl_av numeric(15) NOT NULL, -- ī�޸�Ʈ�����򰡽���
  crmrt_xcpt_cavl_av numeric(15) NOT NULL, -- ī�޸�Ʈ���������򰡽���
  crmrt_xcpt_crdvl_av numeric(15) NOT NULL, -- ī�޸�Ʈ����ī���򰡽���
  crmrt_xcpt_cv_av numeric(15) NOT NULL, -- ī�޸�Ʈ����ȯ�����
  crmrt_xcpt_cacv_av numeric(15) NOT NULL, -- ī�޸�Ʈ��������ȯ�����
  crmrt_xcpt_crdcv_av numeric(15) NOT NULL, -- ī�޸�Ʈ����ī��ȯ�����
  crmrt_xcpt_ppych_cvav numeric(15) NOT NULL, -- ī�޸�Ʈ���ܼ�������ȯ�����
  crmrt_xcpt_ppycr_cvav numeric(15) NOT NULL, -- ī�޸�Ʈ���ܼ���ī��ȯ�����
  cr_inr_insct numeric(10) NOT NULL, -- �ڵ������պ���Ǽ�
  cr_inr_ins_av numeric(15) NOT NULL, -- �ڵ������պ������
  cr_crn_nwct numeric(10) NOT NULL, -- �ڵ���ī���̼ǽű԰Ǽ�
  crd_afdm_ccamt numeric(15) NOT NULL, -- ī����û����Ҿ�
  crd_afdm_cclcs numeric(10) NOT NULL, -- ī����û����Ұ�
  cr_tot_av numeric(15) NOT NULL, -- �ڵ�����ü����
  cr_tot_nwct numeric(10) NOT NULL, -- �ڵ�����ü�ű԰Ǽ�
  cr_co_bzxcp_nwct numeric(10) NOT NULL, -- �ڵ��������������ܽű԰Ǽ�
  cr_std_nwct numeric(10) NOT NULL, -- �ڵ���ǥ�ؽű԰Ǽ�
  cr_tot_nwcct numeric(10) NOT NULL, -- �ڵ�����ü�Ű��Ǽ�
  cr_co_bzxcp_nwcct numeric(10) NOT NULL, -- �ڵ��������������ܽŰ��Ǽ�
  db_cr_cn_crct numeric(10) NOT NULL, -- �ߺ���������ڵ����Ǽ�
  nmtn_crnct numeric(10) NOT NULL, -- ������ī���̼ǰǼ�
  cr_slfud_crd_av numeric(15) NOT NULL, -- �ڵ��������μ�ī�����
  cr_slfud_cash_av numeric(15) NOT NULL, -- �ڵ��������μ����ݽ���
  cr_slfud_nwct numeric(10) NOT NULL, -- �ڵ��������μ��ű԰Ǽ�
  cr_rnwar_pt50x_av numeric(15) NOT NULL, -- �ڵ�������������50�ۼ�Ʈ�ʰ�����
  cr_rnwar_pt50l_av numeric(15) NOT NULL, -- �ڵ�������������50�ۼ�Ʈ���Ͻ���
  cr_slfud_rnw_crct numeric(15) NOT NULL, -- �ڵ��������μ����Ű��Ǽ�
  inp_usr_id character(7) NOT NULL, -- �Է»����ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  ltrm_gnte_snccv_av numeric(15) NOT NULL, -- ��⺸�强���νŰ��ȯ�����
  ltrm_cumt_snccv_av numeric(15) NOT NULL, -- ������������νŰ��ȯ�����
  ltrm_agins_cmamt numeric(15) NOT NULL, -- ����ѾƸ����պ�����ݾ�
  ltrm_agins_nwcct numeric(9) NOT NULL, -- ����ѾƸ����պ���Ű��Ǽ�
  ltrm_agins_nwcr_prm numeric(15) NOT NULL, -- ����ѾƸ����պ���Ű�ຸ���
  ltrm_agins_nwmcv_prm numeric(15) NOT NULL, -- ����ѾƸ����պ���Ű�����ȯ�꺸���
  ltrm_agins_nwccv_av numeric(15) NOT NULL, -- ����ѾƸ����պ���Ű��ȯ�����
  fsyr_ctupr_cvav_2 numeric(15) NOT NULL, -- �ʳ⵵��Ӻ����ȯ�����2
  cr_co_bzxcp_nwav numeric(15) NOT NULL, -- �ڵ��������������ܽűԽ���
  ltrm_bab_nwcct numeric(10) NOT NULL, -- ���B&B�Ű��Ǽ�
  ltrm_bab_nwccv_av numeric(15) NOT NULL, -- ���B&B�Ű��ȯ
  ltgnt_nwccv_1_av numeric(15) NOT NULL, -- ��⺸�强�Ű��ȯ��1����
  ltgnt_nwccv_2_av numeric(15) NOT NULL, -- ��⺸�强�Ű��ȯ��2����
  ltcmt_nwccv_1_av numeric(15) NOT NULL, -- ����������Ű��ȯ��1����
  ltcmt_nwccv_2_av numeric(15) NOT NULL, -- ����������Ű��ȯ��2����
  ltgnt_nwcpy_1_cvprm numeric(15) NOT NULL, -- ��⺸�强�Ű�����1ȯ�꺸���
  ltgnt_nwcpy_2_cvprm numeric(15) NOT NULL, -- ��⺸�强�Ű�����2ȯ�꺸���
  cm_ltrm_nwcr_cvav numeric(15) NOT NULL, -- ������Ű��ȯ�����
  aw_pylts_gd_cvav numeric(15) NOT NULL, -- �����������������ǰȯ�����
  gn_ins_rpamt_cvav numeric(15) NOT NULL, -- �Ϲݺ���å�Ӿ�ȯ�����
  gn_ins_ouq_cvav numeric(15) NOT NULL, -- �Ϲݺ��輺����ȯ�����
  ltrm_xc_cvav numeric(15) NOT NULL, -- �������ȯ�����
  ltgnt_nwccv_3_av numeric(15) NOT NULL, -- ��⺸�强�Ű��ȯ��3����
  ltgnt_nwccv_4_av numeric(15) NOT NULL, -- ��⺸�强�Ű��ȯ��4����
  ltgnt_nwccv_5_av numeric(15) NOT NULL, -- ��⺸�强�Ű��ȯ��5����
  ltcmt_nwccv_3_av numeric(15) NOT NULL, -- ����������Ű��ȯ��3����
  ltcmt_nwccv_4_av numeric(15) NOT NULL, -- ����������Ű��ȯ��4����
  ltcmt_nwccv_5_av numeric(15) NOT NULL, -- ����������Ű��ȯ��5����
  ltgnt_nwcpy_3_cvprm numeric(15) NOT NULL, -- ��⺸�强�Ű�����3ȯ�꺸���
  ltgnt_nwcpy_4_cvprm numeric(15) NOT NULL, -- ��⺸�强�Ű�����4ȯ�꺸���
  ltgnt_nwcpy_5_cvprm numeric(15) NOT NULL, -- ��⺸�强�Ű�����5ȯ�꺸���
  fsyr_ctupr_cvav_3 numeric(15), -- �ʳ⵵��Ӻ����ȯ�����3
  ltgnt_ppy_xcpt_cmav numeric(15), -- ��⺸�强�������ܼ��ݽ���
  ltcmt_ppy_xcpt_cmav numeric(15), -- ����������������ܼ��ݽ���
  cv_2_psct numeric(7,1), -- ȯ��2�ο���
  cr_vlct numeric(10), -- �ڵ����򰡰Ǽ�
  ltrm_prdt_grd character(10), -- �����꼺���
  pcked_prdt_grd character(10), -- �������꼺���
  fsyr_ctupr_cvav_4 numeric(15), -- �ʳ⵵��Ӻ����ȯ�����4
  ltrm_ctu_ct numeric(10), -- ����ӰǼ�
  fsyr_ctu_prm numeric(15), -- �ʳ⵵��Ӻ����
  cnst_cr_ct numeric(10), -- �����ð��Ǽ�
  load_dthms timestamp(0) without time zone

)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (av_yymm, stfno, av_stdt)