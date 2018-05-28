CREATE TABLE cls_ltrm_cvr_rnd_prm
(
  cls_yymm character(6) NOT NULL, -- 마감년월
  plyno character varying(16) NOT NULL, -- 증권번호
  nrdps_dscno character varying(40) NOT NULL, -- 피보험자식별번호
  cvrcd character(8) NOT NULL, -- 담보코드
  gdcd character(10), -- 상품코드
  rp_prm numeric(15), -- 영수보험료
  re_rk_prm numeric(15), -- 출재위험보험료
  re_ad_prm numeric(15), -- 출재부가보험료
  rn_rnd_prm numeric(15), -- 원수경과보험료
  re_rnd_rk_prm numeric(15), -- 출재경과위험보험료
  re_rnd_ad_prm numeric(15), -- 출재경과부가보험료
  rk_rnd_prm numeric(15), -- 위험경과보험료
  ptrm_rn_idm_bnd numeric(15), -- 전기원수미경과보험료
  nxt_rn_nrnpr numeric(15), -- 차기원수미경과보험료
  ptrm_re_nrnpr numeric(15), -- 전기출재미경과보험료
  nxt_re_nrnpr numeric(15), -- 차기출재미경과보험료
  rk_prm numeric(15), -- 위험보험료
  sv_prm numeric(15), -- 저축보험료
  rn_netp_nwcrt numeric(15), -- 원수순보식신계약비
  rn_mncs numeric(15), -- 원수유지비
  rn_cmlcs numeric(15), -- 원수수금비
  re_netp_nwcrt numeric(15), -- 출재순보식신계약비
  re_mncs numeric(15), -- 출재유지비
  re_cmlcs numeric(15), -- 출재수금비
  pr_dm_nvcs numeric(15), -- 예정손해조사비
  ce_stfno character(7), -- 모집직원번호
  dh_stfno character(7), -- 취급직원번호
  dh_bzp_orgcd character(7), -- 취급영업소기관코드
  dh_br_orgcd character(7), -- 취급지점기관코드
  isamt_cd character(10), -- 가입금액코드
  rn_netp_anul_bzprm_cmp_nwcrt numeric(15), -- 원수순보식매년영업보험료대비신계약비
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (plyno)
