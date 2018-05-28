CREATE TABLE igd_gd
(
  gdcd character(10) NOT NULL, -- 상품코드
  ap_nddt date NOT NULL, -- 적용종료일자
  ap_strdt date NOT NULL, -- 적용시작일자
  ikd_grpcd character(10) NOT NULL, -- 보종군코드
  ins_imcd character(10) NOT NULL, -- 보험종목코드
  cla_lng_flgcd character(10) NOT NULL, -- 약관언어구분코드
  gd_ty_flgcd character(10) NOT NULL, -- 상품형태구분코드
  gd_slnm character varying(100) NOT NULL, -- 상품판매명
  gd_shtnm character varying(50), -- 상품단축명
  gd_kornm character varying(100), -- 상품한글명
  gd_ennm character varying(100), -- 상품영문명
  gd_xpnm character varying(1000), -- 상품설명
  gd_per_yn character(1) NOT NULL, -- 상품인가여부
  gd_pernm character varying(100), -- 상품인가명
  gd_per_tpcd character(10), -- 상품인가유형코드
  gd_perdt date, -- 상품인가일자
  gd_sl_tpcd character(10), -- 상품판매유형코드
  cr_opn_ba_hms character(4), -- 계약개시기본시간
  cr_nd_ba_hms character(4), -- 계약종료기본시간
  fc_dh_yn character(1) NOT NULL, -- 외화취급여부
  re_unt_flgcd character(10), -- 출재단위구분코드
  pym_xmp_unt_flgcd character(10) NOT NULL, -- 납입면제단위구분코드
  ppy_prm_prm_yn character(1), -- 선납보험료허용여부
  ppy_prm_mxpsb_mc numeric(4), -- 선납보험료최대가능월수
  psncl_dbins_prm_yn character(1), -- 개인별중복보험허용여부
  cv_ins_av_yn character(1), -- 전환보험가능여부
  auto_tf_dc_yn character(1), -- 자동이체할인여부
  type_flgcd character(10), -- 종구분코드
  type_cn_flgcd character(10), -- 종내용구분코드
  spe_scr_rnw_yn character(1), -- 종별화면갱신여부
  dv_tpcd character(10), -- 배당유형코드
  prm_str_flgcd character(10), -- 보험료구조구분코드
  mw_rtamt_cr_flgcd character(10), -- 중도환급금액발생구분코드
  nd_rtamt_cr_yn character(1), -- 만기환급금액발생여부
  dgn_gd_yn character(1), -- 진단상품여부
  auto_rnw_av_yn character(1), -- 자동갱신가능여부
  prm_inp_flgcd character(10), -- 보험료입력구분코드
  cu_prm_ocpym_yn character(1), -- 적립보험료수시납입여부
  ctu_crdtf_av_yn character(1), -- 계속카드이체가능여부
  cla_ln_av_yn character(1), -- 약관대출가능여부
  sb_pym_flgcd character(10) NOT NULL, -- 대체납입구분코드
  sb_pym_tpcd character(10), -- 대체납입유형코드
  age_cc_st_flgcd character(10), -- 연령산출기준구분코드
  bz_mtdrp_csfcd character(10), -- 사업방법서분류코드
  is_pl_cht_wrtyn character(1), -- 가입설계차트출력여부
  xtn_tpcd character(10), -- 소멸유형코드
  xtntm_rtamt_flgcd character(10), -- 소멸시환급금구분코드
  gr_is_flgcd character(10), -- 단체가입구분코드
  gr_dc_av_yn character(1), -- 단체할인가능여부
  gr_mn_is_psct numeric(3), -- 단체최소가입인원수
  avg_rt_us_yn character(1), -- 평균요율사용여부
  pr_es_prm_yn character(1) NOT NULL, -- 질권설정허용여부
  lowt_prm_mncd character(10), -- 최저보험료화폐코드
  lowt_prm numeric(17,2) NOT NULL, -- 최저보험료
  cvr_prm_sgdlg_flgcd character(10), -- 담보보험료단수처리구분코드
  apprm_sglr_dl_flgcd character(10), -- 적용보험료단수처리구분코드
  sl_pl_adm_yn character(1), -- 판매플랜관리여부
  cr_logfl_pst_info character varying(100), -- 계약log파일위치정보
  op_envr_cv_yn character(1) NOT NULL, -- 운용환경전환여부
  ins_trm_bavl character(3), -- 보험기간기본값
  ins_trm_lm character(3), -- 보험기간한도
  pym_grc_trm character(3), -- 납입유예기간
  tx_pf_gd_csfcd character(10), -- 세금우대상품분류코드
  sl_pl_op_tpcd character(10), -- 판매플랜운용유형코드
  ply_out_tp_flgcd character(10), -- 증권출력유형구분코드
  type_ch_av_yn character(1), -- 종변경가능여부
  gd_dt_scr_yn character(1), -- 상품세부화면여부
  dt_scr_id character(10), -- 세부화면id
  dc_ap_flgcd character(10), -- 할인적용구분코드
  dt_inpsc_xstn_yn character(1), -- 상세입력화면존재여부
  dt_inpsc_id character(10), -- 상세입력화면id
  mw_wdra_av_rt numeric(15) NOT NULL, -- 중도인출가능비율
  mw_wdra_str_rndcd character(10), -- 중도인출시작경과코드
  mw_wdra_cr_cyccd character(10), -- 중도인출발생주기코드
  mw_wdra_cr_caseq numeric(5), -- 중도인출발생주기가능회차
  dvpns_rpr_ikdcd character(10), -- 개발원통보보종코드
  gd_exppr_out_yn character(1), -- 상품해설서출력여부
  marne_nelp_cal_metcd character(10), -- 해상미경과계산방식코드
  inp_usr_id character(7) NOT NULL, -- 입력사용자id
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자id
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  pect_sl_mntr_bjpcd character(10), -- 완전판매모니터링대상코드
  prm_inp_tpcd character(10), -- 보험료입력유형코드
  rntcl_dscrt_ap_yn character(1), -- 경과기간별할인율적용여부
  gds_mx_dc_lmrt numeric(5,2), -- 상품별최대할인한도율
  prm_sb_pym_tpcd character(10), -- 보험료대체납입유형코드
  prm_npy_sb_flgcd character(10), -- 보험료미납대체구분코드
  scr_idc_ordr numeric(5), -- 화면표시순서
  mx_mn_cc_tpcd character(10), -- 최대최소산출유형코드
  rnwdc_fund_chek_yn character(1), -- 갱신할인재원체크여부
  rmimc_rkrt_dcl_yn character(1), -- 실손의료비위험율공시여부
  anul_bzprm_rt_adtm numeric(3), -- 매년영업보험료비율부가기간
  cc_xcpt_dlcd character(10), -- 산출예외처리코드
  indpd_trt_tpcd character(10), -- 독립특약유형코드
  indpd_trt_incld_yn character(1), -- 독립특약포함여부
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (gdcd, ap_nddt, ap_strdt);