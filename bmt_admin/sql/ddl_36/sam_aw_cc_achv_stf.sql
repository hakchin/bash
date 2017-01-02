CREATE TABLE sam_aw_cc_achv_stf
(
  av_yymm character(6) NOT NULL, -- �������
  stfno character(7) NOT NULL, -- ������ȣ
  nm character varying(100) NOT NULL, -- ����
  apo_or_stbdt date NOT NULL, -- ����/��������
  apo_or_stb_mmthr numeric(5) NOT NULL, -- ����/��������
  fnl_cls_yn character(1) NOT NULL, -- ������������
  psgcd character(7), -- �Ҽӱ���ڵ�
  tm_orgcd character(7), -- ������ڵ�
  stf_flgcd character(10) NOT NULL, -- ���������ڵ�
  intr_tpcd character(10), -- ���������ڵ�
  bz_atrcd character(10), -- �����Ӽ��ڵ�
  stf_bz_stcd character(10), -- �������������ڵ�
  psn_grdcd character(10), -- ���ε���ڵ�
  bz_fml_qufcd character(10), -- ���������ڰ��ڵ�
  bz_fml_tmnd_grdcd character(10), -- ���������������ڵ�
  atch_yn character(1) NOT NULL, -- ���ӿ���
  agy_quf_grdcd character(10), -- �븮���ڰݵ���ڵ�
  agy_pntcd character(10), -- �븮���ΰ��ڵ�
  club_mbr_grdcd character(10), -- Ŭ���������ڵ�
  onfml_pf_grd_grdcd character(10), -- �Ѱ���������ڵ�
  tmr_mnth_cnv_hms numeric(3), -- TMR����ȭ�ð�
  bz_mmthr numeric(5), -- ��������
  stadt date, -- ��������
  psn_grd_grtdt date, -- ���ε�޺ο�����
  quf_dlgdt date, -- �ڰ���������
  quf_grd_chdt date, -- �ڰݵ�޺�������
  club_mbr_grd_grtdt date, -- Ŭ�������޺ο�����
  onfml_pf_grd_grtdt date, -- �Ѱ�������޺ο�����
  nwfac_grdcd character(10), -- ���ε���ڵ�
  inp_usr_id character(7) NOT NULL, -- �Է»����ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  ltrm_aw_gpcd character(10), -- ������׷��ڵ�
  org_vl_gp_flgcd character(10), -- ����򰡱׷챸���ڵ�
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (av_yymm, stfno);