

CREATE UNIQUE INDEX SDMINACNT_AC_CODE_P
ON SDMINACNT_AC_CODE (AACPACCD,AACUACCD,AACATTR1) 
;


CREATE UNIQUE INDEX SDMINIDX_AUDT_JA_CONFIRM_UK
ON SDMINAUDT_JA_CONFIRM
(
    TRN_DT,
    TRN_BRNO,
    AUDIT_CD,
    LOGNO,
    UK_INF
) 
;


ALTER TABLE SDMINCARD_FLC_MIHANDO
ADD CONSTRAINT CARD_FLC_MI_P_KEY PRIMARY KEY (RLJADATE,RLJABRNO,RLJASMNO,RLJAACCD);

ALTER TABLE SDMINCARD_FLC_MST
ADD CONSTRAINT CARD_FLC_P_KEY PRIMARY KEY (RLJADATE,RLJABRNO,RLJASMNO,RLJAACCD,RLJASEQ);


CREATE UNIQUE INDEX SDMINCOMM_BR_PK
ON SDMINCOMM_BR_BRCH (ZBRBRCD);



CREATE UNIQUE INDEX SDMINCUST_BA_PK
ON SDMINCUST_BA_BASE (CBACIDNO) 
;

CREATE UNIQUE INDEX SDMINCUST_BA_JUSO_P
ON SDMINCUST_BA_JUSO (CBCIDNO,CBKIND) 
;

CREATE UNIQUE INDEX SDMINDEPO_AC_COMM_P
ON SDMINDEPO_AC_COMM (DACACNO,DACACCD) 
;

