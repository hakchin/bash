CREATE TABLE m_sam_vl_wkdgr_adm
(
  vl_yr character(4) NOT NULL, -- 평가년도
  vl_wkdgr numeric(2) NOT NULL, -- 평가주차수
  wkdgr_strdt date NOT NULL, -- 주차수시작일자
  wkdgr_nddt date NOT NULL, -- 주차수종료일자
  load_dthms timestamp(0) without time zone
)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (vl_yr, vl_wkdgr);
