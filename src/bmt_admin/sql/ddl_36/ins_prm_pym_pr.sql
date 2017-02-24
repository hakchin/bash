CREATE TABLE ins_prm_pym_pr
(
  plyno character varying(16) NOT NULL, -- ���ǹ�ȣ
  pym_seq numeric(5) NOT NULL, -- ����ȸ��
  crt_relpc_seqno numeric(10) NOT NULL, -- ����ڰ����ڼ���
  mncd character(10) NOT NULL, -- ȭ���ڵ�
  ap_nddt date NOT NULL, -- ������������
  ap_strdt date NOT NULL, -- �����������
  ndsno character(4) NOT NULL, -- �輭��ȣ
  vald_nds_yn character(1) NOT NULL, -- ��ȿ�輭����
  nds_ap_str_dthms timestamp(0) without time zone NOT NULL, -- �輭���ν����Ͻ�
  nds_ap_nd_dthms timestamp(0) without time zone NOT NULL, -- �輭���������Ͻ�
  ikd_grpcd character(10) NOT NULL, -- �������ڵ�
  ba_cvr_prm numeric(15) NOT NULL, -- �⺻�㺸�����
  trt_prm numeric(15) NOT NULL, -- Ư�ຸ���
  cu_prm numeric(15) NOT NULL, -- ���������
  flpy_cvr_trt_prm numeric(15) NOT NULL, -- �Ͻó��㺸Ư�ຸ���
  dcbf_cu_prm numeric(15) NOT NULL, -- ���������������
  dcbf_flpy_cvrtr_prm numeric(15) NOT NULL, -- �������Ͻó��㺸Ư�ຸ���
  t1_prm numeric(15) NOT NULL, -- 1ȸ�����
  cumny_sb_prm numeric(15) NOT NULL, -- �����ݴ�ü�����
  ap_prm numeric(17,2) NOT NULL, -- ���뺸���
  dcbf_prm numeric(15) NOT NULL, -- �����������
  woncr_cv_ap_prm numeric(15) NOT NULL, -- ��ȭȯ�����뺸���
  condt_t_prm numeric(17,2) NOT NULL, -- �����μ��Ѻ����
  woncv_condt_t_prm numeric(15) NOT NULL, -- ��ȭȯ������μ��Ѻ����
  thcpq_ap_prm numeric(17,2) NOT NULL, -- �������뺸���
  thcpq_woncv_ap_prm numeric(15) NOT NULL, -- ���п�ȭȯ�����뺸���
  nds_ap_prm numeric(17,2) NOT NULL, -- �輭���뺸���
  woncv_nds_ap_prm numeric(15) NOT NULL, -- ��ȭȯ��輭���뺸���
  pym_prdt date, -- ���Կ�������
  dcndt date, -- Ȯ������
  hg_pym_perd date, -- �ְ��Ա���
  pyp_rt numeric(12,6) NOT NULL, -- �г�����
  incm_prm_cr_seqno numeric(5), -- ���Ժ����߻�����
  prm_flgcd character(10), -- ����ᱸ���ڵ�
  nds_prm_yn character(1), -- �輭����Ῡ��
  xwpy_amt numeric(15) NOT NULL, -- �������ݾ�
  pym_pr_stcd character(10), -- ���Կ��������ڵ�
  pym_cyccd character(10), -- �����ֱ��ڵ�
  cu_nprm numeric(15) NOT NULL, -- �����������
  xcrt numeric(12,6) NOT NULL, -- ȯ��
  dmpdt date, -- �ְ�����
  npy_cnldt date, -- �̳���������
  wrdmp_snddt date, -- �ְ��߼�����
  inp_usr_id character(7) NOT NULL, -- �Է»����ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  prm_dcamt numeric(15) NOT NULL, -- ��������αݾ�
  load_dthms timestamp(0) without time zone


)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno, pym_seq)