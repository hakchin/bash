CREATE TABLE m_org_org_ordr
(
  orgcd character(7) NOT NULL, -- 기관코드
  crnt_org_ordr numeric(5), -- 현재기관순서
  ap_dt date, -- 적용일자
  org_ordr numeric(5), -- 기관순서
  orgnm character varying(100), -- 기관명
  org_shtnm character varying(100), -- 기관단축명
  orgcd_orgnm character varying(100), -- 기관코드기관명
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (orgcd);