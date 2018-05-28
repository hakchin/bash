CREATE TABLE m_lcr_ltins_cr
(
  plyno character varying(16) NOT NULL, -- 증권번호
  cnrdt date, -- 계약일자
  cr_yymm character(6), -- 계약년월
  fnl_cr_stcd character(10), -- 최종계약상태코드
  fnl_cr_st_chdt date, -- 최종계약상태변경일자
  fnl_dt_cr_stcd character(10), -- 최종세부계약상태코드
  fnl_pym_seq numeric(5), -- 최종납입회차
  fnl_pym_yymm character(6), -- 최종납입년월
  ce_evmm numeric(5), -- 모집월차
  ce_seq numeric(10), -- 모집회차
  ply_lvl_flgcd character(10), -- 증권레벨구분코드
  ins_imcd character(10), -- 보험종목코드
  gdcd character(10), -- 상품코드
  prm_str_flgcd character(10), -- 보험료구조구분코드
  ins_st date, -- 보험시기
  ins_st_yymm character(6), -- 보험시기년월
  ins_clstr date, -- 보험종기
  ins_clstr_yymm character(6), -- 보험종기년월
  t1_prm numeric(15), -- 1회보험료
  ins_days numeric(5), -- 보험일수
  holo_sign_yn character(1), -- 자필서명여부
  dv_yn character(1), -- 배당여부
  pym_trm numeric(3), -- 납입기간
  rl_pym_trm numeric(3), -- 실납입기간
  rl_nd_trm numeric(3), -- 실만기기간
  pym_trm_flgcd character(10), -- 납입기간구분코드
  pym_trmcd character(10), -- 납입기간코드
  ce_rowcd character(10), -- 모집경위코드
  nd_flgcd character(10), -- 만기구분코드
  ndcd character(10), -- 만기코드
  cr_chncd character(10), -- 계약채널코드
  plcd character(10), -- 플랜코드
  bm_stfno character(7), -- BM직원번호
  bkcd character(10), -- 은행코드
  bk_brcd character(10), -- 은행지점코드
  bk_extn_qfp character(10), -- 은행유자격자
  mn_nrdps_ctmno character(9), -- 주피보험자고객번호
  mn_nrdps_is_age numeric(3), -- 주피보험자가입연령
  mn_nrdps_age numeric(3), -- 주피보험자연령
  mn_nrdps_sexcd character(10), -- 주피보험자성별코드
  mn_nrdps_injr_rnkcd character(10), -- 주피보험자상해급수코드
  mn_nrdps_jbcd character(10), -- 주피보험자직업코드
  dh_stfno character(7), -- 취급직원번호
  dh_usr_no character(7), -- 취급사용인번호
  ce_bz_part_flgcd character(10), -- 모집영업부문구분코드
  ce_hdqt_orgcd character(7), -- 모집본부기관코드
  ce_br_orgcd character(7), -- 모집지점기관코드
  ce_bzp_orgcd character(7), -- 모집영업소기관코드
  ce_tm_orgcd character(7), -- 모집팀기관코드
  ce_stfno character(7), -- 모집직원번호
  ce_usrno character(7), -- 모집사용인번호
  cer_stf_flgcd character(10), -- 모집자직원구분코드
  spccf_cr_yn character(1), -- 특인계약여부
  clm_yn character(1), -- 사고여부
  clmct numeric(7), -- 사고건수
  crt_ctm_tpcd character(10), -- 계약자고객유형코드
  crt_ctmno character(9), -- 계약자고객번호
  crt_ctm_flgcd character(10), -- 계약자고객구분코드
  crrnm character varying(100), -- 계약자명
  crt_is_age numeric(3), -- 계약자가입연령
  crt_sexcd character(10), -- 계약자성별코드
  crt_adr_sd character varying(30), -- 계약자주소시도
  crt_adr_sgng character varying(30), -- 계약자주소시군구
  crt_ltrm_jbcd character(10), -- 계약자장기직업코드
  cm_mtdcd character(10), -- 수금방법코드
  pym_cyccd character(10), -- 납입주기코드
  rvi_yn character(1), -- 부활여부
  ap_rato numeric(7,2), -- 적용이율
  pr_rato numeric(7,2), -- 예정이율
  crmrt_cr_yn character(1), -- 카메리트계약여부
  self_cr_yn character(1), -- 자기계약여부
  ta_cr_yn character(1), -- 이관계약여부
  cprtb_admno character(10), -- 협력점관리번호
  nsc_yn character(1), -- 계열사여부
  ppr_plyno character varying(16), -- 상위증권번호
  cnn_cr_plyno character varying(16), -- 관련자동차증권번호
  vald_cr_yn character(1), -- 유효계약여부
  ar_flgcd character(10), -- 연체구분코드
  st_rato_kndcd character(10), -- 기준이율종류코드
  nwcr_ctu_flgcd character(10), -- 신계약계속구분코드
  cr_st_apdt date, -- 계약상태승인일자
  nwcr_scan_bj_yn character(1), -- 신계약스캔대상여부
  nwcr_scan_cplt_yn character(1), -- 신계약스캔완료여부
  nwcr_scan_cplt_dthms timestamp(0) without time zone, -- 신계약스캔완료일시
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (plyno);