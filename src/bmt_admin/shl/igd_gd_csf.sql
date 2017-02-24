CREATE TABLE igd_gd_csf
(
  gd_csfcd character(10) NOT NULL, -- 상품분류코드
  ppr_gd_csfcd character(10), -- 상위상품분류코드
  gd_csfnm character varying(50) NOT NULL, -- 상품분류명
  gd_csf_lvl numeric(1) NOT NULL, -- 상품분류레벨
  fnl_lvl_yn character(1) NOT NULL, -- 최종레벨여부
  scr_idc_yn character(1) NOT NULL, -- 화면표시여부
  scr_idc_ordr numeric(5), -- 화면표시순서
  vald_strdt date NOT NULL, -- 유효시작일자
  vald_nddt date NOT NULL, -- 유효종료일자
  cnn_scr_gpcd character(10), -- 관련화면그룹코드
  cnn_scr_dt_flgcd character(10), -- 관련화면세부구분코드
  inp_usr_id character(7) NOT NULL, -- 입력사용자ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  main_gd_yn character(1), -- 주요상품여부
  main_gd_ordr numeric(3), -- 주요상품순서
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (gd_csfcd);