

CREATE TABLE m_sam_ltrm_mn_cr_crst_bmt
(
  st_yymm character(6) NOT NULL, -- 기준년월
  plyno character varying(16) NOT NULL, -- 증권번호
  rnd_mc numeric(5) NOT NULL, -- 경과월수
  du_ar_flgcd character(10) NOT NULL, -- 응당연체구분코드
  ce_yymm character(6) NOT NULL, -- 모집년월
  cr_stcd character(10), -- 계약상태코드
  cr_dt_stcd character(10), -- 계약세부상태코드
  crt_dscno character varying(40), -- 계약자식별번호
  crt_nm character varying(100), -- 계약자성명
  cm_mtdcd character(10), -- 수금방법코드
  pym_cyccd character(10), -- 납입주기코드
  ins_imcd character(10), -- 보험종목코드
  gdcd character(10), -- 상품코드
  fnl_pym_yymm character(6), -- 최종납입년월
  fnl_pym_ct numeric(10), -- 최종납입횟수
  ce_mpy_cvprm numeric(17,2), -- 모집월납환산보험료
  mn_mpy_cvprm numeric(17,2), -- 유지월납환산보험료
  bm_stfno character(7), -- BM직원번호
  bk_brcd character(10), -- 은행지점코드
  ce_stfno character(7), -- 모집직원번호
  ce_usrno character(7), -- 모집사용인번호
  ce_stf_bz_mmthr numeric(5), -- 모집직원영업차월
  ce_stf_bz_atrcd character(10), -- 모집직원영업속성코드
  ce_hdqt_orgcd character(7), -- 모집본부기관코드
  ce_spgp_orgcd character(7), -- 모집지원단기관코드
  ce_br_orgcd character(7), -- 모집지점기관코드
  ce_tm_orgcd character(7), -- 모집팀기관코드
  ce_prs_agyno character(7), -- 모딥대표대리점번호
  cepc_orgcd character(7), -- 모집처기관코드
  dh_stfno character(7), -- 취급직원번호
  dh_stf_bz_mmthr numeric(5), -- 취급직원영업차월
  dh_stf_bz_atrcd character(10), -- 취급직원영업속성코드
  dh_hdqt_orgcd character(7), -- 취급본부기관코드
  dh_spgp_orgcd character(7), -- 취급지원단기관코드
  dh_br_orgcd character(7), -- 취급지점기관코드
  dhtrb_orgcd character(7), -- 취급처기관코드
  dh_tm_orgcd character(7), -- 취급팀기관코드
  bz_tpcd character(10), -- 영업유형코드
  load_dthms timestamp(0) without time zone -- 적재일시
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (st_yymm, plyno, rnd_mc, du_ar_flgcd, ce_yymm)