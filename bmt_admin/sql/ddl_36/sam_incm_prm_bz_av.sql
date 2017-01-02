CREATE TABLE sam_incm_prm_bz_av
(
  plyno character varying(16) NOT NULL, -- ���ǹ�ȣ
  incm_prm_cr_seqno numeric(5) NOT NULL, -- ���Ժ����߻�����
  cv_prm_sm numeric(15) NOT NULL, -- ȯ�꺸����հ�
  vl_prm numeric(15) NOT NULL, -- �򰡺����
  ce_awamt numeric(15) NOT NULL, -- ��������ݾ�
  ikd_grpcd character(10) NOT NULL, -- �������ڵ�
  ce_aw_pyrt numeric(5,2) NOT NULL, -- ��������������
  aw_spc_dl_yn character(1) NOT NULL, -- ���系��ó������
  aw_spc_dldt date NOT NULL, -- ���系��ó������
  aw_py_prdt date NOT NULL, -- �������޿�������
  prpn_aw_smamt numeric(15) NOT NULL, -- ��ʼ����հ�ݾ�
  ppdt date NOT NULL, -- �������
  gnte_cv_prm numeric(15) NOT NULL, -- ���强ȯ�꺸���
  cumt_cv_prm numeric(15) NOT NULL, -- ������ȯ�꺸���
  ltrm_mpy_cv_prm numeric(15) NOT NULL, -- ������ȯ�꺸���
  mn_awamt numeric(15) NOT NULL, -- ��������ݾ�
  cm_awamt numeric(15) NOT NULL, -- ���ݼ���ݾ�
  nw_ou_awamt numeric(15) NOT NULL, -- �űԼ�������ݾ�
  mn_ou_awamt numeric(15) NOT NULL, -- ������������ݾ�
  cu_cvrt numeric(5,2) NOT NULL, -- ����ȯ����
  gn_cvrt numeric(5,2) NOT NULL, -- ����ȯ����
  mn_aw_pyrt numeric(5,2) NOT NULL, -- ��������������
  cm_aw_pyrt numeric(5,2) NOT NULL, -- ���ݼ���������
  rpbl_cv_prm numeric(15) NOT NULL, -- å��ȯ�꺸���
  optn_cv_prm numeric(15) NOT NULL, -- ����ȯ�꺸���
  rpbl_xc_prm_1 numeric(15) NOT NULL, -- å�����꺸���1
  rpbl_xc_prm_2 numeric(15) NOT NULL, -- å�����꺸���2
  optn_xc_prm numeric(15) NOT NULL, -- �������꺸���
  rpbl_ins_pyrt_1 numeric(5,2) NOT NULL, -- å�Ӻ���������1
  rpbl_ins_pyrt_2 numeric(5,2) NOT NULL, -- å�Ӻ���������2
  optn_ins_pyrt numeric(5,2) NOT NULL, -- ���Ǻ���������
  rpbl_ins_awamt_1 numeric(15) NOT NULL, -- å�Ӻ������ݾ�1
  rpbl_ins_awamt_2 numeric(15) NOT NULL, -- å�Ӻ������ݾ�2
  optn_ins_awamt numeric(15) NOT NULL, -- ���Ǻ������ݾ�
  inp_usr_id character(7) NOT NULL, -- �Է»����id
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������id
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  cm_mdf_prm numeric(15), -- ���ݼ��������
  cm_cvrt numeric(5,2), -- ����ȯ����
  re_prm numeric(15), -- ���纸���
  re_cm numeric(17,2), -- ���������
  re_cmrt numeric(12,6), -- �����������
  o1_nwcr_mdf_prm numeric(15), -- 1���Ű����������
  o1_mn_aw_pyrt numeric(5,2), -- 1����������������
  o1_mn_awamt numeric(15), -- 1����������ݾ�
  o2_nwcr_mdf_prm numeric(15), -- 2���Ű����������
  o2_mn_aw_pyrt numeric(5,2), -- 2����������������
  o2_mn_awamt numeric(15), -- 2����������ݾ�
  cradm_mn_aw_pyrt numeric(5,2), -- ��������������������
  cradm_mn_awamt numeric(15), -- ��������������ݾ�
  sv_cradm_awamt numeric(15), -- �������������ݾ�
  load_dthms timestamp(0) without time zone

)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno, incm_prm_cr_seqno)