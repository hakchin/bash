CREATE TABLE igd_gd_cvr_acm_rk
(
  acm_rkcd character(10) NOT NULL, -- 누적위험코드
  gdcd character(10) NOT NULL, -- 상품코드
  cvrcd character(8) NOT NULL, -- 담보코드
  ap_nddt date NOT NULL, -- 적용종료일자
  ap_strdt date NOT NULL, -- 적용시작일자
  acm_mult numeric(10,5), -- 누적배수
  inp_usr_id character(7) NOT NULL, -- 입력사용자ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자ID
  mdf_dthms timestamp(0) without time zone NOT NULL ,-- 수정일시
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (acm_rkcd, gdcd, cvrcd, ap_nddt, ap_strdt);