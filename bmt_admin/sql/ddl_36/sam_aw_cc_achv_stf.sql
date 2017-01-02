CREATE TABLE sam_aw_cc_achv_stf
(
  av_yymm character(6) NOT NULL, -- 실적년월
  stfno character(7) NOT NULL, -- 직원번호
  nm character varying(100) NOT NULL, -- 성명
  apo_or_stbdt date NOT NULL, -- 위촉/개설일자
  apo_or_stb_mmthr numeric(5) NOT NULL, -- 위촉/개설차월
  fnl_cls_yn character(1) NOT NULL, -- 최종마감여부
  psgcd character(7), -- 소속기관코드
  tm_orgcd character(7), -- 팀기관코드
  stf_flgcd character(10) NOT NULL, -- 직원구분코드
  intr_tpcd character(10), -- 도입유형코드
  bz_atrcd character(10), -- 영업속성코드
  stf_bz_stcd character(10), -- 직원영업상태코드
  psn_grdcd character(10), -- 개인등급코드
  bz_fml_qufcd character(10), -- 영업가족자격코드
  bz_fml_tmnd_grdcd character(10), -- 영업가족팀장등급코드
  atch_yn character(1) NOT NULL, -- 전속여부
  agy_quf_grdcd character(10), -- 대리점자격등급코드
  agy_pntcd character(10), -- 대리점인격코드
  club_mbr_grdcd character(10), -- 클럽멤버등급코드
  onfml_pf_grd_grdcd character(10), -- 한가족우대등급코드
  tmr_mnth_cnv_hms numeric(3), -- TMR월통화시간
  bz_mmthr numeric(5), -- 영업차월
  stadt date, -- 상태일자
  psn_grd_grtdt date, -- 개인등급부여일자
  quf_dlgdt date, -- 자격위임일자
  quf_grd_chdt date, -- 자격등급변경일자
  club_mbr_grd_grtdt date, -- 클럽멤버등급부여일자
  onfml_pf_grd_grtdt date, -- 한가족우대등급부여일자
  nwfac_grdcd character(10), -- 신인등급코드
  inp_usr_id character(7) NOT NULL, -- 입력사용자ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  ltrm_aw_gpcd character(10), -- 장기수당그룹코드
  org_vl_gp_flgcd character(10), -- 기관평가그룹구분코드
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (av_yymm, stfno);