CREATE TABLE ins_cr_relpc
(
  plyno character varying(16) NOT NULL, -- 증권번호
  relpc_seqno numeric(10) NOT NULL, -- 관계자순번
  ap_nddt date NOT NULL, -- 적용종료일자
  ap_strdt date NOT NULL, -- 적용시작일자
  ndsno character(4) NOT NULL, -- 배서번호
  vald_nds_yn character(1) NOT NULL, -- 유효배서여부
  nds_ap_str_dthms timestamp(0) without time zone NOT NULL, -- 배서승인시작일시
  nds_ap_nd_dthms timestamp(0) without time zone NOT NULL, -- 배서승인종료일시
  ikd_grpcd character(10) NOT NULL, -- 보종군코드
  relpc_tpcd character(10) NOT NULL, -- 관계자유형코드
  relpc_stcd character(10) NOT NULL, -- 관계자상태코드
  st_chdt date, -- 상태변경일자
  hngl_relnm character varying(100), -- 한글관계자명
  eng_relnm character varying(200), -- 영문관계자명
  ctm_dscno character varying(40), -- 고객식별번호
  relpc_dscno_flgcd character(10), -- 관계자식별번호구분코드
  dlncd character(10), -- 거래선코드
  prs_relpc_yn character(1), -- 대표관계자여부
  crdif_utl_agre_yn character(1), -- 신용정보활용동의여부
  crdif_prt23_agre_yn character(1), -- 신용정보23조동의여부
  crdif_prt24_agre_yn character(1), -- 신용정보24조동의여부
  cntad_seqno numeric(10), -- 연락처순번
  cntad_flgcd character(10), -- 연락처구분코드
  relpc_name character varying(100), -- 관계자호칭
  relpc_name_pstcd character(10), -- 관계자호칭위치코드
  relpc_rlecd character(10), -- 관계자역할코드
  isrdt date, -- 가입일자
  ppr_relpc_seqno numeric(10), -- 상위관계자순번
  ctmno character(9), -- 고객번호
  sbd_gr_ctmno character(9), -- 하위단체고객번호
  orel_cd character(10), -- 구관계코드
  sub_ctm_dscno character varying(40), -- 부고객식별번호
  fire_mn_nrdps_yn character(1), -- 화특주피보험자여부
  fn_orgcd character(10), -- 금융기관코드
  prps_flgcd character(10), -- 질권자구분코드
  prm_pym_rt numeric(12,6) NOT NULL, -- 보험료납부비율
  hndps_yn character(1), -- 장애인여부
  ntn_mrtmn_yn character(1), -- 국가유공자여부
  ba_sadps_yn character(1), -- 기초수급자여부
  crt_flgcd character(10), -- 계약자구분코드
  dmos_flgcd character(10), -- 국내외구분코드
  indpd_mrtmn_yn character(1), -- 독립유공자여부
  dflt_pt_yn character(1), -- 고엽제환자여부
  dmrcy_518_injd_yn character(1), -- 민주518부상자여부
  pfb_flgcd character(10), -- 수익자구분코드
  nrdps_agre_yn character(1), -- 피보험자동의여부
  ut_rt numeric(12,6) NOT NULL, -- 도급비율
  md_cfcap_entp_yn character(1), -- 조정계수적용업체여부
  sexcd character(10), -- 성별코드
  jbcd character(10), -- 직업코드
  jb_ch_seqno numeric(5), -- 직업변경순번
  age numeric(3), -- 연령
  wdg_yn character(1), -- 결혼여부
  lic_specd character(10), -- 면허종별코드
  licno character varying(20), -- 면허번호
  lic_cqdt date, -- 면허취득일자
  clm_crr_yn character(1), -- 사고경력여부
  drve_crr_yyct numeric(3), -- 운전경력년수
  drve_crr_mntct numeric(3), -- 운전경력개월수
  drv_flgcd character(10), -- 운전자구분코드
  hot_stdt date, -- 임대차시기일자
  hot_clsdt date, -- 임대차종기일자
  hot_oj character varying(300), -- 임대차목적
  inp_usr_id character(7) NOT NULL, -- 입력사용자id
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자id
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  crdif_prt32_agre_yn character(1), -- 신용정보32조동의여부
  crdif_prt33_agre_yn character(1), -- 신용정보33조동의여부
  injr_hsp_cvr_yn character(1), -- 상해입원담보여부
  injr_otp_cvr_yn character(1), -- 상해통원담보여부
  dsas_hsp_cvr_yn character(1), -- 질병입원담보여부
  dsas_otp_cvr_yn character(1), -- 질병통원담보여부
  gnrz_hsp_cvr_yn character(1), -- 종합입원담보여부
  gnrz_otp_cvr_yn character(1), -- 종합통원담보여부
  gu_plyno character varying(16), -- 구증권번호
  gu_fire_lgin_id character varying(20), -- 구화재로그인아이디
  sep_cr_cn_yn character(1), -- 분리계약해약여부
  idnty_cnfc_kndcd character(10), -- 신원확인증종류코드
  idnty_cnfc_et_info character varying(100), -- 신원확인증기타정보
  idnty_cnfc_no character varying(40), -- 신원확인증번호
  idnty_cnfc_isdt date, -- 신원확인증발급일자
  idnty_cnfc_is_orgnm character varying(100), -- 신원확인증발급기관명
  rdch_cr_tpcd character(10), -- 승환계약유형코드
  relpc_scr_inp_yn character(1), -- 관계자화면입력여부
  cr_udrtk_arecd character(10), -- 자동차인수지역코드
  pect_sl_mntr_chncd character(10), -- 완전판매모니터링채널코드
  crcc_colus_agre_yn character(1), -- 계약체결수집이용동의여부
  crcc_crdir_agre_yn character(1), -- 계약체결신용정보조회동의여부
  crcc_crdio_agre_yn character(1), -- 계약체결신용정보제공동의여부
  gdint_colus_agre_yn character(1), -- 상품소개수집이용동의여부
  gdint_crdio_agre_yn character(1), -- 상품소개신용정보제공동의여부
  gdint_sesin_agre_yn character(1), -- 상품소개민감정보동의여부
  crcc_sesin_agre_yn character(1), -- 계약체결민감정보동의여부
  pfb_astch_agr_yn character(1), -- 수익자지정변경약정여부
  pfb_astch_rscd character(10), -- 수익자지정변경사유코드
  load_dthms timestamp(0) without time zone
)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (plyno)