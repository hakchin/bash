CREATE TABLE m_sam_stf_srtr_orgn
(
  st_yymm character(6) NOT NULL, -- 기준년월
  stfno character(7) NOT NULL, -- 직원번호
  stfnm character varying(100), -- 직원명
  stf_ordcd character(7), -- 직원순서코드
  rsno character varying(40), -- 주민번호
  cmpcd character(10), -- 회사코드
  cmpnm character varying(100) NOT NULL, -- 회사명
  bzndp_orgcd character(7), -- 사업부기관코드
  bzndp_orgnm character varying(100), -- 사업부기관명
  hdqt_orgcd character(7), -- 본부기관코드
  hdqt_orgnm character varying(100), -- 본부기관명
  hdqt_org_ordr numeric(5), -- 본부기관순서
  hdqt_org_stbdt date, -- 본부기관개설일자
  hdqt_org_clodt date, -- 본부기관폐쇄일자
  hdqt_orghd_stfno character(7), -- 본부기관장직원번호
  hdqt_orghd_nm character varying(100), -- 본부기관장성명
  spgp_orgcd character(7), -- 지원단기관코드
  spgp_orgnm character varying(100), -- 지원단기관명
  spgp_org_ordr numeric(5), -- 지원단기관순서
  spgp_org_stbdt date, -- 지원기관개설일자
  spgp_org_clodt date, -- 지원기관폐쇄일자
  spgp_orghd_stfno character(7), -- 지원단기관장직원번호
  spgp_orghd_nm character varying(100), -- 지원단기관장성명
  br_orgcd character(7), -- 지점기관코드
  br_orgnm character varying(100), -- 지점기관명
  br_org_ordr numeric(5), -- 지점기관순서
  br_org_stbdt date, -- 지점기관개설일자
  br_org_clodt date, -- 지점기관폐쇄일자
  br_orghd_stfno character(7), -- 지점기관장직원번호
  br_orghd_nm character varying(100), -- 지점기관장성명
  bzp_orgcd character(7), -- 영업소기관코드
  bzp_orgnm character varying(100), -- 영업소기관명
  bzp_org_ordcd character(7), -- 영업소기관순서코드
  bzp_org_stbdt date, -- 영업소기관개설일자
  bzp_org_clodt date, -- 영업소기관폐쇄일자
  bzp_orghd_stfno character(7), -- 영업소기관장직원번호
  bzp_orghd_nm character varying(100), -- 영업소기관장성명
  bzp_org_tpcd character(10), -- 영업소기관유형코드
  bzp_org_tpnm character varying(100), -- 영업소기관유형명
  bzp_org_spcd character(10), -- 영업소기관특성코드
  bzp_org_spnm character varying(100), -- 영업소기관특성명
  stf_org_flgcd character(7), -- 직원기관구분코드
  tm_orgcd character(7), -- 팀기관코드
  tmnm character varying(100), -- 팀명
  tm_org_ordcd character(7), -- 팀기관순서코드
  tm_org_stbdt date, -- 팀기관개설일자
  tm_org_clodt date, -- 팀기관폐쇄일자
  adm_stfno character(7), -- 관리직원번호
  adm_stfnm character varying(100), -- 관리직원명
  adm_stf_ordcd character(10), -- 관리직원순서코드
  adm_stf_ntrdt date, -- 관리직원입사일자
  adm_stf_retdt date, -- 관리직원퇴사일자
  usr_yn character(1), -- 사용인여부
  prs_agyno character(7), -- 대표대리점번호
  prs_agynm character varying(100), -- 대표대리점명
  prs_agy_ordcd character(10), -- 대표대리점순서코드
  prs_agy_ntrdt date, -- 대표대리점입사일자
  prs_agy_retdt date, -- 대표대리점퇴사일자
  plz_bzp_orgcd character(7), -- 프라자영업소기관코드
  plz_bzp_orgnm character varying(100), -- 프라자영업소기관명
  plz_bzp_org_ordr numeric(5), -- 프라자영업소기관순서
  plz_br_orgcd character(7), -- 프라자지점기관코드
  plz_br_orgnm character varying(100), -- 프라자지점기관명
  plz_br_org_ordr numeric(5), -- 프라자지점기관순서
  onl_bz_yn character(1), -- 온라인영업여부
  ntrdt date, -- 입사일자
  retdt date, -- 퇴사일자
  stfno_grtdt date, -- 직원번호부여일자
  stf_bz_stcd character(10), -- 직원영업상태코드
  stadt date, -- 상태일자
  sexcd character(10), -- 성별코드
  indc_stfno character(7), -- 유치자직원번호
  indc_relcd character(10), -- 유치자관계코드
  stf_flgcd character(10), -- 직원구분코드
  apo_stb_mmthr numeric(5), -- 위촉개설차월
  atch_yn character(1), -- 전속여부
  bdtcd character(10), -- 직무코드
  dtycd character(10), -- 직책코드
  agy_quf_grdcd character(10), -- 대리점자격등급코드
  agy_pntcd character(10), -- 대리점인격코드
  pdtnm character varying(100), -- 대표자명
  intr_tpcd character(10), -- 도입유형코드
  bz_atrcd character(10), -- 영업속성코드
  psn_grdcd character(10), -- 개인등급코드
  bz_fml_qufcd character(10), -- 영업가족자격코드
  bz_fml_tmnd_grdcd character(10), -- 영업가족팀장등급코드
  pstn_chccd character(10), -- 신분변동코드
  club_mbr_grdcd character(10), -- 클럽멤버등급코드
  onfml_pf_yn character(1), -- 한가족우대여부
  onfml_pf_grd_grdcd character(10), -- 한가족우대등급코드
  sty_yn character(1), -- 정착여부
  clpo_bz_yn character(1), -- 직급영업여부
  ltrm_actvt_yn character(1), -- 장기가동여부
  cr_actvt_yn character(1), -- 자동차가동여부
  gn_actvt_yn character(1), -- 일반가동여부
  std_act_yn character(1), -- 표준활동여부
  std_actvt_flgcd character(10), -- 표준가동구분코드
  nwfac_grdcd character(10), -- 신인등급코드
  pstn_chcdt date, -- 신분변동일자
  pstn_chc_yn character(1), -- 신분변동여부
  bz_tpcd character(10), -- 영업유형코드
  gn_av_incld_yn character(1), -- 일반실적포함여부
  adm_stf_apodt date, -- 관리직원발령일자
  adm_agycd character(7), -- 관리대리점코드
  adm_agy_apodt date, -- 관리대리점발령일자
  load_dthms timestamp(0) without time zone
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (st_yymm, stfno)