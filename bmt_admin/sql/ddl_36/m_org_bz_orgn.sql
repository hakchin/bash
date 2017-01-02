CREATE TABLE m_org_bz_orgn
(
  stfno character(7) NOT NULL, -- 직원번호
  stfnm character varying(100), -- 직원명
  rsno character varying(40), -- 주민번호
  nm character varying(100), -- 성명
  bz_part_flgcd character(10), -- 영업부문구분코드
  bz_part_flgnm character varying(100), -- 영업부문구분명
  hdqt_orgcd character(7), -- 본부기관코드
  hdqnm character varying(100), -- 본부명
  hdqt_org_ordr numeric(5), -- 본부기관순서
  hdqt_org_spcd character(10), -- 본부기관특성코드
  hdqt_org_tpcd character(10), -- 본부기관유형코드
  br_orgcd character(7), -- 지점기관코드
  brnm character varying(100), -- 지점명
  br_org_ordr numeric(5), -- 지점기관순서
  br_org_spcd character(10), -- 지점기관특성코드
  br_org_tpcd character(10), -- 지점기관유형코드
  bzp_orgcd character(7), -- 영업소기관코드
  bzp_nm character varying(100), -- 영업소명
  bzp_org_ordr numeric(5), -- 영업소기관순서
  bzp_org_spcd character(10), -- 영업소기관특성코드
  bzp_org_tpcd character(10), -- 영업소기관유형코드
  tm_orgcd character(7), -- 팀기관코드
  tmnm character varying(100), -- 팀명
  tm_org_ordr numeric(5), -- 팀기관순서
  tm_org_spcd character(10), -- 팀기관특성코드
  tm_org_tpcd character(10), -- 팀기관유형코드
  tm_kndcd character(10), -- 팀종류코드
  org_rgt_cmpcd character(10), -- 원등록회사코드
  stfno_grtdt date, -- 직원번호부여일자
  ntrdt date, -- 입사일자
  retdt date, -- 퇴사일자
  stadt date, -- 상태일자
  stf_bz_stcd character(10), -- 직원영업상태코드
  sexcd character(10), -- 성별코드
  age numeric(3), -- 연령
  wdg_yn character(1), -- 결혼여부
  indc_stfno character(7), -- 유치자직원번호
  indc_relcd character(10), -- 유치자관계코드
  stf_flgcd character(10), -- 직원구분코드
  fnl_edbcd character(10), -- 최종학력코드
  apo_stb_mmthr numeric(5), -- 위촉개설차월
  adm_orgcd character(7), -- 관리기관코드
  ppr_adm_orgcd character(7), -- 상위관리기관코드
  atch_yn character(1), -- 전속여부
  bdtcd character(10), -- 직무코드
  dtycd character(10), -- 직책코드
  agy_quf_grdcd character(10), -- 대리점자격등급코드
  agy_pntcd character(10), -- 대리점인격코드
  admr_stfno character(7), -- 관리자직원번호
  admr_stf_nm character varying(100), -- 관리자직원성명
  st_stfno character(7), -- 기준직원번호
  intr_tpcd character(10), -- 도입유형코드
  ins_crr_btpcd character(10), -- 보험경력업종코드
  scil_crrcd character(10), -- 사회경력코드
  bz_atrcd character(10), -- 영업속성코드
  psn_grdcd character(10), -- 개인등급코드
  bz_fml_tmnd_grdcd character(10), -- 영업가족팀장등급코드
  bz_fml_qufcd character(10), -- 영업가족자격코드
  pstn_chccd character(10), -- 신분변동코드
  pstn_chcdt date, -- 신분변동일자
  rapo_yn character(1), -- 재위촉여부
  club_mbr_grdcd character(10), -- 클럽멤버등급코드
  onfml_pf_yn character(1), -- 한가족우대여부
  adm_stfno character(7), -- 관리직원번호
  stf_rsdpl_sd character varying(30), -- 직원거주지시도
  stf_rsdpl_sgng character varying(30), -- 직원거주지시군구
  stf_rsdpl_twmd character varying(30), -- 직원거주지읍면동
  xstf_bz_flgcd character(10), -- 임직원영업구분코드
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (stfno);