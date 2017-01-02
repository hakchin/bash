CREATE TABLE cls_cr_rnd_prm_mmcls
(
  cls_yymm character(6) NOT NULL, -- �������
  plyno character varying(16) NOT NULL, -- ���ǹ�ȣ
  cvrcd character(8) NOT NULL, -- �㺸�ڵ�
  cvr_seqno numeric(5) NOT NULL, -- �㺸����
  trtcd character(10) NOT NULL, -- Ư���ڵ�
  rnd_prm_seqno numeric(10) NOT NULL, -- �����������
  ce_stfno character(7), -- ����������ȣ
  incm_prm numeric(15), -- ���Ժ����
  rn_prm numeric(15), -- ���������
  cn_prm numeric(17,2), -- ���������
  ptrm_nelp_prm numeric(15), -- ����̰�������
  lltm_nelp_prm numeric(15), -- �ı�̰�������
  rnd_prm numeric(15), -- ��������
  psst_incm_prm numeric(17,2), -- �������ؼ��Ժ����
  psst_rn_prm numeric(17,2), -- �������ؿ��������
  psst_cn_prm numeric(17,2), -- �����������������
  psst_ptrm_nrnpr numeric(17,2), -- ������������̰�������
  psst_lltm_nrnpr numeric(17,2), -- ���������ı�̰�������
  psst_rnd_prm numeric(17,2), -- �������ذ�������
  rk_incm_prm numeric(15), -- ������Ժ����
  rk_rn_prm numeric(15), -- ������������
  rk_cn_prm numeric(15), -- �������������
  rk_ptrm_nelp_prm numeric(15), -- ��������̰�������
  rk_lltm_nelp_prm numeric(15), -- �����ı�̰�������
  rk_rnd_prm numeric(17,2), -- �����������
  psst_rk_incm_prm numeric(17,2), -- ��������������Ժ����
  psst_rk_rn numeric(17,2), -- ��������������������
  psst_rk_cn_prm numeric(17,2), -- ���������������������
  psst_rk_ptrm_nrnpr numeric(17,2), -- ����������������̰�������
  psst_rk_lltm_nrnpr numeric(17,2), -- �������������ı�̰�������
  psst_rk_rnd_prm numeric(17,2), -- �������������������
  iramt_ct numeric(5), -- �κ����
  onw_cr_flgcd character(10), -- �ű���౸���ڵ�
  ce_bf_cmpcd character(10), -- ������ȸ���ڵ�
  cvr_spqu_flgcd character(10), -- �㺸Ư�������ڵ�
  gn_co_obj_flgcd character(10), -- �Ϲݰ������Ǳ����ڵ�
  ins_itm_smccd character(10), -- ��������Һз��ڵ�
  ins_imcd character(10), -- ���������ڵ�
  gn_co_appr_flgcd character(10), -- �Ϲݰ������������ڵ�
  milg_cvrcd character(10), -- ���ϸ����㺸�ڵ�
  milg_is_amtcd character(10), -- ���ϸ������Աݾ��ڵ�
  milg_nelp_days numeric(5), -- ���ϸ����̰���ϼ�
  milg_lltm_nelp_prm numeric(15), -- ���ϸ����ı�̰�������
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (cls_yymm, plyno, cvrcd, cvr_seqno, trtcd, rnd_prm_seqno)
