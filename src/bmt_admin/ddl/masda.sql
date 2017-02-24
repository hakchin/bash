--
-- Greenplum Database database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET default_with_oids = false;

--
-- Name: com; Type: SCHEMA; Schema: -; Owner: gpadmin
--

CREATE SCHEMA com;


ALTER SCHEMA com OWNER TO gpadmin;

--
-- Name: dba; Type: SCHEMA; Schema: -; Owner: gpadmin
--

CREATE SCHEMA dba;


ALTER SCHEMA dba OWNER TO gpadmin;

--
-- Name: masdacmn; Type: SCHEMA; Schema: -; Owner: gpadmin
--

CREATE SCHEMA masdacmn;


ALTER SCHEMA masdacmn OWNER TO gpadmin;

--
-- Name: masdainf; Type: SCHEMA; Schema: -; Owner: gpadmin
--

CREATE SCHEMA masdainf;


ALTER SCHEMA masdainf OWNER TO gpadmin;

--
-- Name: masdapdm; Type: SCHEMA; Schema: -; Owner: gpadmin
--

CREATE SCHEMA masdapdm;


ALTER SCHEMA masdapdm OWNER TO gpadmin;

--
-- Name: masdapdw; Type: SCHEMA; Schema: -; Owner: gpadmin
--

CREATE SCHEMA masdapdw;


ALTER SCHEMA masdapdw OWNER TO gpadmin;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: gpadmin
--

COMMENT ON SCHEMA public IS 'Standard public schema';


--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: gpadmin
--

CREATE PROCEDURAL LANGUAGE plpgsql;
ALTER FUNCTION plpgsql_call_handler() OWNER TO gpadmin;
ALTER FUNCTION plpgsql_validator(oid) OWNER TO gpadmin;


SET search_path = public, pg_catalog;

--
-- Name: ty_split; Type: TYPE; Schema: public; Owner: gpadmin
--

CREATE TYPE ty_split AS (
	col1 character varying(1000)
);


ALTER TYPE public.ty_split OWNER TO gpadmin;

SET search_path = com, pg_catalog;

--
-- Name: fn_get_defect_numerator_qty(character varying, character varying, integer, timestamp without time zone, character varying, character varying); Type: FUNCTION; Schema: com; Owner: gpadmin
--

CREATE FUNCTION fn_get_defect_numerator_qty(p_facility_code character varying, p_glass_id character varying, p_galss_seq_no integer, p_glass_inspection_end_timestamp timestamp without time zone, p_summary_defect_code character varying, p_def_step character varying) RETURNS integer
    AS $$
DECLARE 
	v_result INTEGER;
BEGIN 

IF (p_def_step = 'REV') THEN
        
        SELECT COUNT(DM.SUMMARY_DEFECT_CODE) into v_result
          FROM MASDAPDW.TB_FDA_PDW_GLS_INSP_DEF_H           GD

         INNER JOIN MASDACMN.TB_DDA_CMN_DEF_M DM
            ON DM.DEFECT_CODE_SURID = GD.REVIEW_DEFECT_CODE_SURID

         INNER JOIN COM.FN_SPLIT(p_summary_defect_code, ',') D
            ON (
                  p_summary_defect_code = ' ' OR
                  DM.SUMMARY_DEFECT_CODE LIKE D.COL1
               )
				 LEFT JOIN (SELECT JA.JUDGEMENT_CODE
                      FROM MASDACMN.TB_DDA_CMN_JUDGE_ATTR_M JA
                     WHERE JA.FACILITY_CODE = p_facility_code   				-- param
                       AND JA.JUDGEMENT_ATTRIBUTE_CODE = 'MAS_REVIEW_NG'
                       AND JA.JUDGEMENT_TYPE_NAME      = 'DEFECT'
                     GROUP BY JA.JUDGEMENT_CODE                        
                     ) JA
         ON GD.REVIEW_JUDGEMENT_CODE = JA.JUDGEMENT_CODE
         WHERE GD.GLASS_ID                       = p_glass_id    			-- param
           AND GD.GLASS_SEQ_NO                   = p_galss_seq_no		-- param
           AND GD.GLASS_INSPECTION_END_TIMESTAMP = p_glass_inspection_end_timestamp -- param
           AND GD.REVIEW_DEFECT_CODE_SURID      != -99 
					 AND (NULL IS NULL OR JA.JUDGEMENT_CODE IS NOT NULL)
/*
           AND ( NULL IS NULL OR
                 GD.REVIEW_JUDGEMENT_CODE IN ( SELECT JA.JUDGEMENT_CODE
                                                 FROM MASDACMN.TB_DDA_CMN_JUDGE_ATTR_M JA
                                                WHERE JA.FACILITY_CODE = p_facility_code   				-- param
                                                  AND JA.JUDGEMENT_ATTRIBUTE_CODE = 'MAS_REVIEW_NG'
                                                  AND JA.JUDGEMENT_TYPE_NAME      = 'DEFECT' )
               )
*/               
          ;

ELSIF (p_def_step = 'REP') THEN
        
        SELECT COUNT(DM.SUMMARY_DEFECT_CODE) into v_result
          FROM MASDAPDW.TB_FDA_PDW_GLS_INSP_DEF_H           GD

         INNER JOIN MASDACMN.TB_DDA_CMN_DEF_M DM
            ON DM.DEFECT_CODE_SURID = GD.REPAIR_DEFECT_CODE_SURID

         INNER JOIN COM.FN_SPLIT(p_summary_defect_code, ',') D
            ON (
                  p_summary_defect_code = ' ' OR
                  DM.SUMMARY_DEFECT_CODE LIKE D.COL1
               )
					LEFT JOIN (SELECT JA.JUDGEMENT_CODE
                      FROM MASDACMN.TB_DDA_CMN_JUDGE_ATTR_M JA
                     WHERE JA.FACILITY_CODE = p_facility_code   				-- param
                       AND JA.JUDGEMENT_ATTRIBUTE_CODE = 'MAS_REVIEW_NG'
                       AND JA.JUDGEMENT_TYPE_NAME      = 'DEFECT'
                     GROUP BY JA.JUDGEMENT_CODE                        
                     ) JA
         ON GD.REPAIR_JUDGEMENT_CODE = JA.JUDGEMENT_CODE
         WHERE GD.GLASS_ID                       = p_glass_id    			-- param
           AND GD.GLASS_SEQ_NO                   = p_galss_seq_no		-- param
           AND GD.GLASS_INSPECTION_END_TIMESTAMP = p_glass_inspection_end_timestamp -- param
           AND GD.REPAIR_DEFECT_CODE_SURID      != -99	
					 AND (NULL IS NULL OR JA.JUDGEMENT_CODE IS NOT NULL)
/*
           AND ( NULL IS NULL OR
                 GD.REPAIR_JUDGEMENT_CODE IN ( SELECT JA.JUDGEMENT_CODE
                                                 FROM MASDACMN.TB_DDA_CMN_JUDGE_ATTR_M JA
                                                WHERE JA.FACILITY_CODE = p_facility_code   				-- param
                                                  AND JA.JUDGEMENT_ATTRIBUTE_CODE = 'MAS_REPAIR_NG'
                                                  AND JA.JUDGEMENT_TYPE_NAME      = 'DEFECT' )
               )
*/               
          ;

ELSE
        
        SELECT COUNT(DM.SUMMARY_DEFECT_CODE) into v_result
          FROM MASDAPDW.TB_FDA_PDW_GLS_INSP_DEF_H           GD

         INNER JOIN MASDACMN.TB_DDA_CMN_DEF_M DM
            ON DM.DEFECT_CODE_SURID = GD.LATEST_DEFECT_CODE_SURID

         INNER JOIN COM.FN_SPLIT(p_summary_defect_code, ',') D
            ON (
                  p_summary_defect_code = ' ' OR
                  DM.SUMMARY_DEFECT_CODE LIKE D.COL1
               )
					LEFT JOIN (SELECT JA.JUDGEMENT_CODE
                      FROM MASDACMN.TB_DDA_CMN_JUDGE_ATTR_M JA
                     WHERE JA.FACILITY_CODE = p_facility_code   				-- param
                       AND JA.JUDGEMENT_ATTRIBUTE_CODE = 'MAS_REVIEW_NG'
                       AND JA.JUDGEMENT_TYPE_NAME      = 'DEFECT'
                     GROUP BY JA.JUDGEMENT_CODE                        
                     ) JA
         ON GD.LATEST_JUDGEMENT_CODE = JA.JUDGEMENT_CODE
         WHERE GD.GLASS_ID                       = p_glass_id    			-- param
           AND GD.GLASS_SEQ_NO                   = p_galss_seq_no		-- param
           AND GD.GLASS_INSPECTION_END_TIMESTAMP = p_glass_inspection_end_timestamp -- param
           AND GD.LATEST_DEFECT_CODE_SURID      != -99	
					 AND (NULL IS NULL OR JA.JUDGEMENT_CODE IS NOT NULL)
          /* AND ( NULL IS NULL OR
                 GD.LATEST_JUDGEMENT_CODE IN ( SELECT JA.JUDGEMENT_CODE
                                                 FROM MASDACMN.TB_DDA_CMN_JUDGE_ATTR_M JA
                                                WHERE JA.FACILITY_CODE = p_facility_code   				-- param
                                                  AND JA.JUDGEMENT_ATTRIBUTE_CODE = 'MAS_LATEST_NG'
                                                  AND JA.JUDGEMENT_TYPE_NAME      = 'DEFECT' )
               )*/
          ;

END IF;

RETURN v_result;
/*
SELECT COM.FN_GET_DEFECT_NUMERATOR_QTY('P8T', 'P8AD2B00RE01', '1462200059', '2012-11-11-00.45.33.000000', 'A0G-B0D-C01-%-Y0S-%,A0G-B0D-C0P-%-Y0D-%,A0G-B0D-C0T-%-Y08-%', 'REV') FROM sysibm.sysdummy1 @
SELECT COM.FN_GET_DEFECT_NUMERATOR_QTY('P8T', 'P8AD2B00RE01', '1462200059', '2012-11-11-00.45.33.000000', 'A0G-B0D-C01-%-Y0S-%,A0G-B0D-C0P-%-Y0D-%,A0G-B0D-C0T-%-Y08-%', 'REP') FROM sysibm.sysdummy1 @
SELECT COM.FN_GET_DEFECT_NUMERATOR_QTY('P8T', 'P8AD2B00RE01', '1462200059', '2012-11-11-00.45.33.000000', 'A0G-B0D-C01-%-Y0S-%,A0G-B0D-C0P-%-Y0D-%,A0G-B0D-C0T-%-Y08-%', 'FIN') FROM sysibm.sysdummy1 @
*/


END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION com.fn_get_defect_numerator_qty(p_facility_code character varying, p_glass_id character varying, p_galss_seq_no integer, p_glass_inspection_end_timestamp timestamp without time zone, p_summary_defect_code character varying, p_def_step character varying) OWNER TO gpadmin;

--
-- Name: fn_get_item(character varying, numeric, character varying); Type: FUNCTION; Schema: com; Owner: gpadmin
--

CREATE FUNCTION fn_get_item(p_input_data character varying, p_idx numeric, p_delimiter character varying) RETURNS character varying
    AS $$
DECLARE
	v_result VARCHAR(400);
BEGIN
	SELECT
	CASE WHEN (LENGTH(p_input_data) = 0 OR p_idx  = 0 OR LENGTH(p_delimiter) = 0) IS NULL THEN NULL
	ELSE
		CASE WHEN p_idx=1 THEN SUBSTR(p_input_data,1,STRPOS(p_input_data,p_delimiter) - 1)
		     WHEN p_idx=2 THEN SUBSTR(p_input_data,LENGTH(SUBSTR(p_input_data,1,STRPOS(p_input_data,p_delimiter) + 1)),
				STRPOS(SUBSTR(p_input_data,LENGTH(SUBSTR(p_input_data,1,STRPOS(p_input_data,p_delimiter) + 1))),p_delimiter) - 1)
		     WHEN p_idx=3 THEN SUBSTR(p_input_data,LENGTH(SUBSTR(p_input_data,LENGTH(SUBSTR(p_input_data,1,STRPOS(p_input_data,p_delimiter)))))+1,
				LENGTH(p_input_data) - LENGTH(SUBSTR(p_input_data,LENGTH(SUBSTR(p_input_data,1,STRPOS(p_input_data,p_delimiter))))))
		END
	END into  v_result;
	RETURN v_result;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION com.fn_get_item(p_input_data character varying, p_idx numeric, p_delimiter character varying) OWNER TO gpadmin;

--
-- Name: fn_get_minute_unit_timestamp(timestamp without time zone); Type: FUNCTION; Schema: com; Owner: gpadmin
--

CREATE FUNCTION fn_get_minute_unit_timestamp(p_timestamp timestamp without time zone) RETURNS timestamp without time zone
    AS $$
DECLARE v_datetime  VARCHAR(14);
BEGIN
	v_datetime = to_char(p_timestamp, 'yyyy') || LPAD(to_char(p_timestamp, 'mm'),2,'0') || LPAD(to_char(p_timestamp, 'dd'),2,'0') || LPAD(to_char(p_timestamp, 'hh24'),2,'0') || LPAD(to_char(p_timestamp, 'mi'),2,'0') || '00';
	RETURN v_datetime;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION com.fn_get_minute_unit_timestamp(p_timestamp timestamp without time zone) OWNER TO gpadmin;

--
-- Name: fn_get_panel_numerator_qty(character varying, character varying, integer, timestamp without time zone, character varying, character varying); Type: FUNCTION; Schema: com; Owner: gpadmin
--

CREATE FUNCTION fn_get_panel_numerator_qty(p_facility_code character varying, p_glass_id character varying, p_galss_seq_no integer, p_glass_inspection_end_timestamp timestamp without time zone, p_summary_defect_code character varying, p_def_step character varying) RETURNS integer
    AS $$
DECLARE 
	v_result INTEGER;
BEGIN 
IF (p_def_step = 'REV') THEN

        SELECT COUNT(DM.SUMMARY_DEFECT_CODE) into v_result
          FROM MASDAPDW.TB_FDA_PDW_GLS_INSP_PNL_H           GP

         INNER JOIN MASDACMN.TB_DDA_CMN_DEF_M DM
            ON DM.DEFECT_CODE_SURID = GP.REVIEW_DEFECT_CODE_SURID

         INNER JOIN COM.FN_SPLIT(p_summary_defect_code, ',') D
            ON (
                  p_summary_defect_code = ' ' OR
                  DM.SUMMARY_DEFECT_CODE LIKE D.COL1
               )
					LEFT JOIN ( SELECT JA.JUDGEMENT_CODE
                     FROM MASDACMN.TB_DDA_CMN_JUDGE_ATTR_M JA
                     WHERE JA.FACILITY_CODE            = p_facility_code -- param
                     AND JA.JUDGEMENT_ATTRIBUTE_CODE = 'MAS_REVIEW_NG'
                     AND JA.JUDGEMENT_TYPE_NAME      = 'PNL' 
		   GROUP BY JA.JUDGEMENT_CODE) JA
				 ON GP.REVIEW_JUDGEMENT_CODE = JA.JUDGEMENT_CODE
         WHERE GP.GLASS_ID                        = p_glass_id     -- param
           AND GP.GLASS_SEQ_NO                    = p_galss_seq_no -- param
           AND GP.GLASS_INSPECTION_END_TIMESTAMP  = p_glass_inspection_end_timestamp -- param
           AND GP.REVIEW_DEFECT_CODE_SURID       != -99  
           AND (NULL IS NULL OR JA.JUDGEMENT_CODE IS NOT NULL)
        /*   AND ( NULL IS NULL OR
                 GP.REVIEW_JUDGEMENT_CODE IN ( SELECT JA.JUDGEMENT_CODE
                                                 FROM MASDACMN.TB_DDA_CMN_JUDGE_ATTR_M JA
                                                WHERE JA.FACILITY_CODE            = p_facility_code -- param
                                                  AND JA.JUDGEMENT_ATTRIBUTE_CODE = 'MAS_REVIEW_NG'
                                                  AND JA.JUDGEMENT_TYPE_NAME      = 'PNL' )
               ) */
         ;

ELSEIF (p_def_step = 'REP') THEN
        SELECT COUNT(DM.SUMMARY_DEFECT_CODE) into v_result
          FROM MASDAPDW.TB_FDA_PDW_GLS_INSP_PNL_H           GP

         INNER JOIN MASDACMN.TB_DDA_CMN_DEF_M DM
            ON DM.DEFECT_CODE_SURID = GP.REPAIR_DEFECT_CODE_SURID

         INNER JOIN COM.FN_SPLIT(p_summary_defect_code, ',') D
            ON (
                  p_summary_defect_code = ' ' OR
                  DM.SUMMARY_DEFECT_CODE LIKE D.COL1
               )
         LEFT JOIN ( SELECT JA.JUDGEMENT_CODE
                     FROM MASDACMN.TB_DDA_CMN_JUDGE_ATTR_M JA
                     WHERE JA.FACILITY_CODE            = p_facility_code -- param
                     AND JA.JUDGEMENT_ATTRIBUTE_CODE = 'MAS_REPAIR_NG'
                     AND JA.JUDGEMENT_TYPE_NAME      = 'PNL' 
		   							 GROUP BY JA.JUDGEMENT_CODE) JA
				 ON GP.REPAIR_JUDGEMENT_CODE = JA.JUDGEMENT_CODE
         WHERE GP.GLASS_ID                        = p_glass_id     -- param
           AND GP.GLASS_SEQ_NO                    = p_galss_seq_no -- param
           AND GP.GLASS_INSPECTION_END_TIMESTAMP  = p_glass_inspection_end_timestamp -- param
           AND GP.REPAIR_DEFECT_CODE_SURID       != -99 
					 AND ( NULL IS NULL OR	JA.JUDGEMENT_CODE IS NOT NULL)
           /*AND ( NULL IS NULL OR
                 GP.REPAIR_JUDGEMENT_CODE IN ( SELECT JA.JUDGEMENT_CODE
                                                 FROM MASDACMN.TB_DDA_CMN_JUDGE_ATTR_M JA
                                                WHERE JA.FACILITY_CODE            = p_facility_code -- param
                                                  AND JA.JUDGEMENT_ATTRIBUTE_CODE = 'MAS_REPAIR_NG'
                                                  AND JA.JUDGEMENT_TYPE_NAME      = 'PNL' )
               )*/
          ;

ELSE
        SELECT COUNT(DM.SUMMARY_DEFECT_CODE) into v_result
          FROM MASDAPDW.TB_FDA_PDW_GLS_INSP_PNL_H           GP

         INNER JOIN MASDACMN.TB_DDA_CMN_DEF_M DM
            ON DM.DEFECT_CODE_SURID = GP.LATEST_DEFECT_CODE_SURID

         INNER JOIN COM.FN_SPLIT(p_summary_defect_code, ',') D
            ON (
                  p_summary_defect_code = ' ' OR
                  DM.SUMMARY_DEFECT_CODE LIKE D.COL1
               )
         LEFT JOIN ( SELECT JA.JUDGEMENT_CODE
                     FROM MASDACMN.TB_DDA_CMN_JUDGE_ATTR_M JA
                     WHERE JA.FACILITY_CODE            = p_facility_code -- param
                     AND JA.JUDGEMENT_ATTRIBUTE_CODE = 'MAS_REPAIR_NG'
                     AND JA.JUDGEMENT_TYPE_NAME      = 'PNL' 
		   							 GROUP BY JA.JUDGEMENT_CODE) JA
		     ON GP.LATEST_JUDGEMENT_CODE = JA.JUDGEMENT_CODE
		     
         WHERE GP.GLASS_ID                        = p_glass_id     -- param
           AND GP.GLASS_SEQ_NO                    = p_galss_seq_no -- param
           AND GP.GLASS_INSPECTION_END_TIMESTAMP  = p_glass_inspection_end_timestamp -- param
           AND GP.LATEST_DEFECT_CODE_SURID       != -99   
           
          /* AND ( /*NULL IS NULL OR
                 GP.LATEST_JUDGEMENT_CODE IN ( SELECT JA.JUDGEMENT_CODE
                                                 FROM MASDACMN.TB_DDA_CMN_JUDGE_ATTR_M JA
                                                WHERE JA.FACILITY_CODE            = p_facility_code -- param
                                                  AND JA.JUDGEMENT_ATTRIBUTE_CODE = 'MAS_LATEST_NG'
                                                  AND JA.JUDGEMENT_TYPE_NAME      = 'PNL' )
               )*/
         ;

END IF;
RETURN v_result;

/*
SELECT COM.FN_GET_PANEL_NUMERATOR_QTY('P8T', 'P8AD2B00RE01', '1462200059', '2012-11-11-00.45.33.000000', 'A0G-B0D-C01-%-Y0S-%,A0G-B0D-C0P-%-Y0D-%,A0G-B0D-C0T-%-Y08-%', 'REV') FROM sysibm.sysdummy1 @
SELECT COM.FN_GET_PANEL_NUMERATOR_QTY('P8T', 'P8AD2B00RE01', '1462200059', '2012-11-11-00.45.33.000000', 'A0G-B0D-C01-%-Y0S-%,A0G-B0D-C0P-%-Y0D-%,A0G-B0D-C0T-%-Y08-%', 'REP') FROM sysibm.sysdummy1 @
SELECT COM.FN_GET_PANEL_NUMERATOR_QTY('P8T', 'P8AD2B00RE01', '1462200059', '2012-11-11-00.45.33.000000', 'A0G-B0D-C01-%-Y0S-%,A0G-B0D-C0P-%-Y0D-%,A0G-B0D-C0T-%-Y08-%', 'FIN') FROM sysibm.sysdummy1 @
*/

END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION com.fn_get_panel_numerator_qty(p_facility_code character varying, p_glass_id character varying, p_galss_seq_no integer, p_glass_inspection_end_timestamp timestamp without time zone, p_summary_defect_code character varying, p_def_step character varying) OWNER TO gpadmin;

--
-- Name: fn_get_summary_defect_desc(integer); Type: FUNCTION; Schema: com; Owner: gpadmin
--

CREATE FUNCTION fn_get_summary_defect_desc(p_defect_code_surid integer) RETURNS character varying
    AS $$
DECLARE
 v_result VARCHAR(4000);
BEGIN
SELECT DM.SUMMARY_DEFECT_DESC into v_result
  FROM MASDACMN.TB_DDA_CMN_DEF_M DM
 WHERE DM.DEFECT_CODE_SURID = p_defect_code_surid;
 RETURN v_result;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION com.fn_get_summary_defect_desc(p_defect_code_surid integer) OWNER TO gpadmin;

--
-- Name: fn_get_value(character varying, character varying, character varying); Type: FUNCTION; Schema: com; Owner: gpadmin
--

CREATE FUNCTION fn_get_value(p_input_data character varying, p_key character varying, p_delimiter character varying) RETURNS character varying
    AS $$
DECLARE
	v_result VARCHAR(40);
BEGIN
SELECT
	CASE WHEN LENGTH( p_input_data ) = 0  OR LENGTH(p_key)  = 0  OR  
		  LENGTH(p_delimiter) = 0 OR STRPOS( p_input_data, p_key || '=' ) = 0
	THEN NULL
	ELSE
		CASE WHEN STRPOS(SUBSTR(p_input_data,STRPOS(p_input_data,p_key) + LENGTH(p_key || '=' )),p_delimiter) > 0
			THEN SUBSTR(p_input_data
				,STRPOS(p_input_data,p_key) + LENGTH(p_key || '=' )
				,STRPOS( SUBSTR(p_input_data, STRPOS ( p_input_data,p_key) + LENGTH(p_key || '=' ) ), p_delimiter ) - 1 )
			ELSE SUBSTR(p_input_data
				,STRPOS(p_input_data,p_key) + LENGTH(p_key || '=' )
				,LENGTH(SUBSTR(p_input_data, STRPOS(p_input_data,p_key) + LENGTH(p_key || '=' ) ) ) )
		END	
	END
 into v_result;
RETURN v_result;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION com.fn_get_value(p_input_data character varying, p_key character varying, p_delimiter character varying) OWNER TO gpadmin;

--
-- Name: fn_lookup_vc(character varying, character varying, character varying); Type: FUNCTION; Schema: com; Owner: gpadmin
--

CREATE FUNCTION fn_lookup_vc(asis_col character varying, join_col character varying, tobe_col character varying) RETURNS character varying
    AS $_$
DECLARE
	v_result VARCHAR(40);
BEGIN

SELECT
  CASE
        WHEN ASIS_COL   IS NULL OR LENGTH(ASIS_COL) = 0 THEN '?'
        WHEN JOIN_COL   IS NULL OR LENGTH(JOIN_COL) = 0 THEN '#'
        WHEN TOBE_COL   IS NULL OR LENGTH(TOBE_COL) = 0 THEN '$'
        ELSE TOBE_COL
  END INTO v_result;
	RETURN v_result;
END;
$_$
    LANGUAGE plpgsql;


ALTER FUNCTION com.fn_lookup_vc(asis_col character varying, join_col character varying, tobe_col character varying) OWNER TO gpadmin;

--
-- Name: fn_split(character varying, character varying); Type: FUNCTION; Schema: com; Owner: gpadmin
--

CREATE FUNCTION fn_split(string character varying, dilim character varying) RETURNS SETOF public.ty_split
    AS $$
DECLARE
  v_dilim text;
  row  TY_SPLIT;
BEGIN
  FOR row IN SELECT c AS COL1 FROM unnest(string_to_array(string, dilim)) c 
  LOOP
    RETURN NEXT row;
  END LOOP;

  RETURN;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION com.fn_split(string character varying, dilim character varying) OWNER TO gpadmin;

--
-- Name: fn_surid_value(character varying, integer); Type: FUNCTION; Schema: com; Owner: gpadmin
--

CREATE FUNCTION fn_surid_value(asis_col character varying, tobe_surid integer) RETURNS integer
    AS $$
DECLARE
	v_result INTEGER;
BEGIN
SELECT
 CASE WHEN TOBE_SURID IS NOT NULL THEN TOBE_SURID WHEN ASIS_COL IS NULL OR LENGTH(ASIS_COL) = 0 
 THEN -99 WHEN TOBE_SURID IS NULL OR LENGTH(TOBE_SURID) = 0
  THEN -999 END into v_result;

RETURN v_result;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION com.fn_surid_value(asis_col character varying, tobe_surid integer) OWNER TO gpadmin;

SET search_path = dba, pg_catalog;

SET default_tablespace = '';

--
-- Name: sql_history; Type: TABLE; Schema: dba; Owner: gpadmin; Tablespace: 
--

CREATE TABLE sql_history (
    event_time timestamp without time zone,
    user_name character varying(100),
    database_name character varying(10),
    process_id character varying(10),
    remote_host character varying(20),
    session_start_time timestamp with time zone,
    gp_session_id character varying(20),
    gp_command_count character varying(20),
    debug_query_string text,
    elapsed_ms numeric,
    log_tp character varying(10),
    state_cd character varying(10),
    dtl_msg text
) DISTRIBUTED BY (event_time);


ALTER TABLE dba.sql_history OWNER TO gpadmin;

--
-- Name: table_ddl; Type: TABLE; Schema: dba; Owner: gpadmin; Tablespace: 
--

CREATE TABLE table_ddl (
    tablename text,
    ddl text
) DISTRIBUTED BY (tablename);


ALTER TABLE dba.table_ddl OWNER TO gpadmin;

--
-- Name: tb_pt_size; Type: VIEW; Schema: dba; Owner: gpadmin
--

CREATE VIEW tb_pt_size AS
    SELECT gp_size_of_partition_and_indexes_disk.sopaidparentschemaname AS schema_nm, gp_size_of_partition_and_indexes_disk.sopaidparenttablename AS tb_nm, gp_size_of_partition_and_indexes_disk.sopaidpartitionschemaname AS tbpt_schema_nm, gp_size_of_partition_and_indexes_disk.sopaidpartitiontablename AS tbpt_nm, (((gp_size_of_partition_and_indexes_disk.sopaidpartitiontablesize / 1024) / 1024))::integer AS tb_size_mb, (((gp_size_of_partition_and_indexes_disk.sopaidpartitionindexessize / (1024)::numeric) / (1024)::numeric))::integer AS ix_size_mb FROM gp_toolkit.gp_size_of_partition_and_indexes_disk;


ALTER TABLE dba.tb_pt_size OWNER TO gpadmin;

--
-- Name: tb_size; Type: VIEW; Schema: dba; Owner: gpadmin
--

CREATE VIEW tb_size AS
    SELECT gp_size_of_table_and_indexes_disk.sotaidschemaname AS schema_nm, split_part((gp_size_of_table_and_indexes_disk.sotaidtablename)::text, '1_prt'::text, 1) AS tb_nm, sum((((gp_size_of_table_and_indexes_disk.sotaidtablesize / 1024) / 1024))::integer) AS tb_size_mb, sum((((gp_size_of_table_and_indexes_disk.sotaididxsize / (1024)::numeric) / (1024)::numeric))::integer) AS ix_size_mb FROM gp_toolkit.gp_size_of_table_and_indexes_disk GROUP BY gp_size_of_table_and_indexes_disk.sotaidschemaname, split_part((gp_size_of_table_and_indexes_disk.sotaidtablename)::text, '1_prt'::text, 1);


ALTER TABLE dba.tb_size OWNER TO gpadmin;

SET search_path = masdacmn, pg_catalog;

--
-- Name: tb_dda_cmn_amc_specification_info; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_amc_specification_info (
    factory_code character varying(40) NOT NULL,
    shop_code character varying(40) NOT NULL,
    measure_tag_id character varying(40) NOT NULL,
    measuring_instrument_name character varying(100) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    equipment_group_id character varying(40),
    line_id character varying(40),
    unit_id character varying(40),
    machine_id character varying(40),
    mes_id character varying(40),
    location_name character varying(300),
    channel1_name character varying(10),
    lsl1_value double precision,
    lcl1_value double precision,
    ucl1_value double precision,
    usl1_value double precision,
    channel2_name character varying(10),
    lsl2_value double precision,
    lcl2_value double precision,
    ucl2_value double precision,
    usl2_value double precision,
    channel3_name character varying(10),
    lsl3_value double precision,
    lcl3_value double precision,
    ucl3_value double precision,
    usl3_value double precision,
    channel4_name character varying(10),
    lsl4_value double precision,
    lcl4_value double precision,
    ucl4_value double precision,
    usl4_value double precision,
    channel5_name character varying(10),
    lsl5_value double precision,
    lcl5_value double precision,
    ucl5_value double precision,
    usl5_value double precision,
    channel6_name character varying(10),
    lsl6_value double precision,
    lcl6_value double precision,
    ucl6_value double precision,
    usl6_value double precision,
    channel7_name character varying(10),
    lsl7_value double precision,
    lcl7_value double precision,
    ucl7_value double precision,
    usl7_value double precision,
    channel8_name character varying(10),
    lsl8_value double precision,
    lcl8_value double precision,
    ucl8_value double precision,
    usl8_value double precision,
    channel9_name character varying(10),
    lsl9_value double precision,
    lcl9_value double precision,
    ucl9_value double precision,
    usl9_value double precision,
    channel10_name character varying(10),
    lsl10_value double precision,
    lcl10_value double precision,
    ucl10_value double precision,
    usl10_value double precision,
    trouble_alert_basis_code character varying(100),
    grade_code character varying(40),
    mail_recipient_addr character varying(1000),
    management_contact_name character varying(1000),
    code_name character varying(300),
    check_state_code character varying(10),
    creation_user_id character varying(40),
    creation_timestamp timestamp without time zone DEFAULT now(),
    updated_by character varying(30),
    update_timestamp timestamp without time zone,
    fed_type character varying(10),
    sms_mail_recipient_list character varying(1000),
    enrollment_reason_desc character varying(1000),
    ekms_flag character(1),
    grade1_code character varying(40),
    grade2_code character varying(40),
    grade3_code character varying(40),
    grade4_code character varying(40),
    grade5_code character varying(40),
    grade6_code character varying(40),
    grade7_code character varying(40),
    grade8_code character varying(40),
    grade9_code character varying(40),
    grade10_code character varying(40),
    ucl_trbl_alt_basis1_m_value character varying(100),
    ucl_trbl_alt_basis2_m_value character varying(100),
    ucl_trbl_alt_basis3_m_value character varying(100),
    ucl_trbl_alt_basis4_m_value character varying(100),
    ucl_trbl_alt_basis5_m_value character varying(100),
    ucl_trbl_alt_basis6_m_value character varying(100),
    ucl_trbl_alt_basis7_m_value character varying(100),
    ucl_trbl_alt_basis8_m_value character varying(100),
    ucl_trbl_alt_basis9_m_value character varying(100),
    ucl_trbl_alt_basis10_m_value character varying(100),
    ucl_trbl_alt_basis1_n_value character varying(100),
    ucl_trbl_alt_basis2_n_value character varying(100),
    ucl_trbl_alt_basis3_n_value character varying(100),
    ucl_trbl_alt_basis4_n_value character varying(100),
    ucl_trbl_alt_basis5_n_value character varying(100),
    ucl_trbl_alt_basis6_n_value character varying(100),
    ucl_trbl_alt_basis7_n_value character varying(100),
    ucl_trbl_alt_basis8_n_value character varying(100),
    ucl_trbl_alt_basis9_n_value character varying(100),
    ucl_trbl_alt_basis10_n_value character varying(100),
    usl_trbl_alt_basis1_m_value character varying(100),
    usl_trbl_alt_basis2_m_value character varying(100),
    usl_trbl_alt_basis3_m_value character varying(100),
    usl_trbl_alt_basis4_m_value character varying(100),
    usl_trbl_alt_basis5_m_value character varying(100),
    usl_trbl_alt_basis6_m_value character varying(100),
    usl_trbl_alt_basis7_m_value character varying(100),
    usl_trbl_alt_basis8_m_value character varying(100),
    usl_trbl_alt_basis9_m_value character varying(100),
    usl_trbl_alt_basis10_m_value character varying(100),
    usl_trbl_alt_basis1_n_value character varying(100),
    usl_trbl_alt_basis2_n_value character varying(100),
    usl_trbl_alt_basis3_n_value character varying(100),
    usl_trbl_alt_basis4_n_value character varying(100),
    usl_trbl_alt_basis5_n_value character varying(100),
    usl_trbl_alt_basis6_n_value character varying(100),
    usl_trbl_alt_basis7_n_value character varying(100),
    usl_trbl_alt_basis8_n_value character varying(100),
    usl_trbl_alt_basis9_n_value character varying(100),
    usl_trbl_alt_basis10_n_value character varying(100),
    ucl_mail_recipient_list character varying(1000),
    ucl_sms_mail_recipient_list character varying(1000),
    defect_management_group_code character varying(100),
    target_defect_rate double precision,
    process_down_apply_flag character(1)
) DISTRIBUTED BY (shop_code ,measure_tag_id ,measuring_instrument_name);


ALTER TABLE masdacmn.tb_dda_cmn_amc_specification_info OWNER TO letl;

--
-- Name: tb_dda_cmn_apd_3d_chart_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_apd_3d_chart_m (
    factory_code character varying(40) NOT NULL,
    apd_3d_chart_id character varying(50) NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    apd_data_id character varying(40) NOT NULL,
    facility_code character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    x_axis_data_id character varying(40),
    x_axis_data_value double precision,
    y_axis_data_id character varying(40),
    y_axis_data_value double precision,
    coordinate_basis_info character varying(40),
    x_y_coordinate_basis_info character varying(40)
) DISTRIBUTED BY (apd_3d_chart_id ,equipment_group_id ,apd_data_id ,facility_code);


ALTER TABLE masdacmn.tb_dda_cmn_apd_3d_chart_m OWNER TO letl;

--
-- Name: tb_dda_cmn_apd_gr_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_apd_gr_m (
    factory_code character varying(40) NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    apd_collection_code character(1) NOT NULL,
    apd_data_group_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    apd_data_group_desc character varying(200),
    term_name character varying(250),
    display_flag character(1),
    display_seq_no integer,
    equipment_report_flag character(1),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone,
    inspection_data_flag character(1)
) DISTRIBUTED BY (equipment_group_id ,apd_collection_code);


ALTER TABLE masdacmn.tb_dda_cmn_apd_gr_m OWNER TO letl;

--
-- Name: tb_dda_cmn_apd_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_apd_m (
    factory_code character varying(40) NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    apd_collection_code character(1) NOT NULL,
    apd_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    apd_data_desc character varying(150),
    term_name character varying(250),
    apd_data_group_id character varying(40),
    parts_data_flag character(1),
    part_name character varying(300),
    display_flag character(1),
    display_seq_no integer,
    control_enabled_flag character(1),
    measure_possible_flag character(1),
    raw_data_flag character(1),
    data_type_code character(1),
    data_characteristic_code character varying(40),
    data_unit_code character varying(40),
    keeping_months double precision,
    data_precision_number character varying(30),
    min_unit_value double precision,
    max_value double precision,
    min_value double precision,
    ucl_value double precision,
    lcl_value double precision,
    equipment_report_flag character(1),
    data_collection_flag character(1),
    path_flag character(1),
    main_path_flag character(1),
    time_type_code character varying(40),
    usage_flag character(1),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone,
    apd_type_code character varying(40),
    fdc_use_flag character(1),
    mes_interface_flag character(1),
    zero_not_save_flag character(1),
    mdw_interface_flag character(1)
) DISTRIBUTED BY (equipment_group_id ,apd_collection_code);


ALTER TABLE masdacmn.tb_dda_cmn_apd_m OWNER TO letl;

--
-- Name: tb_dda_cmn_apd_path_cd; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_apd_path_cd (
    factory_code character varying(40) NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    apd_collection_code character(1) NOT NULL,
    apd_data_id character varying(40) NOT NULL,
    equipment_path_code character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (equipment_group_id ,apd_collection_code);


ALTER TABLE masdacmn.tb_dda_cmn_apd_path_cd OWNER TO letl;

--
-- Name: tb_dda_cmn_cell_af_prcs_map_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_cell_af_prcs_map_m (
    facility_code character varying(40) NOT NULL,
    part_no_name character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    start_point_no character(1),
    gate_line_qty double precision,
    data_line_qty double precision,
    gate_line_axis_code character(1),
    data_line_axis_code character(1),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (facility_code ,part_no_name);


ALTER TABLE masdacmn.tb_dda_cmn_cell_af_prcs_map_m OWNER TO letl;

--
-- Name: tb_dda_cmn_condition_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_condition_m (
    factory_code character varying(40) NOT NULL,
    condition_name character varying(40) NOT NULL,
    process_code character varying(50) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL
) DISTRIBUTED BY (factory_code ,condition_name ,process_code);


ALTER TABLE masdacmn.tb_dda_cmn_condition_m OWNER TO letl;

--
-- Name: tb_dda_cmn_contact_map_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_contact_map_m (
    facility_code character varying(40) NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    equipment_unit_id character varying(40) NOT NULL,
    equipment_part_id character varying(40) NOT NULL,
    pad_seq_no integer NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    pad_desc character varying(200),
    term_name character varying(250),
    factory_code character varying(40),
    pin_parts_type_code character(1),
    x_coordinate1_value double precision,
    y_coordinate1_value double precision,
    x_coordinate2_value double precision,
    y_coordinate2_value double precision,
    defect_x_codi_min_value double precision,
    defect_y_codi_min_value double precision,
    defect_x_codi_max_value double precision,
    defect_y_codi_max_value double precision,
    equipment_part_memo_content character varying(200),
    material_desc character varying(200),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (facility_code ,equipment_group_id ,equipment_unit_id ,equipment_part_id ,pad_seq_no);


ALTER TABLE masdacmn.tb_dda_cmn_contact_map_m OWNER TO letl;

--
-- Name: tb_dda_cmn_def_cd; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_def_cd (
    factory_code character varying(40) NOT NULL,
    shop_type_code character varying(10) NOT NULL,
    apply_yyyymm character varying(6) NOT NULL,
    defect_seq_no integer NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    defect_code_surid integer NOT NULL,
    full_defect_code character varying(150),
    field1_code character varying(40),
    field1_desc character varying(100),
    field2_code character varying(40),
    field2_desc character varying(100),
    field3_code character varying(40),
    field3_desc character varying(100),
    field4_code character varying(40),
    field4_desc character varying(100),
    field5_code character varying(40),
    field5_desc character varying(100),
    field6_code character varying(40),
    field6_desc character varying(100),
    field7_code character varying(40),
    field7_desc character varying(100),
    field8_code character varying(40),
    field8_desc character varying(100),
    field9_code character varying(40),
    field9_desc character varying(100),
    field10_code character varying(40),
    field10_desc character varying(100),
    field11_code character varying(40),
    field11_desc character varying(100),
    field12_code character varying(40),
    field12_desc character varying(100),
    field13_code character varying(40),
    field13_desc character varying(100),
    field14_code character varying(40),
    field14_desc character varying(100),
    field15_code character varying(40),
    field15_desc character varying(100),
    field16_code character varying(40),
    field16_desc character varying(100),
    field17_code character varying(40),
    field17_desc character varying(100),
    field18_code character varying(40),
    field18_desc character varying(100),
    field19_code character varying(40),
    field19_desc character varying(100),
    field20_code character varying(40),
    field20_desc character varying(100),
    field21_code character varying(40),
    field21_desc character varying(100),
    field22_code character varying(40),
    field22_desc character varying(100),
    field23_code character varying(40),
    field23_desc character varying(100),
    field24_code character varying(40),
    field24_desc character varying(100),
    field25_code character varying(40),
    field25_desc character varying(100),
    old_defect_code character varying(40),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone,
    field26_code character varying(40),
    field26_desc character varying(100),
    field27_code character varying(40),
    field27_desc character varying(100),
    field28_code character varying(40),
    field28_desc character varying(100),
    field29_code character varying(40),
    field29_desc character varying(100),
    field30_code character varying(40),
    field30_desc character varying(100),
    field31_code character varying(40),
    field31_desc character varying(100),
    field32_code character varying(40),
    field32_desc character varying(100),
    field33_code character varying(40),
    field33_desc character varying(100),
    field34_code character varying(40),
    field34_desc character varying(100)
) DISTRIBUTED BY (factory_code);


ALTER TABLE masdacmn.tb_dda_cmn_def_cd OWNER TO letl;

--
-- Name: tb_dda_cmn_def_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_def_m (
    defect_code_surid integer NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    full_defect_code character varying(150) NOT NULL,
    full_defect_desc character varying(4000),
    summary_defect_code character varying(150) NOT NULL,
    summary_defect_desc character varying(4000),
    field1_code character varying(40),
    field1_desc character varying(100),
    field2_code character varying(40),
    field2_desc character varying(100),
    field3_code character varying(40),
    field3_desc character varying(100),
    field4_code character varying(40),
    field4_desc character varying(100),
    field5_code character varying(40),
    field5_desc character varying(100),
    field6_code character varying(40),
    field6_desc character varying(100),
    field7_code character varying(40),
    field7_desc character varying(100),
    field8_code character varying(40),
    field8_desc character varying(100),
    field9_code character varying(40),
    field9_desc character varying(100),
    field10_code character varying(40),
    field10_desc character varying(100),
    field11_code character varying(40),
    field11_desc character varying(100),
    field12_code character varying(40),
    field12_desc character varying(100),
    field13_code character varying(40),
    field13_desc character varying(100),
    field14_code character varying(40),
    field14_desc character varying(100),
    field15_code character varying(40),
    field15_desc character varying(100),
    field16_code character varying(40),
    field16_desc character varying(100),
    field17_code character varying(40),
    field17_desc character varying(100),
    field18_code character varying(40),
    field18_desc character varying(100),
    field19_code character varying(40),
    field19_desc character varying(100),
    field20_code character varying(40),
    field20_desc character varying(100),
    field21_code character varying(40),
    field21_desc character varying(100),
    field22_code character varying(40),
    field22_desc character varying(100),
    field23_code character varying(40),
    field23_desc character varying(100),
    field24_code character varying(40),
    field24_desc character varying(100),
    field25_code character varying(40),
    field25_desc character varying(100),
    field26_code character varying(40),
    field26_desc character varying(100),
    field27_code character varying(40),
    field27_desc character varying(100),
    field28_code character varying(40),
    field28_desc character varying(100),
    field29_code character varying(40),
    field29_desc character varying(100),
    field30_code character varying(40),
    field30_desc character varying(100),
    field31_code character varying(40),
    field31_desc character varying(100),
    field32_code character varying(40),
    field32_desc character varying(100),
    field33_code character varying(40),
    field33_desc character varying(100),
    field34_code character varying(40),
    field34_desc character varying(100)
) DISTRIBUTED BY (defect_code_surid);


ALTER TABLE masdacmn.tb_dda_cmn_def_m OWNER TO letl;

--
-- Name: tb_dda_cmn_dms_specification_info; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_dms_specification_info (
    factory_code character varying(40) NOT NULL,
    shop_code character varying(40) NOT NULL,
    measuring_instrument_name character varying(100) NOT NULL,
    measure_tag_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    equipment_group_id character varying(40),
    line_id character varying(40),
    unit_id character varying(40),
    machine_id character varying(40),
    mes_id character varying(40),
    location_name character varying(300),
    lsl_base_value character varying(40),
    lcl_base_value character varying(40),
    ucl_base_value character varying(40),
    usl_base_value character varying(40),
    lsl_value double precision,
    lcl_value double precision,
    ucl_value double precision,
    usl_value double precision,
    trouble_alert_basis_code character varying(100),
    grade_code character varying(40),
    mail_recipient_addr character varying(1000),
    management_contact_name character varying(1000),
    code_name character varying(300),
    check_state_code character varying(10),
    creation_user_id character varying(40),
    creation_timestamp timestamp without time zone DEFAULT now(),
    updated_by character varying(30),
    update_timestamp timestamp without time zone,
    fed_type character varying(10),
    sms_mail_recipient_list character varying(1000),
    enrollment_reason_desc character varying(1000),
    ekms_flag character(1),
    channel_type_code character varying(10),
    ucl_trbl_alt_bas_code_m_value character varying(100),
    ucl_trbl_alt_bas_code_n_value character varying(100),
    usl_trbl_alt_bas_code_m_value character varying(100),
    usl_trbl_alt_bas_code_n_value character varying(100),
    ucl_mail_recipient_list character varying(1000),
    ucl_sms_mail_recipient_list character varying(1000),
    defect_management_group_code character varying(100),
    target_defect_rate double precision,
    process_down_apply_flag character(1),
    ucl_information_row_id integer,
    process_down_code character varying(100)
) DISTRIBUTED BY (factory_code ,shop_code ,measuring_instrument_name ,measure_tag_id);


ALTER TABLE masdacmn.tb_dda_cmn_dms_specification_info OWNER TO letl;

--
-- Name: tb_dda_cmn_ea_equipment_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_ea_equipment_m (
    equipment_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    code_desc character varying(200),
    term_name character varying(250),
    factory_code character varying(40),
    machine_type_code character varying(40),
    detail_machine_type_code character varying(40),
    facility_code character varying(40),
    sub_factory_code character varying(40),
    high_equipment_id character varying(40),
    machine_group_name character varying(40),
    equipment_model_name character varying(40),
    vendor_name character varying(40),
    serial_no character varying(30),
    process_unit_code character varying(40),
    process_capacity_size double precision,
    process_group_size_min_value double precision,
    process_group_size_max_value double precision,
    default_recipe_name_space_name character varying(40),
    equipment_state_model_code character varying(40),
    chemicals_name character varying(40),
    max_clean_count double precision,
    cassette_change_flag character(1),
    cassette_map_upload_flag character(1),
    equipment_efficiency_code character varying(40),
    equipment_inline_flag character(1),
    equipment_layer_code character varying(40),
    equipment_port_type_code character varying(40),
    floor_code character varying(40),
    gcs_equipment_id character varying(40),
    rcs_mode_type_code character varying(40),
    inline_stocker_id character varying(40),
    force_end_map_processing_flag character(1),
    stocker_max_cst_storage_qty double precision,
    monitoring_facility_code character varying(40),
    phase_code character varying(40),
    port_qty double precision,
    tact_flag character(1),
    transport_type_code character varying(40),
    unit_equipment_type_code character varying(40),
    mode_group_flag character(1),
    chamber_flag character(1),
    photo_aligner_flag character(1),
    sample_flag character(1),
    cim_flag character(1),
    standard_equipment_name character varying(40),
    available_facility_code character varying(40),
    stocker_shelf_name character varying(40),
    sort_type_info character varying(100),
    mcs_interface_flag character(1),
    mask_slot_qty double precision,
    sub_equipment_efficiency_code character varying(40),
    root_equipment_id character varying(40),
    appropriation_transport_count double precision,
    glass_recipe_use_flag character(1),
    maker_recipe_use_flag character(1),
    stocker_allocation_flag character(1),
    equipment_type_desc character varying(40),
    machine_code character varying(30),
    multi_model_flag character(1)
) DISTRIBUTED BY (equipment_id);


ALTER TABLE masdacmn.tb_dda_cmn_ea_equipment_m OWNER TO letl;

--
-- Name: tb_dda_cmn_ea_parts_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_ea_parts_m (
    facility_code character varying(40) NOT NULL,
    part_no_name character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    code_desc character varying(200),
    term_name character varying(250),
    factory_code character varying(40),
    check_in_status_code character varying(40),
    active_state_name character varying(40),
    creation_timestamp timestamp without time zone,
    creation_user_id character varying(40),
    check_out_timestamp timestamp without time zone,
    check_out_user_id character varying(40),
    production_type_code character varying(40),
    product_type_code character varying(10),
    production_qty double precision,
    sub_product_type_code character varying(40),
    sub_product_unit1_qty double precision,
    sub_product_unit2_qty double precision,
    process_flow_name character varying(40),
    process_flow_version character varying(40),
    estimated_cycle_time_value double precision,
    mmg_type_code character varying(40),
    part_no2_name character varying(40),
    part_no2_version character varying(40),
    aging_rate_info character varying(40),
    ap_aging_check_flag character(1),
    cutting_completion_flag character(1),
    cf_part_no_name character varying(40),
    cs_level_flag character(1),
    dummy_type_code character varying(40),
    erp_model_name character varying(40),
    experiment_change_count double precision,
    gcs_raw_material_code character varying(40),
    glass_direction_code character varying(40),
    gui_display_flag character(1),
    inch_code character varying(40),
    input_ng_port_use_flag character(1),
    main_scrap_qty double precision,
    mask_code character varying(40),
    max_rework_count double precision,
    mmg_sub_location_info character varying(40),
    model_code character varying(40),
    mmg_weighting_info character varying(40),
    optimal_sorting_base_code character varying(40),
    panel_location_info character varying(40),
    part_no_scrap_basis_info character varying(40),
    succd_process_part_no_name character varying(40),
    succd_process_mmg_part_no_name character varying(40),
    scrap_part_no_name character varying(40),
    sub_cutting_qty double precision,
    sub_outsourcing_flag character(1),
    sub_scrap_qty double precision,
    sub_facility_code character varying(40),
    sub_panel_qty double precision,
    tft_part_no_name character varying(40),
    tn_ips_code character varying(40),
    shipping_factory_code character varying(40),
    vap_progress_flag character(1),
    wide_cassette_type_code character varying(40),
    update_ymdhms character varying(14),
    glass_conversion_ppg_qty numeric(22,5),
    chrome_bm_progress_flag character(1),
    sub_factory_code character varying(40),
    part_no_usage_code character varying(10)
) DISTRIBUTED BY (facility_code ,part_no_name);


ALTER TABLE masdacmn.tb_dda_cmn_ea_parts_m OWNER TO letl;

--
-- Name: tb_dda_cmn_ea_process_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_ea_process_m (
    facility_code character varying(40) NOT NULL,
    process_code character varying(50) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    code_desc character varying(200),
    term_name character varying(250),
    factory_code character varying(40),
    check_in_status_code character varying(40),
    active_state_name character varying(40),
    creation_timestamp timestamp without time zone,
    creation_user_id character varying(40),
    check_out_timestamp timestamp without time zone,
    check_out_user_id character varying(40),
    process_operation_type_code character varying(40),
    detail_process_op_type_code character varying(40),
    process_group_code character varying(40),
    process_unit_code character varying(40),
    login_required_flag character(1),
    default_area_name character varying(40),
    alternate_route_flag character(1),
    bonus_code_flag character(1),
    cell_location_code character varying(40),
    cassette_clean_flag character(1),
    gate_photo_validation_code character varying(40),
    loss_code_flag character(1),
    process_flag_info character varying(40),
    photo_insp_waiting_prcs_code character varying(40),
    hold_release_code character varying(40),
    rework_code_flag character(1),
    rework_lot_code character varying(40),
    sputter_target_code character varying(40),
    update_ymdhms character varying(14),
    process_type_code character varying(30),
    inspection_step_code character varying(40),
    inspection_equip_type_code character varying(40),
    front_back_check_flag character(1),
    aligner_check_flag character(1),
    cell_shop_first_insp_prcs_flag character(1),
    cell_shop_reinsp_process_flag character(1),
    wip_group_name character varying(100),
    rework_lot_detail_code character varying(2)
) DISTRIBUTED BY (facility_code ,process_code);


ALTER TABLE masdacmn.tb_dda_cmn_ea_process_m OWNER TO letl;

--
-- Name: tb_dda_cmn_ea_user_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_ea_user_m (
    user_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    user_group_name character varying(40),
    user_name character varying(250),
    department_code character varying(40),
    default_language_code character varying(5),
    shift_crew_code character varying(30),
    email_addr character varying(250),
    user_account_lock_flag character(1),
    program_authority_code character varying(100),
    phone_no character varying(30),
    ip_phone_no character varying(50),
    mail_receive_flag character(1),
    ememo_facility_code character varying(40),
    login_certification_code character varying(250),
    employee_no character varying(30),
    factory_code character varying(40),
    mobile_phone_no character varying(30)
) DISTRIBUTED BY (user_id);


ALTER TABLE masdacmn.tb_dda_cmn_ea_user_m OWNER TO letl;

--
-- Name: tb_dda_cmn_eas_cd; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_eas_cd (
    facility_code character varying(40) NOT NULL,
    code_type_code character varying(40) NOT NULL,
    code_name character varying(300) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    code_desc character varying(200),
    term_name character varying(250),
    factory_code character varying(40),
    code1_content character varying(500),
    code2_content character varying(500),
    code3_content character varying(500),
    code4_content character varying(500),
    code5_content character varying(500),
    number_data1_value double precision,
    number_data2_value double precision,
    number_data3_value double precision,
    number_data4_value double precision,
    number_data5_value double precision,
    use_flag character(1),
    display_seq_no integer,
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (facility_code ,code_type_code ,code_name);


ALTER TABLE masdacmn.tb_dda_cmn_eas_cd OWNER TO letl;

--
-- Name: tb_dda_cmn_equip_gr_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_equip_gr_m (
    factory_code character varying(40) NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    equipment_group_desc character varying(200),
    term_name character varying(250),
    facility_code character varying(40),
    virtual_flag character(1),
    online_flag character(1),
    offline_flag character(1),
    inspection_flag character(1),
    display_seq_no integer,
    update_user_id character varying(40),
    update_timestamp timestamp without time zone,
    equipment_group_type_code character varying(40)
) DISTRIBUTED BY (factory_code ,equipment_group_id);


ALTER TABLE masdacmn.tb_dda_cmn_equip_gr_m OWNER TO letl;

--
-- Name: tb_dda_cmn_equipment_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_equipment_m (
    factory_code character varying(40) NOT NULL,
    equipment_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    code_desc character varying(200),
    term_name character varying(250),
    machine_type_code character varying(40),
    equipment_hierarchy_type_code character varying(40),
    facility_code character varying(40),
    high_equipment_id character varying(40),
    machine_group_name character varying(40),
    vendor_name character varying(40),
    equipment_state_model_code character varying(40),
    equipment_inline_flag character(1),
    equipment_layer_code character varying(40),
    equipment_port_type_code character varying(40),
    floor_code character varying(40),
    gcs_equipment_id character varying(40),
    rcs_mode_type_code character varying(40),
    inline_stocker_id character varying(40),
    standard_equipment_name character varying(40),
    available_facility_code character varying(40),
    stocker_shelf_name character varying(40),
    root_equipment_id character varying(40),
    machine_code character varying(30),
    module_line_code character varying(10),
    use_flag character(1),
    sub_factory_code character varying(40)
) DISTRIBUTED BY (equipment_id);


ALTER TABLE masdacmn.tb_dda_cmn_equipment_m OWNER TO letl;

--
-- Name: tb_dda_cmn_etl_status; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_etl_status (
    target_table_name character varying(40) NOT NULL,
    job_session_name character varying(100) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    src_tbl_extract_end_timestamp timestamp without time zone,
    job_reflection_timestamp timestamp without time zone
) DISTRIBUTED BY (target_table_name ,job_session_name);


ALTER TABLE masdacmn.tb_dda_cmn_etl_status OWNER TO letl;

--
-- Name: tb_dda_cmn_general_cd; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_general_cd (
    factory_code character varying(40) NOT NULL,
    factory_shop_code character varying(40) NOT NULL,
    code_type_code character varying(40) NOT NULL,
    reason_code character varying(150) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    code_desc character varying(200),
    term_name character varying(250),
    parent_reason_code character varying(40),
    leveling_seq_no integer,
    code_data1_value character varying(100),
    code_data2_value character varying(100),
    code_data3_value character varying(100),
    code_data4_value character varying(100),
    code_data5_value character varying(100),
    number_data1_value double precision,
    number_data2_value double precision,
    number_data3_value double precision,
    number_data4_value double precision,
    number_data5_value double precision,
    mdw_code_data1_value character varying(100),
    mdw_number_data1_value double precision,
    mmd_code_data1_value character varying(40),
    display_seq_no integer,
    use_flag character(1),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (factory_code ,factory_shop_code ,code_type_code ,reason_code);


ALTER TABLE masdacmn.tb_dda_cmn_general_cd OWNER TO letl;

--
-- Name: tb_dda_cmn_judge_attr_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_judge_attr_m (
    facility_code character varying(40) NOT NULL,
    judgement_attribute_code character varying(40) NOT NULL,
    judgement_type_name character varying(40) NOT NULL,
    judgement_code character varying(10) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (facility_code ,judgement_attribute_code ,judgement_type_name ,judgement_code);


ALTER TABLE masdacmn.tb_dda_cmn_judge_attr_m OWNER TO letl;

--
-- Name: tb_dda_cmn_judge_cd_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_judge_cd_m (
    facility_code character varying(40) NOT NULL,
    judgement_type_name character varying(40) NOT NULL,
    judgement_code character varying(10) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    judgement_desc character varying(200),
    term_name character varying(250),
    factory_code character varying(40),
    display_seq_no integer,
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (facility_code ,judgement_type_name ,judgement_code);


ALTER TABLE masdacmn.tb_dda_cmn_judge_cd_m OWNER TO letl;

--
-- Name: tb_dda_cmn_mg_equipment_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_mg_equipment_m (
    module_equipment_surid integer NOT NULL,
    language_code character varying(4) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    module_equipment_id character varying(40),
    effective_start_timestamp timestamp without time zone,
    equipment_std1_name character varying(40),
    equipment_std1_desc character varying(256),
    equipment_std2_name character varying(40),
    equipment_std2_desc character varying(256),
    module_equipment_sid integer,
    data_insert_timestamp timestamp without time zone,
    data_update_timestamp timestamp without time zone,
    data_expiration_timestamp timestamp without time zone,
    effective_end_timestamp timestamp without time zone,
    factory_floor_code character varying(40),
    line_code character varying(10),
    high_equipment_surid integer,
    high_equipment_id character varying(40),
    zone_code character varying(40),
    module_equipment_group_id character varying(40),
    equipment_type_code character varying(40),
    equipment_hierarchy_type_code character varying(40),
    equipment_maker_code character varying(40),
    equipment_model_code character varying(40),
    equipment_state_model_code character varying(40),
    work_process_code character varying(40),
    panel_creation_flag character(1),
    product_serial_no_adhere_flag character(1),
    production_plan_setup_flag character(1),
    monitoring_flag character(1),
    auto_equipment_flag character(1),
    production_equipment_flag character(1),
    quality_equipment_flag character(1),
    report_use_flag character(1),
    input_assembly_type_code character varying(40),
    src_etl_insert_upd_timestamp timestamp without time zone,
    panel_pallet_lcm_qty double precision,
    tact_time_use_flag character(1),
    mdw_etl_transfer_flag character(1),
    pdw_etl_transfer_flag character(1)
) DISTRIBUTED BY (module_equipment_surid ,language_code);


ALTER TABLE masdacmn.tb_dda_cmn_mg_equipment_m OWNER TO letl;

--
-- Name: tb_dda_cmn_mg_model_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_mg_model_m (
    model_surid integer NOT NULL,
    language_code character varying(4) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    module_factory_code character varying(40) NOT NULL,
    model_code character varying(40) NOT NULL,
    effective_start_timestamp timestamp without time zone,
    model_std1_name character varying(40),
    model_std1_desc character varying(256),
    model_std2_name character varying(40),
    model_std2_desc character varying(256),
    model_sid integer,
    data_insert_timestamp timestamp without time zone,
    data_update_timestamp timestamp without time zone,
    data_expiration_timestamp timestamp without time zone,
    model_group_code character varying(40),
    inch_code character varying(40),
    box_packing_qty double precision,
    box_pallet_packing_qty double precision,
    packing_type_code character varying(40),
    out_packing_pallet_type_code character varying(40),
    out_packing_pattern_type_code character varying(40),
    edid_check_flag character(1),
    creation_timestamp timestamp without time zone,
    register_user_id character varying(40),
    wide_model_flag character(1),
    effective_end_timestamp timestamp without time zone,
    model_type_code character varying(40),
    mass_production_first_date date,
    panel_factory_code character varying(40),
    item_type_code character varying(50),
    src_etl_insert_upd_timestamp timestamp without time zone,
    receiving_location_code character varying(40),
    main_sub_flag character(1),
    back_light_code character varying(40),
    mdw_etl_transfer_flag character(1),
    pdw_etl_transfer_flag character(1),
    aging_flag character(1),
    model_3d_type_code character varying(40),
    base_model_code character varying(30)
) DISTRIBUTED BY (model_surid ,language_code);


ALTER TABLE masdacmn.tb_dda_cmn_mg_model_m OWNER TO letl;

--
-- Name: tb_dda_cmn_mg_parts_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_mg_parts_m (
    part_no_surid integer NOT NULL,
    language_code character varying(4) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_shop_code character varying(40),
    part_no_name character varying(40),
    part_no_std1_name character varying(40),
    part_no_std1_desc character varying(256),
    part_no_std2_name character varying(40),
    part_no_std2_desc character varying(256),
    part_no_sid integer,
    data_insert_timestamp timestamp without time zone,
    data_update_timestamp timestamp without time zone,
    data_expiration_timestamp timestamp without time zone,
    production_type_code character varying(40),
    factory_code character varying(40),
    shop_code character varying(40),
    model_group_code character varying(40),
    product_group_code character varying(30),
    inch_code character varying(40),
    sub_shop_code character varying(40),
    panel_per_glass_qty double precision,
    kind_of_product_code character varying(40),
    mmg_type_code character varying(40),
    sub_part_no_name character varying(40),
    tn_ips_code character varying(40),
    raw_material_name character varying(100),
    mask_name character varying(100),
    glass_conversion_ppg_qty numeric(22,5),
    gross_area_square double precision,
    active_area_square double precision,
    yield_calculation_flag character(1),
    display_flag character(1),
    display_priority_code character varying(40),
    tft_shop_part_no_name character varying(40),
    cf_shop_part_no_name character varying(40),
    cell_pnl_sub_shop_part_no_name character varying(40),
    scrap_part_no_name character varying(40),
    estimated_cycle_time_days double precision,
    mmg_sub_model_ppg_qty numeric(22,5),
    stick_management_flag character(1),
    sub_panel_main_qty double precision,
    sub_panel_sub_qty double precision,
    panel_location_info character varying(40),
    effective_start_timestamp timestamp without time zone,
    effective_end_timestamp timestamp without time zone,
    cell_cf_sub_shop_part_no_name character varying(40),
    tft_shop_part_no_surid integer,
    cf_shop_part_no_surid integer,
    cell_panel_part_no_surid integer,
    cell_cf_sub_shop_part_no_surid integer,
    final_flag character(1),
    gross_area_width double precision,
    gross_area_height double precision,
    active_area_width double precision,
    active_area_height double precision,
    use_flag character(1),
    mdm_product_group_code character varying(40),
    source_system_code character varying(30),
    src_etl_insert_upd_timestamp timestamp without time zone,
    input_factory_code character varying(40),
    sub_gls_ppg_qty numeric(22,0),
    succd_prcs_sub_gls_ppg_qty double precision,
    succd_prcs_panel_per_glass_qty double precision,
    product_type_code character varying(10),
    pnl_qty_calc_type_code character varying(40),
    leakage_factory_code character varying(40),
    element_name character varying(300),
    laboratory_project_name character varying(40),
    laboratory_team_name character varying(40),
    shipping_factory_code character varying(40),
    sub_outsourcing_flag character(1),
    tat_process_code character varying(40),
    outside_factory_code character varying(40),
    cell_tft_input_factory_code character varying(40),
    tft_input_factory_code character varying(40),
    insp_management_type_code character varying(40),
    cutting_completion_flag character(1),
    mdw_etl_transfer_flag character(1),
    pdw_etl_transfer_flag character(1),
    tft_model_only_flag character(1),
    auto_prober_less_flag character(1),
    part_no_usage_code character varying(10),
    monitoring_glass_type_code character varying(40),
    total_yield_apply_flag character(1),
    dev_run_mapping_part_no_name character varying(40),
    part_no_sub_usage_code character varying(40)
) DISTRIBUTED BY (part_no_surid ,language_code);


ALTER TABLE masdacmn.tb_dda_cmn_mg_parts_m OWNER TO letl;

--
-- Name: tb_dda_cmn_mg_process_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_mg_process_m (
    process_code character varying(50) NOT NULL,
    language_code character varying(4) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    process_std1_name character varying(40) NOT NULL,
    process_std1_desc character varying(256) NOT NULL,
    process_std2_name character varying(40),
    process_std2_desc character varying(256),
    process_sid integer,
    data_insert_timestamp timestamp without time zone,
    data_update_timestamp timestamp without time zone,
    data_expiration_timestamp timestamp without time zone,
    process_type_code character varying(30),
    default_zone_code character varying(40),
    src_etl_insert_upd_timestamp timestamp without time zone,
    mdw_etl_transfer_flag character(1),
    pdw_etl_transfer_flag character(1)
) DISTRIBUTED BY (process_code ,language_code);


ALTER TABLE masdacmn.tb_dda_cmn_mg_process_m OWNER TO letl;

--
-- Name: tb_dda_cmn_mg_user_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_mg_user_m (
    worker_surid integer NOT NULL,
    language_code character varying(4) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    worker_id character varying(40) NOT NULL,
    effective_start_timestamp timestamp without time zone,
    worker_std1_name character varying(40) NOT NULL,
    worker_std1_desc character varying(256) NOT NULL,
    worker_std2_name character varying(40),
    worker_std2_desc character varying(256),
    worker_sid integer,
    data_insert_timestamp timestamp without time zone,
    data_update_timestamp timestamp without time zone,
    data_expiration_timestamp timestamp without time zone,
    effective_end_timestamp timestamp without time zone,
    zone_code character varying(40),
    shop_code character varying(40),
    factory_code character varying(40),
    worker_department_code character varying(40),
    ehr_department_code character varying(30),
    position_code character varying(10),
    manager_flag character(1),
    field_flag character(1),
    vendorship_company_flag character(1),
    cellular_no character varying(30),
    company_phone_no character varying(50),
    resignation_ymdhms character varying(14),
    final_flag character(1),
    user_crew_code character varying(40),
    work_type_name character varying(100),
    src_etl_insert_upd_timestamp timestamp without time zone,
    mdw_etl_transfer_flag character(1),
    pdw_etl_transfer_flag character(1),
    hire_date date
) DISTRIBUTED BY (worker_surid ,language_code);


ALTER TABLE masdacmn.tb_dda_cmn_mg_user_m OWNER TO letl;

--
-- Name: tb_dda_cmn_model_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_model_m (
    module_factory_code character varying(40) NOT NULL,
    model_group_code character varying(40) NOT NULL,
    model_code character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    effective_start_timestamp timestamp without time zone,
    model_std1_name character varying(40),
    model_std1_desc character varying(256),
    model_std2_name character varying(40),
    model_std2_desc character varying(256),
    model_sid integer,
    data_insert_timestamp timestamp without time zone,
    data_update_timestamp timestamp without time zone,
    data_expiration_timestamp timestamp without time zone,
    inch_code character varying(40),
    box_packing_qty double precision,
    box_pallet_packing_qty double precision,
    packing_type_code character varying(40),
    out_packing_pallet_type_code character varying(40),
    out_packing_pattern_type_code character varying(40),
    edid_check_flag character(1),
    creation_timestamp timestamp without time zone,
    register_user_id character varying(40),
    wide_model_flag character(1),
    effective_end_timestamp timestamp without time zone,
    model_type_code character varying(40),
    mass_production_first_date date,
    panel_factory_code character varying(40),
    item_type_code character varying(50),
    src_etl_insert_upd_timestamp timestamp without time zone,
    receiving_location_code character varying(40),
    main_sub_flag character(1),
    back_light_code character varying(40),
    mdw_etl_transfer_flag character(1),
    pdw_etl_transfer_flag character(1),
    aging_flag character(1),
    model_3d_type_code character varying(40),
    base_model_code character varying(30),
    use_flag character(1)
) DISTRIBUTED BY (module_factory_code ,model_group_code ,model_code);


ALTER TABLE masdacmn.tb_dda_cmn_model_m OWNER TO letl;

--
-- Name: tb_dda_cmn_multi_lang_dict_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_multi_lang_dict_m (
    multi_language_code character varying(250) NOT NULL,
    multi_language_type_code character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    term_name character varying(250),
    term_type_code character varying(40),
    use_flag character(1)
) DISTRIBUTED BY (multi_language_code ,multi_language_type_code);


ALTER TABLE masdacmn.tb_dda_cmn_multi_lang_dict_m OWNER TO letl;

--
-- Name: tb_dda_cmn_panel_map_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_panel_map_m (
    facility_code character varying(40) NOT NULL,
    part_no_name character varying(40) NOT NULL,
    panel_seq_no integer NOT NULL,
    panel_corner_seq_no character(1) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    x_coordinate_value double precision,
    y_coordinate_value double precision,
    panel_location_info character varying(40),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (facility_code ,part_no_name ,panel_seq_no ,panel_corner_seq_no);


ALTER TABLE masdacmn.tb_dda_cmn_panel_map_m OWNER TO letl;

--
-- Name: tb_dda_cmn_parts_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_parts_m (
    facility_code character varying(40) NOT NULL,
    part_no_name character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    code_desc character varying(200),
    term_name character varying(250),
    creation_timestamp timestamp without time zone,
    creation_user_id character varying(40),
    production_type_code character varying(40),
    product_type_code character varying(10),
    sub_product_type_code character varying(40),
    mmg_type_code character varying(40),
    sub_product_unit1_qty double precision,
    sub_product_unit2_qty double precision,
    part_no2_name character varying(40),
    cf_part_no_name character varying(40),
    glass_direction_code character varying(40),
    inch_code character varying(40),
    mmg_sub_location_info character varying(40),
    model_code character varying(40),
    panel_location_info character varying(40),
    succd_process_part_no_name character varying(40),
    succd_process_mmg_part_no_name character varying(40),
    tft_part_no_name character varying(40),
    tn_ips_code character varying(40),
    shipping_factory_code character varying(40),
    update_ymdhms character varying(14),
    factory_code character varying(40),
    part_no_usage_code character varying(10),
    use_flag character(1)
) DISTRIBUTED BY (facility_code ,part_no_name);


ALTER TABLE masdacmn.tb_dda_cmn_parts_m OWNER TO letl;

--
-- Name: tb_dda_cmn_process_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_process_m (
    facility_code character varying(40) NOT NULL,
    process_code character varying(50) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    check_in_status_code character varying(40),
    active_state_name character varying(40),
    creation_timestamp timestamp without time zone,
    creation_user_id character varying(40),
    check_out_timestamp timestamp without time zone,
    check_out_user_id character varying(40),
    process_operation_type_code character varying(40),
    detail_process_op_type_code character varying(40),
    process_group_code character varying(40),
    process_unit_code character varying(40),
    login_required_flag character(1),
    default_area_name character varying(40),
    alternate_route_flag character(1),
    bonus_code_flag character(1),
    cell_location_code character varying(40),
    cassette_clean_flag character(1),
    gate_photo_validation_code character varying(40),
    loss_code_flag character(1),
    process_flag_info character varying(40),
    photo_insp_waiting_prcs_code character varying(40),
    hold_release_code character varying(40),
    rework_code_flag character(1),
    rework_lot_code character varying(40),
    sputter_target_code character varying(40),
    update_ymdhms character varying(14),
    process_type_code character varying(30),
    inspection_step_code character varying(40),
    inspection_equip_type_code character varying(40),
    front_back_check_flag character(1),
    aligner_check_flag character(1),
    cell_shop_first_insp_prcs_flag character(1),
    cell_shop_reinsp_process_flag character(1),
    wip_group_name character varying(100),
    rework_lot_detail_code character varying(2),
    term_name character varying(250),
    use_flag character(1),
    code_desc character varying(200)
) DISTRIBUTED BY (facility_code ,process_code);


ALTER TABLE masdacmn.tb_dda_cmn_process_m OWNER TO letl;

--
-- Name: tb_dda_cmn_qlty_cd_field_item_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_qlty_cd_field_item_m (
    field_code character varying(40) NOT NULL,
    field_item_code character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    field_item_name character varying(300),
    term_name character varying(250),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (field_code);


ALTER TABLE masdacmn.tb_dda_cmn_qlty_cd_field_item_m OWNER TO letl;

--
-- Name: tb_dda_cmn_qlty_cd_field_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_qlty_cd_field_m (
    field_code character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    field_name character varying(300),
    term_name character varying(250),
    field_seq_no integer,
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (field_code);


ALTER TABLE masdacmn.tb_dda_cmn_qlty_cd_field_m OWNER TO letl;

--
-- Name: tb_dda_cmn_qlty_cd_field_seq_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_qlty_cd_field_seq_m (
    shop_type_code character varying(10) NOT NULL,
    parts_code character varying(40) NOT NULL,
    defect_large_class_code character varying(40) NOT NULL,
    field_code character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    display_seq_no integer,
    representative_field_flag character(1),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (shop_type_code ,parts_code ,defect_large_class_code);


ALTER TABLE masdacmn.tb_dda_cmn_qlty_cd_field_seq_m OWNER TO letl;

--
-- Name: tb_dda_cmn_qlty_cd_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_qlty_cd_m (
    shop_type_code character varying(10) NOT NULL,
    parts_code character varying(40) NOT NULL,
    defect_large_class_code character varying(40) NOT NULL,
    field_code character varying(40) NOT NULL,
    field_item_code character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    use_flag character(1),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (shop_type_code ,parts_code ,defect_large_class_code);


ALTER TABLE masdacmn.tb_dda_cmn_qlty_cd_m OWNER TO letl;

--
-- Name: tb_dda_cmn_rel_prcs_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_rel_prcs_m (
    facility_code character varying(40) NOT NULL,
    process_code character varying(50) NOT NULL,
    related_process_code character varying(40) NOT NULL,
    related_equipment_group_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    related_process_type_code character(1),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone,
    priority_no integer
) DISTRIBUTED BY (facility_code ,process_code ,related_process_code ,related_equipment_group_id);


ALTER TABLE masdacmn.tb_dda_cmn_rel_prcs_m OWNER TO letl;

--
-- Name: tb_dda_cmn_representative_def; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_representative_def (
    shop_type_code character varying(10) NOT NULL,
    field1_code character varying(40) NOT NULL,
    field2_code character varying(40) NOT NULL,
    defect_code_surid integer NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    representative_defect_code character varying(2500),
    representative_defect_desc character varying(2500)
) DISTRIBUTED BY (shop_type_code ,field1_code ,field2_code ,defect_code_surid);


ALTER TABLE masdacmn.tb_dda_cmn_representative_def OWNER TO letl;

--
-- Name: tb_dda_cmn_representative_def_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_representative_def_m (
    shop_type_code character varying(10) NOT NULL,
    field1_code character varying(40) NOT NULL,
    field2_code character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    field3_code character varying(40),
    field4_code character varying(40),
    field5_code character varying(40),
    field6_code character varying(40),
    field7_code character varying(40),
    field8_code character varying(40),
    field9_code character varying(40),
    field10_code character varying(40),
    field11_code character varying(40),
    field12_code character varying(40),
    field13_code character varying(40),
    field14_code character varying(40),
    field15_code character varying(40),
    field16_code character varying(40),
    field17_code character varying(40),
    field18_code character varying(40),
    field19_code character varying(40),
    field20_code character varying(40),
    field21_code character varying(40),
    field22_code character varying(40),
    field23_code character varying(40),
    field24_code character varying(40),
    field25_code character varying(40),
    field26_code character varying(40),
    field27_code character varying(40),
    field28_code character varying(40),
    field29_code character varying(40),
    field30_code character varying(40),
    field31_code character varying(40),
    field32_code character varying(40),
    field33_code character varying(40),
    field34_code character varying(40)
) DISTRIBUTED BY (shop_type_code ,field1_code ,field2_code);


ALTER TABLE masdacmn.tb_dda_cmn_representative_def_m OWNER TO letl;

--
-- Name: tb_dda_cmn_sdc2_def_cond_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_sdc2_def_cond_m (
    facility_code character varying(40) NOT NULL,
    specification_group_id character varying(50) NOT NULL,
    full_defect_code character varying(150) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone,
    inspection_step_code character varying(40)
) DISTRIBUTED BY (facility_code ,specification_group_id);


ALTER TABLE masdacmn.tb_dda_cmn_sdc2_def_cond_m OWNER TO letl;

--
-- Name: tb_dda_cmn_sdc2_insp_data_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_sdc2_insp_data_m (
    facility_code character varying(40) NOT NULL,
    specification_group_id character varying(50) NOT NULL,
    defect_file_spec_type_code character varying(10) NOT NULL,
    defect_file_section_id character varying(40) NOT NULL,
    inspection_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (facility_code ,specification_group_id);


ALTER TABLE masdacmn.tb_dda_cmn_sdc2_insp_data_m OWNER TO letl;

--
-- Name: tb_dda_cmn_sdc2_judge_cond_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_sdc2_judge_cond_m (
    facility_code character varying(40) NOT NULL,
    specification_group_id character varying(50) NOT NULL,
    numerator_flag character(1) NOT NULL,
    judgement_type_code character(1) NOT NULL,
    judgement_code character varying(10) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone,
    inspection_step_code character varying(40)
) DISTRIBUTED BY (facility_code ,specification_group_id);


ALTER TABLE masdacmn.tb_dda_cmn_sdc2_judge_cond_m OWNER TO letl;

--
-- Name: tb_dda_cmn_sdc2_spec_cont_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_sdc2_spec_cont_m (
    facility_code character varying(40) NOT NULL,
    specification_group_id character varying(50) NOT NULL,
    spec_seq_no bigint NOT NULL,
    contact_id character varying(30) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    specification_contact_flag character(1),
    mail_receive_flag character(1),
    sms_flag character(1),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (facility_code ,specification_group_id);


ALTER TABLE masdacmn.tb_dda_cmn_sdc2_spec_cont_m OWNER TO letl;

--
-- Name: tb_dda_cmn_sdc2_spec_gr_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_sdc2_spec_gr_m (
    facility_code character varying(40) NOT NULL,
    specification_group_id character varying(50) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    section_code character varying(30),
    section_length numeric(15,4),
    section_type_code character varying(10),
    numerator_calc_method_code character varying(10),
    denominator_calc_method_code character varying(10),
    check_value double precision,
    continue_value double precision,
    lot_hold_flag character(1),
    process_down_flag character(1),
    process_down_code character varying(100),
    cause_code character varying(60),
    cause_department_code character varying(40),
    cell_after_flag character(1),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone,
    specification_type_code character varying(40),
    prcs_down_equipment_type_code character varying(40),
    process_down_check_value double precision,
    process_down_continue_value double precision
) DISTRIBUTED BY (facility_code ,specification_group_id);


ALTER TABLE masdacmn.tb_dda_cmn_sdc2_spec_gr_m OWNER TO letl;

--
-- Name: tb_dda_cmn_sdc2_spec_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_sdc2_spec_m (
    facility_code character varying(40) NOT NULL,
    specification_group_id character varying(50) NOT NULL,
    spec_seq_no bigint NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    part_no_name character varying(40),
    inspection_process_code character varying(40),
    inspection_equipment_group_id character varying(40),
    inspection_equipment_id character varying(40),
    cause_process_code character varying(40),
    cause_equipment_id character varying(40),
    upper_limit_value double precision,
    usl_value double precision,
    ucl_value double precision,
    target_value double precision,
    lcl_value double precision,
    lsl_value double precision,
    lower_limit_value double precision,
    min_panel_count double precision,
    change_reason_desc character varying(1000),
    register_user_id character varying(40),
    specification_reg_timestamp timestamp without time zone,
    apply_flag character(1),
    delete_flag character(1),
    denominator_process_code character varying(10),
    denominator_equipment_code character varying(50)
) DISTRIBUTED BY (facility_code ,specification_group_id);


ALTER TABLE masdacmn.tb_dda_cmn_sdc2_spec_m OWNER TO letl;

--
-- Name: tb_dda_cmn_spc_apd_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_spc_apd_m (
    facility_code character varying(40) NOT NULL,
    specification_group_id character varying(50) NOT NULL,
    measure_equipment_group_id character varying(40) NOT NULL,
    apd_collection_code character(1) NOT NULL,
    apd_data_group_flag character(1) NOT NULL,
    apd_data_group_id character varying(40) NOT NULL,
    apd_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (facility_code ,specification_group_id);


ALTER TABLE masdacmn.tb_dda_cmn_spc_apd_m OWNER TO letl;

--
-- Name: tb_dda_cmn_spc_chart_info_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_spc_chart_info_m (
    facility_code character varying(40) NOT NULL,
    control_chart_id character varying(40) NOT NULL,
    child_chart_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    child_chart_name character varying(60),
    child_chart_type_code character varying(40),
    specification_group_id character varying(50),
    display_flag character(1),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone,
    display_seq_no integer
) DISTRIBUTED BY (facility_code ,control_chart_id);


ALTER TABLE masdacmn.tb_dda_cmn_spc_chart_info_m OWNER TO letl;

--
-- Name: tb_dda_cmn_spc_chart_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_spc_chart_m (
    facility_code character varying(40) NOT NULL,
    control_chart_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    control_chart_name character varying(60),
    control_chart_sub_name character varying(60),
    production_equipment_group_id character varying(40),
    production_equipment_group2_id character varying(40),
    manual_flag character(1),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (facility_code ,control_chart_id);


ALTER TABLE masdacmn.tb_dda_cmn_spc_chart_m OWNER TO letl;

--
-- Name: tb_dda_cmn_spc_chart_raw_data_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_spc_chart_raw_data_m (
    facility_code character varying(40) NOT NULL,
    control_chart_id character varying(40) NOT NULL,
    x_axis_unit_code character varying(40) NOT NULL,
    raw_data_type_code character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    uniformity_info character varying(100),
    display_seq_no integer,
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (facility_code ,control_chart_id);


ALTER TABLE masdacmn.tb_dda_cmn_spc_chart_raw_data_m OWNER TO letl;

--
-- Name: tb_dda_cmn_spc_measr_equip_gr_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_spc_measr_equip_gr_m (
    facility_code character varying(40) NOT NULL,
    specification_group_id character varying(50) NOT NULL,
    measure_equipment_group_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (facility_code ,specification_group_id);


ALTER TABLE masdacmn.tb_dda_cmn_spc_measr_equip_gr_m OWNER TO letl;

--
-- Name: tb_dda_cmn_spc_prod_equip_gr_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_spc_prod_equip_gr_m (
    facility_code character varying(40) NOT NULL,
    specification_group_id character varying(50) NOT NULL,
    production_equipment_group_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    priority_no integer,
    update_user_id character varying(40),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (facility_code ,specification_group_id);


ALTER TABLE masdacmn.tb_dda_cmn_spc_prod_equip_gr_m OWNER TO letl;

--
-- Name: tb_dda_cmn_spc_spec_cont_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_spc_spec_cont_m (
    facility_code character varying(40) NOT NULL,
    specification_group_id character varying(50) NOT NULL,
    part_no_name character varying(40) NOT NULL,
    measure_process_code character varying(40) NOT NULL,
    production_equipment_id character varying(40) NOT NULL,
    production_equipment2_id character varying(40) NOT NULL,
    specification_reg_timestamp timestamp without time zone NOT NULL,
    contact_id character varying(30) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    specification_contact_flag character(1),
    mail_receive_flag character(1),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone,
    sms_flag character(1)
) DISTRIBUTED BY (facility_code ,specification_group_id);


ALTER TABLE masdacmn.tb_dda_cmn_spc_spec_cont_m OWNER TO letl;

--
-- Name: tb_dda_cmn_spc_spec_gr_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_spc_spec_gr_m (
    facility_code character varying(40) NOT NULL,
    specification_group_id character varying(50) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    equipment_type_code character varying(40),
    ctq_flag character(1),
    specification_type_code character varying(40),
    data_unit_code character varying(40),
    calculation_method_code character varying(30),
    equipment_calc_value_use_flag character(1),
    lot_hold_flag character(1),
    cassette_list character varying(2000),
    slot_list character varying(2000),
    update_user_id character varying(40),
    update_timestamp timestamp without time zone,
    equipment_hold_flag character(1),
    spec_out_rate_management_flag character(1),
    filtering_rate_management_flag character(1),
    check_value double precision,
    continue_value double precision,
    auto_booking_flag character(1),
    primary_control_chart_id character varying(40),
    primary_control_chart_sub_name character varying(60),
    epk_flag character(1),
    specific_type_code character varying(10),
    trouble_alert_accu_mgt_flag character(1),
    attribute_code character varying(40)
) DISTRIBUTED BY (facility_code ,specification_group_id);


ALTER TABLE masdacmn.tb_dda_cmn_spc_spec_gr_m OWNER TO letl;

--
-- Name: tb_dda_cmn_spc_spec_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_spc_spec_m (
    facility_code character varying(40) NOT NULL,
    specification_group_id character varying(50) NOT NULL,
    part_no_name character varying(40) NOT NULL,
    measure_process_code character varying(40) NOT NULL,
    production_equipment_id character varying(40) NOT NULL,
    production_equipment2_id character varying(40) NOT NULL,
    specification_reg_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    upper_limit_value double precision,
    usl_value double precision,
    ucl_value double precision,
    cl_value double precision,
    target_value double precision,
    lcl_value double precision,
    lsl_value double precision,
    lower_limit_value double precision,
    range_usl_value double precision,
    range_ucl_value double precision,
    display_data_scale_value double precision,
    inspection_point_count double precision,
    spec_out_grade_code character varying(10),
    register_user_id character varying(40),
    change_reason_desc character varying(1000),
    apply_flag character(1),
    delete_flag character(1),
    sigma_usl_value double precision,
    sigma_ucl_value double precision,
    sigma3_usl_value double precision,
    sigma3_ucl_value double precision,
    uniformity_usl_value double precision,
    uniformity_ucl_value double precision,
    event_process_flag character(1),
    cause_process_code character varying(40)
) DISTRIBUTED BY (facility_code ,specification_group_id);


ALTER TABLE masdacmn.tb_dda_cmn_spc_spec_m OWNER TO letl;

--
-- Name: tb_dda_cmn_tfo_policy_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_tfo_policy_m (
    facility_code character varying(40) NOT NULL,
    process_flow_name character varying(40) NOT NULL,
    process_code character varying(50) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    process_operation_unique_id character varying(40),
    cassette_map_update_flag character(1),
    glass_regeneration_flag character(1),
    move_in_required_flag character(1),
    next_process_code character varying(40),
    part_no_change_flag character(1),
    pre_process_code character varying(40),
    rework_process_code character varying(40),
    rework_route_id character varying(40),
    rework_revert_process_code character varying(40),
    rework_revert_route_id character varying(40),
    process_seq_no integer,
    interlock_process_code character varying(40),
    update_ymdhms character varying(14),
    re_move_in_prohibit_flag character(1),
    glass_handling_flag character(1),
    group_serial_no integer
) DISTRIBUTED BY (facility_code ,process_flow_name ,process_code);


ALTER TABLE masdacmn.tb_dda_cmn_tfo_policy_m OWNER TO letl;

--
-- Name: tb_dda_cmn_tpfo_policy_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_tpfo_policy_m (
    facility_code character varying(40) NOT NULL,
    part_no_name character varying(40) NOT NULL,
    process_flow_name character varying(40) NOT NULL,
    process_code character varying(50) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    process_operation_unique_id character varying(40),
    required_flag character(1),
    mandatory_setup_user_id character varying(40),
    engineer_code_flag character(1),
    engineer_id character varying(40),
    hold_flag character(1),
    hold_code character varying(40),
    hold_comment character varying(600),
    hold_user_id character varying(40),
    update_ymdhms character varying(14),
    auto_transport_phase_code character varying(40),
    req_prcs_interlock_check_flag character(1)
) DISTRIBUTED BY (facility_code ,part_no_name ,process_flow_name ,process_code);


ALTER TABLE masdacmn.tb_dda_cmn_tpfo_policy_m OWNER TO letl;

--
-- Name: tb_dda_cmn_tpfom_policy_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_tpfom_policy_m (
    facility_code character varying(40) NOT NULL,
    part_no_name character varying(40) NOT NULL,
    process_flow_name character varying(40) NOT NULL,
    process_code character varying(50) NOT NULL,
    equipment_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    process_operation_unique_id character varying(40),
    auto_transport_priority_code character varying(40),
    recipe_name character varying(100),
    recipe_seq_no integer,
    update_ymdhms character varying(14),
    multi_recipe_type_code character varying(40),
    check_type_code character varying(40)
) DISTRIBUTED BY (facility_code ,process_flow_name ,process_code);


ALTER TABLE masdacmn.tb_dda_cmn_tpfom_policy_m OWNER TO letl;

--
-- Name: tb_dda_cmn_user_def_gr_detail_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_user_def_gr_detail_m (
    shop_type_code character varying(10) NOT NULL,
    user_id character varying(40) NOT NULL,
    defect_code_group_name character varying(150) NOT NULL,
    full_defect_code character varying(150) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    full_defect_desc character varying(4000),
    summary_defect_code character varying(150) NOT NULL,
    summary_defect_desc character varying(4000),
    field1_code character varying(40),
    field1_desc character varying(100),
    field2_code character varying(40),
    field2_desc character varying(100),
    field3_code character varying(40),
    field3_desc character varying(100),
    field4_code character varying(40),
    field4_desc character varying(100),
    field5_code character varying(40),
    field5_desc character varying(100),
    field6_code character varying(40),
    field6_desc character varying(100),
    field7_code character varying(40),
    field7_desc character varying(100),
    field8_code character varying(40),
    field8_desc character varying(100),
    field9_code character varying(40),
    field9_desc character varying(100),
    field10_code character varying(40),
    field10_desc character varying(100),
    field11_code character varying(40),
    field11_desc character varying(100),
    field12_code character varying(40),
    field12_desc character varying(100),
    field13_code character varying(40),
    field13_desc character varying(100),
    field14_code character varying(40),
    field14_desc character varying(100),
    field15_code character varying(40),
    field15_desc character varying(100),
    field16_code character varying(40),
    field16_desc character varying(100),
    field17_code character varying(40),
    field17_desc character varying(100),
    field18_code character varying(40),
    field18_desc character varying(100),
    field19_code character varying(40),
    field19_desc character varying(100),
    field20_code character varying(40),
    field20_desc character varying(100),
    field21_code character varying(40),
    field21_desc character varying(100),
    field22_code character varying(40),
    field22_desc character varying(100),
    field23_code character varying(40),
    field23_desc character varying(100),
    field24_code character varying(40),
    field24_desc character varying(100),
    field25_code character varying(40),
    field25_desc character varying(100),
    field26_code character varying(40),
    field26_desc character varying(100),
    field27_code character varying(40),
    field27_desc character varying(100),
    field28_code character varying(40),
    field28_desc character varying(100),
    field29_code character varying(40),
    field29_desc character varying(100),
    field30_code character varying(40),
    field30_desc character varying(100),
    field31_code character varying(40),
    field31_desc character varying(100),
    field32_code character varying(40),
    field32_desc character varying(100),
    field33_code character varying(40),
    field33_desc character varying(100),
    field34_code character varying(40),
    field34_desc character varying(100),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (shop_type_code ,user_id ,defect_code_group_name ,full_defect_code);


ALTER TABLE masdacmn.tb_dda_cmn_user_def_gr_detail_m OWNER TO letl;

--
-- Name: tb_dda_cmn_user_def_gr_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_user_def_gr_m (
    shop_type_code character varying(10) NOT NULL,
    user_id character varying(40) NOT NULL,
    defect_code_group_name character varying(150) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    public_flag character(1),
    update_timestamp timestamp without time zone
) DISTRIBUTED BY (shop_type_code ,user_id ,defect_code_group_name);


ALTER TABLE masdacmn.tb_dda_cmn_user_def_gr_m OWNER TO letl;

--
-- Name: tb_dda_cmn_user_m; Type: TABLE; Schema: masdacmn; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_cmn_user_m (
    user_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    user_group_name character varying(40),
    user_name character varying(250),
    department_code character varying(40),
    default_language_code character varying(5),
    shift_crew_code character varying(30),
    email_addr character varying(250),
    phone_no character varying(30),
    ip_phone_no character varying(50),
    employee_no character varying(30),
    factory_code character varying(40),
    mobile_phone_no character varying(30),
    use_flag character(1)
) DISTRIBUTED BY (user_id);


ALTER TABLE masdacmn.tb_dda_cmn_user_m OWNER TO letl;

SET search_path = masdainf, pg_catalog;

--
-- Name: a; Type: TABLE; Schema: masdainf; Owner: gpadmin; Tablespace: 
--

CREATE TABLE a (
    "timestamp" timestamp without time zone
) DISTRIBUTED BY ("timestamp");


ALTER TABLE masdainf.a OWNER TO gpadmin;

--
-- Name: tb_dda_inf_ea_def_cd; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_inf_ea_def_cd (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    shop_type_code character varying(10) NOT NULL,
    apply_yyyymm character varying(6) NOT NULL,
    defect_seq_no bigint NOT NULL,
    full_defect_code character varying(150),
    field1_code character varying(40),
    field1_desc character varying(100),
    field2_code character varying(40),
    field2_desc character varying(100),
    field3_code character varying(40),
    field3_desc character varying(100),
    field4_code character varying(40),
    field4_desc character varying(100),
    field5_code character varying(40),
    field5_desc character varying(100),
    field6_code character varying(40),
    field6_desc character varying(100),
    field7_code character varying(40),
    field7_desc character varying(100),
    field8_code character varying(40),
    field8_desc character varying(100),
    field9_code character varying(40),
    field9_desc character varying(100),
    field10_code character varying(40),
    field10_desc character varying(100),
    field11_code character varying(40),
    field11_desc character varying(100),
    field12_code character varying(40),
    field12_desc character varying(100),
    field13_code character varying(40),
    field13_desc character varying(100),
    field14_code character varying(40),
    field14_desc character varying(100),
    field15_code character varying(40),
    field15_desc character varying(100),
    field16_code character varying(40),
    field16_desc character varying(100),
    field17_code character varying(40),
    field17_desc character varying(100),
    field18_code character varying(40),
    field18_desc character varying(100),
    field19_code character varying(40),
    field19_desc character varying(100),
    field20_code character varying(40),
    field20_desc character varying(100),
    field21_code character varying(40),
    field21_desc character varying(100),
    field22_code character varying(40),
    field22_desc character varying(100),
    field23_code character varying(40),
    field23_desc character varying(100),
    field24_code character varying(40),
    field24_desc character varying(100),
    field25_code character varying(40),
    field25_desc character varying(100),
    old_defect_code character varying(40),
    update_user_id character varying(40),
    update_date timestamp without time zone,
    field26_code character varying(40),
    field26_desc character varying(100),
    field27_code character varying(40),
    field27_desc character varying(100),
    field28_code character varying(40),
    field28_desc character varying(100),
    field29_code character varying(40),
    field29_desc character varying(100),
    field30_code character varying(40),
    field30_desc character varying(100),
    field31_code character varying(40),
    field31_desc character varying(100),
    field32_code character varying(40),
    field32_desc character varying(100),
    field33_code character varying(40),
    field33_desc character varying(100),
    field34_code character varying(40),
    field34_desc character varying(100)
) DISTRIBUTED BY (shop_type_code ,apply_yyyymm ,defect_seq_no);


ALTER TABLE masdainf.tb_dda_inf_ea_def_cd OWNER TO letl;

--
-- Name: tb_dda_inf_ea_multi_lang_dict_m; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_inf_ea_multi_lang_dict_m (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    multi_language_code character varying(250) NOT NULL,
    multi_language_type_code character varying(40) NOT NULL,
    term_name character varying(250),
    term_type_code character varying(40),
    use_flag character(1)
) DISTRIBUTED BY (multi_language_code ,multi_language_type_code);


ALTER TABLE masdainf.tb_dda_inf_ea_multi_lang_dict_m OWNER TO letl;

--
-- Name: tb_dda_inf_ea_user_profile_m; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_inf_ea_user_profile_m (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    userid character varying(40) NOT NULL,
    usergroupname character varying(40),
    username character varying(40),
    password character varying(200),
    department_code character varying(40),
    default_language_code character varying(5),
    shift_code character varying(10),
    email_addr character varying(250),
    pre1_password character varying(200),
    pre2_password character varying(200),
    last_login_date timestamp without time zone,
    password_error_count double precision,
    password_change_date timestamp without time zone,
    user_account_lock_flag character(1),
    resignation_date timestamp without time zone,
    program_authority_code character varying(100),
    phone_no character varying(30),
    ip_phone_no character varying(50),
    mail_receive_flag character(1),
    ememo_facility_code character varying(40),
    login_certification_code character varying(250),
    employee_no character varying(30),
    factory_code character varying(40),
    mobile_phone_no character varying(30)
) DISTRIBUTED BY (userid);


ALTER TABLE masdainf.tb_dda_inf_ea_user_profile_m OWNER TO letl;

--
-- Name: tb_dda_inf_mg_model_m; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_inf_mg_model_m (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    model_surid integer NOT NULL,
    language_code character varying(4) NOT NULL,
    module_factory_code character varying(40) NOT NULL,
    model_code character varying(40) NOT NULL,
    effective_start_timestamp timestamp without time zone,
    model_std1_name character varying(40),
    model_std1_desc character varying(256),
    model_std2_name character varying(40),
    model_std2_desc character varying(256),
    model_sid integer,
    data_insert_timestamp timestamp without time zone,
    data_update_timestamp timestamp without time zone,
    data_expiration_timestamp timestamp without time zone,
    model_group_code character varying(40),
    inch_code character varying(40),
    box_packing_qty double precision,
    box_pallet_packing_qty double precision,
    packing_type_code character varying(40),
    out_packing_pallet_type_code character varying(40),
    out_packing_pattern_type_code character varying(40),
    edid_check_flag character(1),
    creation_timestamp timestamp without time zone,
    register_user_id character varying(40),
    wide_model_flag character(1),
    effective_end_timestamp timestamp without time zone,
    model_type_code character varying(40),
    mass_production_first_date date,
    panel_factory_code character varying(40),
    item_type_code character varying(40),
    src_etl_insert_upd_timestamp timestamp without time zone,
    receiving_location_code character varying(40),
    main_sub_flag character(1),
    back_light_code character varying(40),
    mdw_etl_transfer_flag character(1),
    pdw_etl_transfer_flag character(1),
    aging_flag character(1),
    model_3d_type_code character varying(40),
    base_model_code character varying(30)
) DISTRIBUTED BY (model_surid ,language_code);


ALTER TABLE masdainf.tb_dda_inf_mg_model_m OWNER TO letl;

--
-- Name: tb_dda_inf_mg_part_no_m; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_inf_mg_part_no_m (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    part_no_surid integer NOT NULL,
    language_code character varying(4) NOT NULL,
    factory_shop_code character varying(40),
    part_no_name character varying(40),
    part_no_std1_name character varying(40),
    part_no_std1_desc character varying(256),
    part_no_std2_name character varying(40),
    part_no_std2_desc character varying(256),
    part_no_sid integer,
    data_insert_timestamp timestamp without time zone,
    data_update_timestamp timestamp without time zone,
    data_expiration_timestamp timestamp without time zone,
    production_type_code character varying(40),
    factory_code character varying(40),
    shop_code character varying(10),
    model_group_code character varying(40),
    product_group_code character varying(30),
    inch_code character varying(40),
    sub_shop_code character varying(40),
    panel_per_glass_qty double precision,
    kind_of_product_code character varying(40),
    mmg_type_code character varying(40),
    sub_part_no_name character varying(40),
    tn_ips_code character varying(40),
    raw_material_name character varying(100),
    mask_name character varying(100),
    glass_conversion_ppg_qty numeric(22,5),
    gross_area_square numeric(30,14),
    active_area_square numeric(30,14),
    yield_calculation_flag character(1),
    display_flag character(1),
    display_priority_code character varying(40),
    tft_shop_part_no_name character varying(40),
    cf_shop_part_no_name character varying(40),
    cell_pnl_sub_shop_part_no_name character varying(40),
    scrap_part_no_name character varying(40),
    estimated_cycle_time_days double precision,
    mmg_sub_model_ppg_qty numeric(22,5),
    stick_management_flag character(1),
    sub_panel_main_qty double precision,
    sub_panel_sub_qty double precision,
    panel_location_info character varying(40),
    effective_start_timestamp timestamp without time zone,
    effective_end_timestamp timestamp without time zone,
    cell_cf_sub_shop_part_no_name character varying(40),
    tft_shop_part_no_surid integer,
    cf_shop_part_no_surid integer,
    cell_panel_part_no_surid integer,
    cell_cf_sub_shop_part_no_surid integer,
    final_flag character(1),
    gross_area_width double precision,
    gross_area_height double precision,
    active_area_width double precision,
    active_area_height double precision,
    use_flag character(1),
    mdm_product_group_code character varying(40),
    source_system_code character varying(30),
    src_etl_insert_upd_timestamp timestamp without time zone,
    input_factory_code character varying(40),
    sub_gls_ppg_qty double precision,
    succd_prcs_sub_gls_ppg_qty double precision,
    succd_prcs_panel_per_glass_qty double precision,
    product_type_code character varying(40),
    pnl_qty_calc_type_code character varying(40),
    leakage_factory_code character varying(40),
    element_name character varying(40),
    laboratory_project_name character varying(40),
    laboratory_team_name character varying(40),
    shipping_factory_code character varying(40),
    sub_outsourcing_flag character(1),
    tat_process_code character varying(40),
    outside_factory_code character varying(40),
    cell_tft_input_factory_code character varying(40),
    tft_input_factory_code character varying(40),
    insp_management_type_code character varying(40),
    cutting_completion_flag character(1),
    mdw_etl_transfer_flag character(1),
    pdw_etl_transfer_flag character(1),
    tft_model_only_flag character(1),
    auto_prober_less_flag character(1),
    part_no_usage_code character varying(10),
    monitoring_glass_type_code character varying(40),
    total_yield_apply_flag character(1),
    dev_run_map_part_no_name character varying(40),
    part_no_sub_usage_code character varying(40)
) DISTRIBUTED BY (part_no_surid ,language_code);


ALTER TABLE masdainf.tb_dda_inf_mg_part_no_m OWNER TO letl;

--
-- Name: tb_dda_inf_mg_worker_m; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_dda_inf_mg_worker_m (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    worker_surid integer NOT NULL,
    language_code character varying(4) NOT NULL,
    worker_id character varying(40) NOT NULL,
    effective_start_timestamp timestamp without time zone,
    worker_std1_name character varying(40) NOT NULL,
    worker_std1_desc character varying(256) NOT NULL,
    worker_std2_name character varying(40),
    worker_std2_desc character varying(256),
    worker_sid integer,
    data_insert_timestamp timestamp without time zone,
    data_update_timestamp timestamp without time zone,
    data_expiration_timestamp timestamp without time zone,
    effective_end_timestamp timestamp without time zone,
    zone_code character varying(40),
    shop_code character varying(40),
    factory_code character varying(40),
    worker_department_code character varying(40),
    ehr_department_code character varying(30),
    position_code character varying(13),
    manager_flag character(1),
    field_flag character(1),
    vendorship_company_flag character(1),
    cellular_no character varying(30),
    company_phone_no character varying(50),
    resignation_ymdhms character varying(14),
    final_flag character(1),
    user_crew_code character varying(40),
    work_type_name character varying(100),
    src_etl_insert_upd_timestamp timestamp without time zone,
    mdw_etl_transfer_flag character(1),
    pdw_etl_transfer_flag character(1),
    hire_date date
) DISTRIBUTED BY (worker_surid ,language_code);


ALTER TABLE masdainf.tb_dda_inf_mg_worker_m OWNER TO letl;

--
-- Name: tb_fda_inf_ea_apd_detail; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_apd_detail (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    receive_ymdhms character varying(14) NOT NULL,
    apd_seq_no bigint NOT NULL,
    apd_data_id character varying(40) NOT NULL,
    lot_id character varying(40),
    glass_id character varying(40),
    apd_data_group_id character varying(40),
    apd_collection_code character(1),
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (equipment_group_id ,receive_ymdhms ,apd_seq_no ,apd_data_id);


ALTER TABLE masdainf.tb_fda_inf_ea_apd_detail OWNER TO letl;

--
-- Name: tb_fda_inf_ea_apd_h; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_apd_h (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    receive_ymdhms character varying(14) NOT NULL,
    apd_seq_no bigint NOT NULL,
    facility_code character varying(40),
    equipment_id character varying(40),
    equipment_unit_id character varying(40),
    apd_collection_code character(1),
    process_code character varying(40),
    lot_id character varying(40),
    apd_key_id character varying(40),
    glass_id character varying(40),
    cassette_id character varying(40),
    slot_no bigint,
    recipe_id character varying(40),
    collection_event_code character varying(40),
    rcs_mode_type_code character varying(40),
    mode_code character varying(40),
    move_in_qty double precision,
    move_out_qty double precision,
    glass_judgement_code character(1),
    main_panel_judge_info character varying(200),
    sub_panel_judge_info character varying(200),
    main_part_no_name character varying(40),
    sub_part_no_name character varying(40),
    lot_move_in_ymdhms character varying(14),
    lot_move_out_ymdhms character varying(14),
    glass_move_in_ymdhms character varying(14),
    glass_move_out_ymdhms character varying(14),
    equipment_unit_position_code character varying(10),
    creation_date timestamp without time zone,
    update_date timestamp without time zone,
    delete_flag character(1),
    machine_id character varying(40),
    eval_lot_flag character(1),
    eval_lot_assgn_user_id character varying(40),
    eval_lot_assgn_ymdhms character varying(14),
    generate_factory_code character varying(40),
    eval_lot_content character varying(4000)
) DISTRIBUTED BY (glass_id);


ALTER TABLE masdainf.tb_fda_inf_ea_apd_h OWNER TO letl;

--
-- Name: tb_fda_inf_ea_apd_pre_prcs; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_apd_pre_prcs (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    receive_ymdhms character varying(14) NOT NULL,
    apd_seq_no bigint NOT NULL,
    pre_process_code character varying(40) NOT NULL,
    product_id character varying(40),
    pre_equipment_group_id character varying(40),
    pre_receive_ymdhms character varying(14),
    pre_apd_seq_no bigint,
    pre_equipment_id character varying(40),
    pre_equipment_unit_id character varying(40),
    pre_main_path_code character varying(40),
    pre_lot_move_out_ymdhms character varying(14),
    pre_machine_id character varying(40),
    pre_recipe_id character varying(40)
) DISTRIBUTED BY (equipment_group_id ,receive_ymdhms ,apd_seq_no ,pre_process_code);


ALTER TABLE masdainf.tb_fda_inf_ea_apd_pre_prcs OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_cell_af_def_detail; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cell_af_def_detail (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    panel_inspection_end_ymdhms character varying(14) NOT NULL,
    panel_seq_no bigint NOT NULL,
    defect_seq_no bigint NOT NULL,
    detect_shop_code character varying(10) NOT NULL,
    defect_inspection_data_id character varying(40) NOT NULL,
    panel_id character varying(40),
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (panel_seq_no ,defect_seq_no ,detect_shop_code ,defect_inspection_data_id);


ALTER TABLE masdainf.tb_fda_inf_ea_def_cell_af_def_detail OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_cell_af_def_h; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cell_af_def_h (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    panel_inspection_end_ymdhms character varying(14) NOT NULL,
    panel_seq_no bigint NOT NULL,
    defect_seq_no bigint NOT NULL,
    detect_shop_code character varying(10) NOT NULL,
    process_code character varying(40),
    panel_inspection_start_ymdhms character varying(14),
    defect_valid_end_ymdhms character varying(14),
    latest_judgement_code character varying(2),
    latest_defect_large_class_code character varying(40),
    latest_reason_seq_no bigint,
    review_judgement_code character varying(2),
    review_reason_seq_no bigint,
    review_defect_large_class_code character varying(40),
    repair_judgement_code character varying(2),
    repair_reason_seq_no bigint,
    repair_defect_large_class_code character varying(40),
    update_date timestamp without time zone,
    delete_flag character(1),
    def_pnt_x double precision,
    def_pnt_y double precision,
    def_line_x double precision,
    def_line_y double precision,
    def_pnt_g double precision,
    def_pnt_d double precision,
    def_line_g double precision,
    def_line_d double precision,
    def_size double precision,
    def_active_area character varying(50),
    def_art_code character varying(50),
    def_art_site character varying(50),
    def_art_stdev character varying(50),
    def_art_volt character varying(50),
    def_masking character varying(50),
    def_md character varying(50),
    def_mode character varying(50),
    def_rank character varying(50),
    def_operator_id character varying(50),
    def_proc_id character varying(50),
    def_proc_name character varying(50),
    def_ptn_art character varying(50),
    def_ptn_code character varying(150),
    def_rep_mode character varying(50),
    def_rep_proc_id character varying(50),
    def_rep_time character varying(50),
    def_rep_unit_id character varying(50),
    def_rep_value character varying(50),
    def_rev_check character varying(50),
    def_unit_id character varying(50),
    def_rtdcvcrep_value character varying(50),
    def_vc character varying(50),
    def_ccd_no character varying(50),
    def_ap_g double precision,
    def_ap_d double precision,
    panel_id character varying(40)
) DISTRIBUTED BY (panel_seq_no ,defect_seq_no ,detect_shop_code);


ALTER TABLE masdainf.tb_fda_inf_ea_def_cell_af_def_h OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_cell_af_pnl_detail; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cell_af_pnl_detail (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    panel_inspection_end_ymdhms character varying(14) NOT NULL,
    panel_seq_no bigint NOT NULL,
    panel_inspection_data_id character varying(40) NOT NULL,
    panel_id character varying(40),
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (panel_id);


ALTER TABLE masdainf.tb_fda_inf_ea_def_cell_af_pnl_detail OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_cell_af_pnl_h; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cell_af_pnl_h (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    panel_inspection_end_ymdhms character varying(14) NOT NULL,
    panel_seq_no bigint NOT NULL,
    panel_id character varying(40),
    mmg_type_code character varying(40),
    panel_seq_code character varying(10),
    panel_position_code character varying(40),
    process_code character varying(40),
    facility_code character varying(40),
    panel_inspection_start_ymdhms character varying(14),
    group_lot_id character varying(40),
    lot_id character varying(40),
    apd_key_id character varying(40),
    equipment_group_id character varying(40),
    equipment_id character varying(40),
    machine_id character varying(40),
    equipment_unit_id character varying(40),
    part_no_name character varying(40),
    recipe_id character varying(40),
    cassette_id character varying(40),
    slot_no bigint,
    cf_panel_id character varying(40),
    inspector_id character varying(40),
    latest_judgement_code character varying(2),
    latest_defect_large_class_code character varying(40),
    latest_reason_seq_no bigint,
    latest_defect_leakage_code character varying(40),
    latest_defect_nickname_code character varying(40),
    review_judgement_code character varying(2),
    review_defect_large_class_code character varying(40),
    review_reason_seq_no bigint,
    review_defect_leakage_code character varying(40),
    review_defect_nickname_code character varying(40),
    repair_judgement_code character varying(2),
    repair_defect_large_class_code character varying(40),
    repair_reason_seq_no bigint,
    repair_defect_leakage_code character varying(40),
    repair_defect_nickname_code character varying(40),
    last_flag character(1),
    creation_date timestamp without time zone,
    update_date timestamp without time zone,
    delete_flag character(1),
    first_flag character(1),
    cs_level_value character varying(200),
    tft_input_lot_id character varying(40),
    tft_ppbox_id character varying(40),
    tft_ppbox_serial_no character varying(50),
    tft_glass_id character varying(40),
    tft_inspection_lot_id character varying(40),
    tft_finish_lot_id character varying(40),
    tft_finish_slot_no bigint,
    cf_input_lot_id character varying(40),
    cf_ppbox_id character varying(40),
    cf_ppbox_serial_no character varying(50),
    cf_glass_id character varying(40),
    cf_inspection_lot_id character varying(40),
    cf_finish_lot_id character varying(40),
    cf_finish_slot_no bigint,
    cell_input_tft_lot_id character varying(40),
    cell_input_tft_slot_no bigint,
    cell_input_tft_pnl_judge_code character(1),
    cell_input_cf_lot_id character varying(40),
    cell_input_cf_slot_no bigint,
    cell_input_cf_panel_judge_code character(1),
    matching_move_in_tft_slot_no bigint,
    matching_move_in_cf_slot_no bigint,
    matching_move_out_slot_no bigint,
    matching_move_out_lot_id character varying(40),
    cps_lot_id character varying(40),
    cps_slot_no bigint,
    cps_judgement_code character varying(40),
    grinding_lot_id character varying(40),
    grinding_slot_no bigint,
    lane_code character varying(150),
    generate_factory_code character varying(40),
    lc_level_value character varying(40),
    stick_id character varying(40),
    representative_tray_id character varying(40)
) DISTRIBUTED BY (panel_seq_no);


ALTER TABLE masdainf.tb_fda_inf_ea_def_cell_af_pnl_h OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_cell_bf_pnl_detail; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    glass_inspection_end_ymdhms character varying(14) NOT NULL,
    glass_seq_no bigint NOT NULL,
    panel_id character varying(40) NOT NULL,
    panel_inspection_data_id character varying(40) NOT NULL,
    glass_id character varying(40),
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (panel_id);


ALTER TABLE masdainf.tb_fda_inf_ea_def_cell_bf_pnl_detail OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_cf_def_detail; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cf_def_detail (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    glass_inspection_end_ymdhms character varying(14) NOT NULL,
    glass_seq_no bigint NOT NULL,
    panel_id character varying(40) NOT NULL,
    defect_seq_no bigint NOT NULL,
    defect_inspection_data_id character varying(40) NOT NULL,
    glass_id character varying(40),
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_inspection_end_ymdhms ,glass_seq_no);


ALTER TABLE masdainf.tb_fda_inf_ea_def_cf_def_detail OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_cf_def_h; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cf_def_h (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    glass_inspection_end_ymdhms character varying(14) NOT NULL,
    glass_seq_no bigint NOT NULL,
    panel_id character varying(40) NOT NULL,
    defect_seq_no bigint NOT NULL,
    glass_id character varying(40),
    process_code character varying(40),
    glass_inspection_start_ymdhms character varying(14),
    defect_valid_end_ymdhms character varying(14),
    latest_judgement_code character varying(2),
    latest_defect_large_class_code character varying(40),
    latest_reason_seq_no bigint,
    review_judgement_code character varying(2),
    review_reason_seq_no bigint,
    review_defect_large_class_code character varying(40),
    repair_judgement_code character varying(2),
    repair_reason_seq_no bigint,
    repair_defect_large_class_code character varying(40),
    update_date timestamp without time zone,
    delete_flag character(1),
    def_pnt_x double precision,
    def_pnt_y double precision,
    def_line_x double precision,
    def_line_y double precision,
    def_pnt_g double precision,
    def_pnt_d double precision,
    def_line_g double precision,
    def_line_d double precision,
    def_size double precision,
    def_active_area character varying(50),
    def_art_code character varying(50),
    def_art_site character varying(50),
    def_art_stdev character varying(50),
    def_art_volt character varying(50),
    def_masking character varying(50),
    def_md character varying(50),
    def_mode character varying(50),
    def_rank character varying(50),
    def_operator_id character varying(50),
    def_proc_id character varying(50),
    def_proc_name character varying(50),
    def_ptn_art character varying(50),
    def_ptn_code character varying(150),
    def_rep_mode character varying(50),
    def_rep_proc_id character varying(50),
    def_rep_time character varying(50),
    def_rep_unit_id character varying(50),
    def_rep_value character varying(50),
    def_rev_check character varying(50),
    def_shop character varying(50),
    def_unit_id character varying(50),
    def_rtdcvcrep_value character varying(50),
    def_vc character varying(50),
    def_ccd_no character varying(50)
) DISTRIBUTED BY (glass_seq_no);


ALTER TABLE masdainf.tb_fda_inf_ea_def_cf_def_h OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_cf_gls_detail; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cf_gls_detail (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    glass_inspection_end_ymdhms character varying(14) NOT NULL,
    glass_seq_no bigint NOT NULL,
    glass_inspection_data_id character varying(40) NOT NULL,
    glass_id character varying(40),
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_inspection_end_ymdhms ,glass_seq_no);


ALTER TABLE masdainf.tb_fda_inf_ea_def_cf_gls_detail OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_cf_pnl_detail; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cf_pnl_detail (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    glass_inspection_end_ymdhms character varying(14) NOT NULL,
    glass_seq_no bigint NOT NULL,
    panel_id character varying(40) NOT NULL,
    panel_inspection_data_id character varying(40) NOT NULL,
    glass_id character varying(40),
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_inspection_end_ymdhms ,glass_seq_no);


ALTER TABLE masdainf.tb_fda_inf_ea_def_cf_pnl_detail OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_cot_judge_reason; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cot_judge_reason (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    shop_type_code character varying(10) NOT NULL,
    glass_inspection_end_ymdhms character varying(14) NOT NULL,
    glass_seq_no bigint NOT NULL,
    panel_id character varying(40) NOT NULL,
    glass_id character varying(40),
    judgement_code character varying(2),
    defect_large_class_code character varying(40),
    reason_seq_no bigint
) DISTRIBUTED BY (glass_inspection_end_ymdhms ,glass_seq_no);


ALTER TABLE masdainf.tb_fda_inf_ea_def_cot_judge_reason OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_tft_def_detail; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_tft_def_detail (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    glass_inspection_end_ymdhms character varying(14) NOT NULL,
    glass_seq_no bigint NOT NULL,
    panel_id character varying(40) NOT NULL,
    defect_seq_no bigint NOT NULL,
    defect_inspection_data_id character varying(40) NOT NULL,
    glass_id character varying(40),
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_inspection_end_ymdhms ,glass_seq_no);


ALTER TABLE masdainf.tb_fda_inf_ea_def_tft_def_detail OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_tft_def_h; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_tft_def_h (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    glass_inspection_end_ymdhms character varying(14) NOT NULL,
    glass_seq_no bigint NOT NULL,
    panel_id character varying(40) NOT NULL,
    defect_seq_no bigint NOT NULL,
    glass_id character varying(40),
    process_code character varying(40),
    glass_inspection_start_ymdhms character varying(14),
    defect_valid_end_ymdhms character varying(14),
    latest_judgement_code character varying(2),
    latest_defect_large_class_code character varying(40),
    latest_reason_seq_no bigint,
    review_judgement_code character varying(2),
    review_reason_seq_no bigint,
    review_defect_large_class_code character varying(40),
    repair_judgement_code character varying(2),
    repair_reason_seq_no bigint,
    repair_defect_large_class_code character varying(40),
    update_date timestamp without time zone,
    delete_flag character(1),
    def_pnt_x double precision,
    def_pnt_y double precision,
    def_line_x double precision,
    def_line_y double precision,
    def_pnt_g double precision,
    def_pnt_d double precision,
    def_line_g double precision,
    def_line_d double precision,
    def_size double precision,
    def_active_area character varying(50),
    def_art_code character varying(50),
    def_art_site character varying(50),
    def_art_stdev character varying(50),
    def_art_volt character varying(50),
    def_masking character varying(50),
    def_md character varying(50),
    def_mode character varying(50),
    def_rank character varying(50),
    def_operator_id character varying(50),
    def_proc_id character varying(50),
    def_proc_name character varying(50),
    def_ptn_art character varying(50),
    def_ptn_code character varying(150),
    def_rep_mode character varying(50),
    def_rep_proc_id character varying(50),
    def_rep_time character varying(50),
    def_rep_unit_id character varying(50),
    def_rep_value character varying(50),
    def_rev_check character varying(50),
    def_shop character varying(50),
    def_unit_id character varying(50),
    def_rtdcvcrep_value character varying(50),
    def_vc character varying(50),
    def_ccd_no character varying(50)
) DISTRIBUTED BY (glass_inspection_end_ymdhms ,glass_seq_no);


ALTER TABLE masdainf.tb_fda_inf_ea_def_tft_def_h OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_tft_gls_detail; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_tft_gls_detail (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    glass_inspection_end_ymdhms character varying(14) NOT NULL,
    glass_seq_no bigint NOT NULL,
    glass_inspection_data_id character varying(40) NOT NULL,
    glass_id character varying(40),
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_inspection_end_ymdhms ,glass_seq_no);


ALTER TABLE masdainf.tb_fda_inf_ea_def_tft_gls_detail OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_tft_gls_h; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_tft_gls_h (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    glass_inspection_end_ymdhms character varying(14) NOT NULL,
    glass_seq_no bigint NOT NULL,
    glass_id character varying(40),
    process_code character varying(40),
    facility_code character varying(40),
    glass_inspection_start_ymdhms character varying(14),
    lot_id character varying(40),
    apd_key_id character varying(40),
    equipment_group_id character varying(40),
    equipment_id character varying(40),
    machine_id character varying(40),
    equipment_unit_id character varying(40),
    part_no_name character varying(40),
    sub_part_no_name character varying(40),
    recipe_id character varying(40),
    cassette_id character varying(40),
    slot_no bigint,
    inspector_id character varying(40),
    original_glass_id character varying(40),
    latest_judgement_code character varying(2),
    latest_defect_large_class_code character varying(40),
    latest_reason_seq_no bigint,
    latest_defect_leakage_code character varying(40),
    latest_defect_nickname_code character varying(40),
    review_judgement_code character varying(2),
    review_defect_large_class_code character varying(40),
    review_reason_seq_no bigint,
    review_defect_leakage_code character varying(40),
    review_defect_nickname_code character varying(40),
    repair_judgement_code character varying(2),
    repair_defect_large_class_code character varying(40),
    repair_reason_seq_no bigint,
    repair_defect_leakage_code character varying(40),
    repair_defect_nickname_code character varying(40),
    input_main_panel_qty double precision,
    input_sub_panel_qty double precision,
    last_flag character(1),
    creation_date timestamp without time zone,
    update_date timestamp without time zone,
    delete_flag character(1),
    gls_a_m_pnl_qty double precision,
    gls_a_s_pnl_qty double precision,
    gls_b_m_pnl_qty double precision,
    gls_b_s_pnl_qty double precision,
    gls_c_m_pnl_qty double precision,
    gls_c_s_pnl_qty double precision,
    gls_d_m_pnl_qty double precision,
    gls_d_s_pnl_qty double precision,
    gls_e_m_pnl_qty double precision,
    gls_e_s_pnl_qty double precision,
    gls_f_m_pnl_qty double precision,
    gls_f_s_pnl_qty double precision,
    gls_g_m_pnl_qty double precision,
    gls_g_s_pnl_qty double precision,
    gls_h_m_pnl_qty double precision,
    gls_h_s_pnl_qty double precision,
    gls_i_m_pnl_qty double precision,
    gls_i_s_pnl_qty double precision,
    gls_j_m_pnl_qty double precision,
    gls_j_s_pnl_qty double precision,
    gls_k_m_pnl_qty double precision,
    gls_k_s_pnl_qty double precision,
    gls_l_m_pnl_qty double precision,
    gls_l_s_pnl_qty double precision,
    gls_m_m_pnl_qty double precision,
    gls_m_s_pnl_qty double precision,
    gls_n_m_pnl_qty double precision,
    gls_n_s_pnl_qty double precision,
    gls_o_m_pnl_qty double precision,
    gls_o_s_pnl_qty double precision,
    gls_p_m_pnl_qty double precision,
    gls_p_s_pnl_qty double precision,
    gls_q_m_pnl_qty double precision,
    gls_q_s_pnl_qty double precision,
    gls_r_m_pnl_qty double precision,
    gls_r_s_pnl_qty double precision,
    gls_s_m_pnl_qty double precision,
    gls_s_s_pnl_qty double precision,
    gls_t_m_pnl_qty double precision,
    gls_t_s_pnl_qty double precision,
    gls_u_m_pnl_qty double precision,
    gls_u_s_pnl_qty double precision,
    gls_v_m_pnl_qty double precision,
    gls_v_s_pnl_qty double precision,
    gls_w_m_pnl_qty double precision,
    gls_w_s_pnl_qty double precision,
    gls_x_m_pnl_qty double precision,
    gls_x_s_pnl_qty double precision,
    gls_y_m_pnl_qty double precision,
    gls_y_s_pnl_qty double precision,
    gls_z_m_pnl_qty double precision,
    gls_z_s_pnl_qty double precision,
    gls_def_step_l_rb_qty double precision,
    gls_def_step_l_rw_qty double precision,
    gls_def_step_l_tb_qty double precision,
    gls_def_step_l_tw_qty double precision,
    gls_def_step_m_rb_qty double precision,
    gls_def_step_m_rw_qty double precision,
    gls_def_step_m_tb_qty double precision,
    gls_def_step_m_tw_qty double precision,
    gls_def_step_o_rb_qty double precision,
    gls_def_step_o_rw_qty double precision,
    gls_def_step_o_tb_qty double precision,
    gls_def_step_o_tw_qty double precision,
    gls_def_step_s_rb_qty double precision,
    gls_def_step_s_rw_qty double precision,
    gls_def_step_s_tb_qty double precision,
    gls_def_step_s_tw_qty double precision,
    gls_def_cum_l_rb_qty double precision,
    gls_def_cum_l_rw_qty double precision,
    gls_def_cum_l_tb_qty double precision,
    gls_def_cum_l_tw_qty double precision,
    gls_def_cum_m_rb_qty double precision,
    gls_def_cum_m_rw_qty double precision,
    gls_def_cum_m_tb_qty double precision,
    gls_def_cum_m_tw_qty double precision,
    gls_def_cum_o_rb_qty double precision,
    gls_def_cum_o_rw_qty double precision,
    gls_def_cum_o_tb_qty double precision,
    gls_def_cum_o_tw_qty double precision,
    gls_def_cum_s_rb_qty double precision,
    gls_def_cum_s_rw_qty double precision,
    gls_def_cum_s_tb_qty double precision,
    gls_def_cum_s_tw_qty double precision,
    gls_def_total_art_c_qty double precision,
    gls_def_total_cum_art_ptn_qty double precision,
    gls_def_total_art_qty double precision,
    gls_def_total_cvd_qty double precision,
    gls_def_total_prr_qty double precision,
    gls_def_total_ptn_mnt_qty double precision,
    gls_def_total_ptn_qty double precision,
    gls_def_total_rpr_qty double precision,
    gls_def_total_step_qty double precision,
    gls_def_total_cum_qty double precision,
    gls_def_total_new_qty double precision,
    gls_def_tot_inter_art_ptn_qty double precision,
    gls_def_real_inter_art_ptn_qty double precision,
    gls_def_real_cum_art_ptn_qty double precision,
    gls_def_real_art_qty double precision,
    gls_def_real_prr_qty double precision,
    gls_def_real_ptn_mnt_qty double precision,
    gls_def_real_ptn_qty double precision,
    gls_def_real_rpr_qty double precision,
    gls_def_real_step_qty double precision,
    gls_def_real_cum_qty double precision,
    gls_def_real_new_qty double precision,
    gls_rep_blow_action_m_pnl_qty double precision,
    gls_rep_blow_action_s_pnl_qty double precision,
    gls_rep_action_m_pnl_qty double precision,
    gls_rep_action_s_pnl_qty double precision,
    gls_rep_success_m_pnl_qty double precision,
    gls_rep_success_s_pnl_qty double precision,
    gls_rep_auto_cvd_m_pnt_qty double precision,
    gls_rep_auto_cvd_s_pnt_qty double precision,
    gls_rep_auto_laser_m_pnt_qty double precision,
    gls_rep_auto_laser_s_pnt_qty double precision,
    gls_rep_auto_tape_m_pnt_qty double precision,
    gls_rep_auto_tape_s_pnt_qty double precision,
    gls_rep_blow_m_pnt_qty double precision,
    gls_rep_blow_s_pnt_qty double precision,
    gls_rep_cvd_m_pnt_qty double precision,
    gls_rep_cvd_s_pnt_qty double precision,
    gls_rep_grinding_m_pnt_qty double precision,
    gls_rep_grinding_s_pnt_qty double precision,
    gls_rep_ink_m_pnt_qty double precision,
    gls_rep_ink_s_pnt_qty double precision,
    gls_rep_ink_tape_m_pnt_qty double precision,
    gls_rep_ink_tape_s_pnt_qty double precision,
    gls_rep_laser_m_pnt_qty double precision,
    gls_rep_laser_s_pnt_qty double precision,
    gls_rep_los_m_pnt_qty double precision,
    gls_rep_los_s_pnt_qty double precision,
    gls_rep_laser_ink_m_pnt_qty double precision,
    gls_rep_laser_ink_s_pnt_qty double precision,
    gls_rep_laser_tape_m_pnt_qty double precision,
    gls_rep_laser_tape_s_pnt_qty double precision,
    gls_rep_tape_m_pnt_qty double precision,
    gls_rep_tape_s_pnt_qty double precision,
    gls_rep_rep_m_pnt_qty double precision,
    gls_rep_rep_s_pnt_qty double precision,
    gls_rep_rev_m_pnt_qty double precision,
    gls_rep_rev_s_pnt_qty double precision,
    gls_rep_rpr_m_pnt_qty double precision,
    gls_rep_rpr_s_pnt_qty double precision,
    generate_factory_code character varying(40)
) DISTRIBUTED BY (glass_seq_no);


ALTER TABLE masdainf.tb_fda_inf_ea_def_tft_gls_h OWNER TO letl;

--
-- Name: tb_fda_inf_ea_def_tft_pnl_detail; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_tft_pnl_detail (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    glass_inspection_end_ymdhms character varying(14) NOT NULL,
    glass_seq_no bigint NOT NULL,
    panel_id character varying(40) NOT NULL,
    panel_inspection_data_id character varying(40) NOT NULL,
    glass_id character varying(40),
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_inspection_end_ymdhms ,glass_seq_no);


ALTER TABLE masdainf.tb_fda_inf_ea_def_tft_pnl_detail OWNER TO letl;

--
-- Name: tb_fda_inf_ea_spc_point_h; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_spc_point_h (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    facility_code character varying(40) NOT NULL,
    specification_group_id character varying(50) NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    receive_ymdhms character varying(14) NOT NULL,
    apd_seq_no bigint NOT NULL,
    calculation_item_code character varying(40) NOT NULL,
    check_rule_code character varying(10) NOT NULL,
    part_no_name character varying(40),
    measure_process_code character varying(40),
    production_equipment_id character varying(40),
    production_equipment2_id character varying(40),
    specification_register_ymdhms character varying(14),
    point_value double precision,
    spec_out_flag character(1),
    spec_out_grade_code character varying(10),
    trouble_alert_id character varying(40),
    mismeasure_count double precision,
    creation_date timestamp without time zone,
    pre_process_code character varying(40),
    pre_equipment_group_id character varying(40),
    pre_equipment_id character varying(40),
    pre_main_path_code character varying(40),
    action_user_id character varying(40),
    action_ymdhms character varying(14),
    action_content character varying(1000)
) DISTRIBUTED BY (facility_code ,specification_group_id ,equipment_group_id ,receive_ymdhms ,apd_seq_no ,calculation_item_code ,check_rule_code);


ALTER TABLE masdainf.tb_fda_inf_ea_spc_point_h OWNER TO letl;

--
-- Name: tb_fda_inf_mg_mod_insp_defect_h; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_mg_mod_insp_defect_h (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    inspection_aggregate_date date NOT NULL,
    inspection_occur_date date NOT NULL,
    inspection_time_id character varying(2) NOT NULL,
    module_factory_code character varying(40) NOT NULL,
    panel_id character varying(40) NOT NULL,
    defect_timekey character varying(40) NOT NULL,
    src_etl_insert_upd_timestamp timestamp without time zone,
    shift_code character(1),
    event_name character varying(40),
    event_occur_timestamp timestamp without time zone,
    departure_module_factory_code character varying(40),
    panel_factory_code character varying(40),
    zone_code character varying(40),
    tab_zone_input_line_code character varying(10),
    assembly_zone_input_line_code character varying(10),
    inspection_line_code character varying(10),
    inspection_process_code character varying(40),
    insp_module_equipment_surid integer,
    pol_module_equipment_surid integer,
    bl_module_equipment_surid integer,
    tab_zone_input_model_surid integer,
    assy_zn_input_model_surid integer,
    model_surid integer,
    base_model_code character varying(30),
    part_no_surid integer,
    lane_code character varying(150),
    grade_code character varying(40),
    work_crew_code character varying(40),
    work_unit_code character varying(40),
    inspection_worker_surid integer,
    vendorship_company_id character varying(40),
    work_order_no character varying(30),
    panel_pallet_id character varying(40),
    defect_detect_pattern_name character varying(40),
    cancel_timekey character varying(40),
    cancel_flag character(1),
    again_defect_flag character(1),
    re_input_flag character(1),
    self_seq_defect_flag character(1),
    production_type_code character varying(40),
    pixel_vcom_adjust_value double precision,
    pixel_vcom_adjust_drop_value double precision,
    inspection_full_reason_code character varying(250),
    reason_type_code character varying(40),
    inspection_quality_level1_code character varying(40),
    inspection_quality_level2_code character varying(40),
    inspection_quality_level3_code character varying(150),
    input_grade_code character varying(40),
    grade_pre_detect_code character varying(10),
    inspection_date_time_id character varying(10),
    route_type_code character varying(40),
    original_insp_full_reason_code character varying(250),
    base_timestamp timestamp without time zone,
    input_line_type_code character varying(40),
    grade_pre_detect_flag character(1),
    input_line_code character varying(10),
    back_light_input_timestamp timestamp without time zone,
    bl_input_aggregate_date date,
    back_light_input_occur_date date,
    back_light_input_time_id character varying(2)
) DISTRIBUTED BY (inspection_aggregate_date ,inspection_occur_date ,inspection_time_id ,module_factory_code ,panel_id ,defect_timekey);


ALTER TABLE masdainf.tb_fda_inf_mg_mod_insp_defect_h OWNER TO letl;

--
-- Name: tb_fda_inf_mg_mod_prod_process_h; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_mg_mod_prod_process_h (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    result_aggregate_date date NOT NULL,
    result_occur_date date NOT NULL,
    result_time_id character varying(2) NOT NULL,
    module_factory_code character varying(40) NOT NULL,
    panel_id character varying(40) NOT NULL,
    process_timekey character varying(40) NOT NULL,
    src_etl_insert_upd_timestamp timestamp without time zone,
    shift_code character(1) NOT NULL,
    event_name character varying(40),
    event_occur_timestamp timestamp without time zone,
    departure_module_factory_code character varying(40) NOT NULL,
    panel_factory_code character varying(40) NOT NULL,
    zone_code character varying(40) NOT NULL,
    tab_zone_input_line_code character varying(10) NOT NULL,
    assembly_zone_input_line_code character varying(10) NOT NULL,
    line_code character varying(10) NOT NULL,
    process_code character varying(40) NOT NULL,
    next_process_code character varying(40),
    pol_module_equipment_surid integer NOT NULL,
    module_equipment_surid integer NOT NULL,
    bl_module_equipment_surid integer NOT NULL,
    tab_zone_input_model_surid integer NOT NULL,
    assy_zn_input_model_surid integer NOT NULL,
    pre_model_surid integer NOT NULL,
    model_surid integer NOT NULL,
    base_model_code character varying(30),
    part_no_surid integer,
    lane_code character varying(150),
    input_grade_code character varying(40) NOT NULL,
    grade_code character varying(40) NOT NULL,
    work_crew_code character varying(40) NOT NULL,
    work_unit_code character varying(40) NOT NULL,
    worker_surid integer,
    vendorship_company_id character varying(40),
    customer_id character varying(40) NOT NULL,
    re_input_type_code character varying(10),
    re_input_flag character(1),
    process_first_input_flag character(1) NOT NULL,
    again_defect_flag character(1),
    rework_count double precision,
    route_type_code character varying(40),
    production_type_code character varying(40) NOT NULL,
    work_order_no character varying(30),
    tab_zone_work_order_no character varying(30),
    assembly_zone_work_order_no character varying(30),
    panel_pallet_id character varying(40),
    box_id character varying(40),
    pallet_id character varying(40),
    qa_lot_id character varying(40),
    product_serial_no character varying(40),
    cancel_timekey character varying(40),
    cancel_flag character(1),
    pre_event_occur_timestamp timestamp without time zone,
    pixel_vcom_adjust_value double precision,
    pixel_vcom_adjust_drop_value double precision,
    erp_model_code character varying(40),
    result_date_time_id character varying(10),
    production_equipment_surid integer,
    base_timestamp timestamp without time zone,
    input_line_type_code character varying(40),
    warehouse_stock_flag character(1),
    semi_finished_goods_box_id character varying(40),
    top_model_code character varying(40),
    ink_lot_no character varying(40),
    arrival_module_factory_code character varying(40),
    tab_zone_input_part_no_surid integer,
    sale_change_flag character(1),
    route_id character varying(40)
) DISTRIBUTED BY (panel_id);


ALTER TABLE masdainf.tb_fda_inf_mg_mod_prod_process_h OWNER TO letl;

--
-- Name: tb_fda_inf_op_cmd_list_h_i; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_op_cmd_list_h_i (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    eai_seq_id bigint NOT NULL,
    command_seq_no bigint NOT NULL,
    cassette_id character varying(40),
    cassette_type_code character varying(40),
    lot_id character varying(40),
    use_count double precision,
    process_code character varying(40),
    from_equipment_id character varying(40),
    from_port_id character varying(40),
    to_equipment_id character varying(40),
    to_port_id character varying(40),
    priority_no bigint,
    command_status_code character(1),
    transport_type_code character varying(40),
    transport_class_code character(1),
    transport_code character varying(40),
    response_code character varying(40),
    user_id character varying(40),
    creation_date timestamp without time zone,
    completion_date timestamp without time zone,
    request_seq_no bigint,
    reserve_flag character(1),
    reserve_date timestamp without time zone,
    last_lot_event_name character varying(40),
    last_lot_event_timekey character varying(40),
    cancel_user_id character varying(40),
    cancel_date timestamp without time zone,
    glass_handling_mode_code character varying(40),
    facility_code character varying(40),
    rule_name character varying(40),
    error_detail_no bigint,
    data_interface_type_code character(1),
    data_interface_date timestamp without time zone,
    eai_transfer_flag character(1),
    eai_transfer_date timestamp without time zone,
    etl_transfer_date timestamp without time zone,
    etl_transfer_flag character(1),
    anal_system_etl_transfer_flag character(1),
    anal_system_etl_transfer_date timestamp without time zone
) DISTRIBUTED BY (eai_seq_id ,command_seq_no);


ALTER TABLE masdainf.tb_fda_inf_op_cmd_list_h_i OWNER TO letl;

--
-- Name: tb_fda_inf_op_lot_history_p_i; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_op_lot_history_p_i (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    eai_seq_id bigint NOT NULL,
    lotname character varying(40) NOT NULL,
    timekey character varying(40) NOT NULL,
    eventtime timestamp without time zone,
    eventname character varying(40),
    productiontype character varying(40),
    oldproductiontype character varying(40),
    oldproductspecname character varying(40),
    productspecname character varying(40),
    oldproductspecversion character varying(40),
    productspecversion character varying(40),
    oldproductspec2name character varying(40),
    productspec2name character varying(40),
    oldproductspec2version character varying(40),
    productspec2version character varying(40),
    processgroupname character varying(40),
    productrequestname character varying(40),
    originallotname character varying(40),
    sourcelotname character varying(40),
    destinationlotname character varying(40),
    rootlotname character varying(40),
    parentlotname character varying(40),
    carriername character varying(40),
    subproductunitquantity1 bigint,
    subproductunitquantity2 bigint,
    oldproductquantity bigint,
    productquantity double precision,
    oldsubproductquantity bigint,
    subproductquantity bigint,
    oldsubproductquantity1 bigint,
    subproductquantity1 double precision,
    oldsubproductquantity2 bigint,
    subproductquantity2 double precision,
    lotgrade character varying(40),
    duedate timestamp without time zone,
    priority bigint,
    oldfactoryname character varying(40),
    factoryname character varying(40),
    olddestinationfactoryname character varying(40),
    destinationfactoryname character varying(40),
    oldareaname character varying(40),
    areaname character varying(40),
    lotstate character varying(40),
    lotprocessstate character varying(40),
    lotholdstate character varying(40),
    eventuser character varying(40),
    eventcomment character varying(600),
    eventflag character varying(40),
    lastloggedintime timestamp without time zone,
    lastloggedinuser character varying(40),
    lastloggedouttime timestamp without time zone,
    lastloggedoutuser character varying(40),
    reasoncodetype character varying(40),
    reasoncode character varying(40),
    oldprocessflowname character varying(40),
    processflowname character varying(40),
    oldprocessflowversion character varying(40),
    processflowversion character varying(40),
    oldprocessoperationname character varying(40),
    processoperationname character varying(40),
    oldprocessoperationversion character varying(40),
    processoperationversion character varying(40),
    nodestack character varying(400),
    machinename character varying(40),
    machinerecipename character varying(40),
    reworkstate character varying(40),
    reworkcount bigint,
    reworknodeid character varying(40),
    consumerlotname character varying(40),
    consumertimekey character varying(40),
    consumedlotname character varying(40),
    consumeddurablename character varying(40),
    consumedconsumablename character varying(40),
    systemtime timestamp without time zone,
    cancelflag character varying(40),
    canceltimekey character varying(40),
    ap_equipment_id character varying(40),
    collection_event_id character varying(40),
    cell_lot_id character varying(40),
    dummy_type_code character varying(40),
    edge_type_code character varying(40),
    equipment_mode_code character varying(40),
    shop_internal_shipping_flag character(1),
    hold_code character varying(40),
    ics_info character varying(40),
    lane_code character varying(150),
    lot_flag_info character varying(400),
    lot_type_code character varying(40),
    lot_type_conversion_code character varying(40),
    matching_lot_id character varying(40),
    mismatch_info character varying(40),
    mode_code character varying(40),
    glass_handling_flag character(1),
    glass_handling_mode_code character varying(40),
    optimal_sorting_end_flag character(1),
    optimal_sorting_lock_flag character(1),
    optimal_sorting_id character varying(40),
    pair_info character varying(40),
    special_code character varying(40),
    port_id character varying(40),
    return_flag character(1),
    rework_code character varying(40),
    sampling_qty double precision,
    sputter_target_value character varying(40),
    sub_panel_per_glass1_qty double precision,
    sub_panel1_qty double precision,
    sub_panel2_qty double precision,
    sub_panel_per_glass2_qty double precision,
    thickness_info character varying(40),
    shipping_factory_code character varying(40),
    move_out_restrict_ymdhms character varying(14),
    lot_photo_equipment_info character varying(400),
    model_name character varying(40),
    generating_location_code character varying(40),
    usage_code character varying(40),
    detail_usage_code character varying(40),
    split_seq_no character varying(5),
    old_rework_state_code character varying(40),
    interlock_check_process_code character varying(40),
    old_sub_panel1_qty double precision,
    old_sub_panel2_qty double precision,
    ap_move_out_ymdhms character varying(14),
    inventory_type_code character varying(30),
    rework_seq_no character varying(5),
    apd_key_id character varying(40),
    lot_count_info character varying(400),
    optimal_additional_seq_no bigint,
    data_interface_type_code character(1),
    data_interface_date timestamp without time zone,
    eai_transfer_flag character(1),
    eai_transfer_date timestamp without time zone,
    etl_transfer_flag character(1),
    etl_transfer_date timestamp without time zone,
    producttype character varying(40),
    oldproducttype character varying(40),
    subproducttype character varying(40),
    oldsubproducttype character varying(40),
    interest_user_id character varying(40),
    interest_content character varying(600),
    generate_factory_code character varying(40),
    next_priority numeric(22,0),
    factory_code character varying(40),
    facility_code character varying(40),
    hold_release_ymdhms character varying(14),
    hold_worker_id character varying(40),
    slps_code character varying(10),
    anal_system_etl_transfer_flag character(1),
    anal_system_etl_transfer_date timestamp without time zone
) DISTRIBUTED BY (eai_seq_id ,lotname ,timekey);


ALTER TABLE masdainf.tb_fda_inf_op_lot_history_p_i OWNER TO letl;

--
-- Name: tb_fda_inf_op_product_history_p_i; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_op_product_history_p_i (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    eai_seq_id bigint NOT NULL,
    productname character varying(40) NOT NULL,
    timekey character varying(40) NOT NULL,
    eventtime timestamp without time zone,
    eventname character varying(40),
    oldproductiontype character varying(40),
    productiontype character varying(40),
    oldproductspecname character varying(40),
    productspecname character varying(40),
    oldproductspecversion character varying(40),
    productspecversion character varying(40),
    oldproductspec2name character varying(40),
    productspec2name character varying(40),
    oldproductspec2version character varying(40),
    productspec2version character varying(40),
    materiallocationname character varying(40),
    processgroupname character varying(40),
    transportgroupname character varying(40),
    productrequestname character varying(40),
    originalproductname character varying(40),
    sourceproductname character varying(40),
    destinationproductname character varying(40),
    oldlotname character varying(40),
    lotname character varying(40),
    carriername character varying(40),
    "position" bigint,
    subproductunitquantity1 bigint,
    subproductunitquantity2 bigint,
    oldsubproductquantity bigint,
    subproductquantity bigint,
    oldsubproductquantity1 bigint,
    subproductquantity1 bigint,
    oldsubproductquantity2 bigint,
    subproductquantity2 bigint,
    productgrade character varying(40),
    subproductgrades1 character varying(200),
    subproductgrades2 character varying(200),
    duedate timestamp without time zone,
    priority bigint,
    oldfactoryname character varying(40),
    factoryname character varying(40),
    olddestinationfactoryname character varying(40),
    destinationfactoryname character varying(40),
    oldareaname character varying(40),
    areaname character varying(40),
    serialno character varying(40),
    productstate character varying(40),
    productprocessstate character varying(40),
    productholdstate character varying(40),
    eventuser character varying(40),
    eventcomment character varying(600),
    eventflag character varying(40),
    lastprocessingtime timestamp without time zone,
    lastprocessinguser character varying(40),
    lastidletime timestamp without time zone,
    lastidleuser character varying(40),
    reasoncodetype character varying(40),
    reasoncode character varying(40),
    oldprocessflowname character varying(40),
    processflowname character varying(40),
    oldprocessflowversion character varying(40),
    processflowversion character varying(40),
    oldprocessoperationname character varying(40),
    processoperationname character varying(40),
    oldprocessoperationversion character varying(40),
    processoperationversion character varying(40),
    nodestack character varying(400),
    machinename character varying(40),
    machinerecipename character varying(40),
    reworkstate character varying(40),
    reworkcount double precision,
    reworknodeid character varying(40),
    consumerlotname character varying(40),
    consumerproductname character varying(40),
    consumertimekey character varying(40),
    consumedproductname character varying(40),
    consumeddurablename character varying(40),
    consumedconsumablename character varying(40),
    systemtime timestamp without time zone,
    cancelflag character varying(40),
    canceltimekey character varying(40),
    aging_flag character(1),
    ap_inspector_id character varying(40),
    cf_glass_id character varying(40),
    cf_glass_maker_name character varying(40),
    finish_ymdhms character varying(14),
    copy_mask_id character varying(40),
    cps_judgement_code character varying(40),
    shop_internal_shipping_flag character(1),
    glass_count_info character varying(400),
    glass_equipment_info character varying(400),
    glass_flag_info character varying(400),
    glass_type_conversion_code character varying(40),
    lot_timekey character varying(40),
    lane_code character varying(150),
    laser_repair_flag character(1),
    main_glass_type_code character varying(40),
    sub_glass_type_code character varying(40),
    main_lc_level_info character varying(600),
    sub_lc_level_info character varying(600),
    matching_slot_no bigint,
    pair_info character varying(40),
    photo_mask1_code character varying(40),
    photo_mask2_code character varying(40),
    ppbox_id character varying(40),
    ppbox_serial_no character varying(50),
    recipe_id character varying(40),
    pre_glass_judgement_code character varying(40),
    aligner_recipe_id character varying(40),
    rework_code character varying(40),
    sampling_code character varying(40),
    sputter_target_value character varying(40),
    thickness_info character varying(40),
    sub_panel1_qty double precision,
    sub_panel2_qty double precision,
    mmg_work_order_id character varying(40),
    glass_photo_equipment_info character varying(400),
    unit_equipment_id character varying(40),
    apd_key_id character varying(40),
    pre_lane_code character varying(150),
    pre_work_order_id character varying(40),
    pre_mmg_work_order_id character varying(40),
    work_order_id character varying(40),
    move_out_restrict_ymdhms character varying(14),
    gls_hndl_pre_status_code character varying(40),
    gls_hndl_pre_prcs_code character varying(40),
    cs_level_value character varying(200),
    data_interface_type_code character(1),
    data_interface_date timestamp without time zone,
    eai_transfer_flag character(1),
    eai_transfer_date timestamp without time zone,
    etl_transfer_flag character(1),
    etl_transfer_date timestamp without time zone,
    producttype character varying(40),
    oldproducttype character varying(40),
    subproducttype character varying(40),
    oldsubproducttype character varying(40),
    group_lot_id character varying(40),
    glass_specific_data_info character varying(400),
    old_sub_panel1_qty double precision,
    old_sub_panel2_qty double precision,
    factory_code character varying(40),
    facility_code character varying(40),
    slps_code character varying(10),
    old_slps_code character varying(10),
    anal_system_etl_transfer_flag character(1),
    anal_system_etl_transfer_date timestamp without time zone
) DISTRIBUTED BY (eai_seq_id ,productname ,timekey);


ALTER TABLE masdainf.tb_fda_inf_op_product_history_p_i OWNER TO letl;

--
-- Name: tb_fda_inf_op_run_note; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_op_run_note (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    eai_seq_id bigint NOT NULL,
    factory_code character varying(40),
    lot_id character varying(40) NOT NULL,
    facility_code character varying(40) NOT NULL,
    route_id character varying(40) NOT NULL,
    process_code character varying(40) NOT NULL,
    run_note_content character varying(4000),
    user_id character varying(40),
    update_date timestamp without time zone,
    full_cassette_load_flag character varying(1),
    full_cst_load_flag_user_id character varying(40),
    material_id character varying(40),
    progress_spec character varying(1000),
    delete_flag character varying(1),
    data_interface_date timestamp without time zone,
    data_interface_type_code character(1),
    eai_transfer_flag character(1),
    eai_transfer_date timestamp without time zone
) DISTRIBUTED BY (eai_seq_id);


ALTER TABLE masdainf.tb_fda_inf_op_run_note OWNER TO letl;

--
-- Name: tb_fda_inf_op_transport_event_h_i; Type: TABLE; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_inf_op_transport_event_h_i (
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    eai_seq_id bigint NOT NULL,
    event_seq_no bigint NOT NULL,
    equipment_id character varying(40),
    port_id character varying(40),
    shelf_id character varying(40),
    cassette_id character varying(40),
    cassette_type_code character varying(40),
    lot_id character varying(40),
    process_code character varying(40),
    use_count double precision,
    final_destination_equipment_id character varying(40),
    final_destination_port_id character varying(40),
    event_name character varying(40),
    event_type_code character varying(40),
    transport_end_code character(1),
    command_seq_no bigint,
    transport_code character varying(40),
    creation_date timestamp without time zone,
    facility_code character varying(40),
    conveyor_id character varying(40),
    alternate_transport_flag character(1),
    alternate_storage_partition_id character varying(40),
    data_interface_type_code character(1),
    data_interface_date timestamp without time zone,
    eai_transfer_flag character(1),
    eai_transfer_date timestamp without time zone,
    etl_transfer_flag character(1),
    etl_transfer_date timestamp without time zone,
    anal_system_etl_transfer_flag character(1),
    anal_system_etl_transfer_date timestamp without time zone
) DISTRIBUTED BY (eai_seq_id ,event_seq_no);


ALTER TABLE masdainf.tb_fda_inf_op_transport_event_h_i OWNER TO letl;

SET search_path = masdapdm, pg_catalog;

--
-- Name: tb_fda_pdm_product_equip_h; Type: TABLE; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_equip_h (
    product_id character varying(40) NOT NULL,
    facility_code character varying(40) NOT NULL,
    process_code character varying(50) NOT NULL,
    move_in_timestamp timestamp without time zone NOT NULL,
    equipment_id character varying(40) NOT NULL,
    receive_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    original_glass_id character varying(40),
    original_product_id character varying(40),
    product_type_code character varying(10),
    factory_code character varying(40),
    equipment_group_id character varying(40) NOT NULL,
    apd_seq_no integer NOT NULL,
    apd_data_id character varying(40),
    equipment_hierarchy_type_code character varying(40),
    equipment_line_id character varying(40),
    equipment_machine_id character varying(40),
    equipment_unit_id character varying(40),
    equipment_path_id character varying(40),
    delete_flag character(1)
) DISTRIBUTED BY (product_id);


ALTER TABLE masdapdm.tb_fda_pdm_product_equip_h OWNER TO letl;

--
-- Name: tb_fda_pdm_product_m; Type: TABLE; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_m (
    product_id character varying(40) NOT NULL,
    generate_factory_code character varying(40) NOT NULL,
    first_event_occur_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    product_type_code character varying(10),
    final_event_occur_timestamp timestamp without time zone,
    final_factory_code character varying(40),
    sub_factory_code character varying(40),
    first_facility_code character varying(40),
    final_facility_code character varying(40),
    first_part_no_name character varying(40),
    first_sub_part_no_name character varying(40),
    final_part_no_name character varying(40),
    final_sub_part_no_name character varying(40),
    original_glass_id character varying(40),
    original_product_id character varying(40),
    input_lot_id character varying(40),
    ppbox_id character varying(40),
    ppbox_serial_no character varying(50),
    inspection_lot_id character varying(40),
    finish_lot_id character varying(40),
    finish_slot_no integer,
    cell_input_lot_id character varying(40),
    cell_input_slot_no integer,
    matching_move_in_slot_no integer,
    tft_glass_id character varying(40),
    cf_glass_id character varying(40),
    mmg_type_code character varying(40),
    panel_seq_code character varying(10),
    panel_position_code character varying(40),
    cf_panel_id character varying(40),
    cell_input_tft_pnl_judge_code character(1),
    cell_input_cf_panel_judge_code character(1),
    matching_move_out_lot_id character varying(40),
    matching_move_out_slot_no integer,
    cps_lot_id character varying(40),
    cps_slot_no integer,
    cps_judgement_code character varying(40),
    grinding_lot_id character varying(40),
    grinding_slot_no integer,
    cs_level_value character varying(200),
    lc_level_value character varying(40),
    stick_id character varying(40),
    representative_tray_id character varying(40),
    lane_code character varying(150),
    finish_timestamp timestamp without time zone
) DISTRIBUTED BY (product_id);


ALTER TABLE masdapdm.tb_fda_pdm_product_m OWNER TO letl;

--
-- Name: tb_fda_pdm_product_prog_insp_h; Type: TABLE; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_prog_insp_h (
    progress_product_id character varying(40) NOT NULL,
    progress_facility_code character varying(40) NOT NULL,
    progress_process_code character varying(40) NOT NULL,
    progress_move_in_timestamp timestamp without time zone NOT NULL,
    inspection_product_id character varying(40) NOT NULL,
    inspection_product_seq_no integer NOT NULL,
    inspection_end_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    original_glass_id character varying(40),
    original_product_id character varying(40),
    progress_product_type_code character varying(10),
    progress_factory_code character varying(40),
    progress_part_no_name character varying(40),
    progress_delete_flag character(1),
    inspection_product_type_code character varying(10),
    inspection_factory_code character varying(40),
    inspection_facility_code character varying(40),
    inspection_process_code character varying(40),
    inspection_process_first_flag character(1),
    inspection_process_final_flag character(1),
    inspection_facility_final_flag character(1),
    inspection_delete_flag character(1),
    progress_move_in_lot_id character varying(40),
    progress_process_first_flag character(1),
    progress_process_final_flag character(1),
    generate_factory_code character varying(40)
) DISTRIBUTED BY (progress_product_id) PARTITION BY RANGE(progress_move_in_timestamp)
          SUBPARTITION BY LIST(progress_facility_code) 
          (
          START ('2012-11-18 00:00:00'::timestamp without time zone) END ('2012-12-02 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_2', appendonly=false ) 
                  (
                  SUBPARTITION p1t VALUES('P1T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_2_2_prt_p1t', appendonly=false ), 
                  SUBPARTITION p2t VALUES('P2T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_2_2_prt_p2t', appendonly=false ), 
                  SUBPARTITION p8t VALUES('P8T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_2_2_prt_p8t', appendonly=false ), 
                  SUBPARTITION p8c VALUES('P8C') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_2_2_prt_p8c', appendonly=false ), 
                  SUBPARTITION p8f VALUES('P8F') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_2_2_prt_p8f', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_2_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-02 00:00:00'::timestamp without time zone) END ('2012-12-16 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_3', appendonly=false ) 
                  (
                  SUBPARTITION p1t VALUES('P1T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_3_2_prt_p1t', appendonly=false ), 
                  SUBPARTITION p2t VALUES('P2T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_3_2_prt_p2t', appendonly=false ), 
                  SUBPARTITION p8t VALUES('P8T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_3_2_prt_p8t', appendonly=false ), 
                  SUBPARTITION p8c VALUES('P8C') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_3_2_prt_p8c', appendonly=false ), 
                  SUBPARTITION p8f VALUES('P8F') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_3_2_prt_p8f', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_3_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-16 00:00:00'::timestamp without time zone) END ('2012-12-30 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_4', appendonly=false ) 
                  (
                  SUBPARTITION p1t VALUES('P1T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_4_2_prt_p1t', appendonly=false ), 
                  SUBPARTITION p2t VALUES('P2T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_4_2_prt_p2t', appendonly=false ), 
                  SUBPARTITION p8t VALUES('P8T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_4_2_prt_p8t', appendonly=false ), 
                  SUBPARTITION p8c VALUES('P8C') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_4_2_prt_p8c', appendonly=false ), 
                  SUBPARTITION p8f VALUES('P8F') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_4_2_prt_p8f', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_4_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-30 00:00:00'::timestamp without time zone) END ('2013-01-13 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_5', appendonly=false ) 
                  (
                  SUBPARTITION p1t VALUES('P1T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_5_2_prt_p1t', appendonly=false ), 
                  SUBPARTITION p2t VALUES('P2T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_5_2_prt_p2t', appendonly=false ), 
                  SUBPARTITION p8t VALUES('P8T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_5_2_prt_p8t', appendonly=false ), 
                  SUBPARTITION p8c VALUES('P8C') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_5_2_prt_p8c', appendonly=false ), 
                  SUBPARTITION p8f VALUES('P8F') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_5_2_prt_p8f', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_5_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-13 00:00:00'::timestamp without time zone) END ('2013-01-27 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_6', appendonly=false ) 
                  (
                  SUBPARTITION p1t VALUES('P1T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_6_2_prt_p1t', appendonly=false ), 
                  SUBPARTITION p2t VALUES('P2T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_6_2_prt_p2t', appendonly=false ), 
                  SUBPARTITION p8t VALUES('P8T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_6_2_prt_p8t', appendonly=false ), 
                  SUBPARTITION p8c VALUES('P8C') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_6_2_prt_p8c', appendonly=false ), 
                  SUBPARTITION p8f VALUES('P8F') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_6_2_prt_p8f', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_6_2_prt_pdefault', appendonly=false )
                  ), 
          DEFAULT PARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_pdefault', appendonly=false ) 
                  (
                  SUBPARTITION p1t VALUES('P1T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_pdefault_2_prt_p1t', appendonly=false ), 
                  SUBPARTITION p2t VALUES('P2T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_pdefault_2_prt_p2t', appendonly=false ), 
                  SUBPARTITION p8t VALUES('P8T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_pdefault_2_prt_p8t', appendonly=false ), 
                  SUBPARTITION p8c VALUES('P8C') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_pdefault_2_prt_p8c', appendonly=false ), 
                  SUBPARTITION p8f VALUES('P8F') WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_pdefault_2_prt_p8f', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h_1_prt_pdefault_2_prt_pdefault', appendonly=false )
                  )
          );
 ALTER TABLE tb_fda_pdm_product_prog_insp_h 
SET SUBPARTITION TEMPLATE  
          (
          SUBPARTITION p1t VALUES('P1T') WITH (tablename='tb_fda_pdm_product_prog_insp_h'), 
          SUBPARTITION p2t VALUES('P2T') WITH (tablename='tb_fda_pdm_product_prog_insp_h'), 
          SUBPARTITION p8t VALUES('P8T') WITH (tablename='tb_fda_pdm_product_prog_insp_h'), 
          SUBPARTITION p8c VALUES('P8C') WITH (tablename='tb_fda_pdm_product_prog_insp_h'), 
          SUBPARTITION p8f VALUES('P8F') WITH (tablename='tb_fda_pdm_product_prog_insp_h'), 
          DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h')
          )
;


ALTER TABLE masdapdm.tb_fda_pdm_product_prog_insp_h OWNER TO letl;

--
-- Name: nv_fda_pdm_product_prog_equip_insp_h; Type: VIEW; Schema: masdapdm; Owner: letl
--

CREATE VIEW nv_fda_pdm_product_prog_equip_insp_h AS
    SELECT i.progress_product_id, i.progress_facility_code, i.progress_process_code, i.progress_move_in_timestamp, e.equipment_id AS progress_equipment_id, e.receive_timestamp AS progress_receive_timestamp, i.inspection_product_id, i.inspection_product_seq_no, i.inspection_end_timestamp, i.original_glass_id, i.original_product_id, i.progress_product_type_code, i.progress_factory_code, i.progress_part_no_name, e.equipment_group_id AS progress_equipment_group_id, e.apd_seq_no AS progress_apd_seq_no, e.apd_data_id AS progress_apd_data_id, e.equipment_hierarchy_type_code AS progress_equip_hier_type_code, e.equipment_line_id AS progress_equipment_line_id, e.equipment_machine_id AS progress_equipment_machine_id, e.equipment_unit_id AS progress_equipment_unit_id, e.equipment_path_id AS progress_equipment_path_id, i.progress_delete_flag, i.inspection_product_type_code, i.inspection_factory_code, i.inspection_facility_code, i.inspection_process_code, i.inspection_process_first_flag, i.inspection_process_final_flag, i.inspection_facility_final_flag, i.inspection_delete_flag, i.progress_move_in_lot_id, i.progress_process_first_flag, i.progress_process_final_flag, p.finish_timestamp FROM ((tb_fda_pdm_product_prog_insp_h i JOIN tb_fda_pdm_product_equip_h e ON (((((((e.product_id)::text = (i.progress_product_id)::text) AND ((e.facility_code)::text = (i.progress_facility_code)::text)) AND ((e.process_code)::text = (i.progress_process_code)::text)) AND (e.move_in_timestamp = i.progress_move_in_timestamp)) AND (e.delete_flag IS NULL)))) JOIN tb_fda_pdm_product_m p ON ((((p.product_id)::text = (i.progress_product_id)::text) AND ((p.generate_factory_code)::text = (i.generate_factory_code)::text)))) WHERE ((i.progress_delete_flag IS NULL) AND (i.inspection_delete_flag IS NULL));


ALTER TABLE masdapdm.nv_fda_pdm_product_prog_equip_insp_h OWNER TO letl;

--
-- Name: tb_fda_pdm_product_equip_h_b2; Type: TABLE; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_equip_h_b2 (
    product_id character varying(40) NOT NULL,
    facility_code character varying(40) NOT NULL,
    process_code character varying(50) NOT NULL,
    move_in_timestamp timestamp without time zone NOT NULL,
    equipment_id character varying(40) NOT NULL,
    receive_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    original_glass_id character varying(40),
    original_product_id character varying(40),
    product_type_code character varying(10),
    factory_code character varying(40),
    equipment_group_id character varying(40) NOT NULL,
    apd_seq_no integer NOT NULL,
    apd_data_id character varying(40),
    equipment_hierarchy_type_code character varying(40),
    equipment_line_id character varying(40),
    equipment_machine_id character varying(40),
    equipment_unit_id character varying(40),
    equipment_path_id character varying(40),
    delete_flag character(1)
) DISTRIBUTED BY (product_id) PARTITION BY RANGE(move_in_timestamp) 
          (
          START ('2012-11-18 00:00:00'::timestamp without time zone) END ('2012-12-02 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_equip_h_b2_1_prt_2', appendonly=false ), 
          START ('2012-12-02 00:00:00'::timestamp without time zone) END ('2012-12-16 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_equip_h_b2_1_prt_3', appendonly=false ), 
          START ('2012-12-16 00:00:00'::timestamp without time zone) END ('2012-12-30 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_equip_h_b2_1_prt_4', appendonly=false ), 
          START ('2012-12-30 00:00:00'::timestamp without time zone) END ('2013-01-13 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_equip_h_b2_1_prt_5', appendonly=false ), 
          START ('2013-01-13 00:00:00'::timestamp without time zone) END ('2013-01-27 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_equip_h_b2_1_prt_6', appendonly=false ), 
          DEFAULT PARTITION pdefault  WITH (tablename='tb_fda_pdm_product_equip_h_b2_1_prt_pdefault', appendonly=false )
          );


ALTER TABLE masdapdm.tb_fda_pdm_product_equip_h_b2 OWNER TO letl;

--
-- Name: nv_fda_pdm_product_prog_equip_insp_h_b; Type: VIEW; Schema: masdapdm; Owner: letl
--

CREATE VIEW nv_fda_pdm_product_prog_equip_insp_h_b AS
    SELECT i.progress_product_id, i.progress_facility_code, i.progress_process_code, i.progress_move_in_timestamp, e.equipment_id AS progress_equipment_id, e.receive_timestamp AS progress_receive_timestamp, i.inspection_product_id, i.inspection_product_seq_no, i.inspection_end_timestamp, i.original_glass_id, i.original_product_id, i.progress_product_type_code, i.progress_factory_code, i.progress_part_no_name, e.equipment_group_id AS progress_equipment_group_id, e.apd_seq_no AS progress_apd_seq_no, e.apd_data_id AS progress_apd_data_id, e.equipment_hierarchy_type_code AS progress_equip_hier_type_code, e.equipment_line_id AS progress_equipment_line_id, e.equipment_machine_id AS progress_equipment_machine_id, e.equipment_unit_id AS progress_equipment_unit_id, e.equipment_path_id AS progress_equipment_path_id, i.progress_delete_flag, i.inspection_product_type_code, i.inspection_factory_code, i.inspection_facility_code, i.inspection_process_code, i.inspection_process_first_flag, i.inspection_process_final_flag, i.inspection_facility_final_flag, i.inspection_delete_flag, i.progress_move_in_lot_id, i.progress_process_first_flag, i.progress_process_final_flag, p.finish_timestamp FROM ((tb_fda_pdm_product_prog_insp_h i JOIN tb_fda_pdm_product_equip_h_b2 e ON (((((((e.product_id)::text = (i.progress_product_id)::text) AND ((e.facility_code)::text = (i.progress_facility_code)::text)) AND ((e.process_code)::text = (i.progress_process_code)::text)) AND (e.move_in_timestamp = i.progress_move_in_timestamp)) AND (e.delete_flag IS NULL)))) JOIN tb_fda_pdm_product_m p ON ((((p.product_id)::text = (i.progress_product_id)::text) AND ((p.generate_factory_code)::text = (i.generate_factory_code)::text)))) WHERE ((i.progress_delete_flag IS NULL) AND (i.inspection_delete_flag IS NULL));


ALTER TABLE masdapdm.nv_fda_pdm_product_prog_equip_insp_h_b OWNER TO letl;

--
-- Name: tb_fda_pdm_product_h_s; Type: TABLE; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_h_s (
    product_id character varying(40) NOT NULL,
    facility_code character varying(40) NOT NULL,
    process_code character varying(50) NOT NULL,
    move_in_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    generate_factory_code character varying(40),
    factory_code character varying(40),
    move_out_timestamp timestamp without time zone,
    move_in_equipment_id character varying(40),
    move_out_equipment_id character varying(40),
    move_in_lot_id character varying(40),
    move_out_lot_id character varying(40),
    move_in_port_id character varying(40),
    move_out_port_id character varying(40),
    move_in_cassette_id character varying(40),
    move_out_cassette_id character varying(40),
    move_in_slot_no integer,
    move_out_slot_no integer,
    part_no_name character varying(40),
    sub_part_no_name character varying(40),
    glass_judgement_code character(1),
    main_panel_judge_info character varying(200),
    sub_panel_judge_info character varying(200),
    original_glass_id character varying(40),
    original_product_id character varying(40),
    ppbox_id character varying(40),
    ppbox_serial_no character varying(50),
    matching_lot_id character varying(40),
    matching_cf_glass_id character varying(40),
    matching_slot_no integer,
    lane_code character varying(150),
    rework_code character varying(40),
    rework_count double precision,
    final_flag character(1),
    product_type_code character varying(10),
    main_lc_level_desc character varying(1000),
    sub_lc_level_desc character varying(1000),
    cps_judgement_code character varying(40),
    sampling_info character varying(40),
    pre_rework_process_code character varying(40),
    move_in_move_out_same_flag character(1),
    delete_flag character(1),
    process_first_flag character(1),
    process_final_flag character(1),
    glass_handling_flag character(1)
) DISTRIBUTED BY (product_id);


ALTER TABLE masdapdm.tb_fda_pdm_product_h_s OWNER TO letl;

--
-- Name: tb_fda_pdm_product_h_s_t; Type: TABLE; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_h_s_t (
    product_id character varying(40) NOT NULL,
    facility_code character varying(40) NOT NULL,
    process_code character varying(50) NOT NULL,
    move_in_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    generate_factory_code character varying(40),
    factory_code character varying(40),
    move_out_timestamp timestamp without time zone,
    move_in_equipment_id character varying(40),
    move_out_equipment_id character varying(40),
    move_in_lot_id character varying(40),
    move_out_lot_id character varying(40),
    move_in_port_id character varying(40),
    move_out_port_id character varying(40),
    move_in_cassette_id character varying(40),
    move_out_cassette_id character varying(40),
    move_in_slot_no integer,
    move_out_slot_no integer,
    part_no_name character varying(40),
    sub_part_no_name character varying(40),
    glass_judgement_code character(1),
    main_panel_judge_info character varying(200),
    sub_panel_judge_info character varying(200),
    original_glass_id character varying(40),
    original_product_id character varying(40),
    ppbox_id character varying(40),
    ppbox_serial_no character varying(50),
    matching_lot_id character varying(40),
    matching_cf_glass_id character varying(40),
    matching_slot_no integer,
    lane_code character varying(150),
    rework_code character varying(40),
    rework_count double precision,
    final_flag character(1),
    product_type_code character varying(10),
    main_lc_level_desc character varying(1000),
    sub_lc_level_desc character varying(1000),
    cps_judgement_code character varying(40),
    sampling_info character varying(40),
    pre_rework_process_code character varying(40),
    move_in_move_out_same_flag character(1),
    delete_flag character(1),
    process_first_flag character(1),
    process_final_flag character(1),
    glass_handling_flag character(1)
) DISTRIBUTED BY (product_id);


ALTER TABLE masdapdm.tb_fda_pdm_product_h_s_t OWNER TO letl;

--
-- Name: tb_fda_pdm_product_h_s_t2; Type: TABLE; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_h_s_t2 (
    product_id character varying(40),
    facility_code character varying(40),
    process_code character varying(50),
    move_in_timestamp timestamp without time zone
) DISTRIBUTED BY (product_id);


ALTER TABLE masdapdm.tb_fda_pdm_product_h_s_t2 OWNER TO letl;

--
-- Name: tb_fda_pdm_product_m_t1; Type: TABLE; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_m_t1 (
    product_id character varying(40) NOT NULL,
    generate_factory_code character varying(40) NOT NULL,
    first_event_occur_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    product_type_code character varying(10),
    final_event_occur_timestamp timestamp without time zone,
    final_factory_code character varying(40),
    sub_factory_code character varying(40),
    first_facility_code character varying(40),
    final_facility_code character varying(40),
    first_part_no_name character varying(40),
    first_sub_part_no_name character varying(40),
    final_part_no_name character varying(40),
    final_sub_part_no_name character varying(40),
    original_glass_id character varying(40),
    original_product_id character varying(40),
    input_lot_id character varying(40),
    ppbox_id character varying(40),
    ppbox_serial_no character varying(50),
    inspection_lot_id character varying(40),
    finish_lot_id character varying(40),
    finish_slot_no integer,
    cell_input_lot_id character varying(40),
    cell_input_slot_no integer,
    matching_move_in_slot_no integer,
    tft_glass_id character varying(40),
    cf_glass_id character varying(40),
    mmg_type_code character varying(40),
    panel_seq_code character varying(10),
    panel_position_code character varying(40),
    cf_panel_id character varying(40),
    cell_input_tft_pnl_judge_code character(1),
    cell_input_cf_panel_judge_code character(1),
    matching_move_out_lot_id character varying(40),
    matching_move_out_slot_no integer,
    cps_lot_id character varying(40),
    cps_slot_no integer,
    cps_judgement_code character varying(40),
    grinding_lot_id character varying(40),
    grinding_slot_no integer,
    cs_level_value character varying(200),
    lc_level_value character varying(40),
    stick_id character varying(40),
    representative_tray_id character varying(40),
    lane_code character varying(150),
    finish_timestamp timestamp without time zone
) DISTRIBUTED BY (product_id);


ALTER TABLE masdapdm.tb_fda_pdm_product_m_t1 OWNER TO letl;

--
-- Name: tb_fda_pdm_product_m_t2; Type: TABLE; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_m_t2 (
    product_id character varying(40) NOT NULL,
    generate_factory_code character varying(40) NOT NULL,
    first_event_occur_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    product_type_code character varying(10),
    final_event_occur_timestamp timestamp without time zone,
    final_factory_code character varying(40),
    sub_factory_code character varying(40),
    first_facility_code character varying(40),
    final_facility_code character varying(40),
    first_part_no_name character varying(40),
    first_sub_part_no_name character varying(40),
    final_part_no_name character varying(40),
    final_sub_part_no_name character varying(40),
    original_glass_id character varying(40),
    original_product_id character varying(40),
    input_lot_id character varying(40),
    ppbox_id character varying(40),
    ppbox_serial_no character varying(50),
    inspection_lot_id character varying(40),
    finish_lot_id character varying(40),
    finish_slot_no integer,
    cell_input_lot_id character varying(40),
    cell_input_slot_no integer,
    matching_move_in_slot_no integer,
    tft_glass_id character varying(40),
    cf_glass_id character varying(40),
    mmg_type_code character varying(40),
    panel_seq_code character varying(10),
    panel_position_code character varying(40),
    cf_panel_id character varying(40),
    cell_input_tft_pnl_judge_code character(1),
    cell_input_cf_panel_judge_code character(1),
    matching_move_out_lot_id character varying(40),
    matching_move_out_slot_no integer,
    cps_lot_id character varying(40),
    cps_slot_no integer,
    cps_judgement_code character varying(40),
    grinding_lot_id character varying(40),
    grinding_slot_no integer,
    cs_level_value character varying(200),
    lc_level_value character varying(40),
    stick_id character varying(40),
    representative_tray_id character varying(40),
    lane_code character varying(150),
    finish_timestamp timestamp without time zone
) DISTRIBUTED BY (product_id);


ALTER TABLE masdapdm.tb_fda_pdm_product_m_t2 OWNER TO letl;

--
-- Name: tb_fda_pdm_product_prog_insp_h_b; Type: TABLE; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_prog_insp_h_b (
    progress_product_id character varying(40) NOT NULL,
    progress_facility_code character varying(40) NOT NULL,
    progress_process_code character varying(40) NOT NULL,
    progress_move_in_timestamp timestamp without time zone NOT NULL,
    inspection_product_id character varying(40) NOT NULL,
    inspection_product_seq_no integer NOT NULL,
    inspection_end_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    original_glass_id character varying(40),
    original_product_id character varying(40),
    progress_product_type_code character varying(10),
    progress_factory_code character varying(40),
    progress_part_no_name character varying(40),
    progress_delete_flag character(1),
    inspection_product_type_code character varying(10),
    inspection_factory_code character varying(40),
    inspection_facility_code character varying(40),
    inspection_process_code character varying(40),
    inspection_process_first_flag character(1),
    inspection_process_final_flag character(1),
    inspection_facility_final_flag character(1),
    inspection_delete_flag character(1),
    progress_move_in_lot_id character varying(40),
    progress_process_first_flag character(1),
    progress_process_final_flag character(1),
    generate_factory_code character varying(40)
) DISTRIBUTED BY (inspection_product_id) PARTITION BY RANGE(progress_move_in_timestamp)
          SUBPARTITION BY LIST(progress_facility_code) 
          (
          START ('2012-11-18 00:00:00'::timestamp without time zone) END ('2012-12-02 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_2', appendonly=false ) 
                  (
                  SUBPARTITION p1t VALUES('P1T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_2_2_prt_p1t', appendonly=false ), 
                  SUBPARTITION p2t VALUES('P2T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_2_2_prt_p2t', appendonly=false ), 
                  SUBPARTITION p8t VALUES('P8T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_2_2_prt_p8t', appendonly=false ), 
                  SUBPARTITION p8c VALUES('P8C') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_2_2_prt_p8c', appendonly=false ), 
                  SUBPARTITION p8f VALUES('P8F') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_2_2_prt_p8f', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_2_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-02 00:00:00'::timestamp without time zone) END ('2012-12-16 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_3', appendonly=false ) 
                  (
                  SUBPARTITION p1t VALUES('P1T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_3_2_prt_p1t', appendonly=false ), 
                  SUBPARTITION p2t VALUES('P2T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_3_2_prt_p2t', appendonly=false ), 
                  SUBPARTITION p8t VALUES('P8T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_3_2_prt_p8t', appendonly=false ), 
                  SUBPARTITION p8c VALUES('P8C') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_3_2_prt_p8c', appendonly=false ), 
                  SUBPARTITION p8f VALUES('P8F') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_3_2_prt_p8f', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_3_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-16 00:00:00'::timestamp without time zone) END ('2012-12-30 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_4', appendonly=false ) 
                  (
                  SUBPARTITION p1t VALUES('P1T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_4_2_prt_p1t', appendonly=false ), 
                  SUBPARTITION p2t VALUES('P2T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_4_2_prt_p2t', appendonly=false ), 
                  SUBPARTITION p8t VALUES('P8T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_4_2_prt_p8t', appendonly=false ), 
                  SUBPARTITION p8c VALUES('P8C') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_4_2_prt_p8c', appendonly=false ), 
                  SUBPARTITION p8f VALUES('P8F') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_4_2_prt_p8f', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_4_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-30 00:00:00'::timestamp without time zone) END ('2013-01-13 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_5', appendonly=false ) 
                  (
                  SUBPARTITION p1t VALUES('P1T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_5_2_prt_p1t', appendonly=false ), 
                  SUBPARTITION p2t VALUES('P2T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_5_2_prt_p2t', appendonly=false ), 
                  SUBPARTITION p8t VALUES('P8T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_5_2_prt_p8t', appendonly=false ), 
                  SUBPARTITION p8c VALUES('P8C') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_5_2_prt_p8c', appendonly=false ), 
                  SUBPARTITION p8f VALUES('P8F') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_5_2_prt_p8f', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_5_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-13 00:00:00'::timestamp without time zone) END ('2013-01-27 00:00:00'::timestamp without time zone) EVERY ('14 days'::interval) WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_6', appendonly=false ) 
                  (
                  SUBPARTITION p1t VALUES('P1T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_6_2_prt_p1t', appendonly=false ), 
                  SUBPARTITION p2t VALUES('P2T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_6_2_prt_p2t', appendonly=false ), 
                  SUBPARTITION p8t VALUES('P8T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_6_2_prt_p8t', appendonly=false ), 
                  SUBPARTITION p8c VALUES('P8C') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_6_2_prt_p8c', appendonly=false ), 
                  SUBPARTITION p8f VALUES('P8F') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_6_2_prt_p8f', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_6_2_prt_pdefault', appendonly=false )
                  ), 
          DEFAULT PARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_pdefault', appendonly=false ) 
                  (
                  SUBPARTITION p1t VALUES('P1T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_pdefault_2_prt_p1t', appendonly=false ), 
                  SUBPARTITION p2t VALUES('P2T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_pdefault_2_prt_p2t', appendonly=false ), 
                  SUBPARTITION p8t VALUES('P8T') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_pdefault_2_prt_p8t', appendonly=false ), 
                  SUBPARTITION p8c VALUES('P8C') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_pdefault_2_prt_p8c', appendonly=false ), 
                  SUBPARTITION p8f VALUES('P8F') WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_pdefault_2_prt_p8f', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdm_product_prog_insp_h_b_1_prt_pdefault_2_prt_pdefault', appendonly=false )
                  )
          );


ALTER TABLE masdapdm.tb_fda_pdm_product_prog_insp_h_b OWNER TO letl;

--
-- Name: tb_fda_pdm_product_prog_insp_h_bk; Type: TABLE; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_prog_insp_h_bk (
    progress_product_id character varying(40) NOT NULL,
    progress_facility_code character varying(40) NOT NULL,
    progress_process_code character varying(40) NOT NULL,
    progress_move_in_timestamp timestamp without time zone NOT NULL,
    inspection_product_id character varying(40) NOT NULL,
    inspection_product_seq_no integer NOT NULL,
    inspection_end_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    original_glass_id character varying(40),
    original_product_id character varying(40),
    progress_product_type_code character varying(10),
    progress_factory_code character varying(40),
    progress_part_no_name character varying(40),
    progress_delete_flag character(1),
    inspection_product_type_code character varying(10),
    inspection_factory_code character varying(40),
    inspection_facility_code character varying(40),
    inspection_process_code character varying(40),
    inspection_process_first_flag character(1),
    inspection_process_final_flag character(1),
    inspection_facility_final_flag character(1),
    inspection_delete_flag character(1),
    progress_move_in_lot_id character varying(40),
    progress_process_first_flag character(1),
    progress_process_final_flag character(1),
    generate_factory_code character varying(40)
) DISTRIBUTED BY (progress_product_id);


ALTER TABLE masdapdm.tb_fda_pdm_product_prog_insp_h_bk OWNER TO letl;

--
-- Name: tb_fda_pdm_product_prog_insp_h_t1; Type: TABLE; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_prog_insp_h_t1 (
    progress_product_id character varying(40) NOT NULL,
    progress_facility_code character varying(40) NOT NULL,
    progress_process_code character varying(40) NOT NULL,
    progress_move_in_timestamp timestamp without time zone NOT NULL,
    inspection_product_id character varying(40) NOT NULL,
    inspection_product_seq_no integer NOT NULL,
    inspection_end_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    original_glass_id character varying(40),
    original_product_id character varying(40),
    progress_product_type_code character varying(10),
    progress_factory_code character varying(40),
    progress_part_no_name character varying(40),
    progress_delete_flag character(1),
    inspection_product_type_code character varying(10),
    inspection_factory_code character varying(40),
    inspection_facility_code character varying(40),
    inspection_process_code character varying(40),
    inspection_process_first_flag character(1),
    inspection_process_final_flag character(1),
    inspection_facility_final_flag character(1),
    inspection_delete_flag character(1),
    progress_move_in_lot_id character varying(40),
    progress_process_first_flag character(1),
    progress_process_final_flag character(1),
    generate_factory_code character varying(40)
) DISTRIBUTED BY (progress_product_id);


ALTER TABLE masdapdm.tb_fda_pdm_product_prog_insp_h_t1 OWNER TO letl;

--
-- Name: tb_fda_pdm_product_prog_insp_h_t2; Type: TABLE; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_prog_insp_h_t2 (
    progress_product_id character varying(40) NOT NULL,
    progress_facility_code character varying(40) NOT NULL,
    progress_process_code character varying(40) NOT NULL,
    progress_move_in_timestamp timestamp without time zone NOT NULL,
    inspection_product_id character varying(40) NOT NULL,
    inspection_product_seq_no integer NOT NULL,
    inspection_end_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    original_glass_id character varying(40),
    original_product_id character varying(40),
    progress_product_type_code character varying(10),
    progress_factory_code character varying(40),
    progress_part_no_name character varying(40),
    progress_delete_flag character(1),
    inspection_product_type_code character varying(10),
    inspection_factory_code character varying(40),
    inspection_facility_code character varying(40),
    inspection_process_code character varying(40),
    inspection_process_first_flag character(1),
    inspection_process_final_flag character(1),
    inspection_facility_final_flag character(1),
    inspection_delete_flag character(1),
    progress_move_in_lot_id character varying(40),
    progress_process_first_flag character(1),
    progress_process_final_flag character(1),
    generate_factory_code character varying(40)
) DISTRIBUTED BY (progress_product_id);


ALTER TABLE masdapdm.tb_fda_pdm_product_prog_insp_h_t2 OWNER TO letl;

--
-- Name: tb_fda_pdm_product_prog_insp_h_t3; Type: TABLE; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_prog_insp_h_t3 (
    progress_product_id character varying(40) NOT NULL,
    progress_facility_code character varying(40) NOT NULL,
    progress_process_code character varying(40) NOT NULL,
    progress_move_in_timestamp timestamp without time zone NOT NULL,
    inspection_product_id character varying(40) NOT NULL,
    inspection_product_seq_no integer NOT NULL,
    inspection_end_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    original_glass_id character varying(40),
    original_product_id character varying(40),
    progress_product_type_code character varying(10),
    progress_factory_code character varying(40),
    progress_part_no_name character varying(40),
    progress_delete_flag character(1),
    inspection_product_type_code character varying(10),
    inspection_factory_code character varying(40),
    inspection_facility_code character varying(40),
    inspection_process_code character varying(40),
    inspection_process_first_flag character(1),
    inspection_process_final_flag character(1),
    inspection_facility_final_flag character(1),
    inspection_delete_flag character(1),
    progress_move_in_lot_id character varying(40),
    progress_process_first_flag character(1),
    progress_process_final_flag character(1),
    generate_factory_code character varying(40)
) DISTRIBUTED BY (progress_product_id);


ALTER TABLE masdapdm.tb_fda_pdm_product_prog_insp_h_t3 OWNER TO letl;

SET search_path = masdapdw, pg_catalog;

--
-- Name: tb_fda_pdw_apd_detail; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_apd_detail (
    product_id character varying(40) NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    apd_seq_no integer NOT NULL,
    receive_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    apd_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    apd_data_group_id character varying(40),
    apd_collection_code character(1),
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (product_id) PARTITION BY LIST(factory_code) 
          (
          PARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p1', appendonly=false ), 
          PARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p2', appendonly=false ), 
          PARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p8', appendonly=false ), 
          DEFAULT PARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_1_prt_pdefault', appendonly=false )
          );


ALTER TABLE masdapdw.tb_fda_pdw_apd_detail OWNER TO letl;

--
-- Name: tb_fda_pdw_apd_detail_bk; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_apd_detail_bk (
    product_id character varying(40) NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    apd_seq_no integer NOT NULL,
    receive_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    apd_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    apd_data_group_id character varying(40),
    apd_collection_code character(1),
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (product_id) PARTITION BY RANGE(receive_timestamp)
          SUBPARTITION BY LIST(factory_code) 
          (
          START ('2012-11-18 00:00:00'::timestamp without time zone) END ('2012-11-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_2', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_2_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_2_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_2_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_2_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-19 00:00:00'::timestamp without time zone) END ('2012-11-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_3', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_3_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_3_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_3_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_3_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-20 00:00:00'::timestamp without time zone) END ('2012-11-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_4', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_4_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_4_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_4_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_4_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-21 00:00:00'::timestamp without time zone) END ('2012-11-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_5', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_5_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_5_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_5_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_5_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-22 00:00:00'::timestamp without time zone) END ('2012-11-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_6', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_6_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_6_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_6_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_6_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-23 00:00:00'::timestamp without time zone) END ('2012-11-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_7', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_7_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_7_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_7_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_7_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-24 00:00:00'::timestamp without time zone) END ('2012-11-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_8', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_8_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_8_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_8_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_8_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-25 00:00:00'::timestamp without time zone) END ('2012-11-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_9', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_9_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_9_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_9_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_9_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-26 00:00:00'::timestamp without time zone) END ('2012-11-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_10', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_10_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_10_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_10_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_10_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-27 00:00:00'::timestamp without time zone) END ('2012-11-28 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_11', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_11_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_11_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_11_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_11_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-28 00:00:00'::timestamp without time zone) END ('2012-11-29 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_12', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_12_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_12_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_12_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_12_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-29 00:00:00'::timestamp without time zone) END ('2012-11-30 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_13', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_13_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_13_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_13_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_13_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-30 00:00:00'::timestamp without time zone) END ('2012-12-01 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_14', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_14_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_14_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_14_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_14_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-01 00:00:00'::timestamp without time zone) END ('2012-12-02 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_15', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_15_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_15_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_15_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_15_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-02 00:00:00'::timestamp without time zone) END ('2012-12-03 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_16', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_16_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_16_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_16_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_16_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-03 00:00:00'::timestamp without time zone) END ('2012-12-04 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_17', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_17_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_17_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_17_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_17_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-04 00:00:00'::timestamp without time zone) END ('2012-12-05 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_18', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_18_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_18_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_18_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_18_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-05 00:00:00'::timestamp without time zone) END ('2012-12-06 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_19', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_19_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_19_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_19_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_19_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-06 00:00:00'::timestamp without time zone) END ('2012-12-07 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_20', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_20_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_20_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_20_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_20_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-07 00:00:00'::timestamp without time zone) END ('2012-12-08 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_21', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_21_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_21_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_21_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_21_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-08 00:00:00'::timestamp without time zone) END ('2012-12-09 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_22', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_22_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_22_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_22_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_22_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-09 00:00:00'::timestamp without time zone) END ('2012-12-10 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_23', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_23_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_23_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_23_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_23_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-10 00:00:00'::timestamp without time zone) END ('2012-12-11 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_24', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_24_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_24_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_24_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_24_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-11 00:00:00'::timestamp without time zone) END ('2012-12-12 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_25', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_25_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_25_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_25_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_25_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-12 00:00:00'::timestamp without time zone) END ('2012-12-13 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_26', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_26_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_26_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_26_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_26_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-13 00:00:00'::timestamp without time zone) END ('2012-12-14 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_27', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_27_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_27_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_27_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_27_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-14 00:00:00'::timestamp without time zone) END ('2012-12-15 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_28', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_28_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_28_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_28_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_28_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-15 00:00:00'::timestamp without time zone) END ('2012-12-16 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_29', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_29_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_29_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_29_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_29_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-16 00:00:00'::timestamp without time zone) END ('2012-12-17 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_30', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_30_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_30_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_30_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_30_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-17 00:00:00'::timestamp without time zone) END ('2012-12-18 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_31', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_31_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_31_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_31_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_31_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-18 00:00:00'::timestamp without time zone) END ('2012-12-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_32', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_32_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_32_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_32_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_32_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-19 00:00:00'::timestamp without time zone) END ('2012-12-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_33', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_33_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_33_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_33_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_33_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-20 00:00:00'::timestamp without time zone) END ('2012-12-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_34', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_34_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_34_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_34_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_34_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-21 00:00:00'::timestamp without time zone) END ('2012-12-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_35', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_35_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_35_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_35_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_35_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-22 00:00:00'::timestamp without time zone) END ('2012-12-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_36', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_36_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_36_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_36_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_36_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-23 00:00:00'::timestamp without time zone) END ('2012-12-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_37', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_37_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_37_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_37_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_37_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-24 00:00:00'::timestamp without time zone) END ('2012-12-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_38', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_38_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_38_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_38_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_38_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-25 00:00:00'::timestamp without time zone) END ('2012-12-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_39', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_39_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_39_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_39_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_39_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-26 00:00:00'::timestamp without time zone) END ('2012-12-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_40', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_40_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_40_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_40_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_40_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-27 00:00:00'::timestamp without time zone) END ('2012-12-28 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_41', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_41_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_41_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_41_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_41_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-28 00:00:00'::timestamp without time zone) END ('2012-12-29 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_42', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_42_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_42_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_42_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_42_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-29 00:00:00'::timestamp without time zone) END ('2012-12-30 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_43', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_43_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_43_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_43_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_43_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-30 00:00:00'::timestamp without time zone) END ('2012-12-31 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_44', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_44_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_44_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_44_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_44_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-31 00:00:00'::timestamp without time zone) END ('2013-01-01 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_45', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_45_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_45_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_45_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_45_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-01 00:00:00'::timestamp without time zone) END ('2013-01-02 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_46', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_46_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_46_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_46_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_46_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-02 00:00:00'::timestamp without time zone) END ('2013-01-03 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_47', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_47_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_47_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_47_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_47_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-03 00:00:00'::timestamp without time zone) END ('2013-01-04 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_48', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_48_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_48_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_48_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_48_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-04 00:00:00'::timestamp without time zone) END ('2013-01-05 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_49', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_49_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_49_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_49_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_49_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-05 00:00:00'::timestamp without time zone) END ('2013-01-06 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_50', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_50_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_50_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_50_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_50_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-06 00:00:00'::timestamp without time zone) END ('2013-01-07 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_51', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_51_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_51_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_51_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_51_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-07 00:00:00'::timestamp without time zone) END ('2013-01-08 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_52', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_52_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_52_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_52_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_52_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-08 00:00:00'::timestamp without time zone) END ('2013-01-09 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_53', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_53_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_53_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_53_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_53_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-09 00:00:00'::timestamp without time zone) END ('2013-01-10 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_54', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_54_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_54_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_54_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_54_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-10 00:00:00'::timestamp without time zone) END ('2013-01-11 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_55', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_55_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_55_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_55_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_55_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-11 00:00:00'::timestamp without time zone) END ('2013-01-12 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_56', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_56_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_56_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_56_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_56_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-12 00:00:00'::timestamp without time zone) END ('2013-01-13 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_57', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_57_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_57_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_57_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_57_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-13 00:00:00'::timestamp without time zone) END ('2013-01-14 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_58', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_58_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_58_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_58_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_58_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-14 00:00:00'::timestamp without time zone) END ('2013-01-15 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_59', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_59_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_59_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_59_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_59_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-15 00:00:00'::timestamp without time zone) END ('2013-01-16 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_60', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_60_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_60_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_60_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_60_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-16 00:00:00'::timestamp without time zone) END ('2013-01-17 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_61', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_61_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_61_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_61_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_61_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-17 00:00:00'::timestamp without time zone) END ('2013-01-18 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_62', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_62_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_62_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_62_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_62_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-18 00:00:00'::timestamp without time zone) END ('2013-01-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_63', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_63_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_63_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_63_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_63_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-19 00:00:00'::timestamp without time zone) END ('2013-01-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_64', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_64_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_64_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_64_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_64_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-20 00:00:00'::timestamp without time zone) END ('2013-01-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_65', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_65_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_65_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_65_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_65_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-21 00:00:00'::timestamp without time zone) END ('2013-01-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_66', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_66_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_66_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_66_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_66_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-22 00:00:00'::timestamp without time zone) END ('2013-01-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_67', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_67_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_67_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_67_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_67_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-23 00:00:00'::timestamp without time zone) END ('2013-01-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_68', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_68_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_68_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_68_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_68_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-24 00:00:00'::timestamp without time zone) END ('2013-01-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_69', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_69_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_69_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_69_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_69_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-25 00:00:00'::timestamp without time zone) END ('2013-01-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_70', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_70_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_70_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_70_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_70_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-26 00:00:00'::timestamp without time zone) END ('2013-01-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_71', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_71_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_71_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_71_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_71_2_prt_pdefault', appendonly=false )
                  ), 
          DEFAULT PARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_pdefault', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_pdefault_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_pdefault_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_pdefault_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk_1_prt_pdefault_2_prt_pdefault', appendonly=false )
                  )
          );
 ALTER TABLE tb_fda_pdw_apd_detail_bk 
SET SUBPARTITION TEMPLATE  
          (
          SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_apd_detail_bk'), 
          SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_apd_detail_bk'), 
          SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_bk'), 
          DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_apd_detail_bk')
          )
;


ALTER TABLE masdapdw.tb_fda_pdw_apd_detail_bk OWNER TO letl;

--
-- Name: tb_fda_pdw_apd_detail_t; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_apd_detail_t (
    product_id character varying(40) NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    apd_seq_no integer NOT NULL,
    receive_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    apd_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    apd_data_group_id character varying(40),
    apd_collection_code character(1),
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (product_id);


ALTER TABLE masdapdw.tb_fda_pdw_apd_detail_t OWNER TO letl;

--
-- Name: tb_fda_pdw_apd_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_apd_h (
    product_id character varying(40) NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    apd_seq_no integer NOT NULL,
    receive_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    facility_code character varying(40),
    equipment_id character varying(40),
    equipment_hierarchy_type_code character varying(40),
    equipment_line_id character varying(40),
    equipment_machine_id character varying(40),
    equipment_unit_id character varying(40),
    apd_collection_code character(1),
    process_code character varying(50),
    lot_id character varying(40),
    apd_key_id character varying(40),
    cassette_id character varying(40),
    slot_no integer,
    recipe_id character varying(40),
    collection_event_code character varying(40),
    rcs_mode_type_code character varying(40),
    mode_code character varying(40),
    move_in_qty double precision,
    move_out_qty double precision,
    glass_judgement_code character(1),
    main_panel_judge_info character varying(200),
    sub_panel_judge_info character varying(200),
    main_part_no_name character varying(40),
    sub_part_no_name character varying(40),
    lot_move_in_ymdhms character varying(14),
    lot_move_out_ymdhms character varying(14),
    glass_move_in_ymdhms character varying(14),
    glass_move_out_ymdhms character varying(14),
    equipment_unit_position_code character varying(10),
    creation_timestamp timestamp without time zone,
    update_timestamp timestamp without time zone,
    delete_flag character(1),
    eval_lot_flag character(1),
    eval_lot_assgn_user_id character varying(40),
    evaluation_lot_assgn_timestamp timestamp without time zone,
    generate_factory_code character varying(40),
    evaluation_lot_content character varying(4000)
) DISTRIBUTED BY (product_id);


ALTER TABLE masdapdw.tb_fda_pdw_apd_h OWNER TO letl;

--
-- Name: tb_fda_pdw_apd_pre_prcs; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_apd_pre_prcs (
    product_id character varying(40) NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    apd_seq_no integer NOT NULL,
    receive_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    pre_process_code character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    pre_equipment_group_id character varying(40),
    pre_receive_timestamp timestamp without time zone,
    pre_apd_seq_no integer,
    pre_equipment_id character varying(40),
    pre_equipment_unit_id character varying(40),
    pre_main_path_code character varying(40),
    pre_lot_move_out_timestamp timestamp without time zone,
    pre_machine_id character varying(40),
    previous_recipe_id character varying(40)
) DISTRIBUTED BY (product_id);


ALTER TABLE masdapdw.tb_fda_pdw_apd_pre_prcs OWNER TO letl;

--
-- Name: tb_fda_pdw_ememo_file; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_ememo_file (
    facility_code character varying(40) NOT NULL,
    ememo_id character varying(200) NOT NULL,
    ememo_file_name character varying(200) NOT NULL,
    file_register_location_info character varying(200) NOT NULL,
    creation_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    eai_seq_id bigint,
    factory_code character varying(40),
    file_register_url_info character varying(200),
    data_interface_type_code character(1)
) DISTRIBUTED BY (facility_code ,ememo_id);


ALTER TABLE masdapdw.tb_fda_pdw_ememo_file OWNER TO letl;

--
-- Name: tb_fda_pdw_ememo_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_ememo_h (
    facility_code character varying(40) NOT NULL,
    ememo_id character varying(200) NOT NULL,
    creation_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    eai_seq_id bigint NOT NULL,
    factory_code character varying(40),
    register_timestamp timestamp without time zone,
    effective_start_date date,
    effective_end_date date,
    title_name character varying(250),
    memo_comment character varying(600),
    memo_desc character varying(1000),
    print_department_code character varying(40),
    print_user_name character varying(40),
    register_user_id character varying(40),
    end_flag character(1),
    apply_flag character(1),
    first_lot_apply_ymdhms character varying(14),
    apply_process_code character varying(40),
    apply_equipment_id character varying(40),
    document_type_code character varying(10),
    cell_location_code character varying(40),
    process_code_list character varying(4000),
    apply_user_name character varying(40),
    keyword_text character varying(256),
    scrap_ymdhms character varying(14),
    scrap_user_id character varying(40),
    data_interface_type_code character(1)
) DISTRIBUTED BY (facility_code ,ememo_id);


ALTER TABLE masdapdw.tb_fda_pdw_ememo_h OWNER TO letl;

--
-- Name: tb_fda_pdw_ememo_lot; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_ememo_lot (
    facility_code character varying(40) NOT NULL,
    ememo_id character varying(200) NOT NULL,
    lot_id character varying(40) NOT NULL,
    creation_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    eai_seq_id bigint NOT NULL,
    data_interface_type_code character(1)
) DISTRIBUTED BY (lot_id);


ALTER TABLE masdapdw.tb_fda_pdw_ememo_lot OWNER TO letl;

--
-- Name: tb_fda_pdw_equip_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_equip_h (
    factory_code character varying(40) NOT NULL,
    equipment_id character varying(40) NOT NULL,
    timekey_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    equipment_status_code character varying(40),
    equipment_event_code character varying(40),
    event_occur_timestamp timestamp without time zone,
    event_occur_user_id character varying(30),
    run_chamber_number double precision,
    equipment_state_name character varying(40),
    pre_equipment_status_code character varying(40),
    equipment_state_chg_timestamp timestamp without time zone,
    data_interface_type_code character(1)
) DISTRIBUTED BY (equipment_id) PARTITION BY LIST(factory_code) 
          (
          PARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_equip_h_1_prt_p1', appendonly=false ), 
          PARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_equip_h_1_prt_p2', appendonly=false ), 
          PARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_equip_h_1_prt_p8', appendonly=false ), 
          DEFAULT PARTITION pdefault  WITH (tablename='tb_fda_pdw_equip_h_1_prt_pdefault', appendonly=false )
          );


ALTER TABLE masdapdw.tb_fda_pdw_equip_h OWNER TO letl;

--
-- Name: tb_fda_pdw_equip_work_order_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_equip_work_order_h (
    factory_code character varying(40) NOT NULL,
    equipment_id character varying(40) NOT NULL,
    equipment_state_occr_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    etl_seq_id integer NOT NULL,
    data_interface_type_code character(1),
    data_interface_timestamp timestamp without time zone,
    etl_transfer_timestamp timestamp without time zone,
    etl_transfer_flag character(1),
    wip_entity_id bigint,
    wip_entity_name character varying(240),
    work_order_desc character varying(240),
    work_order_type character varying(30),
    instance_number character varying(30),
    actual_start_timestamp timestamp without time zone,
    actual_end_timestamp timestamp without time zone,
    equipment_state_end_timestamp timestamp without time zone,
    error_code character varying(40),
    error_desc character varying(400),
    error_reason_desc character varying(256),
    failure_code character varying(60),
    failure_code_desc character varying(100),
    cause_code character varying(60),
    cause_code_desc character varying(100),
    resolution_code character varying(10),
    resolution_code_desc character varying(100),
    department_id integer,
    department_code character varying(40),
    failure_detail_desc character varying(2000),
    cause_detail_desc character varying(2000),
    resolution_detail_desc character varying(2000),
    failure_grade_code character varying(150),
    failure_desc character varying(2000),
    succession_content character varying(2000),
    status_type integer,
    work_order_status_name character varying(40)
) DISTRIBUTED BY (equipment_id);


ALTER TABLE masdapdw.tb_fda_pdw_equip_work_order_h OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_def_detail; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_def_detail (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    panel_id character varying(40) NOT NULL,
    defect_seq_no integer NOT NULL,
    factory_code character varying(40) NOT NULL,
    defect_inspection_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_id);


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_def_detail OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_def_detail_bk; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_def_detail_bk (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    panel_id character varying(40) NOT NULL,
    defect_seq_no integer NOT NULL,
    factory_code character varying(40) NOT NULL,
    defect_inspection_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_id) PARTITION BY RANGE(glass_inspection_end_timestamp)
          SUBPARTITION BY LIST(factory_code) 
          (
          START ('2012-11-18 00:00:00'::timestamp without time zone) END ('2012-11-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_2', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_2_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_2_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_2_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_2_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-19 00:00:00'::timestamp without time zone) END ('2012-11-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_3', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_3_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_3_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_3_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_3_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-20 00:00:00'::timestamp without time zone) END ('2012-11-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_4', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_4_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_4_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_4_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_4_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-21 00:00:00'::timestamp without time zone) END ('2012-11-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_5', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_5_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_5_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_5_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_5_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-22 00:00:00'::timestamp without time zone) END ('2012-11-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_6', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_6_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_6_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_6_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_6_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-23 00:00:00'::timestamp without time zone) END ('2012-11-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_7', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_7_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_7_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_7_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_7_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-24 00:00:00'::timestamp without time zone) END ('2012-11-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_8', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_8_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_8_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_8_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_8_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-25 00:00:00'::timestamp without time zone) END ('2012-11-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_9', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_9_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_9_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_9_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_9_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-26 00:00:00'::timestamp without time zone) END ('2012-11-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_10', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_10_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_10_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_10_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_10_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-27 00:00:00'::timestamp without time zone) END ('2012-11-28 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_11', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_11_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_11_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_11_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_11_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-28 00:00:00'::timestamp without time zone) END ('2012-11-29 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_12', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_12_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_12_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_12_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_12_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-29 00:00:00'::timestamp without time zone) END ('2012-11-30 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_13', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_13_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_13_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_13_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_13_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-11-30 00:00:00'::timestamp without time zone) END ('2012-12-01 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_14', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_14_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_14_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_14_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_14_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-01 00:00:00'::timestamp without time zone) END ('2012-12-02 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_15', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_15_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_15_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_15_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_15_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-02 00:00:00'::timestamp without time zone) END ('2012-12-03 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_16', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_16_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_16_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_16_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_16_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-03 00:00:00'::timestamp without time zone) END ('2012-12-04 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_17', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_17_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_17_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_17_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_17_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-04 00:00:00'::timestamp without time zone) END ('2012-12-05 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_18', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_18_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_18_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_18_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_18_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-05 00:00:00'::timestamp without time zone) END ('2012-12-06 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_19', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_19_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_19_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_19_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_19_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-06 00:00:00'::timestamp without time zone) END ('2012-12-07 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_20', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_20_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_20_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_20_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_20_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-07 00:00:00'::timestamp without time zone) END ('2012-12-08 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_21', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_21_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_21_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_21_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_21_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-08 00:00:00'::timestamp without time zone) END ('2012-12-09 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_22', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_22_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_22_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_22_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_22_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-09 00:00:00'::timestamp without time zone) END ('2012-12-10 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_23', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_23_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_23_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_23_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_23_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-10 00:00:00'::timestamp without time zone) END ('2012-12-11 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_24', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_24_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_24_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_24_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_24_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-11 00:00:00'::timestamp without time zone) END ('2012-12-12 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_25', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_25_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_25_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_25_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_25_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-12 00:00:00'::timestamp without time zone) END ('2012-12-13 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_26', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_26_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_26_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_26_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_26_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-13 00:00:00'::timestamp without time zone) END ('2012-12-14 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_27', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_27_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_27_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_27_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_27_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-14 00:00:00'::timestamp without time zone) END ('2012-12-15 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_28', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_28_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_28_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_28_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_28_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-15 00:00:00'::timestamp without time zone) END ('2012-12-16 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_29', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_29_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_29_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_29_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_29_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-16 00:00:00'::timestamp without time zone) END ('2012-12-17 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_30', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_30_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_30_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_30_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_30_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-17 00:00:00'::timestamp without time zone) END ('2012-12-18 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_31', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_31_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_31_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_31_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_31_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-18 00:00:00'::timestamp without time zone) END ('2012-12-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_32', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_32_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_32_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_32_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_32_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-19 00:00:00'::timestamp without time zone) END ('2012-12-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_33', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_33_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_33_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_33_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_33_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-20 00:00:00'::timestamp without time zone) END ('2012-12-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_34', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_34_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_34_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_34_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_34_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-21 00:00:00'::timestamp without time zone) END ('2012-12-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_35', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_35_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_35_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_35_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_35_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-22 00:00:00'::timestamp without time zone) END ('2012-12-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_36', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_36_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_36_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_36_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_36_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-23 00:00:00'::timestamp without time zone) END ('2012-12-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_37', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_37_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_37_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_37_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_37_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-24 00:00:00'::timestamp without time zone) END ('2012-12-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_38', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_38_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_38_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_38_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_38_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-25 00:00:00'::timestamp without time zone) END ('2012-12-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_39', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_39_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_39_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_39_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_39_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-26 00:00:00'::timestamp without time zone) END ('2012-12-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_40', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_40_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_40_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_40_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_40_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-27 00:00:00'::timestamp without time zone) END ('2012-12-28 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_41', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_41_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_41_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_41_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_41_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-28 00:00:00'::timestamp without time zone) END ('2012-12-29 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_42', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_42_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_42_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_42_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_42_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-29 00:00:00'::timestamp without time zone) END ('2012-12-30 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_43', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_43_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_43_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_43_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_43_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-30 00:00:00'::timestamp without time zone) END ('2012-12-31 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_44', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_44_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_44_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_44_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_44_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2012-12-31 00:00:00'::timestamp without time zone) END ('2013-01-01 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_45', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_45_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_45_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_45_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_45_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-01 00:00:00'::timestamp without time zone) END ('2013-01-02 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_46', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_46_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_46_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_46_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_46_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-02 00:00:00'::timestamp without time zone) END ('2013-01-03 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_47', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_47_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_47_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_47_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_47_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-03 00:00:00'::timestamp without time zone) END ('2013-01-04 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_48', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_48_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_48_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_48_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_48_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-04 00:00:00'::timestamp without time zone) END ('2013-01-05 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_49', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_49_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_49_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_49_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_49_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-05 00:00:00'::timestamp without time zone) END ('2013-01-06 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_50', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_50_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_50_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_50_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_50_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-06 00:00:00'::timestamp without time zone) END ('2013-01-07 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_51', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_51_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_51_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_51_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_51_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-07 00:00:00'::timestamp without time zone) END ('2013-01-08 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_52', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_52_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_52_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_52_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_52_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-08 00:00:00'::timestamp without time zone) END ('2013-01-09 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_53', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_53_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_53_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_53_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_53_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-09 00:00:00'::timestamp without time zone) END ('2013-01-10 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_54', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_54_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_54_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_54_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_54_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-10 00:00:00'::timestamp without time zone) END ('2013-01-11 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_55', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_55_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_55_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_55_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_55_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-11 00:00:00'::timestamp without time zone) END ('2013-01-12 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_56', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_56_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_56_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_56_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_56_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-12 00:00:00'::timestamp without time zone) END ('2013-01-13 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_57', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_57_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_57_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_57_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_57_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-13 00:00:00'::timestamp without time zone) END ('2013-01-14 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_58', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_58_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_58_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_58_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_58_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-14 00:00:00'::timestamp without time zone) END ('2013-01-15 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_59', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_59_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_59_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_59_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_59_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-15 00:00:00'::timestamp without time zone) END ('2013-01-16 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_60', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_60_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_60_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_60_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_60_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-16 00:00:00'::timestamp without time zone) END ('2013-01-17 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_61', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_61_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_61_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_61_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_61_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-17 00:00:00'::timestamp without time zone) END ('2013-01-18 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_62', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_62_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_62_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_62_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_62_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-18 00:00:00'::timestamp without time zone) END ('2013-01-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_63', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_63_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_63_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_63_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_63_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-19 00:00:00'::timestamp without time zone) END ('2013-01-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_64', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_64_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_64_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_64_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_64_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-20 00:00:00'::timestamp without time zone) END ('2013-01-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_65', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_65_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_65_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_65_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_65_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-21 00:00:00'::timestamp without time zone) END ('2013-01-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_66', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_66_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_66_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_66_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_66_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-22 00:00:00'::timestamp without time zone) END ('2013-01-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_67', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_67_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_67_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_67_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_67_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-23 00:00:00'::timestamp without time zone) END ('2013-01-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_68', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_68_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_68_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_68_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_68_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-24 00:00:00'::timestamp without time zone) END ('2013-01-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_69', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_69_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_69_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_69_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_69_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-25 00:00:00'::timestamp without time zone) END ('2013-01-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_70', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_70_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_70_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_70_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_70_2_prt_pdefault', appendonly=false )
                  ), 
          START ('2013-01-26 00:00:00'::timestamp without time zone) END ('2013-01-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_71', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_71_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_71_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_71_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_71_2_prt_pdefault', appendonly=false )
                  ), 
          DEFAULT PARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_pdefault', appendonly=false ) 
                  (
                  SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_pdefault_2_prt_p1', appendonly=false ), 
                  SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_pdefault_2_prt_p2', appendonly=false ), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_pdefault_2_prt_p8', appendonly=false ), 
                  DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk_1_prt_pdefault_2_prt_pdefault', appendonly=false )
                  )
          );
 ALTER TABLE tb_fda_pdw_gls_insp_def_detail_bk 
SET SUBPARTITION TEMPLATE  
          (
          SUBPARTITION p1 VALUES('P1') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk'), 
          SUBPARTITION p2 VALUES('P2') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk'), 
          SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk'), 
          DEFAULT SUBPARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_detail_bk')
          )
;


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_def_detail_bk OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_def_detail_t; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_def_detail_t (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    panel_id character varying(40) NOT NULL,
    defect_seq_no integer NOT NULL,
    defect_inspection_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_id);


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_def_detail_t OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_def_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_def_h (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    panel_id character varying(40) NOT NULL,
    defect_seq_no integer NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    process_code character varying(50),
    glass_insp_start_timestamp timestamp without time zone,
    defect_valid_end_timestamp timestamp without time zone,
    latest_judgement_code character varying(2),
    latest_defect_large_class_code character varying(40),
    latest_reason_seq_no integer,
    latest_defect_code_surid integer,
    review_judgement_code character varying(2),
    review_reason_seq_no integer,
    review_defect_code_surid integer,
    review_defect_large_class_code character varying(40),
    repair_judgement_code character varying(2),
    repair_reason_seq_no integer,
    repair_defect_code_surid integer,
    repair_defect_large_class_code character varying(40),
    update_timestamp timestamp without time zone,
    delete_flag character(1),
    def_pnt_x double precision,
    def_pnt_y double precision,
    def_line_x double precision,
    def_line_y double precision,
    def_pnt_g double precision,
    def_pnt_d double precision,
    def_line_g double precision,
    def_line_d double precision,
    def_size double precision,
    def_active_area character varying(50),
    def_art_code character varying(50),
    def_art_site character varying(50),
    def_art_stdev character varying(50),
    def_art_volt character varying(50),
    def_masking character varying(50),
    def_md character varying(50),
    def_mode character varying(50),
    def_rank character varying(50),
    def_operator_id character varying(50),
    def_proc_id character varying(50),
    def_proc_name character varying(50),
    def_ptn_art character varying(50),
    def_ptn_code character varying(150),
    def_rep_mode character varying(50),
    def_rep_proc_id character varying(50),
    def_rep_time character varying(50),
    def_rep_unit_id character varying(50),
    def_rep_value character varying(50),
    def_rev_check character varying(50),
    def_shop character varying(50),
    def_unit_id character varying(50),
    def_rtdcvcrep_value character varying(50),
    def_vc character varying(50),
    def_ccd_no character varying(50),
    source_table_shop_type_code character varying(10),
    x_coordinate_value double precision,
    y_coordinate_value double precision
) DISTRIBUTED BY (glass_id);


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_def_h OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_def_h_bk; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_def_h_bk (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    panel_id character varying(40) NOT NULL,
    defect_seq_no integer NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    process_code character varying(50),
    glass_insp_start_timestamp timestamp without time zone,
    defect_valid_end_timestamp timestamp without time zone,
    latest_judgement_code character varying(2),
    latest_defect_large_class_code character varying(40),
    latest_reason_seq_no integer,
    latest_defect_code_surid integer,
    review_judgement_code character varying(2),
    review_reason_seq_no integer,
    review_defect_code_surid integer,
    review_defect_large_class_code character varying(40),
    repair_judgement_code character varying(2),
    repair_reason_seq_no integer,
    repair_defect_code_surid integer,
    repair_defect_large_class_code character varying(40),
    update_timestamp timestamp without time zone,
    delete_flag character(1),
    def_pnt_x double precision,
    def_pnt_y double precision,
    def_line_x double precision,
    def_line_y double precision,
    def_pnt_g double precision,
    def_pnt_d double precision,
    def_line_g double precision,
    def_line_d double precision,
    def_size double precision,
    def_active_area character varying(50),
    def_art_code character varying(50),
    def_art_site character varying(50),
    def_art_stdev character varying(50),
    def_art_volt character varying(50),
    def_masking character varying(50),
    def_md character varying(50),
    def_mode character varying(50),
    def_rank character varying(50),
    def_operator_id character varying(50),
    def_proc_id character varying(50),
    def_proc_name character varying(50),
    def_ptn_art character varying(50),
    def_ptn_code character varying(150),
    def_rep_mode character varying(50),
    def_rep_proc_id character varying(50),
    def_rep_time character varying(50),
    def_rep_unit_id character varying(50),
    def_rep_value character varying(50),
    def_rev_check character varying(50),
    def_shop character varying(50),
    def_unit_id character varying(50),
    def_rtdcvcrep_value character varying(50),
    def_vc character varying(50),
    def_ccd_no character varying(50),
    source_table_shop_type_code character varying(10),
    x_coordinate_value double precision,
    y_coordinate_value double precision
) DISTRIBUTED BY (glass_id) PARTITION BY RANGE(glass_inspection_end_timestamp) 
          (
          START ('2012-11-18 00:00:00'::timestamp without time zone) END ('2012-11-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_2', appendonly=false ), 
          START ('2012-11-19 00:00:00'::timestamp without time zone) END ('2012-11-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_3', appendonly=false ), 
          START ('2012-11-20 00:00:00'::timestamp without time zone) END ('2012-11-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_4', appendonly=false ), 
          START ('2012-11-21 00:00:00'::timestamp without time zone) END ('2012-11-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_5', appendonly=false ), 
          START ('2012-11-22 00:00:00'::timestamp without time zone) END ('2012-11-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_6', appendonly=false ), 
          START ('2012-11-23 00:00:00'::timestamp without time zone) END ('2012-11-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_7', appendonly=false ), 
          START ('2012-11-24 00:00:00'::timestamp without time zone) END ('2012-11-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_8', appendonly=false ), 
          START ('2012-11-25 00:00:00'::timestamp without time zone) END ('2012-11-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_9', appendonly=false ), 
          START ('2012-11-26 00:00:00'::timestamp without time zone) END ('2012-11-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_10', appendonly=false ), 
          START ('2012-11-27 00:00:00'::timestamp without time zone) END ('2012-11-28 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_11', appendonly=false ), 
          START ('2012-11-28 00:00:00'::timestamp without time zone) END ('2012-11-29 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_12', appendonly=false ), 
          START ('2012-11-29 00:00:00'::timestamp without time zone) END ('2012-11-30 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_13', appendonly=false ), 
          START ('2012-11-30 00:00:00'::timestamp without time zone) END ('2012-12-01 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_14', appendonly=false ), 
          START ('2012-12-01 00:00:00'::timestamp without time zone) END ('2012-12-02 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_15', appendonly=false ), 
          START ('2012-12-02 00:00:00'::timestamp without time zone) END ('2012-12-03 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_16', appendonly=false ), 
          START ('2012-12-03 00:00:00'::timestamp without time zone) END ('2012-12-04 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_17', appendonly=false ), 
          START ('2012-12-04 00:00:00'::timestamp without time zone) END ('2012-12-05 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_18', appendonly=false ), 
          START ('2012-12-05 00:00:00'::timestamp without time zone) END ('2012-12-06 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_19', appendonly=false ), 
          START ('2012-12-06 00:00:00'::timestamp without time zone) END ('2012-12-07 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_20', appendonly=false ), 
          START ('2012-12-07 00:00:00'::timestamp without time zone) END ('2012-12-08 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_21', appendonly=false ), 
          START ('2012-12-08 00:00:00'::timestamp without time zone) END ('2012-12-09 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_22', appendonly=false ), 
          START ('2012-12-09 00:00:00'::timestamp without time zone) END ('2012-12-10 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_23', appendonly=false ), 
          START ('2012-12-10 00:00:00'::timestamp without time zone) END ('2012-12-11 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_24', appendonly=false ), 
          START ('2012-12-11 00:00:00'::timestamp without time zone) END ('2012-12-12 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_25', appendonly=false ), 
          START ('2012-12-12 00:00:00'::timestamp without time zone) END ('2012-12-13 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_26', appendonly=false ), 
          START ('2012-12-13 00:00:00'::timestamp without time zone) END ('2012-12-14 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_27', appendonly=false ), 
          START ('2012-12-14 00:00:00'::timestamp without time zone) END ('2012-12-15 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_28', appendonly=false ), 
          START ('2012-12-15 00:00:00'::timestamp without time zone) END ('2012-12-16 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_29', appendonly=false ), 
          START ('2012-12-16 00:00:00'::timestamp without time zone) END ('2012-12-17 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_30', appendonly=false ), 
          START ('2012-12-17 00:00:00'::timestamp without time zone) END ('2012-12-18 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_31', appendonly=false ), 
          START ('2012-12-18 00:00:00'::timestamp without time zone) END ('2012-12-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_32', appendonly=false ), 
          START ('2012-12-19 00:00:00'::timestamp without time zone) END ('2012-12-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_33', appendonly=false ), 
          START ('2012-12-20 00:00:00'::timestamp without time zone) END ('2012-12-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_34', appendonly=false ), 
          START ('2012-12-21 00:00:00'::timestamp without time zone) END ('2012-12-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_35', appendonly=false ), 
          START ('2012-12-22 00:00:00'::timestamp without time zone) END ('2012-12-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_36', appendonly=false ), 
          START ('2012-12-23 00:00:00'::timestamp without time zone) END ('2012-12-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_37', appendonly=false ), 
          START ('2012-12-24 00:00:00'::timestamp without time zone) END ('2012-12-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_38', appendonly=false ), 
          START ('2012-12-25 00:00:00'::timestamp without time zone) END ('2012-12-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_39', appendonly=false ), 
          START ('2012-12-26 00:00:00'::timestamp without time zone) END ('2012-12-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_40', appendonly=false ), 
          START ('2012-12-27 00:00:00'::timestamp without time zone) END ('2012-12-28 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_41', appendonly=false ), 
          START ('2012-12-28 00:00:00'::timestamp without time zone) END ('2012-12-29 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_42', appendonly=false ), 
          START ('2012-12-29 00:00:00'::timestamp without time zone) END ('2012-12-30 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_43', appendonly=false ), 
          START ('2012-12-30 00:00:00'::timestamp without time zone) END ('2012-12-31 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_44', appendonly=false ), 
          START ('2012-12-31 00:00:00'::timestamp without time zone) END ('2013-01-01 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_45', appendonly=false ), 
          START ('2013-01-01 00:00:00'::timestamp without time zone) END ('2013-01-02 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_46', appendonly=false ), 
          START ('2013-01-02 00:00:00'::timestamp without time zone) END ('2013-01-03 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_47', appendonly=false ), 
          START ('2013-01-03 00:00:00'::timestamp without time zone) END ('2013-01-04 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_48', appendonly=false ), 
          START ('2013-01-04 00:00:00'::timestamp without time zone) END ('2013-01-05 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_49', appendonly=false ), 
          START ('2013-01-05 00:00:00'::timestamp without time zone) END ('2013-01-06 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_50', appendonly=false ), 
          START ('2013-01-06 00:00:00'::timestamp without time zone) END ('2013-01-07 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_51', appendonly=false ), 
          START ('2013-01-07 00:00:00'::timestamp without time zone) END ('2013-01-08 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_52', appendonly=false ), 
          START ('2013-01-08 00:00:00'::timestamp without time zone) END ('2013-01-09 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_53', appendonly=false ), 
          START ('2013-01-09 00:00:00'::timestamp without time zone) END ('2013-01-10 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_54', appendonly=false ), 
          START ('2013-01-10 00:00:00'::timestamp without time zone) END ('2013-01-11 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_55', appendonly=false ), 
          START ('2013-01-11 00:00:00'::timestamp without time zone) END ('2013-01-12 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_56', appendonly=false ), 
          START ('2013-01-12 00:00:00'::timestamp without time zone) END ('2013-01-13 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_57', appendonly=false ), 
          START ('2013-01-13 00:00:00'::timestamp without time zone) END ('2013-01-14 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_58', appendonly=false ), 
          START ('2013-01-14 00:00:00'::timestamp without time zone) END ('2013-01-15 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_59', appendonly=false ), 
          START ('2013-01-15 00:00:00'::timestamp without time zone) END ('2013-01-16 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_60', appendonly=false ), 
          START ('2013-01-16 00:00:00'::timestamp without time zone) END ('2013-01-17 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_61', appendonly=false ), 
          START ('2013-01-17 00:00:00'::timestamp without time zone) END ('2013-01-18 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_62', appendonly=false ), 
          START ('2013-01-18 00:00:00'::timestamp without time zone) END ('2013-01-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_63', appendonly=false ), 
          START ('2013-01-19 00:00:00'::timestamp without time zone) END ('2013-01-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_64', appendonly=false ), 
          START ('2013-01-20 00:00:00'::timestamp without time zone) END ('2013-01-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_65', appendonly=false ), 
          START ('2013-01-21 00:00:00'::timestamp without time zone) END ('2013-01-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_66', appendonly=false ), 
          START ('2013-01-22 00:00:00'::timestamp without time zone) END ('2013-01-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_67', appendonly=false ), 
          START ('2013-01-23 00:00:00'::timestamp without time zone) END ('2013-01-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_68', appendonly=false ), 
          START ('2013-01-24 00:00:00'::timestamp without time zone) END ('2013-01-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_69', appendonly=false ), 
          START ('2013-01-25 00:00:00'::timestamp without time zone) END ('2013-01-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_70', appendonly=false ), 
          START ('2013-01-26 00:00:00'::timestamp without time zone) END ('2013-01-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_71', appendonly=false ), 
          DEFAULT PARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_def_h_bk_1_prt_pdefault', appendonly=false )
          );


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_def_h_bk OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_def_h_t; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_def_h_t (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    panel_id character varying(40) NOT NULL,
    defect_seq_no integer NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    process_code character varying(50),
    glass_insp_start_timestamp timestamp without time zone,
    defect_valid_end_timestamp timestamp without time zone,
    latest_judgement_code character varying(2),
    latest_defect_large_class_code character varying(40),
    latest_reason_seq_no integer,
    latest_defect_code_surid integer,
    review_judgement_code character varying(2),
    review_reason_seq_no integer,
    review_defect_code_surid integer,
    review_defect_large_class_code character varying(40),
    repair_judgement_code character varying(2),
    repair_reason_seq_no integer,
    repair_defect_code_surid integer,
    repair_defect_large_class_code character varying(40),
    update_timestamp timestamp without time zone,
    delete_flag character(1),
    def_pnt_x double precision,
    def_pnt_y double precision,
    def_line_x double precision,
    def_line_y double precision,
    def_pnt_g double precision,
    def_pnt_d double precision,
    def_line_g double precision,
    def_line_d double precision,
    def_size double precision,
    def_active_area character varying(50),
    def_art_code character varying(50),
    def_art_site character varying(50),
    def_art_stdev character varying(50),
    def_art_volt character varying(50),
    def_masking character varying(50),
    def_md character varying(50),
    def_mode character varying(50),
    def_rank character varying(50),
    def_operator_id character varying(50),
    def_proc_id character varying(50),
    def_proc_name character varying(50),
    def_ptn_art character varying(50),
    def_ptn_code character varying(150),
    def_rep_mode character varying(50),
    def_rep_proc_id character varying(50),
    def_rep_time character varying(50),
    def_rep_unit_id character varying(50),
    def_rep_value character varying(50),
    def_rev_check character varying(50),
    def_shop character varying(50),
    def_unit_id character varying(50),
    def_rtdcvcrep_value character varying(50),
    def_vc character varying(50),
    def_ccd_no character varying(50),
    source_table_shop_type_code character varying(10),
    x_coordinate_value double precision,
    y_coordinate_value double precision
) DISTRIBUTED BY (glass_id);


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_def_h_t OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_def_img; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_def_img (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    panel_id character varying(40) NOT NULL,
    defect_seq_no integer NOT NULL,
    image_seq_no integer NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    image_path_info character varying(500),
    image_file_name character varying(300),
    update_timestamp timestamp without time zone,
    delete_flag character(1)
) DISTRIBUTED BY (glass_id);


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_def_img OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_detail; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_detail (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    glass_inspection_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_id);


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_detail OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_detail_bk; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_detail_bk (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    glass_inspection_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_id) PARTITION BY RANGE(glass_inspection_end_timestamp) 
          (
          START ('2012-11-18 00:00:00'::timestamp without time zone) END ('2012-11-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_2', appendonly=false ), 
          START ('2012-11-19 00:00:00'::timestamp without time zone) END ('2012-11-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_3', appendonly=false ), 
          START ('2012-11-20 00:00:00'::timestamp without time zone) END ('2012-11-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_4', appendonly=false ), 
          START ('2012-11-21 00:00:00'::timestamp without time zone) END ('2012-11-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_5', appendonly=false ), 
          START ('2012-11-22 00:00:00'::timestamp without time zone) END ('2012-11-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_6', appendonly=false ), 
          START ('2012-11-23 00:00:00'::timestamp without time zone) END ('2012-11-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_7', appendonly=false ), 
          START ('2012-11-24 00:00:00'::timestamp without time zone) END ('2012-11-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_8', appendonly=false ), 
          START ('2012-11-25 00:00:00'::timestamp without time zone) END ('2012-11-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_9', appendonly=false ), 
          START ('2012-11-26 00:00:00'::timestamp without time zone) END ('2012-11-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_10', appendonly=false ), 
          START ('2012-11-27 00:00:00'::timestamp without time zone) END ('2012-11-28 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_11', appendonly=false ), 
          START ('2012-11-28 00:00:00'::timestamp without time zone) END ('2012-11-29 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_12', appendonly=false ), 
          START ('2012-11-29 00:00:00'::timestamp without time zone) END ('2012-11-30 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_13', appendonly=false ), 
          START ('2012-11-30 00:00:00'::timestamp without time zone) END ('2012-12-01 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_14', appendonly=false ), 
          START ('2012-12-01 00:00:00'::timestamp without time zone) END ('2012-12-02 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_15', appendonly=false ), 
          START ('2012-12-02 00:00:00'::timestamp without time zone) END ('2012-12-03 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_16', appendonly=false ), 
          START ('2012-12-03 00:00:00'::timestamp without time zone) END ('2012-12-04 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_17', appendonly=false ), 
          START ('2012-12-04 00:00:00'::timestamp without time zone) END ('2012-12-05 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_18', appendonly=false ), 
          START ('2012-12-05 00:00:00'::timestamp without time zone) END ('2012-12-06 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_19', appendonly=false ), 
          START ('2012-12-06 00:00:00'::timestamp without time zone) END ('2012-12-07 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_20', appendonly=false ), 
          START ('2012-12-07 00:00:00'::timestamp without time zone) END ('2012-12-08 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_21', appendonly=false ), 
          START ('2012-12-08 00:00:00'::timestamp without time zone) END ('2012-12-09 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_22', appendonly=false ), 
          START ('2012-12-09 00:00:00'::timestamp without time zone) END ('2012-12-10 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_23', appendonly=false ), 
          START ('2012-12-10 00:00:00'::timestamp without time zone) END ('2012-12-11 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_24', appendonly=false ), 
          START ('2012-12-11 00:00:00'::timestamp without time zone) END ('2012-12-12 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_25', appendonly=false ), 
          START ('2012-12-12 00:00:00'::timestamp without time zone) END ('2012-12-13 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_26', appendonly=false ), 
          START ('2012-12-13 00:00:00'::timestamp without time zone) END ('2012-12-14 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_27', appendonly=false ), 
          START ('2012-12-14 00:00:00'::timestamp without time zone) END ('2012-12-15 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_28', appendonly=false ), 
          START ('2012-12-15 00:00:00'::timestamp without time zone) END ('2012-12-16 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_29', appendonly=false ), 
          START ('2012-12-16 00:00:00'::timestamp without time zone) END ('2012-12-17 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_30', appendonly=false ), 
          START ('2012-12-17 00:00:00'::timestamp without time zone) END ('2012-12-18 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_31', appendonly=false ), 
          START ('2012-12-18 00:00:00'::timestamp without time zone) END ('2012-12-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_32', appendonly=false ), 
          START ('2012-12-19 00:00:00'::timestamp without time zone) END ('2012-12-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_33', appendonly=false ), 
          START ('2012-12-20 00:00:00'::timestamp without time zone) END ('2012-12-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_34', appendonly=false ), 
          START ('2012-12-21 00:00:00'::timestamp without time zone) END ('2012-12-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_35', appendonly=false ), 
          START ('2012-12-22 00:00:00'::timestamp without time zone) END ('2012-12-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_36', appendonly=false ), 
          START ('2012-12-23 00:00:00'::timestamp without time zone) END ('2012-12-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_37', appendonly=false ), 
          START ('2012-12-24 00:00:00'::timestamp without time zone) END ('2012-12-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_38', appendonly=false ), 
          START ('2012-12-25 00:00:00'::timestamp without time zone) END ('2012-12-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_39', appendonly=false ), 
          START ('2012-12-26 00:00:00'::timestamp without time zone) END ('2012-12-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_40', appendonly=false ), 
          START ('2012-12-27 00:00:00'::timestamp without time zone) END ('2012-12-28 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_41', appendonly=false ), 
          START ('2012-12-28 00:00:00'::timestamp without time zone) END ('2012-12-29 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_42', appendonly=false ), 
          START ('2012-12-29 00:00:00'::timestamp without time zone) END ('2012-12-30 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_43', appendonly=false ), 
          START ('2012-12-30 00:00:00'::timestamp without time zone) END ('2012-12-31 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_44', appendonly=false ), 
          START ('2012-12-31 00:00:00'::timestamp without time zone) END ('2013-01-01 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_45', appendonly=false ), 
          START ('2013-01-01 00:00:00'::timestamp without time zone) END ('2013-01-02 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_46', appendonly=false ), 
          START ('2013-01-02 00:00:00'::timestamp without time zone) END ('2013-01-03 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_47', appendonly=false ), 
          START ('2013-01-03 00:00:00'::timestamp without time zone) END ('2013-01-04 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_48', appendonly=false ), 
          START ('2013-01-04 00:00:00'::timestamp without time zone) END ('2013-01-05 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_49', appendonly=false ), 
          START ('2013-01-05 00:00:00'::timestamp without time zone) END ('2013-01-06 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_50', appendonly=false ), 
          START ('2013-01-06 00:00:00'::timestamp without time zone) END ('2013-01-07 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_51', appendonly=false ), 
          START ('2013-01-07 00:00:00'::timestamp without time zone) END ('2013-01-08 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_52', appendonly=false ), 
          START ('2013-01-08 00:00:00'::timestamp without time zone) END ('2013-01-09 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_53', appendonly=false ), 
          START ('2013-01-09 00:00:00'::timestamp without time zone) END ('2013-01-10 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_54', appendonly=false ), 
          START ('2013-01-10 00:00:00'::timestamp without time zone) END ('2013-01-11 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_55', appendonly=false ), 
          START ('2013-01-11 00:00:00'::timestamp without time zone) END ('2013-01-12 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_56', appendonly=false ), 
          START ('2013-01-12 00:00:00'::timestamp without time zone) END ('2013-01-13 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_57', appendonly=false ), 
          START ('2013-01-13 00:00:00'::timestamp without time zone) END ('2013-01-14 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_58', appendonly=false ), 
          START ('2013-01-14 00:00:00'::timestamp without time zone) END ('2013-01-15 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_59', appendonly=false ), 
          START ('2013-01-15 00:00:00'::timestamp without time zone) END ('2013-01-16 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_60', appendonly=false ), 
          START ('2013-01-16 00:00:00'::timestamp without time zone) END ('2013-01-17 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_61', appendonly=false ), 
          START ('2013-01-17 00:00:00'::timestamp without time zone) END ('2013-01-18 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_62', appendonly=false ), 
          START ('2013-01-18 00:00:00'::timestamp without time zone) END ('2013-01-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_63', appendonly=false ), 
          START ('2013-01-19 00:00:00'::timestamp without time zone) END ('2013-01-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_64', appendonly=false ), 
          START ('2013-01-20 00:00:00'::timestamp without time zone) END ('2013-01-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_65', appendonly=false ), 
          START ('2013-01-21 00:00:00'::timestamp without time zone) END ('2013-01-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_66', appendonly=false ), 
          START ('2013-01-22 00:00:00'::timestamp without time zone) END ('2013-01-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_67', appendonly=false ), 
          START ('2013-01-23 00:00:00'::timestamp without time zone) END ('2013-01-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_68', appendonly=false ), 
          START ('2013-01-24 00:00:00'::timestamp without time zone) END ('2013-01-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_69', appendonly=false ), 
          START ('2013-01-25 00:00:00'::timestamp without time zone) END ('2013-01-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_70', appendonly=false ), 
          START ('2013-01-26 00:00:00'::timestamp without time zone) END ('2013-01-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_71', appendonly=false ), 
          DEFAULT PARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_detail_bk_1_prt_pdefault', appendonly=false )
          );


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_detail_bk OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_detail_t; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_detail_t (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    glass_inspection_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_id);


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_detail_t OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_flag; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_flag (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    facility_final_flag character(1),
    facility_code character varying(40)
) DISTRIBUTED BY (glass_id);


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_flag OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_h (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    process_code character varying(50),
    facility_code character varying(40),
    pre_facility_code character varying(40),
    glass_insp_start_timestamp timestamp without time zone,
    group_lot_id character varying(40),
    lot_id character varying(40),
    apd_key_id character varying(40),
    equipment_group_id character varying(40),
    equipment_id character varying(40),
    machine_id character varying(40),
    equipment_unit_id character varying(40),
    part_no_name character varying(40),
    sub_part_no_name character varying(40),
    recipe_id character varying(40),
    cassette_id character varying(40),
    slot_no integer,
    inspector_id character varying(40),
    original_glass_id character varying(40),
    latest_judgement_code character varying(2),
    latest_defect_large_class_code character varying(40),
    latest_reason_seq_no integer,
    latest_defect_code_surid integer,
    latest_defect_leakage_code character varying(40),
    latest_defect_nickname_code character varying(40),
    review_judgement_code character varying(2),
    review_defect_large_class_code character varying(40),
    review_reason_seq_no integer,
    review_defect_code_surid integer,
    review_defect_leakage_code character varying(40),
    review_defect_nickname_code character varying(40),
    repair_judgement_code character varying(2),
    repair_defect_large_class_code character varying(40),
    repair_reason_seq_no integer,
    repair_defect_code_surid integer,
    repair_defect_leakage_code character varying(40),
    repair_defect_nickname_code character varying(40),
    input_main_panel_qty double precision,
    input_sub_panel_qty double precision,
    process_first_flag character(1),
    final_flag character(1),
    facility_final_flag character(1),
    creation_timestamp timestamp without time zone,
    update_timestamp timestamp without time zone,
    delete_flag character(1),
    gls_a_m_pnl_qty double precision,
    gls_a_s_pnl_qty double precision,
    gls_b_m_pnl_qty double precision,
    gls_b_s_pnl_qty double precision,
    gls_c_m_pnl_qty double precision,
    gls_c_s_pnl_qty double precision,
    gls_d_m_pnl_qty double precision,
    gls_d_s_pnl_qty double precision,
    gls_e_m_pnl_qty double precision,
    gls_e_s_pnl_qty double precision,
    gls_f_m_pnl_qty double precision,
    gls_f_s_pnl_qty double precision,
    gls_g_m_pnl_qty double precision,
    gls_g_s_pnl_qty double precision,
    gls_h_m_pnl_qty double precision,
    gls_h_s_pnl_qty double precision,
    gls_i_m_pnl_qty double precision,
    gls_i_s_pnl_qty double precision,
    gls_j_m_pnl_qty double precision,
    gls_j_s_pnl_qty double precision,
    gls_k_m_pnl_qty double precision,
    gls_k_s_pnl_qty double precision,
    gls_l_m_pnl_qty double precision,
    gls_l_s_pnl_qty double precision,
    gls_m_m_pnl_qty double precision,
    gls_m_s_pnl_qty double precision,
    gls_n_m_pnl_qty double precision,
    gls_n_s_pnl_qty double precision,
    gls_o_m_pnl_qty double precision,
    gls_o_s_pnl_qty double precision,
    gls_p_m_pnl_qty double precision,
    gls_p_s_pnl_qty double precision,
    gls_q_m_pnl_qty double precision,
    gls_q_s_pnl_qty double precision,
    gls_r_m_pnl_qty double precision,
    gls_r_s_pnl_qty double precision,
    gls_s_m_pnl_qty double precision,
    gls_s_s_pnl_qty double precision,
    gls_t_m_pnl_qty double precision,
    gls_t_s_pnl_qty double precision,
    gls_u_m_pnl_qty double precision,
    gls_u_s_pnl_qty double precision,
    gls_v_m_pnl_qty double precision,
    gls_v_s_pnl_qty double precision,
    gls_w_m_pnl_qty double precision,
    gls_w_s_pnl_qty double precision,
    gls_x_m_pnl_qty double precision,
    gls_x_s_pnl_qty double precision,
    gls_y_m_pnl_qty double precision,
    gls_y_s_pnl_qty double precision,
    gls_z_m_pnl_qty double precision,
    gls_z_s_pnl_qty double precision,
    gls_def_step_l_rb_qty double precision,
    gls_def_step_l_rw_qty double precision,
    gls_def_step_l_tb_qty double precision,
    gls_def_step_l_tw_qty double precision,
    gls_def_step_m_rb_qty double precision,
    gls_def_step_m_rw_qty double precision,
    gls_def_step_m_tb_qty double precision,
    gls_def_step_m_tw_qty double precision,
    gls_def_step_o_rb_qty double precision,
    gls_def_step_o_rw_qty double precision,
    gls_def_step_o_tb_qty double precision,
    gls_def_step_o_tw_qty double precision,
    gls_def_step_s_rb_qty double precision,
    gls_def_step_s_rw_qty double precision,
    gls_def_step_s_tb_qty double precision,
    gls_def_step_s_tw_qty double precision,
    gls_def_cum_l_rb_qty double precision,
    gls_def_cum_l_rw_qty double precision,
    gls_def_cum_l_tb_qty double precision,
    gls_def_cum_l_tw_qty double precision,
    gls_def_cum_m_rb_qty double precision,
    gls_def_cum_m_rw_qty double precision,
    gls_def_cum_m_tb_qty double precision,
    gls_def_cum_m_tw_qty double precision,
    gls_def_cum_o_rb_qty double precision,
    gls_def_cum_o_rw_qty double precision,
    gls_def_cum_o_tb_qty double precision,
    gls_def_cum_o_tw_qty double precision,
    gls_def_cum_s_rb_qty double precision,
    gls_def_cum_s_rw_qty double precision,
    gls_def_cum_s_tb_qty double precision,
    gls_def_cum_s_tw_qty double precision,
    gls_def_total_art_c_qty double precision,
    gls_def_total_cum_art_ptn_qty double precision,
    gls_def_total_art_qty double precision,
    gls_def_total_cvd_qty double precision,
    gls_def_total_prr_qty double precision,
    gls_def_total_ptn_mnt_qty double precision,
    gls_def_total_ptn_qty double precision,
    gls_def_total_rpr_qty double precision,
    gls_def_total_step_qty double precision,
    gls_def_total_cum_qty double precision,
    gls_def_total_new_qty double precision,
    gls_def_tot_inter_art_ptn_qty double precision,
    gls_def_real_inter_art_ptn_qty double precision,
    gls_def_real_cum_art_ptn_qty double precision,
    gls_def_real_art_qty double precision,
    gls_def_real_prr_qty double precision,
    gls_def_real_ptn_mnt_qty double precision,
    gls_def_real_ptn_qty double precision,
    gls_def_real_rpr_qty double precision,
    gls_def_real_step_qty double precision,
    gls_def_real_cum_qty double precision,
    gls_def_real_new_qty double precision,
    gls_rep_blow_action_m_pnl_qty double precision,
    gls_rep_blow_action_s_pnl_qty double precision,
    gls_rep_action_m_pnl_qty double precision,
    gls_rep_action_s_pnl_qty double precision,
    gls_rep_success_m_pnl_qty double precision,
    gls_rep_success_s_pnl_qty double precision,
    gls_rep_auto_cvd_m_pnt_qty double precision,
    gls_rep_auto_cvd_s_pnt_qty double precision,
    gls_rep_auto_laser_m_pnt_qty double precision,
    gls_rep_auto_laser_s_pnt_qty double precision,
    gls_rep_auto_tape_m_pnt_qty double precision,
    gls_rep_auto_tape_s_pnt_qty double precision,
    gls_rep_blow_m_pnt_qty double precision,
    gls_rep_blow_s_pnt_qty double precision,
    gls_rep_cvd_m_pnt_qty double precision,
    gls_rep_cvd_s_pnt_qty double precision,
    gls_rep_grinding_m_pnt_qty double precision,
    gls_rep_grinding_s_pnt_qty double precision,
    gls_rep_ink_m_pnt_qty double precision,
    gls_rep_ink_s_pnt_qty double precision,
    gls_rep_ink_tape_m_pnt_qty double precision,
    gls_rep_ink_tape_s_pnt_qty double precision,
    gls_rep_laser_m_pnt_qty double precision,
    gls_rep_laser_s_pnt_qty double precision,
    gls_rep_los_m_pnt_qty double precision,
    gls_rep_los_s_pnt_qty double precision,
    gls_rep_laser_ink_m_pnt_qty double precision,
    gls_rep_laser_ink_s_pnt_qty double precision,
    gls_rep_laser_tape_m_pnt_qty double precision,
    gls_rep_laser_tape_s_pnt_qty double precision,
    gls_rep_tape_m_pnt_qty double precision,
    gls_rep_tape_s_pnt_qty double precision,
    gls_rep_rep_m_pnt_qty double precision,
    gls_rep_rep_s_pnt_qty double precision,
    gls_rep_rev_m_pnt_qty double precision,
    gls_rep_rev_s_pnt_qty double precision,
    gls_rep_rpr_m_pnt_qty double precision,
    gls_rep_rpr_s_pnt_qty double precision,
    generate_factory_code character varying(40),
    process_final_flag character(1),
    source_table_shop_type_code character varying(10)
) DISTRIBUTED BY (glass_id);


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_h OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_pnl_detail; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_pnl_detail (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    panel_id character varying(40) NOT NULL,
    panel_inspection_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_id);


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_pnl_detail OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_pnl_detail_bk; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_pnl_detail_bk (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    panel_id character varying(40) NOT NULL,
    panel_inspection_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_id) PARTITION BY RANGE(glass_inspection_end_timestamp) 
          (
          START ('2012-11-18 00:00:00'::timestamp without time zone) END ('2012-11-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_2', appendonly=false ), 
          START ('2012-11-19 00:00:00'::timestamp without time zone) END ('2012-11-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_3', appendonly=false ), 
          START ('2012-11-20 00:00:00'::timestamp without time zone) END ('2012-11-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_4', appendonly=false ), 
          START ('2012-11-21 00:00:00'::timestamp without time zone) END ('2012-11-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_5', appendonly=false ), 
          START ('2012-11-22 00:00:00'::timestamp without time zone) END ('2012-11-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_6', appendonly=false ), 
          START ('2012-11-23 00:00:00'::timestamp without time zone) END ('2012-11-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_7', appendonly=false ), 
          START ('2012-11-24 00:00:00'::timestamp without time zone) END ('2012-11-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_8', appendonly=false ), 
          START ('2012-11-25 00:00:00'::timestamp without time zone) END ('2012-11-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_9', appendonly=false ), 
          START ('2012-11-26 00:00:00'::timestamp without time zone) END ('2012-11-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_10', appendonly=false ), 
          START ('2012-11-27 00:00:00'::timestamp without time zone) END ('2012-11-28 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_11', appendonly=false ), 
          START ('2012-11-28 00:00:00'::timestamp without time zone) END ('2012-11-29 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_12', appendonly=false ), 
          START ('2012-11-29 00:00:00'::timestamp without time zone) END ('2012-11-30 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_13', appendonly=false ), 
          START ('2012-11-30 00:00:00'::timestamp without time zone) END ('2012-12-01 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_14', appendonly=false ), 
          START ('2012-12-01 00:00:00'::timestamp without time zone) END ('2012-12-02 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_15', appendonly=false ), 
          START ('2012-12-02 00:00:00'::timestamp without time zone) END ('2012-12-03 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_16', appendonly=false ), 
          START ('2012-12-03 00:00:00'::timestamp without time zone) END ('2012-12-04 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_17', appendonly=false ), 
          START ('2012-12-04 00:00:00'::timestamp without time zone) END ('2012-12-05 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_18', appendonly=false ), 
          START ('2012-12-05 00:00:00'::timestamp without time zone) END ('2012-12-06 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_19', appendonly=false ), 
          START ('2012-12-06 00:00:00'::timestamp without time zone) END ('2012-12-07 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_20', appendonly=false ), 
          START ('2012-12-07 00:00:00'::timestamp without time zone) END ('2012-12-08 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_21', appendonly=false ), 
          START ('2012-12-08 00:00:00'::timestamp without time zone) END ('2012-12-09 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_22', appendonly=false ), 
          START ('2012-12-09 00:00:00'::timestamp without time zone) END ('2012-12-10 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_23', appendonly=false ), 
          START ('2012-12-10 00:00:00'::timestamp without time zone) END ('2012-12-11 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_24', appendonly=false ), 
          START ('2012-12-11 00:00:00'::timestamp without time zone) END ('2012-12-12 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_25', appendonly=false ), 
          START ('2012-12-12 00:00:00'::timestamp without time zone) END ('2012-12-13 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_26', appendonly=false ), 
          START ('2012-12-13 00:00:00'::timestamp without time zone) END ('2012-12-14 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_27', appendonly=false ), 
          START ('2012-12-14 00:00:00'::timestamp without time zone) END ('2012-12-15 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_28', appendonly=false ), 
          START ('2012-12-15 00:00:00'::timestamp without time zone) END ('2012-12-16 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_29', appendonly=false ), 
          START ('2012-12-16 00:00:00'::timestamp without time zone) END ('2012-12-17 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_30', appendonly=false ), 
          START ('2012-12-17 00:00:00'::timestamp without time zone) END ('2012-12-18 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_31', appendonly=false ), 
          START ('2012-12-18 00:00:00'::timestamp without time zone) END ('2012-12-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_32', appendonly=false ), 
          START ('2012-12-19 00:00:00'::timestamp without time zone) END ('2012-12-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_33', appendonly=false ), 
          START ('2012-12-20 00:00:00'::timestamp without time zone) END ('2012-12-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_34', appendonly=false ), 
          START ('2012-12-21 00:00:00'::timestamp without time zone) END ('2012-12-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_35', appendonly=false ), 
          START ('2012-12-22 00:00:00'::timestamp without time zone) END ('2012-12-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_36', appendonly=false ), 
          START ('2012-12-23 00:00:00'::timestamp without time zone) END ('2012-12-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_37', appendonly=false ), 
          START ('2012-12-24 00:00:00'::timestamp without time zone) END ('2012-12-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_38', appendonly=false ), 
          START ('2012-12-25 00:00:00'::timestamp without time zone) END ('2012-12-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_39', appendonly=false ), 
          START ('2012-12-26 00:00:00'::timestamp without time zone) END ('2012-12-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_40', appendonly=false ), 
          START ('2012-12-27 00:00:00'::timestamp without time zone) END ('2012-12-28 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_41', appendonly=false ), 
          START ('2012-12-28 00:00:00'::timestamp without time zone) END ('2012-12-29 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_42', appendonly=false ), 
          START ('2012-12-29 00:00:00'::timestamp without time zone) END ('2012-12-30 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_43', appendonly=false ), 
          START ('2012-12-30 00:00:00'::timestamp without time zone) END ('2012-12-31 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_44', appendonly=false ), 
          START ('2012-12-31 00:00:00'::timestamp without time zone) END ('2013-01-01 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_45', appendonly=false ), 
          START ('2013-01-01 00:00:00'::timestamp without time zone) END ('2013-01-02 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_46', appendonly=false ), 
          START ('2013-01-02 00:00:00'::timestamp without time zone) END ('2013-01-03 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_47', appendonly=false ), 
          START ('2013-01-03 00:00:00'::timestamp without time zone) END ('2013-01-04 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_48', appendonly=false ), 
          START ('2013-01-04 00:00:00'::timestamp without time zone) END ('2013-01-05 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_49', appendonly=false ), 
          START ('2013-01-05 00:00:00'::timestamp without time zone) END ('2013-01-06 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_50', appendonly=false ), 
          START ('2013-01-06 00:00:00'::timestamp without time zone) END ('2013-01-07 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_51', appendonly=false ), 
          START ('2013-01-07 00:00:00'::timestamp without time zone) END ('2013-01-08 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_52', appendonly=false ), 
          START ('2013-01-08 00:00:00'::timestamp without time zone) END ('2013-01-09 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_53', appendonly=false ), 
          START ('2013-01-09 00:00:00'::timestamp without time zone) END ('2013-01-10 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_54', appendonly=false ), 
          START ('2013-01-10 00:00:00'::timestamp without time zone) END ('2013-01-11 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_55', appendonly=false ), 
          START ('2013-01-11 00:00:00'::timestamp without time zone) END ('2013-01-12 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_56', appendonly=false ), 
          START ('2013-01-12 00:00:00'::timestamp without time zone) END ('2013-01-13 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_57', appendonly=false ), 
          START ('2013-01-13 00:00:00'::timestamp without time zone) END ('2013-01-14 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_58', appendonly=false ), 
          START ('2013-01-14 00:00:00'::timestamp without time zone) END ('2013-01-15 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_59', appendonly=false ), 
          START ('2013-01-15 00:00:00'::timestamp without time zone) END ('2013-01-16 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_60', appendonly=false ), 
          START ('2013-01-16 00:00:00'::timestamp without time zone) END ('2013-01-17 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_61', appendonly=false ), 
          START ('2013-01-17 00:00:00'::timestamp without time zone) END ('2013-01-18 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_62', appendonly=false ), 
          START ('2013-01-18 00:00:00'::timestamp without time zone) END ('2013-01-19 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_63', appendonly=false ), 
          START ('2013-01-19 00:00:00'::timestamp without time zone) END ('2013-01-20 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_64', appendonly=false ), 
          START ('2013-01-20 00:00:00'::timestamp without time zone) END ('2013-01-21 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_65', appendonly=false ), 
          START ('2013-01-21 00:00:00'::timestamp without time zone) END ('2013-01-22 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_66', appendonly=false ), 
          START ('2013-01-22 00:00:00'::timestamp without time zone) END ('2013-01-23 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_67', appendonly=false ), 
          START ('2013-01-23 00:00:00'::timestamp without time zone) END ('2013-01-24 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_68', appendonly=false ), 
          START ('2013-01-24 00:00:00'::timestamp without time zone) END ('2013-01-25 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_69', appendonly=false ), 
          START ('2013-01-25 00:00:00'::timestamp without time zone) END ('2013-01-26 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_70', appendonly=false ), 
          START ('2013-01-26 00:00:00'::timestamp without time zone) END ('2013-01-27 00:00:00'::timestamp without time zone) EVERY ('1 day'::interval) WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_71', appendonly=false ), 
          DEFAULT PARTITION pdefault  WITH (tablename='tb_fda_pdw_gls_insp_pnl_detail_bk_1_prt_pdefault', appendonly=false )
          );


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_pnl_detail_bk OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_pnl_detail_t; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_pnl_detail_t (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    panel_id character varying(40) NOT NULL,
    panel_inspection_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_id);


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_pnl_detail_t OWNER TO letl;

--
-- Name: tb_fda_pdw_gls_insp_pnl_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_pnl_h (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    panel_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    process_code character varying(50),
    mmg_type_code character varying(40),
    panel_seq_code character varying(10),
    panel_position_code character varying(40),
    latest_judgement_code character varying(2),
    latest_defect_large_class_code character varying(40),
    latest_reason_seq_no integer,
    latest_defect_code_surid integer,
    latest_defect_leakage_code character varying(40),
    latest_defect_nickname_code character varying(40),
    review_judgement_code character varying(2),
    review_defect_large_class_code character varying(40),
    review_reason_seq_no integer,
    review_defect_code_surid integer,
    review_defect_leakage_code character varying(40),
    review_defect_nickname_code character varying(40),
    repair_judgement_code character varying(2),
    repair_defect_large_class_code character varying(40),
    repair_reason_seq_no integer,
    repair_defect_code_surid integer,
    repair_defect_leakage_code character varying(40),
    repair_defect_nickname_code character varying(40),
    update_timestamp timestamp without time zone,
    delete_flag character(1),
    pnl_def_step_l_rb_qty double precision,
    pnl_def_step_l_rw_qty double precision,
    pnl_def_step_l_tb_qty double precision,
    pnl_def_step_l_tw_qty double precision,
    pnl_def_step_m_rb_qty double precision,
    pnl_def_step_m_rw_qty double precision,
    pnl_def_step_m_tb_qty double precision,
    pnl_def_step_m_tw_qty double precision,
    pnl_def_step_o_rb_qty double precision,
    pnl_def_step_o_rw_qty double precision,
    pnl_def_step_o_tb_qty double precision,
    pnl_def_step_o_tw_qty double precision,
    pnl_def_step_s_rb_qty double precision,
    pnl_def_step_s_rw_qty double precision,
    pnl_def_step_s_tb_qty double precision,
    pnl_def_step_s_tw_qty double precision,
    pnl_def_cum_l_rb_qty double precision,
    pnl_def_cum_l_rw_qty double precision,
    pnl_def_cum_l_tb_qty double precision,
    pnl_def_cum_l_tw_qty double precision,
    pnl_def_cum_m_rb_qty double precision,
    pnl_def_cum_m_rw_qty double precision,
    pnl_def_cum_m_tb_qty double precision,
    pnl_def_cum_m_tw_qty double precision,
    pnl_def_cum_o_rb_qty double precision,
    pnl_def_cum_o_rw_qty double precision,
    pnl_def_cum_o_tb_qty double precision,
    pnl_def_cum_o_tw_qty double precision,
    pnl_def_cum_s_rb_qty double precision,
    pnl_def_cum_s_rw_qty double precision,
    pnl_def_cum_s_tb_qty double precision,
    pnl_def_cum_s_tw_qty double precision,
    pnl_def_total_cum_art_ptn_qty double precision,
    pnl_def_total_art_qty double precision,
    pnl_def_total_cvd_qty double precision,
    pnl_def_total_prr_qty double precision,
    pnl_def_total_ptn_mnt_qty double precision,
    pnl_def_total_ptn_qty double precision,
    pnl_def_total_rpr_qty double precision,
    pnl_def_total_step_qty double precision,
    pnl_def_total_cum_qty double precision,
    pnl_def_total_new_qty double precision,
    pnl_def_tot_inter_art_ptn_qty double precision,
    pnl_def_real_inter_art_ptn_qty double precision,
    pnl_def_real_cum_art_ptn_qty double precision,
    pnl_def_real_art_qty double precision,
    pnl_def_real_prr_qty double precision,
    pnl_def_real_ptn_mnt_qty double precision,
    pnl_def_real_ptn_qty double precision,
    pnl_def_real_rpr_qty double precision,
    pnl_def_real_step_qty double precision,
    pnl_def_real_cum_qty double precision,
    pnl_def_real_new_qty double precision,
    pnl_rep_auto_tape_pnt_qty double precision,
    pnl_rep_auto_cvd_pnt_qty double precision,
    pnl_rep_auto_laser_pnt_qty double precision,
    pnl_rep_cvd_pnt_qty double precision,
    pnl_rep_grinding_pnt_qty double precision,
    pnl_rep_ink_pnt_qty double precision,
    pnl_rep_ink_tape_pnt_qty double precision,
    pnl_rep_laser_pnt_qty double precision,
    pnl_rep_laser_ink_pnt_qty double precision,
    pnl_rep_laser_tape_pnt_qty double precision,
    pnl_rep_success_flag character(1),
    pnl_rep_action_flag character(1),
    pnl_rep_rev_pnt_qty double precision,
    pnl_rep_tape_pnt_qty double precision,
    sub_glass_id character varying(40),
    source_table_shop_type_code character varying(10)
) DISTRIBUTED BY (glass_id);


ALTER TABLE masdapdw.tb_fda_pdw_gls_insp_pnl_h OWNER TO letl;

--
-- Name: tb_fda_pdw_lot_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_lot_h (
    factory_code character varying(40) NOT NULL,
    lot_id character varying(40) NOT NULL,
    timekey_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    sub_factory_code character varying(40),
    facility_code character varying(40),
    event_occur_timestamp timestamp without time zone,
    event_code character varying(40),
    apd_key_id character varying(40),
    process_code character varying(50),
    next_process_code character varying(40),
    equipment_id character varying(40),
    port_id character varying(40),
    recipe_id character varying(40),
    cassette_id character varying(40),
    part_no_name character varying(40),
    sub_part_no_name character varying(40),
    glass_qty double precision,
    panel_qty double precision,
    sub_panel_qty double precision,
    original_lot_id character varying(40),
    event_occur_user_id character varying(30),
    glass_handling_flag character(1),
    glass_handling_mode_code character varying(40),
    cancel_flag character(1),
    cancel_timekey character varying(40),
    generate_factory_code character varying(40),
    interest_content character varying(600),
    priority_no integer,
    shipping_factory_code character varying(40),
    usage_code character varying(40),
    detail_usage_code character varying(40),
    lot_flag_info character varying(400),
    data_interface_type_code character(1)
) DISTRIBUTED BY (lot_id);


ALTER TABLE masdapdw.tb_fda_pdw_lot_h OWNER TO letl;

--
-- Name: tb_fda_pdw_lot_h_t; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_lot_h_t (
    factory_code character varying(40) NOT NULL,
    lot_id character varying(40) NOT NULL,
    timekey_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    sub_factory_code character varying(40),
    facility_code character varying(40),
    event_occur_timestamp timestamp without time zone,
    event_code character varying(40),
    apd_key_id character varying(40),
    process_code character varying(50),
    next_process_code character varying(40),
    equipment_id character varying(40),
    port_id character varying(40),
    recipe_id character varying(40),
    cassette_id character varying(40),
    part_no_name character varying(40),
    sub_part_no_name character varying(40),
    glass_qty double precision,
    panel_qty double precision,
    sub_panel_qty double precision,
    original_lot_id character varying(40),
    event_occur_user_id character varying(30),
    glass_handling_flag character(1),
    glass_handling_mode_code character varying(40),
    cancel_flag character(1),
    cancel_timekey character varying(40),
    generate_factory_code character varying(40),
    interest_content character varying(600),
    priority_no integer,
    shipping_factory_code character varying(40),
    usage_code character varying(40),
    detail_usage_code character varying(40),
    lot_flag_info character varying(400),
    data_interface_type_code character(1)
) DISTRIBUTED BY (lot_id);


ALTER TABLE masdapdw.tb_fda_pdw_lot_h_t OWNER TO letl;

--
-- Name: tb_fda_pdw_mod_product_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_mod_product_h (
    panel_id character varying(40) NOT NULL,
    panel_factory_code character varying(40) NOT NULL,
    timekey_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    result_aggregate_date date NOT NULL,
    result_occur_date date NOT NULL,
    result_time_id character varying(2) NOT NULL,
    module_factory_code character varying(40) NOT NULL,
    src_etl_insert_upd_timestamp timestamp without time zone,
    shift_code character(1) NOT NULL,
    event_name character varying(40),
    event_occur_timestamp timestamp without time zone NOT NULL,
    departure_module_factory_code character varying(40) NOT NULL,
    zone_code character varying(40) NOT NULL,
    tab_zone_input_line_code character varying(10) NOT NULL,
    assembly_zone_input_line_code character varying(10) NOT NULL,
    line_code character varying(10) NOT NULL,
    process_code character varying(50) NOT NULL,
    next_process_code character varying(40),
    pol_module_equipment_surid integer NOT NULL,
    pol_module_equip_factory_code character varying(40),
    polarizer_module_equipment_id character varying(40),
    module_equipment_surid integer NOT NULL,
    module_equipment_factory_code character varying(40),
    module_equipment_id character varying(40),
    bl_module_equipment_surid integer NOT NULL,
    bl_module_equip_factory_code character varying(40),
    back_light_module_equipment_id character varying(40),
    tab_zone_input_model_surid integer NOT NULL,
    tab_zn_input_mdl_factory_code character varying(40),
    tab_zn_input_model_group_code character varying(40),
    tab_zone_input_model_code character varying(40),
    assy_zn_input_model_surid integer NOT NULL,
    assy_zn_input_mdl_factory_code character varying(40),
    assy_zn_input_model_group_code character varying(40),
    assembly_zone_input_model_code character varying(40),
    pre_model_surid integer NOT NULL,
    pre_model_factory_code character varying(40),
    pre_model_group_code character varying(40),
    pre_model_code character varying(40),
    model_surid integer NOT NULL,
    model_factory_code character varying(40),
    model_group_code character varying(40),
    model_code character varying(40),
    base_model_code character varying(30),
    part_no_surid integer,
    part_no_facility_code character varying(40),
    part_no_name character varying(40),
    lane_code character varying(150),
    input_grade_code character varying(40) NOT NULL,
    grade_code character varying(40) NOT NULL,
    work_crew_code character varying(40) NOT NULL,
    work_unit_code character varying(40) NOT NULL,
    worker_surid integer,
    worker_id character varying(40),
    vendorship_company_id character varying(40),
    customer_id character varying(100) NOT NULL,
    re_input_type_code character varying(10),
    re_input_flag character(1),
    process_first_input_flag character(1) NOT NULL,
    again_defect_flag character(1),
    rework_count double precision,
    route_type_code character varying(40),
    production_type_code character varying(40) NOT NULL,
    work_order_no character varying(30),
    tab_zone_work_order_no character varying(30),
    assembly_zone_work_order_no character varying(30),
    panel_pallet_id character varying(40),
    box_id character varying(40),
    pallet_id character varying(40),
    qa_lot_id character varying(40),
    product_serial_no character varying(40),
    cancel_timekey character varying(40),
    cancel_flag character(1),
    pre_event_occur_timestamp timestamp without time zone,
    pixel_vcom_adjust_value double precision,
    pixel_vcom_adjust_drop_value double precision,
    erp_model_code character varying(40),
    result_date_time_id character varying(10),
    production_equipment_surid integer,
    production_equip_factory_code character varying(40),
    production_equipment_id character varying(40),
    base_timestamp timestamp without time zone,
    input_line_type_code character varying(40),
    warehouse_stock_flag character(1),
    semi_finished_goods_box_id character varying(40),
    top_model_code character varying(40),
    ink_lot_no character varying(40),
    arrival_module_factory_code character varying(40),
    tab_zone_input_part_no_surid integer,
    tab_input_part_no_facil_code character varying(40),
    tab_zone_input_part_no_name character varying(40),
    sale_change_flag character(1),
    route_id character varying(40)
) DISTRIBUTED BY (panel_id);


ALTER TABLE masdapdw.tb_fda_pdw_mod_product_h OWNER TO letl;

--
-- Name: tb_fda_pdw_pnl_insp_def_detail; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_pnl_insp_def_detail (
    panel_id character varying(40) NOT NULL,
    panel_seq_no integer NOT NULL,
    panel_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    defect_seq_no integer NOT NULL,
    detect_shop_code character varying(10) NOT NULL,
    defect_inspection_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (panel_id);


ALTER TABLE masdapdw.tb_fda_pdw_pnl_insp_def_detail OWNER TO letl;

--
-- Name: tb_fda_pdw_pnl_insp_def_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_pnl_insp_def_h (
    panel_id character varying(40) NOT NULL,
    panel_seq_no integer NOT NULL,
    panel_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    defect_seq_no integer NOT NULL,
    detect_shop_code character varying(10) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    process_code character varying(50),
    panel_insp_start_timestamp timestamp without time zone,
    defect_valid_end_timestamp timestamp without time zone,
    latest_judgement_code character varying(2),
    latest_defect_large_class_code character varying(40),
    latest_reason_seq_no integer,
    latest_defect_code_surid integer,
    review_judgement_code character varying(2),
    review_reason_seq_no integer,
    review_defect_code_surid integer,
    review_defect_large_class_code character varying(40),
    repair_judgement_code character varying(2),
    repair_reason_seq_no integer,
    repair_defect_code_surid integer,
    repair_defect_large_class_code character varying(40),
    update_timestamp timestamp without time zone,
    delete_flag character(1),
    def_pnt_x double precision,
    def_pnt_y double precision,
    def_line_x double precision,
    def_line_y double precision,
    def_pnt_g double precision,
    def_pnt_d double precision,
    def_line_g double precision,
    def_line_d double precision,
    def_size double precision,
    def_active_area character varying(50),
    def_art_code character varying(50),
    def_art_site character varying(50),
    def_art_stdev character varying(50),
    def_art_volt character varying(50),
    def_masking character varying(50),
    def_md character varying(50),
    def_mode character varying(50),
    def_rank character varying(50),
    def_operator_id character varying(50),
    def_proc_id character varying(50),
    def_proc_name character varying(50),
    def_ptn_art character varying(50),
    def_ptn_code character varying(150),
    def_rep_mode character varying(50),
    def_rep_proc_id character varying(50),
    def_rep_time character varying(50),
    def_rep_unit_id character varying(50),
    def_rep_value character varying(50),
    def_rev_check character varying(50),
    def_unit_id character varying(50),
    def_rtdcvcrep_value character varying(50),
    def_vc character varying(50),
    def_ccd_no character varying(50),
    def_ap_g double precision,
    def_ap_d double precision,
    x_coordinate_value double precision,
    y_coordinate_value double precision
) DISTRIBUTED BY (panel_id);


ALTER TABLE masdapdw.tb_fda_pdw_pnl_insp_def_h OWNER TO letl;

--
-- Name: tb_fda_pdw_pnl_insp_detail; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_pnl_insp_detail (
    panel_id character varying(40) NOT NULL,
    panel_seq_no integer NOT NULL,
    panel_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    panel_inspection_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (panel_id);


ALTER TABLE masdapdw.tb_fda_pdw_pnl_insp_detail OWNER TO letl;

--
-- Name: tb_fda_pdw_pnl_insp_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_pnl_insp_h (
    panel_id character varying(40) NOT NULL,
    panel_seq_no integer NOT NULL,
    panel_inspection_end_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    mmg_type_code character varying(40),
    panel_seq_code character varying(10),
    panel_position_code character varying(40),
    process_code character varying(50),
    facility_code character varying(40),
    panel_insp_start_timestamp timestamp without time zone,
    group_lot_id character varying(40),
    lot_id character varying(40),
    apd_key_id character varying(40),
    equipment_group_id character varying(40),
    equipment_id character varying(40),
    machine_id character varying(40),
    equipment_unit_id character varying(40),
    part_no_name character varying(40),
    recipe_id character varying(40),
    cassette_id character varying(40),
    slot_no integer,
    cf_panel_id character varying(40),
    inspector_id character varying(40),
    latest_judgement_code character varying(2),
    latest_defect_large_class_code character varying(40),
    latest_reason_seq_no integer,
    latest_defect_code_surid integer,
    latest_defect_leakage_code character varying(40),
    latest_defect_nickname_code character varying(40),
    review_judgement_code character varying(2),
    review_defect_large_class_code character varying(40),
    review_reason_seq_no integer,
    review_defect_code_surid integer,
    review_defect_leakage_code character varying(40),
    review_defect_nickname_code character varying(40),
    repair_judgement_code character varying(2),
    repair_defect_large_class_code character varying(40),
    repair_reason_seq_no integer,
    repair_defect_code_surid integer,
    repair_defect_leakage_code character varying(40),
    repair_defect_nickname_code character varying(40),
    final_flag character(1),
    facility_final_flag character(1),
    creation_timestamp timestamp without time zone,
    update_timestamp timestamp without time zone,
    delete_flag character(1),
    first_flag character(1),
    cs_level_value character varying(200),
    tft_input_lot_id character varying(40),
    tft_ppbox_id character varying(40),
    tft_ppbox_serial_no character varying(50),
    tft_glass_id character varying(40),
    tft_inspection_lot_id character varying(40),
    tft_finish_lot_id character varying(40),
    tft_finish_slot_no integer,
    cf_input_lot_id character varying(40),
    cf_ppbox_id character varying(40),
    cf_ppbox_serial_no character varying(50),
    cf_glass_id character varying(40),
    cf_inspection_lot_id character varying(40),
    cf_finish_lot_id character varying(40),
    cf_finish_slot_no integer,
    cell_input_tft_lot_id character varying(40),
    cell_input_tft_slot_no integer,
    cell_input_tft_pnl_judge_code character(1),
    cell_input_cf_lot_id character varying(40),
    cell_input_cf_slot_no integer,
    cell_input_cf_panel_judge_code character(1),
    matching_move_in_tft_slot_no integer,
    matching_move_in_cf_slot_no integer,
    matching_move_out_slot_no integer,
    matching_move_out_lot_id character varying(40),
    cps_lot_id character varying(40),
    cps_slot_no integer,
    cps_judgement_code character varying(40),
    grinding_lot_id character varying(40),
    grinding_slot_no integer,
    lane_code character varying(150),
    generate_factory_code character varying(40),
    lc_level_value character varying(40),
    stick_id character varying(40),
    representative_tray_id character varying(40),
    process_first_flag character(1),
    process_final_flag character(1)
) DISTRIBUTED BY (panel_id);


ALTER TABLE masdapdw.tb_fda_pdw_pnl_insp_h OWNER TO letl;

--
-- Name: tb_fda_pdw_pnl_insp_h_t; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_pnl_insp_h_t (
    panel_id character varying(40) NOT NULL,
    panel_seq_no integer NOT NULL,
    panel_inspection_end_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    mmg_type_code character varying(40),
    panel_seq_code character varying(10),
    panel_position_code character varying(40),
    process_code character varying(50),
    facility_code character varying(40),
    panel_insp_start_timestamp timestamp without time zone,
    group_lot_id character varying(40),
    lot_id character varying(40),
    apd_key_id character varying(40),
    equipment_group_id character varying(40),
    equipment_id character varying(40),
    machine_id character varying(40),
    equipment_unit_id character varying(40),
    part_no_name character varying(40),
    recipe_id character varying(40),
    cassette_id character varying(40),
    slot_no integer,
    cf_panel_id character varying(40),
    inspector_id character varying(40),
    latest_judgement_code character varying(2),
    latest_defect_large_class_code character varying(40),
    latest_reason_seq_no integer,
    latest_defect_code_surid integer,
    latest_defect_leakage_code character varying(40),
    latest_defect_nickname_code character varying(40),
    review_judgement_code character varying(2),
    review_defect_large_class_code character varying(40),
    review_reason_seq_no integer,
    review_defect_code_surid integer,
    review_defect_leakage_code character varying(40),
    review_defect_nickname_code character varying(40),
    repair_judgement_code character varying(2),
    repair_defect_large_class_code character varying(40),
    repair_reason_seq_no integer,
    repair_defect_code_surid integer,
    repair_defect_leakage_code character varying(40),
    repair_defect_nickname_code character varying(40),
    final_flag character(1),
    facility_final_flag character(1),
    creation_timestamp timestamp without time zone,
    update_timestamp timestamp without time zone,
    delete_flag character(1),
    first_flag character(1),
    cs_level_value character varying(200),
    tft_input_lot_id character varying(40),
    tft_ppbox_id character varying(40),
    tft_ppbox_serial_no character varying(50),
    tft_glass_id character varying(40),
    tft_inspection_lot_id character varying(40),
    tft_finish_lot_id character varying(40),
    tft_finish_slot_no integer,
    cf_input_lot_id character varying(40),
    cf_ppbox_id character varying(40),
    cf_ppbox_serial_no character varying(50),
    cf_glass_id character varying(40),
    cf_inspection_lot_id character varying(40),
    cf_finish_lot_id character varying(40),
    cf_finish_slot_no integer,
    cell_input_tft_lot_id character varying(40),
    cell_input_tft_slot_no integer,
    cell_input_tft_pnl_judge_code character(1),
    cell_input_cf_lot_id character varying(40),
    cell_input_cf_slot_no integer,
    cell_input_cf_panel_judge_code character(1),
    matching_move_in_tft_slot_no integer,
    matching_move_in_cf_slot_no integer,
    matching_move_out_slot_no integer,
    matching_move_out_lot_id character varying(40),
    cps_lot_id character varying(40),
    cps_slot_no integer,
    cps_judgement_code character varying(40),
    grinding_lot_id character varying(40),
    grinding_slot_no integer,
    lane_code character varying(150),
    generate_factory_code character varying(40),
    lc_level_value character varying(40),
    stick_id character varying(40),
    representative_tray_id character varying(40),
    process_first_flag character(1),
    process_final_flag character(1)
) DISTRIBUTED BY (panel_id);


ALTER TABLE masdapdw.tb_fda_pdw_pnl_insp_h_t OWNER TO letl;

--
-- Name: tb_fda_pdw_product_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_product_h (
    product_id character varying(40) NOT NULL,
    generate_factory_code character varying(40) NOT NULL,
    timekey_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    factory_code character varying(40),
    facility_code character varying(40),
    lot_id character varying(40),
    event_occur_timestamp timestamp without time zone,
    event_code character varying(40),
    apd_key_id character varying(40),
    process_code character varying(50),
    equipment_id character varying(40),
    recipe_id character varying(40),
    cassette_id character varying(40),
    slot_no integer,
    part_no_name character varying(40),
    sub_part_no_name character varying(40),
    glass_judgement_code character(1),
    main_panel_judge_info character varying(200),
    sub_panel_judge_info character varying(200),
    original_glass_id character varying(40),
    original_product_id character varying(40),
    group_lot_id character varying(40),
    event_occur_user_id character varying(30),
    ppbox_id character varying(40),
    ppbox_serial_no character varying(50),
    matching_lot_id character varying(40),
    matching_cf_glass_id character varying(40),
    matching_slot_no integer,
    lane_code character varying(150),
    rework_code character varying(40),
    rework_count double precision,
    cancel_flag character(1),
    cancel_timekey character varying(40),
    final_flag character(1),
    cs_level_value character varying(200),
    next_process_code character varying(40),
    product_type_code character varying(10),
    sub_factory_code character varying(40),
    main_lc_level_desc character varying(1000),
    sub_lc_level_desc character varying(1000),
    cps_judgement_code character varying(40),
    sampling_info character varying(40),
    pre_rework_process_code character varying(40),
    data_interface_type_code character(1)
) DISTRIBUTED BY (product_id);


ALTER TABLE masdapdw.tb_fda_pdw_product_h OWNER TO letl;

--
-- Name: tb_fda_pdw_product_h_t; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_product_h_t (
    product_id character varying(40) NOT NULL,
    generate_factory_code character varying(40) NOT NULL,
    timekey_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone,
    factory_code character varying(40),
    facility_code character varying(40),
    lot_id character varying(40),
    event_occur_timestamp timestamp without time zone,
    event_code character varying(40),
    apd_key_id character varying(40),
    process_code character varying(50),
    equipment_id character varying(40),
    recipe_id character varying(40),
    cassette_id character varying(40),
    slot_no integer,
    part_no_name character varying(40),
    sub_part_no_name character varying(40),
    glass_judgement_code character(1),
    main_panel_judge_info character varying(200),
    sub_panel_judge_info character varying(200),
    original_glass_id character varying(40),
    original_product_id character varying(40),
    group_lot_id character varying(40),
    event_occur_user_id character varying(30),
    ppbox_id character varying(40),
    ppbox_serial_no character varying(50),
    matching_lot_id character varying(40),
    matching_cf_glass_id character varying(40),
    matching_slot_no integer,
    lane_code character varying(150),
    rework_code character varying(40),
    rework_count double precision,
    cancel_flag character(1),
    cancel_timekey character varying(40),
    final_flag character(1),
    cs_level_value character varying(200),
    next_process_code character varying(40),
    product_type_code character varying(10),
    sub_factory_code character varying(40),
    main_lc_level_desc character varying(1000),
    sub_lc_level_desc character varying(1000),
    cps_judgement_code character varying(40),
    sampling_info character varying(40),
    pre_rework_process_code character varying(40),
    data_interface_type_code character(1)
) DISTRIBUTED BY (product_id);


ALTER TABLE masdapdw.tb_fda_pdw_product_h_t OWNER TO letl;

--
-- Name: tb_fda_pdw_recipe_change_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_recipe_change_h (
    factory_code character varying(40) NOT NULL,
    equipment_id character varying(40) NOT NULL,
    recipe_id character varying(40) NOT NULL,
    creation_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    recipe_history_surid integer NOT NULL,
    sub_factory_code character varying(40),
    data_change_type_code character varying(2),
    recipe_version character varying(40),
    approval_status_name character varying(300),
    approval_contents_text character varying(4000),
    approval_id integer,
    created_by integer,
    last_update_timestamp timestamp without time zone,
    last_updated_by integer,
    equipment_surid integer,
    recipe_type_code character varying(40),
    change_reason_content character varying(4000),
    equipment_line_id character varying(40),
    equipment_model_code character varying(40),
    equipment_type_desc character varying(40),
    detail_equipment_type_code character varying(40),
    desc_text character varying(256),
    equipment_inquiry_order_no integer,
    equipment_machine_id character varying(40),
    equipment_unit_id character varying(40),
    facility_code character varying(40),
    user_id character varying(40),
    user_name character varying(250),
    approval_user_id character varying(40),
    approval_user_name character varying(100)
) DISTRIBUTED BY (equipment_id);


ALTER TABLE masdapdw.tb_fda_pdw_recipe_change_h OWNER TO letl;

--
-- Name: tb_fda_pdw_run_note; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_run_note (
    lot_id character varying(40) NOT NULL,
    facility_code character varying(40) NOT NULL,
    route_id character varying(40) NOT NULL,
    process_code character varying(50) NOT NULL,
    application_transfer_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    etl_insert_update_timestamp timestamp without time zone,
    run_note_content character varying(4000),
    user_id character varying(40),
    update_timestamp timestamp without time zone,
    full_cassette_load_flag character(1),
    full_cst_load_flag_user_id character varying(40),
    material_id character varying(40),
    progress_spec character varying(250),
    delete_flag character(1)
) DISTRIBUTED BY (lot_id);


ALTER TABLE masdapdw.tb_fda_pdw_run_note OWNER TO letl;

--
-- Name: tb_fda_pdw_spc_point_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_spc_point_h (
    facility_code character varying(40) NOT NULL,
    specification_group_id character varying(50) NOT NULL,
    equipment_group_id character varying(40) NOT NULL,
    apd_seq_no integer NOT NULL,
    receive_timestamp timestamp without time zone NOT NULL,
    calculation_item_code character varying(40) NOT NULL,
    check_rule_code character varying(10) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40),
    part_no_name character varying(40),
    measure_process_code character varying(40),
    production_equipment_id character varying(40),
    production_equipment2_id character varying(40),
    specification_reg_timestamp timestamp without time zone,
    point_value double precision,
    spec_out_flag character(1),
    spec_out_grade_code character varying(10),
    trouble_alert_id character varying(40),
    mismeasure_count double precision,
    creation_timestamp timestamp without time zone,
    pre_process_code character varying(40),
    pre_equipment_group_id character varying(40),
    pre_equipment_id character varying(40),
    pre_main_path_code character varying(40)
) DISTRIBUTED BY (facility_code ,specification_group_id ,apd_seq_no);


ALTER TABLE masdapdw.tb_fda_pdw_spc_point_h OWNER TO letl;

--
-- Name: tb_fda_pdw_transport_command_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_transport_command_h (
    factory_code character varying(40) NOT NULL,
    command_seq_no integer NOT NULL,
    creation_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    eai_seq_id bigint NOT NULL,
    cassette_id character varying(40),
    cassette_type_code character varying(40),
    lot_id character varying(40),
    use_count double precision,
    process_code character varying(50),
    from_equipment_id character varying(40),
    from_port_id character varying(40),
    to_equipment_id character varying(40),
    to_port_id character varying(40),
    priority_no integer,
    command_status_code character(1),
    transport_type_code character varying(40),
    transport_class_code character(1),
    transport_code character varying(40),
    response_code character varying(40),
    user_id character varying(40),
    completion_timestamp timestamp without time zone,
    request_seq_no integer,
    reserve_flag character(1),
    reserve_date timestamp without time zone,
    last_lot_event_name character varying(40),
    last_lot_event_timekey character varying(40),
    cancel_user_id character varying(40),
    cancel_timestamp timestamp without time zone,
    glass_handling_mode_code character varying(40),
    facility_code character varying(40),
    rule_name character varying(40),
    error_detail_no integer,
    data_interface_type_code character(1)
) DISTRIBUTED BY (command_seq_no);


ALTER TABLE masdapdw.tb_fda_pdw_transport_command_h OWNER TO letl;

--
-- Name: tb_fda_pdw_transport_command_h_t; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_transport_command_h_t (
    factory_code character varying(40) NOT NULL,
    command_seq_no integer NOT NULL,
    creation_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    eai_seq_id bigint NOT NULL,
    cassette_id character varying(40),
    cassette_type_code character varying(40),
    lot_id character varying(40),
    use_count double precision,
    process_code character varying(50),
    from_equipment_id character varying(40),
    from_port_id character varying(40),
    to_equipment_id character varying(40),
    to_port_id character varying(40),
    priority_no integer,
    command_status_code character(1),
    transport_type_code character varying(40),
    transport_class_code character(1),
    transport_code character varying(40),
    response_code character varying(40),
    user_id character varying(40),
    completion_timestamp timestamp without time zone,
    request_seq_no integer,
    reserve_flag character(1),
    reserve_date timestamp without time zone,
    last_lot_event_name character varying(40),
    last_lot_event_timekey character varying(40),
    cancel_user_id character varying(40),
    cancel_timestamp timestamp without time zone,
    glass_handling_mode_code character varying(40),
    facility_code character varying(40),
    rule_name character varying(40),
    error_detail_no integer,
    data_interface_type_code character(1)
) DISTRIBUTED BY (command_seq_no);


ALTER TABLE masdapdw.tb_fda_pdw_transport_command_h_t OWNER TO letl;

--
-- Name: tb_fda_pdw_transport_event_h; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_transport_event_h (
    factory_code character varying(40) NOT NULL,
    event_seq_no integer NOT NULL,
    creation_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    eai_seq_id bigint NOT NULL,
    equipment_id character varying(40),
    port_id character varying(40),
    shelf_id character varying(40),
    cassette_id character varying(40),
    cassette_type_code character varying(40),
    lot_id character varying(40),
    process_code character varying(50),
    use_count double precision,
    final_destination_equipment_id character varying(40),
    final_destination_port_id character varying(40),
    event_name character varying(40),
    event_type_code character varying(40),
    transport_end_code character(1),
    command_seq_no integer,
    transport_code character varying(40),
    facility_code character varying(40),
    conveyor_id character varying(40),
    alternate_transport_flag character(1),
    alternate_storage_partition_id character varying(40),
    data_interface_type_code character(1)
) DISTRIBUTED BY (event_seq_no);


ALTER TABLE masdapdw.tb_fda_pdw_transport_event_h OWNER TO letl;

--
-- Name: tb_fda_pdw_transport_event_h_t; Type: TABLE; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE TABLE tb_fda_pdw_transport_event_h_t (
    factory_code character varying(40) NOT NULL,
    event_seq_no integer NOT NULL,
    creation_timestamp timestamp without time zone NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    eai_seq_id bigint NOT NULL,
    equipment_id character varying(40),
    port_id character varying(40),
    shelf_id character varying(40),
    cassette_id character varying(40),
    cassette_type_code character varying(40),
    lot_id character varying(40),
    process_code character varying(50),
    use_count double precision,
    final_destination_equipment_id character varying(40),
    final_destination_port_id character varying(40),
    event_name character varying(40),
    event_type_code character varying(40),
    transport_end_code character(1),
    command_seq_no integer,
    transport_code character varying(40),
    facility_code character varying(40),
    conveyor_id character varying(40),
    alternate_transport_flag character(1),
    alternate_storage_partition_id character varying(40),
    data_interface_type_code character(1)
) DISTRIBUTED BY (event_seq_no);


ALTER TABLE masdapdw.tb_fda_pdw_transport_event_h_t OWNER TO letl;

--
-- Name: equipment_group_id_bmp_idx; Type: INDEX; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE INDEX equipment_group_id_bmp_idx ON tb_fda_pdw_apd_detail USING bitmap (equipment_group_id);


--
-- Name: equipment_group_id_bmp_1; Type: INDEX; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE INDEX equipment_group_id_bmp_1 ON tb_fda_pdw_apd_h USING bitmap (equipment_group_id);


SET search_path = public, pg_catalog;

--
-- Name: sql_history2; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE sql_history2 (
    event_time timestamp with time zone,
    user_name text,
    database_name text,
    process_id text,
    thread_id text,
    remote_host text,
    remote_port text,
    session_start_time timestamp with time zone,
    transaction_id integer,
    gp_session_id text,
    gp_command_count text,
    gp_segment text,
    slice_id text,
    distr_tranx_id text,
    local_tranx_id text,
    sub_tranx_id text,
    error_severity text,
    sql_state_code text,
    error_message text,
    error_detail text,
    error_hint text,
    internal_query text,
    internal_query_pos integer,
    error_context text,
    debug_query_string text,
    error_cursor_pos integer,
    func_name text,
    file_name text,
    file_line integer,
    stack_trace text
) DISTRIBUTED BY (event_time);


ALTER TABLE public.sql_history2 OWNER TO gpadmin;

--
-- Name: tb_dda_inf_ea_def_cd_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_dda_inf_ea_def_cd_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_dda_inf_ea_def_cd_err OWNER TO gpadmin;

--
-- Name: tb_dda_inf_ea_user_profile_m_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_dda_inf_ea_user_profile_m_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_dda_inf_ea_user_profile_m_err OWNER TO gpadmin;

--
-- Name: tb_dda_inf_mg_model_m_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_dda_inf_mg_model_m_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_dda_inf_mg_model_m_err OWNER TO gpadmin;

--
-- Name: tb_dda_inf_mg_part_no_m_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_dda_inf_mg_part_no_m_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_dda_inf_mg_part_no_m_err OWNER TO gpadmin;

--
-- Name: tb_dda_inf_mg_worker_m_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_dda_inf_mg_worker_m_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_dda_inf_mg_worker_m_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_ea_apd_pre_prcs_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_apd_pre_prcs_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_ea_apd_pre_prcs_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_ea_def_cell_af_def_detail_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cell_af_def_detail_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_ea_def_cell_af_def_detail_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_ea_def_cell_af_def_h_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cell_af_def_h_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_ea_def_cell_af_def_h_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_ea_def_cell_af_pnl_h_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cell_af_pnl_h_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_ea_def_cell_af_pnl_h_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_ea_def_cell_bf_pnl_detail_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_ea_def_cell_bf_pnl_detail_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_ea_def_cf_def_detail_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cf_def_detail_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_ea_def_cf_def_detail_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_ea_def_cf_gls_detail_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cf_gls_detail_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_ea_def_cf_gls_detail_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_ea_def_cf_pnl_detail_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cf_pnl_detail_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_ea_def_cf_pnl_detail_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_ea_def_cot_judge_reason_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_cot_judge_reason_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_ea_def_cot_judge_reason_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_ea_def_tft_def_detail_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_tft_def_detail_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_ea_def_tft_def_detail_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_ea_def_tft_def_h_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_tft_def_h_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_ea_def_tft_def_h_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_ea_def_tft_gls_detail_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_tft_gls_detail_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_ea_def_tft_gls_detail_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_ea_def_tft_gls_h_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_tft_gls_h_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_ea_def_tft_gls_h_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_ea_def_tft_pnl_detail_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_ea_def_tft_pnl_detail_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_ea_def_tft_pnl_detail_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_mg_mod_insp_defect_h_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_mg_mod_insp_defect_h_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_mg_mod_insp_defect_h_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_mg_mod_prod_process_h_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_mg_mod_prod_process_h_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_mg_mod_prod_process_h_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_op_lot_history_p_i_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_op_lot_history_p_i_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_op_lot_history_p_i_err OWNER TO gpadmin;

--
-- Name: tb_fda_inf_op_product_history_p_i_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_inf_op_product_history_p_i_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_inf_op_product_history_p_i_err OWNER TO gpadmin;

--
-- Name: tb_fda_pdm_product_prog_insp_h_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_pdm_product_prog_insp_h_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_pdm_product_prog_insp_h_err OWNER TO gpadmin;

--
-- Name: tb_fda_pdw_gls_insp_detail_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_detail_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_pdw_gls_insp_detail_err OWNER TO gpadmin;

--
-- Name: tb_fda_pdw_gls_insp_pnl_detail_err; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_pnl_detail_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.tb_fda_pdw_gls_insp_pnl_detail_err OWNER TO gpadmin;

--
-- Name: tb_fda_pdw_gls_insp_pnl_detail_tst; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tb_fda_pdw_gls_insp_pnl_detail_tst (
    glass_id character varying(40) NOT NULL,
    glass_seq_no integer NOT NULL,
    glass_inspection_end_timestamp timestamp without time zone NOT NULL,
    factory_code character varying(40) NOT NULL,
    panel_id character varying(40) NOT NULL,
    panel_inspection_data_id character varying(40) NOT NULL,
    etl_insert_update_timestamp timestamp without time zone NOT NULL,
    character_data_value character varying(200),
    number_data_value double precision
) DISTRIBUTED BY (glass_id);


ALTER TABLE public.tb_fda_pdw_gls_insp_pnl_detail_tst OWNER TO gpadmin;

SET search_path = masdainf, pg_catalog;

--
-- Name: idx_tb_fda_inf_ea_apd_h_2; Type: INDEX; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE INDEX idx_tb_fda_inf_ea_apd_h_2 ON tb_fda_inf_ea_apd_h USING btree (etl_insert_update_timestamp);


--
-- Name: tb_fda_inf_ea_apd_detail_ix1; Type: INDEX; Schema: masdainf; Owner: letl; Tablespace: 
--

CREATE INDEX tb_fda_inf_ea_apd_detail_ix1 ON tb_fda_inf_ea_apd_detail USING btree (etl_insert_update_timestamp);


SET search_path = masdapdm, pg_catalog;

--
-- Name: idx_tb_fda_pdm_product_h_s_2; Type: INDEX; Schema: masdapdm; Owner: letl; Tablespace: 
--

CREATE INDEX idx_tb_fda_pdm_product_h_s_2 ON tb_fda_pdm_product_h_s USING btree (etl_insert_update_timestamp);


SET search_path = masdapdw, pg_catalog;

--
-- Name: idx_tb_fda_pdw_gls_insp_def_detail_01; Type: INDEX; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE INDEX idx_tb_fda_pdw_gls_insp_def_detail_01 ON tb_fda_pdw_gls_insp_def_detail USING btree (glass_id, glass_seq_no, glass_inspection_end_timestamp, panel_id, defect_seq_no, defect_inspection_data_id);


--
-- Name: idx_tb_fda_pdw_gls_insp_def_h_01; Type: INDEX; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE INDEX idx_tb_fda_pdw_gls_insp_def_h_01 ON tb_fda_pdw_gls_insp_def_h USING btree (glass_id, glass_seq_no, glass_inspection_end_timestamp, panel_id, defect_seq_no);


--
-- Name: idx_tb_fda_pdw_gls_insp_pnl_detail_01; Type: INDEX; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE INDEX idx_tb_fda_pdw_gls_insp_pnl_detail_01 ON tb_fda_pdw_gls_insp_pnl_detail USING btree (glass_id, glass_seq_no, glass_inspection_end_timestamp, panel_id, panel_inspection_data_id);


--
-- Name: idx_tb_fda_pdw_product_h_2; Type: INDEX; Schema: masdapdw; Owner: letl; Tablespace: 
--

CREATE INDEX idx_tb_fda_pdw_product_h_2 ON tb_fda_pdw_product_h USING btree (etl_insert_update_timestamp);


--
-- Name: com; Type: ACL; Schema: -; Owner: gpadmin
--

REVOKE ALL ON SCHEMA com FROM PUBLIC;
REVOKE ALL ON SCHEMA com FROM gpadmin;
GRANT ALL ON SCHEMA com TO gpadmin;
GRANT ALL ON SCHEMA com TO lolap;
GRANT ALL ON SCHEMA com TO loltp;
GRANT ALL ON SCHEMA com TO letl;
GRANT ALL ON SCHEMA com TO ladhoc;


--
-- Name: dba; Type: ACL; Schema: -; Owner: gpadmin
--

REVOKE ALL ON SCHEMA dba FROM PUBLIC;
REVOKE ALL ON SCHEMA dba FROM gpadmin;
GRANT ALL ON SCHEMA dba TO gpadmin;
GRANT ALL ON SCHEMA dba TO ladhoc;
GRANT ALL ON SCHEMA dba TO letl;
GRANT ALL ON SCHEMA dba TO lolap;
GRANT ALL ON SCHEMA dba TO loltp;


--
-- Name: masdacmn; Type: ACL; Schema: -; Owner: gpadmin
--

REVOKE ALL ON SCHEMA masdacmn FROM PUBLIC;
REVOKE ALL ON SCHEMA masdacmn FROM gpadmin;
GRANT ALL ON SCHEMA masdacmn TO gpadmin;
GRANT ALL ON SCHEMA masdacmn TO lolap;
GRANT ALL ON SCHEMA masdacmn TO loltp;
GRANT ALL ON SCHEMA masdacmn TO letl;
GRANT ALL ON SCHEMA masdacmn TO ladhoc;


--
-- Name: masdainf; Type: ACL; Schema: -; Owner: gpadmin
--

REVOKE ALL ON SCHEMA masdainf FROM PUBLIC;
REVOKE ALL ON SCHEMA masdainf FROM gpadmin;
GRANT ALL ON SCHEMA masdainf TO gpadmin;
GRANT ALL ON SCHEMA masdainf TO lolap;
GRANT ALL ON SCHEMA masdainf TO loltp;
GRANT ALL ON SCHEMA masdainf TO letl;
GRANT ALL ON SCHEMA masdainf TO ladhoc;


--
-- Name: masdapdm; Type: ACL; Schema: -; Owner: gpadmin
--

REVOKE ALL ON SCHEMA masdapdm FROM PUBLIC;
REVOKE ALL ON SCHEMA masdapdm FROM gpadmin;
GRANT ALL ON SCHEMA masdapdm TO gpadmin;
GRANT ALL ON SCHEMA masdapdm TO lolap;
GRANT ALL ON SCHEMA masdapdm TO loltp;
GRANT ALL ON SCHEMA masdapdm TO letl;
GRANT ALL ON SCHEMA masdapdm TO ladhoc;


--
-- Name: masdapdw; Type: ACL; Schema: -; Owner: gpadmin
--

REVOKE ALL ON SCHEMA masdapdw FROM PUBLIC;
REVOKE ALL ON SCHEMA masdapdw FROM gpadmin;
GRANT ALL ON SCHEMA masdapdw TO gpadmin;
GRANT ALL ON SCHEMA masdapdw TO lolap;
GRANT ALL ON SCHEMA masdapdw TO loltp;
GRANT ALL ON SCHEMA masdapdw TO letl;
GRANT ALL ON SCHEMA masdapdw TO ladhoc;


--
-- Name: public; Type: ACL; Schema: -; Owner: gpadmin
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM gpadmin;
GRANT ALL ON SCHEMA public TO gpadmin;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO ladhoc;
GRANT ALL ON SCHEMA public TO letl;
GRANT ALL ON SCHEMA public TO lolap;
GRANT ALL ON SCHEMA public TO loltp;


SET search_path = dba, pg_catalog;

--
-- Name: sql_history; Type: ACL; Schema: dba; Owner: gpadmin
--

REVOKE ALL ON TABLE sql_history FROM PUBLIC;
REVOKE ALL ON TABLE sql_history FROM gpadmin;
GRANT ALL ON TABLE sql_history TO gpadmin;
GRANT ALL ON TABLE sql_history TO ladhoc;
GRANT ALL ON TABLE sql_history TO letl;
GRANT ALL ON TABLE sql_history TO lolap;
GRANT ALL ON TABLE sql_history TO loltp;


--
-- Name: table_ddl; Type: ACL; Schema: dba; Owner: gpadmin
--

REVOKE ALL ON TABLE table_ddl FROM PUBLIC;
REVOKE ALL ON TABLE table_ddl FROM gpadmin;
GRANT ALL ON TABLE table_ddl TO gpadmin;
GRANT ALL ON TABLE table_ddl TO ladhoc;
GRANT ALL ON TABLE table_ddl TO letl;
GRANT ALL ON TABLE table_ddl TO lolap;
GRANT ALL ON TABLE table_ddl TO loltp;


SET search_path = masdacmn, pg_catalog;

--
-- Name: tb_dda_cmn_amc_specification_info; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_amc_specification_info FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_amc_specification_info FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_amc_specification_info TO letl;
GRANT ALL ON TABLE tb_dda_cmn_amc_specification_info TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_amc_specification_info TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_amc_specification_info TO loltp;


--
-- Name: tb_dda_cmn_apd_3d_chart_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_apd_3d_chart_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_apd_3d_chart_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_apd_3d_chart_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_apd_3d_chart_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_apd_3d_chart_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_apd_3d_chart_m TO loltp;


--
-- Name: tb_dda_cmn_apd_gr_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_apd_gr_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_apd_gr_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_apd_gr_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_apd_gr_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_apd_gr_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_apd_gr_m TO loltp;


--
-- Name: tb_dda_cmn_apd_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_apd_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_apd_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_apd_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_apd_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_apd_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_apd_m TO loltp;


--
-- Name: tb_dda_cmn_apd_path_cd; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_apd_path_cd FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_apd_path_cd FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_apd_path_cd TO letl;
GRANT ALL ON TABLE tb_dda_cmn_apd_path_cd TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_apd_path_cd TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_apd_path_cd TO loltp;


--
-- Name: tb_dda_cmn_cell_af_prcs_map_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_cell_af_prcs_map_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_cell_af_prcs_map_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_cell_af_prcs_map_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_cell_af_prcs_map_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_cell_af_prcs_map_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_cell_af_prcs_map_m TO loltp;


--
-- Name: tb_dda_cmn_condition_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_condition_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_condition_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_condition_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_condition_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_condition_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_condition_m TO loltp;


--
-- Name: tb_dda_cmn_contact_map_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_contact_map_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_contact_map_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_contact_map_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_contact_map_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_contact_map_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_contact_map_m TO loltp;


--
-- Name: tb_dda_cmn_def_cd; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_def_cd FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_def_cd FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_def_cd TO letl;
GRANT ALL ON TABLE tb_dda_cmn_def_cd TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_def_cd TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_def_cd TO loltp;


--
-- Name: tb_dda_cmn_def_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_def_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_def_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_def_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_def_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_def_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_def_m TO loltp;


--
-- Name: tb_dda_cmn_dms_specification_info; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_dms_specification_info FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_dms_specification_info FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_dms_specification_info TO letl;
GRANT ALL ON TABLE tb_dda_cmn_dms_specification_info TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_dms_specification_info TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_dms_specification_info TO loltp;


--
-- Name: tb_dda_cmn_ea_equipment_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_ea_equipment_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_ea_equipment_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_ea_equipment_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_ea_equipment_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_ea_equipment_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_ea_equipment_m TO loltp;


--
-- Name: tb_dda_cmn_ea_parts_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_ea_parts_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_ea_parts_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_ea_parts_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_ea_parts_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_ea_parts_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_ea_parts_m TO loltp;


--
-- Name: tb_dda_cmn_ea_process_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_ea_process_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_ea_process_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_ea_process_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_ea_process_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_ea_process_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_ea_process_m TO loltp;


--
-- Name: tb_dda_cmn_ea_user_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_ea_user_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_ea_user_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_ea_user_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_ea_user_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_ea_user_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_ea_user_m TO loltp;


--
-- Name: tb_dda_cmn_eas_cd; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_eas_cd FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_eas_cd FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_eas_cd TO letl;
GRANT ALL ON TABLE tb_dda_cmn_eas_cd TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_eas_cd TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_eas_cd TO loltp;


--
-- Name: tb_dda_cmn_equip_gr_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_equip_gr_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_equip_gr_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_equip_gr_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_equip_gr_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_equip_gr_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_equip_gr_m TO loltp;


--
-- Name: tb_dda_cmn_equipment_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_equipment_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_equipment_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_equipment_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_equipment_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_equipment_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_equipment_m TO loltp;


--
-- Name: tb_dda_cmn_etl_status; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_etl_status FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_etl_status FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_etl_status TO letl;
GRANT ALL ON TABLE tb_dda_cmn_etl_status TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_etl_status TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_etl_status TO loltp;


--
-- Name: tb_dda_cmn_general_cd; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_general_cd FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_general_cd FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_general_cd TO letl;
GRANT ALL ON TABLE tb_dda_cmn_general_cd TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_general_cd TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_general_cd TO loltp;


--
-- Name: tb_dda_cmn_judge_attr_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_judge_attr_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_judge_attr_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_judge_attr_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_judge_attr_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_judge_attr_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_judge_attr_m TO loltp;


--
-- Name: tb_dda_cmn_judge_cd_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_judge_cd_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_judge_cd_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_judge_cd_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_judge_cd_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_judge_cd_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_judge_cd_m TO loltp;


--
-- Name: tb_dda_cmn_mg_equipment_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_mg_equipment_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_mg_equipment_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_mg_equipment_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_mg_equipment_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_mg_equipment_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_mg_equipment_m TO loltp;


--
-- Name: tb_dda_cmn_mg_model_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_mg_model_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_mg_model_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_mg_model_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_mg_model_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_mg_model_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_mg_model_m TO loltp;


--
-- Name: tb_dda_cmn_mg_parts_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_mg_parts_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_mg_parts_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_mg_parts_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_mg_parts_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_mg_parts_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_mg_parts_m TO loltp;


--
-- Name: tb_dda_cmn_mg_process_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_mg_process_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_mg_process_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_mg_process_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_mg_process_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_mg_process_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_mg_process_m TO loltp;


--
-- Name: tb_dda_cmn_mg_user_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_mg_user_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_mg_user_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_mg_user_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_mg_user_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_mg_user_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_mg_user_m TO loltp;


--
-- Name: tb_dda_cmn_model_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_model_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_model_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_model_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_model_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_model_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_model_m TO loltp;


--
-- Name: tb_dda_cmn_multi_lang_dict_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_multi_lang_dict_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_multi_lang_dict_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_multi_lang_dict_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_multi_lang_dict_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_multi_lang_dict_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_multi_lang_dict_m TO loltp;


--
-- Name: tb_dda_cmn_panel_map_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_panel_map_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_panel_map_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_panel_map_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_panel_map_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_panel_map_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_panel_map_m TO loltp;


--
-- Name: tb_dda_cmn_parts_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_parts_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_parts_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_parts_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_parts_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_parts_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_parts_m TO loltp;


--
-- Name: tb_dda_cmn_process_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_process_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_process_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_process_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_process_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_process_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_process_m TO loltp;


--
-- Name: tb_dda_cmn_qlty_cd_field_item_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_qlty_cd_field_item_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_qlty_cd_field_item_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_field_item_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_field_item_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_field_item_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_field_item_m TO loltp;


--
-- Name: tb_dda_cmn_qlty_cd_field_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_qlty_cd_field_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_qlty_cd_field_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_field_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_field_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_field_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_field_m TO loltp;


--
-- Name: tb_dda_cmn_qlty_cd_field_seq_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_qlty_cd_field_seq_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_qlty_cd_field_seq_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_field_seq_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_field_seq_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_field_seq_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_field_seq_m TO loltp;


--
-- Name: tb_dda_cmn_qlty_cd_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_qlty_cd_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_qlty_cd_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_qlty_cd_m TO loltp;


--
-- Name: tb_dda_cmn_rel_prcs_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_rel_prcs_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_rel_prcs_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_rel_prcs_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_rel_prcs_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_rel_prcs_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_rel_prcs_m TO loltp;


--
-- Name: tb_dda_cmn_representative_def; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_representative_def FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_representative_def FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_representative_def TO letl;
GRANT ALL ON TABLE tb_dda_cmn_representative_def TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_representative_def TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_representative_def TO loltp;


--
-- Name: tb_dda_cmn_representative_def_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_representative_def_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_representative_def_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_representative_def_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_representative_def_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_representative_def_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_representative_def_m TO loltp;


--
-- Name: tb_dda_cmn_sdc2_def_cond_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_sdc2_def_cond_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_sdc2_def_cond_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_def_cond_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_def_cond_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_def_cond_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_def_cond_m TO loltp;


--
-- Name: tb_dda_cmn_sdc2_insp_data_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_sdc2_insp_data_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_sdc2_insp_data_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_insp_data_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_insp_data_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_insp_data_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_insp_data_m TO loltp;


--
-- Name: tb_dda_cmn_sdc2_judge_cond_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_sdc2_judge_cond_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_sdc2_judge_cond_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_judge_cond_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_judge_cond_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_judge_cond_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_judge_cond_m TO loltp;


--
-- Name: tb_dda_cmn_sdc2_spec_cont_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_sdc2_spec_cont_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_sdc2_spec_cont_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_spec_cont_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_spec_cont_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_spec_cont_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_spec_cont_m TO loltp;


--
-- Name: tb_dda_cmn_sdc2_spec_gr_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_sdc2_spec_gr_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_sdc2_spec_gr_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_spec_gr_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_spec_gr_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_spec_gr_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_spec_gr_m TO loltp;


--
-- Name: tb_dda_cmn_sdc2_spec_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_sdc2_spec_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_sdc2_spec_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_spec_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_spec_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_spec_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_sdc2_spec_m TO loltp;


--
-- Name: tb_dda_cmn_spc_apd_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_spc_apd_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_spc_apd_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_apd_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_apd_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_spc_apd_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_spc_apd_m TO loltp;


--
-- Name: tb_dda_cmn_spc_chart_info_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_spc_chart_info_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_spc_chart_info_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_chart_info_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_chart_info_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_spc_chart_info_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_spc_chart_info_m TO loltp;


--
-- Name: tb_dda_cmn_spc_chart_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_spc_chart_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_spc_chart_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_chart_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_chart_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_spc_chart_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_spc_chart_m TO loltp;


--
-- Name: tb_dda_cmn_spc_chart_raw_data_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_spc_chart_raw_data_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_spc_chart_raw_data_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_chart_raw_data_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_chart_raw_data_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_spc_chart_raw_data_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_spc_chart_raw_data_m TO loltp;


--
-- Name: tb_dda_cmn_spc_measr_equip_gr_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_spc_measr_equip_gr_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_spc_measr_equip_gr_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_measr_equip_gr_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_measr_equip_gr_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_spc_measr_equip_gr_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_spc_measr_equip_gr_m TO loltp;


--
-- Name: tb_dda_cmn_spc_prod_equip_gr_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_spc_prod_equip_gr_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_spc_prod_equip_gr_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_prod_equip_gr_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_prod_equip_gr_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_spc_prod_equip_gr_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_spc_prod_equip_gr_m TO loltp;


--
-- Name: tb_dda_cmn_spc_spec_cont_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_spc_spec_cont_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_spc_spec_cont_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_spec_cont_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_spec_cont_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_spc_spec_cont_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_spc_spec_cont_m TO loltp;


--
-- Name: tb_dda_cmn_spc_spec_gr_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_spc_spec_gr_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_spc_spec_gr_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_spec_gr_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_spec_gr_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_spc_spec_gr_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_spc_spec_gr_m TO loltp;


--
-- Name: tb_dda_cmn_spc_spec_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_spc_spec_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_spc_spec_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_spec_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_spc_spec_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_spc_spec_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_spc_spec_m TO loltp;


--
-- Name: tb_dda_cmn_tfo_policy_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_tfo_policy_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_tfo_policy_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_tfo_policy_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_tfo_policy_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_tfo_policy_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_tfo_policy_m TO loltp;


--
-- Name: tb_dda_cmn_tpfo_policy_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_tpfo_policy_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_tpfo_policy_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_tpfo_policy_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_tpfo_policy_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_tpfo_policy_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_tpfo_policy_m TO loltp;


--
-- Name: tb_dda_cmn_tpfom_policy_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_tpfom_policy_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_tpfom_policy_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_tpfom_policy_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_tpfom_policy_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_tpfom_policy_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_tpfom_policy_m TO loltp;


--
-- Name: tb_dda_cmn_user_def_gr_detail_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_user_def_gr_detail_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_user_def_gr_detail_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_user_def_gr_detail_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_user_def_gr_detail_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_user_def_gr_detail_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_user_def_gr_detail_m TO loltp;


--
-- Name: tb_dda_cmn_user_def_gr_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_user_def_gr_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_user_def_gr_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_user_def_gr_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_user_def_gr_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_user_def_gr_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_user_def_gr_m TO loltp;


--
-- Name: tb_dda_cmn_user_m; Type: ACL; Schema: masdacmn; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_cmn_user_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_cmn_user_m FROM letl;
GRANT ALL ON TABLE tb_dda_cmn_user_m TO letl;
GRANT ALL ON TABLE tb_dda_cmn_user_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_cmn_user_m TO lolap;
GRANT ALL ON TABLE tb_dda_cmn_user_m TO loltp;


SET search_path = masdainf, pg_catalog;

--
-- Name: tb_dda_inf_ea_def_cd; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_inf_ea_def_cd FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_inf_ea_def_cd FROM letl;
GRANT ALL ON TABLE tb_dda_inf_ea_def_cd TO letl;
GRANT ALL ON TABLE tb_dda_inf_ea_def_cd TO ladhoc;
GRANT ALL ON TABLE tb_dda_inf_ea_def_cd TO lolap;
GRANT ALL ON TABLE tb_dda_inf_ea_def_cd TO loltp;


--
-- Name: tb_dda_inf_ea_multi_lang_dict_m; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_inf_ea_multi_lang_dict_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_inf_ea_multi_lang_dict_m FROM letl;
GRANT ALL ON TABLE tb_dda_inf_ea_multi_lang_dict_m TO letl;
GRANT ALL ON TABLE tb_dda_inf_ea_multi_lang_dict_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_inf_ea_multi_lang_dict_m TO lolap;
GRANT ALL ON TABLE tb_dda_inf_ea_multi_lang_dict_m TO loltp;


--
-- Name: tb_dda_inf_ea_user_profile_m; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_inf_ea_user_profile_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_inf_ea_user_profile_m FROM letl;
GRANT ALL ON TABLE tb_dda_inf_ea_user_profile_m TO letl;
GRANT ALL ON TABLE tb_dda_inf_ea_user_profile_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_inf_ea_user_profile_m TO lolap;
GRANT ALL ON TABLE tb_dda_inf_ea_user_profile_m TO loltp;


--
-- Name: tb_dda_inf_mg_model_m; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_inf_mg_model_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_inf_mg_model_m FROM letl;
GRANT ALL ON TABLE tb_dda_inf_mg_model_m TO letl;
GRANT ALL ON TABLE tb_dda_inf_mg_model_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_inf_mg_model_m TO lolap;
GRANT ALL ON TABLE tb_dda_inf_mg_model_m TO loltp;


--
-- Name: tb_dda_inf_mg_part_no_m; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_inf_mg_part_no_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_inf_mg_part_no_m FROM letl;
GRANT ALL ON TABLE tb_dda_inf_mg_part_no_m TO letl;
GRANT ALL ON TABLE tb_dda_inf_mg_part_no_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_inf_mg_part_no_m TO lolap;
GRANT ALL ON TABLE tb_dda_inf_mg_part_no_m TO loltp;


--
-- Name: tb_dda_inf_mg_worker_m; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_dda_inf_mg_worker_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_inf_mg_worker_m FROM letl;
GRANT ALL ON TABLE tb_dda_inf_mg_worker_m TO letl;
GRANT ALL ON TABLE tb_dda_inf_mg_worker_m TO ladhoc;
GRANT ALL ON TABLE tb_dda_inf_mg_worker_m TO lolap;
GRANT ALL ON TABLE tb_dda_inf_mg_worker_m TO loltp;


--
-- Name: tb_fda_inf_ea_apd_detail; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_apd_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_apd_detail FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_detail TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_detail TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_detail TO loltp;


--
-- Name: tb_fda_inf_ea_apd_h; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_apd_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_apd_h FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_h TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_h TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_h TO loltp;


--
-- Name: tb_fda_inf_ea_apd_pre_prcs; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_apd_pre_prcs FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_apd_pre_prcs FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_pre_prcs TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_pre_prcs TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_pre_prcs TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_pre_prcs TO loltp;


--
-- Name: tb_fda_inf_ea_def_cell_af_def_detail; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_detail FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_detail TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_detail TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_detail TO loltp;


--
-- Name: tb_fda_inf_ea_def_cell_af_def_h; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_h FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_h TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_h TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_h TO loltp;


--
-- Name: tb_fda_inf_ea_def_cell_af_pnl_detail; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_detail FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_detail TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_detail TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_detail TO loltp;


--
-- Name: tb_fda_inf_ea_def_cell_af_pnl_h; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_h FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_h TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_h TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_h TO loltp;


--
-- Name: tb_fda_inf_ea_def_cell_bf_pnl_detail; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail TO loltp;


--
-- Name: tb_fda_inf_ea_def_cf_def_detail; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cf_def_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cf_def_detail FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_def_detail TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_def_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_def_detail TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_def_detail TO loltp;


--
-- Name: tb_fda_inf_ea_def_cf_def_h; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cf_def_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cf_def_h FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_def_h TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_def_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_def_h TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_def_h TO loltp;


--
-- Name: tb_fda_inf_ea_def_cf_gls_detail; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cf_gls_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cf_gls_detail FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_gls_detail TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_gls_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_gls_detail TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_gls_detail TO loltp;


--
-- Name: tb_fda_inf_ea_def_cf_pnl_detail; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cf_pnl_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cf_pnl_detail FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_pnl_detail TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_pnl_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_pnl_detail TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_pnl_detail TO loltp;


--
-- Name: tb_fda_inf_ea_def_cot_judge_reason; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cot_judge_reason FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cot_judge_reason FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cot_judge_reason TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cot_judge_reason TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cot_judge_reason TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cot_judge_reason TO loltp;


--
-- Name: tb_fda_inf_ea_def_tft_def_detail; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_def_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_def_detail FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_detail TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_detail TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_detail TO loltp;


--
-- Name: tb_fda_inf_ea_def_tft_def_h; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_def_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_def_h FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_h TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_h TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_h TO loltp;


--
-- Name: tb_fda_inf_ea_def_tft_gls_detail; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_gls_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_gls_detail FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_detail TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_detail TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_detail TO loltp;


--
-- Name: tb_fda_inf_ea_def_tft_gls_h; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_gls_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_gls_h FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_h TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_h TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_h TO loltp;


--
-- Name: tb_fda_inf_ea_def_tft_pnl_detail; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_pnl_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_pnl_detail FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_pnl_detail TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_pnl_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_pnl_detail TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_pnl_detail TO loltp;


--
-- Name: tb_fda_inf_ea_spc_point_h; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_ea_spc_point_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_spc_point_h FROM letl;
GRANT ALL ON TABLE tb_fda_inf_ea_spc_point_h TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_spc_point_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_spc_point_h TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_spc_point_h TO loltp;


--
-- Name: tb_fda_inf_mg_mod_insp_defect_h; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_mg_mod_insp_defect_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_mg_mod_insp_defect_h FROM letl;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_insp_defect_h TO letl;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_insp_defect_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_insp_defect_h TO lolap;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_insp_defect_h TO loltp;


--
-- Name: tb_fda_inf_mg_mod_prod_process_h; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_mg_mod_prod_process_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_mg_mod_prod_process_h FROM letl;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_prod_process_h TO letl;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_prod_process_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_prod_process_h TO lolap;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_prod_process_h TO loltp;


--
-- Name: tb_fda_inf_op_cmd_list_h_i; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_op_cmd_list_h_i FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_op_cmd_list_h_i FROM letl;
GRANT ALL ON TABLE tb_fda_inf_op_cmd_list_h_i TO letl;
GRANT ALL ON TABLE tb_fda_inf_op_cmd_list_h_i TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_op_cmd_list_h_i TO lolap;
GRANT ALL ON TABLE tb_fda_inf_op_cmd_list_h_i TO loltp;


--
-- Name: tb_fda_inf_op_lot_history_p_i; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_op_lot_history_p_i FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_op_lot_history_p_i FROM letl;
GRANT ALL ON TABLE tb_fda_inf_op_lot_history_p_i TO letl;
GRANT ALL ON TABLE tb_fda_inf_op_lot_history_p_i TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_op_lot_history_p_i TO lolap;
GRANT ALL ON TABLE tb_fda_inf_op_lot_history_p_i TO loltp;


--
-- Name: tb_fda_inf_op_product_history_p_i; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_op_product_history_p_i FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_op_product_history_p_i FROM letl;
GRANT ALL ON TABLE tb_fda_inf_op_product_history_p_i TO letl;
GRANT ALL ON TABLE tb_fda_inf_op_product_history_p_i TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_op_product_history_p_i TO lolap;
GRANT ALL ON TABLE tb_fda_inf_op_product_history_p_i TO loltp;


--
-- Name: tb_fda_inf_op_run_note; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_op_run_note FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_op_run_note FROM letl;
GRANT ALL ON TABLE tb_fda_inf_op_run_note TO letl;
GRANT ALL ON TABLE tb_fda_inf_op_run_note TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_op_run_note TO lolap;
GRANT ALL ON TABLE tb_fda_inf_op_run_note TO loltp;


--
-- Name: tb_fda_inf_op_transport_event_h_i; Type: ACL; Schema: masdainf; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_inf_op_transport_event_h_i FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_op_transport_event_h_i FROM letl;
GRANT ALL ON TABLE tb_fda_inf_op_transport_event_h_i TO letl;
GRANT ALL ON TABLE tb_fda_inf_op_transport_event_h_i TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_op_transport_event_h_i TO lolap;
GRANT ALL ON TABLE tb_fda_inf_op_transport_event_h_i TO loltp;


SET search_path = masdapdm, pg_catalog;

--
-- Name: tb_fda_pdm_product_equip_h; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdm_product_equip_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_equip_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdm_product_equip_h TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_equip_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_equip_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_equip_h TO loltp;


--
-- Name: tb_fda_pdm_product_m; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdm_product_m FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_m FROM letl;
GRANT ALL ON TABLE tb_fda_pdm_product_m TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_m TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_m TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_m TO loltp;


--
-- Name: tb_fda_pdm_product_prog_insp_h; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdm_product_prog_insp_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_prog_insp_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h TO loltp;


--
-- Name: nv_fda_pdm_product_prog_equip_insp_h; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE nv_fda_pdm_product_prog_equip_insp_h FROM PUBLIC;
REVOKE ALL ON TABLE nv_fda_pdm_product_prog_equip_insp_h FROM letl;
GRANT ALL ON TABLE nv_fda_pdm_product_prog_equip_insp_h TO letl;
GRANT ALL ON TABLE nv_fda_pdm_product_prog_equip_insp_h TO ladhoc;
GRANT ALL ON TABLE nv_fda_pdm_product_prog_equip_insp_h TO lolap;
GRANT ALL ON TABLE nv_fda_pdm_product_prog_equip_insp_h TO loltp;


--
-- Name: tb_fda_pdm_product_equip_h_b2; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdm_product_equip_h_b2 FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_equip_h_b2 FROM letl;
GRANT ALL ON TABLE tb_fda_pdm_product_equip_h_b2 TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_equip_h_b2 TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_equip_h_b2 TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_equip_h_b2 TO loltp;


--
-- Name: nv_fda_pdm_product_prog_equip_insp_h_b; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE nv_fda_pdm_product_prog_equip_insp_h_b FROM PUBLIC;
REVOKE ALL ON TABLE nv_fda_pdm_product_prog_equip_insp_h_b FROM letl;
GRANT ALL ON TABLE nv_fda_pdm_product_prog_equip_insp_h_b TO letl;
GRANT ALL ON TABLE nv_fda_pdm_product_prog_equip_insp_h_b TO ladhoc;
GRANT ALL ON TABLE nv_fda_pdm_product_prog_equip_insp_h_b TO lolap;
GRANT ALL ON TABLE nv_fda_pdm_product_prog_equip_insp_h_b TO loltp;


--
-- Name: tb_fda_pdm_product_h_s; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdm_product_h_s FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_h_s FROM letl;
GRANT ALL ON TABLE tb_fda_pdm_product_h_s TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_h_s TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_h_s TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_h_s TO loltp;


--
-- Name: tb_fda_pdm_product_h_s_t; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdm_product_h_s_t FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_h_s_t FROM letl;
GRANT ALL ON TABLE tb_fda_pdm_product_h_s_t TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_h_s_t TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_h_s_t TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_h_s_t TO loltp;


--
-- Name: tb_fda_pdm_product_h_s_t2; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdm_product_h_s_t2 FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_h_s_t2 FROM letl;
GRANT ALL ON TABLE tb_fda_pdm_product_h_s_t2 TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_h_s_t2 TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_h_s_t2 TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_h_s_t2 TO loltp;


--
-- Name: tb_fda_pdm_product_m_t1; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdm_product_m_t1 FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_m_t1 FROM letl;
GRANT ALL ON TABLE tb_fda_pdm_product_m_t1 TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_m_t1 TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_m_t1 TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_m_t1 TO loltp;


--
-- Name: tb_fda_pdm_product_m_t2; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdm_product_m_t2 FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_m_t2 FROM letl;
GRANT ALL ON TABLE tb_fda_pdm_product_m_t2 TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_m_t2 TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_m_t2 TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_m_t2 TO loltp;


--
-- Name: tb_fda_pdm_product_prog_insp_h_b; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdm_product_prog_insp_h_b FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_prog_insp_h_b FROM letl;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_b TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_b TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_b TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_b TO loltp;


--
-- Name: tb_fda_pdm_product_prog_insp_h_bk; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdm_product_prog_insp_h_bk FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_prog_insp_h_bk FROM letl;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_bk TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_bk TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_bk TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_bk TO loltp;


--
-- Name: tb_fda_pdm_product_prog_insp_h_t1; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t1 FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t1 FROM letl;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t1 TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t1 TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t1 TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t1 TO loltp;


--
-- Name: tb_fda_pdm_product_prog_insp_h_t2; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t2 FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t2 FROM letl;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t2 TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t2 TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t2 TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t2 TO loltp;


--
-- Name: tb_fda_pdm_product_prog_insp_h_t3; Type: ACL; Schema: masdapdm; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t3 FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t3 FROM letl;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t3 TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t3 TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t3 TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_t3 TO loltp;


SET search_path = masdapdw, pg_catalog;

--
-- Name: tb_fda_pdw_apd_detail; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_apd_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_apd_detail FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_apd_detail TO letl;
GRANT ALL ON TABLE tb_fda_pdw_apd_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_apd_detail TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_apd_detail TO loltp;


--
-- Name: tb_fda_pdw_apd_detail_bk; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_apd_detail_bk FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_apd_detail_bk FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_apd_detail_bk TO letl;
GRANT ALL ON TABLE tb_fda_pdw_apd_detail_bk TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_apd_detail_bk TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_apd_detail_bk TO loltp;


--
-- Name: tb_fda_pdw_apd_detail_t; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_apd_detail_t FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_apd_detail_t FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_apd_detail_t TO letl;
GRANT ALL ON TABLE tb_fda_pdw_apd_detail_t TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_apd_detail_t TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_apd_detail_t TO loltp;


--
-- Name: tb_fda_pdw_apd_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_apd_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_apd_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_apd_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_apd_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_apd_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_apd_h TO loltp;


--
-- Name: tb_fda_pdw_apd_pre_prcs; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_apd_pre_prcs FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_apd_pre_prcs FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_apd_pre_prcs TO letl;
GRANT ALL ON TABLE tb_fda_pdw_apd_pre_prcs TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_apd_pre_prcs TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_apd_pre_prcs TO loltp;


--
-- Name: tb_fda_pdw_ememo_file; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_ememo_file FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_ememo_file FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_ememo_file TO letl;
GRANT ALL ON TABLE tb_fda_pdw_ememo_file TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_ememo_file TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_ememo_file TO loltp;


--
-- Name: tb_fda_pdw_ememo_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_ememo_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_ememo_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_ememo_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_ememo_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_ememo_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_ememo_h TO loltp;


--
-- Name: tb_fda_pdw_ememo_lot; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_ememo_lot FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_ememo_lot FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_ememo_lot TO letl;
GRANT ALL ON TABLE tb_fda_pdw_ememo_lot TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_ememo_lot TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_ememo_lot TO loltp;


--
-- Name: tb_fda_pdw_equip_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_equip_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_equip_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_equip_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_equip_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_equip_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_equip_h TO loltp;


--
-- Name: tb_fda_pdw_equip_work_order_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_equip_work_order_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_equip_work_order_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_equip_work_order_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_equip_work_order_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_equip_work_order_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_equip_work_order_h TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_def_detail; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_def_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_def_detail FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_detail TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_detail TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_detail TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_def_detail_bk; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_def_detail_bk FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_def_detail_bk FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_detail_bk TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_detail_bk TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_detail_bk TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_detail_bk TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_def_detail_t; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_def_detail_t FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_def_detail_t FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_detail_t TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_detail_t TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_detail_t TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_detail_t TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_def_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_def_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_def_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_h TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_def_h_bk; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_def_h_bk FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_def_h_bk FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_h_bk TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_h_bk TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_h_bk TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_h_bk TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_def_h_t; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_def_h_t FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_def_h_t FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_h_t TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_h_t TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_h_t TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_h_t TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_def_img; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_def_img FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_def_img FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_img TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_img TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_img TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_def_img TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_detail; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_detail FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_detail_bk; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_detail_bk FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_detail_bk FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail_bk TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail_bk TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail_bk TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail_bk TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_detail_t; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_detail_t FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_detail_t FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail_t TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail_t TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail_t TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail_t TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_flag; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_flag FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_flag FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_flag TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_flag TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_flag TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_flag TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_h TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_pnl_detail; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_pnl_detail_bk; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_bk FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_bk FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_bk TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_bk TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_bk TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_bk TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_pnl_detail_t; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_t FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_t FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_t TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_t TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_t TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_t TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_pnl_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_pnl_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_pnl_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_h TO loltp;


--
-- Name: tb_fda_pdw_lot_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_lot_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_lot_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_lot_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_lot_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_lot_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_lot_h TO loltp;


--
-- Name: tb_fda_pdw_lot_h_t; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_lot_h_t FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_lot_h_t FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_lot_h_t TO letl;
GRANT ALL ON TABLE tb_fda_pdw_lot_h_t TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_lot_h_t TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_lot_h_t TO loltp;


--
-- Name: tb_fda_pdw_mod_product_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_mod_product_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_mod_product_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_mod_product_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_mod_product_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_mod_product_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_mod_product_h TO loltp;


--
-- Name: tb_fda_pdw_pnl_insp_def_detail; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_pnl_insp_def_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_pnl_insp_def_detail FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_def_detail TO letl;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_def_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_def_detail TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_def_detail TO loltp;


--
-- Name: tb_fda_pdw_pnl_insp_def_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_pnl_insp_def_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_pnl_insp_def_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_def_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_def_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_def_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_def_h TO loltp;


--
-- Name: tb_fda_pdw_pnl_insp_detail; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_pnl_insp_detail FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_pnl_insp_detail FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_detail TO letl;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_detail TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_detail TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_detail TO loltp;


--
-- Name: tb_fda_pdw_pnl_insp_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_pnl_insp_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_pnl_insp_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_h TO loltp;


--
-- Name: tb_fda_pdw_pnl_insp_h_t; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_pnl_insp_h_t FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_pnl_insp_h_t FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_h_t TO letl;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_h_t TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_h_t TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_pnl_insp_h_t TO loltp;


--
-- Name: tb_fda_pdw_product_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_product_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_product_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_product_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_product_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_product_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_product_h TO loltp;


--
-- Name: tb_fda_pdw_product_h_t; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_product_h_t FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_product_h_t FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_product_h_t TO letl;
GRANT ALL ON TABLE tb_fda_pdw_product_h_t TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_product_h_t TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_product_h_t TO loltp;


--
-- Name: tb_fda_pdw_recipe_change_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_recipe_change_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_recipe_change_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_recipe_change_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_recipe_change_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_recipe_change_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_recipe_change_h TO loltp;


--
-- Name: tb_fda_pdw_run_note; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_run_note FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_run_note FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_run_note TO letl;
GRANT ALL ON TABLE tb_fda_pdw_run_note TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_run_note TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_run_note TO loltp;


--
-- Name: tb_fda_pdw_spc_point_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_spc_point_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_spc_point_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_spc_point_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_spc_point_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_spc_point_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_spc_point_h TO loltp;


--
-- Name: tb_fda_pdw_transport_command_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_transport_command_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_transport_command_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_transport_command_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_transport_command_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_transport_command_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_transport_command_h TO loltp;


--
-- Name: tb_fda_pdw_transport_command_h_t; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_transport_command_h_t FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_transport_command_h_t FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_transport_command_h_t TO letl;
GRANT ALL ON TABLE tb_fda_pdw_transport_command_h_t TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_transport_command_h_t TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_transport_command_h_t TO loltp;


--
-- Name: tb_fda_pdw_transport_event_h; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_transport_event_h FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_transport_event_h FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_transport_event_h TO letl;
GRANT ALL ON TABLE tb_fda_pdw_transport_event_h TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_transport_event_h TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_transport_event_h TO loltp;


--
-- Name: tb_fda_pdw_transport_event_h_t; Type: ACL; Schema: masdapdw; Owner: letl
--

REVOKE ALL ON TABLE tb_fda_pdw_transport_event_h_t FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_transport_event_h_t FROM letl;
GRANT ALL ON TABLE tb_fda_pdw_transport_event_h_t TO letl;
GRANT ALL ON TABLE tb_fda_pdw_transport_event_h_t TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_transport_event_h_t TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_transport_event_h_t TO loltp;


SET search_path = public, pg_catalog;

--
-- Name: tb_dda_inf_ea_def_cd_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_dda_inf_ea_def_cd_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_inf_ea_def_cd_err FROM gpadmin;
GRANT ALL ON TABLE tb_dda_inf_ea_def_cd_err TO gpadmin;
GRANT ALL ON TABLE tb_dda_inf_ea_def_cd_err TO ladhoc;
GRANT ALL ON TABLE tb_dda_inf_ea_def_cd_err TO letl;
GRANT ALL ON TABLE tb_dda_inf_ea_def_cd_err TO lolap;
GRANT ALL ON TABLE tb_dda_inf_ea_def_cd_err TO loltp;


--
-- Name: tb_dda_inf_ea_user_profile_m_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_dda_inf_ea_user_profile_m_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_inf_ea_user_profile_m_err FROM gpadmin;
GRANT ALL ON TABLE tb_dda_inf_ea_user_profile_m_err TO gpadmin;
GRANT ALL ON TABLE tb_dda_inf_ea_user_profile_m_err TO ladhoc;
GRANT ALL ON TABLE tb_dda_inf_ea_user_profile_m_err TO letl;
GRANT ALL ON TABLE tb_dda_inf_ea_user_profile_m_err TO lolap;
GRANT ALL ON TABLE tb_dda_inf_ea_user_profile_m_err TO loltp;


--
-- Name: tb_dda_inf_mg_model_m_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_dda_inf_mg_model_m_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_inf_mg_model_m_err FROM gpadmin;
GRANT ALL ON TABLE tb_dda_inf_mg_model_m_err TO gpadmin;
GRANT ALL ON TABLE tb_dda_inf_mg_model_m_err TO ladhoc;
GRANT ALL ON TABLE tb_dda_inf_mg_model_m_err TO letl;
GRANT ALL ON TABLE tb_dda_inf_mg_model_m_err TO lolap;
GRANT ALL ON TABLE tb_dda_inf_mg_model_m_err TO loltp;


--
-- Name: tb_dda_inf_mg_part_no_m_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_dda_inf_mg_part_no_m_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_inf_mg_part_no_m_err FROM gpadmin;
GRANT ALL ON TABLE tb_dda_inf_mg_part_no_m_err TO gpadmin;
GRANT ALL ON TABLE tb_dda_inf_mg_part_no_m_err TO ladhoc;
GRANT ALL ON TABLE tb_dda_inf_mg_part_no_m_err TO letl;
GRANT ALL ON TABLE tb_dda_inf_mg_part_no_m_err TO lolap;
GRANT ALL ON TABLE tb_dda_inf_mg_part_no_m_err TO loltp;


--
-- Name: tb_dda_inf_mg_worker_m_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_dda_inf_mg_worker_m_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_dda_inf_mg_worker_m_err FROM gpadmin;
GRANT ALL ON TABLE tb_dda_inf_mg_worker_m_err TO gpadmin;
GRANT ALL ON TABLE tb_dda_inf_mg_worker_m_err TO ladhoc;
GRANT ALL ON TABLE tb_dda_inf_mg_worker_m_err TO letl;
GRANT ALL ON TABLE tb_dda_inf_mg_worker_m_err TO lolap;
GRANT ALL ON TABLE tb_dda_inf_mg_worker_m_err TO loltp;


--
-- Name: tb_fda_inf_ea_apd_pre_prcs_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_ea_apd_pre_prcs_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_apd_pre_prcs_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_pre_prcs_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_pre_prcs_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_pre_prcs_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_pre_prcs_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_apd_pre_prcs_err TO loltp;


--
-- Name: tb_fda_inf_ea_def_cell_af_def_detail_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_detail_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_detail_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_detail_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_detail_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_detail_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_detail_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_detail_err TO loltp;


--
-- Name: tb_fda_inf_ea_def_cell_af_def_h_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_h_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_h_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_h_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_h_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_h_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_h_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_def_h_err TO loltp;


--
-- Name: tb_fda_inf_ea_def_cell_af_pnl_h_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_h_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_h_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_h_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_h_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_h_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_h_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_af_pnl_h_err TO loltp;


--
-- Name: tb_fda_inf_ea_def_cell_bf_pnl_detail_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cell_bf_pnl_detail_err TO loltp;


--
-- Name: tb_fda_inf_ea_def_cf_def_detail_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cf_def_detail_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cf_def_detail_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_def_detail_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_def_detail_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_def_detail_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_def_detail_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_def_detail_err TO loltp;


--
-- Name: tb_fda_inf_ea_def_cf_gls_detail_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cf_gls_detail_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cf_gls_detail_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_gls_detail_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_gls_detail_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_gls_detail_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_gls_detail_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_gls_detail_err TO loltp;


--
-- Name: tb_fda_inf_ea_def_cf_pnl_detail_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cf_pnl_detail_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cf_pnl_detail_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_pnl_detail_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_pnl_detail_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_pnl_detail_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_pnl_detail_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cf_pnl_detail_err TO loltp;


--
-- Name: tb_fda_inf_ea_def_cot_judge_reason_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_cot_judge_reason_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_cot_judge_reason_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cot_judge_reason_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cot_judge_reason_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cot_judge_reason_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cot_judge_reason_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_cot_judge_reason_err TO loltp;


--
-- Name: tb_fda_inf_ea_def_tft_def_detail_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_def_detail_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_def_detail_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_detail_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_detail_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_detail_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_detail_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_detail_err TO loltp;


--
-- Name: tb_fda_inf_ea_def_tft_def_h_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_def_h_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_def_h_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_h_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_h_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_h_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_h_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_def_h_err TO loltp;


--
-- Name: tb_fda_inf_ea_def_tft_gls_detail_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_gls_detail_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_gls_detail_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_detail_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_detail_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_detail_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_detail_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_detail_err TO loltp;


--
-- Name: tb_fda_inf_ea_def_tft_gls_h_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_gls_h_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_gls_h_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_h_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_h_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_h_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_h_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_gls_h_err TO loltp;


--
-- Name: tb_fda_inf_ea_def_tft_pnl_detail_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_pnl_detail_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_ea_def_tft_pnl_detail_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_pnl_detail_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_pnl_detail_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_pnl_detail_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_pnl_detail_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_ea_def_tft_pnl_detail_err TO loltp;


--
-- Name: tb_fda_inf_mg_mod_insp_defect_h_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_mg_mod_insp_defect_h_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_mg_mod_insp_defect_h_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_insp_defect_h_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_insp_defect_h_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_insp_defect_h_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_insp_defect_h_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_insp_defect_h_err TO loltp;


--
-- Name: tb_fda_inf_mg_mod_prod_process_h_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_mg_mod_prod_process_h_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_mg_mod_prod_process_h_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_prod_process_h_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_prod_process_h_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_prod_process_h_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_prod_process_h_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_mg_mod_prod_process_h_err TO loltp;


--
-- Name: tb_fda_inf_op_lot_history_p_i_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_op_lot_history_p_i_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_op_lot_history_p_i_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_op_lot_history_p_i_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_op_lot_history_p_i_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_op_lot_history_p_i_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_op_lot_history_p_i_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_op_lot_history_p_i_err TO loltp;


--
-- Name: tb_fda_inf_op_product_history_p_i_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_inf_op_product_history_p_i_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_inf_op_product_history_p_i_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_inf_op_product_history_p_i_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_inf_op_product_history_p_i_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_inf_op_product_history_p_i_err TO letl;
GRANT ALL ON TABLE tb_fda_inf_op_product_history_p_i_err TO lolap;
GRANT ALL ON TABLE tb_fda_inf_op_product_history_p_i_err TO loltp;


--
-- Name: tb_fda_pdm_product_prog_insp_h_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_pdm_product_prog_insp_h_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdm_product_prog_insp_h_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_err TO letl;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_err TO lolap;
GRANT ALL ON TABLE tb_fda_pdm_product_prog_insp_h_err TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_detail_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_detail_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_detail_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail_err TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail_err TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_detail_err TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_pnl_detail_err; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_err FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_err FROM gpadmin;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_err TO gpadmin;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_err TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_err TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_err TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_err TO loltp;


--
-- Name: tb_fda_pdw_gls_insp_pnl_detail_tst; Type: ACL; Schema: public; Owner: gpadmin
--

REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_tst FROM PUBLIC;
REVOKE ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_tst FROM gpadmin;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_tst TO gpadmin;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_tst TO ladhoc;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_tst TO letl;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_tst TO lolap;
GRANT ALL ON TABLE tb_fda_pdw_gls_insp_pnl_detail_tst TO loltp;


--
-- Greenplum Database database dump complete
--

