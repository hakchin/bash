CREATE TABLE m_sam_bz_fml_styrt
(
  st_yymm character(6) NOT NULL, -- ���س��
  stfno character(7) NOT NULL, -- ������ȣ
  apo_yymm character(6), -- ���˳��
  pstn_chccd character(10), -- �źк����ڵ�
  stf_bz_stcd character(10), -- �������������ڵ�
  onfml_pfaw_ben_yn character(1), -- �Ѱ����������������
  nwfac_actaw_ben_yn character(1), -- ����Ȱ�������������
  sty_spaw_ben_yn character(1), -- �������������������
  sty_yn character(1), -- ��������
  edu_crscd character(10), -- ���������ڵ�
  edu_ntd_yymm character(6), -- �����԰����
  o1mm_dpl_yn character(1), -- 1�������Ῡ��
  o2mm_dpl_yn character(1), -- 2�������Ῡ��
  o3mm_dpl_yn character(1), -- 3�������Ῡ��
  edu_prg_stcd character(10), -- ������������ڵ�
  edu_crs_vl_mmdgr numeric(5), -- ������������������
  sty_st_awamt numeric(17,2), -- �������ؼ���ݾ�
  ce_st_awamt numeric(17,2), -- �������ؼ���ݾ�
  load_dthms timestamp(0) without time zone
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (st_yymm, stfno)