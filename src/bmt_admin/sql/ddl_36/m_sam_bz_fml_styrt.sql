CREATE TABLE m_sam_bz_fml_styrt
(
  st_yymm character(6) NOT NULL, -- 기준년월
  stfno character(7) NOT NULL, -- 직원번호
  apo_yymm character(6), -- 위촉년월
  pstn_chccd character(10), -- 신분변동코드
  stf_bz_stcd character(10), -- 직원영업상태코드
  onfml_pfaw_ben_yn character(1), -- 한가족우대수당수혜여부
  nwfac_actaw_ben_yn character(1), -- 신인활동수당수혜여부
  sty_spaw_ben_yn character(1), -- 정착지원수당수혜여부
  sty_yn character(1), -- 정착여부
  edu_crscd character(10), -- 교육과정코드
  edu_ntd_yymm character(6), -- 교육입과년월
  o1mm_dpl_yn character(1), -- 1차월수료여부
  o2mm_dpl_yn character(1), -- 2차월수료여부
  o3mm_dpl_yn character(1), -- 3차월수료여부
  edu_prg_stcd character(10), -- 교육진행상태코드
  edu_crs_vl_mmdgr numeric(5), -- 교육과정평가차월차수
  sty_st_awamt numeric(17,2), -- 정착기준수당금액
  ce_st_awamt numeric(17,2), -- 모집기준수당금액
  load_dthms timestamp(0) without time zone
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (st_yymm, stfno)