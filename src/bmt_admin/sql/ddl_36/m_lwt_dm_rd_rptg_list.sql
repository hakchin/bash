CREATE TABLE m_lwt_dm_rd_rptg_list
(
  vl_yymm character(6) NOT NULL, -- �򰡳��
  rcp_yymm character(6) NOT NULL, -- �������
  rcp_nv_seqno character(5) NOT NULL, -- �����������
  ins_imcd character(10) NOT NULL, -- ���������ڵ�
  dm_rd_rptg_seqno numeric(3) NOT NULL, -- ���ذ��Һ�������
  cvgcd character(10) NOT NULL, -- �㺸���ڵ�
  adm_chrps_stfno character(7) NOT NULL, -- ���������������ȣ
  adm_chrps_tm_orgcd character(7), -- ���������������ڵ�
  adm_chrps_orgcd character(7), -- ��������ڱ���ڵ�
  rptdt date, -- ��������
  prvdt date, -- ��������
  imu_tpcd character(10), -- ��å�����ڵ�
  plyno character varying(16), -- ���ǹ�ȣ
  clmdt date, -- �������
  rcpdt date, -- ��������
  cnrdt date, -- �������
  clm_carno character varying(20), -- ���������ȣ
  nrdnm character varying(100), -- �Ǻ����ڸ�
  clm_cvrnm character varying(100), -- ���㺸��
  siu_admno_yr character(4), -- SIU������ȣ�⵵
  siu_admno_seqno character(6), -- SIU������ȣ����
  siu_dl_rstcd character(10), -- SIUó������ڵ�
  ce_stfno character(7), -- ����������ȣ
  ce_bzp_orgcd character(7), -- ���������ұ���ڵ�
  ce_br_orgcd character(7), -- ������������ڵ�
  gn_co_obj_flgcd character(10), -- �Ϲݰ������Ǳ����ڵ�
  cvap_rcgnt_yn character(1), -- �ο��νĿ���
  detc_orgnm character varying(100), -- ��������
  cnbd numeric(5,2), -- �⿩��
  moff_vl_vwbl_poct numeric(3), -- ��������������
  dfwk_poct numeric(3), -- ���̵�����
  fdg_poct numeric(3), -- ��µ�����
  ins_crme_ct numeric(9), -- ������˰Ǽ�
  dm_rd_ct numeric(9), -- ���ذ��ҰǼ�
  ins_crme_sjtdn_ct numeric(5), -- ����������߰Ǽ�
  ibnf_rdamt numeric(15), -- ����ݰ��ұݾ�
  xp_dmamt numeric(15), -- ������رݾ�
  dm_rd_poct numeric(4,1), -- ���ذ�������
  ap_prm numeric(17,2), -- ���뺸���
  ins_crme_scr numeric(4,1), -- ������˰���
  ins_crme_dmk numeric(4,1), -- ������˰���
  ins_crme_t_poct numeric(4,1), -- �������������
  no1_relnm character varying(100), -- 1�������ڸ�
  no1_relpc_rsno character varying(40), -- 1���������ֹι�ȣ
  no1_nrdps_relnm character varying(50), -- 1���Ǻ����ڰ����
  no1_relpc_jbnm character varying(100), -- 1��������������
  no2_relnm character varying(100), -- 2�������ڸ�
  no2_relpc_rsno character varying(40), -- 2���������ֹι�ȣ
  no2_nrdps_relnm character varying(50), -- 2���Ǻ����ڰ����
  no2_relpc_jbnm character varying(100), -- 2��������������
  no3_relnm character varying(100), -- 3�������ڸ�
  no3_relpc_rsno character varying(40), -- 3���������ֹι�ȣ
  no3_nrdps_relnm character varying(50), -- 3���Ǻ����ڰ����
  no3_relpc_jbnm character varying(100), -- 3��������������
  n04_relnm character varying(100), -- 4�������ڸ�
  n04_relpc_rsno character varying(40), -- 4���������ֹι�ȣ
  n04_nrdps_relnm character varying(50), -- 4���Ǻ����ڰ����
  n04_relpc_jbnm character varying(100), -- 4��������������
  n05_relnm character varying(100), -- 5�������ڸ�
  n05_relpc_rsno character varying(40), -- 5���������ֹι�ȣ
  n05_nrdps_relnm character varying(50), -- 5���Ǻ����ڰ����
  n05_relpc_jbnm character varying(100), -- 5��������������
  fr_xiamt numeric(15), -- �����߻꺸��ݾ�
  remn_xiamt numeric(15), -- �ܿ��߻꺸��ݾ�
  ds_ibamt numeric(15), -- ��������ݾ�
  rcamt numeric(15), -- ȯ���ݾ�
  nvr_stfno character(7), -- ������������ȣ
  udwr_stfno character(7), -- �ɻ���������ȣ
  nvr_cnbd numeric(5,2), -- �����ڱ⿩��
  udwr_cnbd numeric(5,2), -- �ɻ��ڱ⿩��
  itg1_imu_yn character(1), -- 1������å����
  itg2_imu_yn character(1), -- 2������å����
  siu_nv_tpcd character(10), -- SIU���������ڵ�
  appr_dm_rd_ct numeric(10,2), -- �������ذ��ҰǼ�
  appr_ibnf_rdamt numeric(17,2), -- ��������ݰ��ұݾ�
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (vl_yymm, rcp_yymm, rcp_nv_seqno, ins_imcd, dm_rd_rptg_seqno, cvgcd, adm_chrps_stfno)