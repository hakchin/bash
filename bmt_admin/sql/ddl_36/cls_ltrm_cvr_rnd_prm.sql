CREATE TABLE cls_ltrm_cvr_rnd_prm
(
  cls_yymm character(6) NOT NULL, -- �������
  plyno character varying(16) NOT NULL, -- ���ǹ�ȣ
  nrdps_dscno character varying(40) NOT NULL, -- �Ǻ����ڽĺ���ȣ
  cvrcd character(8) NOT NULL, -- �㺸�ڵ�
  gdcd character(10), -- ��ǰ�ڵ�
  rp_prm numeric(15), -- ���������
  re_rk_prm numeric(15), -- �������躸���
  re_ad_prm numeric(15), -- ����ΰ������
  rn_rnd_prm numeric(15), -- ������������
  re_rnd_rk_prm numeric(15), -- ���������躸���
  re_rnd_ad_prm numeric(15), -- �������ΰ������
  rk_rnd_prm numeric(15), -- �����������
  ptrm_rn_idm_bnd numeric(15), -- ��������̰�������
  nxt_rn_nrnpr numeric(15), -- ��������̰�������
  ptrm_re_nrnpr numeric(15), -- ��������̰�������
  nxt_re_nrnpr numeric(15), -- ��������̰�������
  rk_prm numeric(15), -- ���躸���
  sv_prm numeric(15), -- ���ຸ���
  rn_netp_nwcrt numeric(15), -- ���������ĽŰ���
  rn_mncs numeric(15), -- ����������
  rn_cmlcs numeric(15), -- �������ݺ�
  re_netp_nwcrt numeric(15), -- ��������ĽŰ���
  re_mncs numeric(15), -- ����������
  re_cmlcs numeric(15), -- ������ݺ�
  pr_dm_nvcs numeric(15), -- �������������
  ce_stfno character(7), -- ����������ȣ
  dh_stfno character(7), -- ���������ȣ
  dh_bzp_orgcd character(7), -- ��޿����ұ���ڵ�
  dh_br_orgcd character(7), -- �����������ڵ�
  isamt_cd character(10), -- ���Աݾ��ڵ�
  rn_netp_anul_bzprm_cmp_nwcrt numeric(15), -- ���������ĸų⿵���������Ű���
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (plyno)
