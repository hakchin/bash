CREATE TABLE m_lcr_ltrm_incm_prm
(
  plyno character varying(16) NOT NULL, -- 증권번호
  incm_prm_cr_seqno numeric(5) NOT NULL, -- 수입보험료발생순번
  ndsno character(4), -- 배서번호
  ppdt date, -- 계상일자
  pvl_yymm character(6), -- 계상년월
  dh_bz_part_flgcd character(10), -- 취급영업부문구분코드
  dh_hdqt_orgcd character(7), -- 취급본부기관코드
  dh_br_orgcd character(7), -- 취급지점기관코드
  dh_bzp_orgcd character(7), -- 취급영업소기관코드
  dh_tm_orgcd character(7), -- 취급팀기관코드
  dh_stfno character(7), -- 취급직원번호
  org_dh_stfno character(7), -- 원취급직원번호
  admr_stfno character(7), -- 관리자직원번호
  dh_stf_bz_stcd character(10), -- 취급직원영업상태코드
  dh_usr_no character(7), -- 취급사용인번호
  ctmno character(9), -- 고객번호
  ctm_nm character varying(100), -- 고객성명
  ctm_tpcd character(10), -- 고객유형코드
  gdcd character(10), -- 상품코드
  nwfsq_flgcd character(10), -- 신초차구분코드
  rp_pth_flgcd character(10), -- 영수경로구분코드
  pym_dudt date, -- 납입응당일자
  pym_seq numeric(5), -- 납입회차
  pym_cyccd character(10), -- 납입주기코드
  pym_tpcd character(10), -- 납입유형코드
  ppy_tpcd character(10), -- 선납유형코드
  ppy_flgcd character(10), -- 선납구분코드
  flppy_yn character(1), -- 일시선납여부
  nsc_yn character(1), -- 계열사여부
  nsccd character(10), -- 계열사코드
  cr_stcd character(10), -- 계약상태코드
  bkcd character(10), -- 은행코드
  bk_brcd character(10), -- 은행지점코드
  bk_brnm character varying(100), -- 은행지점명
  bk_extn_qfp character(10), -- 은행유자격자
  bnc_admr character(7), -- 방카관리자
  dp_cascd character(10), -- 입금원인코드
  dp_dt_cascd character(10), -- 입금세부원인코드
  onds_dp_tpcd character(10), -- 구배서입금유형코드
  sb_flgcd character(10), -- 대체구분코드
  mnt_flgcd character(10), -- 금종구분코드
  incm_prm numeric(15), -- 수입보험료
  ap_prm numeric(17,2), -- 적용보험료
  cu_prm numeric(15), -- 적립보험료
  gn_prm numeric(15), -- 보장보험료
  mpy_cv_prm numeric(17,2), -- 월납환산보험료
  gnte_mpy_cvprm numeric(17,2), -- 보장성월납환산보험료
  cumt_mpy_cvprm numeric(17,2), -- 적립성월납환산보험료
  gnte_cv_prm numeric(15), -- 보장성환산보험료
  cumt_cv_prm numeric(15), -- 적립성환산보험료
  flpy_cvr_trt_prm numeric(15), -- 일시납담보특약보험료
  dcbf_prm numeric(15), -- 할인전보험료
  load_dthms timestamp(0) without time zone
)

WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (plyno)
