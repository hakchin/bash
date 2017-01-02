CREATE TABLE ins_cr_relpc
(
  plyno character varying(16) NOT NULL, -- ���ǹ�ȣ
  relpc_seqno numeric(10) NOT NULL, -- �����ڼ���
  ap_nddt date NOT NULL, -- ������������
  ap_strdt date NOT NULL, -- �����������
  ndsno character(4) NOT NULL, -- �輭��ȣ
  vald_nds_yn character(1) NOT NULL, -- ��ȿ�輭����
  nds_ap_str_dthms timestamp(0) without time zone NOT NULL, -- �輭���ν����Ͻ�
  nds_ap_nd_dthms timestamp(0) without time zone NOT NULL, -- �輭���������Ͻ�
  ikd_grpcd character(10) NOT NULL, -- �������ڵ�
  relpc_tpcd character(10) NOT NULL, -- �����������ڵ�
  relpc_stcd character(10) NOT NULL, -- �����ڻ����ڵ�
  st_chdt date, -- ���º�������
  hngl_relnm character varying(100), -- �ѱ۰����ڸ�
  eng_relnm character varying(200), -- ���������ڸ�
  ctm_dscno character varying(40), -- ���ĺ���ȣ
  relpc_dscno_flgcd character(10), -- �����ڽĺ���ȣ�����ڵ�
  dlncd character(10), -- �ŷ����ڵ�
  prs_relpc_yn character(1), -- ��ǥ�����ڿ���
  crdif_utl_agre_yn character(1), -- �ſ�����Ȱ�뵿�ǿ���
  crdif_prt23_agre_yn character(1), -- �ſ�����23�����ǿ���
  crdif_prt24_agre_yn character(1), -- �ſ�����24�����ǿ���
  cntad_seqno numeric(10), -- ����ó����
  cntad_flgcd character(10), -- ����ó�����ڵ�
  relpc_name character varying(100), -- ������ȣĪ
  relpc_name_pstcd character(10), -- ������ȣĪ��ġ�ڵ�
  relpc_rlecd character(10), -- �����ڿ����ڵ�
  isrdt date, -- ��������
  ppr_relpc_seqno numeric(10), -- ���������ڼ���
  ctmno character(9), -- ����ȣ
  sbd_gr_ctmno character(9), -- ������ü����ȣ
  orel_cd character(10), -- �������ڵ�
  sub_ctm_dscno character varying(40), -- �ΰ��ĺ���ȣ
  fire_mn_nrdps_yn character(1), -- ȭƯ���Ǻ����ڿ���
  fn_orgcd character(10), -- ��������ڵ�
  prps_flgcd character(10), -- �����ڱ����ڵ�
  prm_pym_rt numeric(12,6) NOT NULL, -- ����ᳳ�κ���
  hndps_yn character(1), -- ����ο���
  ntn_mrtmn_yn character(1), -- ���������ڿ���
  ba_sadps_yn character(1), -- ���ʼ����ڿ���
  crt_flgcd character(10), -- ����ڱ����ڵ�
  dmos_flgcd character(10), -- �����ܱ����ڵ�
  indpd_mrtmn_yn character(1), -- ���������ڿ���
  dflt_pt_yn character(1), -- ����ȯ�ڿ���
  dmrcy_518_injd_yn character(1), -- ����518�λ��ڿ���
  pfb_flgcd character(10), -- �����ڱ����ڵ�
  nrdps_agre_yn character(1), -- �Ǻ����ڵ��ǿ���
  ut_rt numeric(12,6) NOT NULL, -- ���޺���
  md_cfcap_entp_yn character(1), -- ������������ü����
  sexcd character(10), -- �����ڵ�
  jbcd character(10), -- �����ڵ�
  jb_ch_seqno numeric(5), -- �����������
  age numeric(3), -- ����
  wdg_yn character(1), -- ��ȥ����
  lic_specd character(10), -- ���������ڵ�
  licno character varying(20), -- �����ȣ
  lic_cqdt date, -- �����������
  clm_crr_yn character(1), -- ����¿���
  drve_crr_yyct numeric(3), -- ������³��
  drve_crr_mntct numeric(3), -- ������°�����
  drv_flgcd character(10), -- �����ڱ����ڵ�
  hot_stdt date, -- �Ӵ����ñ�����
  hot_clsdt date, -- �Ӵ�����������
  hot_oj character varying(300), -- �Ӵ�������
  inp_usr_id character(7) NOT NULL, -- �Է»����id
  inp_dthms timestamp(0) without time zone NOT NULL, -- �Է��Ͻ�
  mdf_usr_id character(7) NOT NULL, -- ���������id
  mdf_dthms timestamp(0) without time zone NOT NULL, -- �����Ͻ�
  crdif_prt32_agre_yn character(1), -- �ſ�����32�����ǿ���
  crdif_prt33_agre_yn character(1), -- �ſ�����33�����ǿ���
  injr_hsp_cvr_yn character(1), -- �����Կ��㺸����
  injr_otp_cvr_yn character(1), -- ��������㺸����
  dsas_hsp_cvr_yn character(1), -- �����Կ��㺸����
  dsas_otp_cvr_yn character(1), -- ��������㺸����
  gnrz_hsp_cvr_yn character(1), -- �����Կ��㺸����
  gnrz_otp_cvr_yn character(1), -- ��������㺸����
  gu_plyno character varying(16), -- �����ǹ�ȣ
  gu_fire_lgin_id character varying(20), -- ��ȭ��α��ξ��̵�
  sep_cr_cn_yn character(1), -- �и�����ؾ࿩��
  idnty_cnfc_kndcd character(10), -- �ſ�Ȯ���������ڵ�
  idnty_cnfc_et_info character varying(100), -- �ſ�Ȯ������Ÿ����
  idnty_cnfc_no character varying(40), -- �ſ�Ȯ������ȣ
  idnty_cnfc_isdt date, -- �ſ�Ȯ�����߱�����
  idnty_cnfc_is_orgnm character varying(100), -- �ſ�Ȯ�����߱ޱ����
  rdch_cr_tpcd character(10), -- ��ȯ��������ڵ�
  relpc_scr_inp_yn character(1), -- ������ȭ���Է¿���
  cr_udrtk_arecd character(10), -- �ڵ����μ������ڵ�
  pect_sl_mntr_chncd character(10), -- �����ǸŸ���͸�ä���ڵ�
  crcc_colus_agre_yn character(1), -- ���ü������̿뵿�ǿ���
  crcc_crdir_agre_yn character(1), -- ���ü��ſ�������ȸ���ǿ���
  crcc_crdio_agre_yn character(1), -- ���ü��ſ������������ǿ���
  gdint_colus_agre_yn character(1), -- ��ǰ�Ұ������̿뵿�ǿ���
  gdint_crdio_agre_yn character(1), -- ��ǰ�Ұ��ſ������������ǿ���
  gdint_sesin_agre_yn character(1), -- ��ǰ�Ұ��ΰ��������ǿ���
  crcc_sesin_agre_yn character(1), -- ���ü��ΰ��������ǿ���
  pfb_astch_agr_yn character(1), -- ���������������������
  pfb_astch_rscd character(10), -- ������������������ڵ�
  load_dthms timestamp(0) without time zone
)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno)