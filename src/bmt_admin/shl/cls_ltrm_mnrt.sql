CREATE TABLE cls_ltrm_mnrt
(
  cls_yymm character(6) NOT NULL, -- 마감년월
  plyno character varying(16) NOT NULL, -- 증권번호
  cvrcd character(8) NOT NULL, -- 담보코드
  cvr_seqno numeric(5) NOT NULL, -- 담보순번
  gdcd character(10), -- 상품코드
  nrdps_dscno character varying(40), -- 피보험자식별번호
  crt_dscno character varying(40), -- 계약자식별번호
  cr_stcd character(10), -- 계약상태코드
  cr_dt_stcd character(10), -- 계약세부상태코드
  ins_st date, -- 보험시기
  ins_clstr date, -- 보험종기
  fnl_pym_yymm character(6), -- 최종납입년월
  pym_cyccd character(10), -- 납입주기코드
  pym_ct numeric(3), -- 납입횟수
  rnd_mc numeric(5), -- 경과월수
  cu_prm numeric(15), -- 적립보험료
  gn_prm numeric(15), -- 보장보험료
  ce_mpy_cvprm numeric(17,2), -- 모집월납환산보험료
  mn_mpy_cvprm numeric(17,2), -- 유지월납환산보험료
  ce_cvav_prm numeric(15), -- 모집환산실적보험료
  mn_cv_av_prm numeric(15), -- 유지환산실적보험료
  ce_bzp_orgcd character(7), -- 모집영업소기관코드
  ce_stfno character(7), -- 모집직원번호
  dh_bzp_orgcd character(7), -- 취급영업소기관코드
  dh_stfno character(7), -- 취급직원번호
  cm_mtdcd character(10), -- 수금방법코드
  ce_bzp_lead_stfno character(7), -- 모집영업소장직원번호
  ce_brma_stfno character(7), -- 모집지점장직원번호
  is_thtm_nrdps_age numeric(3), -- 가입당시피보험자연령
  cr_thtm_nrdps_age numeric(3), -- 계상당시피보험자연령
  nrdps_pstno character(6), -- 피보험자우편번호
  nrdps_jbcd character(10), -- 피보험자직업코드
  is_thtm_crt_age numeric(3), -- 가입당시계약자연령
  cr_thtm_crt_age numeric(3), -- 계상당시계약자연령
  crt_pstno character(6), -- 계약자우편번호
  crt_jbcd character(10), -- 계약자직업코드
  du_ar_flgcd character(10), -- 응당연체구분코드
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (cls_yymm, plyno, cvrcd, cvr_seqno)