CREATE TABLE met_subo_rel_cd_defn
(
  subo_rel_tpcd character(5) NOT NULL, -- 종속관계유형코드
  lvl_1_dtcd character(10) NOT NULL, -- 레벨1세부코드
  lvl_2_dtcd character(10) NOT NULL, -- 레벨2세부코드
  lvl_3_dtcd character(10) NOT NULL, -- 레벨3세부코드
  lvl_4_dtcd character(10) NOT NULL, -- 레벨4세부코드
  lvl_5_dtcd character(10) NOT NULL, -- 레벨5세부코드
  ap_nddt date NOT NULL, -- 적용종료일자
  ap_strdt date NOT NULL, -- 적용시작일자
  scr_idc_ordr numeric(5), -- 화면표시순서
  inp_usr_id character(7) NOT NULL, -- 입력사용자ID
  inp_dthms timestamp(0) without time zone NOT NULL, -- 입력일시
  mdf_usr_id character(7) NOT NULL, -- 수정사용자ID
  mdf_dthms timestamp(0) without time zone NOT NULL, -- 수정일시
  load_dthms timestamp(0) without time zone

)
WITH (APPENDONLY=true, COMPRESSLEVEL=5,   OIDS=FALSE)
DISTRIBUTED BY (subo_rel_tpcd, lvl_1_dtcd, lvl_2_dtcd, lvl_3_dtcd, lvl_4_dtcd, lvl_5_dtcd, ap_nddt, ap_strdt);
