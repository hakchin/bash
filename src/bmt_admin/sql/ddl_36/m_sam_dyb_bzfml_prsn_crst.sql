CREATE TABLE m_sam_dyb_bzfml_prsn_crst
(
  av_yymm character(6) NOT NULL, -- 실적년월
  av_stdt date NOT NULL, -- 실적기준일자
  stfno character(7) NOT NULL, -- 직원번호
  apo_stbdt date, -- 위촉개설일자
  apo_stb_mmthr numeric(5), -- 위촉개설차월
  sty_yn character(1), -- 정착여부
  ltrm_actvt_yn character(1), -- 장기가동여부
  cr_actvt_yn character(1), -- 자동차가동여부
  gn_actvt_yn character(1), -- 일반가동여부
  std_actvt_flgcd character(10), -- 표준가동구분코드
  std_act_yn character(1), -- 표준활동여부
  tmr_mnth_cnv_hms numeric(3), -- TMR월통화시간
  cm_bz_days numeric(3), -- 당월영업일수
  ltrm_extn_av_yn character(1), -- 장기유실적여부
  cr_extn_av_yn character(1), -- 자동차유실적여부
  gn_extn_av_yn character(1), -- 일반유실적여부
  edu_ntd_yymm character(6), -- 교육입과년월
  edu_crscd character(10), -- 교육과정코드
  edu_prg_stcd character(10), -- 교육진행상태코드
  edu_crs_vl_mmdgr numeric(5), -- 교육과정평가차월차수
  ltrm_gnte_nwcct numeric(10), -- 장기보장성신계약건수
  ltrm_cumt_nwcct numeric(10), -- 장기적립성신계약건수
  ltrm_gnte_nwcr_prm numeric(15), -- 장기보장성신계약보험료
  ltrm_cumt_nwcr_prm numeric(15), -- 장기적립성신계약보험료
  ltrm_gnte_nwmcv_prm numeric(15), -- 장기보장성신계약월납환산보험료
  ltrm_cumt_nwmcv_prm numeric(15), -- 장기적립성신계약월납환산보험료
  ltrm_gnte_nwccv_avamt numeric(17,2), -- 장기보장성신계약환산실적금액
  ltrm_cumt_nwccv_avamt numeric(17,2), -- 장기적립성신계약환산실적금액
  ltrm_gnte_ctu_prm numeric(15), -- 장기보장성계속보험료
  ltrm_cumt_ctu_prm numeric(15), -- 장기적립성계속보험료
  cr_tot_nwcct numeric(10), -- 자동차전체신계약건수
  cr_tot_nwct numeric(10), -- 자동차전체신규건수
  cr_tot_avamt numeric(17,2), -- 자동차전체실적금액
  cr_cv_avamt numeric(17,2), -- 자동차환산실적금액
  gn_ins_nwcct numeric(10), -- 일반보험신계약건수
  gn_ins_avamt numeric(17,2), -- 일반보험실적금액
  cmins_cv_avamt numeric(17,2), -- 일반보험환산실적금액
  ltrm_prdt_grd character(10), -- 장기생산성등급
  pcked_prdt_grd character(10), -- 정예생산성등급
  cr_vl_av numeric(15), -- 자동차평가실적
  cr_cash_vl_av numeric(15), -- 자동차현금평가실적
  cr_crd_vl_av numeric(15), -- 자동차카드평가실적
  cr_vlct numeric(10), -- 자동차평가건수
  bz_mmthr numeric(5), -- 영업차월
  load_dthms timestamp(0) without time zone
)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,  OIDS=FALSE)
DISTRIBUTED BY (av_yymm, av_stdt, stfno)