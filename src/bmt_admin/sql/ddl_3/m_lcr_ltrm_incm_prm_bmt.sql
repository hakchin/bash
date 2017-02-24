CREATE TABLE m_lcr_ltrm_incm_prm_bmt
(
  plyno character varying(16) NOT NULL, -- ���ǹ�ȣ
  incm_prm_cr_seqno numeric(5) NOT NULL, -- ���Ժ����߻�����
  ndsno character(4), -- �輭��ȣ
  ppdt date, -- �������
  pvl_yymm character(6), -- �����
  dh_bz_part_flgcd character(10), -- ��޿����ι������ڵ�
  dh_hdqt_orgcd character(7), -- ��޺��α���ڵ�
  dh_br_orgcd character(7), -- �����������ڵ�
  dh_bzp_orgcd character(7), -- ��޿����ұ���ڵ�
  dh_tm_orgcd character(7), -- ���������ڵ�
  dh_stfno character(7), -- ���������ȣ
  org_dh_stfno character(7), -- �����������ȣ
  admr_stfno character(7), -- ������������ȣ
  dh_stf_bz_stcd character(10), -- ����������������ڵ�
  dh_usr_no character(7), -- ��޻���ι�ȣ
  ctmno character(9), -- ����ȣ
  ctm_nm character varying(100), -- ������
  ctm_tpcd character(10), -- �������ڵ�
  gdcd character(10), -- ��ǰ�ڵ�
  nwfsq_flgcd character(10), -- �����������ڵ�
  rp_pth_flgcd character(10), -- ������α����ڵ�
  pym_dudt date, -- ������������
  pym_seq numeric(5), -- ����ȸ��
  pym_cyccd character(10), -- �����ֱ��ڵ�
  pym_tpcd character(10), -- ���������ڵ�
  ppy_tpcd character(10), -- ���������ڵ�
  ppy_flgcd character(10), -- ���������ڵ�
  flppy_yn character(1), -- �Ͻü�������
  nsc_yn character(1), -- �迭�翩��
  nsccd character(10), -- �迭���ڵ�
  cr_stcd character(10), -- �������ڵ�
  bkcd character(10), -- �����ڵ�
  bk_brcd character(10), -- ���������ڵ�
  bk_brnm character varying(100), -- ����������
  bk_extn_qfp character(10), -- �������ڰ���
  bnc_admr character(7), -- ��ī������
  dp_cascd character(10), -- �Աݿ����ڵ�
  dp_dt_cascd character(10), -- �Աݼ��ο����ڵ�
  onds_dp_tpcd character(10), -- ���輭�Ա������ڵ�
  sb_flgcd character(10), -- ��ü�����ڵ�
  mnt_flgcd character(10), -- ���������ڵ�
  incm_prm numeric(15), -- ���Ժ����
  ap_prm numeric(17,2), -- ���뺸���
  cu_prm numeric(15), -- ���������
  gn_prm numeric(15), -- ���庸���
  mpy_cv_prm numeric(17,2), -- ����ȯ�꺸���
  gnte_mpy_cvprm numeric(17,2), -- ���强����ȯ�꺸���
  cumt_mpy_cvprm numeric(17,2), -- ����������ȯ�꺸���
  gnte_cv_prm numeric(15), -- ���强ȯ�꺸���
  cumt_cv_prm numeric(15), -- ������ȯ�꺸���
  flpy_cvr_trt_prm numeric(15), -- �Ͻó��㺸Ư�ຸ���
  dcbf_prm numeric(15), -- �����������
  load_dthms timestamp(0) without time zone -- �����Ͻ�
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (plyno)