CREATE TABLE cus_ctm
(
  ctmno character(9) NOT NULL, -- 고객번호
  ctm_dscno character varying(40), -- 고객식별번호
  hngl_ctmnm character varying(100) NOT NULL, -- 한글고객명
  eng_ctmnm character varying(100), -- 영문고객명
  chnc_ctmnm character varying(100), -- 한문고객명
  hngl_abrv_ctmnm character varying(100), -- 한글축약고객명
  eng_abrv_ctmnm character varying(100), -- 영문축약고객명
  ctm_tpcd character(10) NOT NULL, -- 고객유형코드
  cr_own_yn character(1), -- 차량소유여부
  drve_yn character(1), -- 운전여부
  ctm_dat_acq_ptncd character(10), -- 고객데이터획득경로코드
  frg_dlpl_flgcd character(10), -- 경품배달처구분코드
  fmllv_ctm_yn character(1), -- 가족사랑고객여부
  hmpag_adr character varying(100), -- 홈페이지주소
  cybmy character varying(50), -- 사이버머니
  sms_rcv_yn character(1), -- sms수신여부
  rlnm_ctfct_file_pth character varying(100), -- 실명증표파일경로
  cntrt_st_rq_yn character(1), -- 접촉정지요청여부
  tl_rcv_yn character(1), -- 전화수신여부
  crdif_utl_agre_yn character(1), -- 신용정보활용동의여부
  mail_rcv_yn character(1), -- 이메일수신여부
  rgbrd_flgcd character(10), -- 내외국구분코드
  mntr_bkcd character(10), -- 주거래은행코드
  mntr_bk_brcd character(10), -- 주거래은행지점코드
  et_adr_flgcd character(10), -- 기타주소구분코드
  cnn_cmpcd character(10), -- 관련회사코드
  ctm_dscno_flgcd character(10), -- 고객식별번호구분코드
  spcl_rel_ctm_yn character(1), -- 특수관계자고객여부
  pdt_rsno character varying(40), -- 대표자주민번호
  pdtnm character varying(100), -- 대표자명
  indpd_mrtmn_yn character(1), -- 독립유공자여부
  dflt_pt_yn character(1), -- 고엽제환자여부
  dmrcy_518_injd_yn character(1), -- 민주518부상자여부
  rltn_bzwpl_cd character(10), -- 연계사업장코드
  rltn_bzwpl_seqno numeric(5), -- 연계사업장순번
  bzps_tpcd character(10), -- 사업자유형코드
  ntp_sclcd character(10), -- 기업규모코드
  bzps_bstnm character varying(100), -- 사업자업태명
  bzps_imnm character varying(100), -- 사업자종목명
  empct numeric(7), -- 종업원수
  slamt numeric(15) NOT NULL, -- 매출액
  capt numeric(15) NOT NULL, -- 자본금
  fnddt date, -- 설립일자
  clodt date, -- 폐쇄일자
  dlncd character(10), -- 거래선코드
  bzwpl_own_yn character(1), -- 사업장소유여부
  mn_pdt_out_pdtct numeric(7), -- 주대표자외대표자수
  bdl_tf_pypsb_yn character(1), -- 일괄이체지급가능여부
  std_ind_csfcd character(10), -- 표준산업분류코드
  nty_tycd character(10), -- 기업형태코드
  lstst_flgcd character(10), -- 상장구분코드
  crpno character varying(13), -- 법인번호
  clgmm_flgcd character(10), -- 결산월구분코드
  gr_flgcd character(10), -- 단체구분코드
  gr_tpcd character(10), -- 단체유형코드
  bzmno character(10), -- 사업자번호
  crp_tpcd character(10), -- 법인유형코드
  wdg_yn character(1), -- 결혼여부
  relgn_cd character(10), -- 종교코드
  fnl_edbcd character(10), -- 최종학력코드
  hndps_yn character(1), -- 장애인여부
  hnd_grdcd character(10), -- 장애등급코드
  hnd_grd_vald_trm character(8), -- 장애등급유효기간
  hndnm character varying(100), -- 장애명
  hnd_grdpa_cd character(10), -- 장애급호코드
  ntn_mrtmn_yn character(1), -- 국가유공자여부
  rwxno character varying(20), -- 보훈번호
  btplc_cd character(10), -- 출생지코드
  grdu_sch character varying(50), -- 출신학교
  slcr_flgcd character(10), -- 양음구분코드
  rl_brtyr_mndy character(8), -- 실제생년월일
  rh_tycd character(10), -- rh형태코드
  bldty_cd character(10), -- 혈액형코드
  wpcnm character varying(100), -- 직장명
  depnm character varying(100), -- 부서명
  ptn character varying(50), -- 직위
  bdt character varying(50), -- 직무
  jb_dt character varying(50), -- 직업상세
  emp_tycd character(10), -- 고용형태코드
  wrk_arecd character(10), -- 근무지역코드
  sexcd character(10), -- 성별코드
  ba_life_sadps_yn character(1), -- 기초생활수급자여부
  smok_yn character(1), -- 흡연여부
  de_yn character(1), -- 사망여부
  htn character varying(50), -- 고향
  wot_yn character(1), -- 맞벌이여부
  frg_rlnm_ctfct_flgcd character(10), -- 외국인실명증표구분코드
  ntlcd character(10), -- 국적코드
  pspno character varying(20), -- 여권번호
  jb_ch_seqno numeric(5), -- 직업변경순번
  jbcd character(10), -- 직업코드
  injr_rnkcd character(10), -- 상해급수코드
  onw_jb_cnf_flgcd character(10), -- 신구직업확인구분코드
  rltn_bzwpl_pstdt date, -- 연계사업장소속일자
  rltn_bzwpl_rgtr_flgcd character(10), -- 연계사업장등록자구분코드
  inp_usr_id character(7) NOT NULL, -- 입력사용자id
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자id
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  psn_info_cvap_yn character(1), -- 개인정보민원여부
  rcmnm character varying(100), -- 추천인명
  rcm_rsno character varying(40), -- 추천인주민번호
  dher_rcm_relcd character(10), -- 취급자추천인관계코드
  rlnm_cnf_flgcd character(10), -- 실명확인구분코드
  ntclt_mail_rcv_yn character(1), -- 안내문이메일수신여부
  bnnm character varying(300), -- 업종명
  bzfml_sms_lmit_yn character(1), -- 영업가족SMS제한여부
  cnv_hp_tmst_cd character(10) , -- 통화희망시간대코드
  load_dthms timestamp(0) without time zone
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (ctmno);