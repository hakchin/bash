

CREATE TABLE m_sam_ltrm_mn_cr_crst_bmt
(
  st_yymm character(6) NOT NULL, -- ���س��
  plyno character varying(16) NOT NULL, -- ���ǹ�ȣ
  rnd_mc numeric(5) NOT NULL, -- �������
  du_ar_flgcd character(10) NOT NULL, -- ���翬ü�����ڵ�
  ce_yymm character(6) NOT NULL, -- �������
  cr_stcd character(10), -- �������ڵ�
  cr_dt_stcd character(10), -- ��༼�λ����ڵ�
  crt_dscno character varying(40), -- ����ڽĺ���ȣ
  crt_nm character varying(100), -- ����ڼ���
  cm_mtdcd character(10), -- ���ݹ���ڵ�
  pym_cyccd character(10), -- �����ֱ��ڵ�
  ins_imcd character(10), -- ���������ڵ�
  gdcd character(10), -- ��ǰ�ڵ�
  fnl_pym_yymm character(6), -- �������Գ��
  fnl_pym_ct numeric(10), -- ��������Ƚ��
  ce_mpy_cvprm numeric(17,2), -- ��������ȯ�꺸���
  mn_mpy_cvprm numeric(17,2), -- ��������ȯ�꺸���
  bm_stfno character(7), -- BM������ȣ
  bk_brcd character(10), -- ���������ڵ�
  ce_stfno character(7), -- ����������ȣ
  ce_usrno character(7), -- ��������ι�ȣ
  ce_stf_bz_mmthr numeric(5), -- ����������������
  ce_stf_bz_atrcd character(10), -- �������������Ӽ��ڵ�
  ce_hdqt_orgcd character(7), -- �������α���ڵ�
  ce_spgp_orgcd character(7), -- ���������ܱ���ڵ�
  ce_br_orgcd character(7), -- ������������ڵ�
  ce_tm_orgcd character(7), -- ����������ڵ�
  ce_prs_agyno character(7), -- �����ǥ�븮����ȣ
  cepc_orgcd character(7), -- ����ó����ڵ�
  dh_stfno character(7), -- ���������ȣ
  dh_stf_bz_mmthr numeric(5), -- ���������������
  dh_stf_bz_atrcd character(10), -- ������������Ӽ��ڵ�
  dh_hdqt_orgcd character(7), -- ��޺��α���ڵ�
  dh_spgp_orgcd character(7), -- ��������ܱ���ڵ�
  dh_br_orgcd character(7), -- �����������ڵ�
  dhtrb_orgcd character(7), -- ���ó����ڵ�
  dh_tm_orgcd character(7), -- ���������ڵ�
  bz_tpcd character(10), -- ���������ڵ�
  load_dthms timestamp(0) without time zone -- �����Ͻ�
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (st_yymm, plyno, rnd_mc, du_ar_flgcd, ce_yymm)