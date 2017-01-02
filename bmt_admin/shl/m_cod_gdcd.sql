CREATE TABLE m_cod_gdcd
(
  gdcd character(10) NOT NULL, -- 상품코드
  gdnm character varying(100), -- 상품명
  ins_imcd character(10) NOT NULL, -- 보험종목코드
  sl_chncd character(10), -- 판매채널코드
  gd_ty_flgcd character(10), -- 상품형태구분코드
  prm_str_flgcd character(10), -- 보험료구조구분코드
  dv_tpcd character(10), -- 배당유형코드
  gd_sl_tpcd character(10), -- 상품판매유형코드
  ikd_grpcd character(10) ,-- 보종군코드
  load_dthms timestamp(0) without time zone
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (gdcd);