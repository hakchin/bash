CREATE TABLE sam_stf
(
  stfno character(7) NOT NULL, -- 직원번호
  stf_bz_stcd character(10) NOT NULL, -- 직원영업상태코드
  stadt date NOT NULL, -- 상태일자
  rsno character varying(40) NOT NULL, -- 주민번호
  nm character varying(100) NOT NULL, -- 성명
  mail_id character varying(50), -- 이메일아이디
  mail_domn character varying(50), -- 이메일도메인
  hmpag_adr character varying(100), -- 홈페이지주소
  blog_adr character varying(100), -- 블로그주소
  bkcd character(10), -- 은행코드
  actno character varying(20), -- 계좌번호
  actno_chdt date, -- 계좌번호변경일자
  ntrdt date, -- 입사일자
  retdt date NOT NULL, -- 퇴사일자
  incb_rscd character(10), -- 해촉사유코드
  stf_flgcd character(10) NOT NULL, -- 직원구분코드
  fnl_edbcd character(10), -- 최종학력코드
  hnor_cmp_stf_yn character(1), -- 명예보상직원여부
  adm_orgn_wrk_strdt date, -- 관리조직근무시작일자
  adm_orgn_wrk_nddt date, -- 관리조직근무종료일자
  rl_brtyr_mndy character(8), -- 실제생년월일
  slcr_flgcd character(10), -- 양음구분코드
  apo_flgcd character(10), -- 위촉구분코드
  crnt_orgcd character(7), -- 현재기관코드
  crnt_tm_orgcd character(7), -- 현재팀기관코드
  adm_orgcd character(7), -- 관리기관코드
  relco_stfno character(7), -- 관계회사직원번호
  scil_crrcd character(10), -- 사회경력코드
  photo_pth character varying(256), -- 사진경로
  crnt_pst_apodt date, -- 현재소속발령일자
  bdtcd character(10), -- 직무코드
  bdt_apodt date, -- 직무발령일자
  dtycd character(10), -- 직책코드
  dty_apodt date, -- 직책발령일자
  ptncd character(10), -- 직위코드
  ptn_apodt date, -- 직위발령일자
  clpcd character(10), -- 직급코드
  pays_cd character(10), -- 호봉코드
  grdpa_apodt date, -- 급호발령일자
  rtm_rscd character(10), -- 퇴직사유코드
  wdg_yn character(1), -- 결혼여부
  drve_lic_own_yn character(1), -- 운전면허소유여부
  indc_stfno character(7), -- 유치자직원번호
  indc_relcd character(10), -- 유치자관계코드
  atr_flgcd character(10), -- 유치구분코드
  befo_stfno character(7), -- 이전직원번호
  adm_stfno character(7), -- 관리직원번호
  stfno_grtdt date, -- 직원번호부여일자
  intr_tpcd character(10), -- 도입유형코드
  bz_atrcd character(10), -- 영업속성코드
  bz_atr_chdt date, -- 영업속성변경일자
  psn_grdcd character(10), -- 개인등급코드
  psn_grd_grtdt date, -- 개인등급부여일자
  psn_grd_nddt date, -- 개인등급종료일자
  bz_fml_qufcd character(10), -- 영업가족자격코드
  quf_dlgdt date, -- 자격위임일자
  bz_fml_tmnd_grdcd character(10), -- 영업가족팀장등급코드
  quf_grd_chdt date, -- 자격등급변경일자
  quf_grd_nddt date, -- 자격등급종료일자
  pstn_chccd character(10), -- 신분변동코드
  pstn_chcdt date, -- 신분변동일자
  club_mbr_grdcd character(10), -- 클럽멤버등급코드
  club_mbr_grd_grtdt date, -- 클럽멤버등급부여일자
  club_mbr_grd_nddt date, -- 클럽멤버등급종료일자
  trf_mncd character(10), -- 교통수단코드
  attd_nd_timcd character(10), -- 출근소요시간코드
  notb_own_yn character(1), -- 노트북소유여부
  onfml_pf_yn character(1), -- 한가족우대여부
  onfml_pf_grd_grdcd character(10), -- 한가족우대등급코드
  onfml_pf_grd_grtdt date, -- 한가족우대등급부여일자
  onfml_pf_grd_nddt date, -- 한가족우대등급종료일자
  atch_yn character(1), -- 전속여부
  atch_yn_chdt date, -- 전속여부변경일자
  agy_quf_grdcd character(10), -- 대리점자격등급코드
  agy_quf_grd_chdt date, -- 대리점자격등급변경일자
  agy_pntcd character(10), -- 대리점인격코드
  agy_pntcd_chdt date, -- 대리점인격코드변경일자
  offc_accpt_flgcd character(10), -- 점포수용구분코드
  agynm character varying(100), -- 대리점명
  pdtnm character varying(100), -- 대표자명
  org_rgt_cmpcd character(10), -- 원등록회사코드
  cm_ap_gpcd character(10), -- 수수료적용그룹코드
  bzmno character(10), -- 사업자번호
  admr_stfno character(7), -- 관리자직원번호
  admr_apodt date, -- 관리자발령일자
  st_stfno character(7), -- 기준직원번호
  inp_usr_id character(7) NOT NULL, -- 입력사용자id
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자id
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  aconm character varying(100), -- 계좌주명
  ltrm_aw_gpcd character(10), -- 장기수당그룹코드
  ltrm_aw_gp_chdt date, -- 장기수당그룹변경일자
  fr_ntr_cmpcd character(10), -- 최초입사회사코드
  fire_stfno character(7), -- 화재직원번호
  brc_orgcd character(7), -- 지사기관코드
  crnt_brc_apodt date, -- 현재지사발령일자
  grpwr_us_yn character(1), -- 그룹웨어사용여부
  msngr_us_yn character(1), -- 메신저사용여부
  bz_stch_rscd character(10), -- 영업상태변경사유코드
  adm_agycd character(7), -- 관리대리점코드
  adm_agy_apodt date, -- 관리대리점발령일자
  adm_stf_apodt date, -- 관리직원발령일자
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (stfno);