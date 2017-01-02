CREATE TABLE sam_aw_cc_achv
(
  av_yymm character(6) NOT NULL, -- 실적년월
  stfno character(7) NOT NULL, -- 직원번호
  av_stdt date NOT NULL, -- 실적기준일자
  sty_yn character(1) NOT NULL, -- 정착여부
  ltrm_actvt_yn character(1), -- 장기가동여부
  cr_actvt_yn character(1), -- 자동차가동여부
  gn_actvt_yn character(1), -- 일반가동여부
  std_actvt_flgcd character(10), -- 표준가동구분코드
  std_act_yn character(1), -- 표준활동여부
  cm_bz_days numeric(3), -- 당월영업일수
  cm_inq_prse_days numeric(3), -- 당월조회참석일수
  cm_inq_prcv_days numeric(3), -- 당월조회지각일수
  cm_rtof_days numeric(3), -- 당월귀소일수
  cv_psct numeric(7,1) NOT NULL, -- 환산인원수
  achv_kndcd character(10) NOT NULL, -- 업적종류코드
  ltrm_dcn_prm numeric(15) NOT NULL, -- 장기확정보험료
  adpym_xcpt_ctu_prm numeric(15) NOT NULL, -- 추가납입제외계속보험료
  du_dcn_prm numeric(15) NOT NULL, -- 응당확정보험료
  doamt numeric(15) NOT NULL, -- 응당수금액
  t2_du_dcprm numeric(15) NOT NULL, -- 2회응당확정보험료
  t2_du_cmamt numeric(15) NOT NULL, -- 2회응당수금액
  ppy_xcpt_cm_av numeric(15) NOT NULL, -- 선납제외수금실적
  ltrm_inr_ins_cmamt numeric(15) NOT NULL, -- 장기통합보험수금액
  ltrm_inr_dcn_prm numeric(15) NOT NULL, -- 장기통합보험확정보험료
  ltrm_gnte_nwcct numeric(10) NOT NULL, -- 장기보장성신계약건수
  ltrm_cumt_nwcct numeric(10) NOT NULL, -- 장기적립성신계약건수
  ltrm_gnte_nwcr_prm numeric(15) NOT NULL, -- 장기보장성신계약보험료
  ltrm_cumt_nwcr_prm numeric(15) NOT NULL, -- 장기적립성신계약보험료
  ltrm_gnte_nwccv_av numeric(15) NOT NULL, -- 장기보장성신계약환산실적
  ltrm_cumt_nwccv_av numeric(15) NOT NULL, -- 장기적립성신계약환산실적
  ltrm_gnte_nwmcv_prm numeric(15) NOT NULL, -- 장기보장성신계약월납환산보험료
  ltrm_cumt_nwmcv_prm numeric(15) NOT NULL, -- 장기적립성신계약월납환산보험료
  ltrm_gnte_ctu_prm numeric(15) NOT NULL, -- 장기보장성계속보험료
  ltrm_cumt_ctu_prm numeric(15) NOT NULL, -- 장기적립성계속보험료
  tmr_ltrm_vl_av numeric(15) NOT NULL, -- TMR장기평가실적
  ltrm_inr_insct numeric(10) NOT NULL, -- 장기통합보험건수
  ltrm_inr_ins_prm numeric(15) NOT NULL, -- 장기통합보험보험료
  ltinr_ins_nwmcv_prm numeric(15) NOT NULL, -- 장기통합보험신계약월납환산보험료
  ltinr_ins_nwccv_av numeric(15) NOT NULL, -- 장기통합보험신계약환산실적
  vald_crgac_incm_prm numeric(15) NOT NULL, -- 유효계약보장성누계수입보험료
  vald_crsac_cv_av numeric(15) NOT NULL, -- 유효계약저축성누계환산실적
  o2mm_nmtn_cvav numeric(15) NOT NULL, -- 2차월미유지환산실적
  nmtn_mpy_cv_prm numeric(15) NOT NULL, -- 미유지월납환산보험료
  aw_pylts_gdct numeric(10) NOT NULL, -- 수당지급장기전략상품건수
  aw_pylts_gd_prm numeric(15) NOT NULL, -- 수당지급장기전략상품보험료
  ctu_ins_mpy_cvprm numeric(15) NOT NULL, -- 계속보험월납환산보험료
  fsyr_ctupr_cv_av numeric(15) NOT NULL, -- 초년도계속보험료환산실적
  mn_aw_stamt numeric(15) NOT NULL, -- 유지수당기준액
  o16mm_ctu_cmamt numeric(15) NOT NULL, -- 16차월계속수금액
  o25mm_ctu_cmamt numeric(15) NOT NULL, -- 25차월계속수금액
  t4s_cv_av numeric(15) NOT NULL, -- 4회차환산실적
  t7s_cv_av numeric(15) NOT NULL, -- 7회차환산실적
  t13s_cv_av numeric(15) NOT NULL, -- 13회차환산실적
  t20s_cv_av numeric(15) NOT NULL, -- 20회차환산실적
  ltrm_tm_gd_prm numeric(15) NOT NULL, -- 장기TM상품보험료
  ltrm_bncgd_prm numeric(15) NOT NULL, -- 장기방카상품보험료
  rtman_xc_prm numeric(15) NOT NULL, -- 퇴직연금전용보험료
  gn_ins_av numeric(15) NOT NULL, -- 일반보험실적
  gn_ins_cv_av numeric(15) NOT NULL, -- 일반보험환산실적
  carg_ins_u2030_prm numeric(15) NOT NULL, -- 적재물보험2030대미만보험료
  carg_ins_a30c_prm numeric(15) NOT NULL, -- 적재물보험30대이상보험료
  cmins_nwcr_av numeric(15) NOT NULL, -- 일반보험신계약실적
  gn_ins_nwcct numeric(10) NOT NULL, -- 일반보험신계약건수
  cmins_hse_av numeric(15) NOT NULL, -- 일반보험가계성실적
  cmins_spc_av numeric(15) NOT NULL, -- 일반보험특종실적
  cmins_carg_av numeric(15) NOT NULL, -- 일반보험적하실적
  cmins_fire_av numeric(15) NOT NULL, -- 일반보험화재실적
  cmins_vsl_av numeric(15) NOT NULL, -- 일반보험선박실적
  co_xcpt_cr_av numeric(15) NOT NULL, -- 공동제외자동차실적
  cr_a_arect numeric(10) NOT NULL, -- 자동차A지역건수
  cr_a_are_av numeric(15) NOT NULL, -- 자동차A지역실적
  cr_b_arect numeric(10) NOT NULL, -- 자동차B지역건수
  cr_b_are_av numeric(15) NOT NULL, -- 자동차B지역실적
  cr_c_arect numeric(10) NOT NULL, -- 자동차C지역건수
  cr_c_areav numeric(15) NOT NULL, -- 자동차C지역실적
  cr_etct numeric(10) NOT NULL, -- 자동차기타건수
  cr_et_av numeric(15) NOT NULL, -- 자동차기타실적
  crcs_vlct numeric(10) NOT NULL, -- 자동차비평가건수
  crcs_vl_av numeric(15) NOT NULL, -- 자동차비평가실적
  cr_vl_av numeric(15) NOT NULL, -- 자동차평가실적
  cr_cash_vl_av numeric(15) NOT NULL, -- 자동차현금평가실적
  cr_crd_vl_av numeric(15) NOT NULL, -- 자동차카드평가실적
  cr_cv_av numeric(15) NOT NULL, -- 자동차환산실적
  cr_cash_cv_av numeric(15) NOT NULL, -- 자동차현금환산실적
  cr_crd_cv_av numeric(15) NOT NULL, -- 자동차카드환산실적
  cr_ppych_cv_av numeric(15) NOT NULL, -- 자동차선납현금환산실적
  cr_ppycr_cv_av numeric(15) NOT NULL, -- 자동차선납카드환산실적
  crmrt_xcpt_vl_av numeric(15) NOT NULL, -- 카메리트제외평가실적
  crmrt_xcpt_cavl_av numeric(15) NOT NULL, -- 카메리트제외현금평가실적
  crmrt_xcpt_crdvl_av numeric(15) NOT NULL, -- 카메리트제외카드평가실적
  crmrt_xcpt_cv_av numeric(15) NOT NULL, -- 카메리트제외환산실적
  crmrt_xcpt_cacv_av numeric(15) NOT NULL, -- 카메리트제외현금환산실적
  crmrt_xcpt_crdcv_av numeric(15) NOT NULL, -- 카메리트제외카드환산실적
  crmrt_xcpt_ppych_cvav numeric(15) NOT NULL, -- 카메리트제외선납현금환산실적
  crmrt_xcpt_ppycr_cvav numeric(15) NOT NULL, -- 카메리트제외선납카드환산실적
  cr_inr_insct numeric(10) NOT NULL, -- 자동차통합보험건수
  cr_inr_ins_av numeric(15) NOT NULL, -- 자동차통합보험실적
  cr_crn_nwct numeric(10) NOT NULL, -- 자동차카네이션신규건수
  crd_afdm_ccamt numeric(15) NOT NULL, -- 카드후청구취소액
  crd_afdm_cclcs numeric(10) NOT NULL, -- 카드후청구취소건
  cr_tot_av numeric(15) NOT NULL, -- 자동차전체실적
  cr_tot_nwct numeric(10) NOT NULL, -- 자동차전체신규건수
  cr_co_bzxcp_nwct numeric(10) NOT NULL, -- 자동차공동영업제외신규건수
  cr_std_nwct numeric(10) NOT NULL, -- 자동차표준신규건수
  cr_tot_nwcct numeric(10) NOT NULL, -- 자동차전체신계약건수
  cr_co_bzxcp_nwcct numeric(10) NOT NULL, -- 자동차공동영업제외신계약건수
  db_cr_cn_crct numeric(10) NOT NULL, -- 중복계약해지자동차건수
  nmtn_crnct numeric(10) NOT NULL, -- 미유지카네이션건수
  cr_slfud_crd_av numeric(15) NOT NULL, -- 자동차자율인수카드실적
  cr_slfud_cash_av numeric(15) NOT NULL, -- 자동차자율인수현금실적
  cr_slfud_nwct numeric(10) NOT NULL, -- 자동차자율인수신규건수
  cr_rnwar_pt50x_av numeric(15) NOT NULL, -- 자동차갱신적용율50퍼센트초과실적
  cr_rnwar_pt50l_av numeric(15) NOT NULL, -- 자동차갱신적용율50퍼센트이하실적
  cr_slfud_rnw_crct numeric(15) NOT NULL, -- 자동차자율인수갱신계약건수
  inp_usr_id character(7) NOT NULL, -- 입력사용자ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  ltrm_gnte_snccv_av numeric(15) NOT NULL, -- 장기보장성본인신계약환산실적
  ltrm_cumt_snccv_av numeric(15) NOT NULL, -- 장기적립성본인신계약환산실적
  ltrm_agins_cmamt numeric(15) NOT NULL, -- 장기한아름종합보험수금액
  ltrm_agins_nwcct numeric(9) NOT NULL, -- 장기한아름종합보험신계약건수
  ltrm_agins_nwcr_prm numeric(15) NOT NULL, -- 장기한아름종합보험신계약보험료
  ltrm_agins_nwmcv_prm numeric(15) NOT NULL, -- 장기한아름종합보험신계약월납환산보험료
  ltrm_agins_nwccv_av numeric(15) NOT NULL, -- 장기한아름종합보험신계약환산실적
  fsyr_ctupr_cvav_2 numeric(15) NOT NULL, -- 초년도계속보험료환산실적2
  cr_co_bzxcp_nwav numeric(15) NOT NULL, -- 자동차공동영업제외신규실적
  ltrm_bab_nwcct numeric(10) NOT NULL, -- 장기B&B신계약건수
  ltrm_bab_nwccv_av numeric(15) NOT NULL, -- 장기B&B신계약환
  ltgnt_nwccv_1_av numeric(15) NOT NULL, -- 장기보장성신계약환산1실적
  ltgnt_nwccv_2_av numeric(15) NOT NULL, -- 장기보장성신계약환산2실적
  ltcmt_nwccv_1_av numeric(15) NOT NULL, -- 장기적립성신계약환산1실적
  ltcmt_nwccv_2_av numeric(15) NOT NULL, -- 장기적립성신계약환산2실적
  ltgnt_nwcpy_1_cvprm numeric(15) NOT NULL, -- 장기보장성신계약월납1환산보험료
  ltgnt_nwcpy_2_cvprm numeric(15) NOT NULL, -- 장기보장성신계약월납2환산보험료
  cm_ltrm_nwcr_cvav numeric(15) NOT NULL, -- 당월장기신계약환산실적
  aw_pylts_gd_cvav numeric(15) NOT NULL, -- 수당지급장기전략상품환산실적
  gn_ins_rpamt_cvav numeric(15) NOT NULL, -- 일반보험책임액환산실적
  gn_ins_ouq_cvav numeric(15) NOT NULL, -- 일반보험성과성환산실적
  ltrm_xc_cvav numeric(15) NOT NULL, -- 장기정산환산실적
  ltgnt_nwccv_3_av numeric(15) NOT NULL, -- 장기보장성신계약환산3실적
  ltgnt_nwccv_4_av numeric(15) NOT NULL, -- 장기보장성신계약환산4실적
  ltgnt_nwccv_5_av numeric(15) NOT NULL, -- 장기보장성신계약환산5실적
  ltcmt_nwccv_3_av numeric(15) NOT NULL, -- 장기적립성신계약환산3실적
  ltcmt_nwccv_4_av numeric(15) NOT NULL, -- 장기적립성신계약환산4실적
  ltcmt_nwccv_5_av numeric(15) NOT NULL, -- 장기적립성신계약환산5실적
  ltgnt_nwcpy_3_cvprm numeric(15) NOT NULL, -- 장기보장성신계약월납3환산보험료
  ltgnt_nwcpy_4_cvprm numeric(15) NOT NULL, -- 장기보장성신계약월납4환산보험료
  ltgnt_nwcpy_5_cvprm numeric(15) NOT NULL, -- 장기보장성신계약월납5환산보험료
  fsyr_ctupr_cvav_3 numeric(15), -- 초년도계속보험료환산실적3
  ltgnt_ppy_xcpt_cmav numeric(15), -- 장기보장성선납제외수금실적
  ltcmt_ppy_xcpt_cmav numeric(15), -- 장기적립성선납제외수금실적
  cv_2_psct numeric(7,1), -- 환산2인원수
  cr_vlct numeric(10), -- 자동차평가건수
  ltrm_prdt_grd character(10), -- 장기생산성등급
  pcked_prdt_grd character(10), -- 정예생산성등급
  fsyr_ctupr_cvav_4 numeric(15), -- 초년도계속보험료환산실적4
  ltrm_ctu_ct numeric(10), -- 장기계속건수
  fsyr_ctu_prm numeric(15), -- 초년도계속보험료
  cnst_cr_ct numeric(10), -- 컨설팅계약건수
  load_dthms timestamp(0) without time zone

)
WITH (  OIDS=FALSE)
DISTRIBUTED BY (av_yymm, stfno, av_stdt)