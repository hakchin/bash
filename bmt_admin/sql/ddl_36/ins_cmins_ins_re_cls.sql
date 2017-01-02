CREATE TABLE ins_cmins_ins_re_cls
(
  cls_yymm character(6) NOT NULL, -- �������
  rn_rtro_cr_flgcd character(10) NOT NULL, -- ���������౸���ڵ�
  cls_bjno character varying(36) NOT NULL, -- ��������ȣ
  re_dlno character varying(11) NOT NULL, -- ����ó����ȣ
  pstcd character(10) NOT NULL, -- ����ó�ڵ�
  rincd character(10) NOT NULL, -- �纸�����ڵ�
  clsdt date, -- ��������
  plyno character varying(16), -- ���ǹ�ȣ
  gdcd character(10), -- ��ǰ�ڵ�
  ins_imcd character(10), -- ���������ڵ�
  udrtk_tycd character(10), -- �μ������ڵ�
  thcp_qtrt numeric(12,6) NOT NULL, -- ���������
  avg_rert numeric(12,6) NOT NULL, -- ���������
  ce_orgcd character(7), -- ��������ڵ�
  ce_stfno character(7), -- ����������ȣ
  dh_orgcd character(7), -- ��ޱ���ڵ�
  dh_stfno character(7), -- ���������ȣ
  chrps_orgcd character(7), -- ����ڱ���ڵ�
  chrps_stfno character(7), -- �����������ȣ
  chr_admr_orgcd character(7), -- �������ڱ���ڵ�
  chr_admr_stfno character(7), -- ��������������ȣ
  xi_py_flgcd character(10), -- �߻����ޱ����ڵ�
  t_re_ibnf numeric(15) NOT NULL, -- �����纸��ݾ�
  thcp_re_ibamt numeric(15) NOT NULL, -- ������纸��ݾ�
  t_re_ibnf_rtamt numeric(15) NOT NULL, -- �����纸���ȯ�ޱݾ�
  thcp_re_ibnf_rtamt numeric(15) NOT NULL, -- ������纸���ȯ�ޱݾ�
  t_re_py_rfamt numeric(15) NOT NULL, -- �����������غ�ݾ�
  thcp_re_py_rfamt numeric(15) NOT NULL, -- ������������غ�ݾ�
  t_re_nvcs numeric(15) NOT NULL, -- ������������
  thcp_re_nvcs numeric(15) NOT NULL, -- �������������
  t_re_nvcs_rfamt numeric(15) NOT NULL, -- �������������غ�ݾ�
  thcp_re_nvcs_rfamt numeric(15) NOT NULL, -- ��������������غ�ݾ�
  inp_usr_id character(7) NOT NULL, -- �Է»����id
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������id
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  dat_sourc_flgcd character(10) ,-- �����ͼҽ������ڵ�
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (cls_yymm, rn_rtro_cr_flgcd, cls_bjno, re_dlno, pstcd, rincd);