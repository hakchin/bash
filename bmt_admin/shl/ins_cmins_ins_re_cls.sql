CREATE TABLE ins_cmins_ins_re_cls
(
  cls_yymm character(6) NOT NULL, -- 마감년월
  rn_rtro_cr_flgcd character(10) NOT NULL, -- 원수수재계약구분코드
  cls_bjno character varying(36) NOT NULL, -- 마감대상번호
  re_dlno character varying(11) NOT NULL, -- 출재처리번호
  pstcd character(10) NOT NULL, -- 경유처코드
  rincd character(10) NOT NULL, -- 재보험자코드
  clsdt date, -- 마감일자
  plyno character varying(16), -- 증권번호
  gdcd character(10), -- 상품코드
  ins_imcd character(10), -- 보험종목코드
  udrtk_tycd character(10), -- 인수형태코드
  thcp_qtrt numeric(12,6) NOT NULL, -- 당사지분율
  avg_rert numeric(12,6) NOT NULL, -- 평균출재율
  ce_orgcd character(7), -- 모집기관코드
  ce_stfno character(7), -- 모집직원번호
  dh_orgcd character(7), -- 취급기관코드
  dh_stfno character(7), -- 취급직원번호
  chrps_orgcd character(7), -- 담당자기관코드
  chrps_stfno character(7), -- 담당자직원번호
  chr_admr_orgcd character(7), -- 담당관리자기관코드
  chr_admr_stfno character(7), -- 담당관리자직원번호
  xi_py_flgcd character(10), -- 추산지급구분코드
  t_re_ibnf numeric(15) NOT NULL, -- 총출재보험금액
  thcp_re_ibamt numeric(15) NOT NULL, -- 당사출재보험금액
  t_re_ibnf_rtamt numeric(15) NOT NULL, -- 총출재보험금환급금액
  thcp_re_ibnf_rtamt numeric(15) NOT NULL, -- 당사출재보험금환급금액
  t_re_py_rfamt numeric(15) NOT NULL, -- 총출재지급준비금액
  thcp_re_py_rfamt numeric(15) NOT NULL, -- 당사출재지급준비금액
  t_re_nvcs numeric(15) NOT NULL, -- 총출재조사비용
  thcp_re_nvcs numeric(15) NOT NULL, -- 당사출재조사비용
  t_re_nvcs_rfamt numeric(15) NOT NULL, -- 총출재조사비용준비금액
  thcp_re_nvcs_rfamt numeric(15) NOT NULL, -- 당사출재조사비용준비금액
  inp_usr_id character(7) NOT NULL, -- 입력사용자id
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자id
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  dat_sourc_flgcd character(10) ,-- 데이터소스구분코드
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (cls_yymm, rn_rtro_cr_flgcd, cls_bjno, re_dlno, pstcd, rincd);