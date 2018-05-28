CREATE TABLE m_cod_cvrcd
(
  cvrcd character(8) NOT NULL, -- 담보코드
  cvrnm character varying(100), -- 담보명
  cvr_lvl_1_cd character(10), -- 담보레벨1코드
  cvr_lvl_1_nm character varying(100), -- 담보레벨1명
  cvr_lvl_2_cd character(10), -- 담보레벨2코드
  cvr_lvl_2_nm character varying(100), -- 담보레벨2명
  cvr_lvl_3_cd character(10), -- 담보레벨3코드
  cvr_lvl_3_nm character varying(100), -- 담보레벨3명
  cvr_lvl_4_cd character(10), -- 담보레벨4코드
  cvr_lvl_4_nm character varying(100), -- 담보레벨4명
  load_dthms timestamp(0) without time zone
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (cvrcd);