CREATE TABLE m_cod_bzus_ins_itm_csfcd
(
  ins_imcd character(10) NOT NULL, -- 보험종목코드
  ins_imnm character varying(100), -- 보험종목명
  gd_lclcd character(10), -- 상품대분류코드
  gd_lclnm character varying(100), -- 상품대분류명
  gd_mdccd character(10), -- 상품중분류코드
  gd_mdcnm character varying(100), -- 상품중분류명
  gd_smccd character(10), -- 상품소분류코드
  gd_smcnm character varying(100) ,-- 상품소분류명
  load_dthms timestamp(0) without time zone
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (ins_imcd);