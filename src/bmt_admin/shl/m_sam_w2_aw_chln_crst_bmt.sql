CREATE TABLE m_sam_w2_aw_chln_crst_bmt
(
  st_yymm character(6), -- 기준년월
  wkdgr_seq numeric(3), -- 주차수회차
  self_cr_flgcd character(10), -- 자기계약구분코드
  dh_stfno character(7), -- 취급직원번호
  mthy_wkdgr_seq numeric(3), -- 월별주차수회차
  wkdgr_strdt date, -- 주차수시작일자
  wkdgr_nddt date, -- 주차수종료일자
  gnte_nwcr_ct numeric(9), -- 보장성신계약건수
  gnte_mpy_cvprm numeric(15), -- 보장성월납환산보험료
  an_sv_nwcct numeric(10), -- 연금저축신계약건수
  an_sv_mpy_cvprm numeric(15), -- 연금저축월납환산보험료
  achv_w2_yn character(1), -- 달성2W여부
  achv_3w_yn character(1), -- 달성3W여부
  cntn_w2_achv_seq numeric(3), -- 연속2W달성회차
  cntn_3w_achv_seq numeric(3), -- 연속3W달성회차
  fnl_w2_achv_seq numeric(3), -- 최종2W달성회차
  fnl_3w_achv_seq numeric(3), -- 최종3W달성회차
  load_dthms timestamp(0) without time zone -- 적재일시
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (st_yymm, wkdgr_seq, self_cr_flgcd, dh_stfno)