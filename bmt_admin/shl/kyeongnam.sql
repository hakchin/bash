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
-- Name: oracompat; Type: SCHEMA; Schema: -; Owner: gpadmin
--

CREATE SCHEMA oracompat;


ALTER SCHEMA oracompat OWNER TO gpadmin;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: gpadmin
--

COMMENT ON SCHEMA public IS 'Standard public schema';


--
-- Name: sdmim; Type: SCHEMA; Schema: -; Owner: lcdc
--

CREATE SCHEMA sdmim;


ALTER SCHEMA sdmim OWNER TO lcdc;

--
-- Name: sdmin; Type: SCHEMA; Schema: -; Owner: letl
--

CREATE SCHEMA sdmin;


ALTER SCHEMA sdmin OWNER TO letl;

--
-- Name: sdmin_bak; Type: SCHEMA; Schema: -; Owner: letl
--

CREATE SCHEMA sdmin_bak;


ALTER SCHEMA sdmin_bak OWNER TO letl;

--
-- Name: sdmin_err; Type: SCHEMA; Schema: -; Owner: gpadmin
--

CREATE SCHEMA sdmin_err;


ALTER SCHEMA sdmin_err OWNER TO gpadmin;

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: gpadmin
--

CREATE PROCEDURAL LANGUAGE plpgsql;
ALTER FUNCTION plpgsql_call_handler() OWNER TO gpadmin;
ALTER FUNCTION plpgsql_validator(oid) OWNER TO gpadmin;


SET search_path = sdmin, pg_catalog;

--
-- Name: child_parent_level; Type: TYPE; Schema: sdmin; Owner: letl
--

CREATE TYPE child_parent_level AS (
	child text,
	parent text,
	lev integer
);


ALTER TYPE sdmin.child_parent_level OWNER TO letl;

SET search_path = oracompat, pg_catalog;

--
-- Name: add_months(date, integer); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION add_months(day date, value integer) RETURNS date
    AS '$libdir/orafunc', 'add_months'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION oracompat.add_months(day date, value integer) OWNER TO gpadmin;

--
-- Name: bitand(bigint, bigint); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION bitand(bigint, bigint) RETURNS bigint
    AS $_$ SELECT $1 & $2; $_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION oracompat.bitand(bigint, bigint) OWNER TO gpadmin;

--
-- Name: concat(text, text); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION concat(text, text) RETURNS text
    AS '$libdir/orafunc', 'ora_concat'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION oracompat.concat(text, text) OWNER TO gpadmin;

--
-- Name: concat(text, anyarray); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION concat(text, anyarray) RETURNS text
    AS $_$SELECT concat($1, $2::text)$_$
    LANGUAGE sql IMMUTABLE;


ALTER FUNCTION oracompat.concat(text, anyarray) OWNER TO gpadmin;

--
-- Name: concat(anyarray, text); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION concat(anyarray, text) RETURNS text
    AS $_$SELECT concat($1::text, $2)$_$
    LANGUAGE sql IMMUTABLE;


ALTER FUNCTION oracompat.concat(anyarray, text) OWNER TO gpadmin;

--
-- Name: concat(anyarray, anyarray); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION concat(anyarray, anyarray) RETURNS text
    AS $_$SELECT concat($1::text, $2::text)$_$
    LANGUAGE sql IMMUTABLE;


ALTER FUNCTION oracompat.concat(anyarray, anyarray) OWNER TO gpadmin;

--
-- Name: dump("any"); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION dump("any") RETURNS character varying
    AS '$libdir/orafunc', 'orafce_dump'
    LANGUAGE c;


ALTER FUNCTION oracompat.dump("any") OWNER TO gpadmin;

--
-- Name: dump("any", integer); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION dump("any", integer) RETURNS character varying
    AS '$libdir/orafunc', 'orafce_dump'
    LANGUAGE c;


ALTER FUNCTION oracompat.dump("any", integer) OWNER TO gpadmin;

--
-- Name: instr(text, text, integer, integer); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION instr(str text, patt text, start integer, nth integer) RETURNS integer
    AS '$libdir/orafunc', 'plvstr_instr4'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION oracompat.instr(str text, patt text, start integer, nth integer) OWNER TO gpadmin;

--
-- Name: instr(text, text, integer); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION instr(str text, patt text, start integer) RETURNS integer
    AS '$libdir/orafunc', 'plvstr_instr3'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION oracompat.instr(str text, patt text, start integer) OWNER TO gpadmin;

--
-- Name: instr(text, text); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION instr(str text, patt text) RETURNS integer
    AS '$libdir/orafunc', 'plvstr_instr2'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION oracompat.instr(str text, patt text) OWNER TO gpadmin;

--
-- Name: last_day(date); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION last_day(value date) RETURNS date
    AS '$libdir/orafunc', 'last_day'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION oracompat.last_day(value date) OWNER TO gpadmin;

--
-- Name: listagg1_transfn(text, text); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION listagg1_transfn(text, text) RETURNS text
    AS '$libdir/orafunc', 'orafce_listagg1_transfn'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION oracompat.listagg1_transfn(text, text) OWNER TO gpadmin;

--
-- Name: listagg2_transfn(text, text, text); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION listagg2_transfn(text, text, text) RETURNS text
    AS '$libdir/orafunc', 'orafce_listagg2_transfn'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION oracompat.listagg2_transfn(text, text, text) OWNER TO gpadmin;

--
-- Name: lnnvl(boolean); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION lnnvl(boolean) RETURNS boolean
    AS '$libdir/orafunc', 'ora_lnnvl'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION oracompat.lnnvl(boolean) OWNER TO gpadmin;

--
-- Name: months_between(date, date); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION months_between(date1 date, date2 date) RETURNS numeric
    AS '$libdir/orafunc', 'months_between'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION oracompat.months_between(date1 date, date2 date) OWNER TO gpadmin;

--
-- Name: nanvl(real, real); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION nanvl(real, real) RETURNS real
    AS $_$ SELECT CASE WHEN $1 = 'NaN' THEN $2 ELSE $1 END; $_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION oracompat.nanvl(real, real) OWNER TO gpadmin;

--
-- Name: nanvl(double precision, double precision); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION nanvl(double precision, double precision) RETURNS double precision
    AS $_$ SELECT CASE WHEN $1 = 'NaN' THEN $2 ELSE $1 END; $_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION oracompat.nanvl(double precision, double precision) OWNER TO gpadmin;

--
-- Name: nanvl(numeric, numeric); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION nanvl(numeric, numeric) RETURNS numeric
    AS $_$ SELECT CASE WHEN $1 = 'NaN' THEN $2 ELSE $1 END; $_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION oracompat.nanvl(numeric, numeric) OWNER TO gpadmin;

--
-- Name: next_day(date, text); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION next_day(value date, weekday text) RETURNS date
    AS '$libdir/orafunc', 'next_day'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION oracompat.next_day(value date, weekday text) OWNER TO gpadmin;

--
-- Name: next_day(date, integer); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION next_day(value date, weekday integer) RETURNS date
    AS '$libdir/orafunc', 'next_day_by_index'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION oracompat.next_day(value date, weekday integer) OWNER TO gpadmin;

--
-- Name: nlssort(text, text); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION nlssort(text, text) RETURNS bytea
    AS '$libdir/orafunc', 'ora_nlssort'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION oracompat.nlssort(text, text) OWNER TO gpadmin;

--
-- Name: nvl(anyelement, anyelement); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION nvl(anyelement, anyelement) RETURNS anyelement
    AS '$libdir/orafunc', 'ora_nvl'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION oracompat.nvl(anyelement, anyelement) OWNER TO gpadmin;

--
-- Name: nvl2(anyelement, anyelement, anyelement); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION nvl2(anyelement, anyelement, anyelement) RETURNS anyelement
    AS '$libdir/orafunc', 'ora_nvl2'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION oracompat.nvl2(anyelement, anyelement, anyelement) OWNER TO gpadmin;

--
-- Name: reverse(text, integer, integer); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION reverse(str text, start integer, _end integer) RETURNS text
    AS '$libdir/orafunc', 'plvstr_rvrs'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION oracompat.reverse(str text, start integer, _end integer) OWNER TO gpadmin;

--
-- Name: reverse(text, integer); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION reverse(str text, start integer) RETURNS text
    AS $_$ SELECT reverse($1,$2,NULL);$_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION oracompat.reverse(str text, start integer) OWNER TO gpadmin;

--
-- Name: reverse(text); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION reverse(str text) RETURNS text
    AS $_$ SELECT reverse($1,1,NULL);$_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION oracompat.reverse(str text) OWNER TO gpadmin;

--
-- Name: round(timestamp with time zone, text); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION round(value timestamp with time zone, fmt text) RETURNS timestamp with time zone
    AS '$libdir/orafunc', 'ora_timestamptz_round'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION oracompat.round(value timestamp with time zone, fmt text) OWNER TO gpadmin;

--
-- Name: round(timestamp with time zone); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION round(value timestamp with time zone) RETURNS timestamp with time zone
    AS $_$ SELECT round($1, 'DDD'); $_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION oracompat.round(value timestamp with time zone) OWNER TO gpadmin;

--
-- Name: round(date, text); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION round(value date, fmt text) RETURNS date
    AS '$libdir/orafunc', 'ora_date_round'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION oracompat.round(value date, fmt text) OWNER TO gpadmin;

--
-- Name: round(date); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION round(value date) RETURNS date
    AS $_$ SELECT $1; $_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION oracompat.round(value date) OWNER TO gpadmin;

--
-- Name: substr(text, integer); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION substr(str text, start integer) RETURNS text
    AS '$libdir/orafunc', 'oracle_substr2'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION oracompat.substr(str text, start integer) OWNER TO gpadmin;

--
-- Name: substr(text, integer, integer); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION substr(str text, start integer, len integer) RETURNS text
    AS '$libdir/orafunc', 'oracle_substr3'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION oracompat.substr(str text, start integer, len integer) OWNER TO gpadmin;

--
-- Name: trunc(timestamp with time zone, text); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION trunc(value timestamp with time zone, fmt text) RETURNS timestamp with time zone
    AS '$libdir/orafunc', 'ora_timestamptz_trunc'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION oracompat.trunc(value timestamp with time zone, fmt text) OWNER TO gpadmin;

--
-- Name: trunc(timestamp with time zone); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION trunc(value timestamp with time zone) RETURNS timestamp with time zone
    AS $_$ SELECT trunc($1, 'DDD'); $_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION oracompat.trunc(value timestamp with time zone) OWNER TO gpadmin;

--
-- Name: trunc(date, text); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION trunc(value date, fmt text) RETURNS date
    AS '$libdir/orafunc', 'ora_date_trunc'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION oracompat.trunc(value date, fmt text) OWNER TO gpadmin;

--
-- Name: trunc(date); Type: FUNCTION; Schema: oracompat; Owner: gpadmin
--

CREATE FUNCTION trunc(value date) RETURNS date
    AS $_$ SELECT $1; $_$
    LANGUAGE sql IMMUTABLE STRICT;


ALTER FUNCTION oracompat.trunc(value date) OWNER TO gpadmin;

SET search_path = public, pg_catalog;

--
-- Name: fn_attrep_apply_changes_2(text); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION fn_attrep_apply_changes_2(table_name text) RETURNS void
    AS $$ DECLARE  	stmt RECORD;     v_row_count	INTEGER;        v_operation VARCHAR; 	v_delete_position INTEGER; 	v_update_position INTEGER;     v_select_stmt TEXT;	BEGIN 	    v_select_stmt = 'SELECT * FROM ' || table_name; 	FOR stmt IN EXECUTE v_select_stmt LOOP  		EXECUTE stmt.statement;         GET DIAGNOSTICS v_row_count := ROW_COUNT; 		IF v_row_count = 0 THEN           v_operation := substring(stmt.statement from 0 for 7); 		  v_delete_position := position('DELETE' in v_operation); 		  v_update_position := position('UPDATE' in v_operation); 		  IF v_delete_position <> 0 OR v_update_position <> 0 THEN 			RAISE EXCEPTION '0 rows affected'; 		  END IF; 		END IF; 	END LOOP; 	END $$
    LANGUAGE plpgsql;


ALTER FUNCTION public.fn_attrep_apply_changes_2(table_name text) OWNER TO gpadmin;

--
-- Name: fn_attrep_text2bool(text); Type: FUNCTION; Schema: public; Owner: lcdc
--

CREATE FUNCTION fn_attrep_text2bool(text) RETURNS boolean
    AS $_$             DECLARE         b bool;         BEGIN         IF $1 is NULL THEN         RETURN NULL;         END IF;		IF $1 = '1' THEN 		return true; 		ELSE 		return false; 		END IF;         END         $_$
    LANGUAGE plpgsql;


ALTER FUNCTION public.fn_attrep_text2bool(text) OWNER TO lcdc;

--
-- Name: fn_attrep_text2bytea(text); Type: FUNCTION; Schema: public; Owner: lcdc
--

CREATE FUNCTION fn_attrep_text2bytea(text) RETURNS bytea
    AS $_$             DECLARE         b bytea;         BEGIN         IF $1 is NULL THEN         RETURN NULL;         END IF;         EXECUTE 'SELECT ' || quote_literal($1) || '::bytea' INTO b;         RETURN b;         END         $_$
    LANGUAGE plpgsql;


ALTER FUNCTION public.fn_attrep_text2bytea(text) OWNER TO lcdc;

SET search_path = sdmin, pg_catalog;

--
-- Name: acnm(character varying); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION acnm(i_accd character varying) RETURNS character varying
    AS $$
DECLARE
  v_acname   VARCHAR(50);
BEGIN
    SELECT aacfname
    INTO v_acname
    FROM acnt_ac_code
    WHERE aacpaccd = i_accd;
  RETURN(v_acname);
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.acnm(i_accd character varying) OWNER TO letl;

--
-- Name: aftdt(character varying); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION aftdt(i_date character varying) RETURNS character varying
    AS $$
declare
  v_befdt   VARCHAR(8);
  v_curdt   DATE;
  v_ck      numeric;
BEGIN
    SELECT TO_DATE(i_date,'YYYYMMDD')
    INTO v_curdt;


  LOOP
    SELECT v_curdt + 1
    INTO v_curdt;

    if (v_curdt >= to_date('20020701','YYYYMMDD')) then
     SELECT DECODE(TO_CHAR(v_curdt,'D'),'1',1,'7',1,0)
     INTO v_ck;

    else
     SELECT DECODE(TO_CHAR(v_curdt,'D'),'1',1,0)
     INTO v_ck;

    end if;

    IF (v_ck = 0) THEN
      SELECT count(*)
      INTO v_ck
      FROM ACNT_HO_LIDAY
      WHERE (AHOYEAR = '9999' AND AHODATE = TO_CHAR(v_curdt,'MMDD')) or
      (AHOYEAR = TO_CHAR(v_curdt,'YYYY') AND AHODATE = to_char(v_curdt,'MMDD'));


    END IF;
    EXIT WHEN v_ck = 0;
  END LOOP;

  SELECT TO_CHAR(v_curdt,'YYYYMMDD')
  INTO v_befdt;
  RETURN(v_befdt);

END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.aftdt(i_date character varying) OWNER TO letl;

--
-- Name: befdt(character); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION befdt(i_date character) RETURNS character
    AS $$
declare

  v_befdt   CHAR(8);
  v_curdt   DATE;
  v_ck      numeric;
BEGIN
 -- i_date  := TO_CHAR(current_timestamp,'YYYYMMDD');
    SELECT TO_DATE(i_date,'YYYYMMDD')
    INTO v_curdt;
  

  LOOP
    SELECT v_curdt - 1
    INTO v_curdt;


    if (v_curdt >= to_date('20020701','YYYYMMDD')) then
     SELECT DECODE(TO_CHAR(v_curdt,'D'),'1',1,'7',1,0)
     INTO v_ck;

    else
     SELECT DECODE(TO_CHAR(v_curdt,'D'),'1',1,0)
     INTO v_ck;

    end if;

    IF (v_ck = 0) THEN
      SELECT count(*)
      INTO v_ck
      FROM ACNT_HO_LIDAY
      WHERE (AHOYEAR = '9999' AND AHODATE = TO_CHAR(v_curdt,'MMDD')) or
      (AHOYEAR = TO_CHAR(v_curdt,'YYYY') AND AHODATE = to_char(v_curdt,'MMDD'));

    END IF;
    EXIT WHEN v_ck = 0;
  END LOOP;
  SELECT TO_CHAR(v_curdt,'YYYYMMDD')
  INTO v_befdt;
  RETURN(v_befdt);

  EXCEPTION
   WHEN OTHERS THEN
    SELECT TO_CHAR(v_curdt,'YYYYMMDD')
    INTO v_befdt
    ;
    RETURN(v_befdt);
    
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.befdt(i_date character) OWNER TO letl;

--
-- Name: befdt_old(character varying); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION befdt_old(i_date character varying) RETURNS character
    AS $$ 

DECLARE
  /*===========================================================**/
  /*  !!!!!작업시 확인 해야하는 사항                           -*/
  /*===========================================================**/
  /* 계정평잔과 일치시키기 위한 수신 계좌별 평잔 작업          **/
  /* - 수신은 토요일 I1으로 처리되고 계정은 익일자로 처리      **/
  /*   되기 때문에 평잔 불일치 사항 발생                       **/
  /* - 관리회계에 사용시 계정평잔과 일치해야 함                **/
  /**************************************************************/

  v_befdt   CHAR(8);
  v_curdt   DATE;
  v_ck      numeric;
  v_date    character varying(8);
  v_len     numeric;
BEGIN 

        v_date := i_date;

	if i_date is null then
		v_date := TO_CHAR(CURRENT_DATE,'YYYYMMDD');
	end if;

	v_len := length(v_date);

	if v_len = 0 then
		v_date := TO_CHAR(CURRENT_DATE,'YYYYMMDD');
	end if;


    v_curdt := TO_DATE(v_date,'YYYYMMDD');


      LOOP
        v_curdt := v_curdt - 1;
    
         v_ck := DECODE(TO_CHAR(v_curdt,'D'),'1',1,0);
    
        IF (v_ck = 0) THEN
          SELECT count(*)
          INTO v_ck
          FROM ACNT_HO_LIDAY
          WHERE (AHOYEAR = '9999' AND AHODATE = TO_CHAR(v_curdt,'MMDD')) or
          (AHOYEAR = TO_CHAR(v_curdt,'YYYY') AND AHODATE = to_char(v_curdt,'MMDD'));
    
        END IF;
        EXIT WHEN v_ck = 0;
      END LOOP;

      v_befdt := TO_CHAR(v_curdt,'YYYYMMDD');

      RETURN v_befdt;

END; 
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.befdt_old(i_date character varying) OWNER TO letl;

--
-- Name: brheadcd(character varying); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION brheadcd(i_brno character varying) RETURNS character varying
    AS $$
DECLARE
  o_headcd		VARCHAR(3);
BEGIN
	SELECT zbrheadcd
	INTO o_headcd
	FROM comm_br_brch
	WHERE zbrbrcd = i_brcd;

	RETURN o_headcd;
	
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.brheadcd(i_brno character varying) OWNER TO letl;

--
-- Name: brnm(character); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION brnm(i_brno character) RETURNS character varying
    AS $$
DECLARE
  v_brname   VARCHAR(20);
BEGIN
  IF i_brno='181' THEN v_brname := '경남ITS팀';
  ELSIF i_brno='182' THEN v_brname := '전산기획실SMM';
  ELSIF i_brno='818' THEN v_brname := '퇴직자실';
  ELSIF i_brno='889' THEN v_brname := '휴직자실';
  ELSIF i_brno IS NOT NULL THEN
    SELECT ZBRKORNM1
    INTO v_brname
    FROM comm_br_brch
    WHERE zbrbrcd = i_brno;
  END IF ;
  RETURN(v_brname);
	
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.brnm(i_brno character) OWNER TO letl;

--
-- Name: clobrck(character); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION clobrck(v_brno character) RETURNS character
    AS $$
DECLARE
  rt_brno CHARACTER(3);
BEGIN
/*********************************************************/
/* owner : BMT.clobrck                                */
/*   - 2004.8.6조직개편으로 13지점 폐쇄                   */
/*   - 2005.7.22. 하대동(610)폐쇄 - 진주동(525) 수관      */
/*   - 2008.12.24.                                       */
/*   내외기업금융(694)+내외동->내외동(613)                */
/*   중리기업금융(708)+중리->중리(585)                    */
/*   울산기업영업부(709)+울산영업부->울산영업부(540)       */
/*   창원기업영업부(691)+창원영업부->창원영업부(508)       */
/*  - 2009.03.30                                         */ 
/*   (폐쇄적용일자:2009.03.28)                            */
/*   구미지점(665) ,643,573-> 구미공단지점(697)           */
/*   신안동지점(561) 602  --> 평거동지점(568)             */
/*   신촌동지점(553)  ----> 월림공단지점(712)             */
/*    전포동지점(575)  ----> 서면지점(701)                */
/*    2010.07.01.                                   */
/*    마산시청지점(552)  ----> 창원시청지점(587)                */
/*    회원구청출 583 -> 552 -> 587 으로 변경            */
/*    2012.09.03.            */
/* 월림공단지점(712) 폐쇄 : 2012.08.31/ 업무마감후 폐쇄  */
/*  웅남기업금융지점(734)으로 통합 : 2012.09.03   */
/*********************************************************/
    IF LENGTH(v_brno) <> 3 THEN    /* 점번이 3자리인지 체크 */
        RETURN NULL;
    END IF;
/*
    IF v_brno IN ('020','030','040') THEN
        rt_brno := '110';
    ELSIF v_brno IN ('533','569') THEN
        rt_brno := '502';
    ELSIF v_brno IN ('579') THEN
        rt_brno := '511';
    ELSIF v_brno IN ('507','636') THEN
        rt_brno := '513';
    ELSIF v_brno IN ('652') THEN
        rt_brno := '514';
    ELSIF v_brno IN ('594','655','659','672') THEN
        rt_brno := '515';
    ELSIF v_brno IN ('567') THEN
        rt_brno := '516';
    ELSIF v_brno IN ('645') THEN
        rt_brno := '519';
    ELSIF v_brno IN ('635') THEN
        rt_brno := '523';
    ELSIF v_brno IN ('620','663') THEN
        rt_brno := '524';
    ELSIF v_brno IN ('610','644','651') THEN
        rt_brno := '525';
    ELSIF v_brno IN ('545') THEN
        rt_brno := '527';
    ELSIF v_brno IN ('666') THEN
        rt_brno := '529';
    ELSIF v_brno IN ('611') THEN
        rt_brno := '530';
    ELSIF v_brno IN ('627') THEN
        rt_brno := '531';
    ELSIF v_brno IN ('598','669') THEN
        rt_brno := '532';
    ELSIF v_brno IN ('546','565') THEN
        rt_brno := '534';
    ELSIF v_brno IN ('628') THEN
        rt_brno := '535';
    ELSIF v_brno IN ('618','631') THEN
        rt_brno := '539';
    ELSIF v_brno IN ('557','559','616') THEN
        rt_brno := '540';
    ELSIF v_brno IN ('562') THEN
        rt_brno := '542';
    ELSIF v_brno IN ('615') THEN
        rt_brno := '544';
    ELSIF v_brno IN ('586') THEN
        rt_brno := '551';
    ELSIF v_brno IN ('583') THEN
        rt_brno := '552';
    ELSIF v_brno IN ('602') THEN
        rt_brno := '561';
    ELSIF v_brno IN ('521') THEN
        rt_brno := '563';
    ELSIF v_brno IN ('621','633','639','649','653','654') THEN
        rt_brno := '572';
    ELSIF v_brno IN ('660') THEN
        rt_brno := '574';
    ELSIF v_brno IN ('647') THEN
        rt_brno := '576';
    ELSIF v_brno IN ('541') THEN
        rt_brno := '578';
    ELSIF v_brno IN ('630') THEN
        rt_brno := '584';
    ELSIF v_brno IN ('658','664') THEN
        rt_brno := '588';
    ELSIF v_brno IN ('504','505') THEN
        rt_brno := '593';
    ELSIF v_brno IN ('656','657') THEN
        rt_brno := '596';
    ELSIF v_brno IN ('608') THEN
        rt_brno := '605';
    ELSIF v_brno IN ('642') THEN
        rt_brno := '609';
    ELSIF v_brno IN ('577','637') THEN
        rt_brno := '612';
    ELSIF v_brno IN ('661') THEN
        rt_brno := '613';
    ELSIF v_brno IN ('589') THEN
        rt_brno := '617';
    ELSIF v_brno IN ('662') THEN
        rt_brno := '619';
    ELSIF v_brno IN ('573','643') THEN
        rt_brno := '665';
    ELSIF v_brno IN ('590') THEN
        rt_brno := '673';
    ELSE
        rt_brno := v_brno;
    END IF;
*/
    SELECT  DECODE(v_brno,
                   '642','609','618','539','631','539',
                   '586','551','627','531','628','535',
                   '630','584','647','576','658','588',
                   '639','572','652','514','643','697',
                   '662','619','664','588','637','612',
                   '589','617','020','110','594','515',
                   '621','572','633','572','644','525',
                   '653','572','654','572','655','515',
                   '657','596','636','513','583','587',
                   '660','574','541','578','557','540',
                   '559','540','598','532','645','519',
                   '649','572','672','515','030','110',
                   '040','110','573','697','545','527',
                   '602','568','620','524','567','516',
                   '659','515','666','529','611','530',
                   '504','593','505','593','577','612',
                   '663','524','521','563','533','502',
                   '546','534','565','534','569','502',
                   '615','544','651','525','656','596',
                   '507','513','579','511','635','523',
                   '590','673','608','605','610','525',
                   '616','540','562','542','661','613',
                   '669','532','512','510','550','511',
                   '580','619','694','613','708','585',
                   '709','540','691','508','665','697',
                   '561','568','553','734','575','701',
                   '552','587','013','060',
                   '132','131','133','130','134','130',
                   '135','130','712','734',v_brno)
      INTO  rt_brno
      ;

    RETURN (rt_brno);
	
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.clobrck(v_brno character) OWNER TO letl;

--
-- Name: connectbya(text, text, text, text); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION connectbya(tablename text, root_key text, connect_key text, condition text) RETURNS SETOF child_parent_level
    AS $$
DECLARE
  v_sql text;
  v_table_name text;
  v_condition text;
  node1 RECORD;
  tmp text;
  result int;
  v_lev int;
  v_istable int;
  --v_relnamespace int;
  v_sess_id text;


  ls_child_parent_level child_parent_level%rowtype;

  
BEGIN
	 select pg_backend_pid() into v_sess_id;
	 v_table_name := 'temp_' || tablename || v_sess_id;
	 select count(*) into v_istable from pg_class where relname = v_table_name ;	

	if condition is null then
		v_condition := root_key || ' is null';
	else
		v_condition := root_key || '=''' || condition || '''';
	end if;
	 
	if v_istable = 0 then
		execute 'create temp table ' || v_table_name || ' as ' ||
		' select 1 as lev, ' || connect_key || ' as connect_key, c.* from acnt_ac_code c ' ||
		' WHERE  ' || v_condition ||
		' distributed by (lev)	 ';
	else 
		execute 'truncate ' || v_table_name;
		execute 'insert into ' || v_table_name ||
		' select 1 as lev, c.' || connect_key || ' as connect_key, c.* from acnt_ac_code c' ||
		' WHERE ' || v_condition;
	end if;
	result := 1;
	v_lev := 1;
	WHILE result >= 1 LOOP	
		select connectbya2(v_lev, tablename,  v_table_name, root_key, connect_key) into result;
		v_lev := v_lev + 1;
	END LOOP;

--         execute 'truncate temp_acnt_ac_code';
--         execute 'insert into temp_acnt_ac_code select coa_cd, higrk_coa_cd, lev from ' || v_table_name ;
         
-- 	FOR node1 IN  execute 'SELECT * FROM ' || v_table_name || ' order by connect_key'
-- 	LOOP
-- 	  RETURN NEXT node1;
-- 	END LOOP;
	
	FOR NODE1 IN  execute 'SELECT * FROM ' || v_table_name || ' order by connect_key'
	LOOP
	   ls_child_parent_level.child = node1.aacpaccd;
	   ls_child_parent_level.parent = node1.aacuaccd;
	   ls_child_parent_level.lev = node1.lev;
	   return next ls_child_parent_level;
	END LOOP;

END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.connectbya(tablename text, root_key text, connect_key text, condition text) OWNER TO letl;

--
-- Name: connectbya2(integer, text, text, text, text); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION connectbya2(priolev integer, tablename text, v_table_name text, root_key text, connect_key text) RETURNS integer
    AS $$
DECLARE
  v_sql text;
  node1 refcursor;
  n int;
  v_sess_id int;
BEGIN
	--select relnamespace into v_relnamespace from pg_class where relname = 'tmp_t' ;	
	v_sql := 'insert into ' || v_table_name ||
	' SELECT ' || (priolev + 1) || ' as lev, b.connect_key || ''/'' || c.' || connect_key || ',  c.* from ' || tablename || ' c, ' || v_table_name ||' b' ||
	' where c.' || root_key || '=b.' || connect_key || ' and b.lev=' || priolev ;
--	RAISE NOTICE 'v_sql here is %', v_sql; -- Quantity here is 30
    EXECUTE v_sql ;
	GET DIAGNOSTICS n = ROW_COUNT ;
	RETURN n;
END 
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.connectbya2(priolev integer, tablename text, v_table_name text, root_key text, connect_key text) OWNER TO letl;

--
-- Name: connectbya9(text, text, text, text); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION connectbya9(iv_tablename text, iv_root_key text, iv_connect_key text, iv_condition text) RETURNS void
    AS $$

declare
--	table_name varchar;     
--	return_value varchar;	
	x record;
--	Y integer;

BEGIN
--Y:=0;
--return_value:='';

  execute 'truncate temp_acnt_ac_code';

  for x in SELECT  cddt_dcode 
             FROM code_detail
             WHERE cddt_mcode = 'ETC0000012'
  loop
    select connectbya(iv_tablename, iv_root_key, iv_connect_key, x.cddt_dcode);
  end loop;

  EXCEPTION WHEN others THEN     -- EXCEPTION HANDLING
    RETURN;
    END;

$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.connectbya9(iv_tablename text, iv_root_key text, iv_connect_key text, iv_condition text) OWNER TO letl;

--
-- Name: connectbya9(text, text, text); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION connectbya9(iv_tablename text, iv_root_key text, iv_connect_key text) RETURNS SETOF child_parent_level
    AS $$
DECLARE

  x record;
  y record;
  ls_child_parent_level sdmin.child_parent_level;

BEGIN
  for x in SELECT  cddt_dcode 
             FROM code_detail
             WHERE cddt_mcode = 'ETC0000012'
  loop
    for y in select * from connectbya(iv_tablename, iv_root_key, iv_connect_key, x.cddt_dcode)
    loop
 		ls_child_parent_level.child  := y.child;
 		ls_child_parent_level.parent := y.parent;
 		ls_child_parent_level.lev    := Y.lev;
 		RETURN NEXT ls_child_parent_level;
    end loop;
  end loop;
  EXCEPTION WHEN others THEN     -- EXCEPTION HANDLING
    RETURN;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.connectbya9(iv_tablename text, iv_root_key text, iv_connect_key text) OWNER TO letl;

--
-- Name: connectbya_backup(text, text, text, text); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION connectbya_backup(tablename text, root_key text, connect_key text, condition text) RETURNS SETOF record
    AS $$
DECLARE
  v_sql text;
  v_table_name text;
  v_condition text;
  node1 RECORD;
  tmp text;
  result int;
  v_lev int;
  v_istable int;
  --v_relnamespace int;
  v_sess_id text;
BEGIN
	 select pg_backend_pid() into v_sess_id;
	 v_table_name := 'temp_' || tablename || v_sess_id;
	 select count(*) into v_istable from pg_class where relname = v_table_name ;	

	if condition is null then
		v_condition := root_key || ' is null';
	else
		v_condition := root_key || '=''' || condition || '''';
	end if;
	 
	if v_istable = 0 then
		execute 'create temp table ' || v_table_name || ' as ' ||
		' select 1 as lev, ' || connect_key || ' as connect_key, c.* from acnt_ac_code c ' ||
		' WHERE  ' || v_condition ||
		' distributed by (lev)	 ';
	else 
		execute 'truncate ' || v_table_name;
		execute 'insert into ' || v_table_name ||
		' select 1 as lev, c.' || connect_key || ' as connect_key, c.* from acnt_ac_code c' ||
		' WHERE ' || v_condition;
	end if;
	result := 1;
	v_lev := 1;
	WHILE result >= 1 LOOP	
		select connectbya2(v_lev, tablename,  v_table_name, root_key, connect_key) into result;
		v_lev := v_lev + 1;
	END LOOP;

        execute 'truncate temp_acnt_ac_code';
        execute 'insert into temp_acnt_ac_code select aacpaccd, aacuaccd, lev from ' || v_table_name ;
         
-- 	FOR node1 IN  execute 'SELECT * FROM ' || v_table_name || ' order by connect_key'
-- 	LOOP
-- 		RETURN NEXT node1;
-- 	END LOOP;
	
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.connectbya_backup(tablename text, root_key text, connect_key text, condition text) OWNER TO letl;

--
-- Name: connectbyi(text, text, text, text); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION connectbyi(tablename text, root_key text, connect_key text, condition text) RETURNS SETOF child_parent_level
    AS $$
DECLARE
  v_sql text;
  v_table_name text;
  v_condition text;
  node1 RECORD;
  tmp text;
  result int;
  v_lev int;
  v_istable int;
  --v_relnamespace int;
  v_sess_id text;


  ls_child_parent_level child_parent_level%rowtype;

  
BEGIN
	 select pg_backend_pid() into v_sess_id;
	 v_table_name := 'temp_' || tablename || v_sess_id;
	 select count(*) into v_istable from pg_class where relname = v_table_name ;	

	if condition is null then
		v_condition := root_key || ' is null';
	else
		v_condition := root_key || '=''' || condition || '''';
	end if;
	 
	if v_istable = 0 then
		execute 'create temp table ' || v_table_name || ' as ' ||
		' select 1 as lev, ' || connect_key || ' as connect_key, c.* from ifgl_coa_tbl c ' ||
		' WHERE  ' || v_condition ||
		' distributed by (lev)	 ';
	else 
		execute 'truncate ' || v_table_name;
		execute 'insert into ' || v_table_name ||
		' select 1 as lev, c.' || connect_key || ' as connect_key, c.* from ifgl_coa_tbl c' ||
		' WHERE ' || v_condition;
	end if;
	result := 1;
	v_lev := 1;
	WHILE result >= 1 LOOP	
		select connectbyi2(v_lev, tablename,  v_table_name, root_key, connect_key) into result;
		v_lev := v_lev + 1;
	END LOOP;

--         execute 'truncate temp_ifgl_coa_tbl';
--         execute 'insert into temp_ifgl_coa_tbl select coa_cd, higrk_coa_cd, lev from ' || v_table_name ;
         
-- 	FOR node1 IN  execute 'SELECT * FROM ' || v_table_name || ' order by connect_key'
-- 	LOOP
-- 	  RETURN NEXT node1;
-- 	END LOOP;
	
	FOR NODE1 IN  execute 'SELECT * FROM ' || v_table_name || ' order by connect_key'
	LOOP
	   ls_child_parent_level.child = node1.coa_cd;
	   ls_child_parent_level.parent = node1.higrk_coa_cd;
	   ls_child_parent_level.lev = node1.lev;
	   return next ls_child_parent_level;
	END LOOP;

END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.connectbyi(tablename text, root_key text, connect_key text, condition text) OWNER TO letl;

--
-- Name: connectbyi2(integer, text, text, text, text); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION connectbyi2(priolev integer, tablename text, v_table_name text, root_key text, connect_key text) RETURNS integer
    AS $$
DECLARE
  v_sql text;
  node1 refcursor;
  n int;
  v_sess_id int;
BEGIN
	--select relnamespace into v_relnamespace from pg_class where relname = 'tmp_t' ;	
	v_sql := 'insert into ' || v_table_name ||
	' SELECT ' || (priolev + 1) || ' as lev, b.connect_key || ''/'' || c.' || connect_key || ',  c.* from ' || tablename || ' c, ' || v_table_name ||' b' ||
	' where c.' || root_key || '=b.' || connect_key || ' and b.lev=' || priolev ;
--	RAISE NOTICE 'v_sql here is %', v_sql; -- Quantity here is 30
    EXECUTE v_sql ;
	GET DIAGNOSTICS n = ROW_COUNT ;
	RETURN n;
END 
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.connectbyi2(priolev integer, tablename text, v_table_name text, root_key text, connect_key text) OWNER TO letl;

--
-- Name: connectbyi9(text, text, text, text); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION connectbyi9(iv_tablename text, iv_root_key text, iv_connect_key text, iv_condition text) RETURNS void
    AS $$

declare
--	table_name varchar;     
--	return_value varchar;	
	x record;
--	Y integer;

BEGIN
--Y:=0;
--return_value:='';

  execute 'truncate temp_acnt_ac_code';

  for x in SELECT  cddt_dcode 
             FROM code_detail
             WHERE cddt_mcode = 'ETC0000012'
  loop
    select connectbyi(iv_tablename, iv_root_key, iv_connect_key, x.cddt_dcode);
  end loop;

  EXCEPTION WHEN others THEN     -- EXCEPTION HANDLING
    RETURN;
    END;

$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.connectbyi9(iv_tablename text, iv_root_key text, iv_connect_key text, iv_condition text) OWNER TO letl;

--
-- Name: connectbyi9(text, text, text); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION connectbyi9(iv_tablename text, iv_root_key text, iv_connect_key text) RETURNS SETOF child_parent_level
    AS $$
DECLARE

  x record;
  y record;
  ls_child_parent_level sdmin.child_parent_level;

BEGIN
  for x in SELECT coa_cd FROM ifgl_coa_tbl
             WHERE dbcr_yn = 'Y'
             AND coa_cd_lvl_attr_cd = decode(bk_trt_bs_is_dscd,'3','2','3')
  loop
    for y in select * from connectbyi(iv_tablename, iv_root_key, iv_connect_key, x.coa_cd)
    loop
 		ls_child_parent_level.child  := y.child;
 		ls_child_parent_level.parent := y.parent;
 		ls_child_parent_level.lev    := Y.lev;
 		RETURN NEXT ls_child_parent_level;
    end loop;
  end loop;
  EXCEPTION WHEN others THEN     -- EXCEPTION HANDLING
    RETURN;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.connectbyi9(iv_tablename text, iv_root_key text, iv_connect_key text) OWNER TO letl;

--
-- Name: depo_goan_avgmk(); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION depo_goan_avgmk() RETURNS void
    AS $$ 
--BGN : Use Case--------------------------------------------------------



--END : Use Case--------------------------------------------------------

DECLARE
    /*===========================================================*/
    /*=   !!! 작업시 확인 사항 !!!!!!!!!!!!!!!!!!!!             =*/
    /*===========================================================*/
    /*= 1. depo_mm_dbal작업은 정확히 완료되었는가              ==*/
    /*-----------------------------------------------------------*/
    /* HISTORY *                                                =*/
    /* -.2004.11월분부터 B/S기준으로 평잔산출 (체계변경)        =*/
    /*===========================================================*/


    v_lstdt     depo_bd_dbal.DBDTRDT%TYPE :=
	            	TO_CHAR(LAST_DAY(ADD_MONTHS(to_date('20130501', 'yyyymmdd')+3,-1)),'YYYYMMDD');
			                     		          /*　기준월　말일　　　*/
    v_fstdt     depo_bd_dbal.DBDTRDT%TYPE := SUBSTR(V_LSTDT,1,6)||'01' ;
					                              /*  기준월　초일　　　*/
    v_enddt     depo_bd_dbal.DBDTRDT%TYPE :=
	                 TO_CHAR(TO_DATE(V_LSTDT,'YYYYMMDD') + 1,'YYYYMMDD') ;
					                               /*  기준월　익월초일  */
    v_yyyymm    CHAR (6)  := SUBSTR(V_FSTDT,1,6) ;        /* 기준년월   */
    v_month     CHAR (2)  := SUBSTR(V_FSTDT,5,2) ;        /* 기준월   */
    v_basyear   CHAR (4)  := SUBSTR(V_FSTDT,1,4) ;        /* 기준년도 */
   v_befyear   CHAR (4)  := SUBSTR(BEFDT(V_FSTDT),1,4) ; /* 전월말의년도 */
   v_befmmdt   CHAR (8)  := BEFDT(V_FSTDT) ;  /* 기준월전월마지막영업일 */
   v_basmmdt   CHAR (8)  := BEFDT(V_ENDDT) ;  /* 기준월  마지막영업일  */
    v_totday    numeric(2,0) := to_number(SUBSTR(V_LSTDT,7,2),'999999999') ;

    vacno       depo_bd_dbal.DBDACNO%TYPE   ;
    vord        numeric(1) ;
    vtrdt       depo_bd_dbal.DBDTRDT%TYPE   ;
    vnxdt       depo_bd_dbal.DBDTRDT%TYPE   ;
    vclodt      depo_bd_dbal.DBDTRDT%TYPE  ;
    vjjan       numeric(15);
    vhjan       numeric(15);
    vicnt       numeric(7);
    viamt       numeric(15);
    vjcnt       numeric(7);
    vjamt       numeric(15);
    clodt       char(8);

    v_sacno     depo_bd_dbal.DbdACNO%TYPE  ;
    v_strdt     depo_bd_dbal.DBDTRDT%TYPE  ;
    v_nxtdt     depo_bd_dbal.DBDTRDT%TYPE  ;
    v_jjan      depo_bd_dbal.dbdiamt%TYPE := 0 ;
    v_hjan      depo_bd_dbal.dbdiamt%TYPE := 0 ;
    v_jan       depo_bd_dbal.dbdiamt%TYPE := 0 ;
    v_ticnt     depo_bd_dbal.dbdiamt%TYPE := 0 ;
    v_tiamt     depo_bd_dbal.dbdiamt%TYPE := 0 ;
    v_tjcnt     depo_bd_dbal.dbdiamt%TYPE := 0 ;
    v_tjamt     depo_bd_dbal.dbdiamt%TYPE := 0 ;

    v_depjuk    numeric(15,0)         := 0 ;
    v_lonjuk    numeric(15,0)         := 0 ;
    v_depavg    depo_bd_dbal.dbdiamt%TYPE := 0 ;
    v_lonavg    depo_bd_dbal.dbdiamt%TYPE := 0 ;

    v_updcnt    numeric := 0 ;
    v_rcnt      numeric := 0 ;
    v_wcnt      numeric := 0 ;
    v_xamt      numeric := 0 ;
    v_xavg      numeric := 0 ;
    vclcnt      numeric := 0 ;
    vaccnt      numeric := 0 ;
    vsjcnt      numeric := 0 ;
    v_wcnt1     numeric := 0 ;

   c1 CURSOR IS select dbdacno,dbdtrdt,dbdord,dbdnxtdt,
                       dbdxjbal,dbdxhbal,dbdicnt,dbdiamt,dbdjcnt,dbdjamt
                from   depo_mm_dbal
	        	where  dbdtrdt between v_fstdt and v_lstdt
                order by 1,2,3 ;

BEGIN 

    exception
          WHEN unique_violation THEN
    RAISE NOTICE ' ' ;
    
    OPEN c1 ;

    LOOP
      FETCH c1 INTO vacno,vtrdt,vord,vnxdt,
		            vjjan,vhjan,vicnt,viamt,vjcnt,vjamt  ;

--      EXIT WHEN c1%NOTFOUND ;
IF NOT FOUND THEN
    EXIT;
END IF;


      IF v_rcnt  = 0  THEN                      /* 맨　첫계좌 ?   */
     	 v_sacno := vacno  ;
         v_jjan  := vjjan  ;
         v_hjan  := vhjan  ;
         v_strdt := vtrdt  ;
         v_nxtdt := vnxdt  ;

      END IF ;

      v_rcnt  := v_rcnt + 1 ;                    /*  READ 건수     */

      IF v_sacno != vacno THEN                   /*  계좌번호 변경　?   */
         IF  v_jjan  >= 0 THEN     /* 최종거래일부터 익영업일까지 예금적수 */
             v_depjuk := v_depjuk + (to_date(v_nxtdt,'yyyymmdd')
	  	 	          -  to_date(v_strdt,'yyyymmdd'))
			          *  v_jjan  ;

         ELSE                    /* 최종거래일부터 익영업일까지 대출적수 */
	         v_lonjuk := v_lonjuk + (to_date(v_nxtdt,'yyyymmdd')
	  		          -  to_date(v_strdt,'yyyymmdd'))
			          *  (v_jjan  * -1) ;
         END IF ;

         IF  v_hjan  >= 0 THEN   /* 최종거래익영업일부터 말일까지 예금적수 */
             v_depjuk := v_depjuk + (to_date(v_enddt,'yyyymmdd')
	  		          -  to_date(v_nxtdt,'yyyymmdd'))
			          *  v_hjan  ;

         ELSE                  /* 최종거래익영업일부터 말일까지 대출적수 */
	         v_lonjuk := v_lonjuk + (to_date(v_enddt,'yyyymmdd')
	  		          -  to_date(v_nxtdt,'yyyymmdd'))
			          *  (v_hjan  * -1) ;
         END IF ;

         v_depavg := trunc(v_depjuk / v_totday)  ;
         v_lonavg := trunc(v_lonjuk / v_totday)  ;

    	 IF  v_strdt = v_basmmdt  THEN     /* 최종거래일이 말일 ?   */
     	     v_jan := v_jjan ;
         ELSE
	         v_jan := v_hjan ;
         END IF ;

         /*-----------------------------------------------*/
         /*- 평잔 자료 갱신- 해당월에 자료갱신           -*/
         /*-----------------------------------------------*/
       IF  v_month   = '01' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm01davg = v_depavg,dmm01lavg = v_lonavg,
                  dmm01icnt = v_ticnt,dmm01iamt = v_tiamt,
                  dmm01jcnt = v_tjcnt,dmm01jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '02' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm02davg = v_depavg,dmm02lavg = v_lonavg,
                  dmm02icnt = v_ticnt,dmm02iamt = v_tiamt,
                  dmm02jcnt = v_tjcnt,dmm02jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '03' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm03davg = v_depavg,dmm03lavg = v_lonavg,
                  dmm03icnt = v_ticnt,dmm03iamt = v_tiamt,
                  dmm03jcnt = v_tjcnt,dmm03jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '04' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm04davg = v_depavg,dmm04lavg = v_lonavg,
                  dmm04icnt = v_ticnt,dmm04iamt = v_tiamt,
                  dmm04jcnt = v_tjcnt,dmm04jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '05' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm05davg = v_depavg,dmm05lavg = v_lonavg,
                  dmm05icnt = v_ticnt,dmm05iamt = v_tiamt,
                  dmm05jcnt = v_tjcnt,dmm05jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '06' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm06davg = v_depavg,dmm06lavg = v_lonavg,
                  dmm06icnt = v_ticnt,dmm06iamt = v_tiamt,
                  dmm06jcnt = v_tjcnt,dmm06jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '07' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm07davg = v_depavg,dmm07lavg = v_lonavg,
                  dmm07icnt = v_ticnt,dmm07iamt = v_tiamt,
                  dmm07jcnt = v_tjcnt,dmm07jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '08' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm08davg = v_depavg,dmm08lavg = v_lonavg,
                  dmm08icnt = v_ticnt,dmm08iamt = v_tiamt,
                  dmm08jcnt = v_tjcnt,dmm08jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '09' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm09davg = v_depavg,dmm09lavg = v_lonavg,
                  dmm09icnt = v_ticnt,dmm09iamt = v_tiamt,
                  dmm09jcnt = v_tjcnt,dmm09jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '10' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm10davg = v_depavg,dmm10lavg = v_lonavg,
                  dmm10icnt = v_ticnt,dmm10iamt = v_tiamt,
                  dmm10jcnt = v_tjcnt,dmm10jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '11' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm11davg = v_depavg,dmm11lavg = v_lonavg,
                  dmm11icnt = v_ticnt,dmm11iamt = v_tiamt,
                  dmm11jcnt = v_tjcnt,dmm11jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '12' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm12davg = v_depavg,dmm12lavg = v_lonavg,
                  dmm12icnt = v_ticnt,dmm12iamt = v_tiamt,
                  dmm12jcnt = v_tjcnt,dmm12jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;
       END IF ;

        /****************************************************
         IF  v_month   = '02' THEN
             UPDATE DEPO_MM_MBAL1
             SET  dmm10davg = v_depavg,dmm10lavg = v_lonavg,
                  dmm10icnt = v_ticnt,dmm10iamt = v_tiamt,
                  dmm10jcnt = v_tjcnt,dmm10jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;
         END IF ;
        ****************************************************/

         v_xamt := v_xamt + v_jjan   ;
         v_xavg := v_xavg + v_depavg ;
         v_wcnt := v_wcnt + 1 ;
         v_updcnt := v_updcnt + 1 ;

    	 IF v_updcnt > 10000 THEN
            COMMIT ;
            v_updcnt := 0;
         END IF ;


	 v_ticnt  := 0 ;
	 v_tiamt  := 0 ;
	 v_tjcnt  := 0 ;
	 v_tjamt  := 0 ;
	 v_depjuk := 0 ;
	 v_lonjuk := 0 ;
	 v_depavg := 0 ;
	 v_lonavg := 0 ;
	 v_sacno  := vacno  ;
	 v_jjan   := vjjan  ;
	 v_hjan   := vhjan  ;
	 v_strdt  := vtrdt  ;
	 v_nxtdt  := vnxdt  ;
	 clodt    := NULL   ;

    END IF ;

      IF vord = 2  THEN      /*  해지 거래 ?  */
         clodt := vtrdt ;    /*  해지일자  SET  */
      END IF ;

      IF  clodt IS NOT NULL AND vtrdt >= clodt THEN
          vjjan := 0 ;
          vhjan := 0 ;
      END IF ;

      IF v_strdt != vtrdt THEN             /*  일자변경　？  */
    	 IF  v_jjan  >= 0 THEN      /* 전거래일부터 익영업일까지  예금적수 */
    	     v_depjuk := v_depjuk + (to_date(v_nxtdt,'yyyymmdd')
	                          -  to_date(v_strdt,'yyyymmdd'))
				  *  v_jjan ;

         ELSE                     /* 전거래일부터 익영업일까지  대출적수 */
    	     v_lonjuk := v_lonjuk + (to_date(v_nxtdt,'yyyymmdd')
	  	                  -  to_date(v_strdt,'yyyymmdd'))
		                  * (v_jjan  * -1)  ;

         END IF ;

    	 IF  v_nxtdt < vtrdt THEN
    	     IF  v_hjan  >= 0 THEN   /*  이번거래전일까지  예금적수   */
     	         v_depjuk := v_depjuk + (to_date(vtrdt,'yyyymmdd')
	                              -  to_date(v_nxtdt,'yyyymmdd'))
				      *  v_hjan ;

             ELSE                  /*  이번거래전일까지　대출적수   */
    	         v_lonjuk := v_lonjuk + (to_date(vtrdt,'yyyymmdd')
  	                              -  to_date(v_nxtdt,'yyyymmdd'))
		                      * (v_hjan  * -1)  ;
             END IF ;
         END IF ;

      END IF ;

      v_ticnt := v_ticnt + vicnt ;
      v_tiamt := v_tiamt + viamt ;
      v_tjcnt := v_tjcnt + vjcnt ;
      v_tjamt := v_tjamt + vjamt ;
      v_jjan  := vjjan ;
      v_hjan  := vhjan ;
      v_strdt := vtrdt ;
      v_nxtdt := vnxdt ;

    END LOOP  ;

    IF  v_jjan  >= 0 THEN
        v_depjuk := v_depjuk + (to_date(v_nxtdt,'yyyymmdd')
	  		     -  to_date(v_strdt,'yyyymmdd'))
			     *  v_jjan  ;
    ELSE
        v_lonjuk := v_lonjuk + (to_date(v_nxtdt,'yyyymmdd')
	  		     -  to_date(v_strdt,'yyyymmdd'))
			     *  (v_jjan  * -1) ;
    END IF ;

    IF  v_hjan  >= 0 THEN
        v_depjuk := v_depjuk + (to_date(v_enddt,'yyyymmdd')
	  		     -  to_date(v_nxtdt,'yyyymmdd'))
			     *  v_hjan  ;
    ELSE
        v_lonjuk := v_lonjuk + (to_date(v_enddt,'yyyymmdd')
	  		     -  to_date(v_nxtdt,'yyyymmdd'))
			     *  (v_hjan  * -1) ;
    END IF ;

    v_depavg := trunc(v_depjuk / v_totday)  ;
    v_lonavg := trunc(v_lonjuk / v_totday)  ;

    IF  v_strdt = v_basmmdt THEN     /* 최종거래일이 말일 ？     */
        v_jan := v_jjan ;
    ELSE
        v_jan := v_hjan ;
    END IF ;


    /*-----------------------------------------------*/
    /*- 평잔 자료 갱신                              -*/
    /*-----------------------------------------------*/

   /************************
    insert into depo_goan_davg
    values(v_yyyymm,v_sacno,v_depavg,v_lonavg);
   ********************************/



    /************************************************************/
       IF  v_month   = '01' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm01davg = v_depavg,dmm01lavg = v_lonavg,
                  dmm01icnt = v_ticnt,dmm01iamt = v_tiamt,
                  dmm01jcnt = v_tjcnt,dmm01jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '02' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm02davg = v_depavg,dmm02lavg = v_lonavg,
                  dmm02icnt = v_ticnt,dmm02iamt = v_tiamt,
                  dmm02jcnt = v_tjcnt,dmm02jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '03' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm03davg = v_depavg,dmm03lavg = v_lonavg,
                  dmm03icnt = v_ticnt,dmm03iamt = v_tiamt,
                  dmm03jcnt = v_tjcnt,dmm03jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '04' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm04davg = v_depavg,dmm04lavg = v_lonavg,
                  dmm04icnt = v_ticnt,dmm04iamt = v_tiamt,
                  dmm04jcnt = v_tjcnt,dmm04jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '05' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm05davg = v_depavg,dmm05lavg = v_lonavg,
                  dmm05icnt = v_ticnt,dmm05iamt = v_tiamt,
                  dmm05jcnt = v_tjcnt,dmm05jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '06' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm06davg = v_depavg,dmm06lavg = v_lonavg,
                  dmm06icnt = v_ticnt,dmm06iamt = v_tiamt,
                  dmm06jcnt = v_tjcnt,dmm06jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '07' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm07davg = v_depavg,dmm07lavg = v_lonavg,
                  dmm07icnt = v_ticnt,dmm07iamt = v_tiamt,
                  dmm07jcnt = v_tjcnt,dmm07jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '08' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm08davg = v_depavg,dmm08lavg = v_lonavg,
                  dmm08icnt = v_ticnt,dmm08iamt = v_tiamt,
                  dmm08jcnt = v_tjcnt,dmm08jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '09' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm09davg = v_depavg,dmm09lavg = v_lonavg,
                  dmm09icnt = v_ticnt,dmm09iamt = v_tiamt,
                  dmm09jcnt = v_tjcnt,dmm09jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '10' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm10davg = v_depavg,dmm10lavg = v_lonavg,
                  dmm10icnt = v_ticnt,dmm10iamt = v_tiamt,
                  dmm10jcnt = v_tjcnt,dmm10jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '11' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm11davg = v_depavg,dmm11lavg = v_lonavg,
                  dmm11icnt = v_ticnt,dmm11iamt = v_tiamt,
                  dmm11jcnt = v_tjcnt,dmm11jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       ELSIF v_month   = '12' THEN
             UPDATE DEPO_MM_MBAL
             SET  dmm12davg = v_depavg,dmm12lavg = v_lonavg,
                  dmm12icnt = v_ticnt,dmm12iamt = v_tiamt,
                  dmm12jcnt = v_tjcnt,dmm12jamt = v_tjamt
             WHERE dmmyear = v_basyear  and dmmacno = v_sacno ;

       END IF;


   /*************************************************************/

    v_xamt := v_xamt + v_jjan   ;
    v_xavg := v_xavg + v_depavg ;
    v_wcnt := v_wcnt + 1 ;

    COMMIT ;
    CLOSE c1 ;


    INSERT INTO CMSUSR.CUST_RL_DT_TBL
    VALUES ('depo_mm_mavg',v_lstdt) ;

    COMMIT ;


    RAISE NOTICE ' ' ;
    RAISE NOTICE '***** 수신 월계수 작성 작업 *****' ;
    RAISE NOTICE '*** 금월 = ',v_month,'월 ***' ;
    RAISE NOTICE '***  시 작 일= ',v_fstdt,'일 ***' ;
    RAISE NOTICE '***  마지막일= ',v_lstdt,'일 ***' ;
    RAISE NOTICE '*** 전월말일 = ',v_befmmdt,'일 ***' ;
    RAISE NOTICE ' ' ;
    RAISE NOTICE '*** 일계수건수 = ',to_char(v_rcnt),' 건 ***' ;
    RAISE NOTICE '*** 월계수갱신 = ',to_char(v_wcnt),' 건 ***' ;
    RAISE NOTICE '*** 월계수잔액 = ',to_char(v_xamt),' 원 ***' ;
    RAISE NOTICE '*** 월계수평잔 = ',to_char(v_xavg),' 원 ***' ;

END; 
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.depo_goan_avgmk() OWNER TO letl;

--
-- Name: depo_goan_dbalmk(); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION depo_goan_dbalmk() RETURNS void
    AS $$ 
--BGN : Use Case--------------------------------------------------------



--END : Use Case--------------------------------------------------------

DECLARE
  /*===========================================================**/
  /*  !!!!!작업시 확인 해야하는 사항                           -*/
  /*===========================================================**/
  /* 계정평잔과 일치시키기 위한 수신 계좌별 평잔 작업          **/
  /* - 수신은 토요일 I1으로 처리되고 계정은 익일자로 처리      **/
  /*   되기 때문에 평잔 불일치 사항 발생                       **/
  /* - 관리회계에 사용시 계정평잔과 일치해야 함                **/
  /**************************************************************/

  v_jobdt char(8) := AFTDT(BEFDT(TO_CHAR(to_date('20130501', 'yyyymmdd'),'YYYYMMDD')));
                                                                /* 작업기준일 */
  v_basdt char(8) := TO_CHAR(LAST_DAY(to_date('20130501', 'yyyymmdd')-6),'YYYYMMDD') ; /* 금월말일   */
  v_deldt char(8) := TO_CHAR(LAST_DAY(to_date('20130501', 'yyyymmdd')-45),'YYYYMMDD') ; /* 전월말일   */
  v_fstdt char(8) := SUBSTR(v_basdt,1,6)||'01'        ;         /* 금월초일  */
  v_nxtdt char(8) := SUBSTR(AFTDT(v_basdt),1,6)||'01' ;  /* 익월초일   */
  v_ltrdt char(8) := BEFDT(AFTDT(v_basdt))    ;          /* 금월말영업일 */
  v_lstdt char(8) := BEFDT(v_fstdt)    ;                 /* 전월말영업일 */
  befwmal char(8) := BEFDT_OLD(v_fstdt)  ;       /* 전월말영업일이후토요일 */
  v_strdt char(8) := v_fstdt                          ;   /* 첫거래일전일 */
  v_year  char(4) := substr(v_lstdt,1,4)              ;   /* 기준년도     */
  v_wcnt numeric (8,0) := 0 ;
  v_del0 numeric (8,0) := 0 ;
  v_cnt0 numeric (8,0) := 0 ;
  v_cnt1 numeric (8,0) := 0 ;
  v_cnt2 numeric (8,0) := 0 ;
  v_cnt3 numeric (8,0) := 0 ;
  v_cnt4 numeric (8,0) := 0 ;
  v_cnt5 numeric (8,0) := 0 ;
  v_cnt6 numeric (8,0) := 0 ;
  v_cnt9 numeric (8,0) := 0 ;

  v_acno   char(12);
  v_trdt   char(8);
  v_aftdt  char(8);
  v_aftaftdt  char(8);
  v_xjbal  numeric := 0;
  v_xhbal  numeric := 0;
  v_icnt  numeric := 0;
  v_iamt  numeric := 0;
  v_jcnt  numeric := 0;
  v_jamt  numeric := 0;
  v_gubun  numeric := 0;


integer_var integer;
 /*---------------------------------------------------------*/
 /*사용 work area define                                   -*/
 /* 1.v_gubun :OFFDT(dbdtrdt) 0(평일),1(토요일)            -*/
 /* 2.v_trtd :거래일자                                     -*/
 /* 3.v_aftdt:익영업일자                                   -*/
 /* 4.v_aftaftdt:익익영업일                                -*/
 /*---------------------------------------------------------*/
 /* 수시작업대비 직전작업일이후부터 현재전일까지 자료추출   */
 /*---------------------------------------------------------*/

 c0 CURSOR IS
            select dbdacno,OFFDT(dbdtrdt),dbdtrdt,AFTDT(dbdtrdt),
                   AFTDT(AFTDT(dbdtrdt)),dbdxjbal,dbdxhbal,
                   dbdicnt,dbdiamt,dbdjcnt,dbdjamt
    from depo_bd_dbal
    where dbdtrdt > v_strdt and dbdtrdt < v_jobdt
    and  ((dbdaccd != '64') or
          (dbdaccd  = '64' and dbdacno != substr(dbdcifno,1,12)))
    order by 2;

 /*---------------------------------------------------*/
 /*- 전월월말 잔액 갱신                              -*/
 /*---------------------------------------------------*/
 c1 CURSOR IS
       select dmmacno,s_fstdt,gubun,s_aftdt,mbal,mbal,0,0,0,0
       from (select dmmacno,v_fstdt s_fstdt,0 gubun,AFTDT(v_lstdt) s_aftdt,
               decode(substr(v_basdt,5,2),'01',dmm12mbal,'02',dmm01mbal,
                         '03',dmm02mbal,'04',dmm03mbal,'05',dmm04mbal,
                         '06',dmm05mbal,'07',dmm06mbal,'08',dmm07mbal,
                         '09',dmm08mbal,'10',dmm09mbal,'11',dmm10mbal,
                         '12',dmm11mbal) mbal
          from   depo_mm_mbal
          where  dmmyear = v_year
           and  ((dmmclodt is null or dmmclocd = '02')  or
                (dmmclodt between v_fstdt and v_basdt))
            ) a;

BEGIN 

    exception
          WHEN unique_violation THEN
    RAISE NOTICE ' ' ;

/*
    delete from depo_mm_dbal
    where dbdtrdt < substr(v_deldt,1,6)||'26' ;
    v_del0 := sql%rowcount ;
    commit ;
*/
    select nvl(count(*)::int,0::int)                /* 전월말일자 계좌 잔액  */
    into   v_cnt0
    from   depo_mm_dbal
    where  dbdord = 0 and dbdtrdt = v_fstdt 
--    and rownum < 3;
    limit 2;

    select nvl(count(*)::int,0::int)                /* 전월말일자 마감후 거래 계좌  */
    into   v_cnt1
    from   depo_mm_dbal
    where  dbdord = 1 and dbdtrdt = v_fstdt 
--    and rownum < 3;
    limit 2;

    select nvl(count(*)::int,0::int)                /* 당월 해지계좌  */
    into   v_cnt2
    from   depo_mm_dbal
    where  dbdord = 2
    and    substr(dbdtrdt,1,6) = substr(v_fstdt,1,6)
--    and rownum < 3;
    limit 2;

    select nvl(count(*)::int,0::int),nvl(max(dbdtrdt),v_lstdt)  /* 당월 거래 내역   */
    into   v_cnt3,v_strdt
    from   depo_mm_dbal
    where  dbdord = 3 ;

    truncate table depo_mm_dbal;


    if  v_cnt1 = 0  then                 /* 전월말일자 마감후 거래내역 */

        insert into depo_mm_dbal
        select dbdacno,v_fstdt,1,AFTDT(v_lstdt),dbdxjbal,dbdxhbal,0,0,0,0
     	  from   depo_bd_dbal
    	  where  dbdtrdt = v_lstdt and dbdxjbal != dbdxhbal
       	    and  ((dbdaccd != '64') or
	         (dbdaccd  = '64' and dbdacno != substr(dbdcifno,1,12))) ;
    GET DIAGNOSTICS integer_var = ROW_COUNT;

     	    v_cnt1 := integer_var;

          commit;
    end if ;

    if  v_cnt2 = 0  then
        if substr(v_jobdt,1,6) != substr(v_basdt,1,6) then /* 해지계좌 정보 */
           insert into depo_mm_dbal
           select dacacno,dacclodt,2,dacclodt,0,0,0,0,0,0
	       from   depo_ac_comm
	       where  dacclodt between v_fstdt and v_basdt
	         and  dacclocd != '02' ;

	       v_cnt2 := sql%rowcount ;

	       commit;
        end if ;
    end if ;

  /*----------------------------------------------------------**/
  /* 금월거래 내역 insert                                     -*/
  /*   1.토요일거래를 먼저 처리한다                           -*/
  /*   2.익일 recode가 없는경우는 insert,있는경우는 update처리-*/
  /*-----------------------------------------------------------*/
   OPEN c0;

   <<DEPO_MM_HOLLI>>
    LOOP
       FETCH c0 INTO v_acno,v_gubun,v_trdt,v_aftdt,v_aftaftdt,
                     v_xjbal,v_xhbal,v_icnt,v_iamt,v_jcnt,v_jamt;


       EXIT WHEN c0%NOTFOUND;

       v_cnt3 := v_cnt3 + 1;

       IF v_trdt = v_ltrdt THEN    /*익영업일이 월말인경우 익월초일로 set */
          v_aftdt := v_nxtdt;
       END IF;

       IF v_gubun = 1 THEN     /*토요일자 거래인 경우 거래일,익영업일 변경*/
          v_trdt := v_aftdt;
          v_aftdt := v_aftaftdt;
          v_xjbal := v_xhbal;
       END IF;


    BEGIN
       INSERT INTO depo_mm_dbal
          VALUES(v_acno,v_trdt,3,v_aftdt,v_xjbal,v_xhbal,v_icnt,v_iamt,
                 v_jcnt,v_jamt);

          v_cnt5 := v_cnt5 + 1;   /*전체건수 출력용 */

          v_cnt6 := v_cnt6 + 1;   /* commit처리용   */


    exception
          WHEN unique_violation THEN
              UPDATE depo_mm_dbal set dbdicnt = dbdicnt + v_icnt,
                                      dbdiamt = dbdiamt + v_iamt,
                                      dbdjcnt = dbdjcnt + v_jcnt,
                                      dbdjamt = dbdjamt + v_jamt
              WHERE dbdacno = v_acno
                and  dbdtrdt = v_trdt
                and  dbdord = 3;

          v_cnt4 := v_cnt4 + 1;
     END;

      if v_cnt6 >= 100 then
         commit ;
         v_cnt6 := 0 ;
      end if ;

   END LOOP DEPO_MM_HOLLI;


   COMMIT;

   CLOSE c0;

  /*-----------------------------------------------------------*/
  /*  전월 말일자 잔액 추출                                    */
  /*-----------------------------------------------------------*/
  if v_cnt0 = 0  then

    OPEN c1;

   <<DEPO_MM_WOL>>
    LOOP
       FETCH c1 INTO v_acno,v_trdt,v_gubun,v_aftdt,v_xjbal,v_xhbal,
                    v_icnt,v_iamt,v_jcnt,v_jamt;


       EXIT WHEN c1%NOTFOUND;

       insert into depo_mm_dbal
       values(v_acno,v_trdt,v_gubun,v_aftdt,v_xjbal,v_xhbal,
                    v_icnt,v_iamt,v_jcnt,v_jamt);

       v_cnt9 := v_cnt9 + 1;

      if v_cnt9 >= 100 then
         commit ;
         v_cnt9 := 0 ;
      end if ;

   END LOOP DEPO_MM_WOL;


   COMMIT;

   CLOSE c1;

  end if ;

  /*----------------------------------------------------*/
  /*-직전월말영업일이후 토요일거래log가 있는 경우      -*/
  /*- - 토요일거래를 익월첫영업일거래로 반영           -*/
  /*----------------------------------------------------*/
  if  v_cnt1 = 0  then            /* 전월말일자 마감후 거래내역 */
     if v_lstdt != befwmal then    /*월말에 토요일영업일있는가 ***/
       begin
        insert into depo_mm_dbal
        select dbdacno,AFTDT(dbdtrdt),3,AFTDT(AFTDT(dbdtrdt)),
               dbdxjbal,dbdxhbal,0,0,0,0
     	  from   depo_bd_dbal
    	  where  dbdtrdt = befwmal
       	    and  ((dbdaccd != '64') or
	         (dbdaccd  = '64' and dbdacno != substr(dbdcifno,1,12))) ;


         exception
          when unique_violation then
             null;
      end;

      commit;

     end if;

  end if;

    RAISE NOTICE ' ** ' ;
    RAISE NOTICE '***** 수신 일계수 작성 작업 *****' ;
    RAISE NOTICE '** 기준일  = ',v_strdt ;
    RAISE NOTICE '** 금월말일= ',v_basdt ;
/*    RAISE NOTICE '-- 전월거래 DELETE 수 = ',v_del0 ; */
    RAISE NOTICE '-- 전월말일 현재 건수 = ',v_cnt0 ;
    RAISE NOTICE '-- 전월말 마감후 건수 = ',v_cnt1 ;
    RAISE NOTICE '-- 당월 해지계좌 건수 = ',v_cnt2 ;
    RAISE NOTICE '-- 금월 거래건수 누계 = ',v_cnt3 ;
    RAISE NOTICE '-- 당월 추가 건수     = ',v_cnt5 ;
    RAISE NOTICE '-- 당월중복 추가 건수     = ',v_cnt4 ;
    RAISE NOTICE ' ** ' ;

END; 
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.depo_goan_dbalmk() OWNER TO letl;

--
-- Name: depo_jchul_avgmk(); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION depo_jchul_avgmk() RETURNS void
    AS $$ 
--BGN : Use Case--------------------------------------------------------



--END : Use Case--------------------------------------------------------

DECLARE
    /*===========================================================*/
    /*=   !!! 작업시 확인 사항 !!!!!!!!!!!!!!!!!!!!             =*/
    /*===========================================================*/
    /*= 1. depo_mm_dbal작업은 정확히 완료되었는가              ==*/
    /*-----------------------------------------------------------*/
    /* HISTORY *                                                =*/
    /* -.2005.12월분부터 계좌번호변경없는 전출입거래가 발생함으로*/
    /*        전출점평전과 전입점평잔을 안분처리하기 위함        */
    /*===========================================================*/

    v_lstdt     depo_bd_dbal.DBDTRDT%TYPE :=
	            	TO_CHAR(LAST_DAY(to_date('20130501', 'yyyymmdd')),'YYYYMMDD');

   /**************
    v_lstdt     depo_bd_dbal.DBDTRDT%TYPE :=
	            	TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE+3,-1)),'YYYYMMDD');
    **************************************************/
			                     		          /*　기준월　말일　　　*/
    v_fstdt     depo_bd_dbal.DBDTRDT%TYPE := SUBSTR(V_LSTDT,1,6)||'01' ;
					                              /*  기준월　초일　　　*/
    v_enddt     depo_bd_dbal.DBDTRDT%TYPE :=
	                 TO_CHAR(TO_DATE(V_LSTDT,'YYYYMMDD') + 1,'YYYYMMDD') ;
					                               /*  기준월　익월초일  */
    v_yyyymm    CHAR (6)  := SUBSTR(V_FSTDT,1,6) ;        /* 기준년월   */
    v_month     CHAR (2)  := SUBSTR(V_FSTDT,5,2) ;        /* 기준월   */
    v_basyear   CHAR (4)  := SUBSTR(V_FSTDT,1,4) ;        /* 기준년도 */
   v_befyear   CHAR (4)  := SUBSTR(BEFDT(V_FSTDT),1,4) ; /* 전월말의년도 */
   v_befmmdt   CHAR (8)  := BEFDT(V_FSTDT) ;  /* 기준월전월마지막영업일 */
   v_basmmdt   CHAR (8)  := BEFDT(V_ENDDT) ;  /* 기준월  마지막영업일  */
    v_totday    numeric(2,0) := TO_number(SUBSTR(V_LSTDT,7,2),'999999999') ;

    vacno       depo_bd_dbal.DBDACNO%TYPE   ;
    vord        numeric(1) ;
    vtrdt       depo_bd_dbal.DBDTRDT%TYPE   ;
    vcvdate     depo_bd_dbal.DBDTRDT%TYPE   ;
    v_cvdate    depo_bd_dbal.DBDTRDT%TYPE   ;
    vnxdt       depo_bd_dbal.DBDTRDT%TYPE   ;
    vclodt      depo_bd_dbal.DBDTRDT%TYPE  ;
    vjjan       numeric(15);
    vhjan       numeric(15);
    vicnt       numeric(7);
    viamt       numeric(15);
    vjcnt       numeric(7);
    vjamt       numeric(15);
    clodt       char(8);
    vjbrno     char(3);
    v_jbrno     char(3);

    v_sacno     depo_bd_dbal.DbdACNO%TYPE  ;
    v_strdt     depo_bd_dbal.DBDTRDT%TYPE  ;
    v_nxtdt     depo_bd_dbal.DBDTRDT%TYPE  ;
    v_jjan      depo_bd_dbal.dbdiamt%TYPE := 0 ;
    v_hjan      depo_bd_dbal.dbdiamt%TYPE := 0 ;
    v_jan       depo_bd_dbal.dbdiamt%TYPE := 0 ;
    v_ticnt     depo_bd_dbal.dbdiamt%TYPE := 0 ;
    v_tiamt     depo_bd_dbal.dbdiamt%TYPE := 0 ;
    v_tjcnt     depo_bd_dbal.dbdiamt%TYPE := 0 ;
    v_tjamt     depo_bd_dbal.dbdiamt%TYPE := 0 ;

    v_depjuk    numeric(15,0)         := 0 ;
    v_lonjuk    numeric(15,0)         := 0 ;
    v_depavg    depo_bd_dbal.dbdiamt%TYPE := 0 ;
    v_lonavg    depo_bd_dbal.dbdiamt%TYPE := 0 ;

    v_updcnt    numeric := 0 ;
    v_rcnt      numeric := 0 ;
    v_wcnt      numeric := 0 ;
    v_xamt      numeric := 0 ;
    v_xavg      numeric := 0 ;
    vclcnt      numeric := 0 ;
    vaccnt      numeric := 0 ;
    vsjcnt      numeric := 0 ;
    v_wcnt1     numeric := 0 ;

   c1 CURSOR IS select /*+ ordered */dbdacno,dbdtrdt,dbdord,dbdnxtdt,
                       dbdxjbal,dbdxhbal,dbdicnt,dbdiamt,dbdjcnt,dbdjamt,
                       dcvdate,dcvjbrno
                from   depo_cv_info,depo_mm_dbal
	        	where  dcvjacno = dbdacno
                  and  dcvcode = '01'
                  and  dcvdate between v_fstdt and v_lstdt
                  and substr(dcvjacno,4,2) in('01','03','22','21','32',
                                                    '35','20','07','09')
                  and  dbdtrdt between v_fstdt and dcvdate
                order by 1,2,3 ;

BEGIN

    exception
          WHEN unique_violation THEN
    RAISE NOTICE ' ' ;

   /*-----------------------------------------------*/

   /*- 평잔 자료 갱신- 당월 이중작업시 대비 delete -*/

   /*-----------------------------------------------*/

   delete  from depo_cv_davg where dcdyymm = v_yyyymm;
   commit;
   

  /*     set transaction use rollback segment RB99;    */



    OPEN c1 ;



    LOOP

      FETCH c1 INTO vacno,vtrdt,vord,vnxdt,

		            vjjan,vhjan,vicnt,viamt,vjcnt,vjamt,vcvdate,vjbrno  ;





      EXIT WHEN c1%NOTFOUND ;



      IF v_rcnt  = 0  THEN                      /* 맨　첫계좌 ?   */

     	 v_sacno := vacno  ;

         v_jjan  := vjjan  ;

         v_hjan  := vhjan  ;

         v_strdt := vtrdt  ;

         v_nxtdt := vnxdt  ;

         v_cvdate := vcvdate  ;

         v_jbrno := vjbrno  ;



      END IF ;



      v_rcnt  := v_rcnt + 1 ;                    /*  READ 건수     */



      IF v_sacno != vacno THEN                   /*  계좌번호 변경　?   */

         IF  v_jjan  >= 0 THEN     /* 최종거래일부터 익영업일까지 예금적수 */

             v_depjuk := v_depjuk + (to_date(v_nxtdt,'yyyymmdd')

	  	 	          -  to_date(v_strdt,'yyyymmdd'))

			          *  v_jjan  ;



         ELSE                    /* 최종거래일부터 익영업일까지 대출적수 */

	         v_lonjuk := v_lonjuk + (to_date(v_nxtdt,'yyyymmdd')

	  		          -  to_date(v_strdt,'yyyymmdd'))

			          *  (v_jjan  * -1) ;

         END IF ;



         IF  v_hjan  >= 0 THEN   /* 최종거래익영업일부터 말일까지 예금적수 */

             v_depjuk := v_depjuk + (to_date(v_cvdate,'yyyymmdd')

	  		          -  to_date(v_nxtdt,'yyyymmdd'))

			          *  v_hjan  ;



         ELSE                  /* 최종거래익영업일부터 말일까지 대출적수 */

	         v_lonjuk := v_lonjuk + (to_date(v_cvdate,'yyyymmdd')

	  		          -  to_date(v_nxtdt,'yyyymmdd'))

			          *  (v_hjan  * -1) ;

         END IF ;



         v_depavg := trunc(v_depjuk / v_totday)  ;

         v_lonavg := trunc(v_lonjuk / v_totday)  ;



    	 IF  v_strdt = v_basmmdt  THEN     /* 최종거래일이 말일 ?   */

     	     v_jan := v_jjan ;

         ELSE

	         v_jan := v_hjan ;

         END IF ;



         /*-----------------------------------------------*/

         /*- 평잔 자료 갱신- 해당월에 자료갱신           -*/

         /*-----------------------------------------------*/

           insert into depo_cv_davg

           values(v_yyyymm,v_sacno,v_jbrno,v_cvdate,v_depavg);



        /***************************************************/



         v_xamt := v_xamt + v_jjan   ;

         v_xavg := v_xavg + v_depavg ;

         v_wcnt := v_wcnt + 1 ;

         v_updcnt := v_updcnt + 1 ;



    	 IF v_updcnt > 5000 THEN

            COMMIT ;

            v_updcnt := 0;

         END IF ;




	 v_ticnt  := 0 ;

	 v_tiamt  := 0 ;

	 v_tjcnt  := 0 ;

	 v_tjamt  := 0 ;

	 v_depjuk := 0 ;

	 v_lonjuk := 0 ;

	 v_depavg := 0 ;

	 v_lonavg := 0 ;

	 v_sacno  := vacno  ;

	 v_jjan   := vjjan  ;

	 v_hjan   := vhjan  ;

	 v_strdt  := vtrdt  ;

	 v_nxtdt  := vnxdt  ;

	 clodt    := NULL   ;

     v_cvdate := vcvdate  ;

     v_jbrno := vjbrno  ;



    END IF ;



      IF vord = 2  THEN      /*  해지 거래 ?  */

         clodt := vtrdt ;    /*  해지일자  SET  */

      END IF ;



      IF  clodt IS NOT NULL AND vtrdt >= clodt THEN

          vjjan := 0 ;

          vhjan := 0 ;

      END IF ;



      IF v_strdt != vtrdt THEN             /*  일자변경　？  */

    	 IF  v_jjan  >= 0 THEN      /* 전거래일부터 익영업일까지  예금적수 */

    	     v_depjuk := v_depjuk + (to_date(v_nxtdt,'yyyymmdd')

	                          -  to_date(v_strdt,'yyyymmdd'))

				  *  v_jjan ;



         ELSE                     /* 전거래일부터 익영업일까지  대출적수 */

    	     v_lonjuk := v_lonjuk + (to_date(v_nxtdt,'yyyymmdd')

	  	                  -  to_date(v_strdt,'yyyymmdd'))

		                  * (v_jjan  * -1)  ;



         END IF ;



    	 IF  v_nxtdt < vtrdt THEN

    	     IF  v_hjan  >= 0 THEN   /*  이번거래전일까지  예금적수   */

     	         v_depjuk := v_depjuk + (to_date(vtrdt,'yyyymmdd')

	                              -  to_date(v_nxtdt,'yyyymmdd'))

				      *  v_hjan ;



             ELSE                  /*  이번거래전일까지　대출적수   */

    	         v_lonjuk := v_lonjuk + (to_date(vtrdt,'yyyymmdd')

  	                              -  to_date(v_nxtdt,'yyyymmdd'))

		                      * (v_hjan  * -1)  ;

             END IF ;

         END IF ;



      END IF ;



      v_ticnt := v_ticnt + vicnt ;

      v_tiamt := v_tiamt + viamt ;

      v_tjcnt := v_tjcnt + vjcnt ;

      v_tjamt := v_tjamt + vjamt ;

      v_jjan  := vjjan ;

      v_hjan  := vhjan ;

      v_strdt := vtrdt ;

      v_nxtdt := vnxdt ;

      v_jbrno := vjbrno  ;



    END LOOP  ;



    IF  v_jjan  >= 0 THEN

        v_depjuk := v_depjuk + (to_date(v_nxtdt,'yyyymmdd')

	  		     -  to_date(v_strdt,'yyyymmdd'))

			     *  v_jjan  ;

    ELSE

        v_lonjuk := v_lonjuk + (to_date(v_nxtdt,'yyyymmdd')

	  		     -  to_date(v_strdt,'yyyymmdd'))

			     *  (v_jjan  * -1) ;

    END IF ;



    IF  v_hjan  >= 0 THEN

        v_depjuk := v_depjuk + (to_date(v_cvdate,'yyyymmdd')

	  		     -  to_date(v_nxtdt,'yyyymmdd'))

			     *  v_hjan  ;

    ELSE

        v_lonjuk := v_lonjuk + (to_date(v_cvdate,'yyyymmdd')

	  		     -  to_date(v_nxtdt,'yyyymmdd'))

			     *  (v_hjan  * -1) ;

    END IF ;



    v_depavg := trunc(v_depjuk / v_totday)  ;

    v_lonavg := trunc(v_lonjuk / v_totday)  ;



    IF  v_strdt = v_basmmdt THEN     /* 최종거래일이 말일 ？     */

        v_jan := v_jjan ;

    ELSE

        v_jan := v_hjan ;

    END IF ;





    /*-----------------------------------------------*/

    /*- 평잔 자료 갱신                              -*/

    /*-----------------------------------------------*/



    insert into depo_cv_davg

           values(v_yyyymm,v_sacno,v_jbrno,v_cvdate,v_depavg);



    /*-----------------------------------------------*/





    v_xamt := v_xamt + v_jjan   ;

    v_xavg := v_xavg + v_depavg ;

    v_wcnt := v_wcnt + 1 ;



    COMMIT ;

    CLOSE c1 ;


--     RAISE NOTICE ' ' ;
--     RAISE NOTICE '***** 수신 월계수 작성 작업 *****' ;
--     RAISE NOTICE '*** 금월 = ',v_month,'월 ***' ;
--     RAISE NOTICE '***  시 작 일= ',v_fstdt,'일 ***' ;
--     RAISE NOTICE '***  마지막일= ',v_lstdt,'일 ***' ;
--     RAISE NOTICE '*** 전월말일 = ',v_befmmdt,'일 ***' ;
--     RAISE NOTICE ' ' ;
--     RAISE NOTICE '*** 일계수건수 = ',to_char(v_rcnt),' 건 ***' ;
--     RAISE NOTICE '*** 월계수갱신 = ',to_char(v_wcnt),' 건 ***' ;
--     RAISE NOTICE '*** 월계수잔액 = ',to_char(v_xamt),' 원 ***' ;
--     RAISE NOTICE '*** 월계수평잔 = ',to_char(v_xavg),' 원 ***' ;




END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.depo_jchul_avgmk() OWNER TO letl;

--
-- Name: depo_mm_janmk(); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION depo_mm_janmk() RETURNS void
    AS $$ 
--BGN : Use Case--------------------------------------------------------



--END : Use Case--------------------------------------------------------

DECLARE
   v_lstdt char(8) :=
         BEFDT(AFTDT(to_char(last_day(add_months(to_date('20130501', 'yyyymmdd')+7,-1)),'YYYYMMDD')));


   v_year  char(4) := substr(v_lstdt,1,4)       ;
   v_year1 char(4) := to_char(to_number(v_year, '9999') + 1, '9999')::char(4) ;
   v_yymm  char(7) := substr(v_lstdt,1,6)||'%'  ;
   v_month char(2) := substr(v_lstdt,5,2)       ;

   v_acno      DEPO_MM_MBAL.DMMACNO%TYPE        ;
   v_opndt     DEPO_MM_MBAL.DMMOPNDT%TYPE       ;
   v_opncd     DEPO_MM_MBAL.DMMOPNCD%TYPE       ;
   v_clodt     DEPO_MM_MBAL.DMMCLODT%TYPE       ;
   v_clocd     DEPO_MM_MBAL.DMMCLOCD%TYPE       ;
   v_clbal     DEPO_MM_MBAL.DMMCLOBAL%TYPE      ;
   v_mbal      DEPO_MM_MBAL.DMM01MBAL%TYPE      ;

   v_cifno     DEPO_MM_MBAL.DMMCIFNO%TYPE       ;
   v_cifcd     DEPO_MM_MBAL.DMMCIFCD%TYPE       ;
   v_accd      DEPO_MM_MBAL.DMMACCD%TYPE        ;
   v_gdcd      DEPO_MM_MBAL.DMMGDCD%TYPE        ;
   v_expdt     DEPO_MM_MBAL.DMMEXPDT%TYPE       ;
   v_termm     DEPO_MM_MBAL.DMMTERMM%TYPE       ;
   v_conam     DEPO_MM_MBAL.DMMCONAM%TYPE       ;
   v_rate      DEPO_MM_MBAL.DMMRATE%TYPE        ;

   v_01mbal    DEPO_MM_MBAL.DMM01MBAL%TYPE := 0 ;
   v_02mbal    DEPO_MM_MBAL.DMM01MBAL%TYPE := 0 ;
   v_03mbal    DEPO_MM_MBAL.DMM01MBAL%TYPE := 0 ;
   v_04mbal    DEPO_MM_MBAL.DMM01MBAL%TYPE := 0 ;
   v_05mbal    DEPO_MM_MBAL.DMM01MBAL%TYPE := 0 ;
   v_06mbal    DEPO_MM_MBAL.DMM01MBAL%TYPE := 0 ;
   v_07mbal    DEPO_MM_MBAL.DMM01MBAL%TYPE := 0 ;
   v_08mbal    DEPO_MM_MBAL.DMM01MBAL%TYPE := 0 ;
   v_09mbal    DEPO_MM_MBAL.DMM01MBAL%TYPE := 0 ;
   v_10mbal    DEPO_MM_MBAL.DMM01MBAL%TYPE := 0 ;
   v_11mbal    DEPO_MM_MBAL.DMM01MBAL%TYPE := 0 ;
   v_12mbal    DEPO_MM_MBAL.DMM01MBAL%TYPE := 0 ;

   v_rcnt      numeric := 0                ;
   v_ucnt      numeric := 0                ;
   v_icnt      numeric := 0                ;
   v_ccnt      numeric := 0                ;
   v_scnt      numeric := 0                ;
   v_tcnt      numeric := 0                ;
   v_ycnt      numeric := 0                ;
   v_comit     numeric := 0                ;

   c1 CURSOR IS
         SELECT  dacacno,daccifno,daccifcd,dacopndt,dacopncd,dacgdcd,dacclodt,
	         dacclocd,dacclbal,decode(dacupddt,v_lstdt,dacxjbal,dacxhbal),
		 dacconam,dacexpdt,dactrrate,dactermm
         FROM    depo_mm_woltb
	 WHERE   dactrseq is null
	 AND    (dacclodt is null or dacclocd = '02' or
		 dacclodt like v_year||'%')   ;		 
BEGIN 

    exception
          WHEN unique_violation THEN
    RAISE NOTICE ' ' ;


   OPEN  c1 ;

   <<JAN_MAKE>>
   LOOP

       FETCH c1 INTO v_acno,v_cifno,v_cifcd,v_opndt,v_opncd,
		     v_gdcd,v_clodt,v_clocd,v_clbal,v_mbal,
		     v_conam,v_expdt,v_rate,v_termm ;
--       EXIT WHEN c1%NOTFOUND ;
IF NOT FOUND THEN
    EXIT;
END IF;


       v_rcnt := v_rcnt + 1 ;

       IF  v_clodt is not null and v_clocd != '02'  THEN
	   v_mbal := 0 ;
	   v_ccnt := v_ccnt + 1  ;
       END IF ;

       IF  v_month  = '01' THEN
           UPDATE DEPO_MM_MBAL
           SET  dmm01mbal = v_mbal,dmmclodt = v_clodt,dmmclocd = v_clocd,
		dmmcifno = v_cifno,dmmcifcd = v_cifcd,
                dmmconam = v_conam,dmmexpdt = v_expdt,
	        dmmrate = v_rate,dmmtermm = v_termm,
                dmmopncd = v_opncd,dmmclobal = v_clbal,dmmgdcd = v_gdcd
           WHERE dmmyear = v_year  and  dmmacno = v_acno  ;
-- 	   IF SQL%NOTFOUND THEN
-- 	      v_01mbal := v_mbal ;
IF NOT FOUND THEN
	      v_01mbal := v_mbal ;
	      
--	      GOTO INSERT_MM_MBAL ;
--{
--     <<INSERT_MM_MBAL>>

       v_accd  :=  substr(v_acno,4,2)  ;

       INSERT  INTO  DEPO_MM_MBAL
          (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,
           dmmopndt,dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,
	   dmm01mbal,dmm02mbal,dmm03mbal,dmm04mbal,dmm05mbal,dmm06mbal,
	   dmm07mbal,dmm08mbal,dmm09mbal,dmm10mbal,dmm11mbal,dmm12mbal,
	   dmmopncd,dmmclobal)
       VALUES(v_year,v_acno,v_cifno,v_cifcd,substr(v_acno,4,2),v_gdcd,
	      v_opndt,v_expdt,v_clodt,v_clocd,v_termm,v_conam,v_rate,
	      v_01mbal,v_02mbal,v_03mbal,v_04mbal,v_05mbal,v_06mbal,
	      v_07mbal,v_08mbal,v_09mbal,v_10mbal,v_11mbal,v_12mbal,
	      v_opncd,v_clbal ) ;

       v_icnt  := v_icnt  + sql%rowcount ; 
       v_comit := v_comit + sql%rowcount ;

       IF v_month  = '99' THEN   --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 2010.12.31 12->99 변경 
--	  GOTO NEW_YEAR ;
----{
--                     <<NEW_YEAR>>
                       IF v_clodt is null or v_clocd = '02' THEN
                          INSERT  INTO  DEPO_MM_MBAL
                                (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
	                         dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd)
                          select v_year1,v_acno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
                                 dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd
                          from  depo_mm_mbal
	                      where dmmyear = v_year and dmmacno = v_acno ;
                    
                          v_ycnt  := v_ycnt  + 1 ;
                          v_comit := v_comit + 1 ;
                       END IF ;

----}

					   ELSE
--          GOTO INSERT_END ;
----{
--             		  <<INSERT_END>>
                      if v_comit >= 50000  then
               	         commit ;
               	         v_comit := 0 ;
                      end if ;
----}
		  END IF ;
--}

           END IF ;

         ELSIF  v_month = '02' THEN
           UPDATE DEPO_MM_MBAL
           SET  dmm02mbal = v_mbal,dmmclodt = v_clodt,dmmclocd = v_clocd,
		dmmcifno = v_cifno,dmmcifcd = v_cifcd,
                dmmconam = v_conam,dmmexpdt = v_expdt,
	        dmmrate = v_rate,dmmtermm = v_termm,
                dmmopncd = v_opncd,dmmclobal = v_clbal,dmmgdcd = v_gdcd
           WHERE dmmyear = v_year  and  dmmacno = v_acno  ;
-- 	   IF SQL%NOTFOUND THEN
-- 	      v_02mbal := v_mbal ;
IF NOT FOUND THEN
 	      v_02mbal := v_mbal ;

--	      GOTO INSERT_MM_MBAL ;
--{
--     <<INSERT_MM_MBAL>>

       v_accd  :=  substr(v_acno,4,2)  ;

       INSERT  INTO  DEPO_MM_MBAL
          (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,
           dmmopndt,dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,
	   dmm01mbal,dmm02mbal,dmm03mbal,dmm04mbal,dmm05mbal,dmm06mbal,
	   dmm07mbal,dmm08mbal,dmm09mbal,dmm10mbal,dmm11mbal,dmm12mbal,
	   dmmopncd,dmmclobal)
       VALUES(v_year,v_acno,v_cifno,v_cifcd,substr(v_acno,4,2),v_gdcd,
	      v_opndt,v_expdt,v_clodt,v_clocd,v_termm,v_conam,v_rate,
	      v_01mbal,v_02mbal,v_03mbal,v_04mbal,v_05mbal,v_06mbal,
	      v_07mbal,v_08mbal,v_09mbal,v_10mbal,v_11mbal,v_12mbal,
	      v_opncd,v_clbal ) ;

       v_icnt  := v_icnt  + sql%rowcount ; 
       v_comit := v_comit + sql%rowcount ;

       IF v_month  = '99' THEN   --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 2010.12.31 12->99 변경 
--	  GOTO NEW_YEAR ;
----{
--                     <<NEW_YEAR>>
                       IF v_clodt is null or v_clocd = '02' THEN
                          INSERT  INTO  DEPO_MM_MBAL
                                (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
	                         dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd)
                          select v_year1,v_acno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
                                 dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd
                          from  depo_mm_mbal
	                      where dmmyear = v_year and dmmacno = v_acno ;
                    
                          v_ycnt  := v_ycnt  + 1 ;
                          v_comit := v_comit + 1 ;
                       END IF ;

----}

					   ELSE
--          GOTO INSERT_END ;
----{
--             		  <<INSERT_END>>
                      if v_comit >= 50000  then
               	         commit ;
               	         v_comit := 0 ;
                      end if ;
----}
		  END IF ;
--}

           END IF ;

         ELSIF  v_month = '03' THEN
           UPDATE DEPO_MM_MBAL
           SET  dmm03mbal = v_mbal,dmmclodt = v_clodt,dmmclocd = v_clocd,
		dmmcifno = v_cifno,dmmcifcd = v_cifcd,
                dmmconam = v_conam,dmmexpdt = v_expdt,
	        dmmrate = v_rate,dmmtermm = v_termm,
                dmmopncd = v_opncd,dmmclobal = v_clbal,dmmgdcd = v_gdcd
           WHERE dmmyear = v_year  and  dmmacno = v_acno  ;
-- 	   IF SQL%NOTFOUND THEN
-- 	      v_03mbal := v_mbal ;
IF NOT FOUND THEN
	      v_03mbal := v_mbal ;
--	      GOTO INSERT_MM_MBAL ;
--{
--     <<INSERT_MM_MBAL>>

       v_accd  :=  substr(v_acno,4,2)  ;

       INSERT  INTO  DEPO_MM_MBAL
          (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,
           dmmopndt,dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,
	   dmm01mbal,dmm02mbal,dmm03mbal,dmm04mbal,dmm05mbal,dmm06mbal,
	   dmm07mbal,dmm08mbal,dmm09mbal,dmm10mbal,dmm11mbal,dmm12mbal,
	   dmmopncd,dmmclobal)
       VALUES(v_year,v_acno,v_cifno,v_cifcd,substr(v_acno,4,2),v_gdcd,
	      v_opndt,v_expdt,v_clodt,v_clocd,v_termm,v_conam,v_rate,
	      v_01mbal,v_02mbal,v_03mbal,v_04mbal,v_05mbal,v_06mbal,
	      v_07mbal,v_08mbal,v_09mbal,v_10mbal,v_11mbal,v_12mbal,
	      v_opncd,v_clbal ) ;

       v_icnt  := v_icnt  + sql%rowcount ; 
       v_comit := v_comit + sql%rowcount ;

       IF v_month  = '99' THEN   --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 2010.12.31 12->99 변경 
--	  GOTO NEW_YEAR ;
----{
--                     <<NEW_YEAR>>
                       IF v_clodt is null or v_clocd = '02' THEN
                          INSERT  INTO  DEPO_MM_MBAL
                                (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
	                         dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd)
                          select v_year1,v_acno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
                                 dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd
                          from  depo_mm_mbal
	                      where dmmyear = v_year and dmmacno = v_acno ;
                    
                          v_ycnt  := v_ycnt  + 1 ;
                          v_comit := v_comit + 1 ;
                       END IF ;

----}

					   ELSE
--          GOTO INSERT_END ;
----{
--             		  <<INSERT_END>>
                      if v_comit >= 50000  then
               	         commit ;
               	         v_comit := 0 ;
                      end if ;
----}
		  END IF ;
--}

           END IF ;

         ELSIF  v_month = '04' THEN
           UPDATE DEPO_MM_MBAL
           SET  dmm04mbal = v_mbal,dmmclodt = v_clodt,dmmclocd = v_clocd,
		dmmcifno = v_cifno,dmmcifcd = v_cifcd,
                dmmconam = v_conam,dmmexpdt = v_expdt,
	        dmmrate = v_rate,dmmtermm = v_termm,
                dmmopncd = v_opncd,dmmclobal = v_clbal,dmmgdcd = v_gdcd
           WHERE dmmyear = v_year  and  dmmacno = v_acno  ;
-- 	   IF SQL%NOTFOUND THEN
-- 	      v_04mbal := v_mbal ;
IF NOT FOUND THEN
	      v_04mbal := v_mbal ;
    --	      GOTO INSERT_MM_MBAL ;
--{
--     <<INSERT_MM_MBAL>>

       v_accd  :=  substr(v_acno,4,2)  ;

       INSERT  INTO  DEPO_MM_MBAL
          (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,
           dmmopndt,dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,
	   dmm01mbal,dmm02mbal,dmm03mbal,dmm04mbal,dmm05mbal,dmm06mbal,
	   dmm07mbal,dmm08mbal,dmm09mbal,dmm10mbal,dmm11mbal,dmm12mbal,
	   dmmopncd,dmmclobal)
       VALUES(v_year,v_acno,v_cifno,v_cifcd,substr(v_acno,4,2),v_gdcd,
	      v_opndt,v_expdt,v_clodt,v_clocd,v_termm,v_conam,v_rate,
	      v_01mbal,v_02mbal,v_03mbal,v_04mbal,v_05mbal,v_06mbal,
	      v_07mbal,v_08mbal,v_09mbal,v_10mbal,v_11mbal,v_12mbal,
	      v_opncd,v_clbal ) ;

       v_icnt  := v_icnt  + sql%rowcount ; 
       v_comit := v_comit + sql%rowcount ;

       IF v_month  = '99' THEN   --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 2010.12.31 12->99 변경 
--	  GOTO NEW_YEAR ;
----{
--                     <<NEW_YEAR>>
                       IF v_clodt is null or v_clocd = '02' THEN
                          INSERT  INTO  DEPO_MM_MBAL
                                (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
	                         dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd)
                          select v_year1,v_acno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
                                 dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd
                          from  depo_mm_mbal
	                      where dmmyear = v_year and dmmacno = v_acno ;
                    
                          v_ycnt  := v_ycnt  + 1 ;
                          v_comit := v_comit + 1 ;
                       END IF ;

----}

					   ELSE
--          GOTO INSERT_END ;
----{
--             		  <<INSERT_END>>
                      if v_comit >= 50000  then
               	         commit ;
               	         v_comit := 0 ;
                      end if ;
----}
		  END IF ;
--}

           END IF ;

         ELSIF  v_month = '05' THEN
           UPDATE DEPO_MM_MBAL
           SET  dmm05mbal = v_mbal,dmmclodt = v_clodt,dmmclocd = v_clocd,
		dmmcifno = v_cifno,dmmcifcd = v_cifcd,
                dmmconam = v_conam,dmmexpdt = v_expdt,
	        dmmrate = v_rate,dmmtermm = v_termm,
                dmmopncd = v_opncd,dmmclobal = v_clbal,dmmgdcd = v_gdcd
           WHERE dmmyear = v_year  and  dmmacno = v_acno  ;
-- 	   IF SQL%NOTFOUND THEN
-- 	      v_05mbal := v_mbal ;
IF NOT FOUND THEN
	      v_05mbal := v_mbal ;

--	      GOTO INSERT_MM_MBAL ;
--{
--     <<INSERT_MM_MBAL>>

       v_accd  :=  substr(v_acno,4,2)  ;

       INSERT  INTO  DEPO_MM_MBAL
          (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,
           dmmopndt,dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,
	   dmm01mbal,dmm02mbal,dmm03mbal,dmm04mbal,dmm05mbal,dmm06mbal,
	   dmm07mbal,dmm08mbal,dmm09mbal,dmm10mbal,dmm11mbal,dmm12mbal,
	   dmmopncd,dmmclobal)
       VALUES(v_year,v_acno,v_cifno,v_cifcd,substr(v_acno,4,2),v_gdcd,
	      v_opndt,v_expdt,v_clodt,v_clocd,v_termm,v_conam,v_rate,
	      v_01mbal,v_02mbal,v_03mbal,v_04mbal,v_05mbal,v_06mbal,
	      v_07mbal,v_08mbal,v_09mbal,v_10mbal,v_11mbal,v_12mbal,
	      v_opncd,v_clbal ) ;

       v_icnt  := v_icnt  + sql%rowcount ; 
       v_comit := v_comit + sql%rowcount ;

       IF v_month  = '99' THEN   --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 2010.12.31 12->99 변경 
--	  GOTO NEW_YEAR ;
----{
--                     <<NEW_YEAR>>
                       IF v_clodt is null or v_clocd = '02' THEN
                          INSERT  INTO  DEPO_MM_MBAL
                                (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
	                         dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd)
                          select v_year1,v_acno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
                                 dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd
                          from  depo_mm_mbal
	                      where dmmyear = v_year and dmmacno = v_acno ;
                    
                          v_ycnt  := v_ycnt  + 1 ;
                          v_comit := v_comit + 1 ;
                       END IF ;

----}

					   ELSE
--          GOTO INSERT_END ;
----{
--             		  <<INSERT_END>>
                      if v_comit >= 50000  then
               	         commit ;
               	         v_comit := 0 ;
                      end if ;
----}
		  END IF ;
--}

           END IF ;

         ELSIF  v_month = '06' THEN
           UPDATE DEPO_MM_MBAL
           SET  dmm06mbal = v_mbal,dmmclodt = v_clodt,dmmclocd = v_clocd,
		dmmcifno = v_cifno,dmmcifcd = v_cifcd,
                dmmconam = v_conam,dmmexpdt = v_expdt,
	        dmmrate = v_rate,dmmtermm = v_termm,
                dmmopncd = v_opncd,dmmclobal = v_clbal,dmmgdcd = v_gdcd
           WHERE dmmyear = v_year  and  dmmacno = v_acno  ;
-- 	   IF SQL%NOTFOUND THEN
-- 	      v_06mbal := v_mbal ;
IF NOT FOUND THEN
 	      v_06mbal := v_mbal ;

--	      GOTO INSERT_MM_MBAL ;
--{
--     <<INSERT_MM_MBAL>>

       v_accd  :=  substr(v_acno,4,2)  ;

       INSERT  INTO  DEPO_MM_MBAL
          (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,
           dmmopndt,dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,
	   dmm01mbal,dmm02mbal,dmm03mbal,dmm04mbal,dmm05mbal,dmm06mbal,
	   dmm07mbal,dmm08mbal,dmm09mbal,dmm10mbal,dmm11mbal,dmm12mbal,
	   dmmopncd,dmmclobal)
       VALUES(v_year,v_acno,v_cifno,v_cifcd,substr(v_acno,4,2),v_gdcd,
	      v_opndt,v_expdt,v_clodt,v_clocd,v_termm,v_conam,v_rate,
	      v_01mbal,v_02mbal,v_03mbal,v_04mbal,v_05mbal,v_06mbal,
	      v_07mbal,v_08mbal,v_09mbal,v_10mbal,v_11mbal,v_12mbal,
	      v_opncd,v_clbal ) ;

       v_icnt  := v_icnt  + sql%rowcount ; 
       v_comit := v_comit + sql%rowcount ;

       IF v_month  = '99' THEN   --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 2010.12.31 12->99 변경 
--	  GOTO NEW_YEAR ;
----{
--                     <<NEW_YEAR>>
                       IF v_clodt is null or v_clocd = '02' THEN
                          INSERT  INTO  DEPO_MM_MBAL
                                (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
	                         dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd)
                          select v_year1,v_acno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
                                 dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd
                          from  depo_mm_mbal
	                      where dmmyear = v_year and dmmacno = v_acno ;
                    
                          v_ycnt  := v_ycnt  + 1 ;
                          v_comit := v_comit + 1 ;
                       END IF ;

----}

					   ELSE
--          GOTO INSERT_END ;
----{
--             		  <<INSERT_END>>
                      if v_comit >= 50000  then
               	         commit ;
               	         v_comit := 0 ;
                      end if ;
----}
		  END IF ;
--}

           END IF ;

         ELSIF  v_month = '07' THEN
           UPDATE DEPO_MM_MBAL
           SET  dmm07mbal = v_mbal,dmmclodt = v_clodt,dmmclocd = v_clocd,
		dmmcifno = v_cifno,dmmcifcd = v_cifcd,
                dmmconam = v_conam,dmmexpdt = v_expdt,
	        dmmrate = v_rate,dmmtermm = v_termm,
                dmmopncd = v_opncd,dmmclobal = v_clbal,dmmgdcd = v_gdcd
           WHERE dmmyear = v_year  and  dmmacno = v_acno  ;
-- 	   IF SQL%NOTFOUND THEN
-- 	      v_07mbal := v_mbal ;
IF NOT FOUND THEN
	      v_07mbal := v_mbal ;
--	      GOTO INSERT_MM_MBAL ;
--{
--     <<INSERT_MM_MBAL>>

       v_accd  :=  substr(v_acno,4,2)  ;

       INSERT  INTO  DEPO_MM_MBAL
          (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,
           dmmopndt,dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,
	   dmm01mbal,dmm02mbal,dmm03mbal,dmm04mbal,dmm05mbal,dmm06mbal,
	   dmm07mbal,dmm08mbal,dmm09mbal,dmm10mbal,dmm11mbal,dmm12mbal,
	   dmmopncd,dmmclobal)
       VALUES(v_year,v_acno,v_cifno,v_cifcd,substr(v_acno,4,2),v_gdcd,
	      v_opndt,v_expdt,v_clodt,v_clocd,v_termm,v_conam,v_rate,
	      v_01mbal,v_02mbal,v_03mbal,v_04mbal,v_05mbal,v_06mbal,
	      v_07mbal,v_08mbal,v_09mbal,v_10mbal,v_11mbal,v_12mbal,
	      v_opncd,v_clbal ) ;

       v_icnt  := v_icnt  + sql%rowcount ; 
       v_comit := v_comit + sql%rowcount ;

       IF v_month  = '99' THEN   --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 2010.12.31 12->99 변경 
--	  GOTO NEW_YEAR ;
----{
--                     <<NEW_YEAR>>
                       IF v_clodt is null or v_clocd = '02' THEN
                          INSERT  INTO  DEPO_MM_MBAL
                                (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
	                         dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd)
                          select v_year1,v_acno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
                                 dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd
                          from  depo_mm_mbal
	                      where dmmyear = v_year and dmmacno = v_acno ;
                    
                          v_ycnt  := v_ycnt  + 1 ;
                          v_comit := v_comit + 1 ;
                       END IF ;

----}

					   ELSE
--          GOTO INSERT_END ;
----{
--             		  <<INSERT_END>>
                      if v_comit >= 50000  then
               	         commit ;
               	         v_comit := 0 ;
                      end if ;
----}
		  END IF ;
--}

           END IF ;

         ELSIF  v_month = '08' THEN
           UPDATE DEPO_MM_MBAL
           SET  dmm08mbal = v_mbal,dmmclodt = v_clodt,dmmclocd = v_clocd,
		dmmcifno = v_cifno,dmmcifcd = v_cifcd,
                dmmconam = v_conam,dmmexpdt = v_expdt,
	        dmmrate = v_rate,dmmtermm = v_termm,
                dmmopncd = v_opncd,dmmclobal = v_clbal,dmmgdcd = v_gdcd
           WHERE dmmyear = v_year  and  dmmacno = v_acno  ;
-- 	   IF SQL%NOTFOUND THEN
-- 	      v_08mbal := v_mbal ;
IF NOT FOUND THEN
	      v_08mbal := v_mbal ;
--	      GOTO INSERT_MM_MBAL ;
--{
--     <<INSERT_MM_MBAL>>

       v_accd  :=  substr(v_acno,4,2)  ;

       INSERT  INTO  DEPO_MM_MBAL
          (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,
           dmmopndt,dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,
	   dmm01mbal,dmm02mbal,dmm03mbal,dmm04mbal,dmm05mbal,dmm06mbal,
	   dmm07mbal,dmm08mbal,dmm09mbal,dmm10mbal,dmm11mbal,dmm12mbal,
	   dmmopncd,dmmclobal)
       VALUES(v_year,v_acno,v_cifno,v_cifcd,substr(v_acno,4,2),v_gdcd,
	      v_opndt,v_expdt,v_clodt,v_clocd,v_termm,v_conam,v_rate,
	      v_01mbal,v_02mbal,v_03mbal,v_04mbal,v_05mbal,v_06mbal,
	      v_07mbal,v_08mbal,v_09mbal,v_10mbal,v_11mbal,v_12mbal,
	      v_opncd,v_clbal ) ;

       v_icnt  := v_icnt  + sql%rowcount ; 
       v_comit := v_comit + sql%rowcount ;

       IF v_month  = '99' THEN   --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 2010.12.31 12->99 변경 
--	  GOTO NEW_YEAR ;
----{
--                     <<NEW_YEAR>>
                       IF v_clodt is null or v_clocd = '02' THEN
                          INSERT  INTO  DEPO_MM_MBAL
                                (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
	                         dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd)
                          select v_year1,v_acno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
                                 dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd
                          from  depo_mm_mbal
	                      where dmmyear = v_year and dmmacno = v_acno ;
                    
                          v_ycnt  := v_ycnt  + 1 ;
                          v_comit := v_comit + 1 ;
                       END IF ;

----}

					   ELSE
--          GOTO INSERT_END ;
----{
--             		  <<INSERT_END>>
                      if v_comit >= 50000  then
               	         commit ;
               	         v_comit := 0 ;
                      end if ;
----}
		  END IF ;
--}

           END IF ;

         ELSIF  v_month = '09' THEN
           UPDATE DEPO_MM_MBAL
           SET  dmm09mbal = v_mbal,dmmclodt = v_clodt,dmmclocd = v_clocd,
		dmmcifno = v_cifno,dmmcifcd = v_cifcd,
                dmmconam = v_conam,dmmexpdt = v_expdt,
	        dmmrate = v_rate,dmmtermm = v_termm,
                dmmopncd = v_opncd,dmmclobal = v_clbal,dmmgdcd = v_gdcd
           WHERE dmmyear = v_year  and  dmmacno = v_acno  ;
-- 	   IF SQL%NOTFOUND THEN
-- 	      v_09mbal := v_mbal ;
IF NOT FOUND THEN
    v_09mbal := v_mbal ;

--	      GOTO INSERT_MM_MBAL ;
--{
--     <<INSERT_MM_MBAL>>

       v_accd  :=  substr(v_acno,4,2)  ;

       INSERT  INTO  DEPO_MM_MBAL
          (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,
           dmmopndt,dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,
	   dmm01mbal,dmm02mbal,dmm03mbal,dmm04mbal,dmm05mbal,dmm06mbal,
	   dmm07mbal,dmm08mbal,dmm09mbal,dmm10mbal,dmm11mbal,dmm12mbal,
	   dmmopncd,dmmclobal)
       VALUES(v_year,v_acno,v_cifno,v_cifcd,substr(v_acno,4,2),v_gdcd,
	      v_opndt,v_expdt,v_clodt,v_clocd,v_termm,v_conam,v_rate,
	      v_01mbal,v_02mbal,v_03mbal,v_04mbal,v_05mbal,v_06mbal,
	      v_07mbal,v_08mbal,v_09mbal,v_10mbal,v_11mbal,v_12mbal,
	      v_opncd,v_clbal ) ;

       v_icnt  := v_icnt  + sql%rowcount ; 
       v_comit := v_comit + sql%rowcount ;

       IF v_month  = '99' THEN   --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 2010.12.31 12->99 변경 
--	  GOTO NEW_YEAR ;
----{
--                     <<NEW_YEAR>>
                       IF v_clodt is null or v_clocd = '02' THEN
                          INSERT  INTO  DEPO_MM_MBAL
                                (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
	                         dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd)
                          select v_year1,v_acno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
                                 dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd
                          from  depo_mm_mbal
	                      where dmmyear = v_year and dmmacno = v_acno ;
                    
                          v_ycnt  := v_ycnt  + 1 ;
                          v_comit := v_comit + 1 ;
                       END IF ;

----}

					   ELSE
--          GOTO INSERT_END ;
----{
--             		  <<INSERT_END>>
                      if v_comit >= 50000  then
               	         commit ;
               	         v_comit := 0 ;
                      end if ;
----}
		  END IF ;
--}

           END IF ;

         ELSIF  v_month = '10' THEN
           UPDATE DEPO_MM_MBAL
           SET  dmm10mbal = v_mbal,dmmclodt = v_clodt,dmmclocd = v_clocd,
		dmmcifno = v_cifno,dmmcifcd = v_cifcd,
                dmmconam = v_conam,dmmexpdt = v_expdt,
	        dmmrate = v_rate,dmmtermm = v_termm,
                dmmopncd = v_opncd,dmmclobal = v_clbal,dmmgdcd = v_gdcd
           WHERE dmmyear = v_year  and  dmmacno = v_acno  ;
-- 	   IF SQL%NOTFOUND THEN
-- 	      v_10mbal := v_mbal ;
IF NOT FOUND THEN
	      v_10mbal := v_mbal ;
--	      GOTO INSERT_MM_MBAL ;
--{
--     <<INSERT_MM_MBAL>>

       v_accd  :=  substr(v_acno,4,2)  ;

       INSERT  INTO  DEPO_MM_MBAL
          (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,
           dmmopndt,dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,
	   dmm01mbal,dmm02mbal,dmm03mbal,dmm04mbal,dmm05mbal,dmm06mbal,
	   dmm07mbal,dmm08mbal,dmm09mbal,dmm10mbal,dmm11mbal,dmm12mbal,
	   dmmopncd,dmmclobal)
       VALUES(v_year,v_acno,v_cifno,v_cifcd,substr(v_acno,4,2),v_gdcd,
	      v_opndt,v_expdt,v_clodt,v_clocd,v_termm,v_conam,v_rate,
	      v_01mbal,v_02mbal,v_03mbal,v_04mbal,v_05mbal,v_06mbal,
	      v_07mbal,v_08mbal,v_09mbal,v_10mbal,v_11mbal,v_12mbal,
	      v_opncd,v_clbal ) ;

       v_icnt  := v_icnt  + sql%rowcount ; 
       v_comit := v_comit + sql%rowcount ;

       IF v_month  = '99' THEN   --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 2010.12.31 12->99 변경 
--	  GOTO NEW_YEAR ;
----{
--                     <<NEW_YEAR>>
                       IF v_clodt is null or v_clocd = '02' THEN
                          INSERT  INTO  DEPO_MM_MBAL
                                (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
	                         dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd)
                          select v_year1,v_acno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
                                 dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd
                          from  depo_mm_mbal
	                      where dmmyear = v_year and dmmacno = v_acno ;
                    
                          v_ycnt  := v_ycnt  + 1 ;
                          v_comit := v_comit + 1 ;
                       END IF ;

----}

					   ELSE
--          GOTO INSERT_END ;
----{
--             		  <<INSERT_END>>
                      if v_comit >= 50000  then
               	         commit ;
               	         v_comit := 0 ;
                      end if ;
----}
		  END IF ;
--}
           END IF ;

         ELSIF  v_month = '11' THEN
           UPDATE DEPO_MM_MBAL
           SET  dmm11mbal = v_mbal,dmmclodt = v_clodt,dmmclocd = v_clocd,
		dmmcifno = v_cifno,dmmcifcd = v_cifcd,
                dmmconam = v_conam,dmmexpdt = v_expdt,
	        dmmrate = v_rate,dmmtermm = v_termm,
                dmmopncd = v_opncd,dmmclobal = v_clbal,dmmgdcd = v_gdcd
           WHERE dmmyear = v_year  and  dmmacno = v_acno  ;
-- 	   IF SQL%NOTFOUND THEN
-- 	      v_11mbal := v_mbal ;
IF NOT FOUND THEN
	      v_11mbal := v_mbal ;

--	      GOTO INSERT_MM_MBAL ;
--{
--     <<INSERT_MM_MBAL>>

       v_accd  :=  substr(v_acno,4,2)  ;

       INSERT  INTO  DEPO_MM_MBAL
          (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,
           dmmopndt,dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,
	   dmm01mbal,dmm02mbal,dmm03mbal,dmm04mbal,dmm05mbal,dmm06mbal,
	   dmm07mbal,dmm08mbal,dmm09mbal,dmm10mbal,dmm11mbal,dmm12mbal,
	   dmmopncd,dmmclobal)
       VALUES(v_year,v_acno,v_cifno,v_cifcd,substr(v_acno,4,2),v_gdcd,
	      v_opndt,v_expdt,v_clodt,v_clocd,v_termm,v_conam,v_rate,
	      v_01mbal,v_02mbal,v_03mbal,v_04mbal,v_05mbal,v_06mbal,
	      v_07mbal,v_08mbal,v_09mbal,v_10mbal,v_11mbal,v_12mbal,
	      v_opncd,v_clbal ) ;

       v_icnt  := v_icnt  + sql%rowcount ; 
       v_comit := v_comit + sql%rowcount ;

       IF v_month  = '99' THEN   --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 2010.12.31 12->99 변경 
--	  GOTO NEW_YEAR ;
----{
--                     <<NEW_YEAR>>
                       IF v_clodt is null or v_clocd = '02' THEN
                          INSERT  INTO  DEPO_MM_MBAL
                                (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
	                         dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd)
                          select v_year1,v_acno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
                                 dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd
                          from  depo_mm_mbal
	                      where dmmyear = v_year and dmmacno = v_acno ;
                    
                          v_ycnt  := v_ycnt  + 1 ;
                          v_comit := v_comit + 1 ;
                       END IF ;

----}

					   ELSE
--          GOTO INSERT_END ;
----{
--             		  <<INSERT_END>>
                      if v_comit >= 50000  then
               	         commit ;
               	         v_comit := 0 ;
                      end if ;
----}
		  END IF ;
--}

           END IF ;

         ELSE
           UPDATE DEPO_MM_MBAL
           SET  dmm12mbal = v_mbal,dmmclodt = v_clodt,dmmclocd = v_clocd,
		dmmcifno = v_cifno,dmmcifcd = v_cifcd,
                dmmconam = v_conam,dmmexpdt = v_expdt,
	        dmmrate = v_rate,dmmtermm = v_termm,
                dmmopncd = v_opncd,dmmclobal = v_clbal,dmmgdcd = v_gdcd
           WHERE dmmyear = v_year  and  dmmacno = v_acno  ;
-- 	   IF SQL%NOTFOUND THEN
-- 	      v_12mbal := v_mbal ;
IF NOT FOUND THEN
	      v_12mbal := v_mbal ;

--	      GOTO INSERT_MM_MBAL ;
--{
--     <<INSERT_MM_MBAL>>

       v_accd  :=  substr(v_acno,4,2)  ;

       INSERT  INTO  DEPO_MM_MBAL
          (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,
           dmmopndt,dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,
	   dmm01mbal,dmm02mbal,dmm03mbal,dmm04mbal,dmm05mbal,dmm06mbal,
	   dmm07mbal,dmm08mbal,dmm09mbal,dmm10mbal,dmm11mbal,dmm12mbal,
	   dmmopncd,dmmclobal)
       VALUES(v_year,v_acno,v_cifno,v_cifcd,substr(v_acno,4,2),v_gdcd,
	      v_opndt,v_expdt,v_clodt,v_clocd,v_termm,v_conam,v_rate,
	      v_01mbal,v_02mbal,v_03mbal,v_04mbal,v_05mbal,v_06mbal,
	      v_07mbal,v_08mbal,v_09mbal,v_10mbal,v_11mbal,v_12mbal,
	      v_opncd,v_clbal ) ;

       v_icnt  := v_icnt  + sql%rowcount ; 
       v_comit := v_comit + sql%rowcount ;

       IF v_month  = '99' THEN   --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 2010.12.31 12->99 변경 
--	  GOTO NEW_YEAR ;
----{
--                     <<NEW_YEAR>>
                       IF v_clodt is null or v_clocd = '02' THEN
                          INSERT  INTO  DEPO_MM_MBAL
                                (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
	                         dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd)
                          select v_year1,v_acno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
                                 dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd
                          from  depo_mm_mbal
	                      where dmmyear = v_year and dmmacno = v_acno ;
                    
                          v_ycnt  := v_ycnt  + 1 ;
                          v_comit := v_comit + 1 ;
                       END IF ;

----}

					   ELSE
--          GOTO INSERT_END ;
----{
--             		  <<INSERT_END>>
                      if v_comit >= 50000  then
               	         commit ;
               	         v_comit := 0 ;
                      end if ;
----}
		  END IF ;
--}

           END IF ;

--           GOTO NEW_YEAR ;
----{
--                     <<NEW_YEAR>>
                       IF v_clodt is null or v_clocd = '02' THEN
                          INSERT  INTO  DEPO_MM_MBAL
                                (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
	                         dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd)
                          select v_year1,v_acno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
                                 dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd
                          from  depo_mm_mbal
	                      where dmmyear = v_year and dmmacno = v_acno ;
                    
                          v_ycnt  := v_ycnt  + 1 ;
                          v_comit := v_comit + 1 ;
                       END IF ;

----}

       END IF  ;

       v_ucnt  := v_ucnt  + 1 ;
       v_comit := v_comit + 1 ;

--       GOTO INSERT_END ;
----{
--             		  <<INSERT_END>>
                      if v_comit >= 50000  then
               	         commit ;
               	         v_comit := 0 ;
                      end if ;
----}

       IF v_month  = '99' THEN   --&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 2010.12.31 12->99 변경 
--	  GOTO NEW_YEAR ;
--{
--       <<NEW_YEAR>>
       IF v_clodt is null or v_clocd = '02' THEN
          INSERT  INTO  DEPO_MM_MBAL
                (dmmyear,dmmacno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
	         dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd)
          select v_year1,v_acno,dmmcifno,dmmcifcd,dmmaccd,dmmgdcd,dmmopndt,
                 dmmexpdt,dmmclodt,dmmclocd,dmmtermm,dmmconam,dmmrate,dmmopncd
          from  depo_mm_mbal
	  where dmmyear = v_year and dmmacno = v_acno ;

          v_ycnt  := v_ycnt  + 1 ;
          v_comit := v_comit + 1 ;
       END IF ;
--}


        ELSE
--        GOTO INSERT_END ;
--{
--       <<INSERT_END>>
       if v_comit >= 50000  then
	  commit ;
	  v_comit := 0 ;
       end if ;
--}
       END IF ;


   END LOOP  JAN_MAKE ;

   COMMIT ;

   CLOSE c1 ;

   RAISE NOTICE ' ' ;
   RAISE NOTICE '*** 월말 잔액 UPDATE JOB  *** ' ;
   RAISE NOTICE ' ' ;
   RAISE NOTICE '  --  월말작업일자 = ',v_lstdt,'**** ' ;
   RAISE NOTICE ' ' ;
   RAISE NOTICE '  --  READ   건수 = ',v_rcnt,' 건 ---' ;
   RAISE NOTICE '  --  UPDATE 건수 = ',v_ucnt,' 건 ---' ;
   RAISE NOTICE '  --  신규   건수 = ',v_icnt,' 건 ---' ;
   RAISE NOTICE '  --  해지   건수 = ',v_ccnt,' 건 ---' ;
   RAISE NOTICE '  -- NEW_YEAR건수 = ',v_ycnt,' 건 ---' ;
   RAISE NOTICE ' ' ;
   RAISE NOTICE '*** 월말 잔액 UPDATE JOB END *** ' ;
   RAISE NOTICE '****                 **** ' ;
END; 
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.depo_mm_janmk() OWNER TO letl;

--
-- Name: depo_mm_wolmk(); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION depo_mm_wolmk() RETURNS void
    AS $$ 
--BGN : Use Case--------------------------------------------------------



--END : Use Case--------------------------------------------------------

DECLARE
  v_basdt char(8) := TO_CHAR(LAST_DAY(ADD_MONTHS(to_date('20130501', 'yyyymmdd')+7,-1)),'YYYYMMDD') ;
  v_basyr char(4) := substr(v_basdt,1,4) ;
  vacno   char(12)          ;
  vdepcn  numeric(4)         ;
  vconam  numeric(15)        ;
  vdueam  numeric(15)        ;
  vdepcd  char(1)           ;
  vcifcd  char(2)           ;
  vfundcd char(3)           ;
  vintcd  char(1)           ;
  vintpt  char(1)           ;
  vypcd   char(1)           ;
  vypter  char(1)           ;
  vyexdt  char(8)           ;
  vypydt  char(8)           ;
  vpam    numeric(15)        ;
  vinicn  numeric(4)         ;
  vrate   numeric(7,4)       ;
  vexpdt  char(8)           ;
  vschool char(2)           ;
  vgyemm  numeric(4)         ;
  vgyedd  numeric(4)         ;
  vterdt  numeric(3)         ;
  vtercd  char(1)           ;
  vtermm  numeric(4)         ;
  v_rcnt0 numeric  := 0 ;
  v_rcnt1 numeric  := 0 ;
  v_rcnt2 numeric  := 0 ;
  v_wcnt  numeric  := 0 ;
  v_wcnt0 numeric  := 0 ;
  v_wcnt1 numeric  := 0 ;
  v_wcnt2 numeric  := 0 ;
  v_wcnt9 numeric  := 0 ;


  integer_var integer;

  /*-------------------------------------------------------------*/
  /*- 환매체 고객자격 처리변경(98==>daccifcd) 2007.3.13 abt      */
  /*-------------------------------------------------------------*/

   c0 CURSOR IS   SELECT   dacacno,daccifcd
		 FROM     depo_ac_comm
		 WHERE    (nvl(dacgdcd,'000') = '054' or dacaccd = '37')
		 AND     (dacclodt is null or dacclodt like v_basyr||'%') ;


   c1 CURSOR IS
	 SELECT  dsjacno,dsjdepcn,dsjconam,dsjtrrate,dsjterdt,dsjtercd,
		     dsjdueam,dsjintcd,'','','','','',0,0,'',
	         decode(dsjexpdt,'00000000',
		      to_char(add_months(to_date(dsjopndt,'yyyymmdd'),dsjtermm),
			      'yyyymmdd'),dsjexpdt),
             dsjschool,dsjtermm,dsjterdd,
             decode(dsjexpdt,'00000000',dsjtermm,
		     ceil(months_between(to_date(dsjexpdt,'yyyymmdd'),
		                          to_date(dsjopndt,'yyyymmdd')))),''
	 FROM  depo_sj_mas
         where   dsjaccd != '37' and nvl(dsjgdcd,'000') != '054'
	     and    (dsjclodt is null or dsjclodt like v_basyr||'%')
     union all
     select  dtracno,dtrdepcn,decode(dtrtercd,'1',dtrconam,0),dtrtrrate,
                 dtrterdt,dtrtercd,dtrdueam,dtrintcd,dtrintpt,dtrypcd,
                 nvl(dtrypter,'1'),dtryexdt,dtrypydt,dtrpam,dtrinicn,dtrdepcd,
                 decode(dtrexpdt,'00000000',
                     to_char(add_months(to_date(dtropndt,'yyyymmdd'),dtrtermm),
  	                     'yyyymmdd'),'99999999',dtropndt,dtrexpdt),
                    '',dtrtermm,dtrterdd,
          decode(dtrexpdt,'00000000',dtrtermm,'99999999',dtrtermm,'99991231',dtrtermm,
                 ceil(months_between(to_date(dtrexpdt,'yyyymmdd'),
  	                     to_date(dtropndt,'yyyymmdd')))),''
     from    depo_tr_mas
        where   dtraccd not in ('56','58')
         and    (dtrclodt is null or dtrclodt like v_basyr||'%')
     union all
     select  drgacno,0,0,drgbrate,0,'',0,'','','','','','',0,0,'',
             drgexpdt,'',drgbterm,0,drgbterm,drgbjong
     from    depo_rg_bond
         where   drgopndt <= v_basdt
         and    (drgclodt is null or drgclodt like v_basyr||'%') ;

   c2 CURSOR IS SELECT dexacno,dexcode FROM   depo_ex_inf
	       WHERE  substr(dexacno,4,2) in ('39','40','42','44','49','50',
		                                  '51','52','53','54','55','56',
                                          '57','58','64','65','70','79')
             AND    dexcode is not null ;

		 
BEGIN 

    exception
          WHEN unique_violation THEN
    RAISE NOTICE ' ' ;

    TRUNCATE TABLE DEPO_MM_WOLTB;

    INSERT INTO DEPO_MM_WOLTB
          (dacacno,daccifno,daccifcd,dacopndt,dacopncd,dacclodt,
           dacclocd,dacupddt,dacxjbal,dacxhbal,dacclbal,dacgdcd,dacacbr)
    SELECT dacacno,daccifno,daccifcd,dacopndt,dacopncd,dacclodt,
           dacclocd,dacupddt,dacxjbal,dacxhbal,dacclbal,dacgdcd,dacacbr
    FROM   DEPO_AC_COMM
    WHERE  dacclodt is null or dacclocd = '02' or dacclodt like v_basyr||'%' ;

    GET DIAGNOSTICS integer_var = ROW_COUNT;
    
    v_wcnt := v_wcnt + integer_var ;
--    v_wcnt := v_wcnt + sql%rowcount ;
    commit ;

    INSERT INTO DEPO_MM_WOLTB
	  (dacacno,dactrseq,daccifno,daccifcd,dacopndt,dacopncd,dacclodt,
	   dacclocd,dacupddt,dacexpdt,dacxjbal,dacxhbal,dacclbal,dacconam,
	   dacgdcd,dacschool,dactermm,dacgyemm,dacgyedd,dacdepcn,dactrrate,
       dacacbr)
    SELECT dsjacno,dsjtrseq,dsjcifno,'98',dsjopndt,dsjopncd,dsjclodt,
	   dsjclocd,dsjopndt,dsjexpdt,dsjxjbal,dsjxhbal,dsjclbal,dsjconam,
	   dsjgdcd,dsjschool,
           ceil(months_between(to_date(dsjexpdt,'yyyymmdd'),
			       to_date(dsjopndt,'yyyymmdd'))),
	   dsjtermm,dsjterdd,dsjdepcn,dsjtrrate,substr(dsjacno,1,3)
    FROM   DEPO_SJ_MAS
    WHERE (dsjaccd = '37' or nvl(dsjgdcd,'000') = '054')
    AND   (dsjclodt is null  or nvl(dsjclodt,dsjexpdt) like v_basyr||'%')  ;

    v_wcnt := v_wcnt + sql%rowcount ;
    commit ;

    OPEN  c0 ;

   <<CIFCD_054>>
   LOOP

       FETCH c0 INTO vacno,vcifcd ;
       EXIT WHEN c0%NOTFOUND ;

       v_rcnt0 := v_rcnt0 + 1 ;

       UPDATE DEPO_MM_WOLTB
       SET    daccifcd = vcifcd
       WHERE  dacacno = vacno ;

       v_wcnt0 := v_wcnt0 + sql%rowcount ;

       if sql%notfound then
	  v_wcnt9 := v_wcnt9 + 1 ;
	  null ;
       end if ;

   END LOOP CIFCD_054 ;


   COMMIT ;

   CLOSE c0 ;

   OPEN  c1 ;

   <<SJ_TR_MAS>>
   LOOP

       FETCH c1 INTO vacno,vdepcn,vconam,vrate,vterdt,vtercd,vdueam,
		     vintcd,vintpt,vypcd,vypter,vyexdt,vypydt,vpam,vinicn,
		     vdepcd,vexpdt,vschool,vgyemm,vgyedd,vtermm,vfundcd ;
       EXIT WHEN c1%NOTFOUND ;

       v_rcnt1 := v_rcnt1 + 1 ;

       UPDATE DEPO_MM_WOLTB
       SET    dacdepcn = vdepcn,dacconam = vconam,dacexpdt = vexpdt,
	      dacschool = vschool,dactermm = vtermm,dactrrate = vrate,
	      dacterdt  = vterdt,dactercd  = vtercd,dacdueam = vdueam,
	      dacintcd  = vintcd,dacintpt  = vintpt,dacypcd  = vypcd,
	      dacypter  = vypter,dacyexdt  = vyexdt,dacypydt = vypydt,
	      dacpam    = vpam,dacinicn = vinicn,dacdepcd = vdepcd,
	      dacgyemm  = vgyemm,dacgyedd = vgyedd,dacfundcd = vfundcd
       WHERE  dacacno = vacno and dactrseq is null ;
       v_wcnt1 := v_wcnt1 + sql%rowcount ;

       if sql%notfound then
	  v_wcnt9 := v_wcnt9 + 1 ;
	  null ;
       end if ;

   END LOOP SJ_TR_MAS ;

   COMMIT ;

   CLOSE c1 ;

   OPEN  c2 ;

   <<SINTAK_FUND>>
   LOOP

       FETCH c2 INTO vacno,vfundcd ;
       EXIT WHEN c2%NOTFOUND ;

       v_rcnt2 := v_rcnt2 + 1 ;

       UPDATE DEPO_MM_WOLTB
       SET    dacfundcd = vfundcd
       WHERE  dacacno = vacno and dactrseq is null ;
       v_wcnt2 := v_wcnt2 + sql%rowcount ;

       if sql%notfound then
	  null ;
       end if ;

   END LOOP SINTAK_FUND ;

   COMMIT ;

   CLOSE c2 ;
  
  
  /*-------------------------------------------------------------*/
  /*- 특정금전신탁 만기일 처리위하여 문장변경 2010.06.01.  kkh        */
  /*-------------------------------------------------------------*/
 /*
   UPDATE DEPO_MM_WOLTB
   SET    dacnxtrm = ceil(months_between(
          to_date(decode(dacexpdt,'99999999','99991231',dacexpdt),'yyyymmdd'),
			                 to_date(v_basdt,'yyyymmdd')))
   WHERE  dacexpdt is not null ;
  */
  
    UPDATE DEPO_MM_WOLTB
    SET    dacnxtrm = decode(dacexpdt,'99999999',9999,'99991231',9999,
                  ceil(months_between(to_date(decode(dacexpdt,'99999999','99991231',dacexpdt),'yyyymmdd'),to_date(v_basdt,'yyyymmdd'))))
    WHERE  dacexpdt is not null ;

   COMMIT ;



--   dbms_output.put_line('***') ;
--   dbms_output.put_line('*** 수신 계좌 월말 원장 BACK-UP 작업 ***') ;
--   dbms_output.put_line('*** 기준일  = '||v_basdt) ;
--   dbms_output.put_line('*** BACK-UP 건수 = '||to_char(v_wcnt)||' 건 ***') ;
--   dbms_output.put_line('*** Ok정기예금 건수 = '||to_char(v_rcnt0)||' 건 ***') ;
--   dbms_output.put_line('*** Ok UPDATE  건수 = '||to_char(v_wcnt0)||' 건 ***') ;
--   dbms_output.put_line('*** 저축,신탁 건수 = '||to_char(v_rcnt1)||' 건 ***') ;
--   dbms_output.put_line('*** UPDATE 건수 = '||to_char(v_wcnt1)||' 건 ***') ;
--   dbms_output.put_line('*** NOTFND 건수 = '||to_char(v_wcnt9)||' 건 ***') ;
--   dbms_output.put_line('***') ;
--   dbms_output.put_line('*** 신탁 FUND 건수 = '||to_char(v_rcnt2)||' 건 ***') ;
--   dbms_output.put_line('*** UPDATE 건수 = '||to_char(v_wcnt2)||' 건 ***') ;
--   dbms_output.put_line('***') ;

raise notice '***' ;
raise notice '*** 수신 계좌 월말 원장 BACK-UP 작업 ***' ;
raise notice '*** 기준일  = ', v_basdt ;
raise notice '*** BACK-UP 건수 = ',to_char(v_wcnt),' 건 ***' ;
raise notice '*** Ok정기예금 건수 = ',to_char(v_rcnt0),' 건 ***' ;
raise notice '*** Ok UPDATE  건수 = ',to_char(v_wcnt0),' 건 ***' ;
raise notice '*** 저축,신탁 건수 = ',to_char(v_rcnt1),' 건 ***' ;
raise notice '*** UPDATE 건수 = ',to_char(v_wcnt1),' 건 ***' ;
raise notice '*** NOTFND 건수 = ',to_char(v_wcnt9),' 건 ***' ;
raise notice '***' ;
raise notice '*** 신탁 FUND 건수 = ',to_char(v_rcnt2),' 건 ***' ;
raise notice '*** UPDATE 건수 = ',to_char(v_wcnt2),' 건 ***' ;
raise notice '***' ;

END; 
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.depo_mm_wolmk() OWNER TO letl;

--
-- Name: fngetemp(character varying, character varying); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION fngetemp(i_empno character varying, i_kind character varying) RETURNS character varying
    AS $$
declare
	o_empno			Varchar(6);
	o_empnm			Varchar(20);
BEGIN 

	SELECT	CASE WHEN (SUBSTR(i_empno,1,1) IN ('1','2','3','4','5','6')) THEN
				(CHR(64+TO_NUMBER(SUBSTR(i_empno,1,1))))||SUBSTR(i_empno,2,5)   
			WHEN (SUBSTR(i_empno,1,1) IN ('A','B','C','D','E','F')) THEN
				DECODE(SUBSTR(i_empno,1,1),'A','1','B','2','C','3','D','4','E','5','F','6')||SUBSTR(i_empno,2,5)   
			ELSE
				i_empno
			END
	INTO	o_empno;


-- 2010.03.04 - By Shin Kyung Seop
-- 2010년도 신입행원의 행번은 1로 시작함. 기존의 A로 시작하는 행번과 혼동됨. 
-- (계정계 데이터는 A를 1로 치환하여 로그를 발행함. -> 정보계에서 다시 A를 1로 치환하여 처리함.)
-- 그러나, 뒷자리 5자리까지 동일한 행번은 경남은행에서 생성하지 않음.
-- 따라서 아래와 같이 IN 을 이용하여 처리함.

	SELECT	MAX(zepempno),MAX(zepname)
	INTO	o_empno,o_empnm
	FROM	comm_ep_emp
	WHERE	zepempno IN (o_empno,i_empno);


	IF (i_kind = 'EMPNO') THEN
		RETURN 	o_empno;
	ELSIF (i_kind = 'EMPNAME') THEN
		RETURN 	o_empnm;
	ELSE
		RETURN 	'-1';	
	END IF;	

EXCEPTION WHEN OTHERS THEN
	RETURN '-9';
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.fngetemp(i_empno character varying, i_kind character varying) OWNER TO letl;

--
-- Name: fu_da_emp_nm(character varying); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION fu_da_emp_nm(i_emp_no character varying) RETURNS character varying
    AS $$
declare
    V_RET_VAL   Varchar(20);
    
BEGIN
    V_RET_VAL := ' ';

    SELECT
        NVL(
            (
            SELECT DISTINCT
                NVL(ZEPNAME, ' ') AS ZEPNAME
            FROM COMM_EP_EMP
            WHERE ZEPEMPNO = I_EMP_NO
            --  AND ROWNUM = 1
            ), ' ')
    INTO V_RET_VAL;   
    
        
    RETURN (V_RET_VAL); --// NOTE //

END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.fu_da_emp_nm(i_emp_no character varying) OWNER TO letl;

--
-- Name: fu_da_psbz_nm(character varying); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION fu_da_psbz_nm(i_psbz_no character varying) RETURNS character varying
    AS $$
declare

    V_RET_VAL   Varchar(100);
    
BEGIN
    V_RET_VAL := ' ';

    SELECT
        NVL(
            (
            SELECT 
                REPLACE(CBAEOBNAME,' ','')||REPLACE(CBANAME,' ','')
            FROM CUST_BA_BASE
            WHERE CBACIDNO = I_PSBZ_NO
            ), ' ')
    INTO V_RET_VAL;    
    
        
    RETURN (V_RET_VAL); --// NOTE //

END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.fu_da_psbz_nm(i_psbz_no character varying) OWNER TO letl;

--
-- Name: getdate(character varying, character varying); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION getdate(i_basedt character varying, i_gubun character varying) RETURNS character varying
    AS $$
DECLARE
o_date character varying(8);
BEGIN
	/* 전일 */
	IF i_gubun = '#YMBD' THEN
		SELECT befdt(i_basedt)
		INTO o_date;
		
	END IF;

	/* 당일 */
	IF i_gubun = '#YMD' THEN
		SELECT i_basedt
		INTO o_date;
		
	END IF;

	/* 전월 */
	IF i_gubun = '#YBM' THEN
		SELECT befdt(substr(i_basedt,1,6)||'01')
		INTO o_date;
		
	END IF;

	/* 당월 */
	IF i_gubun = '#YM' THEN
		SELECT menddt(i_basedt)
		INTO o_date;
		
	END IF;

	/* 전분기 */
	IF i_gubun = '#YBQ' THEN
		SELECT case when substr(i_basedt,5,2) in ('01','02','03') then befdt(substr(i_basedt,1,4)||'0101')
					when substr(i_basedt,5,2) in ('04','05','06') then befdt(substr(i_basedt,1,4)||'0401')
					when substr(i_basedt,5,2) in ('07','08','09') then befdt(substr(i_basedt,1,4)||'0701')
					when substr(i_basedt,5,2) in ('10','11','12') then befdt(substr(i_basedt,1,4)||'1001')
				end
		INTO o_date;
		
	END IF;

	/* 당분기 */
	IF i_gubun = '#YQ' THEN
		SELECT case when substr(i_basedt,5,2) in ('01','02','03') then menddt(substr(i_basedt,1,4)||'0301')
					when substr(i_basedt,5,2) in ('04','05','06') then menddt(substr(i_basedt,1,4)||'0601')
					when substr(i_basedt,5,2) in ('07','08','09') then menddt(substr(i_basedt,1,4)||'0901')
					when substr(i_basedt,5,2) in ('10','11','12') then menddt(substr(i_basedt,1,4)||'1201')
				end
		INTO o_date;
		
	END IF;

	/* 1분기 */
	IF i_gubun = '#YQ1' THEN
		SELECT menddt(substr(i_basedt,1,4)||'0301')
		INTO o_date;
		
	END IF;

	/* 2분기 */
	IF i_gubun = '#YQ2' THEN
		SELECT menddt(substr(i_basedt,1,4)||'0601')
		INTO o_date;
		
	END IF;

	/* 3분기 */
	IF i_gubun = '#YQ3' THEN
		SELECT menddt(substr(i_basedt,1,4)||'0901')
		INTO o_date;
		
	END IF;

	/* 4분기 */
	IF i_gubun = '#YQ4' THEN
		SELECT menddt(substr(i_basedt,1,4)||'1201')
		INTO o_date;
		
	END IF;

	/* 전반기 */
	IF i_gubun = '#BHY' THEN
		SELECT case when substr(i_basedt,5,2) in ('01','02','03','04','05','06') then befdt(substr(i_basedt,1,4)||'0101')
					when substr(i_basedt,5,2) in ('07','08','09','10','11','12') then befdt(substr(i_basedt,1,4)||'0701')
				end
		INTO o_date;
		
	END IF;

	/* 당반기 */
	IF i_gubun = '#HY' THEN
		SELECT case when substr(i_basedt,5,2) in ('01','02','03','04','05','06') then menddt(substr(i_basedt,1,4)||'0601')
					when substr(i_basedt,5,2) in ('07','08','09','10','11','12') then menddt(substr(i_basedt,1,4)||'1201')
				end
		INTO o_date;
		
	END IF;

	/* 상반기 */
	IF i_gubun = '#HY1' THEN
		SELECT menddt(substr(i_basedt,1,4)||'0601')
		INTO o_date;
		
	END IF;

	/* 하반기 */
	IF i_gubun = '#HY2' THEN
		SELECT menddt(substr(i_basedt,1,4)||'1201')
		INTO o_date;
		
	END IF;

	/* 전년 */
	IF i_gubun = '#BY' THEN
		SELECT befdt(substr(i_basedt,1,4)||'0101')
		INTO o_date;
		
	END IF;

	/* 당년 */
	IF i_gubun = '#Y' THEN
		SELECT menddt(substr(i_basedt,1,4)||'1201')
		INTO o_date;
		
	END IF;

	/* 일별 : 1 */
	IF i_gubun = '1' THEN
		SELECT decode(offdt(i_basedt),'1',befdt(i_basedt),i_basedt)
		INTO o_date;
		
	END IF;

	/* 월 : 2 */
	IF i_gubun = '2' THEN
		SELECT menddt(i_basedt)
		INTO o_date;
		
	END IF;

	/* 분기 : 3 */
	IF i_gubun = '3' THEN
		SELECT case when substr(i_basedt,5,2) in ('01','02','03') then menddt(substr(i_basedt,1,4)||'0301')
					when substr(i_basedt,5,2) in ('04','05','06') then menddt(substr(i_basedt,1,4)||'0601')
					when substr(i_basedt,5,2) in ('07','08','09') then menddt(substr(i_basedt,1,4)||'0901')
					when substr(i_basedt,5,2) in ('10','11','12') then menddt(substr(i_basedt,1,4)||'1201')
				end
		INTO o_date;
		
	END IF;

	/* 반기 : 4 */
	IF i_gubun = '4' THEN
		SELECT case when substr(i_basedt,5,2) in ('01','02','03','04','05','06') then menddt(substr(i_basedt,1,4)||'0601')
					when substr(i_basedt,5,2) in ('07','08','09','10','11','12') then menddt(substr(i_basedt,1,4)||'1201')
				end
		INTO o_date;
		
	END IF;

	/* 년 : 5 */
	IF i_gubun = '5' THEN
		SELECT menddt(substr(i_basedt,1,4)||'1201')
		INTO o_date;
		
	END IF;

	RETURN 	o_date;
	END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.getdate(i_basedt character varying, i_gubun character varying) OWNER TO letl;

--
-- Name: k_cor_v2(character, character, character, numeric, numeric, character); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION k_cor_v2(co_rtsel_dscd character, nbis_ptf_dscd character, rtsel_pol_id character, sal_am numeric, pd numeric, sepr_aset_dscd character) RETURNS numeric
    AS $$
DECLARE
  C_VALUE   NUMERIC;
BEGIN

IF CO_RTSEL_DSCD = '1'
   THEN
        IF NBIS_PTF_DSCD IN ('02','06','07','@@','08','09','10')
           THEN
                /*--------------------------------------------------------------------*/
                /* 기업 Exposure                                                      */
                /*--------------------------------------------------------------------*/
                C_VALUE := 0.12*(1-EXP(-50*PD))/(1-EXP(-50))+0.24*(1-(1-EXP(-50*PD))/(1-EXP(-50)));
           ELSE
                /*--------------------------------------------------------------------*/
                /* 중소기업 Exposure                                                  */
                /*--------------------------------------------------------------------*/
                C_VALUE := 0.12*(1-EXP(-50*PD))/(1-EXP(-50))+0.24*(1-(1-EXP(-50*PD))/(1-EXP(-50)))-0.04*(1-(SAL_AM-6)/54);
        END IF;
   ELSE
        /*--------------------------------------------------------------------*/
        /* 소매 Exposure                                                      */
        /*--------------------------------------------------------------------*/
        IF CO_RTSEL_DSCD = '2' AND (RTSEL_POL_ID LIKE 'P1%')
           THEN
               /*--------------------------------------------------------------------*/
               /* 주거용담보 Exposure                                     2015.05.25 */
               /*--------------------------------------------------------------------*/
               IF SEPR_ASET_DSCD = '201'
                  THEN  C_VALUE := 0.30;
                  ELSE  C_VALUE := 0.15;
               END IF;
           ELSE
               /*--------------------------------------------------------------------*/
               /* 적격회전거래 Exposure                                              */
               /*--------------------------------------------------------------------*/
               IF CO_RTSEL_DSCD = '2' AND (   RTSEL_POL_ID LIKE 'P2%')
                  THEN
                      C_VALUE := 0.04;
                  ELSE
                       /*--------------------------------------------------------------------*/
                       /* 기타소매 Exposure                                                  */
                       /*--------------------------------------------------------------------*/
                       C_VALUE := 0.03*(1-EXP(-35*PD))/(1-EXP(-35))+0.16*(1-(1-EXP(-35*PD))/(1-EXP(-35)));
               END IF;
        END IF;
END IF;

  RETURN(C_VALUE);
	
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.k_cor_v2(co_rtsel_dscd character, nbis_ptf_dscd character, rtsel_pol_id character, sal_am numeric, pd numeric, sepr_aset_dscd character) OWNER TO letl;

--
-- Name: k_func_v2(character, character, character, numeric, numeric, numeric, numeric, character); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION k_func_v2(k_co_rtsel_dscd character, k_nbis_ptf_dscd character, k_rtsel_pol_id character, k_sal_am numeric, k_pd_rt numeric, k_lgd_rt numeric, k_m numeric, k_sepr_aset_dscd character) RETURNS numeric
    AS $$
DECLARE
K_VALUE           NUMERIC;     /* K율         */
K_COR_VALUE       NUMERIC;     /* 상관계수    */
K_M_VALUE         NUMERIC;     /* 유효만기    */
BEGIN

IF K_CO_RTSEL_DSCD = '1'
   THEN
        /*--------------------------------------------------------------------*/
        /* 비소매 Exposure                                                    */
        /*--------------------------------------------------------------------*/
        IF K_PD_RT < 1
           THEN
               K_VALUE := (  K_LGD_RT
                           * K_NORMSDIST_V2(
                                            POWER(1/(1 - K_COR_VALUE), 0.5)
                                           * K_NORMSINV_V2(K_PD_RT)
                                           + POWER(K_COR_VALUE/(1 - K_COR_VALUE), 0.5)
                                           * K_NORMSINV_V2(0.999)
                                           )
                            - (K_PD_RT * K_LGD_RT)
                          )
                          *  POWER(1 - (1.5 * K_M_VALUE), -1)
                          * (1 + (K_M - 2.5) * K_M_VALUE);
           ELSE
               K_VALUE := (  K_LGD_RT
                           * 1
                           - (K_PD_RT * K_LGD_RT)
                          )
                         * POWER(1 - (1.5 * K_M_VALUE), -1)
                         * (1 + (K_M - 2.5) * K_M_VALUE);   /* 0값 RETURN : 공식이 바뀔까 해서 분기함 */
        END IF;
   ELSE
        /*--------------------------------------------------------------------*/
        /* 소매 Exposure                                                      */
        /*--------------------------------------------------------------------*/
        IF K_PD_RT < 1
           THEN
               K_VALUE := (  K_LGD_RT
                           * K_NORMSDIST_V2(
                                          POWER(1/(1 - K_COR_VALUE), 0.5) * K_NORMSINV_V2(K_PD_RT)
                                        + POWER(K_COR_VALUE/(1 - K_COR_VALUE), 0.5) * K_NORMSINV_V2(0.999)
                                        )
                           - (K_PD_RT * K_LGD_RT)
                          );
           ELSE
               K_VALUE := (  K_LGD_RT
                           * 1
                           - (K_PD_RT * K_LGD_RT)
                          ); /* 0값 RETURN : 공식이 바뀔까 해서 분기함 */
        END IF;
END IF;

RETURN (K_VALUE);
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.k_func_v2(k_co_rtsel_dscd character, k_nbis_ptf_dscd character, k_rtsel_pol_id character, k_sal_am numeric, k_pd_rt numeric, k_lgd_rt numeric, k_m numeric, k_sepr_aset_dscd character) OWNER TO letl;

--
-- Name: k_m_mediation_v2(numeric); Type: FUNCTION; Schema: sdmin; Owner: gpadmin
--

CREATE FUNCTION k_m_mediation_v2(pd numeric) RETURNS numeric
    AS $$
DECLARE
  M_MEDIATION   NUMERIC;
BEGIN


M_MEDIATION := POWER((0.11852 - 0.05478 * LN(PD)), 2);

RETURN (M_MEDIATION);
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.k_m_mediation_v2(pd numeric) OWNER TO gpadmin;

--
-- Name: k_normdist_v2(numeric, numeric, numeric, character); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION k_normdist_v2(t_val numeric, avg_val numeric, stdv_val numeric, job_val character) RETURNS numeric
    AS $$
DECLARE
PI_VAL         numeric;
RESULT         numeric;
BEGIN


PI_VAL := 3.1415926535897932384626433832795028841971;
RESULT := 0;

IF JOB_VAL <> 'F' OR STDV_VAL = 0
   THEN RESULT := K_NORMSDIST_V2(T_VAL);
   ELSE RESULT := 1/(SQRT(2*PI_VAL)*STDV_VAL)*EXP(-(T_VAL-AVG_VAL)*(T_VAL-AVG_VAL)/(2*STDV_VAL*STDV_VAL));
END IF;

RETURN (RESULT);
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.k_normdist_v2(t_val numeric, avg_val numeric, stdv_val numeric, job_val character) OWNER TO letl;

--
-- Name: k_normsdist_v2(numeric); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION k_normsdist_v2(z numeric) RETURNS numeric
    AS $$
DECLARE
     ZABS    NUMERIC;
     P       NUMERIC;
     EXPNTL  NUMERIC;
     PDF     NUMERIC;
     P0      NUMERIC;
     P1      NUMERIC;
     P2      NUMERIC;
     P3      NUMERIC;
     P4      NUMERIC;
     P5      NUMERIC;
     P6      NUMERIC;

     Q0      NUMERIC;
     Q1      NUMERIC;
     Q2      NUMERIC;
     Q3      NUMERIC;
     Q4      NUMERIC;
     Q5      NUMERIC;
     Q6      NUMERIC;
     Q7      NUMERIC;

     CUTOFF  NUMERIC;
     ROOT2PI NUMERIC;

     M       NUMERIC;
BEGIN

ZABS    := 0;
P       := 0;
EXPNTL  := 0;
PDF     := 0;
P0      := 220.2068679123761;
P1      := 221.2135961699311;
P2      := 112.0792914978709;
P3      := 33.91286607838300;
P4      := 6.373962203531650;
P5      := 0.7003830644436881;
P6      := 0.03526249659989109;

Q0      := 440.4137358247522;
Q1      := 793.8265125199484;
Q2      := 637.3336333788311;
Q3      := 296.5642487796737;
Q4      := 86.78073220294608;
Q5      := 16.06417757920695;
Q6      := 1.755667163182642;
Q7      := 0.08838834764831844;

CUTOFF  := 7.071;
ROOT2PI := 2.506628274631001;

ZABS := Z;

IF Z < 0
   THEN ZABS := Z * -1;
END IF;

IF Z > 37.0
   THEN  P := 1.0;
END IF;

IF Z < -37.0
   THEN  P := 0.0;
END IF;

IF Z <= 37.0 AND Z >= -37.0
   THEN
       EXPNTL := EXP(-0.5*ZABS*ZABS);
       PDF    := EXPNTL/ROOT2PI;

       IF ZABS < CUTOFF
          THEN
               P := EXPNTL*((((((P6*ZABS+P5)*ZABS+P4)*ZABS+P3)*ZABS+P2)*ZABS+P1)*ZABS+P0)/(((((((Q7*ZABS+Q6)*ZABS+Q5)*ZABS+Q4)*ZABS+Q3)*ZABS+Q2)*ZABS+Q1)*ZABS+Q0);
          ELSE
               P := PDF/(ZABS+1.0/(ZABS+2.0/(ZABS+3.0/(ZABS+4.0/(ZABS+0.65)))));
       END IF;

       IF Z >= 0.0
          THEN
               P := 1.0 - P;
       END IF;
END IF;

RETURN (P);
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.k_normsdist_v2(z numeric) OWNER TO letl;

--
-- Name: k_normsinv_v2(numeric); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION k_normsinv_v2(p numeric) RETURNS numeric
    AS $$
DECLARE
     PLOW         NUMERIC;
     PHIGH        NUMERIC;
     Q            NUMERIC;
     R            NUMERIC;
     A1           NUMERIC;
     A2           NUMERIC;
     A3           NUMERIC;
     A4           NUMERIC;
     A5           NUMERIC;
     A6           NUMERIC;
     B1           NUMERIC;
     B2           NUMERIC;
     B3           NUMERIC;
     B4           NUMERIC;
     B5           NUMERIC;
     C1           NUMERIC;
     C2           NUMERIC;
     C3           NUMERIC;
     C4           NUMERIC;
     C5           NUMERIC;
     C6           NUMERIC;
     D1           NUMERIC;
     D2           NUMERIC;
     D3           NUMERIC;
     D4           NUMERIC;
     RESULT       NUMERIC;
BEGIN

PLOW      := 0.02425;
PHIGH     := 1 - PLOW;

Q         := 0.0;
R         := 0.0;

A1        := -39.69683028665376;
A2        := 220.9460984245205;
A3        := -275.9285104469687;
A4        := 138.3577518672690;
A5        := -30.66479806614716;
A6        := 2.506628277459239;

B1        := -54.47609879822406;
B2        := 161.5858368580409;
B3        := -155.6989798598866;
B4        := 66.80131188771972;
B5        := -13.28068155288572;

C1        := -0.007784894002430293;
C2        := -0.3223964580411365;
C3        := -2.400758277161838;
C4        := -2.549732539343734;
C5        := 4.374664141464968;
C6        := 2.938163982698783;

D1        := 0.007784695709041462;
D2        := 0.3224671290700398;
D3        := 2.445134137142996;
D4        := 3.754408661907416;

RESULT    := 0;

IF P < PLOW
   THEN
        Q := SQRT(-2 * LN(P));
        RESULT := (((((C1*Q+C2)*Q+C3)*Q+C4)*Q+C5)*Q+C6)/((((D1*Q+D2)*Q+D3)*Q+D4)*Q+1);
ELSE IF PHIGH < P
       THEN
            Q := SQRT(-2 * LN(1-P));
            RESULT := -(((((C1*Q+C2)*Q+C3)*Q+C4)*Q+C5)*Q+C6)/((((D1*Q+D2)*Q+D3)*Q+D4)*Q+1);
       ELSE
            Q := P - 0.5;
            R := Q*Q ;
            RESULT := (((((A1*R+A2)*R+A3)*R+A4)*R+A5)*R+A6)*Q/(((((B1*R+B2)*R+B3)*R+B4)*R+B5)*R+1);
       END IF;
END IF;

RETURN (RESULT);
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.k_normsinv_v2(p numeric) OWNER TO letl;

--
-- Name: menddt(character); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION menddt(i_date character) RETURNS character
    AS $$
DECLARE
  v_befdt   CHAR(8);
  v_curdt   DATE;
  v_ck      NUMERIC;
BEGIN
    SELECT LAST_DAY(TO_DATE(i_date,'YYYYMMDD'))
    INTO v_curdt
    ;

  LOOP

    IF (v_curdt >= TO_DATE('20020701','YYYYMMDD')) THEN
     SELECT CASE WHEN TO_CHAR(v_curdt,'D') IN ('1','7') THEN 1
                 ELSE 0
            END
     INTO v_ck
     ;
    ELSE
     SELECT CASE WHEN TO_CHAR(v_curdt,'D') = '1' THEN 1
                 ELSE 0
            END
     INTO v_ck
     ;
    END IF;

    IF (v_ck = 0) THEN
      SELECT 1
      INTO v_ck
      FROM ACNT_HO_LIDAY
      WHERE (AHOYEAR = '9999' AND AHODATE = TO_CHAR(v_curdt,'MMDD')) OR
      (AHOYEAR = TO_CHAR(v_curdt,'YYYY') AND AHODATE = TO_CHAR(v_curdt,'MMDD'));

    END IF;

    EXIT WHEN v_ck = 0;

    SELECT v_curdt - '1 day'::interval
    INTO v_curdt
    ;

  END LOOP;

  SELECT TO_CHAR(v_curdt,'YYYYMMDD')
  INTO v_befdt
  ;

  RETURN(v_befdt);
--
  EXCEPTION
   WHEN OTHERS THEN
    SELECT TO_CHAR(v_curdt,'YYYYMMDD')
    INTO v_befdt
    ;
    RETURN(v_befdt);
--
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.menddt(i_date character) OWNER TO letl;

--
-- Name: offdt(character); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION offdt(i_date character) RETURNS numeric
    AS $$
DECLARE
  v_ck   NUMERIC;
BEGIN

    if (i_date >= '20020701') then
     SELECT CASE WHEN TO_CHAR(TO_DATE(i_date,'YYYYMMDD'),'D') IN ('1', '7') THEN 1
                 ELSE 0
            END
     INTO v_ck
     ;
    else
     SELECT CASE WHEN TO_CHAR(TO_DATE(i_date,'YYYYMMDD'),'D') ='1' THEN 1
                 ELSE 0
            END
     INTO v_ck
     ;
    end if;

   IF (v_ck = 1) THEN
     RETURN(v_ck);
   ELSE
    SELECT count(*)
    INTO v_ck
    FROM ACNT_HO_LIDAY
    WHERE (AHOYEAR = '9999' AND AHODATE = SUBSTR(i_date,5,4)) or
             (AHOYEAR = SUBSTR(i_date,1,4) AND AHODATE = SUBSTR(i_date,5,4));

      IF v_ck > 1 THEN
         v_ck := 1;
      END IF;
   END IF;
  RETURN(v_ck);

END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.offdt(i_date character) OWNER TO letl;

--
-- Name: trnm(character varying); Type: FUNCTION; Schema: sdmin; Owner: letl
--

CREATE FUNCTION trnm(i_trcode character varying) RETURNS character varying
    AS $$
DECLARE
        o_trname  VARCHAR(80);
BEGIN

        SELECT  mlgdesc
        INTO    o_trname
        FROM    meta_lg_log
        WHERE   mlgbrcd = SUBSTR(i_trcode,1,2)
        AND             mlgircd = SUBSTR(i_trcode,3,4)
        LIMIT 1;

        RETURN  o_trname;

END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sdmin.trnm(i_trcode character varying) OWNER TO letl;

SET search_path = oracompat, pg_catalog;

--
-- Name: listagg(text); Type: AGGREGATE; Schema: oracompat; Owner: gpadmin
--

CREATE AGGREGATE listagg(text) (
    SFUNC = listagg1_transfn,
    STYPE = text
);


ALTER AGGREGATE oracompat.listagg(text) OWNER TO gpadmin;

--
-- Name: listagg(text, text); Type: AGGREGATE; Schema: oracompat; Owner: gpadmin
--

CREATE AGGREGATE listagg(text, text) (
    SFUNC = listagg2_transfn,
    STYPE = text
);


ALTER AGGREGATE oracompat.listagg(text, text) OWNER TO gpadmin;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

--
-- Name: attrep_apply0004DD47057A6194; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD47057A6194" (
    statement text
) LOCATION (
    'http://localhost:8080/TEST3/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD47057A6194" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD4706FB0426; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD4706FB0426" (
    statement text
) LOCATION (
    'http://localhost:8080/TEST3/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD4706FB0426" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD47093AABF4; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD47093AABF4" (
    statement text
) LOCATION (
    'http://localhost:8080/TEST3/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD47093AABF4" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD470DF41B52; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD470DF41B52" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST3/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD470DF41B52" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD470F886D3D; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD470F886D3D" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST3/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD470F886D3D" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD47113DBCF4; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD47113DBCF4" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST3/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD47113DBCF4" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD47136E5CE2; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD47136E5CE2" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST3/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD47136E5CE2" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD4716FFDA1A; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD4716FFDA1A" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST3/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD4716FFDA1A" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD478F077857; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD478F077857" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD478F077857" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD479CC3C4EB; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD479CC3C4EB" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD479CC3C4EB" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD479E71E898; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD479E71E898" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD479E71E898" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD47A08A58C3; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD47A08A58C3" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD47A08A58C3" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD47A46595F7; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD47A46595F7" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD47A46595F7" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD47AC99931F; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD47AC99931F" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD47AC99931F" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD47B8449F7C; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD47B8449F7C" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD47B8449F7C" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD47CE17A49A; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD47CE17A49A" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD47CE17A49A" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD4A59B73232; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD4A59B73232" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD4A59B73232" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD4A67169FFB; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD4A67169FFB" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD4A67169FFB" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD4A698D3EE7; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD4A698D3EE7" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD4A698D3EE7" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD4A6D063E3B; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD4A6D063E3B" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD4A6D063E3B" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD4A7129FF00; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD4A7129FF00" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD4A7129FF00" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD4A7785F536; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD4A7785F536" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD4A7785F536" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD4A82F704F9; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD4A82F704F9" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD4A82F704F9" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD4AA077DD89; Type: EXTERNAL TABLE; Schema: public; Owner: lcdc; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD4AA077DD89" (
    statement text
) LOCATION (
    'http://10.181.10.127:8080/TEST_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD4AA077DD89" OWNER TO lcdc;

--
-- Name: attrep_apply0004DD4D4A0FF80F; Type: EXTERNAL TABLE; Schema: public; Owner: lcdc; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD4D4A0FF80F" (
    statement text
) LOCATION (
    'http://172.28.4.230:8080/aaa/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD4D4A0FF80F" OWNER TO lcdc;

--
-- Name: attrep_apply0004DD599FF8B7B1; Type: EXTERNAL TABLE; Schema: public; Owner: lcdc; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD599FF8B7B1" (
    statement text
) LOCATION (
    'http://172.28.4.230:8080/aaa/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD599FF8B7B1" OWNER TO lcdc;

--
-- Name: attrep_apply0004DD7135D0E843; Type: EXTERNAL TABLE; Schema: public; Owner: lcdc; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD7135D0E843" (
    statement text
) LOCATION (
    'http://172.28.4.230:8080/aaa/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD7135D0E843" OWNER TO lcdc;

--
-- Name: attrep_apply0004DD72F5306433; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD72F5306433" (
    statement text
) LOCATION (
    'http://172.28.4.230:8080/ccc/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD72F5306433" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD7676170E05; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD7676170E05" (
    statement text
) LOCATION (
    'http://172.28.4.230:8080/full_cdc_job1/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD7676170E05" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD768211686B; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD768211686B" (
    statement text
) LOCATION (
    'http://172.28.4.230:8080/full_cdc_job1/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD768211686B" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD7684C79A64; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD7684C79A64" (
    statement text
) LOCATION (
    'http://172.28.4.230:8080/full_cdc_job1/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD7684C79A64" OWNER TO gpadmin;

--
-- Name: attrep_apply0004DD76DFA90810; Type: EXTERNAL TABLE; Schema: public; Owner: lcdc; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD76DFA90810" (
    statement text
) LOCATION (
    'http://172.28.4.230:8080/ccc/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD76DFA90810" OWNER TO lcdc;

--
-- Name: attrep_apply0004DD7C6BDA3EC3; Type: EXTERNAL TABLE; Schema: public; Owner: letl; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DD7C6BDA3EC3" (
    statement text
) LOCATION (
    'http://172.28.4.230:8080/ORA_S_TO_GP_T_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DD7C6BDA3EC3" OWNER TO letl;

--
-- Name: attrep_apply0004DDA8F5EEEA0D; Type: EXTERNAL TABLE; Schema: public; Owner: letl; Tablespace: 
--

CREATE EXTERNAL WEB TABLE "attrep_apply0004DDA8F5EEEA0D" (
    statement text
) LOCATION (
    'http://172.28.4.230:8080/ORA_S_TO_GP_T_CDC_ONLY/greenplum/cdc/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."attrep_apply0004DDA8F5EEEA0D" OWNER TO letl;

--
-- Name: attrep_apply_exceptions; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE attrep_apply_exceptions (
    task_name character varying(128),
    table_owner character varying(64),
    table_name character varying(64),
    error_time timestamp without time zone,
    statement text,
    error text
) DISTRIBUTED BY (task_name);


ALTER TABLE public.attrep_apply_exceptions OWNER TO gpadmin;

--
-- Name: attrep_net_changes0004DD7138071E4F; Type: TABLE; Schema: public; Owner: lcdc; Tablespace: 
--

CREATE TABLE "attrep_net_changes0004DD7138071E4F" (
    seq integer NOT NULL,
    col1 text,
    col2 text,
    col3 text,
    col4 text,
    col5 text,
    col6 text,
    col7 text,
    col8 text,
    col9 text,
    col10 text,
    col11 text,
    col12 text,
    col13 text,
    col14 text,
    col15 text,
    col16 text,
    col17 text,
    col18 text,
    col19 text,
    col20 text,
    col21 text,
    col22 text,
    col23 text,
    col24 text,
    col25 text,
    col26 text,
    col27 text,
    col28 text,
    col29 text,
    col30 text,
    col31 text,
    col32 text,
    col33 text,
    col34 text,
    col35 text,
    col36 text,
    col37 text,
    col38 text,
    col39 text,
    col40 text,
    col41 text,
    col42 text,
    col43 text,
    col44 text,
    col45 text,
    col46 text,
    col47 text,
    col48 text,
    col49 text,
    col50 text
) DISTRIBUTED BY (seq);


ALTER TABLE public."attrep_net_changes0004DD7138071E4F" OWNER TO lcdc;

--
-- Name: attrep_net_changes0004DD72F535290F; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE "attrep_net_changes0004DD72F535290F" (
    seq integer NOT NULL,
    col1 text,
    col2 text,
    col3 text,
    col4 text,
    col5 text,
    col6 text,
    col7 text,
    col8 text,
    col9 text,
    col10 text,
    col11 text,
    col12 text,
    col13 text,
    col14 text,
    col15 text,
    col16 text,
    col17 text,
    col18 text,
    col19 text,
    col20 text,
    col21 text,
    col22 text,
    col23 text,
    col24 text,
    col25 text,
    col26 text,
    col27 text,
    col28 text,
    col29 text,
    col30 text,
    col31 text,
    col32 text,
    col33 text,
    col34 text,
    col35 text,
    col36 text,
    col37 text,
    col38 text,
    col39 text,
    col40 text,
    col41 text,
    col42 text,
    col43 text,
    col44 text,
    col45 text,
    col46 text,
    col47 text,
    col48 text,
    col49 text,
    col50 text
) DISTRIBUTED BY (seq);


ALTER TABLE public."attrep_net_changes0004DD72F535290F" OWNER TO gpadmin;

--
-- Name: attrep_net_changes0004DD7C6D428EFE; Type: TABLE; Schema: public; Owner: letl; Tablespace: 
--

CREATE TABLE "attrep_net_changes0004DD7C6D428EFE" (
    seq integer NOT NULL,
    col1 text,
    col2 text,
    col3 text,
    col4 text,
    col5 text,
    col6 text,
    col7 text,
    col8 text,
    col9 text,
    col10 text,
    col11 text,
    col12 text,
    col13 text,
    col14 text,
    col15 text,
    col16 text,
    col17 text,
    col18 text,
    col19 text,
    col20 text,
    col21 text,
    col22 text,
    col23 text,
    col24 text,
    col25 text,
    col26 text,
    col27 text,
    col28 text,
    col29 text,
    col30 text,
    col31 text,
    col32 text,
    col33 text,
    col34 text,
    col35 text,
    col36 text,
    col37 text,
    col38 text,
    col39 text,
    col40 text,
    col41 text,
    col42 text,
    col43 text,
    col44 text,
    col45 text,
    col46 text,
    col47 text,
    col48 text,
    col49 text,
    col50 text,
    col51 text,
    col52 text,
    col53 text,
    col54 text,
    col55 text,
    col56 text,
    col57 text,
    col58 text,
    col59 text,
    col60 text,
    col61 text,
    col62 text,
    col63 text,
    col64 text,
    col65 text,
    col66 text,
    col67 text,
    col68 text,
    col69 text,
    col70 text,
    col71 text,
    col72 text,
    col73 text,
    col74 text,
    col75 text,
    col76 text,
    col77 text,
    col78 text,
    col79 text,
    col80 text,
    col81 text,
    col82 text,
    col83 text,
    col84 text,
    col85 text,
    col86 text,
    col87 text,
    col88 text,
    col89 text,
    col90 text,
    col91 text,
    col92 text,
    col93 text,
    col94 text,
    col95 text,
    col96 text,
    col97 text,
    col98 text,
    col99 text,
    col100 text,
    col101 text,
    col102 text,
    col103 text,
    col104 text,
    col105 text,
    col106 text,
    col107 text,
    col108 text,
    col109 text,
    col110 text,
    col111 text,
    col112 text,
    col113 text,
    col114 text,
    col115 text,
    col116 text,
    col117 text,
    col118 text,
    col119 text,
    col120 text,
    col121 text,
    col122 text,
    col123 text,
    col124 text,
    col125 text,
    col126 text,
    col127 text
) DISTRIBUTED BY (seq);


ALTER TABLE public."attrep_net_changes0004DD7C6D428EFE" OWNER TO letl;

--
-- Name: attrep_net_changes0004DDA8F7B178D2; Type: TABLE; Schema: public; Owner: letl; Tablespace: 
--

CREATE TABLE "attrep_net_changes0004DDA8F7B178D2" (
    seq integer NOT NULL,
    col1 text,
    col2 text,
    col3 text,
    col4 text,
    col5 text,
    col6 text,
    col7 text,
    col8 text,
    col9 text,
    col10 text,
    col11 text,
    col12 text,
    col13 text,
    col14 text,
    col15 text,
    col16 text,
    col17 text,
    col18 text,
    col19 text,
    col20 text,
    col21 text,
    col22 text,
    col23 text,
    col24 text,
    col25 text,
    col26 text,
    col27 text,
    col28 text,
    col29 text,
    col30 text,
    col31 text,
    col32 text,
    col33 text,
    col34 text,
    col35 text,
    col36 text,
    col37 text,
    col38 text,
    col39 text,
    col40 text,
    col41 text,
    col42 text,
    col43 text,
    col44 text,
    col45 text,
    col46 text,
    col47 text,
    col48 text,
    col49 text,
    col50 text,
    col51 text,
    col52 text,
    col53 text,
    col54 text,
    col55 text,
    col56 text,
    col57 text,
    col58 text,
    col59 text,
    col60 text,
    col61 text,
    col62 text,
    col63 text,
    col64 text,
    col65 text,
    col66 text,
    col67 text,
    col68 text,
    col69 text,
    col70 text,
    col71 text,
    col72 text,
    col73 text,
    col74 text,
    col75 text,
    col76 text,
    col77 text,
    col78 text,
    col79 text,
    col80 text,
    col81 text,
    col82 text,
    col83 text,
    col84 text,
    col85 text,
    col86 text,
    col87 text,
    col88 text,
    col89 text,
    col90 text,
    col91 text,
    col92 text,
    col93 text,
    col94 text,
    col95 text,
    col96 text,
    col97 text,
    col98 text,
    col99 text,
    col100 text,
    col101 text,
    col102 text,
    col103 text,
    col104 text,
    col105 text,
    col106 text,
    col107 text,
    col108 text,
    col109 text,
    col110 text,
    col111 text,
    col112 text,
    col113 text,
    col114 text,
    col115 text,
    col116 text,
    col117 text,
    col118 text,
    col119 text,
    col120 text,
    col121 text,
    col122 text,
    col123 text,
    col124 text,
    col125 text,
    col126 text,
    col127 text
) DISTRIBUTED BY (seq);


ALTER TABLE public."attrep_net_changes0004DDA8F7B178D2" OWNER TO letl;

--
-- Name: ext_attrep_net_changes0004DD7138071E4F; Type: EXTERNAL TABLE; Schema: public; Owner: lcdc; Tablespace: 
--

CREATE EXTERNAL TABLE "ext_attrep_net_changes0004DD7138071E4F" (
    seq integer,
    col1 text,
    col2 text,
    col3 text,
    col4 text,
    col5 text,
    col6 text,
    col7 text,
    col8 text,
    col9 text,
    col10 text,
    col11 text,
    col12 text,
    col13 text,
    col14 text,
    col15 text,
    col16 text,
    col17 text,
    col18 text,
    col19 text,
    col20 text,
    col21 text,
    col22 text,
    col23 text,
    col24 text,
    col25 text,
    col26 text,
    col27 text,
    col28 text,
    col29 text,
    col30 text,
    col31 text,
    col32 text,
    col33 text,
    col34 text,
    col35 text,
    col36 text,
    col37 text,
    col38 text,
    col39 text,
    col40 text,
    col41 text,
    col42 text,
    col43 text,
    col44 text,
    col45 text,
    col46 text,
    col47 text,
    col48 text,
    col49 text,
    col50 text
) LOCATION (
    'gpfdist://172.28.4.230:8080/aaa/greenplum/bulk/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."ext_attrep_net_changes0004DD7138071E4F" OWNER TO lcdc;

--
-- Name: ext_attrep_net_changes0004DD72F535290F; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE "ext_attrep_net_changes0004DD72F535290F" (
    seq integer,
    col1 text,
    col2 text,
    col3 text,
    col4 text,
    col5 text,
    col6 text,
    col7 text,
    col8 text,
    col9 text,
    col10 text,
    col11 text,
    col12 text,
    col13 text,
    col14 text,
    col15 text,
    col16 text,
    col17 text,
    col18 text,
    col19 text,
    col20 text,
    col21 text,
    col22 text,
    col23 text,
    col24 text,
    col25 text,
    col26 text,
    col27 text,
    col28 text,
    col29 text,
    col30 text,
    col31 text,
    col32 text,
    col33 text,
    col34 text,
    col35 text,
    col36 text,
    col37 text,
    col38 text,
    col39 text,
    col40 text,
    col41 text,
    col42 text,
    col43 text,
    col44 text,
    col45 text,
    col46 text,
    col47 text,
    col48 text,
    col49 text,
    col50 text
) LOCATION (
    'gpfdist://172.28.4.230:8080/ccc/greenplum/bulk/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."ext_attrep_net_changes0004DD72F535290F" OWNER TO gpadmin;

--
-- Name: ext_attrep_net_changes0004DD7C6D428EFE; Type: EXTERNAL TABLE; Schema: public; Owner: letl; Tablespace: 
--

CREATE EXTERNAL TABLE "ext_attrep_net_changes0004DD7C6D428EFE" (
    seq integer,
    col1 text,
    col2 text,
    col3 text,
    col4 text,
    col5 text,
    col6 text,
    col7 text,
    col8 text,
    col9 text,
    col10 text,
    col11 text,
    col12 text,
    col13 text,
    col14 text,
    col15 text,
    col16 text,
    col17 text,
    col18 text,
    col19 text,
    col20 text,
    col21 text,
    col22 text,
    col23 text,
    col24 text,
    col25 text,
    col26 text,
    col27 text,
    col28 text,
    col29 text,
    col30 text,
    col31 text,
    col32 text,
    col33 text,
    col34 text,
    col35 text,
    col36 text,
    col37 text,
    col38 text,
    col39 text,
    col40 text,
    col41 text,
    col42 text,
    col43 text,
    col44 text,
    col45 text,
    col46 text,
    col47 text,
    col48 text,
    col49 text,
    col50 text,
    col51 text,
    col52 text,
    col53 text,
    col54 text,
    col55 text,
    col56 text,
    col57 text,
    col58 text,
    col59 text,
    col60 text,
    col61 text,
    col62 text,
    col63 text,
    col64 text,
    col65 text,
    col66 text,
    col67 text,
    col68 text,
    col69 text,
    col70 text,
    col71 text,
    col72 text,
    col73 text,
    col74 text,
    col75 text,
    col76 text,
    col77 text,
    col78 text,
    col79 text,
    col80 text,
    col81 text,
    col82 text,
    col83 text,
    col84 text,
    col85 text,
    col86 text,
    col87 text,
    col88 text,
    col89 text,
    col90 text,
    col91 text,
    col92 text,
    col93 text,
    col94 text,
    col95 text,
    col96 text,
    col97 text,
    col98 text,
    col99 text,
    col100 text,
    col101 text,
    col102 text,
    col103 text,
    col104 text,
    col105 text,
    col106 text,
    col107 text,
    col108 text,
    col109 text,
    col110 text,
    col111 text,
    col112 text,
    col113 text,
    col114 text,
    col115 text,
    col116 text,
    col117 text,
    col118 text,
    col119 text,
    col120 text,
    col121 text,
    col122 text,
    col123 text,
    col124 text,
    col125 text,
    col126 text,
    col127 text
) LOCATION (
    'gpfdist://172.28.4.230:8080/ORA_S_TO_GP_T_CDC_ONLY/greenplum/bulk/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."ext_attrep_net_changes0004DD7C6D428EFE" OWNER TO letl;

--
-- Name: ext_attrep_net_changes0004DDA8F7B178D2; Type: EXTERNAL TABLE; Schema: public; Owner: letl; Tablespace: 
--

CREATE EXTERNAL TABLE "ext_attrep_net_changes0004DDA8F7B178D2" (
    seq integer,
    col1 text,
    col2 text,
    col3 text,
    col4 text,
    col5 text,
    col6 text,
    col7 text,
    col8 text,
    col9 text,
    col10 text,
    col11 text,
    col12 text,
    col13 text,
    col14 text,
    col15 text,
    col16 text,
    col17 text,
    col18 text,
    col19 text,
    col20 text,
    col21 text,
    col22 text,
    col23 text,
    col24 text,
    col25 text,
    col26 text,
    col27 text,
    col28 text,
    col29 text,
    col30 text,
    col31 text,
    col32 text,
    col33 text,
    col34 text,
    col35 text,
    col36 text,
    col37 text,
    col38 text,
    col39 text,
    col40 text,
    col41 text,
    col42 text,
    col43 text,
    col44 text,
    col45 text,
    col46 text,
    col47 text,
    col48 text,
    col49 text,
    col50 text,
    col51 text,
    col52 text,
    col53 text,
    col54 text,
    col55 text,
    col56 text,
    col57 text,
    col58 text,
    col59 text,
    col60 text,
    col61 text,
    col62 text,
    col63 text,
    col64 text,
    col65 text,
    col66 text,
    col67 text,
    col68 text,
    col69 text,
    col70 text,
    col71 text,
    col72 text,
    col73 text,
    col74 text,
    col75 text,
    col76 text,
    col77 text,
    col78 text,
    col79 text,
    col80 text,
    col81 text,
    col82 text,
    col83 text,
    col84 text,
    col85 text,
    col86 text,
    col87 text,
    col88 text,
    col89 text,
    col90 text,
    col91 text,
    col92 text,
    col93 text,
    col94 text,
    col95 text,
    col96 text,
    col97 text,
    col98 text,
    col99 text,
    col100 text,
    col101 text,
    col102 text,
    col103 text,
    col104 text,
    col105 text,
    col106 text,
    col107 text,
    col108 text,
    col109 text,
    col110 text,
    col111 text,
    col112 text,
    col113 text,
    col114 text,
    col115 text,
    col116 text,
    col117 text,
    col118 text,
    col119 text,
    col120 text,
    col121 text,
    col122 text,
    col123 text,
    col124 text,
    col125 text,
    col126 text,
    col127 text
) LOCATION (
    'gpfdist://172.28.4.230:8080/ORA_S_TO_GP_T_CDC_ONLY/greenplum/bulk/CDC*.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public."ext_attrep_net_changes0004DDA8F7B178D2" OWNER TO letl;

--
-- Name: sn2ro_crud; Type: TABLE; Schema: public; Owner: letl; Tablespace: 
--

CREATE TABLE sn2ro_crud (
    schemaname name NOT NULL,
    tablename name NOT NULL,
    c integer,
    r integer,
    u integer,
    d integer,
    appendonlytext text,
    compressleveltext text,
    orientationtext text,
    m_default_retention integer
) DISTRIBUTED BY (schemaname ,tablename);


ALTER TABLE public.sn2ro_crud OWNER TO letl;

--
-- Name: COLUMN sn2ro_crud.schemaname; Type: COMMENT; Schema: public; Owner: letl
--

COMMENT ON COLUMN sn2ro_crud.schemaname IS 'Schema Name';


--
-- Name: COLUMN sn2ro_crud.tablename; Type: COMMENT; Schema: public; Owner: letl
--

COMMENT ON COLUMN sn2ro_crud.tablename IS 'Table Name';


--
-- Name: COLUMN sn2ro_crud.m_default_retention; Type: COMMENT; Schema: public; Owner: letl
--

COMMENT ON COLUMN sn2ro_crud.m_default_retention IS 'Month Default Retention';


SET search_path = sdmim, pg_catalog;

--
-- Name: acnt_ac_code; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE acnt_ac_code (
    aacpaccd text NOT NULL,
    aacuaccd text NOT NULL,
    aacattr1 smallint NOT NULL,
    aacattra smallint DEFAULT 0,
    aacattrb smallint DEFAULT 0,
    aacattrc smallint DEFAULT 0,
    aacattrd smallint DEFAULT 0,
    aacattre smallint DEFAULT 0,
    aacrplcd character varying(6),
    aacrelcd character varying(6),
    aacalmcd character varying(6),
    aacstrdt character varying(8),
    aacclodt character varying(8),
    aacsname character varying(50) NOT NULL,
    aacfname character varying(50) NOT NULL,
    aacuac1 character varying(6),
    aacuac2 character varying(6),
    aacuac3 character varying(6),
    aackind character varying(1),
    aacsort character varying(5),
    aacfxsort character varying(5),
    aacboth character varying(6),
    aacminus character varying(1),
    bmt_imsi integer
) DISTRIBUTED BY (aacuaccd);


ALTER TABLE sdmim.acnt_ac_code OWNER TO lcdc;

--
-- Name: acnt_ac_code_1; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE acnt_ac_code_1 (
    aacpaccd character varying(6) NOT NULL,
    aacuaccd character varying(6) NOT NULL,
    aacattr1 smallint NOT NULL,
    aacattra smallint,
    aacattrb smallint,
    aacattrc smallint,
    aacattrd smallint,
    aacattre smallint,
    aacrplcd character varying(6),
    aacrelcd character varying(6),
    aacalmcd character varying(6),
    aacstrdt character varying(8),
    aacclodt character varying(8),
    aacsname character varying(50) NOT NULL,
    aacfname character varying(50) NOT NULL,
    aacuac1 character varying(6),
    aacuac2 character varying(6),
    aacuac3 character varying(6),
    aackind character varying(1),
    aacsort character varying(5),
    aacfxsort character varying(5),
    aacboth character varying(6),
    aacminus character varying(1),
    bmt_imsi integer
) DISTRIBUTED BY (aacpaccd ,aacuaccd ,aacattr1);


ALTER TABLE sdmim.acnt_ac_code_1 OWNER TO lcdc;

--
-- Name: acnt_ac_code_b; Type: TABLE; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE TABLE acnt_ac_code_b (
    aacpaccd text NOT NULL,
    aacuaccd text NOT NULL,
    aacattr1 smallint NOT NULL,
    aacattra smallint DEFAULT 0,
    aacattrb smallint DEFAULT 0,
    aacattrc smallint DEFAULT 0,
    aacattrd smallint DEFAULT 0,
    aacattre smallint DEFAULT 0,
    aacrplcd character varying(6),
    aacrelcd character varying(6),
    aacalmcd character varying(6),
    aacstrdt character varying(8),
    aacclodt character varying(8),
    aacsname character varying(50) NOT NULL,
    aacfname character varying(50) NOT NULL,
    aacuac1 character varying(6),
    aacuac2 character varying(6),
    aacuac3 character varying(6),
    aackind character varying(1),
    aacsort character varying(5),
    aacfxsort character varying(5),
    aacboth character varying(6),
    aacminus character varying(1),
    bmt_imsi integer
) DISTRIBUTED BY (aacpaccd);


ALTER TABLE sdmim.acnt_ac_code_b OWNER TO letl;

--
-- Name: audt_ja_confirm; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE audt_ja_confirm (
    trn_dt character varying(8) NOT NULL,
    trn_brno character varying(3) NOT NULL,
    audit_cd character varying(10) NOT NULL,
    logno character varying(30) NOT NULL,
    uk_inf character varying(100) NOT NULL,
    act_no character varying(30),
    cus_no character varying(13),
    conf_dt character varying(14),
    empno character varying(10),
    nor_yn character varying(1),
    acc_gubun character varying(1),
    rmk_txt character varying(4000),
    arn_yn character varying(1),
    arn_dtime character varying(14),
    arn_empno character varying(10),
    pnt_txt character varying(1000),
    bmt_imsi integer
) DISTRIBUTED BY (trn_brno ,audit_cd);


ALTER TABLE sdmim.audt_ja_confirm OWNER TO lcdc;

--
-- Name: audt_ja_confirm_1; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE audt_ja_confirm_1 (
    trn_dt character varying(8) NOT NULL,
    trn_brno character varying(3) NOT NULL,
    audit_cd character varying(10) NOT NULL,
    logno character varying(30) NOT NULL,
    uk_inf character varying(100) NOT NULL,
    act_no character varying(30),
    cus_no character varying(13),
    conf_dt character varying(14),
    empno character varying(10),
    nor_yn character varying(1),
    acc_gubun character varying(1),
    rmk_txt character varying(4000),
    arn_yn character varying(1),
    arn_dtime character varying(14),
    arn_empno character varying(10),
    pnt_txt character varying(1000),
    bmt_imsi integer
) DISTRIBUTED BY (trn_dt ,trn_brno ,audit_cd ,logno ,uk_inf);


ALTER TABLE sdmim.audt_ja_confirm_1 OWNER TO lcdc;

--
-- Name: audt_ja_confirm_b; Type: TABLE; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE TABLE audt_ja_confirm_b (
    trn_dt character varying(8) NOT NULL,
    trn_brno character varying(3) NOT NULL,
    audit_cd character varying(10) NOT NULL,
    logno character varying(30) NOT NULL,
    uk_inf character varying(100) NOT NULL,
    act_no character varying(30),
    cus_no character varying(13),
    conf_dt character varying(14),
    empno character varying(10),
    nor_yn character varying(1),
    acc_gubun character varying(1),
    rmk_txt character varying(4000),
    arn_yn character varying(1),
    arn_dtime character varying(14),
    arn_empno character varying(10),
    pnt_txt character varying(1000),
    bmt_imsi integer
) DISTRIBUTED BY (trn_brno ,audit_cd);


ALTER TABLE sdmim.audt_ja_confirm_b OWNER TO letl;

--
-- Name: card_flc_mihando; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE card_flc_mihando (
    rljadate character varying(8) NOT NULL,
    rljabrno character varying(3) NOT NULL,
    rljasmno character varying(30) NOT NULL,
    rljaaccd character varying(6) NOT NULL,
    rljacifno character varying(13),
    rljafundcd character varying(1),
    crd_xc_rt numeric(7,4),
    lmt_am numeric(15,0) DEFAULT 0,
    bal_bl numeric(15,0) DEFAULT 0,
    nuse_lmt_am numeric(15,0) DEFAULT 0,
    csv_lmt_am numeric(15,0) DEFAULT 0,
    csv_bl numeric(15,0) DEFAULT 0,
    nuse_csv_bl numeric(15,0) DEFAULT 0,
    rljajsdsamt numeric(17,2) DEFAULT 0,
    rljayodsamt numeric(17,2) DEFAULT 0,
    rljagodsamt numeric(17,2) DEFAULT 0,
    rljahsdsamt numeric(17,2) DEFAULT 0,
    rljachdsamt numeric(17,2) DEFAULT 0,
    rljajstdamt numeric(15,0) DEFAULT 0,
    rljayotdamt numeric(15,0) DEFAULT 0,
    rljagotdamt numeric(15,0) DEFAULT 0,
    rljahstdamt numeric(15,0) DEFAULT 0,
    rljachtdamt numeric(15,0) DEFAULT 0,
    rljagyumo character varying(1),
    rljaapv_am numeric(18,0) DEFAULT 0,
    rljaamt numeric(15,0) DEFAULT 0,
    rljagrade character varying(2),
    rljapscd character(1),
    rljapsno character(13),
    rstl_reg_dscd character(1),
    ccd_dfpay_hld_yn character(1),
    dfpay_tspcd_hld_yn character(1),
    dfpay_tspcd_bl numeric(18,0),
    bmt_imsi integer
) DISTRIBUTED BY (rljadate ,rljabrno ,rljasmno ,rljaaccd);


ALTER TABLE sdmim.card_flc_mihando OWNER TO lcdc;

--
-- Name: card_flc_mihando_1; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE card_flc_mihando_1 (
    rljadate character varying(8) NOT NULL,
    rljabrno character varying(3) NOT NULL,
    rljasmno character varying(30) NOT NULL,
    rljaaccd character varying(6) NOT NULL,
    rljacifno character varying(13),
    rljafundcd character varying(1),
    crd_xc_rt numeric(7,4),
    lmt_am numeric(15,0),
    bal_bl numeric(15,0),
    nuse_lmt_am numeric(15,0),
    csv_lmt_am numeric(15,0),
    csv_bl numeric(15,0),
    nuse_csv_bl numeric(15,0),
    rljajsdsamt numeric(17,2),
    rljayodsamt numeric(17,2),
    rljagodsamt numeric(17,2),
    rljahsdsamt numeric(17,2),
    rljachdsamt numeric(17,2),
    rljajstdamt numeric(15,0),
    rljayotdamt numeric(15,0),
    rljagotdamt numeric(15,0),
    rljahstdamt numeric(15,0),
    rljachtdamt numeric(15,0),
    rljagyumo character varying(1),
    rljaapv_am numeric(18,0),
    rljaamt numeric(15,0),
    rljagrade character varying(2),
    rljapscd character varying(1),
    rljapsno character varying(13),
    rstl_reg_dscd character varying(1),
    ccd_dfpay_hld_yn character varying(1),
    dfpay_tspcd_hld_yn character varying(1),
    dfpay_tspcd_bl numeric(18,0),
    bmt_imsi integer
) DISTRIBUTED BY (rljadate ,rljabrno ,rljasmno ,rljaaccd);


ALTER TABLE sdmim.card_flc_mihando_1 OWNER TO lcdc;

--
-- Name: card_flc_mihando_b; Type: TABLE; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE TABLE card_flc_mihando_b (
    rljadate character varying(8) NOT NULL,
    rljabrno character varying(3) NOT NULL,
    rljasmno character varying(30) NOT NULL,
    rljaaccd character varying(6) NOT NULL,
    rljacifno character varying(13),
    rljafundcd character varying(1),
    crd_xc_rt numeric(7,4),
    lmt_am numeric(15,0) DEFAULT 0,
    bal_bl numeric(15,0) DEFAULT 0,
    nuse_lmt_am numeric(15,0) DEFAULT 0,
    csv_lmt_am numeric(15,0) DEFAULT 0,
    csv_bl numeric(15,0) DEFAULT 0,
    nuse_csv_bl numeric(15,0) DEFAULT 0,
    rljajsdsamt numeric(17,2) DEFAULT 0,
    rljayodsamt numeric(17,2) DEFAULT 0,
    rljagodsamt numeric(17,2) DEFAULT 0,
    rljahsdsamt numeric(17,2) DEFAULT 0,
    rljachdsamt numeric(17,2) DEFAULT 0,
    rljajstdamt numeric(15,0) DEFAULT 0,
    rljayotdamt numeric(15,0) DEFAULT 0,
    rljagotdamt numeric(15,0) DEFAULT 0,
    rljahstdamt numeric(15,0) DEFAULT 0,
    rljachtdamt numeric(15,0) DEFAULT 0,
    rljagyumo character varying(1),
    rljaapv_am numeric(18,0) DEFAULT 0,
    rljaamt numeric(15,0) DEFAULT 0,
    rljagrade character varying(2),
    rljapscd character(1),
    rljapsno character(13),
    rstl_reg_dscd character(1),
    ccd_dfpay_hld_yn character(1),
    dfpay_tspcd_hld_yn character(1),
    dfpay_tspcd_bl numeric(18,0),
    bmt_imsi integer
) DISTRIBUTED BY (rljadate ,rljabrno ,rljasmno ,rljaaccd);


ALTER TABLE sdmim.card_flc_mihando_b OWNER TO letl;

--
-- Name: card_flc_mst; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE card_flc_mst (
    rljadate character varying(8) NOT NULL,
    rljabrno character varying(3) NOT NULL,
    rljasmno character varying(30) NOT NULL,
    rljaaccd character varying(6) NOT NULL,
    rljaseq character varying(2) NOT NULL,
    rljaonseq character varying(2),
    rljagubun character varying(2),
    rljacifno character varying(13),
    rljaaccd1 character varying(4),
    rljafundcd character varying(1),
    rljasjgu character varying(1),
    rljasnkind character varying(2),
    rljajencd character varying(2),
    rljahabcd character varying(2),
    rljasancd character varying(5),
    rljasancd1 character varying(4),
    rljamany character varying(2),
    rljaxrrate numeric(7,2),
    rljamusuik character varying(1),
    rljajscd character varying(2),
    rljayocd character varying(2),
    rljagocd character varying(2),
    rljahscd character varying(2),
    rljachcd character varying(2),
    rljasmamt numeric(15,0),
    rljaamt numeric(15,0),
    rljajsamt numeric(15,0),
    rljayoamt numeric(15,0),
    rljagoamt numeric(15,0),
    rljahsamt numeric(15,0),
    rljachamt numeric(15,0),
    rljajsdsamt numeric(17,2),
    rljayodsamt numeric(17,2),
    rljagodsamt numeric(17,2),
    rljahsdsamt numeric(17,2),
    rljachdsamt numeric(17,2),
    rljajstdamt numeric(15,0),
    rljayotdamt numeric(15,0),
    rljagotdamt numeric(15,0),
    rljahstdamt numeric(15,0),
    rljachtdamt numeric(15,0),
    rljajsvlamt numeric(15,0),
    rljayovlamt numeric(15,0),
    rljagovlamt numeric(15,0),
    rljahsvlamt numeric(15,0),
    rljachvlamt numeric(15,0),
    rljagunjsamt numeric(15,0),
    rljagunyoamt numeric(15,0),
    rljagungoamt numeric(15,0),
    rljagunhsamt numeric(15,0),
    rljagunchamt numeric(15,0),
    rljayeamt numeric(15,0),
    rljagunyeamt numeric(15,0),
    rljaempno character varying(6),
    rljachsayu character varying(200),
    rljaempno1 character varying(6),
    rljachsayu1 character varying(200),
    rljabigo character varying(50),
    rljasdate character varying(8),
    rljaexdat character varying(8),
    rljayndt character varying(8),
    rljayongdo character varying(2),
    rljafsdat character varying(8),
    rljaamt1 numeric(15,0),
    rljachrt numeric(7,2),
    rljachrt_p numeric(7,2),
    rljachange character varying(1),
    rljagyumo character varying(1),
    rljapsno character varying(13),
    rljapscd character varying(1),
    rstl_reg_dscd character varying(1),
    bmt_imsi integer
) DISTRIBUTED BY (rljadate ,rljabrno ,rljasmno ,rljaaccd ,rljaseq);


ALTER TABLE sdmim.card_flc_mst OWNER TO lcdc;

--
-- Name: card_flc_mst_1; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE card_flc_mst_1 (
    rljadate character varying(8) NOT NULL,
    rljabrno character varying(3) NOT NULL,
    rljasmno character varying(30) NOT NULL,
    rljaaccd character varying(6) NOT NULL,
    rljaseq character varying(2) NOT NULL,
    rljaonseq character varying(2),
    rljagubun character varying(2),
    rljacifno character varying(13),
    rljaaccd1 character varying(4),
    rljafundcd character varying(1),
    rljasjgu character varying(1),
    rljasnkind character varying(2),
    rljajencd character varying(2),
    rljahabcd character varying(2),
    rljasancd character varying(5),
    rljasancd1 character varying(4),
    rljamany character varying(2),
    rljaxrrate numeric(7,2),
    rljamusuik character varying(1),
    rljajscd character varying(2),
    rljayocd character varying(2),
    rljagocd character varying(2),
    rljahscd character varying(2),
    rljachcd character varying(2),
    rljasmamt numeric(15,0),
    rljaamt numeric(15,0),
    rljajsamt numeric(15,0),
    rljayoamt numeric(15,0),
    rljagoamt numeric(15,0),
    rljahsamt numeric(15,0),
    rljachamt numeric(15,0),
    rljajsdsamt numeric(17,2),
    rljayodsamt numeric(17,2),
    rljagodsamt numeric(17,2),
    rljahsdsamt numeric(17,2),
    rljachdsamt numeric(17,2),
    rljajstdamt numeric(15,0),
    rljayotdamt numeric(15,0),
    rljagotdamt numeric(15,0),
    rljahstdamt numeric(15,0),
    rljachtdamt numeric(15,0),
    rljajsvlamt numeric(15,0),
    rljayovlamt numeric(15,0),
    rljagovlamt numeric(15,0),
    rljahsvlamt numeric(15,0),
    rljachvlamt numeric(15,0),
    rljagunjsamt numeric(15,0),
    rljagunyoamt numeric(15,0),
    rljagungoamt numeric(15,0),
    rljagunhsamt numeric(15,0),
    rljagunchamt numeric(15,0),
    rljayeamt numeric(15,0),
    rljagunyeamt numeric(15,0),
    rljaempno character varying(6),
    rljachsayu character varying(200),
    rljaempno1 character varying(6),
    rljachsayu1 character varying(200),
    rljabigo character varying(50),
    rljasdate character varying(8),
    rljaexdat character varying(8),
    rljayndt character varying(8),
    rljayongdo character varying(2),
    rljafsdat character varying(8),
    rljaamt1 numeric(15,0),
    rljachrt numeric(7,2),
    rljachrt_p numeric(7,2),
    rljachange character varying(1),
    rljagyumo character varying(1),
    rljapsno character varying(13),
    rljapscd character varying(1),
    rstl_reg_dscd character varying(1),
    bmt_imsi integer
) DISTRIBUTED BY (rljadate ,rljabrno ,rljasmno ,rljaaccd ,rljaseq);


ALTER TABLE sdmim.card_flc_mst_1 OWNER TO lcdc;

--
-- Name: card_flc_mst_b; Type: TABLE; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE TABLE card_flc_mst_b (
    rljadate character varying(8) NOT NULL,
    rljabrno character varying(3) NOT NULL,
    rljasmno character varying(30) NOT NULL,
    rljaaccd character varying(6) NOT NULL,
    rljaseq character varying(2) NOT NULL,
    rljaonseq character varying(2),
    rljagubun character varying(2),
    rljacifno character varying(13),
    rljaaccd1 character varying(4),
    rljafundcd character varying(1),
    rljasjgu character varying(1),
    rljasnkind character varying(2),
    rljajencd character varying(2),
    rljahabcd character varying(2),
    rljasancd character varying(5),
    rljasancd1 character varying(4),
    rljamany character varying(2),
    rljaxrrate numeric(7,2) DEFAULT 0,
    rljamusuik character varying(1),
    rljajscd character varying(2),
    rljayocd character varying(2),
    rljagocd character varying(2),
    rljahscd character varying(2),
    rljachcd character varying(2),
    rljasmamt numeric(15,0) DEFAULT 0,
    rljaamt numeric(15,0) DEFAULT 0,
    rljajsamt numeric(15,0) DEFAULT 0,
    rljayoamt numeric(15,0) DEFAULT 0,
    rljagoamt numeric(15,0) DEFAULT 0,
    rljahsamt numeric(15,0) DEFAULT 0,
    rljachamt numeric(15,0) DEFAULT 0,
    rljajsdsamt numeric(17,2) DEFAULT 0,
    rljayodsamt numeric(17,2) DEFAULT 0,
    rljagodsamt numeric(17,2) DEFAULT 0,
    rljahsdsamt numeric(17,2) DEFAULT 0,
    rljachdsamt numeric(17,2) DEFAULT 0,
    rljajstdamt numeric(15,0) DEFAULT 0,
    rljayotdamt numeric(15,0) DEFAULT 0,
    rljagotdamt numeric(15,0) DEFAULT 0,
    rljahstdamt numeric(15,0) DEFAULT 0,
    rljachtdamt numeric(15,0) DEFAULT 0,
    rljajsvlamt numeric(15,0) DEFAULT 0,
    rljayovlamt numeric(15,0) DEFAULT 0,
    rljagovlamt numeric(15,0) DEFAULT 0,
    rljahsvlamt numeric(15,0) DEFAULT 0,
    rljachvlamt numeric(15,0) DEFAULT 0,
    rljagunjsamt numeric(15,0) DEFAULT 0,
    rljagunyoamt numeric(15,0) DEFAULT 0,
    rljagungoamt numeric(15,0) DEFAULT 0,
    rljagunhsamt numeric(15,0) DEFAULT 0,
    rljagunchamt numeric(15,0) DEFAULT 0,
    rljayeamt numeric(15,0) DEFAULT 0,
    rljagunyeamt numeric(15,0) DEFAULT 0,
    rljaempno character varying(6),
    rljachsayu character varying(200),
    rljaempno1 character varying(6),
    rljachsayu1 character varying(200),
    rljabigo character varying(50),
    rljasdate character varying(8),
    rljaexdat character varying(8),
    rljayndt character varying(8),
    rljayongdo character varying(2),
    rljafsdat character varying(8),
    rljaamt1 numeric(15,0),
    rljachrt numeric(7,2),
    rljachrt_p numeric(7,2),
    rljachange character varying(1),
    rljagyumo character varying(1),
    rljapsno character(13),
    rljapscd character(1),
    rstl_reg_dscd character(1),
    bmt_imsi integer
) DISTRIBUTED BY (rljadate ,rljabrno ,rljasmno ,rljaaccd ,rljaseq);


ALTER TABLE sdmim.card_flc_mst_b OWNER TO letl;

--
-- Name: comm_br_brch; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE comm_br_brch (
    zbrbrcd character(3) NOT NULL,
    zbrgirocd character varying(6),
    zbrexbrcd character varying(3),
    zbrbubuncd character(1),
    zbrareacd character varying(3),
    zbrheadcd character varying(3),
    zbrmbrcd character(3),
    zbrexchar character(2),
    zbrmgrnm character varying(20),
    zbrkornm character varying(40) NOT NULL,
    zbrkornm1 character varying(20) NOT NULL,
    zbrengnm character varying(50),
    zbrengcmnm character varying(20),
    zbrsano character varying(10),
    zbrdomgu character(1),
    zbrgukgo character(1),
    zbrtelno character varying(20),
    zbrfaxno character varying(20),
    zbrteljik character varying(20),
    zbrailno character(6),
    zbradrcd character varying(8),
    zbradres character varying(50),
    zbrengadr character varying(80),
    zbrsemucd character varying(3),
    zbrcijhmcd character varying(3),
    zbrbokcd character varying(4),
    zbrinhrat numeric(5,2) DEFAULT 0,
    zbropndt character(8) NOT NULL,
    zbrexopdt character varying(8),
    zbrclose character varying(8),
    zbrapsq numeric(2,0) NOT NULL,
    zbrilbr character(3),
    zbr365cd character(1),
    zbryagum character(1),
    zbrdaegum character(1),
    zbrhyubrcd character(1),
    zbryeclo character(1),
    zbrexchek character(1),
    zbrdivck character(1),
    zbrdivgb character(1),
    zbrdivbr character(3),
    zbrbrkind character(1),
    bmt_imsi integer
) DISTRIBUTED BY (zbrbrcd);


ALTER TABLE sdmim.comm_br_brch OWNER TO lcdc;

--
-- Name: comm_br_brch_1; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE comm_br_brch_1 (
    zbrbrcd character varying(3) NOT NULL,
    zbrgirocd character varying(6),
    zbrexbrcd character varying(3),
    zbrbubuncd character varying(1),
    zbrareacd character varying(3),
    zbrheadcd character varying(3),
    zbrmbrcd character varying(3),
    zbrexchar character varying(2),
    zbrmgrnm character varying(20),
    zbrkornm character varying(40) NOT NULL,
    zbrkornm1 character varying(20) NOT NULL,
    zbrengnm character varying(50),
    zbrengcmnm character varying(20),
    zbrsano character varying(10),
    zbrdomgu character varying(1),
    zbrgukgo character varying(1),
    zbrtelno character varying(20),
    zbrfaxno character varying(20),
    zbrteljik character varying(20),
    zbrailno character varying(6),
    zbradrcd character varying(8),
    zbradres character varying(50),
    zbrengadr character varying(80),
    zbrsemucd character varying(3),
    zbrcijhmcd character varying(3),
    zbrbokcd character varying(4),
    zbrinhrat numeric(5,2),
    zbropndt character varying(8) NOT NULL,
    zbrexopdt character varying(8),
    zbrclose character varying(8),
    zbrapsq smallint NOT NULL,
    zbrilbr character varying(3),
    zbr365cd character varying(1),
    zbryagum character varying(1),
    zbrdaegum character varying(1),
    zbrhyubrcd character varying(1),
    zbryeclo character varying(1),
    zbrexchek character varying(1),
    zbrdivck character varying(1),
    zbrdivgb character varying(1),
    zbrdivbr character varying(3),
    zbrbrkind character varying(1),
    bmt_imsi integer
) DISTRIBUTED BY (zbrbrcd);


ALTER TABLE sdmim.comm_br_brch_1 OWNER TO lcdc;

--
-- Name: comm_br_brch_b; Type: TABLE; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE TABLE comm_br_brch_b (
    zbrbrcd character(3) NOT NULL,
    zbrgirocd character varying(6),
    zbrexbrcd character varying(3),
    zbrbubuncd character(1),
    zbrareacd character varying(3),
    zbrheadcd character varying(3),
    zbrmbrcd character(3),
    zbrexchar character(2),
    zbrmgrnm character varying(20),
    zbrkornm character varying(40) NOT NULL,
    zbrkornm1 character varying(20) NOT NULL,
    zbrengnm character varying(50),
    zbrengcmnm character varying(20),
    zbrsano character varying(10),
    zbrdomgu character(1),
    zbrgukgo character(1),
    zbrtelno character varying(20),
    zbrfaxno character varying(20),
    zbrteljik character varying(20),
    zbrailno character(6),
    zbradrcd character varying(8),
    zbradres character varying(50),
    zbrengadr character varying(80),
    zbrsemucd character varying(3),
    zbrcijhmcd character varying(3),
    zbrbokcd character varying(4),
    zbrinhrat numeric(5,2) DEFAULT 0,
    zbropndt character(8) NOT NULL,
    zbrexopdt character varying(8),
    zbrclose character varying(8),
    zbrapsq numeric(2,0) NOT NULL,
    zbrilbr character(3),
    zbr365cd character(1),
    zbryagum character(1),
    zbrdaegum character(1),
    zbrhyubrcd character(1),
    zbryeclo character(1),
    zbrexchek character(1),
    zbrdivck character(1),
    zbrdivgb character(1),
    zbrdivbr character(3),
    zbrbrkind character(1),
    bmt_imsi integer
) DISTRIBUTED BY (zbrbrcd);


ALTER TABLE sdmim.comm_br_brch_b OWNER TO letl;

--
-- Name: cust_ba_base; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE cust_ba_base (
    cbacidno character(13) NOT NULL,
    cbaname character varying(30),
    cbaeobname character varying(50),
    cbacidcd character varying(2),
    cbacntcd character varying(3),
    cbataxcd character varying(1),
    cbagyumocd character(1),
    cbaindcd character varying(4),
    cbaopndt character varying(8),
    cbaopnbr character varying(3),
    cbalstdt character varying(8) DEFAULT '00000000'::character varying,
    cbajikno character varying(7),
    cbamailgb character(1),
    cbanoticgb character(1),
    cbasugamgb character(1),
    cbapanprgb character(1),
    cbarecmkgb character(1),
    cbaailno character varying(6),
    cbaadrcd character varying(8),
    cbaadres character varying(50),
    cbatelno character varying(20),
    cbafaxno character varying(20),
    cbabigo character varying(30),
    cbabibino character varying(20),
    cbahandno character varying(20),
    cbabcailno character varying(6),
    cbabcadrcd character varying(8),
    cbabcadres character varying(50),
    cbabctelno character varying(20),
    cbalsttm character varying(6) DEFAULT '000000'::character varying,
    cbageoju character(1),
    cbacomp05 character(1),
    cbajang character(1),
    cbaemail character varying(30),
    cbainfor character(1),
    cbacprcd character varying(5),
    cbacustcd character varying(2),
    cbaopstdr character(1),
    cbamegak character(1),
    cbakeyman character(1),
    cbakeybr character varying(3),
    cbaempck character(1),
    cbactrdl character(1),
    cbasiljp character(1),
    cbaupjong character varying(5),
    cbanation character varying(2),
    cbaltdobj character varying(2),
    cbabctel character(1),
    cbabktel character(1),
    cbacprcd1 character varying(5)
) DISTRIBUTED BY (cbacidno);


ALTER TABLE sdmim.cust_ba_base OWNER TO lcdc;

--
-- Name: cust_ba_base_1; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE cust_ba_base_1 (
    cbacidno character varying(13) NOT NULL,
    cbaname character varying(30),
    cbaeobname character varying(50),
    cbacidcd character varying(2),
    cbacntcd character varying(3),
    cbataxcd character varying(1),
    cbagyumocd character varying(1),
    cbaindcd character varying(4),
    cbaopndt character varying(8),
    cbaopnbr character varying(3),
    cbalstdt character varying(8),
    cbajikno character varying(7),
    cbamailgb character varying(1),
    cbanoticgb character varying(1),
    cbasugamgb character varying(1),
    cbapanprgb character varying(1),
    cbarecmkgb character varying(1),
    cbaailno character varying(6),
    cbaadrcd character varying(8),
    cbaadres character varying(50),
    cbatelno character varying(20),
    cbafaxno character varying(20),
    cbabigo character varying(30),
    cbabibino character varying(20),
    cbahandno character varying(20),
    cbabcailno character varying(6),
    cbabcadrcd character varying(8),
    cbabcadres character varying(50),
    cbabctelno character varying(20),
    cbalsttm character varying(6),
    cbageoju character varying(1),
    cbacomp05 character varying(1),
    cbajang character varying(1),
    cbaemail character varying(30),
    cbainfor character varying(1),
    cbacprcd character varying(5),
    cbacustcd character varying(2),
    cbaopstdr character varying(1),
    cbamegak character varying(1),
    cbakeyman character varying(1),
    cbakeybr character varying(3),
    cbaempck character varying(1),
    cbactrdl character varying(1),
    cbasiljp character varying(1),
    cbaupjong character varying(5),
    cbanation character varying(2),
    cbaltdobj character varying(2),
    cbabctel character varying(1),
    cbabktel character varying(1),
    cbacprcd1 character varying(5),
    bmt_imsi integer
) DISTRIBUTED BY (cbaeobname ,cbacidno);


ALTER TABLE sdmim.cust_ba_base_1 OWNER TO lcdc;

--
-- Name: cust_ba_base_b; Type: TABLE; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE TABLE cust_ba_base_b (
    cbacidno character(13) NOT NULL,
    cbaname character varying(30),
    cbaeobname character varying(50),
    cbacidcd character varying(2),
    cbacntcd character varying(3),
    cbataxcd character varying(1),
    cbagyumocd character(1),
    cbaindcd character varying(4),
    cbaopndt character varying(8),
    cbaopnbr character varying(3),
    cbalstdt character varying(8) DEFAULT '00000000'::character varying,
    cbajikno character varying(7),
    cbamailgb character(1),
    cbanoticgb character(1),
    cbasugamgb character(1),
    cbapanprgb character(1),
    cbarecmkgb character(1),
    cbaailno character varying(6),
    cbaadrcd character varying(8),
    cbaadres character varying(50),
    cbatelno character varying(20),
    cbafaxno character varying(20),
    cbabigo character varying(30),
    cbabibino character varying(20),
    cbahandno character varying(20),
    cbabcailno character varying(6),
    cbabcadrcd character varying(8),
    cbabcadres character varying(50),
    cbabctelno character varying(20),
    cbalsttm character varying(6) DEFAULT '000000'::character varying,
    cbageoju character(1),
    cbacomp05 character(1),
    cbajang character(1),
    cbaemail character varying(30),
    cbainfor character(1),
    cbacprcd character varying(5),
    cbacustcd character varying(2),
    cbaopstdr character(1),
    cbamegak character(1),
    cbakeyman character(1),
    cbakeybr character varying(3),
    cbaempck character(1),
    cbactrdl character(1),
    cbasiljp character(1),
    cbaupjong character varying(5),
    cbanation character varying(2),
    cbaltdobj character varying(2),
    cbabctel character(1),
    cbabktel character(1),
    cbacprcd1 character varying(5),
    bmt_imsi integer
) DISTRIBUTED BY (cbacidno);


ALTER TABLE sdmim.cust_ba_base_b OWNER TO letl;

--
-- Name: cust_ba_juso; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE cust_ba_juso (
    cbcidno character(13) NOT NULL,
    cbkind character(1) NOT NULL,
    cbgubun1 character(1),
    cbpost1 character varying(6),
    cbjuso1 character varying(100),
    cbbjuso1 character varying(100),
    cbpnu1 character(25),
    cbtrdt1 character varying(8),
    cbgubun2 character(1),
    cbpost2 character varying(6),
    cbjuso2 character varying(100),
    cbbjuso2 character varying(100),
    cbpnu2 character(25),
    cbtrdt2 character varying(8),
    cbgubun3 character(1),
    cbpost3 character(6),
    cbjuso3 character varying(100),
    cbbjuso3 character varying(100),
    cbpnu3 character(25),
    cbtrdt3 character varying(8)
) DISTRIBUTED BY (cbcidno ,cbkind);


ALTER TABLE sdmim.cust_ba_juso OWNER TO lcdc;

--
-- Name: cust_ba_juso_1; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE cust_ba_juso_1 (
    cbcidno character varying(13) NOT NULL,
    cbkind character varying(1) NOT NULL,
    cbgubun1 character varying(1),
    cbpost1 character varying(6),
    cbjuso1 character varying(100),
    cbbjuso1 character varying(100),
    cbpnu1 character varying(25),
    cbtrdt1 character varying(8),
    cbgubun2 character varying(1),
    cbpost2 character varying(6),
    cbjuso2 character varying(100),
    cbbjuso2 character varying(100),
    cbpnu2 character varying(25),
    cbtrdt2 character varying(8),
    cbgubun3 character varying(1),
    cbpost3 character varying(6),
    cbjuso3 character varying(100),
    cbbjuso3 character varying(100),
    cbpnu3 character varying(25),
    cbtrdt3 character varying(8)
) DISTRIBUTED BY (cbcidno ,cbkind);


ALTER TABLE sdmim.cust_ba_juso_1 OWNER TO lcdc;

--
-- Name: cust_ba_juso_b; Type: TABLE; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE TABLE cust_ba_juso_b (
    cbcidno character(13) NOT NULL,
    cbkind character(1) NOT NULL,
    cbgubun1 character(1),
    cbpost1 character varying(6),
    cbjuso1 character varying(100),
    cbbjuso1 character varying(100),
    cbpnu1 character(25),
    cbtrdt1 character varying(8),
    cbgubun2 character(1),
    cbpost2 character varying(6),
    cbjuso2 character varying(100),
    cbbjuso2 character varying(100),
    cbpnu2 character(25),
    cbtrdt2 character varying(8),
    cbgubun3 character(1),
    cbpost3 character(6),
    cbjuso3 character varying(100),
    cbbjuso3 character varying(100),
    cbpnu3 character(25),
    cbtrdt3 character varying(8),
    bmt_imsi integer
) DISTRIBUTED BY (cbcidno ,cbkind);


ALTER TABLE sdmim.cust_ba_juso_b OWNER TO letl;

--
-- Name: depo_ac_comm; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE depo_ac_comm (
    dacacno character(12) NOT NULL,
    daccifno character(13) NOT NULL,
    dacopndt character(8) NOT NULL,
    dacopncd character(2) NOT NULL,
    dacclodt character(8),
    dacclocd character(2),
    dacupddt character(8) NOT NULL,
    dacseqno numeric(5,0) NOT NULL,
    dacaccd character(2) NOT NULL,
    daccifcd character(2) NOT NULL,
    dacgdcd character(3),
    dactaxcd character(1),
    dacxjbal numeric(15,0) NOT NULL,
    dacxhbal numeric(15,0) NOT NULL,
    dacclbal numeric(15,0) DEFAULT 0,
    dacusrid character(6),
    dacusrbr character(3),
    dacstpdt character(8),
    dacgyldt character(8),
    dacjksdt character(8),
    dacsilcd character(1),
    dacsildt character(8),
    dacsilba numeric(15,0) DEFAULT 0,
    dacxhseq numeric(5,0),
    dacstkcd character(3),
    dacmybi character varying(3),
    dacgold character(1),
    dacstus character(1) DEFAULT '0'::bpchar,
    dacacbr character varying(3),
    dackngub character(1),
    dacisudt character varying(8),
    dacknlove character(1),
    dacyogdcd character(2)
) DISTRIBUTED BY (dacacno ,dacaccd);


ALTER TABLE sdmim.depo_ac_comm OWNER TO lcdc;

--
-- Name: depo_ac_comm_1; Type: TABLE; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE TABLE depo_ac_comm_1 (
    dacacno character varying(12) NOT NULL,
    daccifno character varying(13) NOT NULL,
    dacopndt character varying(8) NOT NULL,
    dacopncd character varying(2) NOT NULL,
    dacclodt character varying(8),
    dacclocd character varying(2),
    dacupddt character varying(8) NOT NULL,
    dacseqno integer NOT NULL,
    dacaccd character varying(2) NOT NULL,
    daccifcd character varying(2) NOT NULL,
    dacgdcd character varying(3),
    dactaxcd character varying(1),
    dacxjbal numeric(15,0) NOT NULL,
    dacxhbal numeric(15,0) NOT NULL,
    dacclbal numeric(15,0),
    dacusrid character varying(6),
    dacusrbr character varying(3),
    dacstpdt character varying(8),
    dacgyldt character varying(8),
    dacjksdt character varying(8),
    dacsilcd character varying(1),
    dacsildt character varying(8),
    dacsilba numeric(15,0),
    dacxhseq integer,
    dacstkcd character varying(3),
    dacmybi character varying(3),
    dacgold character varying(1),
    dacstus character varying(1),
    dacacbr character varying(3),
    dackngub character varying(1),
    dacisudt character varying(8),
    dacknlove character varying(1),
    dacyogdcd character varying(2),
    bmt_imsi integer
) DISTRIBUTED BY (dacacno ,dacaccd);


ALTER TABLE sdmim.depo_ac_comm_1 OWNER TO lcdc;

--
-- Name: depo_ac_comm_b; Type: TABLE; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE TABLE depo_ac_comm_b (
    dacacno character(12) NOT NULL,
    daccifno character(13) NOT NULL,
    dacopndt character(8) NOT NULL,
    dacopncd character(2) NOT NULL,
    dacclodt character(8),
    dacclocd character(2),
    dacupddt character(8) NOT NULL,
    dacseqno numeric(5,0) NOT NULL,
    dacaccd character(2) NOT NULL,
    daccifcd character(2) NOT NULL,
    dacgdcd character(3),
    dactaxcd character(1),
    dacxjbal numeric(15,0) NOT NULL,
    dacxhbal numeric(15,0) NOT NULL,
    dacclbal numeric(15,0) DEFAULT 0,
    dacusrid character(6),
    dacusrbr character(3),
    dacstpdt character(8),
    dacgyldt character(8),
    dacjksdt character(8),
    dacsilcd character(1),
    dacsildt character(8),
    dacsilba numeric(15,0) DEFAULT 0,
    dacxhseq numeric(5,0),
    dacstkcd character(3),
    dacmybi character varying(3),
    dacgold character(1),
    dacstus character(1) DEFAULT '0'::bpchar,
    dacacbr character varying(3),
    dackngub character(1),
    dacisudt character varying(8),
    dacknlove character(1),
    dacyogdcd character(2),
    bmt_imsi integer
) DISTRIBUTED BY (dacacno ,dacaccd);


ALTER TABLE sdmim.depo_ac_comm_b OWNER TO letl;

SET search_path = sdmin, pg_catalog;

--
-- Name: CARS; Type: TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE TABLE "CARS" (
    "Make" character varying(13),
    "Model" character varying(40),
    "Type" character varying(8),
    "Origin" character varying(6),
    "DriveTrain" character varying(5),
    "MSRP" double precision,
    "Invoice" double precision,
    "EngineSize" double precision,
    "Cylinders" double precision,
    "Horsepower" double precision,
    "MPG_City" double precision,
    "MPG_Highway" double precision,
    "Weight" double precision,
    "Wheelbase" double precision,
    "Length" double precision
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin."CARS" OWNER TO gpadmin;

--
-- Name: aa; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE aa (
    a numeric(3,2),
    b character(2)
) DISTRIBUTED BY (a);


ALTER TABLE sdmin.aa OWNER TO letl;

--
-- Name: aaa; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE aaa (
    i integer
) DISTRIBUTED BY (i);


ALTER TABLE sdmin.aaa OWNER TO letl;

--
-- Name: acnt_ac_code; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE acnt_ac_code (
    aacpaccd text NOT NULL,
    aacuaccd text NOT NULL,
    aacattr1 smallint NOT NULL,
    aacattra smallint DEFAULT 0,
    aacattrb smallint DEFAULT 0,
    aacattrc smallint DEFAULT 0,
    aacattrd smallint DEFAULT 0,
    aacattre smallint DEFAULT 0,
    aacrplcd character varying(6),
    aacrelcd character varying(6),
    aacalmcd character varying(6),
    aacstrdt character varying(8),
    aacclodt character varying(8),
    aacsname character varying(50) NOT NULL,
    aacfname character varying(50) NOT NULL,
    aacuac1 character varying(6),
    aacuac2 character varying(6),
    aacuac3 character varying(6),
    aackind character varying(1),
    aacsort character varying(5),
    aacfxsort character varying(5),
    aacboth character varying(6),
    aacminus character varying(1),
    bmt_imsi integer
) DISTRIBUTED BY (aacpaccd);


ALTER TABLE sdmin.acnt_ac_code OWNER TO letl;

--
-- Name: acnt_ac_code_b9; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE acnt_ac_code_b9 (
    aacpaccd text NOT NULL,
    aacuaccd text NOT NULL,
    aacattr1 smallint NOT NULL,
    aacattra smallint DEFAULT 0,
    aacattrb smallint DEFAULT 0,
    aacattrc smallint DEFAULT 0,
    aacattrd smallint DEFAULT 0,
    aacattre smallint DEFAULT 0,
    aacrplcd character varying(6),
    aacrelcd character varying(6),
    aacalmcd character varying(6),
    aacstrdt character varying(8),
    aacclodt character varying(8),
    aacsname character varying(50) NOT NULL,
    aacfname character varying(50) NOT NULL,
    aacuac1 character varying(6),
    aacuac2 character varying(6),
    aacuac3 character varying(6),
    aackind character varying(1),
    aacsort character varying(5),
    aacfxsort character varying(5),
    aacboth character varying(6),
    aacminus character varying(1),
    bmt_imsi integer
) DISTRIBUTED BY (aacpaccd);


ALTER TABLE sdmin.acnt_ac_code_b9 OWNER TO letl;

--
-- Name: acnt_ho_liday; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE acnt_ho_liday (
    ahoyear character(4) NOT NULL,
    ahodate character(4) NOT NULL,
    ahotext character varying(50)
) DISTRIBUTED BY (ahoyear ,ahodate);


ALTER TABLE sdmin.acnt_ho_liday OWNER TO letl;

--
-- Name: audt_ja_app_result; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE audt_ja_app_result (
    trn_dt character varying(8) NOT NULL,
    trn_brno character varying(3) NOT NULL,
    audit_cd character varying(10) NOT NULL,
    tcnt numeric(3,0),
    ycnt numeric(3,0),
    ncnt numeric(3,0),
    xcnt numeric(3,0),
    conf_dt character varying(14),
    empno character varying(10)
) DISTRIBUTED BY (trn_brno ,audit_cd);


ALTER TABLE sdmin.audt_ja_app_result OWNER TO letl;

--
-- Name: audt_ja_confirm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE audt_ja_confirm (
    trn_dt character varying(8) NOT NULL,
    trn_brno character varying(3) NOT NULL,
    audit_cd character varying(10) NOT NULL,
    logno character varying(30) NOT NULL,
    uk_inf character varying(100) NOT NULL,
    act_no character varying(30),
    cus_no character varying(13),
    conf_dt character varying(14),
    empno character varying(10),
    nor_yn character varying(1),
    acc_gubun character varying(1),
    rmk_txt character varying(4000),
    arn_yn character varying(1),
    arn_dtime character varying(14),
    arn_empno character varying(10),
    pnt_txt character varying(1000),
    bmt_imsi integer
) DISTRIBUTED BY (trn_brno ,audit_cd);


ALTER TABLE sdmin.audt_ja_confirm OWNER TO letl;

--
-- Name: audt_ja_confirm_b9; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE audt_ja_confirm_b9 (
    trn_dt character varying(8) NOT NULL,
    trn_brno character varying(3) NOT NULL,
    audit_cd character varying(10) NOT NULL,
    logno character varying(30) NOT NULL,
    uk_inf character varying(100) NOT NULL,
    act_no character varying(30),
    cus_no character varying(13),
    conf_dt character varying(14),
    empno character varying(10),
    nor_yn character varying(1),
    acc_gubun character varying(1),
    rmk_txt character varying(4000),
    arn_yn character varying(1),
    arn_dtime character varying(14),
    arn_empno character varying(10),
    pnt_txt character varying(1000),
    bmt_imsi integer
) DISTRIBUTED BY (trn_brno ,audit_cd);


ALTER TABLE sdmin.audt_ja_confirm_b9 OWNER TO letl;

--
-- Name: audt_ja_depo_mrtg; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE audt_ja_depo_mrtg (
    brnm character varying(30),
    mgg character varying(12),
    psbz_no character varying(13),
    psbz_nm character varying(60),
    mgg_stnm character varying(10),
    apr_dt character varying(8),
    dp_acno character varying(12),
    deed_rmk_txt character varying(30),
    acc_nm character varying(60),
    apv_no character varying(12),
    trdt character varying(8),
    mgg_brno character varying(3),
    audt_id character varying(10),
    mgg_no character varying(12),
    ukval character varying(50),
    mgg_no2 character varying(12),
    psbz_no2 character varying(13)
) DISTRIBUTED BY (trdt ,mgg_brno);


ALTER TABLE sdmin.audt_ja_depo_mrtg OWNER TO letl;

--
-- Name: audt_ja_opn_apv; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE audt_ja_opn_apv (
    act_no character varying(20),
    cus_no character varying(13),
    cus_qlf_nm character varying(80),
    trn_am numeric(15,0),
    ctr_am numeric(15,0),
    cd_no character varying(30),
    trmno character varying(2),
    trn_tm character varying(6),
    opn_kind character varying(30),
    opn_gubun character varying(30),
    advpe_nm character varying(60),
    cpr_nm character varying(60),
    cus_nm character varying(60),
    addr character varying(150),
    telno character varying(20),
    trn_dt character varying(8),
    brno character varying(3),
    audit_cd character varying(10),
    log_no character varying(30),
    uk_inf character varying(50),
    jobcd character varying(1)
) DISTRIBUTED BY (brno ,audit_cd);


ALTER TABLE sdmin.audt_ja_opn_apv OWNER TO letl;

--
-- Name: audt_ja_ss_mst; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE audt_ja_ss_mst (
    ajss_date character(8),
    ajss_brno character(3),
    ajss_cifno character varying(13),
    ajss_keyno character varying(16),
    ajss_trkind character varying(2),
    ajss_trmkd character varying(1),
    ajss_trmno character varying(2),
    ajss_smcd1 character varying(3),
    ajss_smcd2 character varying(3),
    ajss_smcd3 character varying(3),
    ajss_tramt numeric(15,0) DEFAULT 0,
    ajss_comam numeric(15,0) DEFAULT 0,
    ajss_huamt numeric(15,0) DEFAULT 0,
    ajss_acint numeric(15,0) DEFAULT 0,
    ajss_opno character varying(2),
    ajss_audno character varying(2),
    ajss_bankno character varying(10),
    ajss_bigo character varying(30),
    ajss_chkam1 numeric(15,0) DEFAULT 0,
    ajss_chkam2 numeric(15,0) DEFAULT 0,
    ajss_chkam3 numeric(15,0) DEFAULT 0,
    ajss_chkcd character varying(1),
    ajss_chkcd1 character varying(2),
    ajss_chkcd2 character varying(2),
    ajss_chkcd3 character varying(2),
    ajss_code character varying(3),
    ajss_ibjicd character varying(2),
    ajss_jobcd character varying(2),
    ajss_ibsikcd character varying(4),
    ajss_inqcd character varying(1),
    ajss_lnint numeric(15,0) DEFAULT 0,
    ajss_logno character varying(7),
    ajss_mode character(1),
    ajss_name character varying(50),
    ajss_newno character varying(20),
    ajss_oldno character varying(20),
    ajss_openbr character varying(3),
    ajss_time character varying(6),
    ajss_tongkd character varying(2),
    ajss_ydno character varying(12),
    ajss_jacd character varying(3),
    ajss_smcd4 character varying(3),
    ajss_smcd5 character varying(3),
    ajss_smcd6 character varying(3),
    ajss_smcd7 character varying(3),
    ajss_smcd8 character varying(3),
    ajss_smcd9 character varying(3),
    ajss_smcd10 character varying(3),
    ajss_setdt character varying(20),
    ajss_setemp character varying(6),
    ajss_setname character varying(50),
    ajss_afl character varying(1),
    ajss_logbr character varying(3)
) DISTRIBUTED BY (ajss_cifno ,ajss_keyno);


ALTER TABLE sdmin.audt_ja_ss_mst OWNER TO letl;

--
-- Name: audt_vaca_tbl; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE audt_vaca_tbl (
    avac_empno character varying(6) NOT NULL,
    avac_sdate date NOT NULL,
    avac_jobid character varying(5) NOT NULL,
    avac_edate date,
    avac_assig character varying(4),
    avac_assig_nm character varying(40),
    avac_grade character varying(2),
    avac_position character varying(4),
    avac_vacasdate character varying(8),
    avac_vacaedate character varying(8),
    avac_kind character varying(2),
    avac_regempno character varying(6),
    avac_regdate date,
    avac_regbrno character varying(3),
    avac_gamsa character varying(2000),
    avac_gamsaemp character varying(6),
    avac_gamsadate date,
    avac_result character varying(2000),
    avac_resultemp character varying(6),
    avac_resultdate date,
    avac_gempno2 character varying(6),
    avac_gempnm2 character varying(60),
    avac_gempno1 character varying(6),
    avac_gempnm1 character varying(60)
) DISTRIBUTED BY (avac_empno);


ALTER TABLE sdmin.audt_vaca_tbl OWNER TO letl;

--
-- Name: bbb; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE bbb (
    wfg_cd character(2),
    bas_dt character(10),
    ctp_id character(20),
    psbz_no character(13),
    psco_rgno character(13),
    trn_cpt_nm character varying(200),
    nat_cd character(2),
    std_inds_cfcd character(5),
    bzcgr_cd character(2),
    cosiz_cd character(2),
    gid_giv_tgt_yn character(1),
    tot_aset_am numeric(18,3),
    tot_sal_am numeric(18,3),
    crd_evl_mdl_dscd character(2),
    lowpt_mdl_dscd character(2),
    scr_ceg_cd character(2),
    mdps_ceg_cd character(2),
    judg_evl_rk_cd character(2),
    lst_ceg_cd character(2),
    lst_ceg_fix_dt character(10),
    vld_rk_yn character(1),
    co_rtsel_dscd character(1),
    dsh_yn character(1),
    dsh_rsn_cd character(3),
    nbis_dsh_dscd character(1),
    dsh_ocr_dt character(10),
    ln_siz_cd character(2),
    db_chg_ts timestamp(6) without time zone,
    dmn_dsh_yn character(1),
    co_rtsel_cgnz_tpcd character(2),
    his_yn_cd character(1),
    pd_tgt_yn_cd character(1),
    dsh_can_dt character(10),
    crins_vld_fxdt character(10),
    ln_xst_yn character(1),
    cd_xst_yn character(1),
    old_ceg_cd character(2),
    nbis_ptf_dscd character(2),
    sys_ceg_cd character(2),
    rwa_bas_ead_am numeric(21,3)
) DISTRIBUTED BY (bas_dt ,crd_evl_mdl_dscd ,ctp_id ,dmn_dsh_yn ,dsh_ocr_dt ,dsh_yn ,psbz_no ,psco_rgno ,wfg_cd);


ALTER TABLE sdmin.bbb OWNER TO letl;

--
-- Name: bind_depo_opn_trn; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE bind_depo_opn_trn (
    trn_dt character varying(8) NOT NULL,
    trn_log_br character varying(3) NOT NULL,
    trn_log_no character varying(7) NOT NULL,
    trn_brno character varying(3),
    dp_sbj_nm character varying(30),
    dp_kd_nm character varying(20),
    act_no character varying(30),
    cus_no character varying(13),
    opn_dt character varying(8),
    exp_dt character varying(8),
    opn_am numeric(18,0),
    mm_income_am numeric(18,0),
    can_dt character varying(8),
    fc_dp_can_dt character varying(8),
    dps_opn_dt character varying(8),
    opn_can_yn character varying(1),
    bind_xtgt_yn character varying(1),
    bind_xtgt_mgr_empno character varying(10),
    bind_xtgt_mgr_cd character varying(3)
) DISTRIBUTED BY (trn_log_br ,trn_log_no ,cus_no ,trn_brno);


ALTER TABLE sdmin.bind_depo_opn_trn OWNER TO letl;

--
-- Name: card_flc_mihando; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE card_flc_mihando (
    rljadate character varying(8) NOT NULL,
    rljabrno character varying(3) NOT NULL,
    rljasmno character varying(30) NOT NULL,
    rljaaccd character varying(6) NOT NULL,
    rljacifno character varying(13),
    rljafundcd character varying(1),
    crd_xc_rt numeric(7,4),
    lmt_am numeric(15,0),
    bal_bl numeric(15,0),
    nuse_lmt_am numeric(15,0),
    csv_lmt_am numeric(15,0),
    csv_bl numeric(15,0),
    nuse_csv_bl numeric(15,0),
    rljajsdsamt numeric(17,2),
    rljayodsamt numeric(17,2),
    rljagodsamt numeric(17,2),
    rljahsdsamt numeric(17,2),
    rljachdsamt numeric(17,2),
    rljajstdamt numeric(15,0),
    rljayotdamt numeric(15,0),
    rljagotdamt numeric(15,0),
    rljahstdamt numeric(15,0),
    rljachtdamt numeric(15,0),
    rljagyumo character varying(1),
    rljaapv_am numeric(18,0),
    rljaamt numeric(15,0),
    rljagrade character varying(2),
    rljapscd character varying(1),
    rljapsno character varying(13),
    rstl_reg_dscd character varying(1),
    ccd_dfpay_hld_yn character varying(1),
    dfpay_tspcd_hld_yn character varying(1),
    dfpay_tspcd_bl numeric(18,0),
    bmt_imsi integer
) DISTRIBUTED BY (rljadate ,rljabrno ,rljasmno ,rljaaccd);


ALTER TABLE sdmin.card_flc_mihando OWNER TO letl;

--
-- Name: card_flc_mihando_b9; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE card_flc_mihando_b9 (
    rljadate character varying(8) NOT NULL,
    rljabrno character varying(3) NOT NULL,
    rljasmno character varying(30) NOT NULL,
    rljaaccd character varying(6) NOT NULL,
    rljacifno character varying(13),
    rljafundcd character varying(1),
    crd_xc_rt numeric(7,4),
    lmt_am numeric(15,0) DEFAULT 0,
    bal_bl numeric(15,0) DEFAULT 0,
    nuse_lmt_am numeric(15,0) DEFAULT 0,
    csv_lmt_am numeric(15,0) DEFAULT 0,
    csv_bl numeric(15,0) DEFAULT 0,
    nuse_csv_bl numeric(15,0) DEFAULT 0,
    rljajsdsamt numeric(17,2) DEFAULT 0,
    rljayodsamt numeric(17,2) DEFAULT 0,
    rljagodsamt numeric(17,2) DEFAULT 0,
    rljahsdsamt numeric(17,2) DEFAULT 0,
    rljachdsamt numeric(17,2) DEFAULT 0,
    rljajstdamt numeric(15,0) DEFAULT 0,
    rljayotdamt numeric(15,0) DEFAULT 0,
    rljagotdamt numeric(15,0) DEFAULT 0,
    rljahstdamt numeric(15,0) DEFAULT 0,
    rljachtdamt numeric(15,0) DEFAULT 0,
    rljagyumo character varying(1),
    rljaapv_am numeric(18,0) DEFAULT 0,
    rljaamt numeric(15,0) DEFAULT 0,
    rljagrade character varying(2),
    rljapscd character(1),
    rljapsno character(13),
    rstl_reg_dscd character(1),
    ccd_dfpay_hld_yn character(1),
    dfpay_tspcd_hld_yn character(1),
    dfpay_tspcd_bl numeric(18,0),
    bmt_imsi integer
) DISTRIBUTED BY (rljadate ,rljabrno ,rljasmno ,rljaaccd);


ALTER TABLE sdmin.card_flc_mihando_b9 OWNER TO letl;

--
-- Name: card_flc_mst; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE card_flc_mst (
    rljadate character varying(8) NOT NULL,
    rljabrno character varying(3) NOT NULL,
    rljasmno character varying(30) NOT NULL,
    rljaaccd character varying(6) NOT NULL,
    rljaseq character varying(2) NOT NULL,
    rljaonseq character varying(2),
    rljagubun character varying(2),
    rljacifno character varying(13),
    rljaaccd1 character varying(4),
    rljafundcd character varying(1),
    rljasjgu character varying(1),
    rljasnkind character varying(2),
    rljajencd character varying(2),
    rljahabcd character varying(2),
    rljasancd character varying(5),
    rljasancd1 character varying(4),
    rljamany character varying(2),
    rljaxrrate numeric(7,2),
    rljamusuik character varying(1),
    rljajscd character varying(2),
    rljayocd character varying(2),
    rljagocd character varying(2),
    rljahscd character varying(2),
    rljachcd character varying(2),
    rljasmamt numeric(15,0),
    rljaamt numeric(15,0),
    rljajsamt numeric(15,0),
    rljayoamt numeric(15,0),
    rljagoamt numeric(15,0),
    rljahsamt numeric(15,0),
    rljachamt numeric(15,0),
    rljajsdsamt numeric(17,2),
    rljayodsamt numeric(17,2),
    rljagodsamt numeric(17,2),
    rljahsdsamt numeric(17,2),
    rljachdsamt numeric(17,2),
    rljajstdamt numeric(15,0),
    rljayotdamt numeric(15,0),
    rljagotdamt numeric(15,0),
    rljahstdamt numeric(15,0),
    rljachtdamt numeric(15,0),
    rljajsvlamt numeric(15,0),
    rljayovlamt numeric(15,0),
    rljagovlamt numeric(15,0),
    rljahsvlamt numeric(15,0),
    rljachvlamt numeric(15,0),
    rljagunjsamt numeric(15,0),
    rljagunyoamt numeric(15,0),
    rljagungoamt numeric(15,0),
    rljagunhsamt numeric(15,0),
    rljagunchamt numeric(15,0),
    rljayeamt numeric(15,0),
    rljagunyeamt numeric(15,0),
    rljaempno character varying(6),
    rljachsayu character varying(200),
    rljaempno1 character varying(6),
    rljachsayu1 character varying(200),
    rljabigo character varying(50),
    rljasdate character varying(8),
    rljaexdat character varying(8),
    rljayndt character varying(8),
    rljayongdo character varying(2),
    rljafsdat character varying(8),
    rljaamt1 numeric(15,0),
    rljachrt numeric(7,2),
    rljachrt_p numeric(7,2),
    rljachange character varying(1),
    rljagyumo character varying(1),
    rljapsno character varying(13),
    rljapscd character varying(1),
    rstl_reg_dscd character varying(1),
    bmt_imsi integer
) DISTRIBUTED BY (rljadate ,rljabrno ,rljasmno ,rljaaccd);


ALTER TABLE sdmin.card_flc_mst OWNER TO letl;

--
-- Name: card_flc_mst_b9; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE card_flc_mst_b9 (
    rljadate character varying(8) NOT NULL,
    rljabrno character varying(3) NOT NULL,
    rljasmno character varying(30) NOT NULL,
    rljaaccd character varying(6) NOT NULL,
    rljaseq character varying(2) NOT NULL,
    rljaonseq character varying(2),
    rljagubun character varying(2),
    rljacifno character varying(13),
    rljaaccd1 character varying(4),
    rljafundcd character varying(1),
    rljasjgu character varying(1),
    rljasnkind character varying(2),
    rljajencd character varying(2),
    rljahabcd character varying(2),
    rljasancd character varying(5),
    rljasancd1 character varying(4),
    rljamany character varying(2),
    rljaxrrate numeric(7,2) DEFAULT 0,
    rljamusuik character varying(1),
    rljajscd character varying(2),
    rljayocd character varying(2),
    rljagocd character varying(2),
    rljahscd character varying(2),
    rljachcd character varying(2),
    rljasmamt numeric(15,0) DEFAULT 0,
    rljaamt numeric(15,0) DEFAULT 0,
    rljajsamt numeric(15,0) DEFAULT 0,
    rljayoamt numeric(15,0) DEFAULT 0,
    rljagoamt numeric(15,0) DEFAULT 0,
    rljahsamt numeric(15,0) DEFAULT 0,
    rljachamt numeric(15,0) DEFAULT 0,
    rljajsdsamt numeric(17,2) DEFAULT 0,
    rljayodsamt numeric(17,2) DEFAULT 0,
    rljagodsamt numeric(17,2) DEFAULT 0,
    rljahsdsamt numeric(17,2) DEFAULT 0,
    rljachdsamt numeric(17,2) DEFAULT 0,
    rljajstdamt numeric(15,0) DEFAULT 0,
    rljayotdamt numeric(15,0) DEFAULT 0,
    rljagotdamt numeric(15,0) DEFAULT 0,
    rljahstdamt numeric(15,0) DEFAULT 0,
    rljachtdamt numeric(15,0) DEFAULT 0,
    rljajsvlamt numeric(15,0) DEFAULT 0,
    rljayovlamt numeric(15,0) DEFAULT 0,
    rljagovlamt numeric(15,0) DEFAULT 0,
    rljahsvlamt numeric(15,0) DEFAULT 0,
    rljachvlamt numeric(15,0) DEFAULT 0,
    rljagunjsamt numeric(15,0) DEFAULT 0,
    rljagunyoamt numeric(15,0) DEFAULT 0,
    rljagungoamt numeric(15,0) DEFAULT 0,
    rljagunhsamt numeric(15,0) DEFAULT 0,
    rljagunchamt numeric(15,0) DEFAULT 0,
    rljayeamt numeric(15,0) DEFAULT 0,
    rljagunyeamt numeric(15,0) DEFAULT 0,
    rljaempno character varying(6),
    rljachsayu character varying(200),
    rljaempno1 character varying(6),
    rljachsayu1 character varying(200),
    rljabigo character varying(50),
    rljasdate character varying(8),
    rljaexdat character varying(8),
    rljayndt character varying(8),
    rljayongdo character varying(2),
    rljafsdat character varying(8),
    rljaamt1 numeric(15,0),
    rljachrt numeric(7,2),
    rljachrt_p numeric(7,2),
    rljachange character varying(1),
    rljagyumo character varying(1),
    rljapsno character(13),
    rljapscd character(1),
    rstl_reg_dscd character(1),
    bmt_imsi integer
) DISTRIBUTED BY (rljadate ,rljabrno ,rljasmno ,rljaaccd);


ALTER TABLE sdmin.card_flc_mst_b9 OWNER TO letl;

--
-- Name: class_test; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE class_test (
    "Name" character varying(12),
    "Sex" character varying(4),
    "Age" double precision,
    "Height" double precision,
    "Weight" double precision
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin.class_test OWNER TO letl;

--
-- Name: cm034tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE cm034tf (
    trn_dt character(8) NOT NULL,
    ef_trmdi_cd character(2),
    mdi_dinf character(5),
    psbz_no character(13),
    user_no character(8),
    trn_am numeric(18,0),
    fee_am numeric(18,0),
    rcvbk_cd character varying(4),
    rcv_acno character varying(20),
    rcvbk_br_cd character(6),
    pybk_cd character varying(4),
    pybk_paybr_cd character(6),
    pay_acno character varying(20),
    dlbk_cd character varying(4),
    dlbk_br_cd character(6),
    trn_tm character(8),
    trn_kd_txt character(22),
    trn_sts_txt character(10),
    rsp_cd character(4),
    trm_no character(3),
    trn_unq_no character(16),
    elt_eqp_conn_rec_txt character(20),
    mch_no character(20),
    mch_nm character(30),
    cd_no character(16),
    cus_giro_no character(20),
    giro_no character(10),
    trn_apv_rec_txt character(30),
    chk_cn_txt character(3),
    chk_inf character varying(150),
    rmtpe_csno character(13),
    trn_cd character(6),
    lst_load_dt character(8)
) DISTRIBUTED BY (trn_unq_no);


ALTER TABLE sdmin.cm034tf OWNER TO letl;

--
-- Name: code_detail; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE code_detail (
    cddt_mcode character varying(10),
    cddt_dcode character varying(10),
    cddt_name character varying(400),
    cddt_rank numeric(16,4),
    cddt_bigo character varying(4000),
    cddt_regdt character varying(8),
    cddt_reguid character varying(40),
    cddt_del character varying(1),
    cddt_deldt character varying(8),
    cddt_deluid character varying(20)
) DISTRIBUTED BY (cddt_mcode ,cddt_dcode);


ALTER TABLE sdmin.code_detail OWNER TO letl;

--
-- Name: comm_bk_mast; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE comm_bk_mast (
    stand_dte character(8) NOT NULL,
    woori_cod character varying(2),
    coope_inscod character varying(3),
    polno character varying(20),
    regno character varying(13),
    sbcpth_cod character varying(6),
    ctrsta_cod character varying(6),
    contr_dte character varying(8),
    expir_dte character varying(8),
    expin_dte character varying(8),
    insper numeric(10,0) DEFAULT 0,
    insur_pertyp character varying(6),
    pytper numeric(10,0) DEFAULT 0,
    paymt_pertyp character varying(6),
    clsmth_cod character varying(6),
    entfe numeric(17,2) DEFAULT 0,
    sumry_pmi numeric(17,2) DEFAULT 0,
    total_pmi numeric(17,2) DEFAULT 0,
    pytfnl_yym character varying(6),
    pytfnl_tms character varying(3),
    coope_nam character varying(60),
    prodt_cod character varying(10),
    prodt_nam character varying(60),
    prodt_typcod character varying(6),
    crrcy_cod character varying(6),
    mange_dtc character varying(10),
    invitor_num character varying(10),
    reremp_num character varying(10),
    regno_20 character varying(13),
    insur_age20 numeric(3,0) DEFAULT 0,
    regno_30 character varying(13),
    insur_age30 numeric(3,0) DEFAULT 0,
    regno_40 character varying(13),
    insur_age40 numeric(3,0) DEFAULT 0,
    ins_examt numeric(15,0) DEFAULT 0,
    chage_num character varying(4),
    telno_hm character varying(20),
    telno_of character varying(20),
    telno_hd character varying(20),
    custm_nam character varying(40),
    chrpe_nm character varying(40),
    scrc_yn character(1),
    rcv_mtd character varying(30),
    pi_xpr_dt character varying(8)
) DISTRIBUTED BY (polno ,regno);


ALTER TABLE sdmin.comm_bk_mast OWNER TO letl;

--
-- Name: comm_br_brch; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE comm_br_brch (
    zbrbrcd character(3) NOT NULL,
    zbrgirocd character varying(6),
    zbrexbrcd character varying(3),
    zbrbubuncd character(1),
    zbrareacd character varying(3),
    zbrheadcd character varying(3),
    zbrmbrcd character(3),
    zbrexchar character(2),
    zbrmgrnm character varying(20),
    zbrkornm character varying(40) NOT NULL,
    zbrkornm1 character varying(20) NOT NULL,
    zbrengnm character varying(50),
    zbrengcmnm character varying(20),
    zbrsano character varying(10),
    zbrdomgu character(1),
    zbrgukgo character(1),
    zbrtelno character varying(20),
    zbrfaxno character varying(20),
    zbrteljik character varying(20),
    zbrailno character(6),
    zbradrcd character varying(8),
    zbradres character varying(50),
    zbrengadr character varying(80),
    zbrsemucd character varying(3),
    zbrcijhmcd character varying(3),
    zbrbokcd character varying(4),
    zbrinhrat numeric(5,2) DEFAULT 0,
    zbropndt character(8) NOT NULL,
    zbrexopdt character varying(8),
    zbrclose character varying(8),
    zbrapsq numeric(2,0) NOT NULL,
    zbrilbr character(3),
    zbr365cd character(1),
    zbryagum character(1),
    zbrdaegum character(1),
    zbrhyubrcd character(1),
    zbryeclo character(1),
    zbrexchek character(1),
    zbrdivck character(1),
    zbrdivgb character(1),
    zbrdivbr character(3),
    zbrbrkind character(1),
    bmt_imsi integer
) DISTRIBUTED BY (zbrbrcd);


ALTER TABLE sdmin.comm_br_brch OWNER TO letl;

--
-- Name: comm_br_brch_b9; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE comm_br_brch_b9 (
    zbrbrcd character(3) NOT NULL,
    zbrgirocd character varying(6),
    zbrexbrcd character varying(3),
    zbrbubuncd character(1),
    zbrareacd character varying(3),
    zbrheadcd character varying(3),
    zbrmbrcd character(3),
    zbrexchar character(2),
    zbrmgrnm character varying(20),
    zbrkornm character varying(40) NOT NULL,
    zbrkornm1 character varying(20) NOT NULL,
    zbrengnm character varying(50),
    zbrengcmnm character varying(20),
    zbrsano character varying(10),
    zbrdomgu character(1),
    zbrgukgo character(1),
    zbrtelno character varying(20),
    zbrfaxno character varying(20),
    zbrteljik character varying(20),
    zbrailno character(6),
    zbradrcd character varying(8),
    zbradres character varying(50),
    zbrengadr character varying(80),
    zbrsemucd character varying(3),
    zbrcijhmcd character varying(3),
    zbrbokcd character varying(4),
    zbrinhrat numeric(5,2) DEFAULT 0,
    zbropndt character(8) NOT NULL,
    zbrexopdt character varying(8),
    zbrclose character varying(8),
    zbrapsq numeric(2,0) NOT NULL,
    zbrilbr character(3),
    zbr365cd character(1),
    zbryagum character(1),
    zbrdaegum character(1),
    zbrhyubrcd character(1),
    zbryeclo character(1),
    zbrexchek character(1),
    zbrdivck character(1),
    zbrdivgb character(1),
    zbrdivbr character(3),
    zbrbrkind character(1),
    bmt_imsi integer
) DISTRIBUTED BY (zbrbrcd);


ALTER TABLE sdmin.comm_br_brch_b9 OWNER TO letl;

--
-- Name: comm_cd_every; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE comm_cd_every (
    zcdkind character varying(3) NOT NULL,
    zcdcode character varying(10) NOT NULL,
    zcdname character varying(100) NOT NULL,
    zcdbigo character varying(220),
    zcdcdnm character varying(50)
) DISTRIBUTED BY (zcdkind ,zcdcode ,zcdname);


ALTER TABLE sdmin.comm_cd_every OWNER TO letl;

--
-- Name: comm_ep_emp; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE comm_ep_emp (
    zepbrcd character varying(3) NOT NULL,
    zepempno character varying(6) NOT NULL,
    zepbaldt character varying(8) NOT NULL,
    zepname character varying(20),
    zepgup character varying(2),
    zepho character varying(2),
    zepsex character varying(1),
    zepjikwi character varying(20),
    zepcidno character varying(13),
    zepupdt character varying(8),
    zepibdt character varying(8),
    zepaftscool character varying(20),
    zepoldbr character varying(3),
    zepstrdt character varying(8),
    zepextdt character varying(8),
    zepnextbr character varying(3),
    zepschool character varying(20),
    zepailno character varying(6),
    zepaddr character varying(50),
    zepretiredt character varying(8),
    zepaudtcd character varying(1),
    zepjikcd character varying(4),
    zeptellerid character varying(8),
    zepteamid character varying(8),
    zepjiknm character varying(30),
    zeptellernm character varying(30),
    zepteamnm character varying(30)
) DISTRIBUTED BY (zepempno ,zepname ,zepbrcd);


ALTER TABLE sdmin.comm_ep_emp OWNER TO letl;

--
-- Name: comm_im_paper; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE comm_im_paper (
    trn_dt character(8),
    trbr character(3),
    trn_tm character(6),
    op_no character(2),
    trm_no character(2),
    inp_emp_no character varying(6),
    ideed_cd_no character(3),
    use_vol numeric(8,0),
    acp_brno character varying(3),
    trn_kd_cd character(2),
    use_obj_txt character varying(60),
    suof_txt character varying(60),
    user_nm character varying(60),
    usavl_dscd character(2)
) DISTRIBUTED BY (trbr);


ALTER TABLE sdmin.comm_im_paper OWNER TO letl;

--
-- Name: comm_menu_step; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE comm_menu_step (
    step1 character varying(100),
    step2 character varying(200),
    step3 character varying(200),
    step4 character varying(200),
    step5 character varying(200),
    programgb character(1),
    subtitle character varying(100),
    programid character varying(100),
    mngbr character varying(50),
    loaddt date DEFAULT ('now'::text)::date
) DISTRIBUTED BY (step1 ,step2 ,step3 ,step4 ,step5);


ALTER TABLE sdmin.comm_menu_step OWNER TO letl;

--
-- Name: comm_mr_cif; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE comm_mr_cif (
    baseym character(6) NOT NULL,
    cprcd character(5) NOT NULL,
    cifno character(13) NOT NULL,
    regdt character varying(8) NOT NULL,
    clodt character varying(8),
    addgb character varying(1),
    jobdt date DEFAULT ('now'::text)::date
) DISTRIBUTED BY (baseym ,cprcd ,cifno ,regdt);


ALTER TABLE sdmin.comm_mr_cif OWNER TO letl;

--
-- Name: comm_mr_mgr; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE comm_mr_mgr (
    baseym character(6) NOT NULL,
    cprcd character(5) NOT NULL,
    empno character varying(8) NOT NULL,
    regdt character varying(8) NOT NULL,
    clodt character varying(8),
    jobuser character varying(8),
    jobdt date DEFAULT ('now'::text)::date
) DISTRIBUTED BY (baseym ,cprcd ,empno ,regdt);


ALTER TABLE sdmin.comm_mr_mgr OWNER TO letl;

--
-- Name: comm_pb_ct_result; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE comm_pb_ct_result (
    pct_basedt character varying(8) NOT NULL,
    pct_umgb character varying(1) NOT NULL,
    pct_cifno character varying(13) NOT NULL,
    pct_acno character varying(20) NOT NULL,
    pct_accd character varying(6) NOT NULL,
    pct_curr character varying(2) DEFAULT '00'::character varying,
    pct_bal numeric(15,2) DEFAULT 0,
    pct_etc_amt numeric(15,2) DEFAULT 0,
    pct_etc_gb character varying(1),
    pct_jobdt date DEFAULT ('now'::text)::date,
    pct_miscifcd character varying(2),
    pct_wavg numeric(17,2) DEFAULT 0,
    pct_yavg numeric(17,2) DEFAULT 0,
    pct_wjus numeric(17,2) DEFAULT 0,
    pct_yjus numeric(17,2) DEFAULT 0,
    pct_etc_gb_2 character varying(1),
    pct_acbr character varying(3),
    pct_ycamt numeric(15,0),
    pct_ycamt1a numeric(15,0)
) DISTRIBUTED BY (pct_cifno ,pct_acno);


ALTER TABLE sdmin.comm_pb_ct_result OWNER TO letl;

--
-- Name: comm_pb_mg_cif; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE comm_pb_mg_cif (
    pmg_baseyymm character varying(6) NOT NULL,
    pmg_empno character varying(8) NOT NULL,
    pmg_empbr character varying(3) NOT NULL,
    pmg_cifno character varying(13) NOT NULL,
    pmg_pbgb character varying(1) NOT NULL,
    pmg_cifgb character varying(1),
    pmg_strdt character varying(8),
    pmg_clodt character varying(8),
    pmg_jobdt date DEFAULT ('now'::text)::date,
    pmg_movegb character varying(1),
    pmg_moveemp character varying(8),
    pmg_addgb character varying(1),
    pmg_cprcd character varying(5),
    pmg_dpcnt numeric(5,0),
    pmg_q5hmovr numeric(5,0),
    pmg_b5hmovr numeric(5,0),
    pmg_trskip numeric(5,0),
    pmg_acjobdt date
) DISTRIBUTED BY (pmg_empno);


ALTER TABLE sdmin.comm_pb_mg_cif OWNER TO letl;

--
-- Name: comm_vaca_tbl; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE comm_vaca_tbl (
    emp_no character varying(6) NOT NULL,
    fr_date date NOT NULL,
    job_id character varying(5) NOT NULL,
    to_date date,
    assig character varying(4),
    assig_nm character varying(50),
    grade character varying(2),
    "position" character varying(4),
    last_usrid character varying(10),
    last_date date
) DISTRIBUTED BY (emp_no ,job_id);


ALTER TABLE sdmin.comm_vaca_tbl OWNER TO letl;

--
-- Name: connectby_tree; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE connectby_tree (
    keyid text,
    parent_keyid text,
    pos integer
) DISTRIBUTED BY (keyid);


ALTER TABLE sdmin.connectby_tree OWNER TO letl;

--
-- Name: crms_trace; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE crms_trace (
    ttime character varying(14) NOT NULL,
    tuserid character varying(20) NOT NULL,
    tuserip character varying(40) NOT NULL,
    tusersec character varying(1) NOT NULL,
    trepname character varying(100),
    trepsec character varying(1),
    treptype character varying(1),
    tquery character varying(500),
    topnbr character varying(3),
    tcifno character varying(13)
) DISTRIBUTED BY (ttime);


ALTER TABLE sdmin.crms_trace OWNER TO letl;

--
-- Name: cu040tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE cu040tf (
    cus_no character(13) NOT NULL,
    bk_tel_dps_stcd character(1),
    bk_tel_dps_rgs_dt character(8),
    bk_tel_lst_rej_dt character(8),
    bk_wrcst_stcd character(1),
    bk_wrcst_rgs_dt character(8),
    bk_wrcst_rej_dt character(8),
    bc_tel_dps_stcd character(1),
    bc_tel_dps_rgs_dt character(8),
    bc_tel_rev_dt character(8),
    lst_load_dt character(8),
    ln_wrcst_cn numeric(3,0),
    ln_wrcst_rgs_dt character varying(8),
    ln_wrcst_rev_dt character varying(8),
    dps_wrcst_cn numeric(3,0),
    dps_wrcst_rgs_dt character varying(8),
    dps_wrcst_rev_dt character varying(8),
    cd_wrcst_cn numeric(3,0),
    cd_wrcst_rgs_dt character varying(8),
    cd_wrcst_rev_dt character varying(8),
    etc_wrcst_cn numeric(3,0),
    etc_wrcst_rgs_dt character varying(8),
    etc_wrcst_rev_dt character varying(8),
    tm_avl_inf character varying(1),
    tm_rgs_dt character varying(8),
    tm_sto_dt character varying(8),
    sms_avl_inf character varying(1),
    sms_rgs_dt character varying(8),
    sms_sto_dt character varying(8),
    dm_avl_inf character varying(1),
    dm_rgs_dt character varying(8),
    dm_sto_dt character varying(8),
    eml_avl_inf character varying(1),
    eml_rgs_dt character varying(8),
    eml_sto_dt character varying(8)
) DISTRIBUTED BY (cus_no);


ALTER TABLE sdmin.cu040tf OWNER TO letl;

--
-- Name: cust_ba_base; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE cust_ba_base (
    cbacidno character(13) NOT NULL,
    cbaname character varying(30),
    cbaeobname character varying(50),
    cbacidcd character varying(2),
    cbacntcd character varying(3),
    cbataxcd character varying(1),
    cbagyumocd character(1),
    cbaindcd character varying(4),
    cbaopndt character varying(8),
    cbaopnbr character varying(3),
    cbalstdt character varying(8) DEFAULT '00000000'::character varying,
    cbajikno character varying(7),
    cbamailgb character(1),
    cbanoticgb character(1),
    cbasugamgb character(1),
    cbapanprgb character(1),
    cbarecmkgb character(1),
    cbaailno character varying(6),
    cbaadrcd character varying(8),
    cbaadres character varying(50),
    cbatelno character varying(20),
    cbafaxno character varying(20),
    cbabigo character varying(30),
    cbabibino character varying(20),
    cbahandno character varying(20),
    cbabcailno character varying(6),
    cbabcadrcd character varying(8),
    cbabcadres character varying(50),
    cbabctelno character varying(20),
    cbalsttm character varying(6) DEFAULT '000000'::character varying,
    cbageoju character(1),
    cbacomp05 character(1),
    cbajang character(1),
    cbaemail character varying(30),
    cbainfor character(1),
    cbacprcd character varying(5),
    cbacustcd character varying(2),
    cbaopstdr character(1),
    cbamegak character(1),
    cbakeyman character(1),
    cbakeybr character varying(3),
    cbaempck character(1),
    cbactrdl character(1),
    cbasiljp character(1),
    cbaupjong character varying(5),
    cbanation character varying(2),
    cbaltdobj character varying(2),
    cbabctel character(1),
    cbabktel character(1),
    cbacprcd1 character varying(5),
    bmt_imsi integer
) DISTRIBUTED BY (cbacidno);


ALTER TABLE sdmin.cust_ba_base OWNER TO letl;

--
-- Name: cust_ba_base_b9; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE cust_ba_base_b9 (
    cbacidno character(13) NOT NULL,
    cbaname character varying(30),
    cbaeobname character varying(50),
    cbacidcd character varying(2),
    cbacntcd character varying(3),
    cbataxcd character varying(1),
    cbagyumocd character(1),
    cbaindcd character varying(4),
    cbaopndt character varying(8),
    cbaopnbr character varying(3),
    cbalstdt character varying(8) DEFAULT '00000000'::character varying,
    cbajikno character varying(7),
    cbamailgb character(1),
    cbanoticgb character(1),
    cbasugamgb character(1),
    cbapanprgb character(1),
    cbarecmkgb character(1),
    cbaailno character varying(6),
    cbaadrcd character varying(8),
    cbaadres character varying(50),
    cbatelno character varying(20),
    cbafaxno character varying(20),
    cbabigo character varying(30),
    cbabibino character varying(20),
    cbahandno character varying(20),
    cbabcailno character varying(6),
    cbabcadrcd character varying(8),
    cbabcadres character varying(50),
    cbabctelno character varying(20),
    cbalsttm character varying(6) DEFAULT '000000'::character varying,
    cbageoju character(1),
    cbacomp05 character(1),
    cbajang character(1),
    cbaemail character varying(30),
    cbainfor character(1),
    cbacprcd character varying(5),
    cbacustcd character varying(2),
    cbaopstdr character(1),
    cbamegak character(1),
    cbakeyman character(1),
    cbakeybr character varying(3),
    cbaempck character(1),
    cbactrdl character(1),
    cbasiljp character(1),
    cbaupjong character varying(5),
    cbanation character varying(2),
    cbaltdobj character varying(2),
    cbabctel character(1),
    cbabktel character(1),
    cbacprcd1 character varying(5),
    bmt_imsi integer
) DISTRIBUTED BY (cbacidno);


ALTER TABLE sdmin.cust_ba_base_b9 OWNER TO letl;

--
-- Name: cust_ba_juso; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE cust_ba_juso (
    cbcidno character(13) NOT NULL,
    cbkind character(1) NOT NULL,
    cbgubun1 character(1),
    cbpost1 character varying(6),
    cbjuso1 character varying(100),
    cbbjuso1 character varying(100),
    cbpnu1 character(25),
    cbtrdt1 character varying(8),
    cbgubun2 character(1),
    cbpost2 character varying(6),
    cbjuso2 character varying(100),
    cbbjuso2 character varying(100),
    cbpnu2 character(25),
    cbtrdt2 character varying(8),
    cbgubun3 character(1),
    cbpost3 character(6),
    cbjuso3 character varying(100),
    cbbjuso3 character varying(100),
    cbpnu3 character(25),
    cbtrdt3 character varying(8),
    bmt_imsi integer
) DISTRIBUTED BY (cbcidno ,cbkind);


ALTER TABLE sdmin.cust_ba_juso OWNER TO letl;

--
-- Name: cust_ba_juso_b9; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE cust_ba_juso_b9 (
    cbcidno character(13) NOT NULL,
    cbkind character(1) NOT NULL,
    cbgubun1 character(1),
    cbpost1 character varying(6),
    cbjuso1 character varying(100),
    cbbjuso1 character varying(100),
    cbpnu1 character(25),
    cbtrdt1 character varying(8),
    cbgubun2 character(1),
    cbpost2 character varying(6),
    cbjuso2 character varying(100),
    cbbjuso2 character varying(100),
    cbpnu2 character(25),
    cbtrdt2 character varying(8),
    cbgubun3 character(1),
    cbpost3 character(6),
    cbjuso3 character varying(100),
    cbbjuso3 character varying(100),
    cbpnu3 character(25),
    cbtrdt3 character varying(8),
    bmt_imsi integer
) DISTRIBUTED BY (cbcidno ,cbkind);


ALTER TABLE sdmin.cust_ba_juso_b9 OWNER TO letl;

--
-- Name: cust_rl_dp_woltb; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE cust_rl_dp_woltb (
    cdpcifno character(13),
    cdpcifcd character(2),
    cdpjobcd character(2),
    cdpadrcd character(8),
    cdpacno character(12),
    cdpopnbr character(3),
    cdpaccd character(2),
    cdpgdcd character(3),
    cdpopndt character(8),
    cdpclodt character(8),
    cdpexpdt character(8),
    cdptermm numeric(4,0),
    cdprate numeric(7,4),
    cdpmbal numeric(15,0),
    cdpavg1 numeric(15,0),
    cdpavg3 numeric(15,0),
    cdpconam numeric(15,0),
    cdpcloamt numeric(15,0),
    cdpopncd character(2),
    cdpclocd character(2),
    cdpdepcn numeric(4,0),
    cdpdueam numeric(15,0),
    cdpterdt numeric(3,0),
    cdptercd character(1),
    cdpgyemm numeric(4,0),
    cdpgyedd numeric(4,0),
    cdptrseq numeric(4,0),
    cdpintcd character(1),
    cdpintpt character(1),
    cdpypcd character(1),
    cdpypter character(1),
    cdpyexdt character(8),
    cdpypydt character(8),
    cdppam numeric(15,0),
    cdpinicn numeric(4,0),
    cdpdepcd character(1),
    cdpfundcd character(2)
) DISTRIBUTED BY (cdpcifno ,cdpacno ,cdptrseq);


ALTER TABLE sdmin.cust_rl_dp_woltb OWNER TO letl;

--
-- Name: cust_rl_dt_tbl; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE cust_rl_dt_tbl (
    cdtpgnm character varying(12),
    cdtilja character(8)
) DISTRIBUTED BY (cdtpgnm ,cdtilja);


ALTER TABLE sdmin.cust_rl_dt_tbl OWNER TO letl;

--
-- Name: cust_rl_vp_tbl; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE cust_rl_vp_tbl (
    cvpbrno character(3),
    cvpcifno character(13),
    cvpcifcd character(2),
    cvplngu character(1),
    cvpmjan numeric(15,0) DEFAULT 0,
    cvpavg1 numeric(15,0) DEFAULT 0,
    cvpavg3 numeric(15,0) DEFAULT 0,
    cvplsmamt numeric(15,0) DEFAULT 0,
    cvplmjan numeric(15,0) DEFAULT 0
) DISTRIBUTED BY (cvpbrno ,cvpcifno ,cvpcifcd);


ALTER TABLE sdmin.cust_rl_vp_tbl OWNER TO letl;

--
-- Name: dd; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE dd (
    a numeric(3,2),
    b character(2)
) DISTRIBUTED BY (a);


ALTER TABLE sdmin.dd OWNER TO letl;

--
-- Name: depo_ac_comm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE depo_ac_comm (
    dacacno character(12) NOT NULL,
    daccifno character(13) NOT NULL,
    dacopndt character(8) NOT NULL,
    dacopncd character(2) NOT NULL,
    dacclodt character(8),
    dacclocd character(2),
    dacupddt character(8) NOT NULL,
    dacseqno numeric(5,0) NOT NULL,
    dacaccd character(2) NOT NULL,
    daccifcd character(2) NOT NULL,
    dacgdcd character(3),
    dactaxcd character(1),
    dacxjbal numeric(15,0) NOT NULL,
    dacxhbal numeric(15,0) NOT NULL,
    dacclbal numeric(15,0) DEFAULT 0,
    dacusrid character(6),
    dacusrbr character(3),
    dacstpdt character(8),
    dacgyldt character(8),
    dacjksdt character(8),
    dacsilcd character(1),
    dacsildt character(8),
    dacsilba numeric(15,0) DEFAULT 0,
    dacxhseq numeric(5,0),
    dacstkcd character(3),
    dacmybi character varying(3),
    dacgold character(1),
    dacstus character(1) DEFAULT '0'::bpchar,
    dacacbr character varying(3),
    dackngub character(1),
    dacisudt character varying(8),
    dacknlove character(1),
    dacyogdcd character(2),
    bmt_imsi integer
) DISTRIBUTED BY (dacacno);


ALTER TABLE sdmin.depo_ac_comm OWNER TO letl;

--
-- Name: depo_ac_comm_b9; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE depo_ac_comm_b9 (
    dacacno character(12) NOT NULL,
    daccifno character(13) NOT NULL,
    dacopndt character(8) NOT NULL,
    dacopncd character(2) NOT NULL,
    dacclodt character(8),
    dacclocd character(2),
    dacupddt character(8) NOT NULL,
    dacseqno numeric(5,0) NOT NULL,
    dacaccd character(2) NOT NULL,
    daccifcd character(2) NOT NULL,
    dacgdcd character(3),
    dactaxcd character(1),
    dacxjbal numeric(15,0) NOT NULL,
    dacxhbal numeric(15,0) NOT NULL,
    dacclbal numeric(15,0) DEFAULT 0,
    dacusrid character(6),
    dacusrbr character(3),
    dacstpdt character(8),
    dacgyldt character(8),
    dacjksdt character(8),
    dacsilcd character(1),
    dacsildt character(8),
    dacsilba numeric(15,0) DEFAULT 0,
    dacxhseq numeric(5,0),
    dacstkcd character(3),
    dacmybi character varying(3),
    dacgold character(1),
    dacstus character(1) DEFAULT '0'::bpchar,
    dacacbr character varying(3),
    dackngub character(1),
    dacisudt character varying(8),
    dacknlove character(1),
    dacyogdcd character(2),
    bmt_imsi integer
) DISTRIBUTED BY (dacacno);


ALTER TABLE sdmin.depo_ac_comm_b9 OWNER TO letl;

--
-- Name: depo_bd_dbal; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE depo_bd_dbal (
    dbdtrdt character(8) NOT NULL,
    dbdacno character(12) NOT NULL,
    dbdcifno character(13) NOT NULL,
    dbdgdcd character(3),
    dbdaccd character(2) NOT NULL,
    dbdcifcd character(2) NOT NULL,
    dbdxjbal numeric(15,0) NOT NULL,
    dbdxhbal numeric(15,0) NOT NULL,
    dbdicnt numeric(7,0) DEFAULT 0,
    dbdiamt numeric(15,0) DEFAULT 0,
    dbdjcnt numeric(7,0) DEFAULT 0,
    dbdjamt numeric(15,0) DEFAULT 0
) DISTRIBUTED BY (dbdacno);


ALTER TABLE sdmin.depo_bd_dbal OWNER TO letl;

--
-- Name: depo_cv_davg; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE depo_cv_davg (
    dcdyymm character(6) NOT NULL,
    dcdacno character(12) NOT NULL,
    dcdjbrno character(3),
    dcddate character varying(8),
    dcddavg numeric(15,0) DEFAULT 0
) DISTRIBUTED BY (dcdacno);


ALTER TABLE sdmin.depo_cv_davg OWNER TO letl;

--
-- Name: depo_cv_info; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE depo_cv_info (
    dcvjacno character(12) NOT NULL,
    dcvhacno character(12) NOT NULL,
    dcvdate character(8) NOT NULL,
    dcvcifno character(13) NOT NULL,
    dcvcode character(2) NOT NULL,
    dcvjbrno character varying(3),
    dcvhbrno character varying(3)
) DISTRIBUTED BY (dcvjacno ,dcvhacno);


ALTER TABLE sdmin.depo_cv_info OWNER TO letl;

--
-- Name: depo_ex_inf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE depo_ex_inf (
    dexacno character(12) NOT NULL,
    dexcifno character(13) NOT NULL,
    dexclodt character(8),
    dexcode character varying(3),
    dexc01 character(1),
    dexc02 character(1),
    dexc03 character(1),
    dexc04 character(1),
    dexc05 character(1),
    dexc06 character(1),
    dexc07 character(1),
    dexc08 character(1),
    dexc09 character(1),
    dexc10 character(1),
    dexc11 character(1),
    dexc12 character(1),
    dexc13 character(1),
    dexc14 character(1),
    dexc15 character(1),
    dexc16 character(1),
    dexc17 character(1),
    dexc18 character(1),
    dexc19 character(1),
    dexc20 character(1),
    dexc21 character(1),
    dexc22 character(1),
    dexc23 character(1),
    dexc24 character(1),
    dexc25 character(1),
    dexc26 character(1),
    dexc27 character(1),
    dexc28 character(1),
    dexc29 character(1),
    dexc30 character(1),
    dexmilno character varying(13),
    dexdesc character varying(30),
    dexc31 character(1),
    dexbrno character varying(3),
    dexc32 character(1),
    dexc33 character(1),
    dexc34 character(1),
    dexc35 character(1),
    dexc36 character(1),
    dexc37 character(1),
    dexc38 character(1),
    dexc39 character(1),
    dexc40 character(1),
    dexknbrno character varying(3),
    dexkndesc character varying(30),
    dexknusr character varying(6),
    dexc41 character(1),
    dexc37_to character varying(1),
    dexc42 character(1),
    dexc43 character(1)
) DISTRIBUTED BY (dexacno);


ALTER TABLE sdmin.depo_ex_inf OWNER TO letl;

--
-- Name: depo_exp_tongbo; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE depo_exp_tongbo (
    dextrdt character(6),
    dexbrno character(3),
    dexcifno character(13),
    dexacno character(12),
    dexmbal numeric(15,0),
    dexopndt character(8),
    dexexpdt character(8),
    dextermm numeric(4,0),
    dexrate numeric(7,4),
    dexconam numeric(15,0),
    dexdueam numeric(15,0),
    dexintcd character varying(20),
    dexgdnm character varying(30),
    dexregyn character(1),
    dexregdt character(8),
    dexregus character varying(10),
    dexcnlyn character(1),
    dexcnldt character(8),
    dexcnlus character varying(10),
    dexcfmyn character(1),
    dexcfmdt character(8),
    dexcfmus character varying(10),
    dexsilyn character(1),
    dexsildt character(8),
    dexsilus character varying(10),
    dextext character varying(200),
    dexmkdt character(17),
    dexin_pldg_yn character(1),
    dexoist_pldg_yn character(1),
    dexlaw_pay_lmt_yn character(1),
    dexmnr_yn character(1),
    dexrel_cus_yn character(1),
    dextext_mkdt character varying(20),
    dexbrtxt character varying(200),
    dexbrtxt_mkdt character varying(20),
    dexorg_user_yn character(1)
) DISTRIBUTED BY (dexbrno ,dexcifno);


ALTER TABLE sdmin.depo_exp_tongbo OWNER TO letl;

--
-- Name: depo_mm_dbal; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE depo_mm_dbal (
    dbdacno character(12) NOT NULL,
    dbdtrdt character(8) NOT NULL,
    dbdord smallint NOT NULL,
    dbdnxtdt character(8) NOT NULL,
    dbdxjbal numeric(15,0),
    dbdxhbal numeric(15,0),
    dbdicnt numeric(8,0),
    dbdiamt numeric(15,0),
    dbdjcnt numeric(8,0),
    dbdjamt numeric(15,0)
) DISTRIBUTED BY (dbdacno ,dbdord);


ALTER TABLE sdmin.depo_mm_dbal OWNER TO letl;

--
-- Name: depo_mm_mbal; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE depo_mm_mbal (
    dmmyear character(4) NOT NULL,
    dmmacno character(12) NOT NULL,
    dmmcifno character(13),
    dmmcifcd character(2),
    dmmaccd character(2),
    dmmgdcd character(3),
    dmmopndt character(8),
    dmmclodt character(8),
    dmmclocd character(2),
    dmmtermm numeric(4,0) DEFAULT 0,
    dmmconam numeric(15,0) DEFAULT 0,
    dmm01mbal numeric(15,0) DEFAULT 0,
    dmm01davg numeric(15,0) DEFAULT 0,
    dmm01lavg numeric(15,0) DEFAULT 0,
    dmm01icnt numeric(7,0) DEFAULT 0,
    dmm01iamt numeric(15,0) DEFAULT 0,
    dmm01jcnt numeric(7,0) DEFAULT 0,
    dmm01jamt numeric(15,0) DEFAULT 0,
    dmm02mbal numeric(15,0) DEFAULT 0,
    dmm02davg numeric(15,0) DEFAULT 0,
    dmm02lavg numeric(15,0) DEFAULT 0,
    dmm02icnt numeric(7,0) DEFAULT 0,
    dmm02iamt numeric(15,0) DEFAULT 0,
    dmm02jcnt numeric(7,0) DEFAULT 0,
    dmm02jamt numeric(15,0) DEFAULT 0,
    dmm03mbal numeric(15,0) DEFAULT 0,
    dmm03davg numeric(15,0) DEFAULT 0,
    dmm03lavg numeric(15,0) DEFAULT 0,
    dmm03icnt numeric(7,0) DEFAULT 0,
    dmm03iamt numeric(15,0) DEFAULT 0,
    dmm03jcnt numeric(7,0) DEFAULT 0,
    dmm03jamt numeric(15,0) DEFAULT 0,
    dmm04mbal numeric(15,0) DEFAULT 0,
    dmm04davg numeric(15,0) DEFAULT 0,
    dmm04lavg numeric(15,0) DEFAULT 0,
    dmm04icnt numeric(7,0) DEFAULT 0,
    dmm04iamt numeric(15,0) DEFAULT 0,
    dmm04jcnt numeric(7,0) DEFAULT 0,
    dmm04jamt numeric(15,0) DEFAULT 0,
    dmm05mbal numeric(15,0) DEFAULT 0,
    dmm05davg numeric(15,0) DEFAULT 0,
    dmm05lavg numeric(15,0) DEFAULT 0,
    dmm05icnt numeric(7,0) DEFAULT 0,
    dmm05iamt numeric(15,0) DEFAULT 0,
    dmm05jcnt numeric(7,0) DEFAULT 0,
    dmm05jamt numeric(15,0) DEFAULT 0,
    dmm06mbal numeric(15,0) DEFAULT 0,
    dmm06davg numeric(15,0) DEFAULT 0,
    dmm06lavg numeric(15,0) DEFAULT 0,
    dmm06icnt numeric(7,0) DEFAULT 0,
    dmm06iamt numeric(15,0) DEFAULT 0,
    dmm06jcnt numeric(7,0) DEFAULT 0,
    dmm06jamt numeric(15,0) DEFAULT 0,
    dmm07mbal numeric(15,0) DEFAULT 0,
    dmm07davg numeric(15,0) DEFAULT 0,
    dmm07lavg numeric(15,0) DEFAULT 0,
    dmm07icnt numeric(7,0) DEFAULT 0,
    dmm07iamt numeric(15,0) DEFAULT 0,
    dmm07jcnt numeric(7,0) DEFAULT 0,
    dmm07jamt numeric(15,0) DEFAULT 0,
    dmm08mbal numeric(15,0) DEFAULT 0,
    dmm08davg numeric(15,0) DEFAULT 0,
    dmm08lavg numeric(15,0) DEFAULT 0,
    dmm08icnt numeric(7,0) DEFAULT 0,
    dmm08iamt numeric(15,0) DEFAULT 0,
    dmm08jcnt numeric(7,0) DEFAULT 0,
    dmm08jamt numeric(15,0) DEFAULT 0,
    dmm09mbal numeric(15,0) DEFAULT 0,
    dmm09davg numeric(15,0) DEFAULT 0,
    dmm09lavg numeric(15,0) DEFAULT 0,
    dmm09icnt numeric(7,0) DEFAULT 0,
    dmm09iamt numeric(15,0) DEFAULT 0,
    dmm09jcnt numeric(7,0) DEFAULT 0,
    dmm09jamt numeric(15,0) DEFAULT 0,
    dmm10mbal numeric(15,0) DEFAULT 0,
    dmm10davg numeric(15,0) DEFAULT 0,
    dmm10lavg numeric(15,0) DEFAULT 0,
    dmm10icnt numeric(7,0) DEFAULT 0,
    dmm10iamt numeric(15,0) DEFAULT 0,
    dmm10jcnt numeric(7,0) DEFAULT 0,
    dmm10jamt numeric(15,0) DEFAULT 0,
    dmm11mbal numeric(15,0) DEFAULT 0,
    dmm11davg numeric(15,0) DEFAULT 0,
    dmm11lavg numeric(15,0) DEFAULT 0,
    dmm11icnt numeric(7,0) DEFAULT 0,
    dmm11iamt numeric(15,0) DEFAULT 0,
    dmm11jcnt numeric(7,0) DEFAULT 0,
    dmm11jamt numeric(15,0) DEFAULT 0,
    dmm12mbal numeric(15,0) DEFAULT 0,
    dmm12davg numeric(15,0) DEFAULT 0,
    dmm12lavg numeric(15,0) DEFAULT 0,
    dmm12icnt numeric(7,0) DEFAULT 0,
    dmm12iamt numeric(15,0) DEFAULT 0,
    dmm12jcnt numeric(7,0) DEFAULT 0,
    dmm12jamt numeric(15,0) DEFAULT 0,
    dmmrate numeric(7,4),
    dmmexpdt character(8),
    dmmopncd character(2),
    dmmclobal numeric(15,0) DEFAULT 0
) DISTRIBUTED BY (dmmacno ,dmmcifno);


ALTER TABLE sdmin.depo_mm_mbal OWNER TO letl;

--
-- Name: depo_mm_woltb; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE depo_mm_woltb (
    daccifno character(13) NOT NULL,
    dacacno character(12) NOT NULL,
    dacopndt character(8) NOT NULL,
    dacupddt character(8) NOT NULL,
    dacclodt character(8),
    dacclocd character(2),
    dacxjbal numeric(15,0) NOT NULL,
    dacxhbal numeric(15,0) NOT NULL,
    dacclbal numeric(15,0),
    dacopncd character(2) NOT NULL,
    dacgdcd character(3),
    dacdepcn numeric(4,0),
    dacconam numeric(15,0),
    dacexpdt character(8),
    dacschool character(2),
    dactrseq numeric(4,0),
    dactermm numeric(4,0),
    dacnxtrm numeric(4,0),
    daccifcd character(2),
    dactrrate numeric(7,4),
    dacterdt numeric(3,0),
    dactercd character(1),
    dacdueam numeric(15,0),
    dacgyemm numeric(4,0),
    dacgyedd numeric(4,0),
    dacintcd character(1),
    dacintpt character(1),
    dacypcd character(1),
    dacypter character(1),
    dacyexdt character(8),
    dacypydt character(8),
    dacpam numeric(15,0),
    dacinicn numeric(4,0),
    dacdepcd character(1),
    dacfundcd character varying(3),
    dacacbr character(3)
) DISTRIBUTED BY (dacacno ,daccifno);


ALTER TABLE sdmin.depo_mm_woltb OWNER TO letl;

--
-- Name: depo_rg_bond; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE depo_rg_bond (
    drgacno character(12) NOT NULL,
    drgcifno character(13) NOT NULL,
    drgopndt character(8) NOT NULL,
    drgopncd character(2) NOT NULL,
    drgclodt character(8),
    drgclocd character(2),
    drgupddt character(8) NOT NULL,
    drgseqno numeric(5,0) NOT NULL,
    drgcifcd character(2) NOT NULL,
    drgtaxcd character(1),
    drgdanga numeric(7,0),
    drgakbal numeric(15,0),
    drgmcbal numeric(15,0),
    drgclbal numeric(15,0),
    drgbtrseq character(2),
    drgbjong character(2),
    drgbkwon character(1),
    drgbmon character(2),
    drgbterm numeric(3,0),
    drgbrate numeric(7,4),
    drgbdate character(8),
    drgregdt character(8),
    drgexpdt character(8),
    drgusrid character(6),
    drgusrbr character(3),
    drghybrid character(1)
) DISTRIBUTED BY (drgacno);


ALTER TABLE sdmin.depo_rg_bond OWNER TO letl;

--
-- Name: depo_sj_mas; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE depo_sj_mas (
    dsjacno character(12) NOT NULL,
    dsjopndt character(8) NOT NULL,
    dsjcifno character(13) NOT NULL,
    dsjtrseq numeric(4,0) DEFAULT 0,
    dsjopncd character(2) NOT NULL,
    dsjclodt character(8),
    dsjclocd character(2),
    dsjaccd character(2) NOT NULL,
    dsjtaxcd character(1),
    dsjgdcd character(3),
    dsjxjbal numeric(15,0) NOT NULL,
    dsjxhbal numeric(15,0) NOT NULL,
    dsjclbal numeric(15,0) DEFAULT 0,
    dsjexpdt character(8),
    dsjdeldt character(8),
    dsjcledt character(8),
    dsjconam numeric(15,0) DEFAULT 0,
    dsjtermm numeric(4,0) DEFAULT 0,
    dsjterdd numeric(4,0) DEFAULT 0,
    dsjterdt numeric(3,0),
    dsjtercd character(1),
    dsjdueam numeric(15,0) DEFAULT 0,
    dsjdepcn numeric(4,0) DEFAULT 0,
    dsjlegam numeric(15,0) DEFAULT 0,
    dsjintcd character(1),
    dsjpcscd character(1),
    dsjrpdcd character(1),
    dsjtrrate numeric(7,4),
    dsjschool character(2),
    dsjchrate numeric(4,0) DEFAULT 0,
    dsjissucd character(1),
    dsjilamti numeric(15,0) DEFAULT 0,
    dsjilamto numeric(15,0) DEFAULT 0,
    dsjsangye character(1),
    dsjtfcode character(3),
    dsjratecd character(1),
    dsjbsrate numeric(7,4) DEFAULT 0
) DISTRIBUTED BY (dsjacno ,dsjtrseq ,dsjcifno);


ALTER TABLE sdmin.depo_sj_mas OWNER TO letl;

--
-- Name: depo_tr_mas; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE depo_tr_mas (
    dtracno character(12) NOT NULL,
    dtropndt character(8) NOT NULL,
    dtrcifno character(13) NOT NULL,
    dtrtrseq numeric(4,0) DEFAULT 0,
    dtropncd character(2) NOT NULL,
    dtrclodt character(8),
    dtrclocd character(2),
    dtraccd character(2) NOT NULL,
    dtrtaxcd character(1),
    dtrgdcd character(3),
    dtrxjbal numeric(15,0) NOT NULL,
    dtrxhbal numeric(15,0) NOT NULL,
    dtrclbal numeric(15,0) DEFAULT 0,
    dtrtermm numeric(4,0) DEFAULT 0,
    dtrterdd numeric(4,0) DEFAULT 0,
    dtrexpdt character(8),
    dtrdeldt character(8),
    dtrcledt character(8),
    dtrdepcd character(1),
    dtrconam numeric(15,0) DEFAULT 0,
    dtriniam numeric(15,0) DEFAULT 0,
    dtrterdt numeric(3,0),
    dtrtercd character(1),
    dtrdueam numeric(15,0) DEFAULT 0,
    dtrdepcn numeric(4,0),
    dtrintcd character(1),
    dtrintpt character(1),
    dtrypcd character(1),
    dtrypter character(1),
    dtryexdt character(8),
    dtrypydt character(8),
    dtrpam numeric(15,0) DEFAULT 0,
    dtrinicn numeric(4,0) DEFAULT 0,
    dtricifn character(13),
    dtrbcifn character(13),
    dtrtrrate numeric(7,4),
    dtrinsamt numeric(15,0),
    dtrninsam numeric(15,0),
    dtrjimon numeric(3,0),
    dtrfund character varying(6),
    dtrcurjas numeric(15,0) DEFAULT 0,
    dtrplancd character varying(14),
    dtrplangu character(1),
    dtrintro character varying(6)
) DISTRIBUTED BY (dtracno ,dtropndt ,dtrcifno);


ALTER TABLE sdmin.depo_tr_mas OWNER TO letl;

--
-- Name: dp905td; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE dp905td (
    bas_dt character(8),
    act_no character varying(20),
    act_srno numeric(6,0),
    acc_cd character(6),
    cur_cd character(2),
    dpspd_dscd character(3),
    act_mngbr_cd character(3),
    cus_no character(13),
    cus_qlf_cd character(2),
    uni_cd character(2),
    cus_cfcd character(2),
    dp_sbj_cd character(2),
    fnd_cd character(6),
    opn_dt character(8),
    can_dt character(8),
    ldg_bl numeric(18,0),
    ldg_act_cn numeric(13,0),
    bcls_bl numeric(18,0),
    dmn_bcls_avgbl numeric(18,3),
    dmn_bcls_acm numeric(18,0),
    fa_li_bl numeric(18,0),
    dmn_fa_li_avgbl numeric(18,3),
    dmn_fa_li_acm numeric(18,0),
    rcv_trn_cn numeric(10,0),
    rcv_am numeric(18,0),
    pay_trn_cn numeric(10,0),
    pay_am numeric(18,0),
    obc_am numeric(18,0),
    dmn_obc_avgbl numeric(18,3),
    dmn_obc_acm numeric(18,0),
    advpe_emp_no character(6),
    lst_load_dt character(8)
) DISTRIBUTED BY (act_no);


ALTER TABLE sdmin.dp905td OWNER TO letl;

--
-- Name: ea13mt; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ea13mt (
    job_date date NOT NULL,
    br_code numeric(3,0) NOT NULL,
    kind numeric(3,0) NOT NULL,
    cuscount numeric,
    account1 numeric,
    account2 numeric,
    jwa1 numeric,
    amt1 numeric,
    con1 numeric
) DISTRIBUTED BY (job_date ,br_code ,kind);


ALTER TABLE sdmin.ea13mt OWNER TO letl;

SET search_path = sdmin_err, pg_catalog;

--
-- Name: cm034tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE cm034tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.cm034tf_err OWNER TO letl;

SET search_path = sdmin, pg_catalog;

--
-- Name: ext_cm034tf; Type: EXTERNAL TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE EXTERNAL TABLE ext_cm034tf (
    trn_dt character(8),
    ef_trmdi_cd character(2),
    mdi_dinf character(5),
    psbz_no character(13),
    user_no character(8),
    trn_am numeric(18,0),
    fee_am numeric(18,0),
    rcvbk_cd character varying(4),
    rcv_acno character varying(20),
    rcvbk_br_cd character(6),
    pybk_cd character varying(4),
    pybk_paybr_cd character(6),
    pay_acno character varying(20),
    dlbk_cd character varying(4),
    dlbk_br_cd character(6),
    trn_tm character(8),
    trn_kd_txt character(22),
    trn_sts_txt character(10),
    rsp_cd character(4),
    trm_no character(3),
    trn_unq_no character(16),
    elt_eqp_conn_rec_txt character(20),
    mch_no character(20),
    mch_nm character(30),
    cd_no character(16),
    cus_giro_no character(20),
    giro_no character(10),
    trn_apv_rec_txt character(30),
    chk_cn_txt character(3),
    chk_inf character varying(150),
    rmtpe_csno character(13),
    trn_cd character(6),
    lst_load_dt character(8)
) LOCATION (
    'gpfdist://sdw9:8091//data2/DAT/cm034tf_chg.dat'
) FORMAT 'text' (delimiter E';' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.cm034tf_err SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_cm034tf OWNER TO letl;

SET search_path = sdmin_err, pg_catalog;

--
-- Name: dp905td_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE dp905td_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.dp905td_err OWNER TO letl;

SET search_path = sdmin, pg_catalog;

--
-- Name: ext_dp905td; Type: EXTERNAL TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE EXTERNAL TABLE ext_dp905td (
    bas_dt character(8),
    act_no character varying(20),
    act_srno numeric(6,0),
    acc_cd character(6),
    cur_cd character(2),
    dpspd_dscd character(3),
    act_mngbr_cd character(3),
    cus_no character(13),
    cus_qlf_cd character(2),
    uni_cd character(2),
    cus_cfcd character(2),
    dp_sbj_cd character(2),
    fnd_cd character(6),
    opn_dt character(8),
    can_dt character(8),
    ldg_bl numeric(18,0),
    ldg_act_cn numeric(13,0),
    bcls_bl numeric(18,0),
    dmn_bcls_avgbl numeric(18,3),
    dmn_bcls_acm numeric(18,0),
    fa_li_bl numeric(18,0),
    dmn_fa_li_avgbl numeric(18,3),
    dmn_fa_li_acm numeric(18,0),
    rcv_trn_cn numeric(10,0),
    rcv_am numeric(18,0),
    pay_trn_cn numeric(10,0),
    pay_am numeric(18,0),
    obc_am numeric(18,0),
    dmn_obc_avgbl numeric(18,3),
    dmn_obc_acm numeric(18,0),
    advpe_emp_no character(6),
    lst_load_dt character(8)
) LOCATION (
    'gpfdist://sdw9:8092//data2/DAT/dp905td_chg.dat'
) FORMAT 'text' (delimiter E';' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.dp905td_err SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_dp905td OWNER TO letl;

--
-- Name: ext_gpload20130524_142640_45459; Type: EXTERNAL TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE EXTERNAL TABLE ext_gpload20130524_142640_45459 (
    trn_dt character(8),
    ef_trmdi_cd character(2),
    mdi_dinf character(5),
    psbz_no character(13),
    user_no character(8),
    trn_am numeric(18,0),
    fee_am numeric(18,0),
    rcvbk_cd character varying(4),
    rcv_acno character varying(20),
    rcvbk_br_cd character(6),
    pybk_cd character varying(4),
    pybk_paybr_cd character(6),
    pay_acno character varying(20),
    dlbk_cd character varying(4),
    dlbk_br_cd character(6),
    trn_tm character(8),
    trn_kd_txt character(22),
    trn_sts_txt character(10),
    rsp_cd character(4),
    trm_no character(3),
    trn_unq_no character(16),
    elt_eqp_conn_rec_txt character(20),
    mch_no character(20),
    mch_nm character(30),
    cd_no character(16),
    cus_giro_no character(20),
    giro_no character(10),
    trn_apv_rec_txt character(30),
    chk_cn_txt character(3),
    chk_inf character varying(150),
    rmtpe_csno character(13),
    trn_cd character(6),
    lst_load_dt character(8)
) LOCATION (
    'gpfdist://sdw9:8082//data2/DAT/cm034tf_chg.dat'
) FORMAT 'text' (delimiter E';' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.cm034tf_err SEGMENT REJECT LIMIT 25 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_gpload20130524_142640_45459 OWNER TO letl;

SET search_path = sdmin_err, pg_catalog;

--
-- Name: hum4b2tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum4b2tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum4b2tm_err OWNER TO letl;

SET search_path = sdmin, pg_catalog;

--
-- Name: ext_gpload20130527_160548_87300; Type: EXTERNAL TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_gpload20130527_160548_87300 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    scnr_id character(5),
    rwa_cal_id character(42),
    std_aset_clas_cd character(5),
    in_rk_aset_clas_cd character(5),
    std_ead_am numeric(18,3),
    firb_ead_am numeric(18,3),
    airb_ead_am numeric(18,3),
    std_ccf_cd character(2),
    firb_ccf_cd character(2),
    lmt_ln_tp_gcfcd character(1),
    lmt_ln_tp_scfcd character(3),
    db_chg_ts timestamp(6) without time zone
) LOCATION (
    'gpfdist://sdw9:8081//data/BASEL/dat/*HUM4B2TM_2*.dat'
) FORMAT 'text' (delimiter E'|' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.hum4b2tm_err SEGMENT REJECT LIMIT 25 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_gpload20130527_160548_87300 OWNER TO gpadmin;

SET search_path = sdmin_err, pg_catalog;

--
-- Name: hum216tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum216tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum216tm_err OWNER TO letl;

SET search_path = sdmin, pg_catalog;

--
-- Name: ext_gpload20130527_160607_87376; Type: EXTERNAL TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_gpload20130527_160607_87376 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    crd_mtg_id character(30),
    rwa_cal_id character(42),
    mgg_id character(20),
    est_srno character(3),
    apvrq_no character(11),
    rq_srno character(3),
    xps_id character(30),
    ctp_id character(20),
    liv_cm_use_dscd character(1),
    tsa_a_stsp_aply_yn character(1),
    tsa_a_stch_aply_yn character(1),
    tsa_a_firb_fit_yn character(1),
    tsa_a_airb_fit_yn character(1),
    sapc_rsk_wgt_rt numeric(12,8),
    zero_hct_yn character(1),
    xpr_dcrd_yn character(1),
    call_dcrd_yn character(1),
    rsk_wgt_rt numeric(12,8),
    mgg_aloc_am numeric(18,3),
    if_ts_sys_cd character(1),
    db_chg_ts timestamp(6) without time zone
) LOCATION (
    'gpfdist://sdw9:8081//data/BASEL/dat/*HUM216TM_2*.dat'
) FORMAT 'text' (delimiter E'|' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.hum216tm_err SEGMENT REJECT LIMIT 25 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_gpload20130527_160607_87376 OWNER TO gpadmin;

SET search_path = sdmin_err, pg_catalog;

--
-- Name: hum215tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum215tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum215tm_err OWNER TO letl;

SET search_path = sdmin, pg_catalog;

--
-- Name: ext_gpload20130527_160615_87407; Type: EXTERNAL TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_gpload20130527_160615_87407 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    aloc_scnr_id character(5),
    crd_mtg_id character(30),
    rwa_cal_id character(42),
    ctp_id character(20),
    crd_mtg_aloc_rk numeric(8,0),
    xps_aloc_rk numeric(8,0),
    crm_xps_aloc_rk numeric(8,0),
    liv_cm_use_dscd character(1),
    tsa_a_stsp_fit_yn character(1),
    tsa_a_stch_fit_yn character(1),
    tsa_a_firb_fit_yn character(1),
    tsa_a_airb_fit_yn character(1),
    xpr_dcrd_yn character(1),
    call_dcrd_yn character(1),
    rsk_wgt_rt numeric(12,8),
    crd_mtg_aloc_am numeric(18,3),
    mgg_aloc_am numeric(18,3),
    crd_mtg_bas_am numeric(18,3),
    xps_bas_am numeric(18,3),
    aloc_bf_crd_mtg_am numeric(18,3),
    aloc_bf_xps_am numeric(18,3),
    aloc_af_crd_mtg_am numeric(18,3),
    aloc_af_xps_am numeric(18,3),
    db_chg_ts timestamp(6) without time zone,
    aply_ead_am numeric(18,3),
    crd_mtg_add_aloc_am numeric(18,3)
) LOCATION (
    'gpfdist://sdw9:8083//data/BASEL/dat/*HUM215TM_2*.dat'
) FORMAT 'text' (delimiter E'|' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.hum215tm_err SEGMENT REJECT LIMIT 25 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_gpload20130527_160615_87407 OWNER TO gpadmin;

SET search_path = sdmin_err, pg_catalog;

--
-- Name: hu0b22tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b22tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0b22tm_err OWNER TO letl;

SET search_path = sdmin, pg_catalog;

--
-- Name: ext_gpload20130527_160624_87446; Type: EXTERNAL TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_gpload20130527_160624_87446 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    scnr_id character(5),
    rwa_cal_id character(42),
    xps_id character(30),
    xps_tpcd character(2),
    acc_dscd character(2),
    acc_cd character(11),
    act_mngbr_cd character(5),
    ctp_id character(20),
    tot_sal_am numeric(18,3),
    std_aset_clas_cd character(5),
    in_rk_aset_clas_cd character(5),
    xps_pre_af_rk_cd character(2),
    nbis_bas_dsh_yn character(1),
    xps_sdt character(10),
    xps_xpdt character(10),
    xps_srviv_xpr_ycn numeric(10,4),
    em_ycn numeric(10,4),
    stm_prd_tgt_yn character(1),
    cur_cd character(3),
    krw_xc_lmt_am numeric(18,3),
    krw_xc_not_wdr_bl numeric(18,3),
    krw_xc_bl numeric(18,3),
    gen_alw_am numeric(18,3),
    spc_alw_am numeric(18,3),
    ead_am numeric(18,3),
    adj_ead_am numeric(18,3),
    lgd_rt numeric(12,8),
    fcst_los_rt numeric(12,8),
    fcst_los_am numeric(18,3),
    wgt_avg_rsk_wgt_rt numeric(12,8),
    std_hld_rsk_wgt_rt numeric(12,8),
    xps_rsk_wgt_rt numeric(12,8),
    fcls_opt_estm_rt numeric(12,8),
    crd_evl_mdl_dscd character(2),
    ext_crdrk_cd character(2),
    rtsel_pol_id character(20),
    wgt_avg_dsh_rt numeric(12,8),
    xps_dsh_rt numeric(12,8),
    oist_evl_ist_cd character(2),
    oist_crdrk_txt character(10),
    onac_ofset_am numeric(18,3),
    mcr_am numeric(18,3),
    mgg_pt_rwa_am numeric(18,3),
    nmgg_pt_rwa_am numeric(18,3),
    rwast_am numeric(18,3),
    adj_af_xps_am numeric(18,3),
    fnc_mgg_aloc_am numeric(18,3),
    nfnc_mgg_aloc_am numeric(18,3),
    crd_dvprd_aloc_am numeric(18,3),
    grn_aloc_am numeric(18,3),
    rre_vld_mgg_am numeric(18,3),
    cre_vld_mgg_am numeric(18,3),
    crd_mtg_xps_am numeric(18,3),
    acl_id character(20),
    coco_nv numeric(12,8),
    std_inds_cfcd character(5),
    cosiz_cd character(2),
    nbis_ptf_dscd character(2),
    bdsys_dscd character(2),
    acc_bas_biz_hq_cd character(3),
    cus_bas_biz_hq_cd character(3),
    db_chg_ts timestamp(6) without time zone,
    fc_aset_yn character(1),
    nbis_cal_aply_dscd character(1),
    co_rtsel_dscd character(1),
    psco_rgno character(13),
    psbz_no character(13),
    prd_cd character(9),
    gen_bdr_am numeric(18,3),
    spc_bdr_am numeric(18,3),
    bl_ead_am numeric(18,3),
    nuse_lmt_ead_am numeric(18,3),
    bl_el_am numeric(18,3),
    nuse_lmt_el_am numeric(18,3),
    aply_aset_clas_cd character varying(4),
    lnk_com_cd character(8)
) LOCATION (
    'gpfdist://sdw9:8084//data/BASEL/dat/*HU0B22TM_2*.dat'
) FORMAT 'text' (delimiter E'|' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.hu0b22tm_err SEGMENT REJECT LIMIT 25 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_gpload20130527_160624_87446 OWNER TO gpadmin;

--
-- Name: ext_gpload20130527_161137_87879; Type: EXTERNAL TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_gpload20130527_161137_87879 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    scnr_id character(5),
    rwa_cal_id character(42),
    xps_id character(30),
    xps_tpcd character(2),
    acc_dscd character(2),
    acc_cd character(11),
    act_mngbr_cd character(5),
    ctp_id character(20),
    tot_sal_am numeric(18,3),
    std_aset_clas_cd character(5),
    in_rk_aset_clas_cd character(5),
    xps_pre_af_rk_cd character(2),
    nbis_bas_dsh_yn character(1),
    xps_sdt character(10),
    xps_xpdt character(10),
    xps_srviv_xpr_ycn numeric(10,4),
    em_ycn numeric(10,4),
    stm_prd_tgt_yn character(1),
    cur_cd character(3),
    krw_xc_lmt_am numeric(18,3),
    krw_xc_not_wdr_bl numeric(18,3),
    krw_xc_bl numeric(18,3),
    gen_alw_am numeric(18,3),
    spc_alw_am numeric(18,3),
    ead_am numeric(18,3),
    adj_ead_am numeric(18,3),
    lgd_rt numeric(12,8),
    fcst_los_rt numeric(12,8),
    fcst_los_am numeric(18,3),
    wgt_avg_rsk_wgt_rt numeric(12,8),
    std_hld_rsk_wgt_rt numeric(12,8),
    xps_rsk_wgt_rt numeric(12,8),
    fcls_opt_estm_rt numeric(12,8),
    crd_evl_mdl_dscd character(2),
    ext_crdrk_cd character(2),
    rtsel_pol_id character(20),
    wgt_avg_dsh_rt numeric(12,8),
    xps_dsh_rt numeric(12,8),
    oist_evl_ist_cd character(2),
    oist_crdrk_txt character(10),
    onac_ofset_am numeric(18,3),
    mcr_am numeric(18,3),
    mgg_pt_rwa_am numeric(18,3),
    nmgg_pt_rwa_am numeric(18,3),
    rwast_am numeric(18,3),
    adj_af_xps_am numeric(18,3),
    fnc_mgg_aloc_am numeric(18,3),
    nfnc_mgg_aloc_am numeric(18,3),
    crd_dvprd_aloc_am numeric(18,3),
    grn_aloc_am numeric(18,3),
    rre_vld_mgg_am numeric(18,3),
    cre_vld_mgg_am numeric(18,3),
    crd_mtg_xps_am numeric(18,3),
    acl_id character(20),
    coco_nv numeric(12,8),
    std_inds_cfcd character(5),
    cosiz_cd character(2),
    nbis_ptf_dscd character(2),
    bdsys_dscd character(2),
    acc_bas_biz_hq_cd character(3),
    cus_bas_biz_hq_cd character(3),
    db_chg_ts timestamp(6) without time zone,
    fc_aset_yn character(1),
    nbis_cal_aply_dscd character(1),
    co_rtsel_dscd character(1),
    psco_rgno character(13),
    psbz_no character(13),
    prd_cd character(9),
    gen_bdr_am numeric(18,3),
    spc_bdr_am numeric(18,3),
    bl_ead_am numeric(18,3),
    nuse_lmt_ead_am numeric(18,3),
    bl_el_am numeric(18,3),
    nuse_lmt_el_am numeric(18,3),
    aply_aset_clas_cd character varying(4),
    lnk_com_cd character(8)
) LOCATION (
    'gpfdist://sdw9:8090//data/BASEL/dat/*HU0B22TM_2*.dat'
) FORMAT 'text' (delimiter E'|' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.hu0b22tm_err SEGMENT REJECT LIMIT 25 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_gpload20130527_161137_87879 OWNER TO gpadmin;

SET search_path = sdmin_err, pg_catalog;

--
-- Name: hum701tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum701tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum701tm_err OWNER TO letl;

SET search_path = sdmin, pg_catalog;

--
-- Name: ext_gpload20130527_161639_88648; Type: EXTERNAL TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_gpload20130527_161639_88648 (
    wfg_cd character(2),
    bas_dt character(10),
    ctp_id character(20),
    psbz_dscd character(2),
    in_rk_ctp_tpcd character(3),
    std_ctp_tpcd character(3),
    psbz_no character(13),
    psco_rgno character(13),
    bic_cd character(11),
    trn_cpt_nm character varying(200),
    cosiz_cd character(2),
    co_kdcd character(2),
    tot_aset_am numeric(18,3),
    tot_sal_am numeric(18,3),
    nat_cd character(2),
    std_inds_cfcd character(5),
    aff_cd character(6),
    hoff_loc_zip_cd character(6),
    dom_rsdpe_yn character(1),
    onac_ofset_ctr_yn character(1),
    dvprd_ofset_ctr_yn character(1),
    core_mkt_entpe_yn character(1),
    fst_ln_rq_dt character(10),
    spc_dscd character(1),
    spc_law_bld_dt character(10),
    nbis_dat_src_dscd character(2),
    del_yn character(1),
    db_chg_ts timestamp(6) without time zone,
    corpno_yn character(1)
) LOCATION (
    'gpfdist://sdw9:8086//data/BASEL/dat/*HUM701TM_2*.dat'
) FORMAT 'text' (delimiter E'|' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.hum701tm_err SEGMENT REJECT LIMIT 25 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_gpload20130527_161639_88648 OWNER TO gpadmin;

SET search_path = sdmin_err, pg_catalog;

--
-- Name: hum421tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum421tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum421tf_err OWNER TO letl;

SET search_path = sdmin, pg_catalog;

--
-- Name: ext_gpload20130527_161639_88650; Type: EXTERNAL TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_gpload20130527_161639_88650 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    rwa_cal_id character(42),
    xps_tpcd character(2),
    xps_id character(30),
    lmt_agr_id character(30),
    apvrq_no character(11),
    rq_srno character(3),
    ln_rq_dscd character(2),
    ln_op_dscd character(2),
    ln_rq_kdcd character(2),
    acc_dscd character(2),
    acc_cd character(11),
    bl_dscd character(1),
    trtuni_cd character(2),
    ocpy_rst_psv_yn character(1),
    prd_cd character(9),
    rel_acno character(30),
    act_mngbr_cd character(5),
    xps_pre_af_rk_cd character(2),
    stm_prd_tgt_yn character(1),
    ctp_id character(20),
    sme_ctp_id character(20),
    psco_rgno character(13),
    isupe_psco_rgno character(13),
    b2bmctr_copnt_cd character(3),
    b2b_mctr_co_corpno character(13),
    b2b_mctr_co_bzno character(13),
    std_ctp_tpcd character(3),
    in_rk_ctp_tpcd character(3),
    std_aset_clas_cd character(5),
    in_rk_aset_clas_cd character(5),
    nat_cd character(2),
    cur_cd character(3),
    krw_xc_bl numeric(18,3),
    krw_xc_not_wdr_bl numeric(18,3),
    krw_xc_lmt_am numeric(18,3),
    krwx_ncol_agi_am numeric(18,3),
    krwx_rvs_pri_am numeric(18,3),
    ncol_irt numeric(12,8),
    aply_irt numeric(7,3),
    gen_alw_am numeric(18,3),
    spc_alw_am numeric(18,3),
    std_ccf_cd character(2),
    std_ccf_rt numeric(12,8),
    std_ead_am numeric(18,3),
    firb_ccf_cd character(2),
    firb_ccf_rt numeric(12,8),
    firb_ead_am numeric(18,3),
    lmt_ln_tp_gcfcd character(1),
    lmt_ln_tp_scfcd character(3),
    lmt_add_use_rt numeric(12,8),
    lmt_vns_rt numeric(12,8),
    lmtug_rt numeric(12,8),
    onac_cnv_rt numeric(12,8),
    airb_ead_am numeric(18,3),
    dfr_sdt character(10),
    dfr_dcn numeric(11,0),
    avg_dfr_dcn numeric(4,0),
    nbis_bas_dsh_yn character(1),
    dsh_rsn_cd character(3),
    dsh_pas_dcn numeric(5,0),
    opt_estm_fcls_rt numeric(12,8),
    pot_lgd_rt numeric(10,4),
    ltm_dsh_wag_lgd_rt numeric(10,4),
    gg_stn_lgd_rt numeric(10,4),
    co_rtsel_dscd character(1),
    rtsel_pol_id character(20),
    crd_evl_mdl_dscd character(2),
    ext_crdrk_cd character(2),
    nbis_ptf_dscd character(2),
    frg_scrt_itm_cd character(12),
    oist_evl_ist_cd character(2),
    oist_crdrk_txt character(10),
    frg_bnd_nat_cd character(2),
    scrt_itm_cd character(12),
    act_sdt character(10),
    act_xpdt character(10),
    bdtb_act_xpdt character(10),
    bfxtn_act_xpdt character(10),
    xps_agr_xpr_ycn numeric(10,4),
    xps_srviv_xpr_ycn numeric(10,4),
    em_ycn numeric(25,10),
    co_psn_dscd character(1),
    ccd_svc_dscd character(1),
    csel_am numeric(18,3),
    csv_am numeric(18,3),
    at_canav_agr_yn character(1),
    rq_mgg_dscd character(1),
    sal_bnd_yn character(1),
    ln_prd_aloc_rk numeric(10,0),
    irb_fit_nfnc_mgr numeric(12,8),
    listed_yn character(1),
    fp_dvam_pay_yn character(1),
    krw_xc_cn_posi_am numeric(18,3),
    cn_posi_svx_ycn numeric(10,4),
    krw_xc_sel_posi_am numeric(18,3),
    sel_posi_svx_ycn numeric(10,4),
    stc_std_apl_yn character(1),
    in_mdl_pot_los_am numeric(18,3),
    bdopev_otmkdv_yn character(1),
    dvprd_net_trc_am numeric(18,3),
    dvprd_tot_trc_am numeric(18,3),
    ngr_rt numeric(12,8),
    ofset_bf_aoft_am numeric(18,3),
    ofset_af_aoft_am numeric(18,3),
    ofset_af_evpl_sam numeric(18,3),
    invpd_bast_tpcd character(2),
    ininvs_bast_rw_rt numeric(12,8),
    crd_dvprd_tpcd character(2),
    cds_tpcd character(2),
    crdp_bas_aset_tpcd character(2),
    crdp_bast_rw_rt numeric(12,8),
    mst_ofset_yn character(1),
    bdopev_mgn_adj_yn character(1),
    fit_lnd_scrt_yn character(1),
    hrsk_cre_rec_yn character(1),
    spfn_prf_wgt_apyn character(1),
    acl_id character(20),
    xps_stcd character(1),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone,
    bic_cd character(11),
    lc_opnbk_bic_cd character(11),
    col_yn character(1),
    dfct_yn character(1),
    aptr_wgt_rt numeric(12,8),
    bdsys_dscd character(2),
    acc_bas_biz_hq_cd character(3),
    cus_bas_biz_hq_cd character(3),
    prd_col_rt_tgt_yn character(1),
    lc_buy_dscd character(2),
    rq_mgg_aloc_rk numeric(9,0),
    prm_rt numeric(12,8),
    rc_cus_dscd character(1),
    cd_pol_prd_dscd character(1),
    dshtm_bl numeric(18,3),
    gen_bdr_am numeric(18,3),
    spc_bdr_am numeric(18,3),
    lnk_com_cd character(8)
) LOCATION (
    'gpfdist://sdw9:8095//data/BASEL/dat/*HUM421TF_2*.dat'
) FORMAT 'text' (delimiter E'|' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.hum421tf_err SEGMENT REJECT LIMIT 25 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_gpload20130527_161639_88650 OWNER TO gpadmin;

--
-- Name: ext_gpload20130527_161639_88652; Type: EXTERNAL TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_gpload20130527_161639_88652 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    scnr_id character(5),
    rwa_cal_id character(42),
    std_aset_clas_cd character(5),
    in_rk_aset_clas_cd character(5),
    std_ead_am numeric(18,3),
    firb_ead_am numeric(18,3),
    airb_ead_am numeric(18,3),
    std_ccf_cd character(2),
    firb_ccf_cd character(2),
    lmt_ln_tp_gcfcd character(1),
    lmt_ln_tp_scfcd character(3),
    db_chg_ts timestamp(6) without time zone
) LOCATION (
    'gpfdist://sdw9:8087//data/BASEL/dat/*HUM4B2TM_2*.dat'
) FORMAT 'text' (delimiter E'|' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.hum4b2tm_err SEGMENT REJECT LIMIT 25 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_gpload20130527_161639_88652 OWNER TO gpadmin;

SET search_path = sdmin_err, pg_catalog;

--
-- Name: hum40btm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum40btm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum40btm_err OWNER TO letl;

SET search_path = sdmin, pg_catalog;

--
-- Name: ext_gpload20130527_161639_88654; Type: EXTERNAL TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_gpload20130527_161639_88654 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    scnr_id character(5),
    sme_ctp_id character(20),
    tot_xps_am numeric(18,3),
    std_ctp_tpcd character(3),
    std_bas_rre_sam numeric(18,3),
    std_bas_xps_sam numeric(18,3),
    std_trxps_bdsp_rt numeric(12,8),
    in_rk_ctp_tpcd character(3),
    in_rk_bas_rre_sam numeric(18,3),
    in_rk_bas_xps_sam numeric(18,3),
    psbz_no character(13),
    psco_rgno character(13),
    db_chg_ts timestamp(6) without time zone,
    std_ctn_lmtov_cn numeric(5,0),
    in_rk_ctn_lmtov_cn numeric(5,0)
) LOCATION (
    'gpfdist://sdw9:8091//data/BASEL/dat/*HUM40BTM_2*.dat'
) FORMAT 'text' (delimiter E'|' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.hum40btm_err SEGMENT REJECT LIMIT 25 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_gpload20130527_161639_88654 OWNER TO gpadmin;

SET search_path = sdmin_err, pg_catalog;

--
-- Name: hum209tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum209tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum209tf_err OWNER TO letl;

SET search_path = sdmin, pg_catalog;

--
-- Name: ext_gpload20130527_161639_88656; Type: EXTERNAL TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_gpload20130527_161639_88656 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    crd_mtg_id character(30),
    nbis_crd_mtg_dscd character(2),
    mgg_dscd character(2),
    mgg_kdcd character(3),
    mgg_usg_ref_cd character(2),
    mgg_id character(20),
    his_no character(5),
    est_srno character(3),
    mgg_srno character(10),
    isupe_std_ctp_tpcd character(3),
    crm_isp_psbz_no character(13),
    crm_ipsco_rgno character(13),
    nat_cd character(2),
    bic_cd character(11),
    mgg_aloc_dscd character(1),
    mgg_aloc_dis_rk numeric(10,0),
    mgg_kd_rk numeric(10,0),
    std_sapc_fit_yn character(1),
    std_cah_fit_yn character(1),
    firb_fit_yn character(1),
    airb_fit_yn character(1),
    fit_scrt_yn character(1),
    fit_grn_yn character(1),
    crd_mtg_acq_dt character(10),
    crd_mtg_xpdt character(10),
    biz_dt_bas_xpdt character(10),
    apr_dt character(10),
    insp_dt character(10),
    cur_val_evl_dt character(10),
    crm_agr_xpr_ycn numeric(10,4),
    crm_svx_ycn numeric(10,4),
    lst_insp_pr_evl_dt character(10),
    scrt_itm_cd character(12),
    frg_scrt_itm_cd character(12),
    scrt_rk_dscd character(1),
    bas_aset_rk_txt character(10),
    ref_aset_rk_txt character(10),
    ref_aset_ctp_id character(20),
    krw_xc_nm_item_am numeric(18,3),
    mlt_bas_aset_yn character(1),
    liv_cm_use_dscd character(1),
    oprevl_mgn_adj_dcn numeric(4,0),
    msidx_incl_yn character(1),
    xch_listed_yn character(1),
    nbis_ptf_dscd character(2),
    ext_crdrk_cd character(2),
    rsk_wgt_rt numeric(12,8),
    crd_mtg_crcd character(3),
    krw_xc_apr_am numeric(18,3),
    krw_xc_insp_am numeric(18,3),
    krw_xc_pre_rk_am numeric(18,3),
    etw_prkes_am numeric(18,3),
    krw_xc_prkes_am numeric(18,3),
    krw_xc_rnt_am numeric(18,3),
    krw_xc_etc_ddu_am numeric(18,3),
    etw_est_am numeric(18,3),
    krw_xc_est_am numeric(18,3),
    krw_xc_avl_pr numeric(18,3),
    krw_xc_cur_val_am numeric(18,3),
    krwx_svl_evl_am numeric(18,3),
    etw_am numeric(18,3),
    krwx_vld_mgg_suval numeric(18,3),
    etw_vld_mgg_pr_am numeric(18,3),
    insp_rt numeric(12,8),
    sbid_rt numeric(12,8),
    cmpl_ltv_rt numeric(12,8),
    grn_rt numeric(12,8),
    src_mgg_no character(16),
    slf_estm_ddu_rt_id character(20),
    if_ts_sys_cd character(1),
    pd_lgd_aply_dscd character(1),
    db_chg_ts timestamp(6) without time zone,
    rgn_tpcd character(1),
    ecezo_ltv_rt numeric(12,8)
) LOCATION (
    'gpfdist://sdw9:8093//data/BASEL/dat/*HUM209TF_2*.dat'
) FORMAT 'text' (delimiter E'|' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.hum209tf_err SEGMENT REJECT LIMIT 25 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_gpload20130527_161639_88656 OWNER TO gpadmin;

--
-- Name: ext_gpload20130527_161639_88660; Type: EXTERNAL TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_gpload20130527_161639_88660 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    aloc_scnr_id character(5),
    crd_mtg_id character(30),
    rwa_cal_id character(42),
    ctp_id character(20),
    crd_mtg_aloc_rk numeric(8,0),
    xps_aloc_rk numeric(8,0),
    crm_xps_aloc_rk numeric(8,0),
    liv_cm_use_dscd character(1),
    tsa_a_stsp_fit_yn character(1),
    tsa_a_stch_fit_yn character(1),
    tsa_a_firb_fit_yn character(1),
    tsa_a_airb_fit_yn character(1),
    xpr_dcrd_yn character(1),
    call_dcrd_yn character(1),
    rsk_wgt_rt numeric(12,8),
    crd_mtg_aloc_am numeric(18,3),
    mgg_aloc_am numeric(18,3),
    crd_mtg_bas_am numeric(18,3),
    xps_bas_am numeric(18,3),
    aloc_bf_crd_mtg_am numeric(18,3),
    aloc_bf_xps_am numeric(18,3),
    aloc_af_crd_mtg_am numeric(18,3),
    aloc_af_xps_am numeric(18,3),
    db_chg_ts timestamp(6) without time zone,
    aply_ead_am numeric(18,3),
    crd_mtg_add_aloc_am numeric(18,3)
) LOCATION (
    'gpfdist://sdw9:8089//data/BASEL/dat/*HUM215TM_2*.dat'
) FORMAT 'text' (delimiter E'|' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.hum215tm_err SEGMENT REJECT LIMIT 25 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_gpload20130527_161639_88660 OWNER TO gpadmin;

--
-- Name: ext_gpload20130527_161639_88661; Type: EXTERNAL TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_gpload20130527_161639_88661 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    scnr_id character(5),
    rwa_cal_id character(42),
    xps_id character(30),
    xps_tpcd character(2),
    acc_dscd character(2),
    acc_cd character(11),
    act_mngbr_cd character(5),
    ctp_id character(20),
    tot_sal_am numeric(18,3),
    std_aset_clas_cd character(5),
    in_rk_aset_clas_cd character(5),
    xps_pre_af_rk_cd character(2),
    nbis_bas_dsh_yn character(1),
    xps_sdt character(10),
    xps_xpdt character(10),
    xps_srviv_xpr_ycn numeric(10,4),
    em_ycn numeric(10,4),
    stm_prd_tgt_yn character(1),
    cur_cd character(3),
    krw_xc_lmt_am numeric(18,3),
    krw_xc_not_wdr_bl numeric(18,3),
    krw_xc_bl numeric(18,3),
    gen_alw_am numeric(18,3),
    spc_alw_am numeric(18,3),
    ead_am numeric(18,3),
    adj_ead_am numeric(18,3),
    lgd_rt numeric(12,8),
    fcst_los_rt numeric(12,8),
    fcst_los_am numeric(18,3),
    wgt_avg_rsk_wgt_rt numeric(12,8),
    std_hld_rsk_wgt_rt numeric(12,8),
    xps_rsk_wgt_rt numeric(12,8),
    fcls_opt_estm_rt numeric(12,8),
    crd_evl_mdl_dscd character(2),
    ext_crdrk_cd character(2),
    rtsel_pol_id character(20),
    wgt_avg_dsh_rt numeric(12,8),
    xps_dsh_rt numeric(12,8),
    oist_evl_ist_cd character(2),
    oist_crdrk_txt character(10),
    onac_ofset_am numeric(18,3),
    mcr_am numeric(18,3),
    mgg_pt_rwa_am numeric(18,3),
    nmgg_pt_rwa_am numeric(18,3),
    rwast_am numeric(18,3),
    adj_af_xps_am numeric(18,3),
    fnc_mgg_aloc_am numeric(18,3),
    nfnc_mgg_aloc_am numeric(18,3),
    crd_dvprd_aloc_am numeric(18,3),
    grn_aloc_am numeric(18,3),
    rre_vld_mgg_am numeric(18,3),
    cre_vld_mgg_am numeric(18,3),
    crd_mtg_xps_am numeric(18,3),
    acl_id character(20),
    coco_nv numeric(12,8),
    std_inds_cfcd character(5),
    cosiz_cd character(2),
    nbis_ptf_dscd character(2),
    bdsys_dscd character(2),
    acc_bas_biz_hq_cd character(3),
    cus_bas_biz_hq_cd character(3),
    db_chg_ts timestamp(6) without time zone,
    fc_aset_yn character(1),
    nbis_cal_aply_dscd character(1),
    co_rtsel_dscd character(1),
    psco_rgno character(13),
    psbz_no character(13),
    prd_cd character(9),
    gen_bdr_am numeric(18,3),
    spc_bdr_am numeric(18,3),
    bl_ead_am numeric(18,3),
    nuse_lmt_ead_am numeric(18,3),
    bl_el_am numeric(18,3),
    nuse_lmt_el_am numeric(18,3),
    aply_aset_clas_cd character varying(4),
    lnk_com_cd character(8)
) LOCATION (
    'gpfdist://sdw9:8094//data/BASEL/dat/*HU0B22TM_2*.dat'
) FORMAT 'text' (delimiter E'|' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.hu0b22tm_err SEGMENT REJECT LIMIT 25 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_gpload20130527_161639_88661 OWNER TO gpadmin;

--
-- Name: ext_hu0b22tm; Type: EXTERNAL TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_hu0b22tm (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    scnr_id character(5),
    rwa_cal_id character(42),
    xps_id character(30),
    xps_tpcd character(2),
    acc_dscd character(2),
    acc_cd character(11),
    act_mngbr_cd character(5),
    ctp_id character(20),
    tot_sal_am numeric(18,3),
    std_aset_clas_cd character(5),
    in_rk_aset_clas_cd character(5),
    xps_pre_af_rk_cd character(2),
    nbis_bas_dsh_yn character(1),
    xps_sdt character(10),
    xps_xpdt character(10),
    xps_srviv_xpr_ycn numeric(10,4),
    em_ycn numeric(10,4),
    stm_prd_tgt_yn character(1),
    cur_cd character(3),
    krw_xc_lmt_am numeric(18,3),
    krw_xc_not_wdr_bl numeric(18,3),
    krw_xc_bl numeric(18,3),
    gen_alw_am numeric(18,3),
    spc_alw_am numeric(18,3),
    ead_am numeric(18,3),
    adj_ead_am numeric(18,3),
    lgd_rt numeric(12,8),
    fcst_los_rt numeric(12,8),
    fcst_los_am numeric(18,3),
    wgt_avg_rsk_wgt_rt numeric(12,8),
    std_hld_rsk_wgt_rt numeric(12,8),
    xps_rsk_wgt_rt numeric(12,8),
    fcls_opt_estm_rt numeric(12,8),
    crd_evl_mdl_dscd character(2),
    ext_crdrk_cd character(2),
    rtsel_pol_id character(20),
    wgt_avg_dsh_rt numeric(12,8),
    xps_dsh_rt numeric(12,8),
    oist_evl_ist_cd character(2),
    oist_crdrk_txt character(10),
    onac_ofset_am numeric(18,3),
    mcr_am numeric(18,3),
    mgg_pt_rwa_am numeric(18,3),
    nmgg_pt_rwa_am numeric(18,3),
    rwast_am numeric(18,3),
    adj_af_xps_am numeric(18,3),
    fnc_mgg_aloc_am numeric(18,3),
    nfnc_mgg_aloc_am numeric(18,3),
    crd_dvprd_aloc_am numeric(18,3),
    grn_aloc_am numeric(18,3),
    rre_vld_mgg_am numeric(18,3),
    cre_vld_mgg_am numeric(18,3),
    crd_mtg_xps_am numeric(18,3),
    acl_id character(20),
    coco_nv numeric(12,8),
    std_inds_cfcd character(5),
    cosiz_cd character(2),
    nbis_ptf_dscd character(2),
    bdsys_dscd character(2),
    acc_bas_biz_hq_cd character(3),
    cus_bas_biz_hq_cd character(3),
    db_chg_ts timestamp without time zone,
    fc_aset_yn character(1),
    nbis_cal_aply_dscd character(1),
    co_rtsel_dscd character(1),
    psco_rgno character(13),
    psbz_no character(13),
    prd_cd character(9),
    gen_bdr_am numeric(18,3),
    spc_bdr_am numeric(18,3),
    bl_ead_am numeric(18,3),
    nuse_lmt_ead_am numeric(18,3),
    bl_el_am numeric(18,3),
    nuse_lmt_el_am numeric(18,3),
    aply_aset_clas_cd character varying(4),
    lnk_com_cd character(8)
) LOCATION (
    'gpfdist://172.28.4.233:8081/data.dat'
) FORMAT 'text' (delimiter E'|' null E'\\N' escape E'\\')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE sdmin.ext_hu0b22tm OWNER TO gpadmin;

SET search_path = sdmin_err, pg_catalog;

--
-- Name: ln805th_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ln805th_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ln805th_err OWNER TO letl;

SET search_path = sdmin, pg_catalog;

--
-- Name: ext_ln805th; Type: EXTERNAL TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE EXTERNAL TABLE ext_ln805th (
    bas_dt character(8),
    act_no character varying(20),
    actbr_cd character(3),
    acc_dscd character(2),
    acc_cd character(6),
    cur_cd character(2),
    psbz_no character(13),
    int_col_cn character(1),
    actv_yn character(1),
    ctr_can_yn character(1),
    can_yn character(1),
    nml_flpay_yn character(1),
    reln_flpay_yn character(1),
    mdf_flpay_yn character(1),
    pxpay_flpay_yn character(1),
    tjur_flpay_yn character(1),
    ofset_flpay_yn character(1),
    dprc_sbnd_ent_flpay_yn character(1),
    tbil_dc_flpay_yn character(1),
    itg_flpay_yn character(1),
    dcbil_at_aloc_yn character(1),
    kamc_disp_yn character(1),
    ntrth_ln_unt_trt_yn character(1),
    abs_isu_tgtac_yn character(1),
    pt_rpy_pln_dfncy_yn character(1),
    old_exe_his_dfncy_yn character(1),
    eqv_prn_nrpy_dfncy_yn character(1),
    ldg_irt_ifofr_yn character(1),
    ical_yn character(1),
    a_cs_tgtac_mk_xcp_yn character(1),
    irt_flt_brw_tgt_yn character(1),
    c2_pri_sup_fnd_rpt_yn character(1),
    bok_trmny_fr_ln_yn character(1),
    xtn_rec_xst_yn character(1),
    rewrt_rec_xst_yn character(1),
    irt_grnfe_chg_yn character(1),
    itg_mitg_xst_yn character(1),
    dfr_rt_chg_yn character(1),
    irt_unchg_brw_tgt_yn character(1),
    adcol_int_xst_yn character(1),
    rfnd_int_xst_yn character(1),
    kcgf_sbgt_rpy_act_yn character(1),
    dvam_rcp_act_yn character(1),
    ical_imp_act_yn character(1),
    dcbil_dsh_yn character(1),
    dcbil_nstl_yn character(1),
    prv_sgov_ncol_rvs_yn character(1),
    brw_lnrpy_avl_act_yn character(1),
    ofemp_act_yn character(1),
    cpsdp_pfirt_col_yn character(1),
    tjrj_rel_act_yn character(1),
    dsoff_act_yn character(1),
    rpy_ferdu_act_yn character(1),
    imxp_lnk_exe_act_yn character(1),
    tfnc_by_xtn_act_yn character(1),
    saf_ctrct_prv_sgov_yn character(1),
    inflw_prd_auct_acp_fnd_act_yn character(1),
    sm_urg_spc_fnd_act_yn character(1),
    fst_kcgf_sbgt_rpy_yn character(1),
    apv_no character(12),
    lst_trn_srno numeric(3,0),
    lnk_acno character varying(20),
    leas_com_rdmpe_siz_cd character(1),
    inet_ln_exe_yn character(1),
    crd_insu_act_yn character(1),
    cls_not_rvs_act_yn character(1),
    pur_fnc_by_tmxtn_yn character(1),
    tmpft_los_hld_ntc_yn character(1),
    tmpft_los_grnpe_ntc_yn character(1),
    col_delg_rgs_yn character(1),
    lnk_trno character(3),
    grp_no character(2),
    old_exe_apv_no character(12),
    old_exe_acno character varying(20),
    bil_no character(12),
    lndl_fecol_am numeric(18,0),
    alcrg_am numeric(18,0),
    bzctg_adirt numeric(7,4),
    bil_insu_stc_am numeric(18,0),
    rel_lc_no character(15),
    fnd_brw_agn_fee_am numeric(18,3),
    tbil_irt_aply_bsdt character(8),
    brw_no character(6),
    brw_am numeric(18,3),
    exe_am numeric(18,3),
    exe_cur_bl numeric(18,3),
    prnrp_acam numeric(18,0),
    apv_xc_rt numeric(15,8),
    pgrn_apv_rt numeric(15,8),
    xch_rt numeric(7,2),
    ncol_int_am numeric(18,3),
    exe_dt character(8),
    op_dt character(8),
    rt_aply_bsdt character(8),
    lst_trn_invs_dt character(8),
    fst_agr_fxdt character(8),
    vld_agr_fxdt character(8),
    sq_tms_rpy_dt character(8),
    evrtm_intpi_ym character(6),
    intpi_itv_mcn numeric(2,0),
    evrtm_intpi_dy character(2),
    lst_ircv_dt character(8),
    int_ppay_dcn numeric(3,0),
    dfr_irt_aply_dt character(8),
    bil_fxdt character(8),
    lst_dfr_ircv_dt character(8),
    lst_intdf_ircv_dt character(8),
    cshtf_dscd character(1),
    acc_mdf_mtd_cd character(1),
    fndus_cd character(2),
    new_uni_op_dscd character(3),
    old_uni_op_dscd character(3),
    prnrp_mtd_cd character(2),
    intpi_mtd_cd character(2),
    irt_cd character(3),
    irt_grnfe_fee_rt numeric(7,4),
    dc_ovr_irt numeric(7,4),
    lnam_trbok_isu_yn character(1),
    pbok_licn numeric(2,0),
    npbok_trn_rec_cn numeric(3,0),
    fnd_cd character(2),
    wpgrn_isu_yn character(1),
    grn_cptco_cd character(4),
    grn_cptco_nm character(20),
    leas_com_rdmpe_usg_cd character(2),
    itg_dscd character(1),
    rept_cn numeric(3,0),
    xps_id character(12),
    rel_acno character varying(20),
    cus_dscd character(2),
    lst_load_dt character(8),
    hrpy_ferdu_no character(2),
    hedg_tgt_yn character(1),
    fnc_prd_ctgr_cd character(2),
    prgwk_val_cd character(2),
    onld_crd_div_rt numeric(7,4),
    act_itg_lst_srno character(3),
    pvbnd_dc_am numeric(15,0),
    ncol_ocr_am numeric(23,3),
    ncol_impo_am numeric(23,3),
    fnc_grn_yn character(1),
    dfirt_nml_irt_dt character(8),
    dfr_sdt character(8)
) LOCATION (
    'gpfdist://sdw9:8093//data2/DAT/ln805th_chg.dat'
) FORMAT 'text' (delimiter E';' null E'' escape E'\\')
ENCODING 'UHC'
LOG ERRORS INTO sdmin_err.ln805th_err SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sdmin.ext_ln805th OWNER TO letl;

--
-- Name: foex_de_dept; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE foex_de_dept (
    fdeacno character(12) NOT NULL,
    fdetonghwa character(3) NOT NULL,
    fdecustno character(13) NOT NULL,
    fdegubuncd character(1),
    fdegamokcd character(6),
    fdegejusn character(1),
    fdesttrdt character(8),
    fdemangidt character(8),
    fdegeyakil numeric(3,0) DEFAULT 0,
    fdegeyakwl numeric(3,0) DEFAULT 0,
    fdehejidt character(8),
    fdecancdt character(8),
    fdemoacno character(12),
    fdesayu character(1),
    fdegukje character(3),
    fderate numeric(6,4),
    fdebalamt numeric(15,3),
    fdewonamt numeric(15,0),
    fdelstdate character(8),
    fdelsttime character(6),
    fdejikno character(6),
    fdejagumcd character(1),
    fdehjsayucd character(1),
    fdest1 character varying(1),
    fdest2 character varying(1),
    fdest3 character varying(1),
    fdest5 character varying(1),
    fdest6 character varying(1),
    fdest7 character varying(1),
    fdest8 character varying(1),
    fdest9 character varying(1),
    fdest10 character varying(1),
    fdest24 character varying(1),
    fdejokun1 character varying(1),
    fdejokun2 character varying(1),
    fdejokun3 character varying(1),
    fdejokun5 character varying(1),
    fdejokun6 character varying(1),
    fdejokun7 character varying(1),
    fdeilza1 character varying(8),
    fdejumbun1 character varying(3),
    fdeilza2 character varying(8),
    fdejumbun2 character varying(3),
    fdeilza3 character varying(8),
    fdejumbun3 character varying(3),
    fdeilza5 character varying(8),
    fdejumbun5 character varying(3),
    fdegeumak5 numeric(15,3) DEFAULT 0,
    fdeilza6 character varying(8),
    fdegeumak6 numeric(15,3) DEFAULT 0,
    fdeilza7 character varying(8),
    fdejumbun7 character varying(3),
    fdegeumak7 numeric(15,3) DEFAULT 0,
    fdejjstil character varying(8),
    fdejjedil character varying(8),
    fdejbikdat character varying(8),
    fdejbiknos numeric(5,0),
    fdejbikhgb character varying(1),
    fdejbikamt numeric(15,3)
) DISTRIBUTED BY (fdeacno);


ALTER TABLE sdmin.foex_de_dept OWNER TO letl;

--
-- Name: gita_rpcd_tbl; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE gita_rpcd_tbl (
    grc_rpkind character(3) NOT NULL,
    grc_group character varying(12) NOT NULL,
    grc_makegb character varying(1) NOT NULL,
    grc_rpkindcd character varying(3),
    grc_valuecd character varying(12),
    grc_sign character varying(1),
    grc_gpsort numeric(4,0) DEFAULT 0,
    grc_groupnm character varying(100),
    grc_rpkindnm character varying(1000),
    grc_sqlexp character varying(4000),
    grc_mmdate character varying(1),
    grc_trdate character varying(8),
    grc_update character varying(8),
    grc_deldate character varying(8) DEFAULT '99991231'::character varying,
    grc_gdcd character varying(2) DEFAULT '00'::character varying
) DISTRIBUTED BY (grc_rpkind ,grc_group);


ALTER TABLE sdmin.gita_rpcd_tbl OWNER TO letl;

--
-- Name: gita_rpdata_tbl; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE gita_rpdata_tbl (
    grd_basedt character varying(8) NOT NULL,
    grd_rpkind character varying(3) NOT NULL,
    grd_group character varying(12) NOT NULL,
    grd_value1 numeric(16,2) DEFAULT 0,
    grd_value2 numeric(16,2) DEFAULT 0,
    grd_value3 numeric(16,2) DEFAULT 0,
    grd_value4 numeric(15,2) DEFAULT 0,
    grd_value5 numeric(15,2) DEFAULT 0,
    grd_value6 numeric(15,2) DEFAULT 0,
    grd_value7 numeric(15,2) DEFAULT 0,
    grd_value8 numeric(15,2) DEFAULT 0,
    grd_value9 numeric(15,2) DEFAULT 0,
    grd_value10 numeric(15,2) DEFAULT 0,
    grd_value11 numeric(15,2) DEFAULT 0,
    grd_value12 numeric(15,2) DEFAULT 0,
    grd_jobdt date
) DISTRIBUTED BY (grd_rpkind ,grd_group);


ALTER TABLE sdmin.gita_rpdata_tbl OWNER TO letl;

--
-- Name: goods_view; Type: VIEW; Schema: sdmin; Owner: letl
--

CREATE VIEW goods_view AS
    SELECT rtl.gdord, rtl.gdknd, rtl.gdname FROM (((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((SELECT '01a' AS gdord, 90 AS gdknd, 'KNB재형저축' AS gdname UNION ALL SELECT '01a' AS gdord, 97 AS gdknd, '월복리솔솔적금' AS gdname) UNION ALL SELECT '01a' AS gdord, 96 AS gdknd, '자유적금(아이드림제외)' AS gdname) UNION ALL SELECT '01a' AS gdord, 95 AS gdknd, '경남(울산)사랑통장' AS gdname) UNION ALL SELECT '01b' AS gdord, 66 AS gdknd, '평생비과세저축' AS gdname) UNION ALL SELECT '02a' AS gdord, 54 AS gdknd, '장기회전정기예금' AS gdname) UNION ALL SELECT '03a' AS gdord, 53 AS gdknd, '지수연동정기예금' AS gdname) UNION ALL SELECT '03b' AS gdord, 201 AS gdknd, '경남(울산)사랑적금' AS gdname) UNION ALL SELECT '03b' AS gdord, 65 AS gdknd, 'KNB가맹점우대통장' AS gdname) UNION ALL SELECT '03b' AS gdord, 67 AS gdknd, 'KNB공직자우대통장' AS gdname) UNION ALL SELECT '03b' AS gdord, 68 AS gdknd, 'KNB회전정기예금' AS gdname) UNION ALL SELECT '03b' AS gdord, 69 AS gdknd, 'KNB1020통장' AS gdname) UNION ALL SELECT '03b' AS gdord, 70 AS gdknd, 'HI- Korea통장' AS gdname) UNION ALL SELECT '03b' AS gdord, 74 AS gdknd, '국민연금안심통장' AS gdname) UNION ALL SELECT '03f' AS gdord, 202 AS gdknd, 'KNB스마트정기예금' AS gdname) UNION ALL SELECT '03f' AS gdord, 203 AS gdknd, 'KNB스마트자유적금' AS gdname) UNION ALL SELECT '03f' AS gdord, 204 AS gdknd, '희망모아적금(정액)' AS gdname) UNION ALL SELECT '03f' AS gdord, 205 AS gdknd, '희망모아적금(자유)' AS gdname) UNION ALL SELECT '03f' AS gdord, 206 AS gdknd, '지수연동정기예금(펀드:088)' AS gdname) UNION ALL SELECT '03f' AS gdord, 207 AS gdknd, '지수연동정기예금(펀드:089)' AS gdname) UNION ALL SELECT '03f' AS gdord, 208 AS gdknd, '지수연동정기예금(펀드:090)' AS gdname) UNION ALL SELECT '03f' AS gdord, 209 AS gdknd, '지수연동정기예금(펀드:088-090)' AS gdname) UNION ALL SELECT '03f' AS gdord, 210 AS gdknd, '지수연동정기예금(펀드:091)' AS gdname) UNION ALL SELECT '03f' AS gdord, 211 AS gdknd, '지수연동정기예금(펀드:092)' AS gdname) UNION ALL SELECT '03f' AS gdord, 212 AS gdknd, '지수연동정기예금(펀드:093)' AS gdname) UNION ALL SELECT '03f' AS gdord, 213 AS gdknd, '지수연동정기예금(펀드:091-093)' AS gdname) UNION ALL SELECT '03f' AS gdord, 214 AS gdknd, '지수연동정기예금(펀드:094)' AS gdname) UNION ALL SELECT '03f' AS gdord, 215 AS gdknd, '지수연동정기예금(펀드:095)' AS gdname) UNION ALL SELECT '03f' AS gdord, 216 AS gdknd, '지수연동정기예금(펀드:096)' AS gdname) UNION ALL SELECT '03f' AS gdord, 217 AS gdknd, '지수연동정기예금(펀드:094-096)' AS gdname) UNION ALL SELECT '03f' AS gdord, 223 AS gdknd, '지수연동정기예금(펀드:42)' AS gdname) UNION ALL SELECT '03f' AS gdord, 225 AS gdknd, '지수연동정기예금(펀드:43)' AS gdname) UNION ALL SELECT '03f' AS gdord, 421 AS gdknd, 'Magic Project 특판(마니마니정기예금) 현황(6개월이상)' AS gdname) UNION ALL SELECT '03f' AS gdord, 422 AS gdknd, 'Magic Project 특판(마니마니정기예금) 현황(12개월이상)' AS gdname) UNION ALL SELECT '03f' AS gdord, 423 AS gdknd, 'Magic Project 특판(매직정기예금) 현황(6개월이상)' AS gdname) UNION ALL SELECT '03f' AS gdord, 424 AS gdknd, 'Magic Project 특판(매직정기예금) 현황(12개월이상)' AS gdname) UNION ALL SELECT '03f' AS gdord, 246 AS gdknd, '마니마니정기예금(특판:184)' AS gdname) UNION ALL SELECT '03f' AS gdord, 247 AS gdknd, '마니마니정기예금(특판:185)' AS gdname) UNION ALL SELECT '03f' AS gdord, 248 AS gdknd, '마니마니정기예금(특판:184+185)' AS gdname) UNION ALL SELECT '03f' AS gdord, 249 AS gdknd, '행복드림적금(특판:037)' AS gdname) UNION ALL SELECT '03f' AS gdord, 284 AS gdknd, '지수연동정기예금(펀드:64)' AS gdname) UNION ALL SELECT '03f' AS gdord, 285 AS gdknd, '지수연동정기예금(펀드:65)' AS gdname) UNION ALL SELECT '03f' AS gdord, 286 AS gdknd, '지수연동정기예금(펀드:64+65)' AS gdname) UNION ALL SELECT '03f' AS gdord, 332 AS gdknd, '지수연동정기예금(펀드:67)' AS gdname) UNION ALL SELECT '03f' AS gdord, 333 AS gdknd, '지수연동정기예금(펀드:68)' AS gdname) UNION ALL SELECT '03f' AS gdord, 334 AS gdknd, '지수연동정기예금(펀드:67+68)' AS gdname) UNION ALL SELECT '03f' AS gdord, 335 AS gdknd, '새봄맞이특판정기예금(162)' AS gdname) UNION ALL SELECT '03f' AS gdord, 336 AS gdknd, '새봄맞이특판적금(021)' AS gdname) UNION ALL SELECT '03f' AS gdord, 337 AS gdknd, '지수연동정기예금(펀드:69)' AS gdname) UNION ALL SELECT '03f' AS gdord, 338 AS gdknd, '지수연동정기예금(펀드:70)' AS gdname) UNION ALL SELECT '03f' AS gdord, 339 AS gdknd, '지수연동정기예금(펀드:69+70)' AS gdname) UNION ALL SELECT '03f' AS gdord, 340 AS gdknd, '지수연동정기예금(펀드:73)' AS gdname) UNION ALL SELECT '03f' AS gdord, 341 AS gdknd, '지수연동정기예금(펀드:74)' AS gdname) UNION ALL SELECT '03f' AS gdord, 342 AS gdknd, '지수연동정기예금(펀드:75)' AS gdname) UNION ALL SELECT '03f' AS gdord, 343 AS gdknd, '지수연동정기예금(펀드:73-75)' AS gdname) UNION ALL SELECT '03f' AS gdord, 344 AS gdknd, '지수연동정기예금(펀드:76)' AS gdname) UNION ALL SELECT '03f' AS gdord, 345 AS gdknd, '지수연동정기예금(펀드:77)' AS gdname) UNION ALL SELECT '03f' AS gdord, 346 AS gdknd, '지수연동정기예금(펀드:78)' AS gdname) UNION ALL SELECT '03f' AS gdord, 347 AS gdknd, '지수연동정기예금(펀드:76-78)' AS gdname) UNION ALL SELECT '03f' AS gdord, 348 AS gdknd, '지수연동정기예금(펀드:79)' AS gdname) UNION ALL SELECT '03f' AS gdord, 349 AS gdknd, '지수연동정기예금(펀드:80)' AS gdname) UNION ALL SELECT '03f' AS gdord, 350 AS gdknd, '지수연동정기예금(펀드:81)' AS gdname) UNION ALL SELECT '03f' AS gdord, 351 AS gdknd, '지수연동정기예금(펀드:79-81)' AS gdname) UNION ALL SELECT '03f' AS gdord, 356 AS gdknd, '지수연동정기예금(펀드:82)' AS gdname) UNION ALL SELECT '03f' AS gdord, 357 AS gdknd, '지수연동정기예금(펀드:83)' AS gdname) UNION ALL SELECT '03f' AS gdord, 358 AS gdknd, '지수연동정기예금(펀드:84)' AS gdname) UNION ALL SELECT '03f' AS gdord, 359 AS gdknd, '지수연동정기예금(펀드:82-84)' AS gdname) UNION ALL SELECT '03f' AS gdord, 360 AS gdknd, '통합창원시특판(167)' AS gdname) UNION ALL SELECT '03f' AS gdord, 361 AS gdknd, '통합창원시특판(168)' AS gdname) UNION ALL SELECT '03f' AS gdord, 362 AS gdknd, 'e-그린 공동구매 정기예금 3차(169)' AS gdname) UNION ALL SELECT '03f' AS gdord, 363 AS gdknd, 'e-그린 공동구매 정기예금 4차(170)' AS gdname) UNION ALL SELECT '03f' AS gdord, 364 AS gdknd, 'e-그린 공동구매 정기예금 (2011-1차)' AS gdname) UNION ALL SELECT '03f' AS gdord, 383 AS gdknd, '지수연동정기예금(펀드:97)' AS gdname) UNION ALL SELECT '03f' AS gdord, 384 AS gdknd, '지수연동정기예금(펀드:98)' AS gdname) UNION ALL SELECT '03f' AS gdord, 385 AS gdknd, '지수연동정기예금(펀드:99)' AS gdname) UNION ALL SELECT '03f' AS gdord, 386 AS gdknd, '지수연동정기예금(펀드:97-99)' AS gdname) UNION ALL SELECT '03f' AS gdord, 391 AS gdknd, '지수연동정기예금(펀드:100)' AS gdname) UNION ALL SELECT '03f' AS gdord, 392 AS gdknd, '지수연동정기예금(펀드:101)' AS gdname) UNION ALL SELECT '03f' AS gdord, 393 AS gdknd, '지수연동정기예금(펀드:102)' AS gdname) UNION ALL SELECT '03f' AS gdord, 394 AS gdknd, '지수연동정기예금(펀드:100-102)' AS gdname) UNION ALL SELECT '03f' AS gdord, 395 AS gdknd, '지수연동정기예금(펀드:103)' AS gdname) UNION ALL SELECT '03f' AS gdord, 396 AS gdknd, '지수연동정기예금(펀드:104)' AS gdname) UNION ALL SELECT '03f' AS gdord, 397 AS gdknd, '지수연동정기예금(펀드:105)' AS gdname) UNION ALL SELECT '03f' AS gdord, 398 AS gdknd, '지수연동정기예금(펀드:103-105)' AS gdname) UNION ALL SELECT '03f' AS gdord, 600 AS gdknd, '지수연동정기예금(펀드:106)' AS gdname) UNION ALL SELECT '03f' AS gdord, 601 AS gdknd, '지수연동정기예금(펀드:107)' AS gdname) UNION ALL SELECT '03f' AS gdord, 602 AS gdknd, '지수연동정기예금(펀드:108)' AS gdname) UNION ALL SELECT '03f' AS gdord, 603 AS gdknd, '지수연동정기예금(펀드:106-108)' AS gdname) UNION ALL SELECT '03f' AS gdord, 604 AS gdknd, '지수연동정기예금(펀드:109)' AS gdname) UNION ALL SELECT '03f' AS gdord, 605 AS gdknd, '지수연동정기예금(펀드:110)' AS gdname) UNION ALL SELECT '03f' AS gdord, 606 AS gdknd, '지수연동정기예금(펀드:111)' AS gdname) UNION ALL SELECT '03f' AS gdord, 607 AS gdknd, '지수연동정기예금(펀드:112)' AS gdname) UNION ALL SELECT '03f' AS gdord, 608 AS gdknd, '지수연동정기예금(펀드:109-112)' AS gdname) UNION ALL SELECT '03f' AS gdord, 609 AS gdknd, 'KNB직장인우대통장' AS gdname) UNION ALL SELECT '03f' AS gdord, 401 AS gdknd, '지수연동정기예금(펀드:113)' AS gdname) UNION ALL SELECT '03f' AS gdord, 402 AS gdknd, '지수연동정기예금(펀드:114)' AS gdname) UNION ALL SELECT '03f' AS gdord, 403 AS gdknd, '지수연동정기예금(펀드:115)' AS gdname) UNION ALL SELECT '03f' AS gdord, 404 AS gdknd, '지수연동정기예금(펀드:103-115)' AS gdname) UNION ALL SELECT '03f' AS gdord, 405 AS gdknd, '지수연동정기예금(펀드:116)' AS gdname) UNION ALL SELECT '03f' AS gdord, 406 AS gdknd, '지수연동정기예금(펀드:117)' AS gdname) UNION ALL SELECT '03f' AS gdord, 407 AS gdknd, '지수연동정기예금(펀드:118)' AS gdname) UNION ALL SELECT '03f' AS gdord, 408 AS gdknd, '지수연동정기예금(펀드:116-118)' AS gdname) UNION ALL SELECT '03f' AS gdord, 411 AS gdknd, '지수연동정기예금(펀드:119)' AS gdname) UNION ALL SELECT '03f' AS gdord, 412 AS gdknd, '지수연동정기예금(펀드:120)' AS gdname) UNION ALL SELECT '03f' AS gdord, 413 AS gdknd, '지수연동정기예금(펀드:121)' AS gdname) UNION ALL SELECT '03f' AS gdord, 414 AS gdknd, '지수연동정기예금(펀드:119-121)' AS gdname) UNION ALL SELECT '03f' AS gdord, 415 AS gdknd, '지수연동정기예금(펀드:122)' AS gdname) UNION ALL SELECT '03f' AS gdord, 416 AS gdknd, '지수연동정기예금(펀드:123)' AS gdname) UNION ALL SELECT '03f' AS gdord, 417 AS gdknd, '지수연동정기예금(펀드:124)' AS gdname) UNION ALL SELECT '03f' AS gdord, 418 AS gdknd, '지수연동정기예금(펀드:122-124)' AS gdname) UNION ALL SELECT '03f' AS gdord, 409 AS gdknd, 'KNB자동이체우대통장' AS gdname) UNION ALL SELECT '03f' AS gdord, 287 AS gdknd, '특판정기예금(101)' AS gdname) UNION ALL SELECT '03f' AS gdord, 288 AS gdknd, '창립특판정기예금(089)' AS gdname) UNION ALL SELECT '03f' AS gdord, 289 AS gdknd, '본부승인특판정기예금(090)' AS gdname) UNION ALL SELECT '03f' AS gdord, 290 AS gdknd, '다다드림정기예금' AS gdname) UNION ALL SELECT '03f' AS gdord, 291 AS gdknd, 'VIP정기예금' AS gdname) UNION ALL SELECT '03f' AS gdord, 293 AS gdknd, '아이드림자유적금' AS gdname) UNION ALL SELECT '03f' AS gdord, 294 AS gdknd, '특판정기예금(102)' AS gdname) UNION ALL SELECT '03f' AS gdord, 295 AS gdknd, '탄탄성공적금' AS gdname) UNION ALL SELECT '03f' AS gdord, 299 AS gdknd, '특판정기예금(103)' AS gdname) UNION ALL SELECT '03f' AS gdord, 296 AS gdknd, '나라국토사랑특판1년' AS gdname) UNION ALL SELECT '03f' AS gdord, 297 AS gdknd, '나라국토사랑특판2년' AS gdname) UNION ALL SELECT '03f' AS gdord, 298 AS gdknd, '나라국토사랑특판3년' AS gdname) UNION ALL SELECT '03f' AS gdord, 300 AS gdknd, '한가위정기적금1년' AS gdname) UNION ALL SELECT '03f' AS gdord, 301 AS gdknd, '한가위정기적금2년' AS gdname) UNION ALL SELECT '03f' AS gdord, 302 AS gdknd, '한가위정기적금3년' AS gdname) UNION ALL SELECT '03f' AS gdord, 303 AS gdknd, '특판정기예금(104)' AS gdname) UNION ALL SELECT '03f' AS gdord, 304 AS gdknd, '행복드림적금' AS gdname) UNION ALL SELECT '03g' AS gdord, 10 AS gdknd, '경남.울산기업사랑정기예금' AS gdname) UNION ALL SELECT '03f' AS gdord, 305 AS gdknd, '람사르 특판 정기예금(110)_9개월' AS gdname) UNION ALL SELECT '03f' AS gdord, 306 AS gdknd, '람사르 특판 정기예금(110)_12개월' AS gdname) UNION ALL SELECT '03f' AS gdord, 307 AS gdknd, '현대차 특판 정기예금(109)_12개월' AS gdname) UNION ALL SELECT '03f' AS gdord, 308 AS gdknd, '현대차 특판 정기예금(118)_12개월' AS gdname) UNION ALL SELECT '03g' AS gdord, 309 AS gdknd, '특판정기예금(122)-12개월' AS gdname) UNION ALL SELECT '03g' AS gdord, 310 AS gdknd, '특판정기예금(122)-9개월' AS gdname) UNION ALL SELECT '03g' AS gdord, 311 AS gdknd, '특판정기예금(122)-6개월' AS gdname) UNION ALL SELECT '03g' AS gdord, 312 AS gdknd, '특판정기예금(122)-3개월' AS gdname) UNION ALL SELECT '03g' AS gdord, 313 AS gdknd, '특판정기예금(124)-12개월' AS gdname) UNION ALL SELECT '03g' AS gdord, 314 AS gdknd, '특판정기예금(124)-9개월' AS gdname) UNION ALL SELECT '03g' AS gdord, 315 AS gdknd, '특판정기예금(124)-6개월' AS gdname) UNION ALL SELECT '03g' AS gdord, 316 AS gdknd, '특판정기예금(124)-3개월' AS gdname) UNION ALL SELECT '03g' AS gdord, 320 AS gdknd, '(정기)행복Dream여행적금' AS gdname) UNION ALL SELECT '03g' AS gdord, 321 AS gdknd, '(자유)행복Dream여행적금' AS gdname) UNION ALL SELECT '03g' AS gdord, 322 AS gdknd, '(전체)행복 Dream 여행적금' AS gdname) UNION ALL SELECT '03g' AS gdord, 355 AS gdknd, '휴면고객 Wake Up 예금' AS gdname) UNION ALL SELECT '03g' AS gdord, 365 AS gdknd, '특판양도성예금증서(054)' AS gdname) UNION ALL SELECT '03g' AS gdord, 366 AS gdknd, '(자유적금)인터넷전용상품' AS gdname) UNION ALL SELECT '03g' AS gdord, 367 AS gdknd, '(요구불)인터넷전용상품' AS gdname) UNION ALL SELECT '03g' AS gdord, 368 AS gdknd, '(정기예금)인터넷전용상품' AS gdname) UNION ALL SELECT '03g' AS gdord, 369 AS gdknd, '창립특판양도성(045)' AS gdname) UNION ALL SELECT '03g' AS gdord, 370 AS gdknd, '본부승인특판양도성(046)' AS gdname) UNION ALL SELECT '03g' AS gdord, 371 AS gdknd, '제2007-9차특판양도성예금증서' AS gdname) UNION ALL SELECT '03g' AS gdord, 372 AS gdknd, 'VIP양도성' AS gdname) UNION ALL SELECT '03g' AS gdord, 373 AS gdknd, '특판양도성예금증서(055)' AS gdname) UNION ALL SELECT '03g' AS gdord, 374 AS gdknd, '람사르 특판 양도성예금증서-9개월' AS gdname) UNION ALL SELECT '03g' AS gdord, 375 AS gdknd, '람사르 특판 양도성예금증서-12개월' AS gdname) UNION ALL SELECT '03h' AS gdord, 400 AS gdknd, 'VIP환매조건부채권' AS gdname) UNION ALL SELECT '03g' AS gdord, 380 AS gdknd, '마이플랜(페스티발)' AS gdname) UNION ALL SELECT '03g' AS gdord, 381 AS gdknd, '평생비과세저축(페스티발)' AS gdname) UNION ALL SELECT '03g' AS gdord, 382 AS gdknd, '특판평생비과세저축' AS gdname) UNION ALL SELECT '04a' AS gdord, 52 AS gdknd, '수익증권' AS gdname) UNION ALL SELECT '04b' AS gdord, 64 AS gdknd, '양도성예금증서 은행등록발행' AS gdname) UNION ALL SELECT '04c' AS gdord, 390 AS gdknd, '성공파트너통장' AS gdname) UNION ALL SELECT '04d' AS gdord, 15 AS gdknd, 'KNB매직정기예금(6개월)' AS gdname) UNION ALL SELECT '04d' AS gdord, 16 AS gdknd, 'KNB매직정기예금(12개월)' AS gdname) UNION ALL SELECT '04d' AS gdord, 17 AS gdknd, '해외송금전용통장' AS gdname) UNION ALL SELECT '04d' AS gdord, 352 AS gdknd, '경은파워 MMF' AS gdname) UNION ALL SELECT '04d' AS gdord, 353 AS gdknd, '비과세생계형저축' AS gdname) UNION ALL SELECT '04d' AS gdord, 354 AS gdknd, '세금우대저축' AS gdname) UNION ALL SELECT '05a' AS gdord, 60 AS gdknd, '골드통장(기본)' AS gdname) UNION ALL SELECT '06a' AS gdord, 59 AS gdknd, '골드통장(연결)' AS gdname) UNION ALL SELECT '07a' AS gdord, 58 AS gdknd, '경남은행 한마음통장(기본)' AS gdname) UNION ALL SELECT '08a' AS gdord, 57 AS gdknd, '경남은행 한마음통장(연결)' AS gdname) UNION ALL SELECT '09a' AS gdord, 55 AS gdknd, '2002 축구사랑예금' AS gdname) UNION ALL SELECT '10a' AS gdord, 56 AS gdknd, '2002 축구사랑적금' AS gdname) UNION ALL SELECT '11a' AS gdord, 13 AS gdknd, 'OK 정기예금' AS gdname) UNION ALL SELECT '12a' AS gdord, 14 AS gdknd, '비과세 우대저축' AS gdname) UNION ALL SELECT '13a' AS gdord, 48 AS gdknd, '이웃사랑예금' AS gdname) UNION ALL SELECT '14a' AS gdord, 49 AS gdknd, '이웃사랑적금' AS gdname) UNION ALL SELECT '15a' AS gdord, 89 AS gdknd, '연금 신탁' AS gdname) UNION ALL SELECT '16a' AS gdord, 900 AS gdknd, '사이버예금' AS gdname) UNION ALL SELECT '17a' AS gdord, 500 AS gdknd, '비과세 생계형저축' AS gdname) UNION ALL SELECT '18a' AS gdord, 46 AS gdknd, '종합과세 안심예금' AS gdname) UNION ALL SELECT '19a' AS gdord, 47 AS gdknd, '종합과세 안심적금' AS gdname) UNION ALL SELECT '20a' AS gdord, 88 AS gdknd, '신개인연금신탁' AS gdname) UNION ALL SELECT '21a' AS gdord, 86 AS gdknd, '훼밀리 예금' AS gdname) UNION ALL SELECT '22a' AS gdord, 87 AS gdknd, '훼밀리 적금' AS gdname) UNION ALL SELECT '23a' AS gdord, 83 AS gdknd, '주택 청약 예금' AS gdname) UNION ALL SELECT '24a' AS gdord, 84 AS gdknd, '주택 청약 부금' AS gdname) UNION ALL SELECT '25a' AS gdord, 24 AS gdknd, '비과세 가계저축' AS gdname) UNION ALL SELECT '26a' AS gdord, 25 AS gdknd, '비과세 가계신탁' AS gdname) UNION ALL SELECT '27a' AS gdord, 85 AS gdknd, '퇴직 신탁' AS gdname) UNION ALL SELECT '28a' AS gdord, 82 AS gdknd, '추가 금전신탁' AS gdname) UNION ALL SELECT '29a' AS gdord, 45 AS gdknd, '뱅크라인 정기예금' AS gdname) UNION ALL SELECT '30a' AS gdord, 81 AS gdknd, '새천년새희망 적금' AS gdname) UNION ALL SELECT '31a' AS gdord, 3 AS gdknd, '단위형 신탁' AS gdname) UNION ALL SELECT '32a' AS gdord, 33 AS gdknd, '뉴 스타트 부금' AS gdname) UNION ALL SELECT '33a' AS gdord, 44 AS gdknd, '신 자유부금' AS gdname) UNION ALL SELECT '34a' AS gdord, 22 AS gdknd, '급여이체우대통장' AS gdname) UNION ALL SELECT '34a' AS gdord, 23 AS gdknd, 'KNB행복지킴이통장' AS gdname) UNION ALL SELECT '37a' AS gdord, 71 AS gdknd, '마니마니2이자지급식' AS gdname) UNION ALL SELECT '38a' AS gdord, 72 AS gdknd, '마니마니2만기지급식' AS gdname) UNION ALL SELECT '39a' AS gdord, 61 AS gdknd, '마니마니 이자지급식' AS gdname) UNION ALL SELECT '40a' AS gdord, 62 AS gdknd, '마니마니 만기지급식' AS gdname) UNION ALL SELECT '41a' AS gdord, 73 AS gdknd, '모아모아부금' AS gdname) UNION ALL SELECT '42a' AS gdord, 63 AS gdknd, '학생저축상호부금' AS gdname) UNION ALL SELECT '45a' AS gdord, 51 AS gdknd, '신종적립신탁' AS gdname) UNION ALL SELECT '46a' AS gdord, 41 AS gdknd, '나라사랑어깨동무통장' AS gdname) UNION ALL SELECT '47a' AS gdord, 43 AS gdknd, '통일로세계로적립신탁' AS gdname) UNION ALL SELECT '48a' AS gdord, 31 AS gdknd, '근로자우대저축' AS gdname) UNION ALL SELECT '49a' AS gdord, 32 AS gdknd, '근로자우대신탁' AS gdname) UNION ALL SELECT '50a' AS gdord, 21 AS gdknd, '슈퍼베스트부금' AS gdname) UNION ALL SELECT '51a' AS gdord, 11 AS gdknd, '일일베스트통장' AS gdname) UNION ALL SELECT '52a' AS gdord, 12 AS gdknd, '기업베스트예금' AS gdname) UNION ALL SELECT '53a' AS gdord, 0 AS gdknd, 'A+ 이자지급식' AS gdname) UNION ALL SELECT '54a' AS gdord, 1 AS gdknd, 'A+ 만기지급식' AS gdname) UNION ALL SELECT '55a' AS gdord, 2 AS gdknd, '월부금면제적금' AS gdname) UNION ALL SELECT '56a' AS gdord, 810 AS gdknd, '새천년새희망적금기간별' AS gdname) UNION ALL SELECT '57a' AS gdord, 440 AS gdknd, '신자유부금기간별' AS gdname) UNION ALL SELECT '58a' AS gdord, 750 AS gdknd, '마니마니월복리기간별' AS gdname) UNION ALL SELECT '58a' AS gdord, 751 AS gdknd, '마니마니월복리식' AS gdname) UNION ALL SELECT '59a' AS gdord, 710 AS gdknd, '마니마니2기간별' AS gdname) UNION ALL SELECT '60a' AS gdord, 610 AS gdknd, '마니마니기간별' AS gdname) UNION ALL SELECT '61a' AS gdord, 650 AS gdknd, '마니마니월복리신규해지' AS gdname) UNION ALL SELECT '62a' AS gdord, 670 AS gdknd, '마니마니2신규해지' AS gdname) UNION ALL SELECT '63a' AS gdord, 630 AS gdknd, '마니마니신규해지' AS gdname) UNION ALL SELECT '64a' AS gdord, 740 AS gdknd, '모아모아부금기간별' AS gdname) UNION ALL SELECT '65a' AS gdord, 420 AS gdknd, '나라사랑어깨동무기간별' AS gdname) UNION ALL SELECT '66a' AS gdord, 410 AS gdknd, '나라사랑어깨동무시군별' AS gdname) UNION ALL SELECT '67a' AS gdord, 430 AS gdknd, '통일로세계로신탁시군별' AS gdname) UNION ALL SELECT '68a' AS gdord, 36 AS gdknd, '장기주택마련저축' AS gdname) UNION ALL SELECT '70a' AS gdord, 50 AS gdknd, '특정금전신탁' AS gdname) UNION ALL SELECT '01a' AS gdord, 98 AS gdknd, '월복리 솔솔 정기예금' AS gdname) UNION ALL SELECT '01a' AS gdord, 99 AS gdknd, '마니마니자유적금' AS gdname) rtl;


ALTER TABLE sdmin.goods_view OWNER TO letl;

--
-- Name: hu0b18tc; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b18tc (
    wfg_cd character(2) NOT NULL,
    aloc_scnr_id character(5) NOT NULL,
    aply_edt character(10) NOT NULL,
    aloc_scnr_nm character varying(100),
    crd_mtg_am_bas_cd character(1) NOT NULL,
    xps_am_bas_cd character(1),
    crm_aloc_mtd_cd character(1),
    aloc_am_dcs_cd character(1),
    cmpl_ltv_use_yn character(1),
    rre_aloc_lwltd_rt numeric(12,8),
    aply_sdt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (wfg_cd);


ALTER TABLE sdmin.hu0b18tc OWNER TO letl;

--
-- Name: hu0b19tc; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b19tc (
    wfg_cd character(2) NOT NULL,
    aloc_scnr_id character(5) NOT NULL,
    aloc_tp_dscd character(1) NOT NULL,
    bas_colm_pri_rk numeric(5,0) NOT NULL,
    aply_edt character(10) NOT NULL,
    bas_attr_nm character varying(100),
    bas_colm_nm character varying(100),
    sort_bas_txt character varying(100),
    aply_sdt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (aloc_tp_dscd ,bas_colm_pri_rk);


ALTER TABLE sdmin.hu0b19tc OWNER TO letl;

--
-- Name: hu0b20tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b20tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    wk_bsdt character(10) NOT NULL,
    scnr_id character(5) NOT NULL,
    aply_edt character(10) NOT NULL,
    lst_cal_mtd_yn character(1),
    lnk_bs_apyn character(1),
    aply_sdt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (scnr_id);


ALTER TABLE sdmin.hu0b20tm OWNER TO letl;

--
-- Name: hu0b21tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b21tm (
    wfg_cd character(2) NOT NULL,
    scnr_id character(5) NOT NULL,
    aply_edt character(10) NOT NULL,
    scnr_nm character varying(100),
    wk_kdcd character(2),
    rwa_cal_mtd_tpcd character(2),
    sl_cal_mtd_cd character(1),
    stc_xps_cal_mtd_cd character(1),
    sal_bnd_cal_mtd_cd character(1),
    bak_rwacm_tpcd character(2),
    rre_clf_mtd_cd character(1) NOT NULL,
    crd_mtg_prc_mtd_cd character(1),
    aloc_scnr_id character(5) NOT NULL,
    pd_scnr_id character(5),
    lgd_scnr_id character(5),
    ead_scnr_id character(5),
    tm_scnr_id character(5),
    fnd_vol_scnr_id character(5),
    lnk_scnr_id character(5),
    gov_cal_mtd_cd character(2),
    pbist_cal_mtd_cd character(2),
    mdb_cal_mtd_cd character(2),
    bk_cal_mtd_cd character(2),
    co_cal_mtd_cd character(2),
    rtsel_cal_mtd_cd character(2),
    subco_cal_mtd_cd character(2),
    frg_br_cal_mtd_cd character(2),
    airb_em_use_yn character(1),
    hldco_hld_lmt_yn character(1),
    ctn_lmtov_aply_cn numeric(2,0),
    hmil10_lmt_alw_am numeric(18,3),
    rre_con_yn character(1),
    mkt_rsk_scnr_id character(5),
    orm_scnr_id character(5),
    irt_rsk_scnr_id character(5),
    biz_rsk_scnr_id character(5),
    cct_rsk_scnr_id character(5),
    ntfnd_scnr_id character(5),
    aply_sdt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (scnr_id);


ALTER TABLE sdmin.hu0b21tm OWNER TO letl;

--
-- Name: hu0b22tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b22tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    wk_bsdt character(10) NOT NULL,
    scnr_id character(5) NOT NULL,
    rwa_cal_id character(42) NOT NULL,
    xps_id character(30),
    xps_tpcd character(2),
    acc_dscd character(2),
    acc_cd character(11),
    act_mngbr_cd character(5),
    ctp_id character(20),
    tot_sal_am numeric(18,3),
    std_aset_clas_cd character(5) NOT NULL,
    in_rk_aset_clas_cd character(5),
    xps_pre_af_rk_cd character(2),
    nbis_bas_dsh_yn character(1),
    xps_sdt character(10),
    xps_xpdt character(10),
    xps_srviv_xpr_ycn numeric(10,4),
    em_ycn numeric(10,4),
    stm_prd_tgt_yn character(1),
    cur_cd character(3),
    krw_xc_lmt_am numeric(18,3),
    krw_xc_not_wdr_bl numeric(18,3),
    krw_xc_bl numeric(18,3),
    gen_alw_am numeric(18,3),
    spc_alw_am numeric(18,3),
    ead_am numeric(18,3),
    adj_ead_am numeric(18,3),
    lgd_rt numeric(12,8),
    fcst_los_rt numeric(12,8),
    fcst_los_am numeric(18,3),
    wgt_avg_rsk_wgt_rt numeric(12,8),
    std_hld_rsk_wgt_rt numeric(12,8),
    xps_rsk_wgt_rt numeric(12,8),
    fcls_opt_estm_rt numeric(12,8),
    crd_evl_mdl_dscd character(2),
    ext_crdrk_cd character(2) NOT NULL,
    rtsel_pol_id character(20) NOT NULL,
    wgt_avg_dsh_rt numeric(12,8),
    xps_dsh_rt numeric(12,8),
    oist_evl_ist_cd character(2),
    oist_crdrk_txt character(10),
    onac_ofset_am numeric(18,3),
    mcr_am numeric(18,3),
    mgg_pt_rwa_am numeric(18,3),
    nmgg_pt_rwa_am numeric(18,3),
    rwast_am numeric(18,3),
    adj_af_xps_am numeric(18,3),
    fnc_mgg_aloc_am numeric(18,3),
    nfnc_mgg_aloc_am numeric(18,3),
    crd_dvprd_aloc_am numeric(18,3),
    grn_aloc_am numeric(18,3),
    rre_vld_mgg_am numeric(18,3),
    cre_vld_mgg_am numeric(18,3),
    crd_mtg_xps_am numeric(18,3),
    acl_id character(20),
    coco_nv numeric(12,8),
    std_inds_cfcd character(5),
    cosiz_cd character(2),
    nbis_ptf_dscd character(2),
    bdsys_dscd character(2),
    acc_bas_biz_hq_cd character(3),
    cus_bas_biz_hq_cd character(3),
    db_chg_ts timestamp(6) without time zone,
    fc_aset_yn character(1) NOT NULL,
    nbis_cal_aply_dscd character(1),
    co_rtsel_dscd character(1),
    psco_rgno character(13),
    psbz_no character(13),
    prd_cd character(9),
    gen_bdr_am numeric(18,3),
    spc_bdr_am numeric(18,3),
    bl_ead_am numeric(18,3),
    nuse_lmt_ead_am numeric(18,3),
    bl_el_am numeric(18,3),
    nuse_lmt_el_am numeric(18,3),
    aply_aset_clas_cd character varying(4),
    lnk_com_cd character(8)
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.hu0b22tm OWNER TO letl;

--
-- Name: hu0b22tm_ori; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b22tm_ori (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    scnr_id character(5),
    rwa_cal_id character(42),
    xps_id character(30),
    xps_tpcd character(2),
    acc_dscd character(2),
    acc_cd character(11),
    act_mngbr_cd character(5),
    ctp_id character(20),
    tot_sal_am numeric(18,3),
    std_aset_clas_cd character(5),
    in_rk_aset_clas_cd character(5),
    xps_pre_af_rk_cd character(2),
    nbis_bas_dsh_yn character(1),
    xps_sdt character(10),
    xps_xpdt character(10),
    xps_srviv_xpr_ycn numeric(10,4),
    em_ycn numeric(10,4),
    stm_prd_tgt_yn character(1),
    cur_cd character(3),
    krw_xc_lmt_am numeric(18,3),
    krw_xc_not_wdr_bl numeric(18,3),
    krw_xc_bl numeric(18,3),
    gen_alw_am numeric(18,3),
    spc_alw_am numeric(18,3),
    ead_am numeric(18,3),
    adj_ead_am numeric(18,3),
    lgd_rt numeric(12,8),
    fcst_los_rt numeric(12,8),
    fcst_los_am numeric(18,3),
    wgt_avg_rsk_wgt_rt numeric(12,8),
    std_hld_rsk_wgt_rt numeric(12,8),
    xps_rsk_wgt_rt numeric(12,8),
    fcls_opt_estm_rt numeric(12,8),
    crd_evl_mdl_dscd character(2),
    ext_crdrk_cd character(2),
    rtsel_pol_id character(20),
    wgt_avg_dsh_rt numeric(12,8),
    xps_dsh_rt numeric(12,8),
    oist_evl_ist_cd character(2),
    oist_crdrk_txt character(10),
    onac_ofset_am numeric(18,3),
    mcr_am numeric(18,3),
    mgg_pt_rwa_am numeric(18,3),
    nmgg_pt_rwa_am numeric(18,3),
    rwast_am numeric(18,3),
    adj_af_xps_am numeric(18,3),
    fnc_mgg_aloc_am numeric(18,3),
    nfnc_mgg_aloc_am numeric(18,3),
    crd_dvprd_aloc_am numeric(18,3),
    grn_aloc_am numeric(18,3),
    rre_vld_mgg_am numeric(18,3),
    cre_vld_mgg_am numeric(18,3),
    crd_mtg_xps_am numeric(18,3),
    acl_id character(20),
    coco_nv numeric(12,8),
    std_inds_cfcd character(5),
    cosiz_cd character(2),
    nbis_ptf_dscd character(2),
    bdsys_dscd character(2),
    acc_bas_biz_hq_cd character(3),
    cus_bas_biz_hq_cd character(3),
    db_chg_ts timestamp(6) without time zone,
    fc_aset_yn character(1),
    nbis_cal_aply_dscd character(1),
    co_rtsel_dscd character(1),
    psco_rgno character(13),
    psbz_no character(13),
    prd_cd character(9),
    gen_bdr_am numeric(18,3),
    spc_bdr_am numeric(18,3),
    bl_ead_am numeric(18,3),
    nuse_lmt_ead_am numeric(18,3),
    bl_el_am numeric(18,3),
    nuse_lmt_el_am numeric(18,3),
    aply_aset_clas_cd character varying(4),
    lnk_com_cd character(8)
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.hu0b22tm_ori OWNER TO letl;

--
-- Name: hu0b34tc; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b34tc (
    wfg_cd character(2) NOT NULL,
    bic_cd character(11) NOT NULL,
    aply_edt character(10) NOT NULL,
    bic_ist_tpcd character(2),
    bic_ist_tp_nm character varying(300),
    hoff_loc_nat_cd character(2),
    hoff_loc_nat_nm character(50),
    ist_loc_nat_cd character(2),
    ist_loc_nat_nm character(50),
    aply_sdt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (bic_cd);


ALTER TABLE sdmin.hu0b34tc OWNER TO letl;

--
-- Name: hu0b41tc; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b41tc (
    wfg_cd character(2) NOT NULL,
    lgd_scnr_id character(5) NOT NULL,
    mmgg_col_rt_dscd character(2) NOT NULL,
    vtl_dscd character(2) NOT NULL,
    aply_edt character(10) NOT NULL,
    col_rt numeric(12,8),
    los_rt numeric(12,8),
    aply_sdt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (lgd_scnr_id ,mmgg_col_rt_dscd ,vtl_dscd);


ALTER TABLE sdmin.hu0b41tc OWNER TO letl;

--
-- Name: hu0b44tc; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b44tc (
    wfg_cd character(2) NOT NULL,
    pd_scnr_id character(5) NOT NULL,
    rtsel_pol_id character(20) NOT NULL,
    aply_edt character(10) NOT NULL,
    dsh_rt numeric(12,8),
    aply_sdt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (pd_scnr_id ,rtsel_pol_id);


ALTER TABLE sdmin.hu0b44tc OWNER TO letl;

--
-- Name: hu0d01tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0d01tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    ctp_id character(20) NOT NULL,
    psbz_no character(13),
    psco_rgno character(13),
    trn_cpt_nm character varying(200),
    nat_cd character(2),
    std_inds_cfcd character(5),
    bzcgr_cd character(2),
    cosiz_cd character(2),
    gid_giv_tgt_yn character(1),
    tot_aset_am numeric(18,3),
    tot_sal_am numeric(18,3),
    crd_evl_mdl_dscd character(2),
    lowpt_mdl_dscd character(2),
    scr_ceg_cd character(2),
    mdps_ceg_cd character(2),
    judg_evl_rk_cd character(2),
    lst_ceg_cd character(2),
    lst_ceg_fix_dt character(10),
    vld_rk_yn character(1),
    co_rtsel_dscd character(1),
    dsh_yn character(1),
    dsh_rsn_cd character(3),
    nbis_dsh_dscd character(1) NOT NULL,
    dsh_ocr_dt character(10),
    ln_siz_cd character(2) NOT NULL,
    db_chg_ts timestamp(6) without time zone,
    dmn_dsh_yn character(1),
    co_rtsel_cgnz_tpcd character(2),
    his_yn_cd character(1),
    pd_tgt_yn_cd character(1),
    dsh_can_dt character(10),
    crins_vld_fxdt character(10),
    ln_xst_yn character(1),
    cd_xst_yn character(1),
    old_ceg_cd character(2),
    nbis_ptf_dscd character(2),
    sys_ceg_cd character(2),
    rwa_bas_ead_am numeric(21,3)
) DISTRIBUTED BY (ctp_id);


ALTER TABLE sdmin.hu0d01tm OWNER TO letl;

--
-- Name: hu0d02tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0d02tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    acc_cd character(11) NOT NULL,
    xps_id character(30) NOT NULL,
    acc_dscd character(2) NOT NULL,
    act_no character(20),
    lmt_agr_id character(30),
    apvrq_no character(11) NOT NULL,
    rq_srno character(3) NOT NULL,
    act_mngbr_cd character(5),
    rel_acno character(30),
    cus_no character(15),
    ctp_id character(20),
    psco_rgno character(13),
    trnpe_dscd character(4),
    bdsys_dscd character(2),
    co_rtsel_dscd character(1),
    psco_dscd character(1),
    prc_apl_dscd character(2),
    xps_tpcd character(2),
    trtuni_cd character(2),
    trt_fnd_no character(9),
    prd_cd character(9),
    ocpy_psv_yn character(1),
    ln_op_dscd character(2),
    lmt_agr_sdt character(10),
    lmt_agr_xpdt character(10),
    act_sdt character(10),
    act_xpdt character(10),
    fst_act_xpdt character(10),
    xps_agr_xpr_ycn numeric(10,4),
    fst_dsh_dt character(10),
    dsh_ocr_dt character(10),
    dsh_can_dt character(10),
    aply_irt numeric(10,4),
    lmt_am numeric(18,3),
    cur_cd character(3),
    ln_exe_am numeric(18,3),
    ln_bl numeric(18,3),
    dshtm_bl numeric(18,3),
    nml_pot_lmt_am numeric(18,3),
    nml_pot_bl numeric(18,3),
    dfr_dcn numeric(5,0),
    ncol_agr_int_am numeric(18,3),
    fee_am numeric(18,3),
    pxpay_yn character(1),
    pxpay_bl numeric(18,3),
    abs_dscd character(1),
    pgrn_kdcd character(2),
    lc_buy_dscd character(2),
    dsh_yn character(1),
    dsh_rsn_cd character(3),
    grpln_fnd_dscd character(2),
    dpsin_mggln_yn character(1),
    liv_cm_use_dscd character(1),
    rc_cus_dscd character(1),
    mn6_pas_yn character(1),
    apt_mgg_dscd character(1),
    org_xpr_dscd character(1),
    rc_crdrk_cd character(2),
    pur_psn_prd_dscd character(2),
    cd_pol_prd_dscd character(1),
    soho_prd_dscd character(2),
    dfr_dcn_dscd character(2),
    onl_mdl_rk_cd character(2),
    bat_mdl_rk_cd character(2),
    evl_dt character(10),
    rtsel_pol_id character(20),
    db_chg_ts timestamp(6) without time zone,
    onl_evl_mdl_dscd character(2),
    bat_evl_mdl_dscd character(2),
    dmn_dsh_yn character(1),
    trt_fnd_cfcd character(2),
    rc_caltg_yn character(1),
    co_rtsel_cgnz_tpcd character(2),
    fst_lmt_agr_sdt character(10),
    nml_pot_onac_bl numeric(18,3),
    onl_evl_dt character(10),
    bat_evl_dt character(10),
    onl_mdl_dis_id character(2),
    bat_mdl_dis_id character(2),
    dfr_yn character(1),
    lnact_fst_opn_dt character(10),
    css_jud_xcp_dscd character(2),
    css_jud_xcp_yn character(1),
    soho_jud_xcp_no character(3),
    soho_jud_xcp_yn character(1),
    bfchg_rtsel_pol_id character(20),
    dfr_dscd character(2),
    dfr_rckdt character(10),
    xps_stcd character(1),
    rc_caltg_dscd character(2),
    ln_rq_dscd character(2),
    apv_no character(20),
    onl_crd_asc numeric(18,3),
    bat_crd_asc numeric(18,3),
    rc_crd_asc numeric(18,3),
    pas_mn_dscd character(2),
    rwa_bas_ead_am numeric(21,3)
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.hu0d02tm OWNER TO letl;

--
-- Name: hu0d05tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0d05tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    xps_id character(30) NOT NULL,
    acc_cd character(11) NOT NULL,
    co_psn_dscd character(1),
    co_rtsel_dscd character(1),
    cus_no character(15),
    ctp_id character(20),
    psbz_no character(13),
    xps_tpcd character(2),
    prd_cd character(9),
    lmt_am numeric(18,3),
    bal_bl numeric(18,3),
    nml_pot_lmt_am numeric(18,3),
    nml_pot_bl numeric(18,3),
    ncol_int_am numeric(18,3),
    dfr_int_am numeric(18,3),
    mbr_vld_ineff_yn character(1),
    hirk_cd_rk_cd character(1),
    fst_dfr_dt character(10),
    tot_dfr_dcn numeric(5,0),
    fst_dsh_dt character(10),
    dsh_ocr_dt character(10),
    dsh_can_dt character(10),
    dsh_yn character(1),
    dsh_rsn_cd character(3),
    onl_evl_mdl_dscd character(2),
    ass_rk_txt character(2),
    bss_rk_txt character(2),
    cd_pol_prd_dscd character(1),
    dfr_dcn_dscd character(2),
    cd_use_rst_yn character(1),
    d60_pas_yn character(1),
    rc_crdrk_cd character(2),
    rtsel_pol_id character(20),
    db_chg_ts timestamp(6) without time zone,
    dmn_dsh_yn character(1),
    mbr_dscd character(1),
    bat_evl_mdl_dscd character(2),
    evl_dt character(10),
    ccd_csno character(15),
    rc_caltg_yn character(1),
    co_rtsel_cgnz_tpcd character(2),
    spc_lmt_am numeric(18,3),
    dshtm_bl numeric(18,3),
    dfr_yn character(1),
    bss_tgt_yn character(1),
    bfchg_rtsel_pol_id character(20),
    mgg_grn_tpcd character(2),
    psn_bss_dtl_mdl_cd character(1),
    rc_caltg_dscd character(2),
    cd_opn_dt character(10),
    onl_crd_asc numeric(18,3),
    bat_crd_asc numeric(18,3),
    rc_crd_asc numeric(18,3),
    rc_cus_dscd character(1),
    emn_rst_yn character(1),
    onl_mdl_dis_id character(2),
    bat_mdl_dis_id character(2),
    bl_xst_yn character(1),
    rwa_bas_ead_am numeric(21,3)
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.hu0d05tm OWNER TO letl;

--
-- Name: hu0d88tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0d88tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    ctp_id character(20) NOT NULL,
    psco_rgno character(13),
    crd_evl_mdl_dscd character(2),
    lst_ceg_cd character(2),
    co_rtsel_dscd character(1) NOT NULL,
    dsh_yn character(1),
    dsh_ocr_dt character(10),
    db_chg_ts timestamp(6) without time zone,
    co_rtsel_cgnz_tpcd character(2),
    crins_vld_fxdt character(10),
    ext_crdrk_cd character(2),
    nbis_ptf_dscd character(2)
) DISTRIBUTED BY (ctp_id);


ALTER TABLE sdmin.hu0d88tm OWNER TO letl;

--
-- Name: hu0d99tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0d99tm (
    wfg_cd character(2),
    bas_dt character(10),
    psco_rgno character(13),
    ctp_id character(20),
    xps_id character(30),
    acc_cd character(11),
    acc_dscd character(2),
    ln_xst_yn character(1),
    cd_xst_yn character(1),
    lmt_agr_id character(30),
    corp_yn character(1),
    lst_ceg_cd character(2),
    lst_ceg_fix_dt character(10),
    tot_sal_am numeric(18,3),
    tot_aset_am numeric(18,3),
    lmt_am numeric(18,3),
    lst_lmt_am numeric(18,3),
    rc_crdrk_cd character(2),
    evl_dt character(10),
    lst_evl_dt character(10),
    co_rtsel_dscd character(1),
    co_rtsel_cgnz_tpcd character(2),
    db_chg_ts timestamp(6) without time zone,
    crins_vld_fxdt character(10),
    crd_evl_mdl_dscd character(2),
    cus_no character(15),
    prd_cd character(9),
    bat_evl_mdl_dscd character(2),
    ln_op_dscd character(2),
    dsh_ocr_dt character(10),
    dsh_can_dt character(10),
    dsh_rsn_cd character(3),
    psco_dscd character(1)
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.hu0d99tm OWNER TO letl;

--
-- Name: hu0e0ctm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e0ctm (
    wfg_cd character(2) NOT NULL,
    rtsel_pol_id character(20) NOT NULL,
    aply_edt character(10) NOT NULL,
    rtsel_pol_id_nm character varying(100),
    pol_prd_dscd character(1),
    stbl_prd_dscd character(2),
    rhsqt_dscd character(1),
    ext_crdrk_cd character(2),
    mst_scle_rk_cd character(5),
    aply_sdt character(10),
    use_yn character(1),
    db_chg_ts timestamp(6) without time zone,
    cd_pol_prd_dscd character(1),
    rc_crdrk_use_yn character(1),
    rc_cus_pur_psn_yn character(1),
    midas_rtsel_cfcd character(2),
    midas_rtsel_gcfcd character(2),
    midas_rtsel_mcfcd character(2),
    midas_rtsel_scfcd character(3),
    midas_dtl_srno character(3)
) DISTRIBUTED BY (rtsel_pol_id);


ALTER TABLE sdmin.hu0e0ctm OWNER TO letl;

--
-- Name: hu0e13tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e13tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    anl_tgt_tm_cd character(1) NOT NULL,
    pd_anl_mtd_dscd character(1) NOT NULL,
    rtsel_pol_id character(20) NOT NULL,
    aply_edt character(10) NOT NULL,
    anl_tgt_ym character(6),
    nml_act_cn numeric(8,0),
    dsh_act_cn numeric(8,0),
    dsh_rt numeric(9,6),
    adj_dsh_rt numeric(9,6),
    lst_dsh_rt numeric(9,6),
    ltm_avg_dsh_rt numeric(9,6),
    ltm_avg_stdv_rt numeric(9,6),
    aply_sdt character(10),
    db_chg_ts timestamp(6) without time zone,
    opn_dsh_hld_cn numeric(8,0),
    aloc_opn_dsh_cn numeric(7,0)
) DISTRIBUTED BY (anl_tgt_tm_cd ,pd_anl_mtd_dscd ,rtsel_pol_id);


ALTER TABLE sdmin.hu0e13tm OWNER TO letl;

--
-- Name: hu0e26tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e26tm (
    wfg_cd character(2) NOT NULL,
    rc_crdrk_cd character(2) NOT NULL,
    aply_edt character(10) NOT NULL,
    aply_sdt character(10),
    ext_crdrk_cd character(2),
    use_yn character(1),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (rc_crdrk_cd);


ALTER TABLE sdmin.hu0e26tm OWNER TO letl;

--
-- Name: hu0e27tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e27tm (
    wfg_cd character(2) NOT NULL,
    nbis_ptf_dscd character(2) NOT NULL,
    ser_no character(4) NOT NULL,
    aply_edt character(10) NOT NULL,
    aply_sdt character(10),
    crd_evl_mdl_dscd character(2) NOT NULL,
    nbis_aply_yn character(1),
    use_yn character(1),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (nbis_ptf_dscd ,ser_no);


ALTER TABLE sdmin.hu0e27tm OWNER TO letl;

--
-- Name: hu0e2btm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e2btm (
    wfg_cd character(2) NOT NULL,
    nbis_apl_ar_dscd character(2) NOT NULL,
    nbis_dtl_apl_id character varying(50) NOT NULL,
    nbis_hdw_para_id character(3) NOT NULL,
    aply_edt character(10) NOT NULL,
    nbis_dtl_apl_id_nm character(50),
    nbis_hdw_para_nm character(2000),
    hdw_para_txt character(50),
    hdw_para_nv numeric(26,10),
    aply_sdt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_dh timestamp(6) without time zone
) DISTRIBUTED BY (nbis_apl_ar_dscd ,nbis_dtl_apl_id ,nbis_hdw_para_id);


ALTER TABLE sdmin.hu0e2btm OWNER TO letl;

--
-- Name: hu0e32tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e32tm (
    wfg_cd character(2) NOT NULL,
    acc_dscd character(2) NOT NULL,
    acc_cd character(11) NOT NULL,
    ln_op_dscd character(2) NOT NULL,
    aply_edt character(10) NOT NULL,
    lmt_ln_tp_gcfcd character(1),
    lmt_ln_tp_scfcd character(3),
    aply_sdt character(10),
    use_yn character(1),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (ln_op_dscd);


ALTER TABLE sdmin.hu0e32tm OWNER TO letl;

--
-- Name: hu0e63tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e63tm (
    wfg_cd character(2) NOT NULL,
    mgg_dscd character(2) NOT NULL,
    mmgg_kdcd character(3) NOT NULL,
    mgg_musg_cd character(2) NOT NULL,
    aply_edt character(10) NOT NULL,
    nbis_mgcrt_dscd character(2) NOT NULL,
    mgg_aloc_rk numeric(2,0),
    aply_sdt character(10),
    use_yn character(1),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (mgg_dscd ,mmgg_kdcd ,mgg_musg_cd);


ALTER TABLE sdmin.hu0e63tm OWNER TO letl;

--
-- Name: hu0e64tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e64tm (
    wfg_cd character(2) NOT NULL,
    nbis_mgcrt_dscd character(2) NOT NULL,
    vtl_sta_rt numeric(9,6) NOT NULL,
    vtl_end_rt numeric(9,6) NOT NULL,
    aply_edt character(10) NOT NULL,
    vtl_dscd character(2) NOT NULL,
    use_yn character(1),
    aply_sdt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (nbis_mgcrt_dscd ,vtl_sta_rt ,vtl_end_rt);


ALTER TABLE sdmin.hu0e64tm OWNER TO letl;

--
-- Name: hu0es1tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0es1tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    anl_tgt_tm_cd character(1) NOT NULL,
    pd_anl_mtd_dscd character(1) NOT NULL,
    rtsel_pol_id character(20) NOT NULL,
    aply_edt character(10) NOT NULL,
    smt_dsh_rt numeric(9,6),
    aply_sdt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (anl_tgt_tm_cd ,pd_anl_mtd_dscd ,rtsel_pol_id);


ALTER TABLE sdmin.hu0es1tm OWNER TO letl;

--
-- Name: hu0raatf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0raatf (
    wk_dt character(10) NOT NULL,
    wk_id character(50) NOT NULL,
    prc_id character(50) NOT NULL,
    wk_wfg_cd character(2),
    wk_bsdt character(10),
    wk_exe_bsdt character(10),
    wk_sta_dh timestamp(6) without time zone,
    wk_end_dh timestamp(6) without time zone,
    wk_stcd character(2),
    tms_fil_cn numeric(15,0),
    wk_cn numeric(15,0),
    wk_rst_txt character varying(4000),
    wk_rtfil_nm character varying(100),
    wk_pth_nm character varying(100),
    sys_dis_nm character(10),
    err_id character(20),
    para_txt character varying(100),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (wk_id ,prc_id ,err_id ,sys_dis_nm);


ALTER TABLE sdmin.hu0raatf OWNER TO letl;

--
-- Name: hu0radtm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0radtm (
    err_txt text,
    sys_dis_nm text,
    err_id text,
    del_yn text
) DISTRIBUTED BY (err_txt);


ALTER TABLE sdmin.hu0radtm OWNER TO letl;

--
-- Name: hu0raitf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0raitf (
    wk_dt text,
    wk_id text,
    prc_id text,
    wk_log_dh text,
    nbis_wk_stcd text,
    wk_log_lvl_no text,
    wk_log_txt text,
    sys_dis_nm text,
    err_id text,
    db_chg_ts text
) DISTRIBUTED BY (wk_dt);


ALTER TABLE sdmin.hu0raitf OWNER TO letl;

--
-- Name: hu0ramtm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0ramtm (
    wfg_cd text,
    pgm_id text,
    aply_edt text,
    bat_mnd_yn text
) DISTRIBUTED BY (wfg_cd);


ALTER TABLE sdmin.hu0ramtm OWNER TO letl;

--
-- Name: hu0rantf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu0rantf (
    wfg_cd text,
    bas_dt text,
    scrn_id text,
    cmpl_yn text
) DISTRIBUTED BY (wfg_cd);


ALTER TABLE sdmin.hu0rantf OWNER TO letl;

--
-- Name: hu3r5ttm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu3r5ttm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    psco_rgno character(13) NOT NULL,
    aply_edt character(10) NOT NULL,
    crd_evl_mdl_dscd character(2) NOT NULL,
    bzcgr_cd character varying(2) NOT NULL,
    crins_dscd character(2) NOT NULL,
    lst_ceg_cd character(2),
    scr_ceg_cd character(2),
    judg_evl_rk_cd character(2),
    mdps_ceg_cd character(2),
    sys_ceg_cd character(2),
    lst_ceg_fix_dt character(10),
    lmt_am numeric(18,3),
    bal_bl numeric(18,3),
    dsh_yn character(1),
    dsh_ocr_dt character(10),
    dsh_ocr_pot_dscd character(1),
    nml_pot_ceg_cd character(2),
    nml_pot_evl_mdl_dscd character(2),
    nml_pot_bzcgr_cd character(2),
    nml_pot_crins_dscd character(2),
    nml_pot_evl_dt character(10),
    db_chg_ts timestamp(6) without time zone,
    pd_tgt_yn_cd character(1) NOT NULL
) DISTRIBUTED BY (psco_rgno);


ALTER TABLE sdmin.hu3r5ttm OWNER TO letl;

--
-- Name: hu8d88tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu8d88tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    ifrs_scnr_id character(3) NOT NULL,
    ctp_id character(20) NOT NULL,
    psco_rgno character(13),
    co_rtsel_dscd character(1) NOT NULL,
    co_rtsel_cgnz_tpcd character(2),
    dsh_yn character(1),
    dsh_ocr_dt character(10),
    crins_vld_fxdt character(10),
    crd_evl_mdl_dscd character(2),
    lst_ceg_cd character(2),
    ext_crdrk_cd character varying(2) NOT NULL,
    nbis_ptf_dscd character varying(2) NOT NULL,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (ctp_id);


ALTER TABLE sdmin.hu8d88tm OWNER TO letl;

--
-- Name: hu9e68tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hu9e68tm (
    wfg_cd character(2) NOT NULL,
    mgg_dscd character(2) NOT NULL,
    mmgg_kdcd character(3) NOT NULL,
    mgg_musg_cd character(2) NOT NULL,
    aply_edt character(10) NOT NULL,
    nbis_mgcrt_dscd character(2) NOT NULL,
    mgg_aloc_rk numeric(2,0),
    aply_sdt character(10),
    use_yn character(1),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (mgg_dscd ,mmgg_kdcd ,mgg_musg_cd);


ALTER TABLE sdmin.hu9e68tm OWNER TO letl;

--
-- Name: hud206tc; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hud206tc (
    wfg_cd character(2) NOT NULL,
    mgg_dscd character(2) NOT NULL,
    mgg_kdcd character(3) NOT NULL,
    mgg_usg_ref_cd character(2) NOT NULL,
    aply_edt character(10) NOT NULL,
    mgg_kd_nm character varying(100),
    nbis_crd_mtg_dscd character(2),
    std_sapc_fit_yn character(1),
    std_cah_fit_yn character(1),
    firb_fit_yn character(1),
    airb_fit_yn character(1),
    isupe_std_ctp_tpcd character(3),
    fit_scrt_yn character(1),
    fit_grn_yn character(1),
    cmpl_ltv_rt numeric(12,8),
    liv_cre_dscd character(1),
    aply_sdt character(10),
    mgg_kd_rk numeric(10,0),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone,
    pd_lgd_aply_dscd character(1),
    ecezo_ltv_rt numeric(12,8),
    avgbl_el_fit_yn character(1) NOT NULL,
    endbl_el_fit_yn character(1) NOT NULL
) DISTRIBUTED BY (mgg_kdcd);


ALTER TABLE sdmin.hud206tc OWNER TO letl;

--
-- Name: hud207tc; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hud207tc (
    nbis_crd_mtg_dscd character(2) NOT NULL,
    aply_edt character(10) NOT NULL,
    nbis_crm_dis_nm character(40),
    nfmg_aply_mlgd_rt numeric(10,4),
    ovr_mgg_rt numeric(12,8),
    min_mgg_rt numeric(12,8),
    aply_sdt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (nbis_crd_mtg_dscd);


ALTER TABLE sdmin.hud207tc OWNER TO letl;

--
-- Name: hud501tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hud501tm (
    wfg_cd character(2) NOT NULL,
    evl_dt character(10) NOT NULL,
    psco_rgno character(13) NOT NULL,
    pscobz_dscd character(1),
    gid_giv_tgt_yn character(1),
    lst_ceg_cd character(2) NOT NULL,
    crd_evl_mdl_dscd character(2) NOT NULL,
    lowpt_mdl_dscd character(2),
    std_inds_cfcd character(5) NOT NULL,
    bzcgr_cd character(2) NOT NULL,
    crins_rcp_dscd character(1) NOT NULL,
    crins_dscd character(2) NOT NULL,
    bdsys_cd character(1) NOT NULL,
    stc_listed_dscd character(2) NOT NULL,
    gid_giv_rsn_cd character(2) NOT NULL,
    fncstm_bsdt character(10),
    estm_fncstm_bas_yr character(4),
    estm_fncstm_srno numeric(3,0),
    lst_evl_chg_dt character(10),
    fnc_pst_evl_rk_cd character(2),
    judg_evl_rk_cd character(2) NOT NULL,
    mdps_ceg_cd character(2) NOT NULL,
    rqpe_br_cd character(5) NOT NULL,
    evl_br_cd character(5) NOT NULL,
    insuni_rcog_yn character(1),
    inspe_emp_no character(8),
    inspe_pobr_cd character(5) NOT NULL,
    insp_dt character(10),
    crins_vld_fxdt character(10),
    del_yn character(1),
    scr_ceg_cd character(2),
    old_ceg_cd character(2),
    evlpe_emp_no character(8) NOT NULL,
    seq_no numeric(3,0) NOT NULL,
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone,
    ceg_scfcd character(2),
    old_crd_evl_mdl_dscd character(2),
    bfchg_psco_rgno character(13),
    scr_asc_sc numeric(18,6) NOT NULL,
    mdps2_ceg_cd character(2) NOT NULL,
    judg_asc_sc numeric(18,6) NOT NULL,
    mdps_asc_sc numeric(18,6) NOT NULL,
    mdps2_asc_sc numeric(18,6) NOT NULL,
    sys_ceg_cd character(2),
    judg_tot_sc numeric(18,6) NOT NULL,
    cb_tot_sc numeric(18,6) NOT NULL,
    cb_asc_sc numeric(18,6) NOT NULL
) DISTRIBUTED BY (psco_rgno ,evl_dt);


ALTER TABLE sdmin.hud501tm OWNER TO letl;

--
-- Name: hud504tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hud504tf (
    nat_cd character(2) NOT NULL,
    oist_evl_ist_cd character(2) NOT NULL,
    evl_dt character(10) NOT NULL,
    oist_crdrk_dscd character(1) NOT NULL,
    oist_crdrk_txt character(10),
    rk_vld_dt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    del_yn character(1),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (nat_cd ,oist_evl_ist_cd);


ALTER TABLE sdmin.hud504tf OWNER TO letl;

--
-- Name: hud511tc; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hud511tc (
    isupe_psco_rgno character(13) NOT NULL,
    scrt_itm_cd character(12) NOT NULL,
    scrt_rk_dscd character(1),
    cpbnd_evl_srno character(10),
    isu_dt character(10),
    isu_am numeric(18,3),
    cpbnd_xpdt character(10),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (isupe_psco_rgno ,scrt_itm_cd);


ALTER TABLE sdmin.hud511tc OWNER TO letl;

--
-- Name: hud513tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hud513tm (
    isupe_psco_rgno character(13) NOT NULL,
    scrt_itm_cd character(12) NOT NULL,
    evl_dt character(10) NOT NULL,
    oist_evl_ist_cd character(2) NOT NULL,
    oist_crdrk_dscd character(1) NOT NULL,
    scrt_evl_rk_txt character(10),
    crd_mtg_adj_yn character(1),
    stm_crdrk_yn character(1),
    prn_lmt_crd_evl_yn character(1),
    std_ctp_tpcd character(3),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (isupe_psco_rgno ,scrt_itm_cd);


ALTER TABLE sdmin.hud513tm OWNER TO letl;

--
-- Name: hud514tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hud514tf (
    corp_no character(13) NOT NULL,
    oist_evl_ist_cd character(2) NOT NULL,
    evl_dt character(10) NOT NULL,
    oist_crdrk_dscd character(1) NOT NULL,
    nbis_dat_src_dscd character(2) NOT NULL,
    std_ctp_tpcd character(3),
    bic_cd_yn character(1),
    rk_vld_dt character(10),
    oist_crdrk_txt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    del_yn character(1),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (corp_no);


ALTER TABLE sdmin.hud514tf OWNER TO letl;

--
-- Name: hud520tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hud520tf (
    wfg_cd character(2) NOT NULL,
    psco_rgno character(13) NOT NULL,
    evl_dt character(10) NOT NULL,
    cpbnd_evl_ist_cd character(1) NOT NULL,
    cpbnd_cbevl_dscd character(2) NOT NULL,
    cpbnd_evl_srno character(30) NOT NULL,
    cpbnd_kdcd character(6) NOT NULL,
    syn_evl_rk_nm character varying(20),
    slf_evl_rk_nm character varying(20),
    fncstm_bsdt character(10),
    vld_dt character(10),
    isu_dt character(10),
    isu_am numeric(18,3) NOT NULL,
    cpbnd_xpdt character(10),
    wlist_dscd character(2),
    wlist_rgs_dt character(10),
    co_cpbnd_rk_cd character(2),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (psco_rgno);


ALTER TABLE sdmin.hud520tf OWNER TO letl;

--
-- Name: hud591tc; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hud591tc (
    std_ctp_tpcd character(3) NOT NULL,
    oist_evl_ist_cd character(2) NOT NULL,
    oist_crdrk_dscd character(1) NOT NULL,
    oist_crdrk_txt character(10) NOT NULL,
    aply_edt character(10) NOT NULL,
    std_evl_rk_cd character(5),
    dsh_rt numeric(9,6),
    rsk_wgt_rt numeric(12,8),
    aply_sdt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (std_ctp_tpcd ,oist_evl_ist_cd ,oist_crdrk_dscd);


ALTER TABLE sdmin.hud591tc OWNER TO letl;

--
-- Name: hud593tc; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hud593tc (
    wfg_cd character(2) NOT NULL,
    crd_evl_mdl_dscd character(2) NOT NULL,
    aply_edt character(10) NOT NULL,
    crd_evl_mdl_dscn character varying(100),
    std_ctp_tpcd character(3),
    in_rk_ctp_tpcd character(3),
    std_aset_clas_cd character(5),
    in_rk_aset_clas_cd character(5),
    aply_sdt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (crd_evl_mdl_dscd);


ALTER TABLE sdmin.hud593tc OWNER TO letl;

--
-- Name: hud594tc; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hud594tc (
    wfg_cd character(2) NOT NULL,
    rtsel_pol_id character(20) NOT NULL,
    aply_edt character(10),
    rtsel_pol_nm character varying(100),
    std_ctp_tpcd character(3),
    in_rk_ctp_tpcd character(3),
    std_aset_clas_cd character(5),
    in_rk_aset_clas_cd character(5),
    aply_sdt character(10),
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (rtsel_pol_id);


ALTER TABLE sdmin.hud594tc OWNER TO letl;

--
-- Name: hue017tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hue017tf (
    wfg_cd character(2) NOT NULL,
    acc_cd character(11) NOT NULL,
    acc_dscd character(2) NOT NULL,
    aply_edt character(10) NOT NULL,
    aply_sdt character(10),
    std_aset_clas_cd character(5),
    in_rk_aset_clas_cd character(5),
    nbis_acc_ref_cd character(3),
    rsk_wgt_rt numeric(12,8),
    acc_pctgt_yn character(1),
    tot_ln_sum_tgt_yn character(1),
    stm_prd_tgt_yn character(1),
    sal_bnd_yn character(1),
    stc_yn character(1),
    fit_rot_ln_yn character(1),
    hhld_ln_prd_yn character(1),
    cre_dt character(10),
    lchg_dt character(10) NOT NULL,
    rwa_caltg_xcp_yn character(1),
    ctp_id character(20),
    dtl_xps_yn character(1),
    fit_lnd_scrt_yn character(1),
    stm_rk_tgt_yn character(1),
    avgbl_el_xtgt_yn character(1),
    endbl_el_xtgt_yn character(1),
    el_acc_pctgt_yn character(1),
    crd_xps_tpcd character(2),
    fc_aset_yn character(1) NOT NULL,
    use_cnf_cd character varying(1) NOT NULL,
    opr_no character(8),
    mgr_no character(8),
    opbr_cd character(5),
    op_dh date,
    db_chg_ts timestamp(6) without time zone,
    lmt_aloc_yn character(1) NOT NULL,
    el_cap_cost_yn character(1) NOT NULL
) DISTRIBUTED BY (acc_pctgt_yn ,rwa_caltg_xcp_yn);


ALTER TABLE sdmin.hue017tf OWNER TO letl;

--
-- Name: huf40dtm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE huf40dtm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    xps_id character(30) NOT NULL,
    lmt_agr_id character(30) NOT NULL,
    apvrq_no character(11),
    rq_srno character(3) NOT NULL,
    prc_apl_dscd character(2),
    bdsys_dscd character(2),
    ctp_id character(20),
    psco_rgno character(13),
    trn_cpt_nm character varying(150),
    cus_no character(15) NOT NULL,
    prd_cd character(9),
    acc_dscd character(2) NOT NULL,
    acc_cd character(11) NOT NULL,
    trtuni_cd character(2),
    cur_cd character(3),
    apv_am numeric(18,3),
    krw_xc_apv_am numeric(18,3),
    dmn_krw_avgbl numeric(18,3),
    krw_xc_bl numeric(18,3),
    dacbr_cd character(5),
    ln_op_dscd character(2),
    ln_rq_dscd character(2),
    ln_rq_kdcd character(2),
    fx_apv_yn character(1),
    lmt_agr_sdt character(10),
    lmt_agr_xpdt character(10),
    dpsin_mggln_yn character(1),
    mmgg_cd character(5),
    rq_mgg_dscd character(1),
    trnpe_dscd character(4),
    std_inds_cfcd character(5),
    nbis_dat_src_dscd character(2) NOT NULL,
    db_chg_ts timestamp(6) without time zone,
    xps_hld_yn character(1) NOT NULL,
    tot_aset_am numeric(18,3),
    tot_sal_am numeric(18,3)
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.huf40dtm OWNER TO letl;

--
-- Name: huf410tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE huf410tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    ifrs_scnr_id character(3) NOT NULL,
    xps_id character(30) NOT NULL,
    acc_cd character(11) NOT NULL,
    ctp_id character(20) NOT NULL,
    co_rtsel_dscd character(1),
    ext_crdrk_cd character(2),
    nbis_bas_dsh_yn character(1),
    dsh_ocr_dt character(10),
    dsh_can_dt character(10),
    crd_evl_mdl_dscd character(2),
    rtsel_pol_id character(20),
    db_chg_ts timestamp(6) without time zone,
    co_rtsel_cgnz_tpcd character(2),
    rc_crdrk_cd character varying(2),
    rc_cus_dscd character(1),
    cd_pol_prd_dscd character(1),
    psco_rgno character(13) NOT NULL,
    dshtm_bl numeric(18,3),
    nbis_dat_src_dscd character(2),
    liv_cm_use_dscd character(1),
    nbis_ptf_dscd character(2) NOT NULL,
    prd_cd character(9)
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.huf410tm OWNER TO letl;

--
-- Name: huf415tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE huf415tf (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    xps_id character(30) NOT NULL,
    acc_cd character(11) NOT NULL,
    cur_cd character(3) NOT NULL,
    act_no character(20) NOT NULL,
    scrt_acno character(32),
    lmt_agr_id character(30) NOT NULL,
    acc_dscd character(2),
    nbis_acc_ref_cd character(3),
    bl_dscd character(1),
    prd_cd character(9),
    bdsys_dscd character(2),
    ln_op_dscd character(2),
    bal_bl numeric(18,3),
    krw_xc_bl numeric(18,3),
    lmt_am numeric(18,3) NOT NULL,
    krw_xc_lmt_am numeric(18,3) NOT NULL,
    xps_tpcd character(2),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.huf415tf OWNER TO letl;

--
-- Name: huf419tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE huf419tf (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    xps_id character(30) NOT NULL,
    acc_cd character(11) NOT NULL,
    cur_cd character(3) NOT NULL,
    act_mngbr_cd character(5) NOT NULL,
    trtuni_cd character(2) NOT NULL,
    bdsys_dscd character(2) NOT NULL,
    act_no character(20) NOT NULL,
    scrt_acno character(32),
    lmt_agr_id character(30) NOT NULL,
    acc_dscd character(2),
    nbis_acc_ref_cd character(3),
    bl_dscd character(1),
    prd_cd character(9),
    ln_op_dscd character(2),
    avgbl_lmt_am numeric(18,3),
    krw_avgbl_lmt_am numeric(18,3),
    bal_bl numeric(18,3),
    krw_xc_bl numeric(18,3),
    dmn_krw_avgbl numeric(18,3),
    krw_xc_nuse_lmt_am numeric(18,3),
    xps_tpcd character(2),
    nbis_dat_src_dscd character(2) NOT NULL,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.huf419tf OWNER TO letl;

--
-- Name: huf41atf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE huf41atf (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    xps_id character(30) NOT NULL,
    acc_cd character(11) NOT NULL,
    cur_cd character(3) NOT NULL,
    act_no character(20) NOT NULL,
    scrt_acno character(32) NOT NULL,
    lmt_agr_id character(30) NOT NULL,
    acc_dscd character(2),
    nbis_acc_ref_cd character(3),
    bl_dscd character(1),
    prd_cd character(9),
    bdsys_dscd character(2),
    ln_op_dscd character(2),
    lmt_am numeric(18,3),
    krw_xc_lmt_am numeric(18,3),
    bal_bl numeric(18,3),
    krw_xc_bl numeric(18,3),
    krw_xc_nuse_lmt_am numeric(18,3),
    xps_tpcd character(2),
    nbis_dat_src_dscd character(2) NOT NULL,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.huf41atf OWNER TO letl;

--
-- Name: huf41btf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE huf41btf (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    xps_id character(30) NOT NULL,
    acc_cd character(11) NOT NULL,
    cur_cd character(3) NOT NULL,
    act_mngbr_cd character(5) NOT NULL,
    trtuni_cd character(2) NOT NULL,
    bdsys_dscd character(2) NOT NULL,
    act_no character(20) NOT NULL,
    scrt_acno character(32),
    lmt_agr_id character(30) NOT NULL,
    acc_dscd character(2),
    nbis_acc_ref_cd character(3),
    bl_dscd character(1),
    prd_cd character(9),
    ln_op_dscd character(2),
    avgbl_lmt_am numeric(18,3),
    krw_avgbl_lmt_am numeric(18,3),
    bal_bl numeric(18,3),
    krw_xc_bl numeric(18,3),
    dmn_krw_avgbl numeric(18,3),
    krw_xc_nuse_lmt_am numeric(18,3),
    xps_tpcd character(2),
    nbis_dat_src_dscd character(2) NOT NULL,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.huf41btf OWNER TO letl;

--
-- Name: hum008tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum008tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    br_cd character(5) NOT NULL,
    kbr_nm character(50),
    ebr_nm character(50),
    infdpt_kbr_abr_nm character(20),
    kbr_abr_nm character(8),
    fxbk_cd character(2),
    fxbr_cd character(5),
    fx_mobr_cd character(5),
    br_kdcd character(1),
    shut_yn character(1),
    br_opn_dt character(10),
    cent_rgs_dt character(10),
    shut_bsdt character(10),
    psnpo_cd character(6),
    zip_cd character(6),
    kor_rmd_ad character varying(120),
    tel_no character(14),
    ch_cd character(2),
    fnd_mobr_yn character(1),
    mobr_yn character(1),
    mobr_cd character(5),
    giro_cd character(6),
    rgn_cd character(2),
    nat_cd character(2),
    itg_br_cd character(5),
    abs_br_yn character(1),
    exe_apl_dscd character(1),
    rgn_cent_dscd character(1),
    biz_hq_cd character(2),
    biz_no character(10),
    abs_mng_mobr_cd character(5),
    old_br_cd character(5),
    del_yn character(1),
    lst_load_dt character(10) NOT NULL,
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (br_cd);


ALTER TABLE sdmin.hum008tm OWNER TO letl;

--
-- Name: hum201tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum201tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    mgg_id character(20) NOT NULL,
    mgg_dscd character(2),
    mgg_srno character(10),
    mgg_stcd character(2),
    mmgg_kdcd character(3) NOT NULL,
    mgg_musg_cd character(2),
    frm_mgg_dscd character(1),
    crd_mtg_acq_dt character(10),
    crd_mtg_can_dt character(10),
    srviv_rsk_xst_yn character(1),
    mgg_no character(16),
    br_cd character(5) NOT NULL,
    rps_ownpe_unq_no character(13),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone,
    bmgg_rcog_yn character(1),
    bmgg_am numeric(18,3),
    bmgg_rcog_rt numeric(7,3),
    bmgg_vld_fxdt character(10),
    bmgg_aply_sbid_rt numeric(7,3),
    unq_no_dscd character(1)
) DISTRIBUTED BY (mgg_id);


ALTER TABLE sdmin.hum201tm OWNER TO letl;

--
-- Name: hum202tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum202tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    mgg_id character(20) NOT NULL,
    his_no character(5) NOT NULL,
    nbis_crd_mtg_dscd character(2),
    mgg_stcd character(2),
    mgg_kdcd character(3),
    mgg_usg_ref_cd character(2),
    stc_itm_cd character(6),
    nat_cd character(2),
    bic_cd character(11),
    scrt_itm_cd character(12),
    isupe_psco_rgno character(13),
    isupe_std_ctp_tpcd character(3),
    frg_scrt_itm_cd character(12),
    scrt_deed_no character(20),
    scrt_rk_dscd character(1),
    dps_acno character(20),
    xch_listed_yn character(1),
    msidx_incl_yn character(1),
    slf_estm_ddu_rt_id character(20),
    oprevl_mgn_adj_dcn numeric(4,0),
    isu_dt character(10),
    xpr_dt character(10),
    biz_dt_bas_xpdt character(10),
    can_dt character(10),
    apr_dt character(10),
    insp_dt character(10),
    cur_val_evl_dt character(10),
    crm_agr_xpr_ycn numeric(10,4),
    crm_svx_ycn numeric(10,4),
    cur_cd character(3),
    apr_pr numeric(18,3),
    krw_xc_apr_pr numeric(18,3),
    insp_pr numeric(18,3),
    krw_xc_insp_pr numeric(18,3),
    cur_val_am numeric(18,3),
    krw_xc_cur_val_am numeric(18,3),
    tbk_dpsin_bl numeric(18,3),
    insp_rt numeric(12,8),
    fcst_col_rt numeric(12,8),
    oait_corp_cd character(3),
    iap_evlpe_emp_no character(8),
    ovs_mgg_bnd_dscd character(1),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (mgg_id);


ALTER TABLE sdmin.hum202tm OWNER TO letl;

--
-- Name: hum203tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum203tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    mgg_id character(20) NOT NULL,
    his_no character(5) NOT NULL,
    nbis_crd_mtg_dscd character(2),
    mgg_stcd character(2),
    mgg_kdcd character(3),
    mgg_usg_ref_cd character(2),
    liv_cm_use_dscd character(1),
    prdf_ocp_dscd character(1),
    dfmg_acq_pln_dt character(10),
    crt_dong_sido_cd character(2),
    xpr_dt character(10),
    can_dt character(10),
    apr_dt character(10),
    insp_dt character(10),
    cur_val_evl_dt character(10),
    cur_cd character(3),
    apr_pr numeric(18,3),
    krw_xc_apr_pr numeric(18,3),
    insp_pr numeric(18,3),
    krw_xc_insp_pr numeric(18,3),
    cur_val_am numeric(18,3),
    krw_xc_cur_val_am numeric(18,3),
    insp_rt numeric(12,8),
    sbid_rt numeric(12,8),
    oait_corp_cd character(3),
    iap_evlpe_emp_no character(8),
    aset_idx_nm character(40),
    aset_idx_rt numeric(12,8),
    aset_idx_frqc_rt numeric(12,8),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone,
    adm_sgg_cd character(3),
    adm_dem_cd character(3),
    li_cd character(2),
    loc_sido_cd character(2)
) DISTRIBUTED BY (mgg_id);


ALTER TABLE sdmin.hum203tm OWNER TO letl;

--
-- Name: hum204tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum204tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    mgg_id character(20) NOT NULL,
    his_no character(5) NOT NULL,
    nbis_crd_mtg_dscd character(2),
    mgg_stcd character(2),
    mgg_kdcd character(3),
    mgg_usg_ref_cd character(2),
    grn_tpcd character(2),
    trnpe_dscd character(4),
    isupe_std_ctp_tpcd character(3),
    grnpe_rps_psbz_no character(13),
    grn_corpno character(13),
    isu_dt character(10),
    xpr_dt character(10),
    biz_dt_bas_xpdt character(10),
    can_dt character(10),
    cur_cd character(3),
    grn_rt numeric(12,8),
    grn_am numeric(18,3),
    krw_xc_grn_am numeric(18,3),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (mgg_id);


ALTER TABLE sdmin.hum204tm OWNER TO letl;

--
-- Name: hum209tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum209tf (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    wk_bsdt character(10) NOT NULL,
    crd_mtg_id character(30) NOT NULL,
    nbis_crd_mtg_dscd character(2),
    mgg_dscd character(2) NOT NULL,
    mgg_kdcd character(3) NOT NULL,
    mgg_usg_ref_cd character(2) NOT NULL,
    mgg_id character(20) NOT NULL,
    his_no character(5),
    est_srno character(3) NOT NULL,
    mgg_srno character(10),
    isupe_std_ctp_tpcd character(3),
    crm_isp_psbz_no character(13),
    crm_ipsco_rgno character(13),
    nat_cd character(2),
    bic_cd character(11),
    mgg_aloc_dscd character(1),
    mgg_aloc_dis_rk numeric(10,0),
    mgg_kd_rk numeric(10,0),
    std_sapc_fit_yn character(1),
    std_cah_fit_yn character(1),
    firb_fit_yn character(1),
    airb_fit_yn character(1),
    fit_scrt_yn character(1),
    fit_grn_yn character(1),
    crd_mtg_acq_dt character(10),
    crd_mtg_xpdt character(10),
    biz_dt_bas_xpdt character(10),
    apr_dt character(10),
    insp_dt character(10),
    cur_val_evl_dt character(10),
    crm_agr_xpr_ycn numeric(10,4),
    crm_svx_ycn numeric(10,4),
    lst_insp_pr_evl_dt character(10),
    scrt_itm_cd character(12),
    frg_scrt_itm_cd character(12),
    scrt_rk_dscd character(1),
    bas_aset_rk_txt character(10),
    ref_aset_rk_txt character(10),
    ref_aset_ctp_id character(20),
    krw_xc_nm_item_am numeric(18,3),
    mlt_bas_aset_yn character(1),
    liv_cm_use_dscd character(1),
    oprevl_mgn_adj_dcn numeric(4,0),
    msidx_incl_yn character(1),
    xch_listed_yn character(1),
    nbis_ptf_dscd character(2),
    ext_crdrk_cd character(2),
    rsk_wgt_rt numeric(12,8),
    crd_mtg_crcd character(3),
    krw_xc_apr_am numeric(18,3),
    krw_xc_insp_am numeric(18,3),
    krw_xc_pre_rk_am numeric(18,3),
    etw_prkes_am numeric(18,3),
    krw_xc_prkes_am numeric(18,3),
    krw_xc_rnt_am numeric(18,3),
    krw_xc_etc_ddu_am numeric(18,3),
    etw_est_am numeric(18,3),
    krw_xc_est_am numeric(18,3),
    krw_xc_avl_pr numeric(18,3),
    krw_xc_cur_val_am numeric(18,3),
    krwx_svl_evl_am numeric(18,3),
    etw_am numeric(18,3),
    krwx_vld_mgg_suval numeric(18,3),
    etw_vld_mgg_pr_am numeric(18,3),
    insp_rt numeric(12,8),
    sbid_rt numeric(12,8),
    cmpl_ltv_rt numeric(12,8),
    grn_rt numeric(12,8),
    src_mgg_no character(16),
    slf_estm_ddu_rt_id character(20),
    if_ts_sys_cd character(1),
    pd_lgd_aply_dscd character(1),
    db_chg_ts timestamp(6) without time zone,
    rgn_tpcd character(1),
    ecezo_ltv_rt numeric(12,8)
) DISTRIBUTED BY (mgg_id);


ALTER TABLE sdmin.hum209tf OWNER TO letl;

--
-- Name: hum209tf_ori; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum209tf_ori (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    crd_mtg_id character(30),
    nbis_crd_mtg_dscd character(2),
    mgg_dscd character(2),
    mgg_kdcd character(3),
    mgg_usg_ref_cd character(2),
    mgg_id character(20),
    his_no character(5),
    est_srno character(3),
    mgg_srno character(10),
    isupe_std_ctp_tpcd character(3),
    crm_isp_psbz_no character(13),
    crm_ipsco_rgno character(13),
    nat_cd character(2),
    bic_cd character(11),
    mgg_aloc_dscd character(1),
    mgg_aloc_dis_rk numeric(10,0),
    mgg_kd_rk numeric(10,0),
    std_sapc_fit_yn character(1),
    std_cah_fit_yn character(1),
    firb_fit_yn character(1),
    airb_fit_yn character(1),
    fit_scrt_yn character(1),
    fit_grn_yn character(1),
    crd_mtg_acq_dt character(10),
    crd_mtg_xpdt character(10),
    biz_dt_bas_xpdt character(10),
    apr_dt character(10),
    insp_dt character(10),
    cur_val_evl_dt character(10),
    crm_agr_xpr_ycn numeric(10,4),
    crm_svx_ycn numeric(10,4),
    lst_insp_pr_evl_dt character(10),
    scrt_itm_cd character(12),
    frg_scrt_itm_cd character(12),
    scrt_rk_dscd character(1),
    bas_aset_rk_txt character(10),
    ref_aset_rk_txt character(10),
    ref_aset_ctp_id character(20),
    krw_xc_nm_item_am numeric(18,3),
    mlt_bas_aset_yn character(1),
    liv_cm_use_dscd character(1),
    oprevl_mgn_adj_dcn numeric(4,0),
    msidx_incl_yn character(1),
    xch_listed_yn character(1),
    nbis_ptf_dscd character(2),
    ext_crdrk_cd character(2),
    rsk_wgt_rt numeric(12,8),
    crd_mtg_crcd character(3),
    krw_xc_apr_am numeric(18,3),
    krw_xc_insp_am numeric(18,3),
    krw_xc_pre_rk_am numeric(18,3),
    etw_prkes_am numeric(18,3),
    krw_xc_prkes_am numeric(18,3),
    krw_xc_rnt_am numeric(18,3),
    krw_xc_etc_ddu_am numeric(18,3),
    etw_est_am numeric(18,3),
    krw_xc_est_am numeric(18,3),
    krw_xc_avl_pr numeric(18,3),
    krw_xc_cur_val_am numeric(18,3),
    krwx_svl_evl_am numeric(18,3),
    etw_am numeric(18,3),
    krwx_vld_mgg_suval numeric(18,3),
    etw_vld_mgg_pr_am numeric(18,3),
    insp_rt numeric(12,8),
    sbid_rt numeric(12,8),
    cmpl_ltv_rt numeric(12,8),
    grn_rt numeric(12,8),
    src_mgg_no character(16),
    slf_estm_ddu_rt_id character(20),
    if_ts_sys_cd character(1),
    pd_lgd_aply_dscd character(1),
    db_chg_ts timestamp(6) without time zone,
    rgn_tpcd character(1),
    ecezo_ltv_rt numeric(12,8)
) DISTRIBUTED BY (mgg_id);


ALTER TABLE sdmin.hum209tf_ori OWNER TO letl;

--
-- Name: hum210tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum210tf (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    mgg_id character(20) NOT NULL,
    est_srno character(3) NOT NULL,
    lmt_agr_id character(30) NOT NULL,
    apvrq_no character(11) NOT NULL,
    rq_srno character(3) NOT NULL,
    apv_no character(20),
    crms_hld_rel_cd character(2),
    mgg_rcog_rt numeric(12,8),
    ln_cfcd character(1),
    est_rgs_dt character(10),
    mgg_stcd character(2),
    can_dt character(10),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (mgg_id);


ALTER TABLE sdmin.hum210tf OWNER TO letl;

--
-- Name: hum211tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum211tf (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    mgg_id character(20) NOT NULL,
    est_srno character(3) NOT NULL,
    pub_est_mng_no character(15),
    mgg_dscd character(2),
    est_stcd character(2),
    mgg_srno character(10),
    est_rgs_dt character(10),
    est_xpdt character(10),
    est_crcd character(3),
    est_am numeric(18,3),
    est_krw_xc_am numeric(18,3),
    tbk_est_yn character(1),
    bdpv_cd character(2),
    mgg_invk_yn character(1),
    mgg_obj_cd character(2),
    mgg_invk_am numeric(18,3),
    bdtb_est_xpdt character(10),
    can_dt character(10),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone,
    clb_ln_rt numeric(7,3)
) DISTRIBUTED BY (mgg_id);


ALTER TABLE sdmin.hum211tf OWNER TO letl;

--
-- Name: hum213tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum213tf (
    wfg_cd character(2) NOT NULL,
    bas_yr character(4) NOT NULL,
    bas_qr_mn character(2) NOT NULL,
    crt_dong_sido_cd character(2) NOT NULL,
    adm_sgg_cd character varying(3) NOT NULL,
    mgg_usg_ref_cd character(2) NOT NULL,
    sbid_rt_dscd character(2) NOT NULL,
    sbid_rt numeric(12,8),
    aply_sdt character(10),
    nbis_dat_src_dscd character(2) NOT NULL,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (crt_dong_sido_cd);


ALTER TABLE sdmin.hum213tf OWNER TO letl;

--
-- Name: hum215tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum215tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    wk_bsdt character(10) NOT NULL,
    aloc_scnr_id character(5) NOT NULL,
    crd_mtg_id character(30) NOT NULL,
    rwa_cal_id character(42) NOT NULL,
    ctp_id character(20),
    crd_mtg_aloc_rk numeric(8,0),
    xps_aloc_rk numeric(8,0),
    crm_xps_aloc_rk numeric(8,0),
    liv_cm_use_dscd character(1),
    tsa_a_stsp_fit_yn character(1),
    tsa_a_stch_fit_yn character(1),
    tsa_a_firb_fit_yn character(1),
    tsa_a_airb_fit_yn character(1),
    xpr_dcrd_yn character(1),
    call_dcrd_yn character(1),
    rsk_wgt_rt numeric(12,8),
    crd_mtg_aloc_am numeric(18,3),
    mgg_aloc_am numeric(18,3),
    crd_mtg_bas_am numeric(18,3),
    xps_bas_am numeric(18,3),
    aloc_bf_crd_mtg_am numeric(18,3),
    aloc_bf_xps_am numeric(18,3),
    aloc_af_crd_mtg_am numeric(18,3),
    aloc_af_xps_am numeric(18,3),
    db_chg_ts timestamp(6) without time zone,
    aply_ead_am numeric(18,3) NOT NULL,
    crd_mtg_add_aloc_am numeric(18,3) NOT NULL
) DISTRIBUTED BY (crd_mtg_id ,rwa_cal_id);


ALTER TABLE sdmin.hum215tm OWNER TO letl;

--
-- Name: hum215tm_ori; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum215tm_ori (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    aloc_scnr_id character(5),
    crd_mtg_id character(30),
    rwa_cal_id character(42),
    ctp_id character(20),
    crd_mtg_aloc_rk numeric(8,0),
    xps_aloc_rk numeric(8,0),
    crm_xps_aloc_rk numeric(8,0),
    liv_cm_use_dscd character(1),
    tsa_a_stsp_fit_yn character(1),
    tsa_a_stch_fit_yn character(1),
    tsa_a_firb_fit_yn character(1),
    tsa_a_airb_fit_yn character(1),
    xpr_dcrd_yn character(1),
    call_dcrd_yn character(1),
    rsk_wgt_rt numeric(12,8),
    crd_mtg_aloc_am numeric(18,3),
    mgg_aloc_am numeric(18,3),
    crd_mtg_bas_am numeric(18,3),
    xps_bas_am numeric(18,3),
    aloc_bf_crd_mtg_am numeric(18,3),
    aloc_bf_xps_am numeric(18,3),
    aloc_af_crd_mtg_am numeric(18,3),
    aloc_af_xps_am numeric(18,3),
    db_chg_ts timestamp(6) without time zone,
    aply_ead_am numeric(18,3),
    crd_mtg_add_aloc_am numeric(18,3)
) DISTRIBUTED BY (crd_mtg_id ,rwa_cal_id);


ALTER TABLE sdmin.hum215tm_ori OWNER TO letl;

--
-- Name: hum216tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum216tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    wk_bsdt character(10) NOT NULL,
    crd_mtg_id character(30) NOT NULL,
    rwa_cal_id character(42) NOT NULL,
    mgg_id character(20),
    est_srno character(3),
    apvrq_no character(11),
    rq_srno character(3),
    xps_id character(30),
    ctp_id character(20),
    liv_cm_use_dscd character(1),
    tsa_a_stsp_aply_yn character(1),
    tsa_a_stch_aply_yn character(1),
    tsa_a_firb_fit_yn character(1),
    tsa_a_airb_fit_yn character(1),
    sapc_rsk_wgt_rt numeric(12,8),
    zero_hct_yn character(1),
    xpr_dcrd_yn character(1),
    call_dcrd_yn character(1),
    rsk_wgt_rt numeric(12,8),
    mgg_aloc_am numeric(18,3),
    if_ts_sys_cd character(1),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (crd_mtg_id ,rwa_cal_id);


ALTER TABLE sdmin.hum216tm OWNER TO letl;

--
-- Name: hum216tm_ori; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum216tm_ori (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    crd_mtg_id character(30),
    rwa_cal_id character(42),
    mgg_id character(20),
    est_srno character(3),
    apvrq_no character(11),
    rq_srno character(3),
    xps_id character(30),
    ctp_id character(20),
    liv_cm_use_dscd character(1),
    tsa_a_stsp_aply_yn character(1),
    tsa_a_stch_aply_yn character(1),
    tsa_a_firb_fit_yn character(1),
    tsa_a_airb_fit_yn character(1),
    sapc_rsk_wgt_rt numeric(12,8),
    zero_hct_yn character(1),
    xpr_dcrd_yn character(1),
    call_dcrd_yn character(1),
    rsk_wgt_rt numeric(12,8),
    mgg_aloc_am numeric(18,3),
    if_ts_sys_cd character(1),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (crd_mtg_id ,rwa_cal_id);


ALTER TABLE sdmin.hum216tm_ori OWNER TO letl;

--
-- Name: hum218tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum218tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    mgg_id character(20) NOT NULL,
    rnt_srno character(2) NOT NULL,
    mgg_stcd character(2),
    spc_rgn_dscd character(1),
    mgg_rgn_dscd character(2),
    str_ddu_dscd character(1),
    rgs_dt character(10),
    can_dt character(10),
    smam_grn_aply_dt character(10),
    hous_actl_rnt_am numeric(18,3),
    hous_fcst_rnt_am numeric(18,3),
    hous_fst_rpy_am numeric(18,3),
    ful_rum_cn numeric(2,0),
    rnt_rum_cn numeric(2,0),
    smam_grn_am numeric(18,3),
    smdu_tgt_rum_cn numeric(5,2),
    str_actl_rnt_am numeric(18,3),
    str_fcst_rnt_am numeric(18,3),
    str_fst_rpy_am numeric(18,3),
    mgg_rcog_am numeric(18,3),
    mgg_rcog_rt numeric(7,3),
    br_brmgr_emp_no character(8),
    opbr_cd character(5),
    opr_emp_no character(8),
    etc_rnt_am numeric(18,3),
    etc_rnt_txt character(50),
    nbis_dat_src_dscd character(2) NOT NULL,
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (mgg_id);


ALTER TABLE sdmin.hum218tm OWNER TO letl;

--
-- Name: hum219tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum219tf (
    wfg_cd character(2) NOT NULL,
    sido_cd character(2) NOT NULL,
    adm_sgg_cd character(3) NOT NULL,
    adm_dem_cd character(3) NOT NULL,
    li_cd character(2) NOT NULL,
    rgn_tpcd character(1) NOT NULL,
    vld_sdt character(10) NOT NULL,
    vld_edt character(10),
    rgs_dt character(10),
    opr_emp_no character(8),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (sido_cd ,adm_sgg_cd ,adm_dem_cd);


ALTER TABLE sdmin.hum219tf OWNER TO letl;

--
-- Name: hum401tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum401tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    xps_id character(30) NOT NULL,
    cur_cd character(3),
    acc_dscd character(2),
    act_mngbr_cd character(5),
    lmt_agr_id character(30),
    ctp_id character(20),
    act_no character(20) NOT NULL,
    scrt_acno character(32),
    psco_rgno character(13),
    cus_no character(15),
    rdmpe_csno character(9),
    trnpe_dscd character(4),
    prd_cd character(9) NOT NULL,
    ln_op_dscd character(2),
    trtuni_cd character(2),
    trt_fnd_no character(9),
    trad_tgt_yn character(1),
    rel_acno character(30),
    acl_id character(20) NOT NULL,
    alwy_canav_yn character(1),
    act_sdt character(10),
    act_xpdt character(10),
    bfxtn_act_xpdt character(10),
    bdtb_act_xpdt character(10),
    act_edt character(10),
    xps_agr_xpr_ycn numeric(10,4),
    xps_srviv_xpr_ycn numeric(10,4),
    xps_stcd character(1),
    xps_tpcd character(2),
    abs_dscd character(1),
    sal_dt character(10),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone,
    kj_knbk_cur_acno character(30)
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.hum401tm OWNER TO letl;

--
-- Name: hum402tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum402tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    xps_id character(30) NOT NULL,
    act_no character(20) NOT NULL,
    xps_pre_af_rk_cd character(2),
    dfr_dscd character(2),
    dfr_rckdt character(10),
    dfr_tot_dcn numeric(5,0),
    psc_xuse_cd_yn character(1),
    psc_mctr_co_bzno character(10),
    psc_mctr_cocd_srno character(4),
    exac_itm_agr_yn character(1),
    rtsel_yn character(1),
    sal_bnd_yn character(1),
    hrsk_cre_rec_yn character(1),
    spfn_prf_wgt_apyn character(1),
    ln_rpy_mtd_cd character(2),
    prnrp_frq_mcn numeric(4,0),
    intpi_frq_mcn numeric(4,0),
    prdf_ocp_dscd character(1),
    fndus_dscd character(4),
    trt_fnd_cfcd character(2),
    lc_opnbk_bic_cd character(11),
    b2bmctr_copnt_cd character(3) NOT NULL,
    b2b_mctr_co_corpno character(13),
    b2b_mctr_co_bzno character(13),
    pxpay_yn character(1),
    pxpay_bl numeric(18,3),
    lc_buy_dscd character(2),
    dsh_yn character(1),
    cus_dsh_dcn numeric(4,0),
    stl_pln_dt character(10),
    dsh_prc_dt character(10),
    dsh_adj_dt character(10),
    col_yn character(1),
    dfct_yn character(1),
    bycol_fcam numeric(18,3),
    dcfe_col_dscd character(1),
    nml_xcfee_rt numeric(9,6),
    prf_xcfee_rt numeric(9,6),
    impo_opn_fee_rt numeric(12,8),
    impo_dc_rt numeric(12,8),
    grnfe_rt numeric(12,8),
    keic_beins_yn character(1),
    tbrmt_kdcd character(1),
    obrmt_kdcd character(1),
    rbybk_cd character(3),
    pgrn_kdcd character(2),
    mgg_am numeric(18,3),
    ldg_sts_txt character(3),
    ln_ldgcn_rsn_cd character(2),
    lnact_fst_opn_dt character(10),
    rm_sqno character(5),
    buy_fx_colbk_cd character(11),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.hum402tm OWNER TO letl;

--
-- Name: hum403tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum403tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    xps_id character(30) NOT NULL,
    psbz_no character(13),
    co_psn_dscd character(1),
    cur_lmt_am numeric(18,3),
    csel_pmny_lmt_am numeric(18,3),
    csv_lmt_am numeric(18,3),
    csel_am numeric(18,3),
    csel_nwlmt_am numeric(18,3),
    csv_am numeric(18,3),
    csv_not_wdr_lmt_am numeric(18,3),
    not_wdr_lmt_am numeric(18,3),
    spc_lmt_am numeric(18,3),
    istl_fee_rt numeric(12,8),
    csv_fee_rt numeric(12,8),
    cdln_fee_rt numeric(12,8),
    reln_fee_rt numeric(12,8),
    dfr_yn character(1),
    dfr5_ttw_ovr_yn character(1),
    mbr_vld_ineff_yn character(1),
    fst_dfr_dt character(10),
    tot_dfr_dcn numeric(5,0),
    reln_bl numeric(18,3),
    istln_bl numeric(18,3),
    cdln_bl numeric(18,3),
    hirk_cd_rk_cd character(1),
    rgs_dt character(10),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone,
    cdln_lmt_am numeric(18,3),
    nuse_lmt_am numeric(18,3)
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.hum403tm OWNER TO letl;

--
-- Name: hum405tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum405tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    xps_id character(30) NOT NULL,
    act_no character(20),
    scrt_itm_cd character(12),
    nm_item_am numeric(18,3),
    krw_xc_nm_item_am numeric(18,3),
    bok_am numeric(18,3),
    bok_up numeric(18,3),
    acq_am numeric(18,3),
    acq_up numeric(18,3),
    bnd_int_kdcd character(2),
    xps_pre_af_rk_cd character(2),
    stm_em_use_yn character(1),
    frc_cnv_cnd_xst_yn character(1),
    nst_cl_fa_sep_yn character(1),
    isupe_psco_rgno character(13),
    isu_ist_bzno character(13),
    isu_dt character(10),
    frg_bnd_nat_cd character(2),
    frg_bnd_kdcd character(2),
    fbnd_isin_cd_txt character(15),
    frg_bnd_evl_ist_cd character(2),
    frg_bnd_rk_txt character(10),
    lst_trn_dt character(10),
    hld_tpcd character(3),
    dfr_ycn numeric(2,0),
    cint_int_tm_ycn numeric(4,0),
    surfc_irt numeric(13,7),
    ical_mcn numeric(4,0),
    intpi_frq_mcn numeric(4,0),
    prnrp_frq_mcn numeric(4,0),
    prnrp_tp_dscd character(2),
    pt_ycn numeric(2,0),
    oprevl_am numeric(18,3),
    lst_acq_dt character(10),
    nbis_dat_src_dscd character(2),
    invs_scrt_evpft_am numeric(18,3),
    invs_scrt_evlos_am numeric(18,3),
    emt_evl_pl_am numeric(18,3),
    val_evl_dscd character(3),
    db_chg_ts timestamp(6) without time zone,
    nm_item_am_crcd character(3)
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.hum405tm OWNER TO letl;

--
-- Name: hum40btm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum40btm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    wk_bsdt character(10) NOT NULL,
    scnr_id character(5) NOT NULL,
    sme_ctp_id character(20) NOT NULL,
    tot_xps_am numeric(18,3),
    std_ctp_tpcd character(3),
    std_bas_rre_sam numeric(18,3),
    std_bas_xps_sam numeric(18,3),
    std_trxps_bdsp_rt numeric(12,8),
    in_rk_ctp_tpcd character(3),
    in_rk_bas_rre_sam numeric(18,3),
    in_rk_bas_xps_sam numeric(18,3),
    psbz_no character(13),
    psco_rgno character(13),
    db_chg_ts timestamp(6) without time zone,
    std_ctn_lmtov_cn numeric(5,0),
    in_rk_ctn_lmtov_cn numeric(5,0)
) DISTRIBUTED BY (scnr_id ,sme_ctp_id);


ALTER TABLE sdmin.hum40btm OWNER TO letl;

--
-- Name: hum40btm_ori; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum40btm_ori (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    scnr_id character(5),
    sme_ctp_id character(20),
    tot_xps_am numeric(18,3),
    std_ctp_tpcd character(3),
    std_bas_rre_sam numeric(18,3),
    std_bas_xps_sam numeric(18,3),
    std_trxps_bdsp_rt numeric(12,8),
    in_rk_ctp_tpcd character(3),
    in_rk_bas_rre_sam numeric(18,3),
    in_rk_bas_xps_sam numeric(18,3),
    psbz_no character(13),
    psco_rgno character(13),
    db_chg_ts timestamp(6) without time zone,
    std_ctn_lmtov_cn numeric(5,0),
    in_rk_ctn_lmtov_cn numeric(5,0)
) DISTRIBUTED BY (scnr_id ,sme_ctp_id);


ALTER TABLE sdmin.hum40btm_ori OWNER TO letl;

--
-- Name: hum421tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum421tf (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    wk_bsdt character(10) NOT NULL,
    rwa_cal_id character(42) NOT NULL,
    xps_tpcd character(2),
    xps_id character(30),
    lmt_agr_id character(30),
    apvrq_no character(11),
    rq_srno character(3),
    ln_rq_dscd character(2),
    ln_op_dscd character(2),
    ln_rq_kdcd character(2),
    acc_dscd character(2),
    acc_cd character(11),
    bl_dscd character(1) NOT NULL,
    trtuni_cd character(2),
    ocpy_rst_psv_yn character(1),
    prd_cd character(9) NOT NULL,
    rel_acno character(30),
    act_mngbr_cd character(5),
    xps_pre_af_rk_cd character(2),
    stm_prd_tgt_yn character(1),
    ctp_id character(20),
    sme_ctp_id character(20),
    psco_rgno character(13),
    isupe_psco_rgno character(13),
    b2bmctr_copnt_cd character(3),
    b2b_mctr_co_corpno character(13),
    b2b_mctr_co_bzno character(13),
    std_ctp_tpcd character(3),
    in_rk_ctp_tpcd character(3),
    std_aset_clas_cd character(5),
    in_rk_aset_clas_cd character(5),
    nat_cd character(2),
    cur_cd character(3),
    krw_xc_bl numeric(18,3),
    krw_xc_not_wdr_bl numeric(18,3),
    krw_xc_lmt_am numeric(18,3),
    krwx_ncol_agi_am numeric(18,3),
    krwx_rvs_pri_am numeric(18,3),
    ncol_irt numeric(12,8),
    aply_irt numeric(7,3),
    gen_alw_am numeric(18,3),
    spc_alw_am numeric(18,3),
    std_ccf_cd character(2),
    std_ccf_rt numeric(12,8),
    std_ead_am numeric(18,3),
    firb_ccf_cd character(2),
    firb_ccf_rt numeric(12,8),
    firb_ead_am numeric(18,3),
    lmt_ln_tp_gcfcd character(1),
    lmt_ln_tp_scfcd character(3),
    lmt_add_use_rt numeric(12,8),
    lmt_vns_rt numeric(12,8),
    lmtug_rt numeric(12,8),
    onac_cnv_rt numeric(12,8),
    airb_ead_am numeric(18,3),
    dfr_sdt character(10),
    dfr_dcn numeric(11,0),
    avg_dfr_dcn numeric(4,0),
    nbis_bas_dsh_yn character(1),
    dsh_rsn_cd character(3),
    dsh_pas_dcn numeric(5,0),
    opt_estm_fcls_rt numeric(12,8),
    pot_lgd_rt numeric(10,4),
    ltm_dsh_wag_lgd_rt numeric(10,4),
    gg_stn_lgd_rt numeric(10,4),
    co_rtsel_dscd character(1),
    rtsel_pol_id character(20),
    crd_evl_mdl_dscd character(2),
    ext_crdrk_cd character(2),
    nbis_ptf_dscd character(2),
    frg_scrt_itm_cd character(12),
    oist_evl_ist_cd character(2),
    oist_crdrk_txt character(10),
    frg_bnd_nat_cd character(2),
    scrt_itm_cd character(12),
    act_sdt character(10),
    act_xpdt character(10),
    bdtb_act_xpdt character(10),
    bfxtn_act_xpdt character(10),
    xps_agr_xpr_ycn numeric(10,4),
    xps_srviv_xpr_ycn numeric(10,4),
    em_ycn numeric(25,10),
    co_psn_dscd character(1),
    ccd_svc_dscd character(1),
    csel_am numeric(18,3),
    csv_am numeric(18,3),
    at_canav_agr_yn character(1),
    rq_mgg_dscd character(1),
    sal_bnd_yn character(1),
    ln_prd_aloc_rk numeric(10,0),
    irb_fit_nfnc_mgr numeric(12,8),
    listed_yn character(1),
    fp_dvam_pay_yn character(1),
    krw_xc_cn_posi_am numeric(18,3),
    cn_posi_svx_ycn numeric(10,4),
    krw_xc_sel_posi_am numeric(18,3),
    sel_posi_svx_ycn numeric(10,4),
    stc_std_apl_yn character(1),
    in_mdl_pot_los_am numeric(18,3),
    bdopev_otmkdv_yn character(1),
    dvprd_net_trc_am numeric(18,3),
    dvprd_tot_trc_am numeric(18,3),
    ngr_rt numeric(12,8),
    ofset_bf_aoft_am numeric(18,3),
    ofset_af_aoft_am numeric(18,3),
    ofset_af_evpl_sam numeric(18,3),
    invpd_bast_tpcd character(2),
    ininvs_bast_rw_rt numeric(12,8),
    crd_dvprd_tpcd character(2),
    cds_tpcd character(2),
    crdp_bas_aset_tpcd character(2),
    crdp_bast_rw_rt numeric(12,8),
    mst_ofset_yn character(1),
    bdopev_mgn_adj_yn character(1),
    fit_lnd_scrt_yn character(1),
    hrsk_cre_rec_yn character(1),
    spfn_prf_wgt_apyn character(1),
    acl_id character(20),
    xps_stcd character(1),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone,
    bic_cd character(11),
    lc_opnbk_bic_cd character(11),
    col_yn character(1),
    dfct_yn character(1),
    aptr_wgt_rt numeric(12,8),
    bdsys_dscd character(2),
    acc_bas_biz_hq_cd character(3),
    cus_bas_biz_hq_cd character(3),
    prd_col_rt_tgt_yn character(1),
    lc_buy_dscd character(2),
    rq_mgg_aloc_rk numeric(9,0),
    prm_rt numeric(12,8),
    rc_cus_dscd character(1),
    cd_pol_prd_dscd character(1),
    dshtm_bl numeric(18,3),
    gen_bdr_am numeric(18,3),
    spc_bdr_am numeric(18,3),
    lnk_com_cd character(8)
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.hum421tf OWNER TO letl;

--
-- Name: hum421tf_ori; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum421tf_ori (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    rwa_cal_id character(42),
    xps_tpcd character(2),
    xps_id character(30),
    lmt_agr_id character(30),
    apvrq_no character(11),
    rq_srno character(3),
    ln_rq_dscd character(2),
    ln_op_dscd character(2),
    ln_rq_kdcd character(2),
    acc_dscd character(2),
    acc_cd character(11),
    bl_dscd character(1),
    trtuni_cd character(2),
    ocpy_rst_psv_yn character(1),
    prd_cd character(9),
    rel_acno character(30),
    act_mngbr_cd character(5),
    xps_pre_af_rk_cd character(2),
    stm_prd_tgt_yn character(1),
    ctp_id character(20),
    sme_ctp_id character(20),
    psco_rgno character(13),
    isupe_psco_rgno character(13),
    b2bmctr_copnt_cd character(3),
    b2b_mctr_co_corpno character(13),
    b2b_mctr_co_bzno character(13),
    std_ctp_tpcd character(3),
    in_rk_ctp_tpcd character(3),
    std_aset_clas_cd character(5),
    in_rk_aset_clas_cd character(5),
    nat_cd character(2),
    cur_cd character(3),
    krw_xc_bl numeric(18,3),
    krw_xc_not_wdr_bl numeric(18,3),
    krw_xc_lmt_am numeric(18,3),
    krwx_ncol_agi_am numeric(18,3),
    krwx_rvs_pri_am numeric(18,3),
    ncol_irt numeric(12,8),
    aply_irt numeric(7,3),
    gen_alw_am numeric(18,3),
    spc_alw_am numeric(18,3),
    std_ccf_cd character(2),
    std_ccf_rt numeric(12,8),
    std_ead_am numeric(18,3),
    firb_ccf_cd character(2),
    firb_ccf_rt numeric(12,8),
    firb_ead_am numeric(18,3),
    lmt_ln_tp_gcfcd character(1),
    lmt_ln_tp_scfcd character(3),
    lmt_add_use_rt numeric(12,8),
    lmt_vns_rt numeric(12,8),
    lmtug_rt numeric(12,8),
    onac_cnv_rt numeric(12,8),
    airb_ead_am numeric(18,3),
    dfr_sdt character(10),
    dfr_dcn numeric(11,0),
    avg_dfr_dcn numeric(4,0),
    nbis_bas_dsh_yn character(1),
    dsh_rsn_cd character(3),
    dsh_pas_dcn numeric(5,0),
    opt_estm_fcls_rt numeric(12,8),
    pot_lgd_rt numeric(10,4),
    ltm_dsh_wag_lgd_rt numeric(10,4),
    gg_stn_lgd_rt numeric(10,4),
    co_rtsel_dscd character(1),
    rtsel_pol_id character(20),
    crd_evl_mdl_dscd character(2),
    ext_crdrk_cd character(2),
    nbis_ptf_dscd character(2),
    frg_scrt_itm_cd character(12),
    oist_evl_ist_cd character(2),
    oist_crdrk_txt character(10),
    frg_bnd_nat_cd character(2),
    scrt_itm_cd character(12),
    act_sdt character(10),
    act_xpdt character(10),
    bdtb_act_xpdt character(10),
    bfxtn_act_xpdt character(10),
    xps_agr_xpr_ycn numeric(10,4),
    xps_srviv_xpr_ycn numeric(10,4),
    em_ycn numeric(25,10),
    co_psn_dscd character(1),
    ccd_svc_dscd character(1),
    csel_am numeric(18,3),
    csv_am numeric(18,3),
    at_canav_agr_yn character(1),
    rq_mgg_dscd character(1),
    sal_bnd_yn character(1),
    ln_prd_aloc_rk numeric(10,0),
    irb_fit_nfnc_mgr numeric(12,8),
    listed_yn character(1),
    fp_dvam_pay_yn character(1),
    krw_xc_cn_posi_am numeric(18,3),
    cn_posi_svx_ycn numeric(10,4),
    krw_xc_sel_posi_am numeric(18,3),
    sel_posi_svx_ycn numeric(10,4),
    stc_std_apl_yn character(1),
    in_mdl_pot_los_am numeric(18,3),
    bdopev_otmkdv_yn character(1),
    dvprd_net_trc_am numeric(18,3),
    dvprd_tot_trc_am numeric(18,3),
    ngr_rt numeric(12,8),
    ofset_bf_aoft_am numeric(18,3),
    ofset_af_aoft_am numeric(18,3),
    ofset_af_evpl_sam numeric(18,3),
    invpd_bast_tpcd character(2),
    ininvs_bast_rw_rt numeric(12,8),
    crd_dvprd_tpcd character(2),
    cds_tpcd character(2),
    crdp_bas_aset_tpcd character(2),
    crdp_bast_rw_rt numeric(12,8),
    mst_ofset_yn character(1),
    bdopev_mgn_adj_yn character(1),
    fit_lnd_scrt_yn character(1),
    hrsk_cre_rec_yn character(1),
    spfn_prf_wgt_apyn character(1),
    acl_id character(20),
    xps_stcd character(1),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone,
    bic_cd character(11),
    lc_opnbk_bic_cd character(11),
    col_yn character(1),
    dfct_yn character(1),
    aptr_wgt_rt numeric(12,8),
    bdsys_dscd character(2),
    acc_bas_biz_hq_cd character(3),
    cus_bas_biz_hq_cd character(3),
    prd_col_rt_tgt_yn character(1),
    lc_buy_dscd character(2),
    rq_mgg_aloc_rk numeric(9,0),
    prm_rt numeric(12,8),
    rc_cus_dscd character(1),
    cd_pol_prd_dscd character(1),
    dshtm_bl numeric(18,3),
    gen_bdr_am numeric(18,3),
    spc_bdr_am numeric(18,3),
    lnk_com_cd character(8)
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.hum421tf_ori OWNER TO letl;

--
-- Name: hum493tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum493tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    bas_aset_id character(45) NOT NULL,
    xps_id character(30) NOT NULL,
    scrt_itm_cd character(12),
    fbnd_isin_cd_txt character(15),
    bnd_kdcd character(2),
    isupe_corpno character(13),
    cur_cd character(3),
    krw_xc_face_am numeric(18,3),
    krw_xc_bl numeric(18,3),
    bas_aset_xpdt character(10),
    xps_srviv_xpr_ycn numeric(10,4),
    bast_oei_cd character(2),
    bast_otcrrk_txt character(10),
    nbis_dat_src_dscd character(2),
    db_chg_ts timestamp(6) without time zone,
    evl_am numeric(18,3),
    evl_crcd character(3),
    krw_xc_evl_am numeric(18,3),
    prm_rt numeric(12,8)
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.hum493tm OWNER TO letl;

--
-- Name: hum4b2tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum4b2tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    wk_bsdt character(10) NOT NULL,
    scnr_id character(5) NOT NULL,
    rwa_cal_id character(42) NOT NULL,
    std_aset_clas_cd character(5) NOT NULL,
    in_rk_aset_clas_cd character(5) NOT NULL,
    std_ead_am numeric(18,3),
    firb_ead_am numeric(18,3),
    airb_ead_am numeric(18,3),
    std_ccf_cd character(2),
    firb_ccf_cd character(2),
    lmt_ln_tp_gcfcd character(1),
    lmt_ln_tp_scfcd character(3),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (scnr_id ,rwa_cal_id);


ALTER TABLE sdmin.hum4b2tm OWNER TO letl;

--
-- Name: hum4b2tm_ori; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum4b2tm_ori (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    scnr_id character(5),
    rwa_cal_id character(42),
    std_aset_clas_cd character(5),
    in_rk_aset_clas_cd character(5),
    std_ead_am numeric(18,3),
    firb_ead_am numeric(18,3),
    airb_ead_am numeric(18,3),
    std_ccf_cd character(2),
    firb_ccf_cd character(2),
    lmt_ln_tp_gcfcd character(1),
    lmt_ln_tp_scfcd character(3),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (scnr_id ,rwa_cal_id);


ALTER TABLE sdmin.hum4b2tm_ori OWNER TO letl;

--
-- Name: hum507tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum507tf (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    oist_crdrk_dscd character(1) NOT NULL,
    corp_no character(13) NOT NULL,
    std_ctp_tpcd character(3) NOT NULL,
    evl_dt character(10) NOT NULL,
    oist_evl_ist_cd character(2),
    oist_crdrk_txt character(10),
    rsk_wgt_rt numeric(12,8),
    std_evl_rk_cd character(5),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (oist_crdrk_dscd ,corp_no ,std_ctp_tpcd);


ALTER TABLE sdmin.hum507tf OWNER TO letl;

--
-- Name: hum508tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum508tf (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    oist_crdrk_dscd character(1) NOT NULL,
    nat_cd character(2) NOT NULL,
    std_ctp_tpcd character(3) NOT NULL,
    oist_evl_ist_cd character(2),
    oist_crdrk_txt character(10),
    evl_dt character(10) NOT NULL,
    std_evl_rk_cd character(5),
    rsk_wgt_rt numeric(12,8),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (oist_crdrk_dscd ,nat_cd ,std_ctp_tpcd);


ALTER TABLE sdmin.hum508tf OWNER TO letl;

--
-- Name: hum516tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum516tf (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    scrt_itm_cd character(12) NOT NULL,
    oist_crdrk_dscd character(1) NOT NULL,
    std_ctp_tpcd character(3) NOT NULL,
    evl_dt character(10) NOT NULL,
    scrt_rk_dscd character(1) NOT NULL,
    oist_evl_ist_cd character(2),
    oist_crdrk_txt character(10),
    std_evl_rk_cd character(5),
    rsk_wgt_rt numeric(12,8),
    isu_ist_corpno character(13) NOT NULL,
    crd_mtg_adj_yn character(1),
    stm_crdrk_yn character(1),
    prn_lmt_crd_evl_yn character(1),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (scrt_itm_cd);


ALTER TABLE sdmin.hum516tf OWNER TO letl;

--
-- Name: hum701tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE hum701tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    ctp_id character(20) NOT NULL,
    psbz_dscd character(2) NOT NULL,
    in_rk_ctp_tpcd character(3) NOT NULL,
    std_ctp_tpcd character(3) NOT NULL,
    psbz_no character(13),
    psco_rgno character(13),
    bic_cd character(11),
    trn_cpt_nm character varying(200),
    cosiz_cd character(2),
    co_kdcd character(2),
    tot_aset_am numeric(18,3),
    tot_sal_am numeric(18,3),
    nat_cd character(2),
    std_inds_cfcd character(5),
    aff_cd character(6),
    hoff_loc_zip_cd character(6),
    dom_rsdpe_yn character(1),
    onac_ofset_ctr_yn character(1),
    dvprd_ofset_ctr_yn character(1),
    core_mkt_entpe_yn character(1),
    fst_ln_rq_dt character(10),
    spc_dscd character(1),
    spc_law_bld_dt character(10),
    nbis_dat_src_dscd character(2) NOT NULL,
    del_yn character(1),
    db_chg_ts timestamp(6) without time zone,
    corpno_yn character(1)
) DISTRIBUTED BY (ctp_id);


ALTER TABLE sdmin.hum701tm OWNER TO letl;

--
-- Name: ifgl_bsw_day; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ifgl_bsw_day (
    bas_dt character varying(8) NOT NULL,
    dacc_isubr_cd character varying(3) NOT NULL,
    coa_cd character varying(11) NOT NULL,
    fncpd_cfcd character varying(2) NOT NULL,
    uni_cd character varying(2) NOT NULL,
    fnd_cd character varying(2) NOT NULL,
    tday_bl numeric(18,0) DEFAULT 0,
    bdy_bl numeric(18,0) DEFAULT 0,
    dmn_acm numeric(18,0) DEFAULT 0,
    dmn_avgbl numeric(18,0) DEFAULT 0,
    dbt_csh_slip_cn numeric(10,0) DEFAULT 0,
    dbt_csh_trn_am numeric(18,0) DEFAULT 0,
    dbt_trf_slip_cn numeric(10,0) DEFAULT 0,
    dbt_trf_trn_am numeric(18,0) DEFAULT 0,
    crd_csh_slip_cn numeric(10,0) DEFAULT 0,
    crd_csh_trn_am numeric(18,0) DEFAULT 0,
    crd_trf_slip_cn numeric(10,0) DEFAULT 0,
    crd_trf_trn_am numeric(18,0) DEFAULT 0,
    lchg_dh date DEFAULT ('now'::text)::date
) DISTRIBUTED BY (coa_cd);


ALTER TABLE sdmin.ifgl_bsw_day OWNER TO letl;

--
-- Name: ifgl_bsw_mon; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ifgl_bsw_mon (
    bas_dt character varying(8) NOT NULL,
    dacc_isubr_cd character varying(3) NOT NULL,
    coa_cd character varying(11) NOT NULL,
    fncpd_cfcd character varying(2) NOT NULL,
    uni_cd character varying(2) NOT NULL,
    fnd_cd character varying(2) NOT NULL,
    rvs_be1m_bl numeric(18,0) DEFAULT 0,
    rvs_bmn_m_acm numeric(18,0) DEFAULT 0,
    rvs_bmn_m_avgbl numeric(18,0) DEFAULT 0,
    rvs_ftrm_m_acm numeric(18,0) DEFAULT 0,
    rvs_ftrm_m_avgbl numeric(18,0) DEFAULT 0,
    rvs_am numeric(18,0) DEFAULT 0,
    dbt_dmn_slip_cn numeric(10,0) DEFAULT 0,
    dbt_dmn_trn_am numeric(18,0) DEFAULT 0,
    dbt_fstm_slip_cn numeric(10,0) DEFAULT 0,
    dbt_fstm_tramt numeric(18,0) DEFAULT 0,
    crd_dmn_slip_cn numeric(10,0) DEFAULT 0,
    crd_dmn_trn_am numeric(18,0) DEFAULT 0,
    crd_fstm_slip_cn numeric(10,0) DEFAULT 0,
    crd_fstm_tramt numeric(18,0) DEFAULT 0,
    rcls_rvs_af_dmn_acm numeric(18,0) DEFAULT 0,
    rcls_rvs_af_dmn_avgbl numeric(18,0) DEFAULT 0,
    rcls_rvs_af_fstm_acm numeric(18,0) DEFAULT 0,
    rcls_rvs_af_fstm_avgbl numeric(18,0) DEFAULT 0,
    lchg_dh date DEFAULT ('now'::text)::date
) DISTRIBUTED BY (coa_cd);


ALTER TABLE sdmin.ifgl_bsw_mon OWNER TO letl;

--
-- Name: ifgl_bsw_mon_v; Type: VIEW; Schema: sdmin; Owner: letl
--

CREATE VIEW ifgl_bsw_mon_v AS
    SELECT ifgl_bsw_mon.bas_dt, ifgl_bsw_mon.coa_cd, ifgl_bsw_mon.fncpd_cfcd, sum(ifgl_bsw_mon.rvs_be1m_bl) AS rvs_be1m_bl, sum(ifgl_bsw_mon.rvs_am) AS rvs_am, sum(ifgl_bsw_mon.rvs_bmn_m_avgbl) AS rvs_bmn_m_avgbl FROM ifgl_bsw_mon GROUP BY ifgl_bsw_mon.bas_dt, ifgl_bsw_mon.coa_cd, ifgl_bsw_mon.fncpd_cfcd;


ALTER TABLE sdmin.ifgl_bsw_mon_v OWNER TO letl;

--
-- Name: ifgl_coa_tbl; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ifgl_coa_tbl (
    coa_cd text NOT NULL,
    higrk_coa_cd text NOT NULL,
    coa_cd_lvl_attr_cd character varying(1) NOT NULL,
    fnote_yn character varying(1),
    dbcr_yn character varying(1),
    coa_cd_krw_attr_cd character varying(1) NOT NULL,
    coa_cd_onl_attr_cd character varying(1) NOT NULL,
    rel_pl_coa_cd character varying(11),
    dbt_coacc_coa_cd character varying(11),
    crd_dbcr_coa_cd character varying(11),
    in_lvl_attr_cd character varying(1),
    rgs_dt character varying(8) NOT NULL,
    abol_dt character varying(8),
    coa_abb_nm character varying(50),
    coa_nm character varying(50) NOT NULL,
    bl_dscd character varying(1) NOT NULL,
    sort_seq_num numeric(10,2) NOT NULL,
    bk_trt_bs_is_dscd character varying(1) NOT NULL,
    prd_yn character varying(1),
    scrn_indt_num numeric(5,0) NOT NULL,
    lchg_dh date DEFAULT ('now'::text)::date,
    mrgn_rt_tgt_yn character varying(1),
    mapg_tp_cd character varying(1),
    am_chg_dis_cd character varying(1)
) DISTRIBUTED BY (coa_cd);


ALTER TABLE sdmin.ifgl_coa_tbl OWNER TO letl;

--
-- Name: ifgl_coa_tbl_b9; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ifgl_coa_tbl_b9 (
    coa_cd text NOT NULL,
    higrk_coa_cd text NOT NULL,
    coa_cd_lvl_attr_cd character varying(1) NOT NULL,
    fnote_yn character varying(1),
    dbcr_yn character varying(1),
    coa_cd_krw_attr_cd character varying(1) NOT NULL,
    coa_cd_onl_attr_cd character varying(1) NOT NULL,
    rel_pl_coa_cd character varying(11),
    dbt_coacc_coa_cd character varying(11),
    crd_dbcr_coa_cd character varying(11),
    in_lvl_attr_cd character varying(1),
    rgs_dt character varying(8) NOT NULL,
    abol_dt character varying(8),
    coa_abb_nm character varying(50),
    coa_nm character varying(50) NOT NULL,
    bl_dscd character varying(1) NOT NULL,
    sort_seq_num numeric(10,2) NOT NULL,
    bk_trt_bs_is_dscd character varying(1) NOT NULL,
    prd_yn character varying(1),
    scrn_indt_num numeric(5,0) NOT NULL,
    lchg_dh date DEFAULT ('now'::text)::date,
    mrgn_rt_tgt_yn character varying(1),
    mapg_tp_cd character varying(1),
    am_chg_dis_cd character varying(1)
) DISTRIBUTED BY (coa_cd);


ALTER TABLE sdmin.ifgl_coa_tbl_b9 OWNER TO letl;

--
-- Name: ifgl_isw_day; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ifgl_isw_day (
    bas_dt character varying(8) NOT NULL,
    dacc_isubr_cd character varying(3) NOT NULL,
    coa_cd character varying(11) NOT NULL,
    fncpd_cfcd character varying(2) NOT NULL,
    uni_cd character varying(2) NOT NULL,
    fnd_cd character varying(2) NOT NULL,
    tday_bl numeric(18,0) DEFAULT 0,
    bdy_bl numeric(18,0) DEFAULT 0,
    dbt_csh_slip_cn numeric(10,0) DEFAULT 0,
    dbt_csh_trn_am numeric(18,0) DEFAULT 0,
    dbt_trf_slip_cn numeric(10,0) DEFAULT 0,
    dbt_trf_trn_am numeric(18,0) DEFAULT 0,
    crd_csh_slip_cn numeric(10,0) DEFAULT 0,
    crd_csh_trn_am numeric(18,0) DEFAULT 0,
    crd_trf_slip_cn numeric(10,0) DEFAULT 0,
    crd_trf_trn_am numeric(18,0) DEFAULT 0,
    lchg_dh date DEFAULT ('now'::text)::date
) DISTRIBUTED BY (coa_cd);


ALTER TABLE sdmin.ifgl_isw_day OWNER TO letl;

--
-- Name: ifgl_isw_mon; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ifgl_isw_mon (
    bas_dt character varying(8) NOT NULL,
    dacc_isubr_cd character varying(3) NOT NULL,
    coa_cd character varying(11) NOT NULL,
    fncpd_cfcd character varying(2) NOT NULL,
    uni_cd character varying(2) NOT NULL,
    fnd_cd character varying(2) NOT NULL,
    emn_bl numeric(18,0) DEFAULT 0,
    rvs_am numeric(18,0) DEFAULT 0,
    dbt_dmn_slip_cn numeric(10,0) DEFAULT 0,
    dbt_dmn_trn_am numeric(18,0) DEFAULT 0,
    dbt_fstm_slip_cn numeric(10,0) DEFAULT 0,
    dbt_fstm_trn_am numeric(18,0) DEFAULT 0,
    crd_dmn_slip_cn numeric(10,0) DEFAULT 0,
    crd_dmn_trn_am numeric(18,0) DEFAULT 0,
    crd_fstm_slip_cn numeric(10,0) DEFAULT 0,
    crd_fstm_trn_am numeric(18,0) DEFAULT 0,
    lchg_dh date DEFAULT ('now'::text)::date
) DISTRIBUTED BY (coa_cd);


ALTER TABLE sdmin.ifgl_isw_mon OWNER TO letl;

--
-- Name: intratrace; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE intratrace (
    ttime character varying(14) NOT NULL,
    tuserid character varying(20) NOT NULL,
    tuserip character varying(40) NOT NULL,
    tusersec character varying(1) NOT NULL,
    trepname character varying(100),
    trepsec character varying(1),
    treptype character varying(1),
    tquery character varying(100)
) DISTRIBUTED BY (ttime);


ALTER TABLE sdmin.intratrace OWNER TO letl;

--
-- Name: lcx_hal_tot; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE lcx_hal_tot (
    lcxbi_gijun character(8),
    lcxbi_cifno character(13),
    lcxbi_snno character(12),
    lcxbi_mlno character(12),
    lcxbi_no numeric(10,0),
    lcxbi_accd character varying(6),
    lcxbi_brno character(3),
    lcxbi_fund character(1),
    lcxbi_sancd character(4),
    lcxbi_sancd1 character(4),
    lcxbi_habcd character(2),
    lcxbi_form character(1),
    lcxbi_ac_seq character varying(1),
    lcxbi_amt numeric(15,0),
    lcxbi_last_amt numeric(15,0),
    lcxbi_ml_gdno character(12),
    lcxbi_you_damamt numeric(15,0),
    lcxbi_last_you_damamt numeric(15,0),
    lcxbi_bis_rate numeric(3,0),
    lcxbi_jasan_amt numeric(15,0),
    lcxbi_hal_amt numeric(15,0),
    lcxbi_mlkindcd character(3),
    lcxbi_mlkindnm character varying(40),
    lcxbi_yd_gbnm character varying(30),
    lcxbi_0 numeric(15,0),
    lcxbi_10 numeric(15,0),
    lcxbi_20 numeric(15,0),
    lcxbi_50 numeric(15,0),
    lcxbi_55 numeric(15,0),
    lcxbi_100 numeric(15,0),
    lcxbi_mi_amt numeric(15,0),
    lcxbi_mi_0 numeric(15,0),
    lcxbi_mi_10 numeric(15,0),
    lcxbi_mi_20 numeric(15,0),
    lcxbi_mi_50 numeric(15,0),
    lcxbi_mi_55 numeric(15,0),
    lcxbi_mi_100 numeric(15,0)
) DISTRIBUTED BY (lcxbi_cifno);


ALTER TABLE sdmin.lcx_hal_tot OWNER TO letl;

--
-- Name: ld005tc; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ld005tc (
    mgg_kdcd character(3) NOT NULL,
    aply_sdt character(8),
    mgg_kdcn character varying(50),
    mgg_kdcd_des character varying(250),
    sys_evl_yn character(1),
    scrn_mrk_yn character(1),
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19)
) DISTRIBUTED BY (mgg_kdcd);


ALTER TABLE sdmin.ld005tc OWNER TO letl;

--
-- Name: ld030tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ld030tm (
    mgg_no character(12) NOT NULL,
    mgg_stcd character(2),
    mgg_dscd character(2),
    mmgg_cd character(5),
    mmgg_kdcd character(3),
    mgg_musg_cd character(2),
    fst_mgg_no character(12),
    ln_cslt_no character(7),
    rgs_dt character(8),
    can_dt character(8),
    jbf_mgg_stcd character(2),
    mgg_can_rsn_cd character(2),
    frm_mgg_dscd character(1),
    rps_ownpe_psbz_no character(13),
    rps_ownpe_nm character varying(40),
    pub_own_yn character(1) DEFAULT 'N'::bpchar,
    loc_zip_cd character(6),
    mgg_loc_ad character varying(100),
    mgg_mngbr_cd character(3),
    mgg_fit_lnm_yn character(1),
    mgg_acq_dscd character(1),
    old_prd_kdcd character(2),
    tp_dbtpe_psbz_no character(13) NOT NULL,
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    conn_mgg_no character(12)
) DISTRIBUTED BY (mgg_no);


ALTER TABLE sdmin.ld030tm OWNER TO letl;

--
-- Name: ld061tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ld061tm (
    ln_apv_no character(12) NOT NULL,
    mgg_no character(12) NOT NULL,
    mgg_his_no character(3) NOT NULL,
    pldg_est_trn_dscd character(1) NOT NULL,
    dbtpe_psbz_no character(13) NOT NULL,
    ownpe_psbz_no character(13),
    dpsin_acno character varying(20),
    pldg_crcd character(2),
    est_dt character(8),
    pldg_est_am numeric(18,3),
    can_dt character(8),
    pldg_can_am numeric(18,3),
    rck_dt character(8),
    trnpe_emp_no character(6),
    apv_emp_no character(6),
    trn_br_cd character(3),
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    pt_wgrn_hld_yn character(1),
    pldg_rvk_obj_cd character(1)
) DISTRIBUTED BY (mgg_no);


ALTER TABLE sdmin.ld061tm OWNER TO letl;

--
-- Name: ln050tm_l; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln050tm_l (
    mgg_no character(12)
) DISTRIBUTED BY (mgg_no);


ALTER TABLE sdmin.ln050tm_l OWNER TO letl;

--
-- Name: ln774tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln774tm (
    bas_dt character(8) NOT NULL,
    exe_srno numeric(5,0) NOT NULL,
    dbtpe_psbz_no character(13) NOT NULL,
    mgg_no character(12) NOT NULL,
    mgg_stcd character(2),
    mgg_dscd character(2),
    mmgg_cd character(5),
    mmgg_kdcd character(3),
    mgg_musg_cd character(2),
    frm_mgg_dscd character(1),
    mgg_fit_lnm_yn character(1),
    mgg_mngbr_cd character(3),
    krw_xc_est_am numeric(18,0),
    krw_xc_apr_pr numeric(18,0),
    krw_xc_insp_pr numeric(18,0),
    krw_xc_rgl_mgg_pr numeric(18,0),
    krw_xc_cur_val_evl_am numeric(18,0),
    krw_xc_est_bas_mgg_pr numeric(18,0),
    krw_xc_vld_mgg_pr numeric(18,0),
    krw_xc_col_fcst_mgg_pr numeric(18,0),
    old_prd_kdcd character(2),
    actl_rnt_am numeric(18,0),
    fst_rpy_am numeric(18,0),
    pri_rpy_bnd_am numeric(18,0),
    isu_dt character(8),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    lst_load_dt character(8)
) DISTRIBUTED BY (mgg_no);


ALTER TABLE sdmin.ln774tm OWNER TO letl;

--
-- Name: ln774tm_temp; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln774tm_temp (
    bas_dt character(8) NOT NULL,
    exe_srno numeric(5,0) NOT NULL,
    dbtpe_psbz_no character(13) NOT NULL,
    mgg_no character(12) NOT NULL,
    mgg_stcd character(2),
    mgg_dscd character(2),
    mmgg_cd character(5),
    mmgg_kdcd character(3),
    mgg_musg_cd character(2),
    frm_mgg_dscd character(1),
    mgg_fit_lnm_yn character(1),
    mgg_mngbr_cd character(3),
    krw_xc_est_am numeric(18,0),
    krw_xc_apr_pr numeric(18,0),
    krw_xc_insp_pr numeric(18,0),
    krw_xc_rgl_mgg_pr numeric(18,0),
    krw_xc_cur_val_evl_am numeric(18,0),
    krw_xc_est_bas_mgg_pr numeric(18,0),
    krw_xc_vld_mgg_pr numeric(18,0),
    krw_xc_col_fcst_mgg_pr numeric(18,0),
    old_prd_kdcd character(2),
    actl_rnt_am numeric(18,0),
    fst_rpy_am numeric(18,0),
    pri_rpy_bnd_am numeric(18,0),
    isu_dt character(8),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    lst_load_dt character(8)
) DISTRIBUTED BY (mgg_no);


ALTER TABLE sdmin.ln774tm_temp OWNER TO letl;

--
-- Name: ln805th; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln805th (
    bas_dt character(8) NOT NULL,
    act_no character varying(20) NOT NULL,
    actbr_cd character(3),
    acc_dscd character(2),
    acc_cd character(6),
    cur_cd character(2),
    psbz_no character(13),
    int_col_cn character(1),
    actv_yn character(1),
    ctr_can_yn character(1),
    can_yn character(1),
    nml_flpay_yn character(1),
    reln_flpay_yn character(1),
    mdf_flpay_yn character(1),
    pxpay_flpay_yn character(1),
    tjur_flpay_yn character(1),
    ofset_flpay_yn character(1),
    dprc_sbnd_ent_flpay_yn character(1),
    tbil_dc_flpay_yn character(1),
    itg_flpay_yn character(1),
    dcbil_at_aloc_yn character(1),
    kamc_disp_yn character(1),
    ntrth_ln_unt_trt_yn character(1),
    abs_isu_tgtac_yn character(1),
    pt_rpy_pln_dfncy_yn character(1),
    old_exe_his_dfncy_yn character(1),
    eqv_prn_nrpy_dfncy_yn character(1),
    ldg_irt_ifofr_yn character(1),
    ical_yn character(1),
    a_cs_tgtac_mk_xcp_yn character(1),
    irt_flt_brw_tgt_yn character(1),
    c2_pri_sup_fnd_rpt_yn character(1),
    bok_trmny_fr_ln_yn character(1),
    xtn_rec_xst_yn character(1),
    rewrt_rec_xst_yn character(1),
    irt_grnfe_chg_yn character(1),
    itg_mitg_xst_yn character(1),
    dfr_rt_chg_yn character(1),
    irt_unchg_brw_tgt_yn character(1),
    adcol_int_xst_yn character(1),
    rfnd_int_xst_yn character(1),
    kcgf_sbgt_rpy_act_yn character(1),
    dvam_rcp_act_yn character(1),
    ical_imp_act_yn character(1),
    dcbil_dsh_yn character(1),
    dcbil_nstl_yn character(1),
    prv_sgov_ncol_rvs_yn character(1),
    brw_lnrpy_avl_act_yn character(1),
    ofemp_act_yn character(1),
    cpsdp_pfirt_col_yn character(1),
    tjrj_rel_act_yn character(1),
    dsoff_act_yn character(1),
    rpy_ferdu_act_yn character(1),
    imxp_lnk_exe_act_yn character(1),
    tfnc_by_xtn_act_yn character(1),
    saf_ctrct_prv_sgov_yn character(1),
    inflw_prd_auct_acp_fnd_act_yn character(1),
    sm_urg_spc_fnd_act_yn character(1),
    fst_kcgf_sbgt_rpy_yn character(1),
    apv_no character(12),
    lst_trn_srno numeric(3,0),
    lnk_acno character varying(20),
    leas_com_rdmpe_siz_cd character(1),
    inet_ln_exe_yn character(1),
    crd_insu_act_yn character(1),
    cls_not_rvs_act_yn character(1),
    pur_fnc_by_tmxtn_yn character(1),
    tmpft_los_hld_ntc_yn character(1),
    tmpft_los_grnpe_ntc_yn character(1),
    col_delg_rgs_yn character(1),
    lnk_trno character(3),
    grp_no character(2),
    old_exe_apv_no character(12),
    old_exe_acno character varying(20),
    bil_no character(12),
    lndl_fecol_am numeric(18,0),
    alcrg_am numeric(18,0),
    bzctg_adirt numeric(7,4),
    bil_insu_stc_am numeric(18,0),
    rel_lc_no character(15),
    fnd_brw_agn_fee_am numeric(18,3),
    tbil_irt_aply_bsdt character(8),
    brw_no character(6),
    brw_am numeric(18,3),
    exe_am numeric(18,3),
    exe_cur_bl numeric(18,3),
    prnrp_acam numeric(18,0),
    apv_xc_rt numeric(15,8),
    pgrn_apv_rt numeric(15,8),
    xch_rt numeric(7,2),
    ncol_int_am numeric(18,3),
    exe_dt character(8),
    op_dt character(8),
    rt_aply_bsdt character(8),
    lst_trn_invs_dt character(8),
    fst_agr_fxdt character(8),
    vld_agr_fxdt character(8),
    sq_tms_rpy_dt character(8),
    evrtm_intpi_ym character(6),
    intpi_itv_mcn numeric(2,0),
    evrtm_intpi_dy character(2),
    lst_ircv_dt character(8),
    int_ppay_dcn numeric(3,0),
    dfr_irt_aply_dt character(8),
    bil_fxdt character(8),
    lst_dfr_ircv_dt character(8),
    lst_intdf_ircv_dt character(8),
    cshtf_dscd character(1),
    acc_mdf_mtd_cd character(1),
    fndus_cd character(2),
    new_uni_op_dscd character(3),
    old_uni_op_dscd character(3),
    prnrp_mtd_cd character(2),
    intpi_mtd_cd character(2),
    irt_cd character(3),
    irt_grnfe_fee_rt numeric(7,4),
    dc_ovr_irt numeric(7,4),
    lnam_trbok_isu_yn character(1),
    pbok_licn numeric(2,0),
    npbok_trn_rec_cn numeric(3,0),
    fnd_cd character(2),
    wpgrn_isu_yn character(1),
    grn_cptco_cd character(4),
    grn_cptco_nm character(20),
    leas_com_rdmpe_usg_cd character(2),
    itg_dscd character(1),
    rept_cn numeric(3,0),
    xps_id character(12),
    rel_acno character varying(20),
    cus_dscd character(2),
    lst_load_dt character(8),
    hrpy_ferdu_no character(2),
    hedg_tgt_yn character(1),
    fnc_prd_ctgr_cd character(2),
    prgwk_val_cd character(2),
    onld_crd_div_rt numeric(7,4),
    act_itg_lst_srno character(3),
    pvbnd_dc_am numeric(15,0),
    ncol_ocr_am numeric(23,3),
    ncol_impo_am numeric(23,3),
    fnc_grn_yn character(1),
    dfirt_nml_irt_dt character(8),
    dfr_sdt character(8)
) DISTRIBUTED BY (act_no);


ALTER TABLE sdmin.ln805th OWNER TO letl;

--
-- Name: ln834th; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln834th (
    bas_ym character(6) NOT NULL,
    mgg_no character(12) NOT NULL,
    mgg_stcd character(2),
    mgg_dscd character(2),
    mmgg_cd character(5),
    mmgg_kdcd character(3),
    mgg_musg_cd character(2),
    fst_mgg_no character(12),
    ln_cslt_no character(7),
    rgs_dt character(8),
    can_dt character(8),
    jbf_mgg_stcd character(2),
    mgg_can_rsn_cd character(2),
    frm_mgg_dscd character(1),
    rps_ownpe_psbz_no character(13),
    rps_ownpe_nm character varying(40),
    pub_own_yn character(1) DEFAULT 'N'::bpchar,
    loc_zip_cd character(6),
    mgg_loc_ad character varying(100),
    mgg_mngbr_cd character(3),
    mgg_fit_lnm_yn character(1),
    mgg_acq_dscd character(1),
    old_prd_kdcd character(2),
    tp_dbtpe_psbz_no character(13) NOT NULL,
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    lst_load_dt character(8),
    conn_mgg_no character(12)
) DISTRIBUTED BY (rps_ownpe_psbz_no ,tp_dbtpe_psbz_no);


ALTER TABLE sdmin.ln834th OWNER TO letl;

--
-- Name: ln834th_temp; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln834th_temp (
    bas_ym character(6) NOT NULL,
    mgg_no character(12) NOT NULL,
    mgg_stcd character(2),
    mgg_dscd character(2),
    mmgg_cd character(5),
    mmgg_kdcd character(3),
    mgg_musg_cd character(2),
    fst_mgg_no character(12),
    ln_cslt_no character(7),
    rgs_dt character(8),
    can_dt character(8),
    jbf_mgg_stcd character(2),
    mgg_can_rsn_cd character(2),
    frm_mgg_dscd character(1),
    rps_ownpe_psbz_no character(13),
    rps_ownpe_nm character varying(40),
    pub_own_yn character(1),
    loc_zip_cd character(6),
    mgg_loc_ad character varying(100),
    mgg_mngbr_cd character(3),
    mgg_fit_lnm_yn character(1),
    mgg_acq_dscd character(1),
    old_prd_kdcd character(2),
    tp_dbtpe_psbz_no character(13) NOT NULL,
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    lst_load_dt character(8),
    conn_mgg_no character(12)
) DISTRIBUTED BY (rps_ownpe_psbz_no ,tp_dbtpe_psbz_no);


ALTER TABLE sdmin.ln834th_temp OWNER TO letl;

--
-- Name: ln836th; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln836th (
    bas_ym character(6) NOT NULL,
    mgg_no character(12) NOT NULL,
    mgg_his_no character(3) NOT NULL,
    mgg_stcd character(2),
    mgg_cd character(5) NOT NULL,
    mgg_dscd character(2),
    mgg_kdcd character(3),
    mgg_usg_cd character(2),
    mgg_ref_cd character(2),
    prdf_ocp_dscd character(2),
    dpr_xcp_yn character(1),
    asgn_mgg_yn character(1),
    bmgg_yn character(1),
    cistg_yn character(1),
    mgg_crcd character(2),
    mgg_cn numeric(18,3),
    mgg_cn_unt_cd character(2),
    dfacq_mgg_acq_pln_dt character(8),
    isu_dt character(8),
    xpr_dt character(8),
    apr_dt character(8),
    insp_dt character(8),
    can_dt character(8),
    fst_dl_dt character(8),
    mgg_can_rsn_cd character(2),
    apr_pr numeric(18,3) DEFAULT 0,
    insp_aply_rt numeric(7,3) DEFAULT 0,
    insp_pr numeric(18,3) DEFAULT 0,
    tbk_mgg_rcog_rt numeric(7,3),
    rgl_mgg_pr numeric(18,3),
    apr_ist_cd character(2),
    apr_ist_corpno character(13),
    apr_ist_crdrk_nm character varying(10),
    evl_src_dscd character(2),
    txt_ycn numeric(5,0),
    pas_tm_ycn numeric(5,0),
    mgg_fit_lnm_yn character(1),
    insp_chrpe_emp_no character(6),
    insp_txt character varying(250),
    old_mgg_kdcd character(3),
    old_mgg_clf_cd character(3),
    old_aply_usg_cd character(3),
    thdpt_mgg_dscd character(2),
    evldoc_no character varying(20),
    bdpv_cd character(2),
    mgg_dtl_usg_cd character(3),
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    lst_load_dt character(8),
    ownpe_psbz_no character(13),
    ownpe_nm character varying(40),
    hld_rel_cd character(2),
    mgr_no character(6),
    dbt_acp_est_rgs_dt character(8),
    pub_own_yn character(1)
) DISTRIBUTED BY (mgg_no);


ALTER TABLE sdmin.ln836th OWNER TO letl;

--
-- Name: ln836th_temp; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln836th_temp (
    bas_ym character(6) NOT NULL,
    mgg_no character(12) NOT NULL,
    mgg_his_no character(3) NOT NULL,
    mgg_stcd character(2),
    mgg_cd character(5) NOT NULL,
    mgg_dscd character(2),
    mgg_kdcd character(3),
    mgg_usg_cd character(2),
    mgg_ref_cd character(2),
    prdf_ocp_dscd character(2),
    dpr_xcp_yn character(1),
    asgn_mgg_yn character(1),
    bmgg_yn character(1),
    cistg_yn character(1),
    mgg_crcd character(2),
    mgg_cn numeric(18,3),
    mgg_cn_unt_cd character(2),
    dfacq_mgg_acq_pln_dt character(8),
    isu_dt character(8),
    xpr_dt character(8),
    apr_dt character(8),
    insp_dt character(8),
    can_dt character(8),
    fst_dl_dt character(8),
    mgg_can_rsn_cd character(2),
    apr_pr numeric(18,3),
    insp_aply_rt numeric(7,3),
    insp_pr numeric(18,3),
    tbk_mgg_rcog_rt numeric(7,3),
    rgl_mgg_pr numeric(18,3),
    apr_ist_cd character(2),
    apr_ist_corpno character(13),
    apr_ist_crdrk_nm character varying(10),
    evl_src_dscd character(2),
    txt_ycn numeric(5,0),
    pas_tm_ycn numeric(5,0),
    mgg_fit_lnm_yn character(1),
    insp_chrpe_emp_no character(6),
    insp_txt character varying(250),
    old_mgg_kdcd character(3),
    old_mgg_clf_cd character(3),
    old_aply_usg_cd character(3),
    thdpt_mgg_dscd character(2),
    evldoc_no character varying(20),
    bdpv_cd character(2),
    mgg_dtl_usg_cd character(3),
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    lst_load_dt character(8),
    ownpe_psbz_no character(13),
    ownpe_nm character varying(40),
    hld_rel_cd character(2),
    mgr_no character(6),
    dbt_acp_est_rgs_dt character(8),
    pub_own_yn character(1)
) DISTRIBUTED BY (mgg_no);


ALTER TABLE sdmin.ln836th_temp OWNER TO letl;

--
-- Name: ln840th; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln840th (
    bas_ym character(6) NOT NULL,
    mgg_no character(12) NOT NULL,
    mgg_his_no character(3) NOT NULL,
    wgrn_no character varying(30),
    wgrn_isu_ist_cd character(3),
    wgrn_isu_ist_tpcd character(2),
    isu_com_nm character varying(40),
    isu_dt character(8),
    face_pr numeric(18,3) DEFAULT 0,
    grn_rt numeric(7,3),
    grn_cnd_txt character varying(1024),
    tbk_isu_yn character(1),
    grn_lnexe_dt character(8),
    obk_acno character varying(20),
    grn_ist_br_nm character varying(40),
    est_mtd_dscd character(2),
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    lst_load_dt character(8),
    wgrn_can_cnd_yn character(1),
    elt_mtd_rcp_yn character(1)
) DISTRIBUTED BY (mgg_no);


ALTER TABLE sdmin.ln840th OWNER TO letl;

--
-- Name: ln840th_temp; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln840th_temp (
    bas_ym character(6) NOT NULL,
    mgg_no character(12) NOT NULL,
    mgg_his_no character(3) NOT NULL,
    wgrn_no character varying(30),
    wgrn_isu_ist_cd character(3),
    wgrn_isu_ist_tpcd character(2),
    isu_com_nm character varying(40),
    isu_dt character(8),
    face_pr numeric(18,3),
    grn_rt numeric(7,3),
    grn_cnd_txt character varying(1024),
    tbk_isu_yn character(1),
    grn_lnexe_dt character(8),
    obk_acno character varying(20),
    grn_ist_br_nm character varying(40),
    est_mtd_dscd character(2),
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    lst_load_dt character(8),
    wgrn_can_cnd_yn character(1),
    elt_mtd_rcp_yn character(1)
) DISTRIBUTED BY (mgg_no);


ALTER TABLE sdmin.ln840th_temp OWNER TO letl;

--
-- Name: ln848th; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln848th (
    bas_ym character(6) NOT NULL,
    mgg_no character(12) NOT NULL,
    mgg_est_no character(10) NOT NULL,
    est_srno character(3),
    mgg_est_rk numeric(4,0),
    rgs_dt character(8),
    can_dt character(8),
    mgg_est_lnk_stcd character(2),
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    lst_load_dt character(8)
) DISTRIBUTED BY (mgg_est_no);


ALTER TABLE sdmin.ln848th OWNER TO letl;

--
-- Name: ln848th_temp; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln848th_temp (
    bas_ym character(6) NOT NULL,
    mgg_no character(12) NOT NULL,
    mgg_est_no character(10) NOT NULL,
    est_srno character(3),
    mgg_est_rk numeric(4,0),
    rgs_dt character(8),
    can_dt character(8),
    mgg_est_lnk_stcd character(2),
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    lst_load_dt character(8)
) DISTRIBUTED BY (mgg_est_no);


ALTER TABLE sdmin.ln848th_temp OWNER TO letl;

--
-- Name: ln850th; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln850th (
    bas_ym character(6) NOT NULL,
    dbtpe_psbz_no character(13) NOT NULL,
    mgg_no character(12) NOT NULL,
    itg_apv_no character(12) NOT NULL,
    mgg_acno_lnk_rk numeric(4,0),
    rgs_dt character(8),
    can_dt character(8),
    mgg_ln_lnk_stcd character(2),
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    lst_load_dt character(8),
    kcgf_dona_alw_yn character(1)
) DISTRIBUTED BY (mgg_no);


ALTER TABLE sdmin.ln850th OWNER TO letl;

--
-- Name: ln850th_temp; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln850th_temp (
    bas_ym character(6) NOT NULL,
    dbtpe_psbz_no character(13) NOT NULL,
    mgg_no character(12) NOT NULL,
    itg_apv_no character(12) NOT NULL,
    mgg_acno_lnk_rk numeric(4,0),
    rgs_dt character(8),
    can_dt character(8),
    mgg_ln_lnk_stcd character(2),
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    lst_load_dt character(8),
    kcgf_dona_alw_yn character(1)
) DISTRIBUTED BY (mgg_no);


ALTER TABLE sdmin.ln850th_temp OWNER TO letl;

--
-- Name: ln852th; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln852th (
    bas_ym character(6) NOT NULL,
    mgg_est_no character(10) NOT NULL,
    pub_est_yn character(1),
    est_crcd character(2),
    est_am numeric(18,3) DEFAULT 0,
    est_rgtpe_nm character varying(40),
    tbk_est_yn character(1),
    est_kd_dscd character(2),
    rgs_dt character(8),
    est_dt character(8),
    xpr_dt character(8),
    can_dt character(8),
    mgg_est_br_cd character(3),
    bdpv_cd character(2),
    rmk_txt character varying(100),
    dbtpe_psbz_no character(13) NOT NULL,
    est_mtd_dscd character(2),
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    lst_load_dt character(8),
    nest_ln_est_yn character(1),
    rgs_rcp_no character(13)
) DISTRIBUTED BY (dbtpe_psbz_no);


ALTER TABLE sdmin.ln852th OWNER TO letl;

--
-- Name: ln852th_temp; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ln852th_temp (
    bas_ym character(6) NOT NULL,
    mgg_est_no character(10) NOT NULL,
    pub_est_yn character(1),
    est_crcd character(2),
    est_am numeric(18,3),
    est_rgtpe_nm character varying(40),
    tbk_est_yn character(1),
    est_kd_dscd character(2),
    rgs_dt character(8),
    est_dt character(8),
    xpr_dt character(8),
    can_dt character(8),
    mgg_est_br_cd character(3),
    bdpv_cd character(2),
    rmk_txt character varying(100),
    dbtpe_psbz_no character(13) NOT NULL,
    est_mtd_dscd character(2),
    del_yn character(1),
    lchg_emp_no character(6),
    db_chg_ts character(19),
    lst_load_dt character(8),
    nest_ln_est_yn character(1),
    rgs_rcp_no character(13)
) DISTRIBUTED BY (dbtpe_psbz_no);


ALTER TABLE sdmin.ln852th_temp OWNER TO letl;

--
-- Name: loan_day_tbl; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE loan_day_tbl (
    ldtdate character(8),
    ldtsmno character(12),
    ldtkind character(2),
    ldtcifno character(13),
    ldtbrno character(3),
    ldtaccd character(6),
    ldtsdate character(8),
    ldtgb character varying(4),
    ldtgrade character varying(10),
    ldtsmamt numeric(15,0),
    ldtsilamt numeric(15,0),
    ldtamt numeric(15,0),
    ldt1pamt numeric(15,0)
) DISTRIBUTED BY (ldtsmno);


ALTER TABLE sdmin.loan_day_tbl OWNER TO letl;

--
-- Name: loan_mn9988_code; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE loan_mn9988_code (
    std_ym character(6) NOT NULL,
    gb_cd character(3) NOT NULL,
    code1 character varying(4) NOT NULL,
    code2 character varying(3),
    cd_nm character varying(50)
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin.loan_mn9988_code OWNER TO letl;

--
-- Name: loan_mn9988_mst; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE loan_mn9988_mst (
    std_ym character(6) NOT NULL,
    seq_no numeric(7,0) NOT NULL,
    cop_no character varying(13) NOT NULL,
    cop_gb character(1),
    gigan_cd character(4),
    rpt_cd character(2),
    acc_cd character(4),
    loan_amt numeric(15,0)
) DISTRIBUTED BY (cop_no ,std_ym);


ALTER TABLE sdmin.loan_mn9988_mst OWNER TO letl;

--
-- Name: loan_rt_ms_mst; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE loan_rt_ms_mst (
    rlmsdate character varying(8),
    rlmsbrno character varying(3),
    rlmssmno character varying(12),
    rlmsacno character varying(12),
    rlmsaccd character varying(6),
    rlmsaccd1 character varying(4),
    rlmscifno character varying(13),
    rlmsosmno character varying(12),
    rlmsrate numeric(7,4),
    rlmsjemsu numeric(3,0),
    rlmsnxdt character(8),
    rlmsdamga character varying(1),
    rlmsdbamt numeric(15,0),
    rlmsiyulcd character varying(3),
    rlmsacsts character varying(1),
    rlmshejicd character varying(1),
    rlmsactsu numeric(1,0),
    rlmsfundcd character varying(1),
    rlmsfundfm character varying(1),
    rlmsamt numeric(15,0),
    rlmsamt1 numeric(15,0),
    rlmssilamt numeric(15,0),
    rlmssilamt1 numeric(15,0),
    rlmssildt character(8),
    rlmsavg numeric(15,0),
    rlmsavg1 numeric(15,0),
    rlmsform character varying(1),
    rlmsmisuam numeric(15,0),
    rlmsbocheo character varying(1),
    rlmsbhamt numeric(15,0),
    rlmsnxbdt character(8),
    rlmsbihan numeric(15,0),
    rlmssancd character varying(4),
    rlmssancd1 character varying(4),
    rlmssign character varying(1),
    rlmssuacno character varying(12),
    rlmssmamt numeric(15,0),
    rlmssmamt1 numeric(15,0),
    rlmsbonbu character varying(2),
    rlmssnkind character varying(2),
    rlmsstscd character varying(1),
    rlmshests character varying(1),
    rlmssmdate character(8),
    rlmssjgu character varying(1),
    rlmsjogcd character varying(1),
    rlmsjodat character varying(8),
    rlmssinbo character varying(1),
    rlmscramt numeric(15,0),
    rlmsyakdt character(8),
    rlmsfsyakdt character(8),
    rlmshando character varying(1),
    rlmsyterm numeric(5,1),
    rlmsyncd numeric(1,0),
    rlmsynamt numeric(15,0),
    rlmsynamt1 numeric(15,0),
    rlmssayu character varying(2),
    rlmsynsu numeric(5,0),
    rlmsyndt character(8),
    rlmsamtsa character varying(2),
    rlmssaamt numeric(15,0),
    rlmssaamt1 numeric(15,0),
    rlmschamt numeric(15,0),
    rlmschamt1 numeric(15,0),
    rlmsigap numeric(2,0),
    rlmssuamt numeric(15,0),
    rlmsisucd character varying(2),
    rlmshcamt numeric(15,0),
    rlmsimjik character varying(1),
    rlmsjagcd character varying(2),
    rlmsyongdo character varying(2),
    rlmsjabr character varying(3),
    rlmsmansu numeric(5,1),
    rlmsjencd character varying(2),
    rlmsjenman character varying(6),
    rlmsbijecd character varying(1),
    rlmsjibyear character varying(1),
    rlmsjiwon character varying(1),
    rlmsjija character varying(1),
    rlmschasts character varying(1),
    rlmsisdt character(8),
    rlmsisudt character(8),
    rlmsynijdt character(8),
    rlmstrdt character(8),
    rlmsfsdat character(8),
    rlmsmany character varying(3),
    rlmshabcd character varying(2),
    rlmsgihandt character varying(8),
    rlmssugandt character varying(8),
    rlmssugangu character varying(1),
    rlmsmunno character varying(4),
    rlmsgyolga character varying(1),
    rlmsichno character varying(12),
    rlmsichdt character varying(8),
    rlmsichhedt character varying(8),
    rlmsoldbon character varying(2),
    rlmstonggu character varying(1),
    rlmstongdt character varying(8),
    rlmssangsil character varying(8),
    rlmsbkcd character varying(4),
    rlmsexdat character varying(8),
    rlmssahab character varying(1),
    rlmssdate character varying(8),
    rlmsmaekak character varying(1),
    rlmsisacno character varying(12),
    rlmsgamyul numeric(7,4),
    rlmsbofund character varying(1),
    rlmsfundsin character varying(2),
    rlmsinsu character varying(1),
    rlmsnsuacno character varying(12),
    rlmsabs1 character varying(1),
    rlmsabs2 character varying(1),
    rlmsabsamt numeric(15,0),
    rlmsabsamt1 numeric(15,0),
    rlmssmmany character varying(3),
    rlmsinternt character(1),
    rlmschrt numeric(7,4),
    rlmsratedt character varying(8),
    rlmsspread numeric(7,4),
    rlmsgap numeric(2,0),
    rlmscssgrade character(2),
    rlmscsskind character(1),
    rlmscssjado character(1),
    rlmsworkout character(1),
    rlmssubaccd character varying(6),
    rlmssubamt numeric(15,0),
    rlmssubamt1 numeric(15,0),
    rlmsgoodscd character varying(2),
    rlmsdaeji character varying(1),
    rlmsrisk character varying(1),
    rlmsgroupln character varying(1),
    rlmsdsloan character varying(1),
    rlmssnccno character varying(12),
    rlmsempno character varying(6),
    rlmsdanbo character varying(1),
    rlmsdanbrt numeric(8,5),
    rlmsbisid character varying(12),
    rlmsexpid character varying(12),
    rlmsrelac character varying(12),
    rlmssuyul numeric(7,4),
    rlmsnaegub character varying(4),
    rlmsgoodcd1 character varying(3),
    rlmsgoodcd2 character varying(2),
    rlmshouseyn character varying(1),
    rlmshousecd character varying(2),
    rlmsolddeal character varying(1),
    rlmsnewdeal character varying(1),
    rlmsdtiyn character varying(1),
    rlmsdticode character varying(2),
    rlmsdtirate numeric(7,3),
    rlmstonggub character varying(1),
    rlmsbalno character varying(13),
    rlmsupjon character varying(5),
    rlmsmougb character(2)
) DISTRIBUTED BY (rlmscifno ,rlmsdate);


ALTER TABLE sdmin.loan_rt_ms_mst OWNER TO letl;

--
-- Name: meta_lg_log; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE meta_lg_log (
    mlgbrcd character(2) NOT NULL,
    mlgircd character(4) NOT NULL,
    mlglgtyp character(2) NOT NULL,
    mlglogtp character(1) NOT NULL,
    mlgyidnm character varying(30),
    mlgnoseg numeric(2,0),
    mlgsegco character varying(420),
    mlglq1 character(8),
    mlglq2 character(8),
    mlglq3 character(8),
    mlglq4 character(8),
    mlglq5 character(8),
    mlglq6 character(8),
    mlglq7 character(8),
    mlglq8 character(8),
    mlglq9 character(8),
    mlglq10 character(8),
    mlglq11 character(8),
    mlglq12 character(8),
    mlglq13 character(8),
    mlglq14 character(8),
    mlglq15 character(8),
    mlglq16 character(8),
    mlglq17 character(8),
    mlglq18 character(8),
    mlglq19 character(8),
    mlglq20 character(8),
    mlgdesc character varying(80),
    mlglngth numeric(8,0),
    mlggdno character(4),
    mlgcount numeric,
    mlglq4k1 character(1),
    mlglq4k2 character(1),
    mlglq4k3 character(1),
    mlglq4k4 character(1),
    mlglq4k5 character(1),
    mlglq4k6 character(1),
    mlglq4k7 character(1),
    mlglq4k8 character(1),
    mlglq4k9 character(1),
    mlglq4k10 character(1),
    mlglq4k11 character(1),
    mlglq4k12 character(1),
    mlglq4k13 character(1),
    mlglq4k14 character(1),
    mlglq4k15 character(1),
    mlglq4k16 character(1),
    mlglq4k17 character(1),
    mlglq4k18 character(1),
    mlglq4k19 character(1),
    mlglq4k20 character(1),
    mlgclodt character(8)
) DISTRIBUTED BY (mlgbrcd ,mlgircd ,mlglgtyp);


ALTER TABLE sdmin.meta_lg_log OWNER TO letl;

--
-- Name: misu_bis; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE misu_bis (
    misubrno character(3),
    misucifno character(13),
    misusmno character(12),
    misuacno character(12),
    misuaccd character(6),
    misuamt numeric(15,0)
) DISTRIBUTED BY (misusmno ,misuacno ,misucifno);


ALTER TABLE sdmin.misu_bis OWNER TO letl;

--
-- Name: ms_mst_cif; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE ms_mst_cif (
    lsmno character varying(12) NOT NULL,
    lsmcifno character varying(13)
) DISTRIBUTED BY (lsmno);


ALTER TABLE sdmin.ms_mst_cif OWNER TO letl;

--
-- Name: rt_ms_mst; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE rt_ms_mst (
    rlmsdate character varying(8) NOT NULL,
    rlmssmno character varying(12) NOT NULL,
    rlmsacno character varying(12) NOT NULL,
    rlmsaccd character varying(6),
    rlmsbrno character varying(3) NOT NULL,
    rlmscifno character varying(13),
    rlmshejicd character varying(1),
    rlmsfundcd character varying(1),
    rlmssancd character varying(4),
    rlmssancd1 character varying(4),
    rlmshabcd character varying(2),
    rlmsform character varying(1),
    rlmssmamt numeric(15,0),
    rlmsamt numeric(15,0)
) DISTRIBUTED BY (rlmsdate ,rlmscifno);


ALTER TABLE sdmin.rt_ms_mst OWNER TO letl;

--
-- Name: sf_org_user; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE sf_org_user (
    f_user_id character varying(40),
    f_user_name character varying(80),
    f_rank_id numeric(10,0),
    f_rank_name character varying(80),
    f_role_id numeric(22,0),
    f_role_name character varying(80),
    f_dept_id character varying(40),
    f_dept_name character varying(80),
    delete_gb character varying(1),
    expiry_date character varying(10)
) DISTRIBUTED BY (f_user_id);


ALTER TABLE sdmin.sf_org_user OWNER TO letl;

--
-- Name: sr002tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE sr002tm (
    user_id character(7) NOT NULL,
    psbz_no character(13),
    inet_cus_cfcd character(1),
    cus_nm character varying(50),
    mngbr_cd character(3),
    tel_no character(14),
    actv_yn character(1),
    pwerr_stp_yn character(1),
    rgs_tm_pas_stp_yn character(1),
    br_rndm_stp_yn character(1),
    can_yn character(1),
    re_ent_yn character(1),
    ebnk_cus_stcd character(2),
    acts_rq_yn character(1),
    fi_yn character(1),
    rcvac_dgn_yn character(1),
    fexem_yn character(1),
    user_id_chg_avl_yn character(1),
    cstm_rgs_yn character(1),
    psnbz_co_bnkg_rgs_yn character(1),
    fexem_cn_mng_yn character(1),
    conn_pwno_chg_dt character(8),
    ts_pwno_chg_dt character(8),
    scrt_cd_no character(8),
    opn_dt character(8),
    can_dt character(8),
    re_ent_dt character(8),
    tscus_cnv_dt character(8),
    acts_rq_dt character(8),
    fee_stl_acno character varying(20),
    rcv_mo_acno character varying(20),
    wdrac_rq_cn numeric(3,0),
    rcvac_rq_cn numeric(3,0),
    fexem_avl_cn numeric(3,0),
    dt1_tslmt_am numeric(18,0),
    tms1_tslmt_am numeric(18,0),
    lst_ts_trn_dt character(8),
    rcp_no character(7),
    evt_tm_ts_cn numeric(6,0),
    cstm_no numeric(5,0),
    ent_advpe_emp_no character(6),
    fexem_sdt character(8),
    fexem_edt character(8),
    fmbk_user_dscd character(1),
    biz_no character(13),
    lst_load_dt character(8),
    scrt_rk_wrcst_mnd_yn character(1),
    vmmb_ent_yn character(1),
    spbk_ent_yn character(1)
) DISTRIBUTED BY (psbz_no);


ALTER TABLE sdmin.sr002tm OWNER TO letl;

--
-- Name: sr010tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE sr010tm (
    ps_no character(13) NOT NULL,
    cus_nm character varying(50),
    rcp_no character(7),
    pwno_chg_dt character(8),
    tlbnk_cus_stcd character(2),
    pwerr_stp_yn character(1),
    rgs_tm_pas_stp_yn character(1),
    can_yn character(1),
    psno_chg_yn character(1),
    fexem_yn character(1),
    dgn_tel_no_rgs_yn character(1),
    mngbr_cd character(3),
    opn_dt character(8),
    can_dt character(8),
    stp_dt character(8),
    re_ent_dt character(8),
    tel_no character(14),
    fax_no character(14),
    ent_advpe_emp_no character(6),
    dt1_tslmt_am numeric(18,0),
    tms1_tslmt_am numeric(18,0),
    fexem_cn_mng_yn character(1),
    lst_ts_trn_dt character(8),
    fexem_sdt character(8),
    fexem_edt character(8),
    afchg_psno character(13),
    lst_ts_tm character(6),
    fexem_avl_cn numeric(3,0),
    scrt_cd_no character(8),
    lst_load_dt character(8),
    wdr1_acno character varying(12),
    wdr2_acno character varying(12),
    wdr3_acno character varying(12),
    wdr4_acno character varying(12),
    wdr5_acno character varying(12)
) DISTRIBUTED BY (ps_no);


ALTER TABLE sdmin.sr010tm OWNER TO letl;

--
-- Name: sr_prc_req_inf_sql; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE sr_prc_req_inf_sql (
    itm_id numeric(4,0) NOT NULL,
    req_emp_no character varying(10) NOT NULL,
    req_dtime character varying(14) NOT NULL,
    prc_rst_dscd character varying(1) DEFAULT 'N'::character varying,
    bat_prc_sql text
) DISTRIBUTED BY (itm_id ,req_emp_no ,req_dtime);


ALTER TABLE sdmin.sr_prc_req_inf_sql OWNER TO letl;

--
-- Name: tbl_lcx_bis; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE tbl_lcx_bis (
    cifno character varying(13),
    snno character varying(12),
    lcxsb_snno character(12),
    mlno character varying(12),
    mlkindnm character varying(3),
    mlkindcd character varying(3),
    you_damamt numeric,
    n_you_damamt numeric,
    no numeric,
    bis_rate numeric
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin.tbl_lcx_bis OWNER TO letl;

--
-- Name: temp_aacpaccd; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE temp_aacpaccd (
    aacpaccd text
) DISTRIBUTED BY (aacpaccd);


ALTER TABLE sdmin.temp_aacpaccd OWNER TO letl;

--
-- Name: temp_acnt_ac_code; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE temp_acnt_ac_code (
    child text,
    parent text,
    lev integer
) DISTRIBUTED BY (child);


ALTER TABLE sdmin.temp_acnt_ac_code OWNER TO letl;

--
-- Name: temp_acnt_ac_code_all; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE temp_acnt_ac_code_all (
    child text,
    parent text,
    lev integer
) DISTRIBUTED BY (child);


ALTER TABLE sdmin.temp_acnt_ac_code_all OWNER TO letl;

--
-- Name: temp_acnt_ac_code_old; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE temp_acnt_ac_code_old (
    child text,
    parent text,
    lev integer
) DISTRIBUTED BY (child);


ALTER TABLE sdmin.temp_acnt_ac_code_old OWNER TO letl;

--
-- Name: temp_hum209tf_rlt; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE temp_hum209tf_rlt (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    wk_bsdt character(10) NOT NULL,
    crd_mtg_id character(30) NOT NULL,
    nbis_crd_mtg_dscd character(2),
    mgg_dscd character(2) NOT NULL,
    mgg_kdcd character(3) NOT NULL,
    mgg_usg_ref_cd character(2) NOT NULL,
    mgg_id character(20) NOT NULL,
    his_no character(5),
    est_srno character(3) NOT NULL,
    mgg_srno character(10),
    isupe_std_ctp_tpcd character(3),
    crm_isp_psbz_no character(13),
    crm_ipsco_rgno character(13),
    nat_cd character(2),
    bic_cd character(11),
    mgg_aloc_dscd character(1),
    mgg_aloc_dis_rk numeric(10,0),
    mgg_kd_rk numeric(10,0),
    std_sapc_fit_yn character(1),
    std_cah_fit_yn character(1),
    firb_fit_yn character(1),
    airb_fit_yn character(1),
    fit_scrt_yn character(1),
    fit_grn_yn character(1),
    crd_mtg_acq_dt character(10),
    crd_mtg_xpdt character(10),
    biz_dt_bas_xpdt character(10),
    apr_dt character(10),
    insp_dt character(10),
    cur_val_evl_dt character(10),
    crm_agr_xpr_ycn numeric(10,4),
    crm_svx_ycn numeric(10,4),
    lst_insp_pr_evl_dt character(10),
    scrt_itm_cd character(12),
    frg_scrt_itm_cd character(12),
    scrt_rk_dscd character(1),
    bas_aset_rk_txt character(10),
    ref_aset_rk_txt character(10),
    ref_aset_ctp_id character(20),
    krw_xc_nm_item_am numeric(18,3),
    mlt_bas_aset_yn character(1),
    liv_cm_use_dscd character(1),
    oprevl_mgn_adj_dcn numeric(4,0),
    msidx_incl_yn character(1),
    xch_listed_yn character(1),
    nbis_ptf_dscd character(2),
    ext_crdrk_cd character(2),
    rsk_wgt_rt numeric(12,8),
    crd_mtg_crcd character(3),
    krw_xc_apr_am numeric(18,3),
    krw_xc_insp_am numeric(18,3),
    krw_xc_pre_rk_am numeric(18,3),
    etw_prkes_am numeric(18,3),
    krw_xc_prkes_am numeric(18,3),
    krw_xc_rnt_am numeric(18,3),
    krw_xc_etc_ddu_am numeric(18,3),
    etw_est_am numeric(18,3),
    krw_xc_est_am numeric(18,3),
    krw_xc_avl_pr numeric(18,3),
    krw_xc_cur_val_am numeric(18,3),
    krwx_svl_evl_am numeric(18,3),
    etw_am numeric(18,3),
    krwx_vld_mgg_suval numeric(18,3),
    etw_vld_mgg_pr_am numeric(18,3),
    insp_rt numeric(12,8),
    sbid_rt numeric(12,8),
    cmpl_ltv_rt numeric(12,8),
    grn_rt numeric(12,8),
    src_mgg_no character(16),
    slf_estm_ddu_rt_id character(20),
    if_ts_sys_cd character(1),
    pd_lgd_aply_dscd character(1),
    db_chg_ts timestamp(6) without time zone,
    rgn_tpcd character(1),
    ecezo_ltv_rt numeric(12,8),
    aloc_yn character(1),
    dat_dscd character(1)
) DISTRIBUTED BY (crd_mtg_id);


ALTER TABLE sdmin.temp_hum209tf_rlt OWNER TO letl;

--
-- Name: temp_hum2153102ir01; Type: TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE TABLE temp_hum2153102ir01 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    rwa_cal_id character(42)
) DISTRIBUTED BY (wfg_cd);


ALTER TABLE sdmin.temp_hum2153102ir01 OWNER TO gpadmin;

--
-- Name: temp_hum2153102ir02; Type: TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE TABLE temp_hum2153102ir02 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    crd_mtg_id character(30),
    rwa_cal_id character(42)
) DISTRIBUTED BY (rwa_cal_id);


ALTER TABLE sdmin.temp_hum2153102ir02 OWNER TO gpadmin;

--
-- Name: temp_hum2153102ir03; Type: TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE TABLE temp_hum2153102ir03 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    crd_mtg_id character(30),
    rwa_cal_id character(42),
    nbis_crd_mtg_dscd character(2),
    mgg_dscd character(2),
    rwa_cnt bigint,
    crm_cnt bigint
) DISTRIBUTED BY (rwa_cal_id);


ALTER TABLE sdmin.temp_hum2153102ir03 OWNER TO gpadmin;

--
-- Name: temp_hum2153102ir04; Type: TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE TABLE temp_hum2153102ir04 (
    wfg_cd character(2),
    bas_dt character(10),
    wk_bsdt character(10),
    rwa_cal_id character(42)
) DISTRIBUTED BY (wfg_cd);


ALTER TABLE sdmin.temp_hum2153102ir04 OWNER TO gpadmin;

--
-- Name: temp_hum215tm_rlt; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE temp_hum215tm_rlt (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    wk_bsdt character(10) NOT NULL,
    aloc_scnr_id character(5) NOT NULL,
    crd_mtg_id character(30) NOT NULL,
    rwa_cal_id character(42) NOT NULL,
    ctp_id character(20),
    crd_mtg_aloc_rk numeric(8,0),
    xps_aloc_rk numeric(8,0),
    crm_xps_aloc_rk numeric(8,0),
    liv_cm_use_dscd character(1),
    tsa_a_stsp_fit_yn character(1),
    tsa_a_stch_fit_yn character(1),
    tsa_a_firb_fit_yn character(1),
    tsa_a_airb_fit_yn character(1),
    xpr_dcrd_yn character(1),
    call_dcrd_yn character(1),
    rsk_wgt_rt numeric(12,8),
    crd_mtg_aloc_am numeric(18,3),
    mgg_aloc_am numeric(18,3),
    crd_mtg_bas_am numeric(18,3),
    xps_bas_am numeric(18,3),
    aloc_bf_crd_mtg_am numeric(18,3),
    aloc_bf_xps_am numeric(18,3),
    aloc_af_crd_mtg_am numeric(18,3),
    aloc_af_xps_am numeric(18,3),
    db_chg_ts timestamp(6) without time zone,
    aply_ead_am numeric(18,3) NOT NULL,
    crd_mtg_add_aloc_am numeric(18,3) NOT NULL,
    aloc_insp_am numeric(18,3),
    aloc_wr_est_am numeric(18,3),
    aloc_ob_est_am numeric(18,3),
    aloc_rnt_am numeric(18,3)
) DISTRIBUTED BY (rwa_cal_id);


ALTER TABLE sdmin.temp_hum215tm_rlt OWNER TO letl;

--
-- Name: temp_hum216tm_rlt; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE temp_hum216tm_rlt (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    wk_bsdt character(10) NOT NULL,
    crd_mtg_id character(30) NOT NULL,
    rwa_cal_id character(42) NOT NULL,
    mgg_id character(20),
    est_srno character(3),
    apvrq_no character(11),
    rq_srno character(3),
    xps_id character(30),
    ctp_id character(20),
    liv_cm_use_dscd character(1),
    tsa_a_stsp_aply_yn character(1),
    tsa_a_stch_aply_yn character(1),
    tsa_a_firb_fit_yn character(1),
    tsa_a_airb_fit_yn character(1),
    sapc_rsk_wgt_rt numeric(12,8),
    zero_hct_yn character(1),
    xpr_dcrd_yn character(1),
    call_dcrd_yn character(1),
    rsk_wgt_rt numeric(12,8),
    mgg_aloc_am numeric(18,3),
    if_ts_sys_cd character(1),
    db_chg_ts timestamp(6) without time zone
) DISTRIBUTED BY (rwa_cal_id);


ALTER TABLE sdmin.temp_hum216tm_rlt OWNER TO letl;

--
-- Name: temp_hum421tf_idx; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE temp_hum421tf_idx (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    wk_bsdt character(10) NOT NULL,
    rwa_cal_id character(42) NOT NULL,
    org_ead_am numeric(18,3),
    ead_am numeric(18,3),
    crd_apl_yn character(1),
    db_chg_ts timestamp(0) without time zone
) DISTRIBUTED BY (rwa_cal_id);


ALTER TABLE sdmin.temp_hum421tf_idx OWNER TO letl;

--
-- Name: temp_ifgl_coa_tbl; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE temp_ifgl_coa_tbl (
    child text,
    parent text,
    lev integer
) DISTRIBUTED BY (child);


ALTER TABLE sdmin.temp_ifgl_coa_tbl OWNER TO letl;

--
-- Name: test1; Type: TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE TABLE test1 (
    "WFG_CD" character varying(2),
    "BAS_DT" character varying(10),
    "WK_BSDT" character varying(10),
    "SCNR_ID" character varying(5),
    "RWA_CAL_ID" character varying(42),
    "XPS_ID" character varying(30),
    "XPS_TPCD" character varying(2),
    "ACC_DSCD" character varying(2),
    "ACC_CD" character varying(11),
    "ACT_MNGBR_CD" character varying(5),
    "CTP_ID" character varying(20),
    "TOT_SAL_AM" numeric(20,3),
    "STD_ASET_CLAS_CD" character varying(5),
    "IN_RK_ASET_CLAS_CD" character varying(5),
    "XPS_PRE_AF_RK_CD" character varying(2),
    "NBIS_BAS_DSH_YN" character varying(1),
    "XPS_SDT" character varying(10),
    "XPS_XPDT" character varying(10),
    "XPS_SRVIV_XPR_YCN" numeric(12,4),
    "EM_YCN" numeric(12,4),
    "STM_PRD_TGT_YN" character varying(1),
    "CUR_CD" character varying(3),
    "KRW_XC_LMT_AM" numeric(20,3),
    "KRW_XC_NOT_WDR_BL" numeric(20,3),
    "KRW_XC_BL" numeric(20,3),
    "GEN_ALW_AM" numeric(20,3),
    "SPC_ALW_AM" numeric(20,3),
    "EAD_AM" numeric(20,3),
    "ADJ_EAD_AM" numeric(20,3),
    "LGD_RT" numeric(14,8),
    "FCST_LOS_RT" numeric(14,8),
    "FCST_LOS_AM" numeric(20,3),
    "WGT_AVG_RSK_WGT_RT" numeric(14,8),
    "STD_HLD_RSK_WGT_RT" numeric(14,8),
    "XPS_RSK_WGT_RT" numeric(14,8),
    "FCLS_OPT_ESTM_RT" numeric(14,8),
    "CRD_EVL_MDL_DSCD" character varying(2),
    "EXT_CRDRK_CD" character varying(2),
    "RTSEL_POL_ID" character varying(20),
    "WGT_AVG_DSH_RT" numeric(14,8),
    "XPS_DSH_RT" numeric(14,8),
    "OIST_EVL_IST_CD" character varying(2),
    "OIST_CRDRK_TXT" character varying(10),
    "ONAC_OFSET_AM" numeric(20,3),
    "MCR_AM" numeric(20,3),
    "MGG_PT_RWA_AM" numeric(20,3),
    "NMGG_PT_RWA_AM" numeric(20,3),
    "RWAST_AM" numeric(20,3),
    "ADJ_AF_XPS_AM" numeric(20,3),
    "FNC_MGG_ALOC_AM" numeric(20,3),
    "NFNC_MGG_ALOC_AM" numeric(20,3),
    "CRD_DVPRD_ALOC_AM" numeric(20,3),
    "GRN_ALOC_AM" numeric(20,3),
    "RRE_VLD_MGG_AM" numeric(20,3),
    "CRE_VLD_MGG_AM" numeric(20,3),
    "CRD_MTG_XPS_AM" numeric(20,3),
    "ACL_ID" character varying(20),
    "COCO_NV" numeric(14,8),
    "STD_INDS_CFCD" character varying(5),
    "COSIZ_CD" character varying(2),
    "NBIS_PTF_DSCD" character varying(2),
    "BDSYS_DSCD" character varying(2),
    "ACC_BAS_BIZ_HQ_CD" character varying(3),
    "CUS_BAS_BIZ_HQ_CD" character varying(3),
    "DB_CHG_TS" timestamp without time zone,
    "FC_ASET_YN" character varying(1),
    "NBIS_CAL_APLY_DSCD" character varying(1),
    "CO_RTSEL_DSCD" character varying(1),
    "PSCO_RGNO" character varying(13),
    "PSBZ_NO" character varying(13),
    "PRD_CD" character varying(9),
    "GEN_BDR_AM" numeric(20,3),
    "SPC_BDR_AM" numeric(20,3),
    "BL_EAD_AM" numeric(20,3),
    "NUSE_LMT_EAD_AM" numeric(20,3),
    "BL_EL_AM" numeric(20,3),
    "NUSE_LMT_EL_AM" numeric(20,3),
    "APLY_ASET_CLAS_CD" character varying(4),
    "LNK_COM_CD" character varying(8)
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin.test1 OWNER TO gpadmin;

--
-- Name: test5; Type: TABLE; Schema: sdmin; Owner: gpadmin; Tablespace: 
--

CREATE TABLE test5 (
    "WFG_CD" character varying(2),
    "BAS_DT" character varying(10),
    "WK_BSDT" character varying(10),
    "SCNR_ID" character varying(5),
    "RWA_CAL_ID" character varying(42),
    "XPS_ID" character varying(30),
    "XPS_TPCD" character varying(2),
    "ACC_DSCD" character varying(2),
    "ACC_CD" character varying(11),
    "ACT_MNGBR_CD" character varying(5),
    "CTP_ID" character varying(20),
    "TOT_SAL_AM" numeric(20,3),
    "STD_ASET_CLAS_CD" character varying(5),
    "IN_RK_ASET_CLAS_CD" character varying(5),
    "XPS_PRE_AF_RK_CD" character varying(2),
    "NBIS_BAS_DSH_YN" character varying(1),
    "XPS_SDT" character varying(10),
    "XPS_XPDT" character varying(10),
    "XPS_SRVIV_XPR_YCN" numeric(12,4),
    "EM_YCN" numeric(12,4),
    "STM_PRD_TGT_YN" character varying(1),
    "CUR_CD" character varying(3),
    "KRW_XC_LMT_AM" numeric(20,3),
    "KRW_XC_NOT_WDR_BL" numeric(20,3),
    "KRW_XC_BL" numeric(20,3),
    "GEN_ALW_AM" numeric(20,3),
    "SPC_ALW_AM" numeric(20,3),
    "EAD_AM" numeric(20,3),
    "ADJ_EAD_AM" numeric(20,3),
    "LGD_RT" numeric(14,8),
    "FCST_LOS_RT" numeric(14,8),
    "FCST_LOS_AM" numeric(20,3),
    "WGT_AVG_RSK_WGT_RT" numeric(14,8),
    "STD_HLD_RSK_WGT_RT" numeric(14,8),
    "XPS_RSK_WGT_RT" numeric(14,8),
    "FCLS_OPT_ESTM_RT" numeric(14,8),
    "CRD_EVL_MDL_DSCD" character varying(2),
    "EXT_CRDRK_CD" character varying(2),
    "RTSEL_POL_ID" character varying(20),
    "WGT_AVG_DSH_RT" numeric(14,8),
    "XPS_DSH_RT" numeric(14,8),
    "OIST_EVL_IST_CD" character varying(2),
    "OIST_CRDRK_TXT" character varying(10),
    "ONAC_OFSET_AM" numeric(20,3),
    "MCR_AM" numeric(20,3),
    "MGG_PT_RWA_AM" numeric(20,3),
    "NMGG_PT_RWA_AM" numeric(20,3),
    "RWAST_AM" numeric(20,3),
    "ADJ_AF_XPS_AM" numeric(20,3),
    "FNC_MGG_ALOC_AM" numeric(20,3),
    "NFNC_MGG_ALOC_AM" numeric(20,3),
    "CRD_DVPRD_ALOC_AM" numeric(20,3),
    "GRN_ALOC_AM" numeric(20,3),
    "RRE_VLD_MGG_AM" numeric(20,3),
    "CRE_VLD_MGG_AM" numeric(20,3),
    "CRD_MTG_XPS_AM" numeric(20,3),
    "ACL_ID" character varying(20),
    "COCO_NV" numeric(14,8),
    "STD_INDS_CFCD" character varying(5),
    "COSIZ_CD" character varying(2),
    "NBIS_PTF_DSCD" character varying(2),
    "BDSYS_DSCD" character varying(2),
    "ACC_BAS_BIZ_HQ_CD" character varying(3),
    "CUS_BAS_BIZ_HQ_CD" character varying(3),
    "DB_CHG_TS" timestamp without time zone,
    "FC_ASET_YN" character varying(1),
    "NBIS_CAL_APLY_DSCD" character varying(1),
    "CO_RTSEL_DSCD" character varying(1),
    "PSCO_RGNO" character varying(13),
    "PSBZ_NO" character varying(13),
    "PRD_CD" character varying(9),
    "GEN_BDR_AM" numeric(20,3),
    "SPC_BDR_AM" numeric(20,3),
    "BL_EAD_AM" numeric(20,3),
    "NUSE_LMT_EAD_AM" numeric(20,3),
    "BL_EL_AM" numeric(20,3),
    "NUSE_LMT_EL_AM" numeric(20,3),
    "APLY_ASET_CLAS_CD" character varying(4),
    "LNK_COM_CD" character varying(8)
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin.test5 OWNER TO gpadmin;

--
-- Name: tmp_hum701tm_01; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE tmp_hum701tm_01 (
    psco_rgno character(13),
    std_ctp_tpcd character(3)
) DISTRIBUTED BY (psco_rgno ,std_ctp_tpcd);


ALTER TABLE sdmin.tmp_hum701tm_01 OWNER TO letl;

--
-- Name: trns_ad_mst; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE trns_ad_mst (
    tadtrdt character varying(8) NOT NULL,
    tadkeyno character varying(16) NOT NULL,
    tadlogno character varying(7) NOT NULL,
    tadopenbr character varying(3),
    tadmode character(1),
    tadtrkind character varying(2),
    tadtramt numeric(15,0) DEFAULT 0,
    tadtime character varying(6),
    tadtrbr character varying(3),
    tadhuamt numeric(15,0) DEFAULT 0,
    tadname character varying(50),
    tadcifno character varying(13),
    tadtrmno character varying(2),
    tadtrmkd character varying(1),
    taddamno character varying(5),
    tadcode character varying(3),
    tadoldno character varying(20),
    tadnewno character varying(20),
    tadcomam numeric(15,0) DEFAULT 0,
    tadsmcd1 character varying(3),
    tadsmcd2 character varying(3),
    tadsmcd3 character varying(3),
    tadsmcd4 character varying(3),
    tadsmcd5 character varying(3),
    tadsmcd6 character varying(3),
    tadsmcd7 character varying(3),
    tadsmcd8 character varying(3),
    tadsmcd9 character varying(3),
    tadjobcd character varying(2),
    tadbigo character varying(30),
    tadibsikcd character varying(4),
    tadibjicd character varying(2),
    tadopno character varying(2),
    tadautno character varying(2),
    tadbankno character varying(10),
    tadtongkd character varying(2),
    tadacint numeric(15,0),
    tadlnint numeric(15,0),
    tadsotax numeric(15,0),
    tadjutax numeric(15,0),
    tadnotax numeric(15,0),
    tadedtax numeric(15,0),
    tadbutax numeric(15,0),
    tadchkam1 numeric(15,0),
    tadchkam2 numeric(15,0),
    tadchkam3 numeric(15,0),
    tadchkcd1 character varying(2),
    tadchkcd2 character varying(2),
    tadchkcd3 character varying(2),
    tadchkcd character varying(1),
    tadydno character varying(12),
    tadcdbk character varying(1),
    tadinqcd character varying(1),
    tadatcd character varying(1),
    tadcdkd character varying(1),
    taddaykd character varying(1),
    tad365 character varying(1),
    tadempid character varying(20) DEFAULT '      '::character varying,
    tadbigo1 character varying(100),
    tadchkcnt1 numeric(3,0),
    tadchkcnt2 numeric(3,0),
    tadchkcnt3 numeric(3,0),
    tadchkno1 character varying(30),
    tadchkno2 character varying(30),
    tadchkno3 character varying(30),
    tadcdid character(4),
    tadmujp character(1),
    tadgiupib character(6),
    tadsuupib character(6),
    tadafl character(1),
    tadiljjcnt numeric(2,0),
    tadiljmode character varying(1),
    tadpbnf character varying(1),
    tadpbno character varying(1),
    tadcrgb character varying(2),
    tadopid character varying(10),
    tadautid character varying(10),
    tadsyid character varying(2),
    tadlogstid character varying(2),
    tadtmst character varying(1),
    tadlogstdt character varying(8),
    tadcif character varying(1),
    tadctr character varying(1),
    taderrcd character varying(4),
    tadpayacno character varying(20),
    tadrcvacno character varying(20),
    taddcifno character varying(13),
    tadatabrno character varying(3),
    tadpbsms character varying(1)
) DISTRIBUTED BY (tadkeyno);


ALTER TABLE sdmin.trns_ad_mst OWNER TO letl;

--
-- Name: trns_ad_mst_1; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE trns_ad_mst_1 (
    tadtrdt character varying(8) NOT NULL,
    tadkeyno character varying(16) NOT NULL,
    tadlogno character varying(7) NOT NULL,
    tadopenbr character varying(3),
    tadmode character(1),
    tadtrkind character varying(2),
    tadtramt numeric(15,0),
    tadtime character varying(6),
    tadtrbr character varying(3),
    tadhuamt numeric(15,0),
    tadname character varying(50),
    tadcifno character varying(13),
    tadtrmno character varying(2),
    tadtrmkd character varying(1),
    taddamno character varying(5),
    tadcode character varying(3),
    tadoldno character varying(20),
    tadnewno character varying(20),
    tadcomam numeric(15,0),
    tadsmcd1 character varying(3),
    tadsmcd2 character varying(3),
    tadsmcd3 character varying(3),
    tadsmcd4 character varying(3),
    tadsmcd5 character varying(3),
    tadsmcd6 character varying(3),
    tadsmcd7 character varying(3),
    tadsmcd8 character varying(3),
    tadsmcd9 character varying(3),
    tadjobcd character varying(2),
    tadbigo character varying(30),
    tadibsikcd character varying(4),
    tadibjicd character varying(2),
    tadopno character varying(2),
    tadautno character varying(2),
    tadbankno character varying(10),
    tadtongkd character varying(2),
    tadacint numeric(15,0),
    tadlnint numeric(15,0),
    tadsotax numeric(15,0),
    tadjutax numeric(15,0),
    tadnotax numeric(15,0),
    tadedtax numeric(15,0),
    tadbutax numeric(15,0),
    tadchkam1 numeric(15,0),
    tadchkam2 numeric(15,0),
    tadchkam3 numeric(15,0),
    tadchkcd1 character varying(2),
    tadchkcd2 character varying(2),
    tadchkcd3 character varying(2),
    tadchkcd character varying(1),
    tadydno character varying(12),
    tadcdbk character varying(1),
    tadinqcd character varying(1),
    tadatcd character varying(1),
    tadcdkd character varying(1),
    taddaykd character varying(1),
    tad365 character varying(1),
    tadempid character varying(20) DEFAULT '      '::character varying,
    tadbigo1 character varying(100),
    tadchkcnt1 numeric(3,0),
    tadchkcnt2 numeric(3,0),
    tadchkcnt3 numeric(3,0),
    tadchkno1 character varying(30),
    tadchkno2 character varying(30),
    tadchkno3 character varying(30),
    tadcdid character(4),
    tadmujp character(1),
    tadgiupib character(6),
    tadsuupib character(6),
    tadafl character(1),
    tadiljjcnt numeric(2,0),
    tadiljmode character varying(1),
    tadpbnf character varying(1),
    tadpbno character varying(1),
    tadcrgb character varying(2),
    tadopid character varying(10),
    tadautid character varying(10),
    tadsyid character varying(2),
    tadlogstid character varying(2),
    tadtmst character varying(1),
    tadlogstdt character varying(8),
    tadcif character varying(1),
    tadctr character varying(1),
    taderrcd character varying(4),
    tadpayacno character varying(20),
    tadrcvacno character varying(20),
    taddcifno character varying(13),
    tadatabrno character varying(3),
    tadpbsms character varying(1)
) DISTRIBUTED BY (tadkeyno);


ALTER TABLE sdmin.trns_ad_mst_1 OWNER TO letl;

--
-- Name: trns_ad_mst_1001; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE trns_ad_mst_1001 (
    tadtrdt character varying(8) NOT NULL,
    tadkeyno character varying(16) NOT NULL,
    tadlogno character varying(7) NOT NULL,
    tadopenbr character varying(3),
    tadmode character(1),
    tadtrkind character varying(2),
    tadtramt numeric(15,0),
    tadtime character varying(6),
    tadtrbr character varying(3),
    tadhuamt numeric(15,0),
    tadname character varying(50),
    tadcifno character varying(13),
    tadtrmno character varying(2),
    tadtrmkd character varying(1),
    taddamno character varying(5),
    tadcode character varying(3),
    tadoldno character varying(20),
    tadnewno character varying(20),
    tadcomam numeric(15,0),
    tadsmcd1 character varying(3),
    tadsmcd2 character varying(3),
    tadsmcd3 character varying(3),
    tadsmcd4 character varying(3),
    tadsmcd5 character varying(3),
    tadsmcd6 character varying(3),
    tadsmcd7 character varying(3),
    tadsmcd8 character varying(3),
    tadsmcd9 character varying(3),
    tadjobcd character varying(2),
    tadbigo character varying(30),
    tadibsikcd character varying(4),
    tadibjicd character varying(2),
    tadopno character varying(2),
    tadautno character varying(2),
    tadbankno character varying(10),
    tadtongkd character varying(2),
    tadacint numeric(15,0),
    tadlnint numeric(15,0),
    tadsotax numeric(15,0),
    tadjutax numeric(15,0),
    tadnotax numeric(15,0),
    tadedtax numeric(15,0),
    tadbutax numeric(15,0),
    tadchkam1 numeric(15,0),
    tadchkam2 numeric(15,0),
    tadchkam3 numeric(15,0),
    tadchkcd1 character varying(2),
    tadchkcd2 character varying(2),
    tadchkcd3 character varying(2),
    tadchkcd character varying(1),
    tadydno character varying(12),
    tadcdbk character varying(1),
    tadinqcd character varying(1),
    tadatcd character varying(1),
    tadcdkd character varying(1),
    taddaykd character varying(1),
    tad365 character varying(1),
    tadempid character varying(20),
    tadbigo1 character varying(100),
    tadchkcnt1 numeric(3,0),
    tadchkcnt2 numeric(3,0),
    tadchkcnt3 numeric(3,0),
    tadchkno1 character varying(30),
    tadchkno2 character varying(30),
    tadchkno3 character varying(30),
    tadcdid character(4),
    tadmujp character(1),
    tadgiupib character(6),
    tadsuupib character(6),
    tadafl character(1),
    tadiljjcnt numeric(2,0),
    tadiljmode character varying(1),
    tadpbnf character varying(1),
    tadpbno character varying(1),
    tadcrgb character varying(2),
    tadopid character varying(10),
    tadautid character varying(10),
    tadsyid character varying(2),
    tadlogstid character varying(2),
    tadtmst character varying(1),
    tadlogstdt character varying(8),
    tadcif character varying(1),
    tadctr character varying(1),
    taderrcd character varying(4),
    tadpayacno character varying(20),
    tadrcvacno character varying(20),
    taddcifno character varying(13),
    tadatabrno character varying(3)
) DISTRIBUTED BY (tadkeyno);


ALTER TABLE sdmin.trns_ad_mst_1001 OWNER TO letl;

--
-- Name: trns_ad_mst_1003; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE trns_ad_mst_1003 (
    tadtrdt character varying(8) NOT NULL,
    tadkeyno character varying(16) NOT NULL,
    tadlogno character varying(7) NOT NULL,
    tadopenbr character varying(3),
    tadmode character(1),
    tadtrkind character varying(2),
    tadtramt numeric(15,0),
    tadtime character varying(6),
    tadtrbr character varying(3),
    tadhuamt numeric(15,0),
    tadname character varying(50),
    tadcifno character varying(13),
    tadtrmno character varying(2),
    tadtrmkd character varying(1),
    taddamno character varying(5),
    tadcode character varying(3),
    tadoldno character varying(20),
    tadnewno character varying(20),
    tadcomam numeric(15,0),
    tadsmcd1 character varying(3),
    tadsmcd2 character varying(3),
    tadsmcd3 character varying(3),
    tadsmcd4 character varying(3),
    tadsmcd5 character varying(3),
    tadsmcd6 character varying(3),
    tadsmcd7 character varying(3),
    tadsmcd8 character varying(3),
    tadsmcd9 character varying(3),
    tadjobcd character varying(2),
    tadbigo character varying(30),
    tadibsikcd character varying(4),
    tadibjicd character varying(2),
    tadopno character varying(2),
    tadautno character varying(2),
    tadbankno character varying(10),
    tadtongkd character varying(2),
    tadacint numeric(15,0),
    tadlnint numeric(15,0),
    tadsotax numeric(15,0),
    tadjutax numeric(15,0),
    tadnotax numeric(15,0),
    tadedtax numeric(15,0),
    tadbutax numeric(15,0),
    tadchkam1 numeric(15,0),
    tadchkam2 numeric(15,0),
    tadchkam3 numeric(15,0),
    tadchkcd1 character varying(2),
    tadchkcd2 character varying(2),
    tadchkcd3 character varying(2),
    tadchkcd character varying(1),
    tadydno character varying(12),
    tadcdbk character varying(1),
    tadinqcd character varying(1),
    tadatcd character varying(1),
    tadcdkd character varying(1),
    taddaykd character varying(1),
    tad365 character varying(1),
    tadempid character varying(20),
    tadbigo1 character varying(100),
    tadchkcnt1 numeric(3,0),
    tadchkcnt2 numeric(3,0),
    tadchkcnt3 numeric(3,0),
    tadchkno1 character varying(30),
    tadchkno2 character varying(30),
    tadchkno3 character varying(30),
    tadcdid character(4),
    tadmujp character(1),
    tadgiupib character(6),
    tadsuupib character(6),
    tadafl character(1),
    tadiljjcnt numeric(2,0),
    tadiljmode character varying(1),
    tadpbnf character varying(1),
    tadpbno character varying(1),
    tadcrgb character varying(2),
    tadopid character varying(10),
    tadautid character varying(10),
    tadsyid character varying(2),
    tadlogstid character varying(2),
    tadtmst character varying(1),
    tadlogstdt character varying(8),
    tadcif character varying(1),
    tadctr character varying(1),
    taderrcd character varying(4),
    tadpayacno character varying(20),
    tadrcvacno character varying(20),
    taddcifno character varying(13),
    tadatabrno character varying(3)
) DISTRIBUTED BY (tadkeyno);


ALTER TABLE sdmin.trns_ad_mst_1003 OWNER TO letl;

--
-- Name: trns_ad_mst_1205; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE trns_ad_mst_1205 (
    tadtrdt character varying(8) NOT NULL,
    tadkeyno character varying(16) NOT NULL,
    tadlogno character varying(7) NOT NULL,
    tadopenbr character varying(3),
    tadmode character(1),
    tadtrkind character varying(2),
    tadtramt numeric(15,0),
    tadtime character varying(6),
    tadtrbr character varying(3),
    tadhuamt numeric(15,0),
    tadname character varying(50),
    tadcifno character varying(13),
    tadtrmno character varying(2),
    tadtrmkd character varying(1),
    taddamno character varying(5),
    tadcode character varying(3),
    tadoldno character varying(20),
    tadnewno character varying(20),
    tadcomam numeric(15,0),
    tadsmcd1 character varying(3),
    tadsmcd2 character varying(3),
    tadsmcd3 character varying(3),
    tadsmcd4 character varying(3),
    tadsmcd5 character varying(3),
    tadsmcd6 character varying(3),
    tadsmcd7 character varying(3),
    tadsmcd8 character varying(3),
    tadsmcd9 character varying(3),
    tadjobcd character varying(2),
    tadbigo character varying(30),
    tadibsikcd character varying(4),
    tadibjicd character varying(2),
    tadopno character varying(2),
    tadautno character varying(2),
    tadbankno character varying(10),
    tadtongkd character varying(2),
    tadacint numeric(15,0),
    tadlnint numeric(15,0),
    tadsotax numeric(15,0),
    tadjutax numeric(15,0),
    tadnotax numeric(15,0),
    tadedtax numeric(15,0),
    tadbutax numeric(15,0),
    tadchkam1 numeric(15,0),
    tadchkam2 numeric(15,0),
    tadchkam3 numeric(15,0),
    tadchkcd1 character varying(2),
    tadchkcd2 character varying(2),
    tadchkcd3 character varying(2),
    tadchkcd character varying(1),
    tadydno character varying(12),
    tadcdbk character varying(1),
    tadinqcd character varying(1),
    tadatcd character varying(1),
    tadcdkd character varying(1),
    taddaykd character varying(1),
    tad365 character varying(1),
    tadempid character varying(20),
    tadbigo1 character varying(100),
    tadchkcnt1 numeric(3,0),
    tadchkcnt2 numeric(3,0),
    tadchkcnt3 numeric(3,0),
    tadchkno1 character varying(30),
    tadchkno2 character varying(30),
    tadchkno3 character varying(30),
    tadcdid character(4),
    tadmujp character(1),
    tadgiupib character(6),
    tadsuupib character(6),
    tadafl character(1),
    tadiljjcnt numeric(2,0),
    tadiljmode character varying(1),
    tadpbnf character varying(1),
    tadpbno character varying(1),
    tadcrgb character varying(2),
    tadopid character varying(10),
    tadautid character varying(10),
    tadsyid character varying(2),
    tadlogstid character varying(2),
    tadtmst character varying(1),
    tadlogstdt character varying(8),
    tadcif character varying(1),
    tadctr character varying(1),
    taderrcd character varying(4),
    tadpayacno character varying(20),
    tadrcvacno character varying(20),
    taddcifno character varying(13),
    tadatabrno character varying(3),
    tadpbsms character varying(1)
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin.trns_ad_mst_1205 OWNER TO letl;

--
-- Name: trns_fi_doc; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE trns_fi_doc (
    tfdbrno character(3) NOT NULL,
    tfdtrdt character(8) NOT NULL,
    tfdseqno numeric(5,0) DEFAULT 0 NOT NULL,
    tfddocno character varying(30),
    tfddorvdt character(8),
    tfdorgcd character(2),
    tfdrqunm character varying(30),
    tfdrqrnm character varying(30),
    tfdrqdt character(8),
    tfdrqlaw character varying(100),
    tfdrqpssu numeric(7,0) DEFAULT 0,
    tfdrqpsinf character varying(60),
    tfdrqitem character varying(100),
    tfdgvdate character(8),
    tfdgvlaw character varying(50),
    tfdgvpssu numeric(7,0) DEFAULT 0,
    tfdgvpsinf character varying(60),
    tfdgvitem character varying(100),
    tfdrjwhy character varying(100),
    tfdcsavdt character(8),
    tfdcsdydt character(8),
    tfdcsdyinf character varying(100),
    tfdupid character(6),
    tfdupnm character varying(10),
    tfdatid1 character(6),
    tfdatnm1 character varying(10),
    tfdatapp1 character(1),
    tfdatid2 character(6),
    tfdatnm2 character varying(10),
    tfdatapp2 character(1),
    tfdatid3 character(6),
    tfdatnm3 character varying(10),
    tfdatapp3 character(1),
    tfdorginf character varying(100),
    tfdcsid character(6),
    tfdcsnm character varying(10),
    tfinfgoal character varying(100),
    tfdhrqlaw character varying(100),
    tfdhgvlaw character varying(100),
    tfdtongbo character varying(1),
    tfdomitinf character varying(100),
    tfdomitcd character varying(6)
) DISTRIBUTED BY (tfddorvdt ,tfdtrdt ,tfdseqno);


ALTER TABLE sdmin.trns_fi_doc OWNER TO letl;

--
-- Name: trns_seobu_rst; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE trns_seobu_rst (
    bas_dt character varying(8) NOT NULL,
    cus_no character varying(13) NOT NULL,
    actno character varying(50),
    acc_sbj character varying(6),
    avg_bl numeric(15,0),
    bal_bl numeric(15,0),
    mngbr character varying(3),
    act_mngbr character varying(3),
    prod_cd character varying(4),
    gubun_cd character varying(2),
    bks_ctr_dt character varying(8),
    pfstc_sel_fee numeric(12,0),
    acm_pfstc character varying(1),
    apv_no character varying(20),
    cus_nm character varying(60),
    spc_kind character varying(5)
) DISTRIBUTED BY (actno);


ALTER TABLE sdmin.trns_seobu_rst OWNER TO letl;

--
-- Name: tum20101; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE tum20101 (
    tbnm text,
    wfg_cd character(2),
    bas_dt character(10),
    nbis_crd_mtg_dscd character(2),
    mgg_dscd character(2),
    mgg_kdcd character(3),
    mgg_usg_ref_cd character(2),
    mgg_id character(20),
    his_no character(5),
    mgg_srno character(10),
    isupe_std_ctp_tpcd bpchar,
    crm_isp_psbz_no bpchar,
    crm_ipsco_rgno bpchar,
    mgg_aloc_dscd text,
    crd_mtg_acq_dt character(10),
    crd_mtg_xpdt character(10),
    biz_dt_bas_xpdt character(10),
    apr_dt character(10),
    insp_dt character(10),
    cur_val_evl_dt character(10),
    crm_agr_xpr_ycn integer,
    crm_svx_ycn integer,
    lst_insp_pr_evl_dt character(10),
    scrt_itm_cd bpchar,
    frg_scrt_itm_cd bpchar,
    scrt_rk_dscd bpchar,
    bas_aset_rk_txt text,
    ref_aset_rk_txt text,
    ref_aset_ctp_id text,
    krw_xc_nm_item_am integer,
    mlt_bas_aset_yn text,
    liv_cm_use_dscd bpchar,
    oprevl_mgn_adj_dcn numeric,
    msidx_incl_yn bpchar,
    xch_listed_yn bpchar,
    rsk_wgt_rt integer,
    crd_mtg_crcd character(3),
    krw_xc_apr_am numeric(18,3),
    krw_xc_insp_am numeric(18,3),
    krw_xc_pre_rk_am integer,
    krw_xc_rnt_am numeric,
    krw_xc_etc_ddu_am integer,
    krw_xc_avl_pr numeric,
    krw_xc_sum_avl_pr numeric,
    krw_xc_sum_cur_val_am numeric,
    krw_xc_cur_val_am numeric(18,3),
    etw_am numeric(18,3),
    krwx_svl_evl_am numeric,
    insp_rt numeric,
    sbid_rt numeric,
    cmpl_ltv_rt integer,
    grn_rt numeric,
    src_mgg_no character(16),
    slf_estm_ddu_rt_id text,
    if_ts_sys_cd text,
    nat_cd bpchar,
    bic_cd bpchar,
    pre_rk_am integer,
    rnt_am numeric,
    stl_val_evl_am integer,
    rgn_tpcd bpchar
) DISTRIBUTED BY (mgg_id);


ALTER TABLE sdmin.tum20101 OWNER TO letl;

--
-- Name: tum20102; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE tum20102 (
    wfg_cd character(2),
    bas_dt character(10),
    mgg_id character(20),
    est_srno character(3),
    est_crcd character(3),
    est_krw_xc_am numeric,
    tbk_est_yn character(1),
    est_rgs_dt character(10),
    est_xpdt character(10),
    bdpv_cd character(2)
) DISTRIBUTED BY (mgg_id);


ALTER TABLE sdmin.tum20102 OWNER TO letl;

--
-- Name: tum210tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE tum210tf (
    wfg_cd character(2),
    bas_dt character(10),
    mgg_id character(20),
    est_srno character(3),
    mgg_aloc_dis_rk bigint
) DISTRIBUTED BY (mgg_id);


ALTER TABLE sdmin.tum210tf OWNER TO letl;

--
-- Name: tum211tf; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE tum211tf (
    wfg_cd character(2),
    bas_dt character(10),
    mgg_id character(20),
    est_srno character(3),
    pub_est_mng_no character(15),
    mgg_dscd character(2),
    est_stcd character(2),
    mgg_srno character(10),
    est_rgs_dt character(10),
    est_xpdt character(10),
    est_crcd character(3),
    est_am numeric(18,3),
    est_krw_xc_am numeric,
    tbk_est_yn character(1),
    bdpv_cd character(2),
    mgg_invk_yn character(1),
    mgg_obj_cd character(2),
    mgg_invk_am numeric(18,3),
    bdtb_est_xpdt character(10),
    can_dt character(10)
) DISTRIBUTED BY (mgg_id);


ALTER TABLE sdmin.tum211tf OWNER TO letl;

--
-- Name: tum60atm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE tum60atm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    xps_id character(30) NOT NULL,
    acc_dscd character(2) NOT NULL,
    acc_cd character(11) NOT NULL,
    llp_bal_gen_alw_am numeric,
    llp_bal_spc_alw_am numeric,
    bdr_bal_gen_alw_am numeric,
    bdr_bal_spc_alw_am numeric
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.tum60atm OWNER TO letl;

--
-- Name: tum611tm; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE tum611tm (
    wfg_cd character(2) NOT NULL,
    bas_dt character(10) NOT NULL,
    xps_id character(30) NOT NULL,
    acc_dscd character(2) NOT NULL,
    acc_cd character(11) NOT NULL,
    llp_lmt_gen_alw_am numeric,
    llp_lmt_spc_alw_am numeric,
    bdr_lmt_gen_alw_am numeric,
    bdr_lmt_spc_alw_am numeric
) DISTRIBUTED BY (xps_id);


ALTER TABLE sdmin.tum611tm OWNER TO letl;

--
-- Name: v_ck; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE v_ck (
    "?column?" integer
) DISTRIBUTED BY ("?column?");


ALTER TABLE sdmin.v_ck OWNER TO letl;

--
-- Name: v_istable; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE v_istable (
    count bigint
) DISTRIBUTED BY (count);


ALTER TABLE sdmin.v_istable OWNER TO letl;

--
-- Name: v_sess_id; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE v_sess_id (
    pg_backend_pid integer
) DISTRIBUTED BY (pg_backend_pid);


ALTER TABLE sdmin.v_sess_id OWNER TO letl;

--
-- Name: xpr_arv_mkt_cus; Type: TABLE; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE TABLE xpr_arv_mkt_cus (
    act_no character(12) NOT NULL,
    cus_no character(13),
    cus_nm character varying(100),
    cus_qlf_cd character(2),
    prd_cd character(3),
    prd_nm character varying(50),
    opn_dt character(8),
    xpr_dt character(8),
    dfr_xpdt character(8),
    pi_cn numeric(3,0),
    ctr_tm numeric(3,0),
    bal_bl numeric(18,0),
    ctr_am numeric(18,0),
    agr_irt numeric(7,4),
    dis_cd character varying(10),
    sbj_cd character(2),
    act_mngbr character(3),
    mkt_cn numeric(3,0),
    chrg_csltpe character varying(10),
    late_cont_txt character varying(100),
    wk_dt character(8),
    stat_cd character(1),
    sts_chg_dt character(8),
    agr_flag character varying(1)
) DISTRIBUTED BY (act_no);


ALTER TABLE sdmin.xpr_arv_mkt_cus OWNER TO letl;

SET search_path = sdmin_err, pg_catalog;

--
-- Name: aaa_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE aaa_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.aaa_err OWNER TO gpadmin;

--
-- Name: acnt_ac_code_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE acnt_ac_code_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.acnt_ac_code_err OWNER TO letl;

--
-- Name: acnt_ho_liday_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE acnt_ho_liday_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.acnt_ho_liday_err OWNER TO gpadmin;

--
-- Name: audt_ja_app_result_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE audt_ja_app_result_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.audt_ja_app_result_err OWNER TO letl;

--
-- Name: audt_ja_confirm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE audt_ja_confirm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.audt_ja_confirm_err OWNER TO letl;

--
-- Name: audt_ja_depo_mrtg_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE audt_ja_depo_mrtg_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.audt_ja_depo_mrtg_err OWNER TO letl;

--
-- Name: audt_ja_opn_apv_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE audt_ja_opn_apv_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.audt_ja_opn_apv_err OWNER TO letl;

--
-- Name: audt_ja_ss_mst_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE audt_ja_ss_mst_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.audt_ja_ss_mst_err OWNER TO letl;

--
-- Name: audt_vaca_tbl_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE audt_vaca_tbl_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.audt_vaca_tbl_err OWNER TO letl;

--
-- Name: bbb_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE bbb_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.bbb_err OWNER TO gpadmin;

--
-- Name: bind_depo_opn_trn_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE bind_depo_opn_trn_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.bind_depo_opn_trn_err OWNER TO letl;

--
-- Name: card_flc_mihando_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE card_flc_mihando_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.card_flc_mihando_err OWNER TO letl;

--
-- Name: card_flc_mst_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE card_flc_mst_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.card_flc_mst_err OWNER TO letl;

--
-- Name: code_detail_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE code_detail_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.code_detail_err OWNER TO letl;

--
-- Name: comm_bk_mast_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE comm_bk_mast_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.comm_bk_mast_err OWNER TO letl;

--
-- Name: comm_br_brch_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE comm_br_brch_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.comm_br_brch_err OWNER TO letl;

--
-- Name: comm_cd_every_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE comm_cd_every_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.comm_cd_every_err OWNER TO letl;

--
-- Name: comm_ep_emp_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE comm_ep_emp_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.comm_ep_emp_err OWNER TO letl;

--
-- Name: comm_im_paper_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE comm_im_paper_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.comm_im_paper_err OWNER TO letl;

--
-- Name: comm_menu_step_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE comm_menu_step_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.comm_menu_step_err OWNER TO letl;

--
-- Name: comm_mr_cif_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE comm_mr_cif_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.comm_mr_cif_err OWNER TO letl;

--
-- Name: comm_mr_mgr_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE comm_mr_mgr_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.comm_mr_mgr_err OWNER TO letl;

--
-- Name: comm_pb_ct_result_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE comm_pb_ct_result_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.comm_pb_ct_result_err OWNER TO letl;

--
-- Name: comm_pb_mg_cif_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE comm_pb_mg_cif_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.comm_pb_mg_cif_err OWNER TO letl;

--
-- Name: comm_vaca_tbl_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE comm_vaca_tbl_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.comm_vaca_tbl_err OWNER TO letl;

--
-- Name: connectby_tree_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE connectby_tree_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.connectby_tree_err OWNER TO gpadmin;

--
-- Name: crms_trace_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE crms_trace_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.crms_trace_err OWNER TO letl;

--
-- Name: cu040tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE cu040tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.cu040tf_err OWNER TO letl;

--
-- Name: cust_ba_base_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE cust_ba_base_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.cust_ba_base_err OWNER TO letl;

--
-- Name: cust_ba_juso_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE cust_ba_juso_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.cust_ba_juso_err OWNER TO letl;

--
-- Name: cust_rl_dp_woltb_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE cust_rl_dp_woltb_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.cust_rl_dp_woltb_err OWNER TO gpadmin;

--
-- Name: cust_rl_dt_tbl_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE cust_rl_dt_tbl_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.cust_rl_dt_tbl_err OWNER TO letl;

--
-- Name: cust_rl_vp_tbl_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE cust_rl_vp_tbl_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.cust_rl_vp_tbl_err OWNER TO letl;

--
-- Name: dd_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE dd_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.dd_err OWNER TO gpadmin;

--
-- Name: depo_ac_comm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE depo_ac_comm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.depo_ac_comm_err OWNER TO letl;

--
-- Name: depo_bd_dbal_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE depo_bd_dbal_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.depo_bd_dbal_err OWNER TO letl;

--
-- Name: depo_cv_davg_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE depo_cv_davg_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.depo_cv_davg_err OWNER TO letl;

--
-- Name: depo_cv_info_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE depo_cv_info_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.depo_cv_info_err OWNER TO letl;

--
-- Name: depo_ex_inf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE depo_ex_inf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.depo_ex_inf_err OWNER TO letl;

--
-- Name: depo_exp_tongbo_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE depo_exp_tongbo_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.depo_exp_tongbo_err OWNER TO letl;

--
-- Name: depo_mm_dbal_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE depo_mm_dbal_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.depo_mm_dbal_err OWNER TO letl;

--
-- Name: depo_mm_mbal_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE depo_mm_mbal_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.depo_mm_mbal_err OWNER TO letl;

--
-- Name: depo_mm_woltb_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE depo_mm_woltb_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.depo_mm_woltb_err OWNER TO letl;

--
-- Name: depo_rg_bond_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE depo_rg_bond_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.depo_rg_bond_err OWNER TO letl;

--
-- Name: depo_sj_mas_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE depo_sj_mas_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.depo_sj_mas_err OWNER TO letl;

--
-- Name: depo_tr_mas_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE depo_tr_mas_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.depo_tr_mas_err OWNER TO letl;

--
-- Name: ea13mt_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ea13mt_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ea13mt_err OWNER TO letl;

--
-- Name: foex_de_dept_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE foex_de_dept_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.foex_de_dept_err OWNER TO letl;

--
-- Name: gita_rpcd_tbl_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE gita_rpcd_tbl_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.gita_rpcd_tbl_err OWNER TO letl;

--
-- Name: gita_rpdata_tbl_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE gita_rpdata_tbl_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.gita_rpdata_tbl_err OWNER TO letl;

--
-- Name: hu0b18tc_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b18tc_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0b18tc_err OWNER TO letl;

--
-- Name: hu0b19tc_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b19tc_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0b19tc_err OWNER TO letl;

--
-- Name: hu0b20tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b20tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0b20tm_err OWNER TO letl;

--
-- Name: hu0b21tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b21tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0b21tm_err OWNER TO letl;

--
-- Name: hu0b34tc_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b34tc_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0b34tc_err OWNER TO letl;

--
-- Name: hu0b41tc_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b41tc_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0b41tc_err OWNER TO letl;

--
-- Name: hu0b44tc_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0b44tc_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0b44tc_err OWNER TO letl;

--
-- Name: hu0d01tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0d01tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0d01tm_err OWNER TO letl;

--
-- Name: hu0d02tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0d02tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0d02tm_err OWNER TO letl;

--
-- Name: hu0d05tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0d05tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0d05tm_err OWNER TO letl;

--
-- Name: hu0d88tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0d88tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0d88tm_err OWNER TO letl;

--
-- Name: hu0d99tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0d99tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0d99tm_err OWNER TO letl;

--
-- Name: hu0e0ctm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e0ctm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0e0ctm_err OWNER TO letl;

--
-- Name: hu0e13tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e13tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0e13tm_err OWNER TO letl;

--
-- Name: hu0e26tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e26tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0e26tm_err OWNER TO letl;

--
-- Name: hu0e27tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e27tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0e27tm_err OWNER TO letl;

--
-- Name: hu0e2btm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e2btm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0e2btm_err OWNER TO letl;

--
-- Name: hu0e32tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e32tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0e32tm_err OWNER TO letl;

--
-- Name: hu0e63tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e63tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0e63tm_err OWNER TO letl;

--
-- Name: hu0e64tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0e64tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0e64tm_err OWNER TO letl;

--
-- Name: hu0es1tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0es1tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0es1tm_err OWNER TO letl;

--
-- Name: hu0raatf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu0raatf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0raatf_err OWNER TO letl;

--
-- Name: hu0radtm_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE hu0radtm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0radtm_err OWNER TO gpadmin;

--
-- Name: hu0raitf_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE hu0raitf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0raitf_err OWNER TO gpadmin;

--
-- Name: hu0ramtm_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE hu0ramtm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0ramtm_err OWNER TO gpadmin;

--
-- Name: hu0rantf_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE hu0rantf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu0rantf_err OWNER TO gpadmin;

--
-- Name: hu3r5ttm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu3r5ttm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu3r5ttm_err OWNER TO letl;

--
-- Name: hu8d88tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu8d88tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu8d88tm_err OWNER TO letl;

--
-- Name: hu9e68tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hu9e68tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hu9e68tm_err OWNER TO letl;

--
-- Name: hud206tc_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hud206tc_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hud206tc_err OWNER TO letl;

--
-- Name: hud207tc_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hud207tc_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hud207tc_err OWNER TO letl;

--
-- Name: hud501tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hud501tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hud501tm_err OWNER TO letl;

--
-- Name: hud504tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hud504tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hud504tf_err OWNER TO letl;

--
-- Name: hud511tc_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hud511tc_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hud511tc_err OWNER TO letl;

--
-- Name: hud513tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hud513tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hud513tm_err OWNER TO letl;

--
-- Name: hud514tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hud514tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hud514tf_err OWNER TO letl;

--
-- Name: hud520tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hud520tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hud520tf_err OWNER TO letl;

--
-- Name: hud591tc_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hud591tc_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hud591tc_err OWNER TO letl;

--
-- Name: hud593tc_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hud593tc_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hud593tc_err OWNER TO letl;

--
-- Name: hud594tc_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hud594tc_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hud594tc_err OWNER TO letl;

--
-- Name: hue017tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hue017tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hue017tf_err OWNER TO letl;

--
-- Name: huf40dtm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE huf40dtm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.huf40dtm_err OWNER TO letl;

--
-- Name: huf410tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE huf410tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.huf410tm_err OWNER TO letl;

--
-- Name: huf415tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE huf415tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.huf415tf_err OWNER TO letl;

--
-- Name: huf419tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE huf419tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.huf419tf_err OWNER TO letl;

--
-- Name: huf41atf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE huf41atf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.huf41atf_err OWNER TO letl;

--
-- Name: huf41btf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE huf41btf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.huf41btf_err OWNER TO letl;

--
-- Name: hum008tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum008tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum008tm_err OWNER TO letl;

--
-- Name: hum201tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum201tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum201tm_err OWNER TO letl;

--
-- Name: hum202tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum202tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum202tm_err OWNER TO letl;

--
-- Name: hum203tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum203tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum203tm_err OWNER TO letl;

--
-- Name: hum204tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum204tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum204tm_err OWNER TO letl;

--
-- Name: hum210tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum210tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum210tf_err OWNER TO letl;

--
-- Name: hum211tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum211tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum211tf_err OWNER TO letl;

--
-- Name: hum213tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum213tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum213tf_err OWNER TO letl;

--
-- Name: hum218tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum218tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum218tm_err OWNER TO letl;

--
-- Name: hum219tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum219tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum219tf_err OWNER TO letl;

--
-- Name: hum401tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum401tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum401tm_err OWNER TO letl;

--
-- Name: hum402tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum402tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum402tm_err OWNER TO letl;

--
-- Name: hum403tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum403tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum403tm_err OWNER TO letl;

--
-- Name: hum405tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum405tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum405tm_err OWNER TO letl;

--
-- Name: hum493tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum493tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum493tm_err OWNER TO letl;

--
-- Name: hum507tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum507tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum507tf_err OWNER TO letl;

--
-- Name: hum508tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum508tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum508tf_err OWNER TO letl;

--
-- Name: hum516tf_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE hum516tf_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.hum516tf_err OWNER TO letl;

--
-- Name: ifgl_bsw_day_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ifgl_bsw_day_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ifgl_bsw_day_err OWNER TO letl;

--
-- Name: ifgl_bsw_mon_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ifgl_bsw_mon_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ifgl_bsw_mon_err OWNER TO letl;

--
-- Name: ifgl_coa_tbl_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ifgl_coa_tbl_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ifgl_coa_tbl_err OWNER TO letl;

--
-- Name: ifgl_isw_day_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ifgl_isw_day_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ifgl_isw_day_err OWNER TO letl;

--
-- Name: ifgl_isw_mon_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ifgl_isw_mon_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ifgl_isw_mon_err OWNER TO letl;

--
-- Name: intratrace_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE intratrace_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.intratrace_err OWNER TO letl;

--
-- Name: lcx_hal_tot_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE lcx_hal_tot_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.lcx_hal_tot_err OWNER TO letl;

--
-- Name: ld005tc_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE ld005tc_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ld005tc_err OWNER TO gpadmin;

--
-- Name: ld030tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ld030tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ld030tm_err OWNER TO letl;

--
-- Name: ld061tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ld061tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ld061tm_err OWNER TO letl;

--
-- Name: ln050tm_l_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ln050tm_l_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ln050tm_l_err OWNER TO letl;

--
-- Name: ln774tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ln774tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ln774tm_err OWNER TO letl;

--
-- Name: ln834th_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ln834th_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ln834th_err OWNER TO letl;

--
-- Name: ln836th_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE ln836th_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ln836th_err OWNER TO gpadmin;

--
-- Name: ln840th_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ln840th_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ln840th_err OWNER TO letl;

--
-- Name: ln848th_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ln848th_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ln848th_err OWNER TO letl;

--
-- Name: ln850th_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ln850th_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ln850th_err OWNER TO letl;

--
-- Name: ln852th_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ln852th_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ln852th_err OWNER TO letl;

--
-- Name: loan_day_tbl_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE loan_day_tbl_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.loan_day_tbl_err OWNER TO letl;

--
-- Name: loan_mn9988_code_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE loan_mn9988_code_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.loan_mn9988_code_err OWNER TO letl;

--
-- Name: loan_mn9988_mst_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE loan_mn9988_mst_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.loan_mn9988_mst_err OWNER TO letl;

--
-- Name: loan_rt_ms_mst_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE loan_rt_ms_mst_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.loan_rt_ms_mst_err OWNER TO letl;

--
-- Name: meta_lg_log_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE meta_lg_log_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.meta_lg_log_err OWNER TO gpadmin;

--
-- Name: misu_bis_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE misu_bis_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.misu_bis_err OWNER TO letl;

--
-- Name: ms_mst_cif_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE ms_mst_cif_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.ms_mst_cif_err OWNER TO letl;

--
-- Name: rt_ms_mst_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE rt_ms_mst_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.rt_ms_mst_err OWNER TO letl;

--
-- Name: sf_org_user_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE sf_org_user_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.sf_org_user_err OWNER TO letl;

--
-- Name: sr002tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE sr002tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.sr002tm_err OWNER TO letl;

--
-- Name: sr010tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE sr010tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.sr010tm_err OWNER TO letl;

--
-- Name: sr_prc_req_inf_sql_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE sr_prc_req_inf_sql_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.sr_prc_req_inf_sql_err OWNER TO letl;

--
-- Name: temp_hum209tf_rlt_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE temp_hum209tf_rlt_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.temp_hum209tf_rlt_err OWNER TO letl;

--
-- Name: temp_hum2153102ir01_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE temp_hum2153102ir01_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.temp_hum2153102ir01_err OWNER TO gpadmin;

--
-- Name: temp_hum2153102ir02_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE temp_hum2153102ir02_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.temp_hum2153102ir02_err OWNER TO gpadmin;

--
-- Name: temp_hum2153102ir03_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE temp_hum2153102ir03_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.temp_hum2153102ir03_err OWNER TO gpadmin;

--
-- Name: temp_hum2153102ir04_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE temp_hum2153102ir04_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.temp_hum2153102ir04_err OWNER TO gpadmin;

--
-- Name: temp_hum215tm_rlt_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE temp_hum215tm_rlt_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.temp_hum215tm_rlt_err OWNER TO letl;

--
-- Name: temp_hum216tm_rlt_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE temp_hum216tm_rlt_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.temp_hum216tm_rlt_err OWNER TO letl;

--
-- Name: temp_hum421tf_idx_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE temp_hum421tf_idx_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.temp_hum421tf_idx_err OWNER TO letl;

--
-- Name: trns_ad_mst_1001_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE trns_ad_mst_1001_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.trns_ad_mst_1001_err OWNER TO gpadmin;

--
-- Name: trns_ad_mst_1003_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE trns_ad_mst_1003_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.trns_ad_mst_1003_err OWNER TO letl;

--
-- Name: trns_ad_mst_1205_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE trns_ad_mst_1205_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.trns_ad_mst_1205_err OWNER TO gpadmin;

--
-- Name: trns_ad_mst_1_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE trns_ad_mst_1_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.trns_ad_mst_1_err OWNER TO letl;

--
-- Name: trns_ad_mst_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE trns_ad_mst_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.trns_ad_mst_err OWNER TO letl;

--
-- Name: trns_fi_doc_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE trns_fi_doc_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.trns_fi_doc_err OWNER TO letl;

--
-- Name: trns_seobu_rst_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE trns_seobu_rst_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.trns_seobu_rst_err OWNER TO letl;

--
-- Name: tum60atm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE tum60atm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.tum60atm_err OWNER TO letl;

--
-- Name: tum611tm_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE tum611tm_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.tum611tm_err OWNER TO letl;

--
-- Name: v_sess_id_err; Type: TABLE; Schema: sdmin_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE v_sess_id_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.v_sess_id_err OWNER TO gpadmin;

--
-- Name: xpr_arv_mkt_cus_err; Type: TABLE; Schema: sdmin_err; Owner: letl; Tablespace: 
--

CREATE TABLE xpr_arv_mkt_cus_err (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sdmin_err.xpr_arv_mkt_cus_err OWNER TO letl;

SET search_path = public, pg_catalog;

--
-- Name: attrep_net_changes0004DD7138071E4F_attrep_net_changes0004DD7138; Type: CONSTRAINT; Schema: public; Owner: lcdc; Tablespace: 
--

ALTER TABLE ONLY "attrep_net_changes0004DD7138071E4F"
    ADD CONSTRAINT "attrep_net_changes0004DD7138071E4F_attrep_net_changes0004DD7138" PRIMARY KEY (seq);


--
-- Name: attrep_net_changes0004DD72F535290F_attrep_net_changes0004DD72F5; Type: CONSTRAINT; Schema: public; Owner: gpadmin; Tablespace: 
--

ALTER TABLE ONLY "attrep_net_changes0004DD72F535290F"
    ADD CONSTRAINT "attrep_net_changes0004DD72F535290F_attrep_net_changes0004DD72F5" PRIMARY KEY (seq);


--
-- Name: attrep_net_changes0004DD7C6D428EFE_attrep_net_changes0004DD7C6D; Type: CONSTRAINT; Schema: public; Owner: letl; Tablespace: 
--

ALTER TABLE ONLY "attrep_net_changes0004DD7C6D428EFE"
    ADD CONSTRAINT "attrep_net_changes0004DD7C6D428EFE_attrep_net_changes0004DD7C6D" PRIMARY KEY (seq);


--
-- Name: attrep_net_changes0004DDA8F7B178D2_attrep_net_changes0004DDA8F7; Type: CONSTRAINT; Schema: public; Owner: letl; Tablespace: 
--

ALTER TABLE ONLY "attrep_net_changes0004DDA8F7B178D2"
    ADD CONSTRAINT "attrep_net_changes0004DDA8F7B178D2_attrep_net_changes0004DDA8F7" PRIMARY KEY (seq);


--
-- Name: sn2ro_crud_pkey; Type: CONSTRAINT; Schema: public; Owner: letl; Tablespace: 
--

ALTER TABLE ONLY sn2ro_crud
    ADD CONSTRAINT sn2ro_crud_pkey PRIMARY KEY (schemaname, tablename);


SET search_path = sdmim, pg_catalog;

--
-- Name: acnt_ac_code_1_ACNT_AC_CODE_P; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX "acnt_ac_code_1_ACNT_AC_CODE_P" ON acnt_ac_code_1 USING btree (aacpaccd, aacuaccd, aacattr1);


--
-- Name: acnt_ac_code_b_p; Type: INDEX; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX acnt_ac_code_b_p ON acnt_ac_code_b USING btree (aacpaccd, aacuaccd, aacattr1);


--
-- Name: acnt_ac_code_p; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX acnt_ac_code_p ON acnt_ac_code USING btree (aacpaccd, aacuaccd, aacattr1);


--
-- Name: audt_ja_confirm_1_IDX_AUDT_JA_CONFIRM_UK; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX "audt_ja_confirm_1_IDX_AUDT_JA_CONFIRM_UK" ON audt_ja_confirm_1 USING btree (trn_dt, trn_brno, audit_cd, logno, uk_inf);


--
-- Name: audt_ja_confirm_b_uk; Type: INDEX; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX audt_ja_confirm_b_uk ON audt_ja_confirm_b USING btree (trn_dt, trn_brno, audit_cd, logno, uk_inf);


--
-- Name: audt_ja_confirm_uk; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX audt_ja_confirm_uk ON audt_ja_confirm USING btree (trn_dt, trn_brno, audit_cd, logno, uk_inf);


--
-- Name: card_flc_mi_b_uk; Type: INDEX; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX card_flc_mi_b_uk ON card_flc_mihando_b USING btree (rljadate, rljabrno, rljasmno, rljaaccd);


--
-- Name: card_flc_mi_uk; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX card_flc_mi_uk ON card_flc_mihando USING btree (rljadate, rljabrno, rljasmno, rljaaccd);


--
-- Name: card_flc_mihando_1_CARD_FLC_MI_P_KEY; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX "card_flc_mihando_1_CARD_FLC_MI_P_KEY" ON card_flc_mihando_1 USING btree (rljadate, rljabrno, rljasmno, rljaaccd);


--
-- Name: card_flc_mst_1_CARD_FLC_UK; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX "card_flc_mst_1_CARD_FLC_UK" ON card_flc_mst_1 USING btree (rljadate, rljabrno, rljasmno, rljaaccd, rljaseq);


--
-- Name: card_flc_mst_CARD_FLC_UK; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX "card_flc_mst_CARD_FLC_UK" ON card_flc_mst USING btree (rljadate, rljabrno, rljasmno, rljaaccd, rljaseq);


--
-- Name: card_flc_uk_b; Type: INDEX; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX card_flc_uk_b ON card_flc_mst_b USING btree (rljadate, rljabrno, rljasmno, rljaaccd, rljaseq);


--
-- Name: comm_br_b_pk; Type: INDEX; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX comm_br_b_pk ON comm_br_brch_b USING btree (zbrbrcd);


--
-- Name: comm_br_brch_1_COMM_BR_PK; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX "comm_br_brch_1_COMM_BR_PK" ON comm_br_brch_1 USING btree (zbrbrcd);


--
-- Name: comm_br_pk; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX comm_br_pk ON comm_br_brch USING btree (zbrbrcd);


--
-- Name: cust_ba_b_pk; Type: INDEX; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX cust_ba_b_pk ON cust_ba_base_b USING btree (cbacidno);


--
-- Name: cust_ba_base_1_CUST_BA_EOB_I; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX "cust_ba_base_1_CUST_BA_EOB_I" ON cust_ba_base_1 USING btree (cbaeobname, cbacidno);


--
-- Name: cust_ba_juso_b_p; Type: INDEX; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX cust_ba_juso_b_p ON cust_ba_juso_b USING btree (cbcidno, cbkind);


--
-- Name: cust_ba_juso_p; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX cust_ba_juso_p ON cust_ba_juso USING btree (cbcidno, cbkind);


--
-- Name: cust_ba_juso_p_1; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX cust_ba_juso_p_1 ON cust_ba_juso_1 USING btree (cbcidno, cbkind);


--
-- Name: cust_ba_pk; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX cust_ba_pk ON cust_ba_base USING btree (cbacidno);


--
-- Name: depo_ac_comm_1_DEPO_AC_COMM_P; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX "depo_ac_comm_1_DEPO_AC_COMM_P" ON depo_ac_comm_1 USING btree (dacacno, dacaccd);


--
-- Name: depo_ac_comm_b_p; Type: INDEX; Schema: sdmim; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX depo_ac_comm_b_p ON depo_ac_comm_b USING btree (dacacno, dacaccd);


--
-- Name: depo_ac_comm_p; Type: INDEX; Schema: sdmim; Owner: lcdc; Tablespace: 
--

CREATE UNIQUE INDEX depo_ac_comm_p ON depo_ac_comm USING btree (dacacno, dacaccd);


SET search_path = sdmin, pg_catalog;

--
-- Name: acnt_ac_code_b_p; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX acnt_ac_code_b_p ON acnt_ac_code_b9 USING btree (aacpaccd, aacuaccd, aacattr1);


--
-- Name: acnt_ac_code_p; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX acnt_ac_code_p ON acnt_ac_code USING btree (aacpaccd, aacuaccd, aacattr1);


--
-- Name: audt_ja_confirm_b_uk; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX audt_ja_confirm_b_uk ON audt_ja_confirm_b9 USING btree (trn_dt, trn_brno, audit_cd, logno, uk_inf);


--
-- Name: audt_ja_confirm_uk; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX audt_ja_confirm_uk ON audt_ja_confirm USING btree (trn_dt, trn_brno, audit_cd, logno, uk_inf);


--
-- Name: card_flc_mi_b_uk; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX card_flc_mi_b_uk ON card_flc_mihando_b9 USING btree (rljadate, rljabrno, rljasmno, rljaaccd);


--
-- Name: card_flc_mihando_CARD_FLC_MI_P_KEY; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX "card_flc_mihando_CARD_FLC_MI_P_KEY" ON card_flc_mihando USING btree (rljadate, rljabrno, rljasmno, rljaaccd);


--
-- Name: card_flc_mst_CARD_FLC_UK; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX "card_flc_mst_CARD_FLC_UK" ON card_flc_mst USING btree (rljadate, rljabrno, rljasmno, rljaaccd, rljaseq);


--
-- Name: card_flc_uk_b; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX card_flc_uk_b ON card_flc_mst_b9 USING btree (rljadate, rljabrno, rljasmno, rljaaccd, rljaseq);


--
-- Name: comm_br_b_pk; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX comm_br_b_pk ON comm_br_brch_b9 USING btree (zbrbrcd);


--
-- Name: comm_br_pk; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX comm_br_pk ON comm_br_brch USING btree (zbrbrcd);


--
-- Name: cust_ba_b_pk; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX cust_ba_b_pk ON cust_ba_base_b9 USING btree (cbacidno);


--
-- Name: cust_ba_juso_b_p; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX cust_ba_juso_b_p ON cust_ba_juso_b9 USING btree (cbcidno, cbkind);


--
-- Name: cust_ba_juso_p; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX cust_ba_juso_p ON cust_ba_juso USING btree (cbcidno, cbkind);


--
-- Name: cust_ba_pk; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX cust_ba_pk ON cust_ba_base USING btree (cbacidno);


--
-- Name: depo_ac_comm_b_p; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX depo_ac_comm_b_p ON depo_ac_comm_b9 USING btree (dacacno, dacaccd);


--
-- Name: depo_ac_comm_p; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX depo_ac_comm_p ON depo_ac_comm USING btree (dacacno, dacaccd);


--
-- Name: hu0b18u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0b18u1 ON hu0b18tc USING btree (wfg_cd, aloc_scnr_id, aply_edt);


--
-- Name: hu0b19u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0b19u1 ON hu0b19tc USING btree (wfg_cd, aloc_scnr_id, aloc_tp_dscd, bas_colm_pri_rk, aply_edt);


--
-- Name: hu0b19x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0b19x2 ON hu0b19tc USING btree (wfg_cd, aloc_scnr_id, aply_edt);


--
-- Name: hu0b20u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0b20u1 ON hu0b20tm USING btree (wfg_cd, bas_dt, wk_bsdt, scnr_id, aply_edt);


--
-- Name: hu0b20x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0b20x2 ON hu0b20tm USING btree (wfg_cd, scnr_id, aply_edt);


--
-- Name: hu0b21u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0b21u1 ON hu0b21tm USING btree (wfg_cd, scnr_id, aply_edt);


--
-- Name: hu0b21x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0b21x2 ON hu0b21tm USING btree (wfg_cd, aloc_scnr_id, aply_edt);


--
-- Name: hu0b21x3; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0b21x3 ON hu0b21tm USING btree (wfg_cd, ead_scnr_id, aply_edt);


--
-- Name: hu0b21x4; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0b21x4 ON hu0b21tm USING btree (wfg_cd, pd_scnr_id, aply_edt);


--
-- Name: hu0b21x5; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0b21x5 ON hu0b21tm USING btree (wfg_cd, lgd_scnr_id, aply_edt);


--
-- Name: hu0b21x6; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0b21x6 ON hu0b21tm USING btree (wfg_cd, fnd_vol_scnr_id, aply_edt);


--
-- Name: hu0b21x7; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0b21x7 ON hu0b21tm USING btree (wfg_cd, tm_scnr_id, aply_edt);


--
-- Name: hu0b34u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0b34u1 ON hu0b34tc USING btree (wfg_cd, bic_cd, aply_edt);


--
-- Name: hu0b41u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0b41u1 ON hu0b41tc USING btree (wfg_cd, lgd_scnr_id, mmgg_col_rt_dscd, vtl_dscd, aply_edt);


--
-- Name: hu0b41x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0b41x2 ON hu0b41tc USING btree (wfg_cd, lgd_scnr_id, aply_edt);


--
-- Name: hu0b44u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0b44u1 ON hu0b44tc USING btree (wfg_cd, pd_scnr_id, rtsel_pol_id, aply_edt);


--
-- Name: hu0b44x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0b44x2 ON hu0b44tc USING btree (wfg_cd, pd_scnr_id, aply_edt);


--
-- Name: hu0d01x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0d01x2 ON hu0d01tm USING btree (psco_rgno, bas_dt, wfg_cd);


--
-- Name: hu0d01x3; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0d01x3 ON hu0d01tm USING btree (psbz_no, bas_dt, wfg_cd);


--
-- Name: hu0d01x4; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0d01x4 ON hu0d01tm USING btree (ctp_id, bas_dt, wfg_cd);


--
-- Name: hu0d01x5; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0d01x5 ON hu0d01tm USING btree (wfg_cd, psco_rgno, bas_dt, dsh_yn);


--
-- Name: hu0d01x6; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0d01x6 ON hu0d01tm USING btree (wfg_cd, bas_dt, dsh_ocr_dt, dmn_dsh_yn, crd_evl_mdl_dscd);


--
-- Name: hu0d02x4; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0d02x4 ON hu0d02tm USING btree (wfg_cd, bas_dt, ctp_id);


--
-- Name: hu0d02x6; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0d02x6 ON hu0d02tm USING btree (wfg_cd, bas_dt, psco_rgno);


--
-- Name: hu0d02x7; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0d02x7 ON hu0d02tm USING btree (wfg_cd, bas_dt, lmt_agr_id);


--
-- Name: hu0d02x8; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0d02x8 ON hu0d02tm USING btree (wfg_cd, xps_id);


--
-- Name: hu0d05x3; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0d05x3 ON hu0d05tm USING btree (wfg_cd, bas_dt, ctp_id);


--
-- Name: hu0d05x6; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0d05x6 ON hu0d05tm USING btree (wfg_cd, bas_dt, xps_id);


--
-- Name: hu0d88x1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0d88x1 ON hu0d88tm USING btree (wfg_cd, bas_dt, psco_rgno);


--
-- Name: hu0d99u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0d99u1 ON hu0d99tm USING btree (wfg_cd, bas_dt, psco_rgno, ctp_id, xps_id, acc_cd);


--
-- Name: hu0e0cu1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0e0cu1 ON hu0e0ctm USING btree (wfg_cd, rtsel_pol_id, aply_edt);


--
-- Name: hu0e13u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0e13u1 ON hu0e13tm USING btree (wfg_cd, bas_dt, anl_tgt_tm_cd, pd_anl_mtd_dscd, rtsel_pol_id, aply_edt);


--
-- Name: hu0e13x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0e13x2 ON hu0e13tm USING btree (wfg_cd, bas_dt, anl_tgt_tm_cd, pd_anl_mtd_dscd, aply_edt);


--
-- Name: hu0e26u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0e26u1 ON hu0e26tm USING btree (wfg_cd, rc_crdrk_cd, aply_edt);


--
-- Name: hu0e27u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0e27u1 ON hu0e27tm USING btree (wfg_cd, nbis_ptf_dscd, ser_no, aply_edt);


--
-- Name: hu0e2bu1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0e2bu1 ON hu0e2btm USING btree (wfg_cd, nbis_apl_ar_dscd, nbis_dtl_apl_id, nbis_hdw_para_id, aply_edt);


--
-- Name: hu0e32u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0e32u1 ON hu0e32tm USING btree (wfg_cd, acc_dscd, acc_cd, ln_op_dscd, aply_edt);


--
-- Name: hu0e63u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0e63u1 ON hu0e63tm USING btree (wfg_cd, mgg_dscd, mmgg_kdcd, mgg_musg_cd, aply_edt);


--
-- Name: hu0e64u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0e64u1 ON hu0e64tm USING btree (wfg_cd, nbis_mgcrt_dscd, vtl_sta_rt, vtl_end_rt, aply_edt);


--
-- Name: hu0es1u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0es1u1 ON hu0es1tm USING btree (wfg_cd, bas_dt, anl_tgt_tm_cd, pd_anl_mtd_dscd, rtsel_pol_id, aply_edt);


--
-- Name: hu0raau1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu0raau1 ON hu0raatf USING btree (wk_dt, wk_id, prc_id);


--
-- Name: hu0raax2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0raax2 ON hu0raatf USING btree (wk_id);


--
-- Name: hu0raax3; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0raax3 ON hu0raatf USING btree (err_id, sys_dis_nm);


--
-- Name: hu0raax4; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu0raax4 ON hu0raatf USING btree (wk_bsdt);


--
-- Name: hu3r5tu1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu3r5tu1 ON hu3r5ttm USING btree (wfg_cd, bas_dt, psco_rgno, aply_edt);


--
-- Name: hu8d88x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hu8d88x2 ON hu8d88tm USING btree (wfg_cd, bas_dt, ifrs_scnr_id, psco_rgno);


--
-- Name: hu9e68u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hu9e68u1 ON hu9e68tm USING btree (wfg_cd, mgg_dscd, mmgg_kdcd, mgg_musg_cd, aply_edt);


--
-- Name: hud206x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hud206x2 ON hud206tc USING btree (nbis_crd_mtg_dscd, aply_edt);


--
-- Name: hud501u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hud501u1 ON hud501tm USING btree (wfg_cd, psco_rgno, evl_dt);


--
-- Name: hud504u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hud504u1 ON hud504tf USING btree (nat_cd, oist_evl_ist_cd, evl_dt, oist_crdrk_dscd);


--
-- Name: hud511u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hud511u1 ON hud511tc USING btree (isupe_psco_rgno, scrt_itm_cd);


--
-- Name: hud513u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hud513u1 ON hud513tm USING btree (isupe_psco_rgno, scrt_itm_cd, evl_dt, oist_evl_ist_cd, oist_crdrk_dscd);


--
-- Name: hud513x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hud513x2 ON hud513tm USING btree (scrt_itm_cd, isupe_psco_rgno);


--
-- Name: hud514u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hud514u1 ON hud514tf USING btree (corp_no, oist_evl_ist_cd, evl_dt, oist_crdrk_dscd, nbis_dat_src_dscd);


--
-- Name: hud520u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hud520u1 ON hud520tf USING btree (wfg_cd, psco_rgno, evl_dt, cpbnd_evl_ist_cd, cpbnd_cbevl_dscd, cpbnd_evl_srno);


--
-- Name: hud591u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hud591u1 ON hud591tc USING btree (std_ctp_tpcd, oist_evl_ist_cd, oist_crdrk_dscd, oist_crdrk_txt, aply_edt);


--
-- Name: hud593u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hud593u1 ON hud593tc USING btree (wfg_cd, crd_evl_mdl_dscd, aply_edt);


--
-- Name: hud594u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hud594u1 ON hud594tc USING btree (wfg_cd, rtsel_pol_id, aply_edt);


--
-- Name: hue017x3; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hue017x3 ON hue017tf USING btree (acc_pctgt_yn, rwa_caltg_xcp_yn, aply_edt);


--
-- Name: huf40du1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX huf40du1 ON huf40dtm USING btree (wfg_cd, bas_dt, xps_id);


--
-- Name: huf410x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX huf410x2 ON huf410tm USING btree (wfg_cd, bas_dt, ctp_id);


--
-- Name: huf410x3; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX huf410x3 ON huf410tm USING btree (wfg_cd, bas_dt, psco_rgno);


--
-- Name: huf415u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX huf415u1 ON huf415tf USING btree (wfg_cd, bas_dt, xps_id, acc_cd, cur_cd);


--
-- Name: huf419u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX huf419u1 ON huf419tf USING btree (wfg_cd, bas_dt, xps_id, acc_cd, cur_cd, act_mngbr_cd, trtuni_cd, bdsys_dscd);


--
-- Name: huf41au1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX huf41au1 ON huf41atf USING btree (wfg_cd, bas_dt, xps_id, acc_cd, cur_cd);


--
-- Name: huf41bu1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX huf41bu1 ON huf41btf USING btree (wfg_cd, bas_dt, xps_id, acc_cd, cur_cd, act_mngbr_cd, trtuni_cd, bdsys_dscd);


--
-- Name: hum008u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum008u1 ON hum008tm USING btree (wfg_cd, bas_dt, br_cd);


--
-- Name: hum201u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum201u1 ON hum201tm USING btree (wfg_cd, bas_dt, mgg_id);


--
-- Name: hum202u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum202u1 ON hum202tm USING btree (wfg_cd, bas_dt, mgg_id, his_no);


--
-- Name: hum203u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum203u1 ON hum203tm USING btree (wfg_cd, bas_dt, mgg_id, his_no);


--
-- Name: hum203x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hum203x2 ON hum203tm USING btree (mgg_id, wfg_cd, bas_dt);


--
-- Name: hum204u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum204u1 ON hum204tm USING btree (wfg_cd, bas_dt, mgg_id, his_no);


--
-- Name: hum204x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hum204x2 ON hum204tm USING btree (mgg_id, wfg_cd, bas_dt);


--
-- Name: hum210u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum210u1 ON hum210tf USING btree (wfg_cd, bas_dt, mgg_id, est_srno, lmt_agr_id);


--
-- Name: hum210x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hum210x2 ON hum210tf USING btree (wfg_cd, mgg_id, est_srno, bas_dt);


--
-- Name: hum210x3; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hum210x3 ON hum210tf USING btree (wfg_cd, lmt_agr_id, bas_dt);


--
-- Name: hum211u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum211u1 ON hum211tf USING btree (wfg_cd, bas_dt, mgg_id, est_srno);


--
-- Name: hum211x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hum211x2 ON hum211tf USING btree (wfg_cd, mgg_id, bas_dt);


--
-- Name: hum213u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum213u1 ON hum213tf USING btree (wfg_cd, bas_yr, bas_qr_mn, crt_dong_sido_cd, adm_sgg_cd, mgg_usg_ref_cd, sbid_rt_dscd);


--
-- Name: hum218u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum218u1 ON hum218tm USING btree (wfg_cd, bas_dt, mgg_id, rnt_srno);


--
-- Name: hum219u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum219u1 ON hum219tf USING btree (wfg_cd, sido_cd, adm_sgg_cd, adm_dem_cd, li_cd, rgn_tpcd, vld_sdt);


--
-- Name: hum401u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum401u1 ON hum401tm USING btree (wfg_cd, bas_dt, xps_id);


--
-- Name: hum401x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hum401x2 ON hum401tm USING btree (ctp_id, wfg_cd, bas_dt);


--
-- Name: hum401x3; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hum401x3 ON hum401tm USING btree (wfg_cd, lmt_agr_id, bas_dt);


--
-- Name: hum402u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum402u1 ON hum402tm USING btree (wfg_cd, bas_dt, xps_id);


--
-- Name: hum402x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hum402x2 ON hum402tm USING btree (wfg_cd, psc_mctr_co_bzno, psc_mctr_cocd_srno, bas_dt);


--
-- Name: hum402x3; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hum402x3 ON hum402tm USING btree (wfg_cd, bas_dt, b2bmctr_copnt_cd);


--
-- Name: hum405u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum405u1 ON hum405tm USING btree (wfg_cd, bas_dt, xps_id);


--
-- Name: hum493x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hum493x2 ON hum493tm USING btree (wfg_cd, bas_dt, xps_id);


--
-- Name: hum507u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum507u1 ON hum507tf USING btree (wfg_cd, bas_dt, oist_crdrk_dscd, corp_no, std_ctp_tpcd);


--
-- Name: hum507x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hum507x2 ON hum507tf USING btree (wfg_cd, corp_no, oist_crdrk_dscd, bas_dt);


--
-- Name: hum508u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX hum508u1 ON hum508tf USING btree (wfg_cd, bas_dt, oist_crdrk_dscd, nat_cd, std_ctp_tpcd);


--
-- Name: hum516x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hum516x2 ON hum516tf USING btree (wfg_cd, isu_ist_corpno, oist_crdrk_dscd, bas_dt);


--
-- Name: hum701x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX hum701x2 ON hum701tm USING btree (wfg_cd, bas_dt, psco_rgno, ctp_id);


--
-- Name: idx_connectby_tree_ke; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX idx_connectby_tree_ke ON connectby_tree USING btree (keyid);


--
-- Name: idx_connectby_tree_parent_keyid; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX idx_connectby_tree_parent_keyid ON connectby_tree USING btree (parent_keyid);


--
-- Name: t_um421u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX t_um421u1 ON temp_hum421tf_idx USING btree (wfg_cd, bas_dt, wk_bsdt, rwa_cal_id);


--
-- Name: tmp_hum701tm_01x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX tmp_hum701tm_01x2 ON tmp_hum701tm_01 USING btree (psco_rgno);


--
-- Name: tum209u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX tum209u1 ON temp_hum209tf_rlt USING btree (wfg_cd, bas_dt, wk_bsdt, crd_mtg_id);


--
-- Name: tum210u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX tum210u1 ON tum210tf USING btree (wfg_cd, bas_dt, mgg_id, est_srno);


--
-- Name: tum210x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX tum210x2 ON tum210tf USING btree (wfg_cd, bas_dt, mgg_id);


--
-- Name: tum211u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX tum211u1 ON tum211tf USING btree (wfg_cd, bas_dt, mgg_id, est_srno);


--
-- Name: tum211x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX tum211x2 ON tum211tf USING btree (wfg_cd, bas_dt, mgg_id);


--
-- Name: tum215u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX tum215u1 ON temp_hum215tm_rlt USING btree (wfg_cd, bas_dt, wk_bsdt, aloc_scnr_id, crd_mtg_id, rwa_cal_id);


--
-- Name: tum215x1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX tum215x1 ON temp_hum215tm_rlt USING btree (wfg_cd, bas_dt, wk_bsdt, aloc_scnr_id, rwa_cal_id);


--
-- Name: tum216u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX tum216u1 ON temp_hum216tm_rlt USING btree (wfg_cd, bas_dt, wk_bsdt, crd_mtg_id, rwa_cal_id);


--
-- Name: tum2x1u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX tum2x1u1 ON tum20101 USING btree (wfg_cd, bas_dt, mgg_id, his_no);


--
-- Name: tum2x1x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX tum2x1x2 ON tum20101 USING btree (wfg_cd, bas_dt, mgg_id);


--
-- Name: tum2x2u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX tum2x2u1 ON tum20102 USING btree (wfg_cd, bas_dt, mgg_id, est_srno);


--
-- Name: tum2x2x2; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE INDEX tum2x2x2 ON tum20102 USING btree (wfg_cd, bas_dt, mgg_id);


--
-- Name: tum60au1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX tum60au1 ON tum60atm USING btree (wfg_cd, bas_dt, xps_id, acc_dscd, acc_cd);


--
-- Name: tum611u1; Type: INDEX; Schema: sdmin; Owner: letl; Tablespace: 
--

CREATE UNIQUE INDEX tum611u1 ON tum611tm USING btree (wfg_cd, bas_dt, xps_id, acc_dscd, acc_cd);


--
-- Name: oracompat; Type: ACL; Schema: -; Owner: gpadmin
--

REVOKE ALL ON SCHEMA oracompat FROM PUBLIC;
REVOKE ALL ON SCHEMA oracompat FROM gpadmin;
GRANT ALL ON SCHEMA oracompat TO gpadmin;
GRANT ALL ON SCHEMA oracompat TO lolap;
GRANT ALL ON SCHEMA oracompat TO letl;
GRANT ALL ON SCHEMA oracompat TO ladhoc;
GRANT ALL ON SCHEMA oracompat TO loltp;


--
-- Name: public; Type: ACL; Schema: -; Owner: gpadmin
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM gpadmin;
GRANT ALL ON SCHEMA public TO gpadmin;
GRANT ALL ON SCHEMA public TO lolap;
GRANT ALL ON SCHEMA public TO letl;
GRANT ALL ON SCHEMA public TO ladhoc;
GRANT ALL ON SCHEMA public TO loltp;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: sdmim; Type: ACL; Schema: -; Owner: lcdc
--

REVOKE ALL ON SCHEMA sdmim FROM PUBLIC;
REVOKE ALL ON SCHEMA sdmim FROM lcdc;
GRANT ALL ON SCHEMA sdmim TO lcdc;
GRANT ALL ON SCHEMA sdmim TO ladhoc;
GRANT ALL ON SCHEMA sdmim TO letl;
GRANT ALL ON SCHEMA sdmim TO lolap;
GRANT ALL ON SCHEMA sdmim TO loltp;
GRANT ALL ON SCHEMA sdmim TO gpadmin;


--
-- Name: sdmin; Type: ACL; Schema: -; Owner: letl
--

REVOKE ALL ON SCHEMA sdmin FROM PUBLIC;
REVOKE ALL ON SCHEMA sdmin FROM letl;
GRANT ALL ON SCHEMA sdmin TO letl;
GRANT ALL ON SCHEMA sdmin TO lolap;
GRANT ALL ON SCHEMA sdmin TO ladhoc;
GRANT ALL ON SCHEMA sdmin TO ldba;
GRANT ALL ON SCHEMA sdmin TO loltp;


--
-- Name: sdmin_err; Type: ACL; Schema: -; Owner: gpadmin
--

REVOKE ALL ON SCHEMA sdmin_err FROM PUBLIC;
REVOKE ALL ON SCHEMA sdmin_err FROM gpadmin;
GRANT ALL ON SCHEMA sdmin_err TO gpadmin;
GRANT ALL ON SCHEMA sdmin_err TO letl;
GRANT ALL ON SCHEMA sdmin_err TO lolap;
GRANT ALL ON SCHEMA sdmin_err TO ladhoc;
GRANT ALL ON SCHEMA sdmin_err TO ldba;
GRANT ALL ON SCHEMA sdmin_err TO loltp;


SET search_path = sdmim, pg_catalog;

--
-- Name: acnt_ac_code; Type: ACL; Schema: sdmim; Owner: lcdc
--

REVOKE ALL ON TABLE acnt_ac_code FROM PUBLIC;
REVOKE ALL ON TABLE acnt_ac_code FROM lcdc;
GRANT ALL ON TABLE acnt_ac_code TO lcdc;
GRANT ALL ON TABLE acnt_ac_code TO letl;
GRANT ALL ON TABLE acnt_ac_code TO ladhoc;
GRANT ALL ON TABLE acnt_ac_code TO lolap;
GRANT ALL ON TABLE acnt_ac_code TO loltp;


--
-- Name: acnt_ac_code_b; Type: ACL; Schema: sdmim; Owner: letl
--

REVOKE ALL ON TABLE acnt_ac_code_b FROM PUBLIC;
REVOKE ALL ON TABLE acnt_ac_code_b FROM letl;
GRANT ALL ON TABLE acnt_ac_code_b TO letl;
GRANT ALL ON TABLE acnt_ac_code_b TO ladhoc;
GRANT ALL ON TABLE acnt_ac_code_b TO lolap;
GRANT ALL ON TABLE acnt_ac_code_b TO loltp;


--
-- Name: audt_ja_confirm; Type: ACL; Schema: sdmim; Owner: lcdc
--

REVOKE ALL ON TABLE audt_ja_confirm FROM PUBLIC;
REVOKE ALL ON TABLE audt_ja_confirm FROM lcdc;
GRANT ALL ON TABLE audt_ja_confirm TO lcdc;
GRANT ALL ON TABLE audt_ja_confirm TO letl;
GRANT ALL ON TABLE audt_ja_confirm TO ladhoc;
GRANT ALL ON TABLE audt_ja_confirm TO lolap;
GRANT ALL ON TABLE audt_ja_confirm TO loltp;


--
-- Name: audt_ja_confirm_b; Type: ACL; Schema: sdmim; Owner: letl
--

REVOKE ALL ON TABLE audt_ja_confirm_b FROM PUBLIC;
REVOKE ALL ON TABLE audt_ja_confirm_b FROM letl;
GRANT ALL ON TABLE audt_ja_confirm_b TO letl;
GRANT ALL ON TABLE audt_ja_confirm_b TO ladhoc;
GRANT ALL ON TABLE audt_ja_confirm_b TO lolap;
GRANT ALL ON TABLE audt_ja_confirm_b TO loltp;


--
-- Name: card_flc_mihando; Type: ACL; Schema: sdmim; Owner: lcdc
--

REVOKE ALL ON TABLE card_flc_mihando FROM PUBLIC;
REVOKE ALL ON TABLE card_flc_mihando FROM lcdc;
GRANT ALL ON TABLE card_flc_mihando TO lcdc;
GRANT ALL ON TABLE card_flc_mihando TO letl;
GRANT ALL ON TABLE card_flc_mihando TO ladhoc;
GRANT ALL ON TABLE card_flc_mihando TO lolap;
GRANT ALL ON TABLE card_flc_mihando TO loltp;


--
-- Name: card_flc_mihando_b; Type: ACL; Schema: sdmim; Owner: letl
--

REVOKE ALL ON TABLE card_flc_mihando_b FROM PUBLIC;
REVOKE ALL ON TABLE card_flc_mihando_b FROM letl;
GRANT ALL ON TABLE card_flc_mihando_b TO letl;
GRANT ALL ON TABLE card_flc_mihando_b TO ladhoc;
GRANT ALL ON TABLE card_flc_mihando_b TO lolap;
GRANT ALL ON TABLE card_flc_mihando_b TO loltp;


--
-- Name: card_flc_mst_b; Type: ACL; Schema: sdmim; Owner: letl
--

REVOKE ALL ON TABLE card_flc_mst_b FROM PUBLIC;
REVOKE ALL ON TABLE card_flc_mst_b FROM letl;
GRANT ALL ON TABLE card_flc_mst_b TO letl;
GRANT ALL ON TABLE card_flc_mst_b TO ladhoc;
GRANT ALL ON TABLE card_flc_mst_b TO lolap;
GRANT ALL ON TABLE card_flc_mst_b TO loltp;


--
-- Name: comm_br_brch; Type: ACL; Schema: sdmim; Owner: lcdc
--

REVOKE ALL ON TABLE comm_br_brch FROM PUBLIC;
REVOKE ALL ON TABLE comm_br_brch FROM lcdc;
GRANT ALL ON TABLE comm_br_brch TO lcdc;
GRANT ALL ON TABLE comm_br_brch TO letl;
GRANT ALL ON TABLE comm_br_brch TO ladhoc;
GRANT ALL ON TABLE comm_br_brch TO lolap;
GRANT ALL ON TABLE comm_br_brch TO loltp;


--
-- Name: comm_br_brch_b; Type: ACL; Schema: sdmim; Owner: letl
--

REVOKE ALL ON TABLE comm_br_brch_b FROM PUBLIC;
REVOKE ALL ON TABLE comm_br_brch_b FROM letl;
GRANT ALL ON TABLE comm_br_brch_b TO letl;
GRANT ALL ON TABLE comm_br_brch_b TO ladhoc;
GRANT ALL ON TABLE comm_br_brch_b TO lolap;
GRANT ALL ON TABLE comm_br_brch_b TO loltp;


--
-- Name: cust_ba_base; Type: ACL; Schema: sdmim; Owner: lcdc
--

REVOKE ALL ON TABLE cust_ba_base FROM PUBLIC;
REVOKE ALL ON TABLE cust_ba_base FROM lcdc;
GRANT ALL ON TABLE cust_ba_base TO lcdc;
GRANT ALL ON TABLE cust_ba_base TO letl;
GRANT ALL ON TABLE cust_ba_base TO ladhoc;
GRANT ALL ON TABLE cust_ba_base TO lolap;
GRANT ALL ON TABLE cust_ba_base TO loltp;


--
-- Name: cust_ba_base_b; Type: ACL; Schema: sdmim; Owner: letl
--

REVOKE ALL ON TABLE cust_ba_base_b FROM PUBLIC;
REVOKE ALL ON TABLE cust_ba_base_b FROM letl;
GRANT ALL ON TABLE cust_ba_base_b TO letl;
GRANT ALL ON TABLE cust_ba_base_b TO ladhoc;
GRANT ALL ON TABLE cust_ba_base_b TO lolap;
GRANT ALL ON TABLE cust_ba_base_b TO loltp;


--
-- Name: cust_ba_juso; Type: ACL; Schema: sdmim; Owner: lcdc
--

REVOKE ALL ON TABLE cust_ba_juso FROM PUBLIC;
REVOKE ALL ON TABLE cust_ba_juso FROM lcdc;
GRANT ALL ON TABLE cust_ba_juso TO lcdc;
GRANT ALL ON TABLE cust_ba_juso TO letl;
GRANT ALL ON TABLE cust_ba_juso TO ladhoc;
GRANT ALL ON TABLE cust_ba_juso TO lolap;
GRANT ALL ON TABLE cust_ba_juso TO loltp;


--
-- Name: cust_ba_juso_b; Type: ACL; Schema: sdmim; Owner: letl
--

REVOKE ALL ON TABLE cust_ba_juso_b FROM PUBLIC;
REVOKE ALL ON TABLE cust_ba_juso_b FROM letl;
GRANT ALL ON TABLE cust_ba_juso_b TO letl;
GRANT ALL ON TABLE cust_ba_juso_b TO ladhoc;
GRANT ALL ON TABLE cust_ba_juso_b TO lolap;
GRANT ALL ON TABLE cust_ba_juso_b TO loltp;


--
-- Name: depo_ac_comm; Type: ACL; Schema: sdmim; Owner: lcdc
--

REVOKE ALL ON TABLE depo_ac_comm FROM PUBLIC;
REVOKE ALL ON TABLE depo_ac_comm FROM lcdc;
GRANT ALL ON TABLE depo_ac_comm TO lcdc;
GRANT ALL ON TABLE depo_ac_comm TO letl;
GRANT ALL ON TABLE depo_ac_comm TO ladhoc;
GRANT ALL ON TABLE depo_ac_comm TO lolap;
GRANT ALL ON TABLE depo_ac_comm TO loltp;


--
-- Name: depo_ac_comm_b; Type: ACL; Schema: sdmim; Owner: letl
--

REVOKE ALL ON TABLE depo_ac_comm_b FROM PUBLIC;
REVOKE ALL ON TABLE depo_ac_comm_b FROM letl;
GRANT ALL ON TABLE depo_ac_comm_b TO letl;
GRANT ALL ON TABLE depo_ac_comm_b TO ladhoc;
GRANT ALL ON TABLE depo_ac_comm_b TO lolap;
GRANT ALL ON TABLE depo_ac_comm_b TO loltp;


SET search_path = sdmin, pg_catalog;

--
-- Name: acnt_ac_code; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE acnt_ac_code FROM PUBLIC;
REVOKE ALL ON TABLE acnt_ac_code FROM letl;
GRANT ALL ON TABLE acnt_ac_code TO letl;
GRANT ALL ON TABLE acnt_ac_code TO ladhoc;
GRANT ALL ON TABLE acnt_ac_code TO lolap;
GRANT ALL ON TABLE acnt_ac_code TO loltp;


--
-- Name: acnt_ac_code_b9; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE acnt_ac_code_b9 FROM PUBLIC;
REVOKE ALL ON TABLE acnt_ac_code_b9 FROM letl;
GRANT ALL ON TABLE acnt_ac_code_b9 TO letl;
GRANT ALL ON TABLE acnt_ac_code_b9 TO ladhoc;
GRANT ALL ON TABLE acnt_ac_code_b9 TO lolap;
GRANT ALL ON TABLE acnt_ac_code_b9 TO loltp;


--
-- Name: audt_ja_app_result; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE audt_ja_app_result FROM PUBLIC;
REVOKE ALL ON TABLE audt_ja_app_result FROM letl;
GRANT ALL ON TABLE audt_ja_app_result TO letl;
GRANT ALL ON TABLE audt_ja_app_result TO ladhoc;
GRANT ALL ON TABLE audt_ja_app_result TO lolap;
GRANT ALL ON TABLE audt_ja_app_result TO loltp;


--
-- Name: audt_ja_confirm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE audt_ja_confirm FROM PUBLIC;
REVOKE ALL ON TABLE audt_ja_confirm FROM letl;
GRANT ALL ON TABLE audt_ja_confirm TO letl;
GRANT ALL ON TABLE audt_ja_confirm TO ladhoc;
GRANT ALL ON TABLE audt_ja_confirm TO lolap;
GRANT ALL ON TABLE audt_ja_confirm TO loltp;


--
-- Name: audt_ja_confirm_b9; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE audt_ja_confirm_b9 FROM PUBLIC;
REVOKE ALL ON TABLE audt_ja_confirm_b9 FROM letl;
GRANT ALL ON TABLE audt_ja_confirm_b9 TO letl;
GRANT ALL ON TABLE audt_ja_confirm_b9 TO ladhoc;
GRANT ALL ON TABLE audt_ja_confirm_b9 TO lolap;
GRANT ALL ON TABLE audt_ja_confirm_b9 TO loltp;


--
-- Name: audt_ja_depo_mrtg; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE audt_ja_depo_mrtg FROM PUBLIC;
REVOKE ALL ON TABLE audt_ja_depo_mrtg FROM letl;
GRANT ALL ON TABLE audt_ja_depo_mrtg TO letl;
GRANT ALL ON TABLE audt_ja_depo_mrtg TO ladhoc;
GRANT ALL ON TABLE audt_ja_depo_mrtg TO lolap;
GRANT ALL ON TABLE audt_ja_depo_mrtg TO loltp;


--
-- Name: audt_ja_opn_apv; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE audt_ja_opn_apv FROM PUBLIC;
REVOKE ALL ON TABLE audt_ja_opn_apv FROM letl;
GRANT ALL ON TABLE audt_ja_opn_apv TO letl;
GRANT ALL ON TABLE audt_ja_opn_apv TO ladhoc;
GRANT ALL ON TABLE audt_ja_opn_apv TO lolap;
GRANT ALL ON TABLE audt_ja_opn_apv TO loltp;


--
-- Name: audt_ja_ss_mst; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE audt_ja_ss_mst FROM PUBLIC;
REVOKE ALL ON TABLE audt_ja_ss_mst FROM letl;
GRANT ALL ON TABLE audt_ja_ss_mst TO letl;
GRANT ALL ON TABLE audt_ja_ss_mst TO ladhoc;
GRANT ALL ON TABLE audt_ja_ss_mst TO lolap;
GRANT ALL ON TABLE audt_ja_ss_mst TO loltp;


--
-- Name: audt_vaca_tbl; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE audt_vaca_tbl FROM PUBLIC;
REVOKE ALL ON TABLE audt_vaca_tbl FROM letl;
GRANT ALL ON TABLE audt_vaca_tbl TO letl;
GRANT ALL ON TABLE audt_vaca_tbl TO ladhoc;
GRANT ALL ON TABLE audt_vaca_tbl TO lolap;
GRANT ALL ON TABLE audt_vaca_tbl TO loltp;


--
-- Name: bind_depo_opn_trn; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE bind_depo_opn_trn FROM PUBLIC;
REVOKE ALL ON TABLE bind_depo_opn_trn FROM letl;
GRANT ALL ON TABLE bind_depo_opn_trn TO letl;
GRANT ALL ON TABLE bind_depo_opn_trn TO ladhoc;
GRANT ALL ON TABLE bind_depo_opn_trn TO lolap;
GRANT ALL ON TABLE bind_depo_opn_trn TO loltp;


--
-- Name: card_flc_mihando_b9; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE card_flc_mihando_b9 FROM PUBLIC;
REVOKE ALL ON TABLE card_flc_mihando_b9 FROM letl;
GRANT ALL ON TABLE card_flc_mihando_b9 TO letl;
GRANT ALL ON TABLE card_flc_mihando_b9 TO ladhoc;
GRANT ALL ON TABLE card_flc_mihando_b9 TO lolap;
GRANT ALL ON TABLE card_flc_mihando_b9 TO loltp;


--
-- Name: card_flc_mst_b9; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE card_flc_mst_b9 FROM PUBLIC;
REVOKE ALL ON TABLE card_flc_mst_b9 FROM letl;
GRANT ALL ON TABLE card_flc_mst_b9 TO letl;
GRANT ALL ON TABLE card_flc_mst_b9 TO ladhoc;
GRANT ALL ON TABLE card_flc_mst_b9 TO lolap;
GRANT ALL ON TABLE card_flc_mst_b9 TO loltp;


--
-- Name: code_detail; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE code_detail FROM PUBLIC;
REVOKE ALL ON TABLE code_detail FROM letl;
GRANT ALL ON TABLE code_detail TO letl;
GRANT ALL ON TABLE code_detail TO ladhoc;
GRANT ALL ON TABLE code_detail TO lolap;
GRANT ALL ON TABLE code_detail TO loltp;


--
-- Name: comm_bk_mast; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE comm_bk_mast FROM PUBLIC;
REVOKE ALL ON TABLE comm_bk_mast FROM letl;
GRANT ALL ON TABLE comm_bk_mast TO letl;
GRANT ALL ON TABLE comm_bk_mast TO ladhoc;
GRANT ALL ON TABLE comm_bk_mast TO lolap;
GRANT ALL ON TABLE comm_bk_mast TO loltp;


--
-- Name: comm_br_brch; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE comm_br_brch FROM PUBLIC;
REVOKE ALL ON TABLE comm_br_brch FROM letl;
GRANT ALL ON TABLE comm_br_brch TO letl;
GRANT ALL ON TABLE comm_br_brch TO ladhoc;
GRANT ALL ON TABLE comm_br_brch TO lolap;
GRANT ALL ON TABLE comm_br_brch TO loltp;


--
-- Name: comm_br_brch_b9; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE comm_br_brch_b9 FROM PUBLIC;
REVOKE ALL ON TABLE comm_br_brch_b9 FROM letl;
GRANT ALL ON TABLE comm_br_brch_b9 TO letl;
GRANT ALL ON TABLE comm_br_brch_b9 TO ladhoc;
GRANT ALL ON TABLE comm_br_brch_b9 TO lolap;
GRANT ALL ON TABLE comm_br_brch_b9 TO loltp;


--
-- Name: comm_cd_every; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE comm_cd_every FROM PUBLIC;
REVOKE ALL ON TABLE comm_cd_every FROM letl;
GRANT ALL ON TABLE comm_cd_every TO letl;
GRANT ALL ON TABLE comm_cd_every TO ladhoc;
GRANT ALL ON TABLE comm_cd_every TO lolap;
GRANT ALL ON TABLE comm_cd_every TO loltp;


--
-- Name: comm_ep_emp; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE comm_ep_emp FROM PUBLIC;
REVOKE ALL ON TABLE comm_ep_emp FROM letl;
GRANT ALL ON TABLE comm_ep_emp TO letl;
GRANT ALL ON TABLE comm_ep_emp TO ladhoc;
GRANT ALL ON TABLE comm_ep_emp TO lolap;
GRANT ALL ON TABLE comm_ep_emp TO loltp;


--
-- Name: comm_im_paper; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE comm_im_paper FROM PUBLIC;
REVOKE ALL ON TABLE comm_im_paper FROM letl;
GRANT ALL ON TABLE comm_im_paper TO letl;
GRANT ALL ON TABLE comm_im_paper TO ladhoc;
GRANT ALL ON TABLE comm_im_paper TO lolap;
GRANT ALL ON TABLE comm_im_paper TO loltp;


--
-- Name: comm_menu_step; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE comm_menu_step FROM PUBLIC;
REVOKE ALL ON TABLE comm_menu_step FROM letl;
GRANT ALL ON TABLE comm_menu_step TO letl;
GRANT ALL ON TABLE comm_menu_step TO ladhoc;
GRANT ALL ON TABLE comm_menu_step TO lolap;
GRANT ALL ON TABLE comm_menu_step TO loltp;


--
-- Name: comm_mr_cif; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE comm_mr_cif FROM PUBLIC;
REVOKE ALL ON TABLE comm_mr_cif FROM letl;
GRANT ALL ON TABLE comm_mr_cif TO letl;
GRANT ALL ON TABLE comm_mr_cif TO ladhoc;
GRANT ALL ON TABLE comm_mr_cif TO lolap;
GRANT ALL ON TABLE comm_mr_cif TO loltp;


--
-- Name: comm_mr_mgr; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE comm_mr_mgr FROM PUBLIC;
REVOKE ALL ON TABLE comm_mr_mgr FROM letl;
GRANT ALL ON TABLE comm_mr_mgr TO letl;
GRANT ALL ON TABLE comm_mr_mgr TO ladhoc;
GRANT ALL ON TABLE comm_mr_mgr TO lolap;
GRANT ALL ON TABLE comm_mr_mgr TO loltp;


--
-- Name: comm_pb_ct_result; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE comm_pb_ct_result FROM PUBLIC;
REVOKE ALL ON TABLE comm_pb_ct_result FROM letl;
GRANT ALL ON TABLE comm_pb_ct_result TO letl;
GRANT ALL ON TABLE comm_pb_ct_result TO ladhoc;
GRANT ALL ON TABLE comm_pb_ct_result TO lolap;
GRANT ALL ON TABLE comm_pb_ct_result TO loltp;


--
-- Name: comm_pb_mg_cif; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE comm_pb_mg_cif FROM PUBLIC;
REVOKE ALL ON TABLE comm_pb_mg_cif FROM letl;
GRANT ALL ON TABLE comm_pb_mg_cif TO letl;
GRANT ALL ON TABLE comm_pb_mg_cif TO ladhoc;
GRANT ALL ON TABLE comm_pb_mg_cif TO lolap;
GRANT ALL ON TABLE comm_pb_mg_cif TO loltp;


--
-- Name: comm_vaca_tbl; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE comm_vaca_tbl FROM PUBLIC;
REVOKE ALL ON TABLE comm_vaca_tbl FROM letl;
GRANT ALL ON TABLE comm_vaca_tbl TO letl;
GRANT ALL ON TABLE comm_vaca_tbl TO ladhoc;
GRANT ALL ON TABLE comm_vaca_tbl TO lolap;
GRANT ALL ON TABLE comm_vaca_tbl TO loltp;


--
-- Name: crms_trace; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE crms_trace FROM PUBLIC;
REVOKE ALL ON TABLE crms_trace FROM letl;
GRANT ALL ON TABLE crms_trace TO letl;
GRANT ALL ON TABLE crms_trace TO ladhoc;
GRANT ALL ON TABLE crms_trace TO lolap;
GRANT ALL ON TABLE crms_trace TO loltp;


--
-- Name: cu040tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE cu040tf FROM PUBLIC;
REVOKE ALL ON TABLE cu040tf FROM letl;
GRANT ALL ON TABLE cu040tf TO letl;
GRANT ALL ON TABLE cu040tf TO ladhoc;
GRANT ALL ON TABLE cu040tf TO lolap;
GRANT ALL ON TABLE cu040tf TO loltp;


--
-- Name: cust_ba_base; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE cust_ba_base FROM PUBLIC;
REVOKE ALL ON TABLE cust_ba_base FROM letl;
GRANT ALL ON TABLE cust_ba_base TO letl;
GRANT ALL ON TABLE cust_ba_base TO ladhoc;
GRANT ALL ON TABLE cust_ba_base TO lolap;
GRANT ALL ON TABLE cust_ba_base TO loltp;


--
-- Name: cust_ba_base_b9; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE cust_ba_base_b9 FROM PUBLIC;
REVOKE ALL ON TABLE cust_ba_base_b9 FROM letl;
GRANT ALL ON TABLE cust_ba_base_b9 TO letl;
GRANT ALL ON TABLE cust_ba_base_b9 TO ladhoc;
GRANT ALL ON TABLE cust_ba_base_b9 TO lolap;
GRANT ALL ON TABLE cust_ba_base_b9 TO loltp;


--
-- Name: cust_ba_juso; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE cust_ba_juso FROM PUBLIC;
REVOKE ALL ON TABLE cust_ba_juso FROM letl;
GRANT ALL ON TABLE cust_ba_juso TO letl;
GRANT ALL ON TABLE cust_ba_juso TO ladhoc;
GRANT ALL ON TABLE cust_ba_juso TO lolap;
GRANT ALL ON TABLE cust_ba_juso TO loltp;


--
-- Name: cust_ba_juso_b9; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE cust_ba_juso_b9 FROM PUBLIC;
REVOKE ALL ON TABLE cust_ba_juso_b9 FROM letl;
GRANT ALL ON TABLE cust_ba_juso_b9 TO letl;
GRANT ALL ON TABLE cust_ba_juso_b9 TO ladhoc;
GRANT ALL ON TABLE cust_ba_juso_b9 TO lolap;
GRANT ALL ON TABLE cust_ba_juso_b9 TO loltp;


--
-- Name: cust_rl_dt_tbl; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE cust_rl_dt_tbl FROM PUBLIC;
REVOKE ALL ON TABLE cust_rl_dt_tbl FROM letl;
GRANT ALL ON TABLE cust_rl_dt_tbl TO letl;
GRANT ALL ON TABLE cust_rl_dt_tbl TO ladhoc;
GRANT ALL ON TABLE cust_rl_dt_tbl TO lolap;
GRANT ALL ON TABLE cust_rl_dt_tbl TO loltp;


--
-- Name: cust_rl_vp_tbl; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE cust_rl_vp_tbl FROM PUBLIC;
REVOKE ALL ON TABLE cust_rl_vp_tbl FROM letl;
GRANT ALL ON TABLE cust_rl_vp_tbl TO letl;
GRANT ALL ON TABLE cust_rl_vp_tbl TO ladhoc;
GRANT ALL ON TABLE cust_rl_vp_tbl TO lolap;
GRANT ALL ON TABLE cust_rl_vp_tbl TO loltp;


--
-- Name: depo_ac_comm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE depo_ac_comm FROM PUBLIC;
REVOKE ALL ON TABLE depo_ac_comm FROM letl;
GRANT ALL ON TABLE depo_ac_comm TO letl;
GRANT ALL ON TABLE depo_ac_comm TO ladhoc;
GRANT ALL ON TABLE depo_ac_comm TO lolap;
GRANT ALL ON TABLE depo_ac_comm TO loltp;


--
-- Name: depo_ac_comm_b9; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE depo_ac_comm_b9 FROM PUBLIC;
REVOKE ALL ON TABLE depo_ac_comm_b9 FROM letl;
GRANT ALL ON TABLE depo_ac_comm_b9 TO letl;
GRANT ALL ON TABLE depo_ac_comm_b9 TO ladhoc;
GRANT ALL ON TABLE depo_ac_comm_b9 TO lolap;
GRANT ALL ON TABLE depo_ac_comm_b9 TO loltp;


--
-- Name: depo_bd_dbal; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE depo_bd_dbal FROM PUBLIC;
REVOKE ALL ON TABLE depo_bd_dbal FROM letl;
GRANT ALL ON TABLE depo_bd_dbal TO letl;
GRANT ALL ON TABLE depo_bd_dbal TO ladhoc;
GRANT ALL ON TABLE depo_bd_dbal TO lolap;
GRANT ALL ON TABLE depo_bd_dbal TO loltp;


--
-- Name: depo_cv_davg; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE depo_cv_davg FROM PUBLIC;
REVOKE ALL ON TABLE depo_cv_davg FROM letl;
GRANT ALL ON TABLE depo_cv_davg TO letl;
GRANT ALL ON TABLE depo_cv_davg TO ladhoc;
GRANT ALL ON TABLE depo_cv_davg TO lolap;
GRANT ALL ON TABLE depo_cv_davg TO loltp;


--
-- Name: depo_cv_info; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE depo_cv_info FROM PUBLIC;
REVOKE ALL ON TABLE depo_cv_info FROM letl;
GRANT ALL ON TABLE depo_cv_info TO letl;
GRANT ALL ON TABLE depo_cv_info TO ladhoc;
GRANT ALL ON TABLE depo_cv_info TO lolap;
GRANT ALL ON TABLE depo_cv_info TO loltp;


--
-- Name: depo_ex_inf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE depo_ex_inf FROM PUBLIC;
REVOKE ALL ON TABLE depo_ex_inf FROM letl;
GRANT ALL ON TABLE depo_ex_inf TO letl;
GRANT ALL ON TABLE depo_ex_inf TO ladhoc;
GRANT ALL ON TABLE depo_ex_inf TO lolap;
GRANT ALL ON TABLE depo_ex_inf TO loltp;


--
-- Name: depo_exp_tongbo; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE depo_exp_tongbo FROM PUBLIC;
REVOKE ALL ON TABLE depo_exp_tongbo FROM letl;
GRANT ALL ON TABLE depo_exp_tongbo TO letl;
GRANT ALL ON TABLE depo_exp_tongbo TO ladhoc;
GRANT ALL ON TABLE depo_exp_tongbo TO lolap;
GRANT ALL ON TABLE depo_exp_tongbo TO loltp;


--
-- Name: depo_mm_dbal; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE depo_mm_dbal FROM PUBLIC;
REVOKE ALL ON TABLE depo_mm_dbal FROM letl;
GRANT ALL ON TABLE depo_mm_dbal TO letl;
GRANT ALL ON TABLE depo_mm_dbal TO ladhoc;
GRANT ALL ON TABLE depo_mm_dbal TO lolap;
GRANT ALL ON TABLE depo_mm_dbal TO loltp;


--
-- Name: depo_mm_mbal; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE depo_mm_mbal FROM PUBLIC;
REVOKE ALL ON TABLE depo_mm_mbal FROM letl;
GRANT ALL ON TABLE depo_mm_mbal TO letl;
GRANT ALL ON TABLE depo_mm_mbal TO ladhoc;
GRANT ALL ON TABLE depo_mm_mbal TO lolap;
GRANT ALL ON TABLE depo_mm_mbal TO loltp;


--
-- Name: depo_mm_woltb; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE depo_mm_woltb FROM PUBLIC;
REVOKE ALL ON TABLE depo_mm_woltb FROM letl;
GRANT ALL ON TABLE depo_mm_woltb TO letl;
GRANT ALL ON TABLE depo_mm_woltb TO ladhoc;
GRANT ALL ON TABLE depo_mm_woltb TO lolap;
GRANT ALL ON TABLE depo_mm_woltb TO loltp;


--
-- Name: depo_rg_bond; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE depo_rg_bond FROM PUBLIC;
REVOKE ALL ON TABLE depo_rg_bond FROM letl;
GRANT ALL ON TABLE depo_rg_bond TO letl;
GRANT ALL ON TABLE depo_rg_bond TO ladhoc;
GRANT ALL ON TABLE depo_rg_bond TO lolap;
GRANT ALL ON TABLE depo_rg_bond TO loltp;


--
-- Name: depo_sj_mas; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE depo_sj_mas FROM PUBLIC;
REVOKE ALL ON TABLE depo_sj_mas FROM letl;
GRANT ALL ON TABLE depo_sj_mas TO letl;
GRANT ALL ON TABLE depo_sj_mas TO ladhoc;
GRANT ALL ON TABLE depo_sj_mas TO lolap;
GRANT ALL ON TABLE depo_sj_mas TO loltp;


--
-- Name: depo_tr_mas; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE depo_tr_mas FROM PUBLIC;
REVOKE ALL ON TABLE depo_tr_mas FROM letl;
GRANT ALL ON TABLE depo_tr_mas TO letl;
GRANT ALL ON TABLE depo_tr_mas TO ladhoc;
GRANT ALL ON TABLE depo_tr_mas TO lolap;
GRANT ALL ON TABLE depo_tr_mas TO loltp;


--
-- Name: ea13mt; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ea13mt FROM PUBLIC;
REVOKE ALL ON TABLE ea13mt FROM letl;
GRANT ALL ON TABLE ea13mt TO letl;
GRANT ALL ON TABLE ea13mt TO ladhoc;
GRANT ALL ON TABLE ea13mt TO lolap;
GRANT ALL ON TABLE ea13mt TO loltp;


SET search_path = sdmin_err, pg_catalog;

--
-- Name: cm034tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE cm034tf_err FROM PUBLIC;
REVOKE ALL ON TABLE cm034tf_err FROM letl;
GRANT ALL ON TABLE cm034tf_err TO letl;
GRANT ALL ON TABLE cm034tf_err TO ladhoc;
GRANT ALL ON TABLE cm034tf_err TO lolap;
GRANT ALL ON TABLE cm034tf_err TO loltp;


--
-- Name: dp905td_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE dp905td_err FROM PUBLIC;
REVOKE ALL ON TABLE dp905td_err FROM letl;
GRANT ALL ON TABLE dp905td_err TO letl;
GRANT ALL ON TABLE dp905td_err TO ladhoc;
GRANT ALL ON TABLE dp905td_err TO lolap;
GRANT ALL ON TABLE dp905td_err TO loltp;


--
-- Name: hum4b2tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum4b2tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum4b2tm_err FROM letl;
GRANT ALL ON TABLE hum4b2tm_err TO letl;
GRANT ALL ON TABLE hum4b2tm_err TO ladhoc;
GRANT ALL ON TABLE hum4b2tm_err TO lolap;
GRANT ALL ON TABLE hum4b2tm_err TO loltp;


--
-- Name: hum216tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum216tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum216tm_err FROM letl;
GRANT ALL ON TABLE hum216tm_err TO letl;
GRANT ALL ON TABLE hum216tm_err TO ladhoc;
GRANT ALL ON TABLE hum216tm_err TO lolap;
GRANT ALL ON TABLE hum216tm_err TO loltp;


--
-- Name: hum215tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum215tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum215tm_err FROM letl;
GRANT ALL ON TABLE hum215tm_err TO letl;
GRANT ALL ON TABLE hum215tm_err TO ladhoc;
GRANT ALL ON TABLE hum215tm_err TO lolap;
GRANT ALL ON TABLE hum215tm_err TO loltp;


--
-- Name: hu0b22tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0b22tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0b22tm_err FROM letl;
GRANT ALL ON TABLE hu0b22tm_err TO letl;
GRANT ALL ON TABLE hu0b22tm_err TO ladhoc;
GRANT ALL ON TABLE hu0b22tm_err TO lolap;
GRANT ALL ON TABLE hu0b22tm_err TO loltp;


--
-- Name: hum701tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum701tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum701tm_err FROM letl;
GRANT ALL ON TABLE hum701tm_err TO letl;
GRANT ALL ON TABLE hum701tm_err TO ladhoc;
GRANT ALL ON TABLE hum701tm_err TO lolap;
GRANT ALL ON TABLE hum701tm_err TO loltp;


--
-- Name: hum421tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum421tf_err FROM PUBLIC;
REVOKE ALL ON TABLE hum421tf_err FROM letl;
GRANT ALL ON TABLE hum421tf_err TO letl;
GRANT ALL ON TABLE hum421tf_err TO ladhoc;
GRANT ALL ON TABLE hum421tf_err TO lolap;
GRANT ALL ON TABLE hum421tf_err TO loltp;


--
-- Name: hum40btm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum40btm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum40btm_err FROM letl;
GRANT ALL ON TABLE hum40btm_err TO letl;
GRANT ALL ON TABLE hum40btm_err TO ladhoc;
GRANT ALL ON TABLE hum40btm_err TO lolap;
GRANT ALL ON TABLE hum40btm_err TO loltp;


--
-- Name: hum209tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum209tf_err FROM PUBLIC;
REVOKE ALL ON TABLE hum209tf_err FROM letl;
GRANT ALL ON TABLE hum209tf_err TO letl;
GRANT ALL ON TABLE hum209tf_err TO ladhoc;
GRANT ALL ON TABLE hum209tf_err TO lolap;
GRANT ALL ON TABLE hum209tf_err TO loltp;


--
-- Name: ln805th_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ln805th_err FROM PUBLIC;
REVOKE ALL ON TABLE ln805th_err FROM letl;
GRANT ALL ON TABLE ln805th_err TO letl;
GRANT ALL ON TABLE ln805th_err TO ladhoc;
GRANT ALL ON TABLE ln805th_err TO lolap;
GRANT ALL ON TABLE ln805th_err TO loltp;


SET search_path = sdmin, pg_catalog;

--
-- Name: foex_de_dept; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE foex_de_dept FROM PUBLIC;
REVOKE ALL ON TABLE foex_de_dept FROM letl;
GRANT ALL ON TABLE foex_de_dept TO letl;
GRANT ALL ON TABLE foex_de_dept TO ladhoc;
GRANT ALL ON TABLE foex_de_dept TO lolap;
GRANT ALL ON TABLE foex_de_dept TO loltp;


--
-- Name: gita_rpcd_tbl; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE gita_rpcd_tbl FROM PUBLIC;
REVOKE ALL ON TABLE gita_rpcd_tbl FROM letl;
GRANT ALL ON TABLE gita_rpcd_tbl TO letl;
GRANT ALL ON TABLE gita_rpcd_tbl TO ladhoc;
GRANT ALL ON TABLE gita_rpcd_tbl TO lolap;
GRANT ALL ON TABLE gita_rpcd_tbl TO loltp;


--
-- Name: gita_rpdata_tbl; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE gita_rpdata_tbl FROM PUBLIC;
REVOKE ALL ON TABLE gita_rpdata_tbl FROM letl;
GRANT ALL ON TABLE gita_rpdata_tbl TO letl;
GRANT ALL ON TABLE gita_rpdata_tbl TO ladhoc;
GRANT ALL ON TABLE gita_rpdata_tbl TO lolap;
GRANT ALL ON TABLE gita_rpdata_tbl TO loltp;


--
-- Name: hu0b18tc; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0b18tc FROM PUBLIC;
REVOKE ALL ON TABLE hu0b18tc FROM letl;
GRANT ALL ON TABLE hu0b18tc TO letl;
GRANT ALL ON TABLE hu0b18tc TO ladhoc;
GRANT ALL ON TABLE hu0b18tc TO lolap;
GRANT ALL ON TABLE hu0b18tc TO loltp;


--
-- Name: hu0b19tc; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0b19tc FROM PUBLIC;
REVOKE ALL ON TABLE hu0b19tc FROM letl;
GRANT ALL ON TABLE hu0b19tc TO letl;
GRANT ALL ON TABLE hu0b19tc TO ladhoc;
GRANT ALL ON TABLE hu0b19tc TO lolap;
GRANT ALL ON TABLE hu0b19tc TO loltp;


--
-- Name: hu0b20tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0b20tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0b20tm FROM letl;
GRANT ALL ON TABLE hu0b20tm TO letl;
GRANT ALL ON TABLE hu0b20tm TO ladhoc;
GRANT ALL ON TABLE hu0b20tm TO lolap;
GRANT ALL ON TABLE hu0b20tm TO loltp;


--
-- Name: hu0b21tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0b21tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0b21tm FROM letl;
GRANT ALL ON TABLE hu0b21tm TO letl;
GRANT ALL ON TABLE hu0b21tm TO ladhoc;
GRANT ALL ON TABLE hu0b21tm TO lolap;
GRANT ALL ON TABLE hu0b21tm TO loltp;


--
-- Name: hu0b22tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0b22tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0b22tm FROM letl;
GRANT ALL ON TABLE hu0b22tm TO letl;
GRANT ALL ON TABLE hu0b22tm TO ladhoc;
GRANT ALL ON TABLE hu0b22tm TO lolap;
GRANT ALL ON TABLE hu0b22tm TO loltp;


--
-- Name: hu0b34tc; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0b34tc FROM PUBLIC;
REVOKE ALL ON TABLE hu0b34tc FROM letl;
GRANT ALL ON TABLE hu0b34tc TO letl;
GRANT ALL ON TABLE hu0b34tc TO ladhoc;
GRANT ALL ON TABLE hu0b34tc TO lolap;
GRANT ALL ON TABLE hu0b34tc TO loltp;


--
-- Name: hu0b41tc; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0b41tc FROM PUBLIC;
REVOKE ALL ON TABLE hu0b41tc FROM letl;
GRANT ALL ON TABLE hu0b41tc TO letl;
GRANT ALL ON TABLE hu0b41tc TO ladhoc;
GRANT ALL ON TABLE hu0b41tc TO lolap;
GRANT ALL ON TABLE hu0b41tc TO loltp;


--
-- Name: hu0b44tc; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0b44tc FROM PUBLIC;
REVOKE ALL ON TABLE hu0b44tc FROM letl;
GRANT ALL ON TABLE hu0b44tc TO letl;
GRANT ALL ON TABLE hu0b44tc TO ladhoc;
GRANT ALL ON TABLE hu0b44tc TO lolap;
GRANT ALL ON TABLE hu0b44tc TO loltp;


--
-- Name: hu0d01tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0d01tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0d01tm FROM letl;
GRANT ALL ON TABLE hu0d01tm TO letl;
GRANT ALL ON TABLE hu0d01tm TO ladhoc;
GRANT ALL ON TABLE hu0d01tm TO lolap;
GRANT ALL ON TABLE hu0d01tm TO loltp;


--
-- Name: hu0d02tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0d02tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0d02tm FROM letl;
GRANT ALL ON TABLE hu0d02tm TO letl;
GRANT ALL ON TABLE hu0d02tm TO ladhoc;
GRANT ALL ON TABLE hu0d02tm TO lolap;
GRANT ALL ON TABLE hu0d02tm TO loltp;


--
-- Name: hu0d05tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0d05tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0d05tm FROM letl;
GRANT ALL ON TABLE hu0d05tm TO letl;
GRANT ALL ON TABLE hu0d05tm TO ladhoc;
GRANT ALL ON TABLE hu0d05tm TO lolap;
GRANT ALL ON TABLE hu0d05tm TO loltp;


--
-- Name: hu0d88tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0d88tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0d88tm FROM letl;
GRANT ALL ON TABLE hu0d88tm TO letl;
GRANT ALL ON TABLE hu0d88tm TO ladhoc;
GRANT ALL ON TABLE hu0d88tm TO lolap;
GRANT ALL ON TABLE hu0d88tm TO loltp;


--
-- Name: hu0d99tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0d99tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0d99tm FROM letl;
GRANT ALL ON TABLE hu0d99tm TO letl;
GRANT ALL ON TABLE hu0d99tm TO ladhoc;
GRANT ALL ON TABLE hu0d99tm TO lolap;
GRANT ALL ON TABLE hu0d99tm TO loltp;


--
-- Name: hu0e0ctm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0e0ctm FROM PUBLIC;
REVOKE ALL ON TABLE hu0e0ctm FROM letl;
GRANT ALL ON TABLE hu0e0ctm TO letl;
GRANT ALL ON TABLE hu0e0ctm TO ladhoc;
GRANT ALL ON TABLE hu0e0ctm TO lolap;
GRANT ALL ON TABLE hu0e0ctm TO loltp;


--
-- Name: hu0e13tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0e13tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0e13tm FROM letl;
GRANT ALL ON TABLE hu0e13tm TO letl;
GRANT ALL ON TABLE hu0e13tm TO ladhoc;
GRANT ALL ON TABLE hu0e13tm TO lolap;
GRANT ALL ON TABLE hu0e13tm TO loltp;


--
-- Name: hu0e26tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0e26tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0e26tm FROM letl;
GRANT ALL ON TABLE hu0e26tm TO letl;
GRANT ALL ON TABLE hu0e26tm TO ladhoc;
GRANT ALL ON TABLE hu0e26tm TO lolap;
GRANT ALL ON TABLE hu0e26tm TO loltp;


--
-- Name: hu0e27tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0e27tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0e27tm FROM letl;
GRANT ALL ON TABLE hu0e27tm TO letl;
GRANT ALL ON TABLE hu0e27tm TO ladhoc;
GRANT ALL ON TABLE hu0e27tm TO lolap;
GRANT ALL ON TABLE hu0e27tm TO loltp;


--
-- Name: hu0e2btm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0e2btm FROM PUBLIC;
REVOKE ALL ON TABLE hu0e2btm FROM letl;
GRANT ALL ON TABLE hu0e2btm TO letl;
GRANT ALL ON TABLE hu0e2btm TO ladhoc;
GRANT ALL ON TABLE hu0e2btm TO lolap;
GRANT ALL ON TABLE hu0e2btm TO loltp;


--
-- Name: hu0e32tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0e32tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0e32tm FROM letl;
GRANT ALL ON TABLE hu0e32tm TO letl;
GRANT ALL ON TABLE hu0e32tm TO ladhoc;
GRANT ALL ON TABLE hu0e32tm TO lolap;
GRANT ALL ON TABLE hu0e32tm TO loltp;


--
-- Name: hu0e63tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0e63tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0e63tm FROM letl;
GRANT ALL ON TABLE hu0e63tm TO letl;
GRANT ALL ON TABLE hu0e63tm TO ladhoc;
GRANT ALL ON TABLE hu0e63tm TO lolap;
GRANT ALL ON TABLE hu0e63tm TO loltp;


--
-- Name: hu0e64tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0e64tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0e64tm FROM letl;
GRANT ALL ON TABLE hu0e64tm TO letl;
GRANT ALL ON TABLE hu0e64tm TO ladhoc;
GRANT ALL ON TABLE hu0e64tm TO lolap;
GRANT ALL ON TABLE hu0e64tm TO loltp;


--
-- Name: hu0es1tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0es1tm FROM PUBLIC;
REVOKE ALL ON TABLE hu0es1tm FROM letl;
GRANT ALL ON TABLE hu0es1tm TO letl;
GRANT ALL ON TABLE hu0es1tm TO ladhoc;
GRANT ALL ON TABLE hu0es1tm TO lolap;
GRANT ALL ON TABLE hu0es1tm TO loltp;


--
-- Name: hu0raatf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu0raatf FROM PUBLIC;
REVOKE ALL ON TABLE hu0raatf FROM letl;
GRANT ALL ON TABLE hu0raatf TO letl;
GRANT ALL ON TABLE hu0raatf TO ladhoc;
GRANT ALL ON TABLE hu0raatf TO lolap;
GRANT ALL ON TABLE hu0raatf TO loltp;


--
-- Name: hu3r5ttm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu3r5ttm FROM PUBLIC;
REVOKE ALL ON TABLE hu3r5ttm FROM letl;
GRANT ALL ON TABLE hu3r5ttm TO letl;
GRANT ALL ON TABLE hu3r5ttm TO ladhoc;
GRANT ALL ON TABLE hu3r5ttm TO lolap;
GRANT ALL ON TABLE hu3r5ttm TO loltp;


--
-- Name: hu8d88tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu8d88tm FROM PUBLIC;
REVOKE ALL ON TABLE hu8d88tm FROM letl;
GRANT ALL ON TABLE hu8d88tm TO letl;
GRANT ALL ON TABLE hu8d88tm TO ladhoc;
GRANT ALL ON TABLE hu8d88tm TO lolap;
GRANT ALL ON TABLE hu8d88tm TO loltp;


--
-- Name: hu9e68tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hu9e68tm FROM PUBLIC;
REVOKE ALL ON TABLE hu9e68tm FROM letl;
GRANT ALL ON TABLE hu9e68tm TO letl;
GRANT ALL ON TABLE hu9e68tm TO ladhoc;
GRANT ALL ON TABLE hu9e68tm TO lolap;
GRANT ALL ON TABLE hu9e68tm TO loltp;


--
-- Name: hud206tc; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hud206tc FROM PUBLIC;
REVOKE ALL ON TABLE hud206tc FROM letl;
GRANT ALL ON TABLE hud206tc TO letl;
GRANT ALL ON TABLE hud206tc TO ladhoc;
GRANT ALL ON TABLE hud206tc TO lolap;
GRANT ALL ON TABLE hud206tc TO loltp;


--
-- Name: hud207tc; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hud207tc FROM PUBLIC;
REVOKE ALL ON TABLE hud207tc FROM letl;
GRANT ALL ON TABLE hud207tc TO letl;
GRANT ALL ON TABLE hud207tc TO ladhoc;
GRANT ALL ON TABLE hud207tc TO lolap;
GRANT ALL ON TABLE hud207tc TO loltp;


--
-- Name: hud501tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hud501tm FROM PUBLIC;
REVOKE ALL ON TABLE hud501tm FROM letl;
GRANT ALL ON TABLE hud501tm TO letl;
GRANT ALL ON TABLE hud501tm TO ladhoc;
GRANT ALL ON TABLE hud501tm TO lolap;
GRANT ALL ON TABLE hud501tm TO loltp;


--
-- Name: hud504tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hud504tf FROM PUBLIC;
REVOKE ALL ON TABLE hud504tf FROM letl;
GRANT ALL ON TABLE hud504tf TO letl;
GRANT ALL ON TABLE hud504tf TO ladhoc;
GRANT ALL ON TABLE hud504tf TO lolap;
GRANT ALL ON TABLE hud504tf TO loltp;


--
-- Name: hud511tc; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hud511tc FROM PUBLIC;
REVOKE ALL ON TABLE hud511tc FROM letl;
GRANT ALL ON TABLE hud511tc TO letl;
GRANT ALL ON TABLE hud511tc TO ladhoc;
GRANT ALL ON TABLE hud511tc TO lolap;
GRANT ALL ON TABLE hud511tc TO loltp;


--
-- Name: hud513tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hud513tm FROM PUBLIC;
REVOKE ALL ON TABLE hud513tm FROM letl;
GRANT ALL ON TABLE hud513tm TO letl;
GRANT ALL ON TABLE hud513tm TO ladhoc;
GRANT ALL ON TABLE hud513tm TO lolap;
GRANT ALL ON TABLE hud513tm TO loltp;


--
-- Name: hud514tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hud514tf FROM PUBLIC;
REVOKE ALL ON TABLE hud514tf FROM letl;
GRANT ALL ON TABLE hud514tf TO letl;
GRANT ALL ON TABLE hud514tf TO ladhoc;
GRANT ALL ON TABLE hud514tf TO lolap;
GRANT ALL ON TABLE hud514tf TO loltp;


--
-- Name: hud520tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hud520tf FROM PUBLIC;
REVOKE ALL ON TABLE hud520tf FROM letl;
GRANT ALL ON TABLE hud520tf TO letl;
GRANT ALL ON TABLE hud520tf TO ladhoc;
GRANT ALL ON TABLE hud520tf TO lolap;
GRANT ALL ON TABLE hud520tf TO loltp;


--
-- Name: hud591tc; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hud591tc FROM PUBLIC;
REVOKE ALL ON TABLE hud591tc FROM letl;
GRANT ALL ON TABLE hud591tc TO letl;
GRANT ALL ON TABLE hud591tc TO ladhoc;
GRANT ALL ON TABLE hud591tc TO lolap;
GRANT ALL ON TABLE hud591tc TO loltp;


--
-- Name: hud593tc; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hud593tc FROM PUBLIC;
REVOKE ALL ON TABLE hud593tc FROM letl;
GRANT ALL ON TABLE hud593tc TO letl;
GRANT ALL ON TABLE hud593tc TO ladhoc;
GRANT ALL ON TABLE hud593tc TO lolap;
GRANT ALL ON TABLE hud593tc TO loltp;


--
-- Name: hud594tc; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hud594tc FROM PUBLIC;
REVOKE ALL ON TABLE hud594tc FROM letl;
GRANT ALL ON TABLE hud594tc TO letl;
GRANT ALL ON TABLE hud594tc TO ladhoc;
GRANT ALL ON TABLE hud594tc TO lolap;
GRANT ALL ON TABLE hud594tc TO loltp;


--
-- Name: hue017tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hue017tf FROM PUBLIC;
REVOKE ALL ON TABLE hue017tf FROM letl;
GRANT ALL ON TABLE hue017tf TO letl;
GRANT ALL ON TABLE hue017tf TO ladhoc;
GRANT ALL ON TABLE hue017tf TO lolap;
GRANT ALL ON TABLE hue017tf TO loltp;


--
-- Name: huf40dtm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE huf40dtm FROM PUBLIC;
REVOKE ALL ON TABLE huf40dtm FROM letl;
GRANT ALL ON TABLE huf40dtm TO letl;
GRANT ALL ON TABLE huf40dtm TO ladhoc;
GRANT ALL ON TABLE huf40dtm TO lolap;
GRANT ALL ON TABLE huf40dtm TO loltp;


--
-- Name: huf410tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE huf410tm FROM PUBLIC;
REVOKE ALL ON TABLE huf410tm FROM letl;
GRANT ALL ON TABLE huf410tm TO letl;
GRANT ALL ON TABLE huf410tm TO ladhoc;
GRANT ALL ON TABLE huf410tm TO lolap;
GRANT ALL ON TABLE huf410tm TO loltp;


--
-- Name: huf415tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE huf415tf FROM PUBLIC;
REVOKE ALL ON TABLE huf415tf FROM letl;
GRANT ALL ON TABLE huf415tf TO letl;
GRANT ALL ON TABLE huf415tf TO ladhoc;
GRANT ALL ON TABLE huf415tf TO lolap;
GRANT ALL ON TABLE huf415tf TO loltp;


--
-- Name: huf419tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE huf419tf FROM PUBLIC;
REVOKE ALL ON TABLE huf419tf FROM letl;
GRANT ALL ON TABLE huf419tf TO letl;
GRANT ALL ON TABLE huf419tf TO ladhoc;
GRANT ALL ON TABLE huf419tf TO lolap;
GRANT ALL ON TABLE huf419tf TO loltp;


--
-- Name: huf41atf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE huf41atf FROM PUBLIC;
REVOKE ALL ON TABLE huf41atf FROM letl;
GRANT ALL ON TABLE huf41atf TO letl;
GRANT ALL ON TABLE huf41atf TO ladhoc;
GRANT ALL ON TABLE huf41atf TO lolap;
GRANT ALL ON TABLE huf41atf TO loltp;


--
-- Name: huf41btf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE huf41btf FROM PUBLIC;
REVOKE ALL ON TABLE huf41btf FROM letl;
GRANT ALL ON TABLE huf41btf TO letl;
GRANT ALL ON TABLE huf41btf TO ladhoc;
GRANT ALL ON TABLE huf41btf TO lolap;
GRANT ALL ON TABLE huf41btf TO loltp;


--
-- Name: hum008tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum008tm FROM PUBLIC;
REVOKE ALL ON TABLE hum008tm FROM letl;
GRANT ALL ON TABLE hum008tm TO letl;
GRANT ALL ON TABLE hum008tm TO ladhoc;
GRANT ALL ON TABLE hum008tm TO lolap;
GRANT ALL ON TABLE hum008tm TO loltp;


--
-- Name: hum201tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum201tm FROM PUBLIC;
REVOKE ALL ON TABLE hum201tm FROM letl;
GRANT ALL ON TABLE hum201tm TO letl;
GRANT ALL ON TABLE hum201tm TO ladhoc;
GRANT ALL ON TABLE hum201tm TO lolap;
GRANT ALL ON TABLE hum201tm TO loltp;


--
-- Name: hum202tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum202tm FROM PUBLIC;
REVOKE ALL ON TABLE hum202tm FROM letl;
GRANT ALL ON TABLE hum202tm TO letl;
GRANT ALL ON TABLE hum202tm TO ladhoc;
GRANT ALL ON TABLE hum202tm TO lolap;
GRANT ALL ON TABLE hum202tm TO loltp;


--
-- Name: hum203tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum203tm FROM PUBLIC;
REVOKE ALL ON TABLE hum203tm FROM letl;
GRANT ALL ON TABLE hum203tm TO letl;
GRANT ALL ON TABLE hum203tm TO ladhoc;
GRANT ALL ON TABLE hum203tm TO lolap;
GRANT ALL ON TABLE hum203tm TO loltp;


--
-- Name: hum204tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum204tm FROM PUBLIC;
REVOKE ALL ON TABLE hum204tm FROM letl;
GRANT ALL ON TABLE hum204tm TO letl;
GRANT ALL ON TABLE hum204tm TO ladhoc;
GRANT ALL ON TABLE hum204tm TO lolap;
GRANT ALL ON TABLE hum204tm TO loltp;


--
-- Name: hum209tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum209tf FROM PUBLIC;
REVOKE ALL ON TABLE hum209tf FROM letl;
GRANT ALL ON TABLE hum209tf TO letl;
GRANT ALL ON TABLE hum209tf TO ladhoc;
GRANT ALL ON TABLE hum209tf TO lolap;
GRANT ALL ON TABLE hum209tf TO loltp;


--
-- Name: hum210tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum210tf FROM PUBLIC;
REVOKE ALL ON TABLE hum210tf FROM letl;
GRANT ALL ON TABLE hum210tf TO letl;
GRANT ALL ON TABLE hum210tf TO ladhoc;
GRANT ALL ON TABLE hum210tf TO lolap;
GRANT ALL ON TABLE hum210tf TO loltp;


--
-- Name: hum211tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum211tf FROM PUBLIC;
REVOKE ALL ON TABLE hum211tf FROM letl;
GRANT ALL ON TABLE hum211tf TO letl;
GRANT ALL ON TABLE hum211tf TO ladhoc;
GRANT ALL ON TABLE hum211tf TO lolap;
GRANT ALL ON TABLE hum211tf TO loltp;


--
-- Name: hum213tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum213tf FROM PUBLIC;
REVOKE ALL ON TABLE hum213tf FROM letl;
GRANT ALL ON TABLE hum213tf TO letl;
GRANT ALL ON TABLE hum213tf TO ladhoc;
GRANT ALL ON TABLE hum213tf TO lolap;
GRANT ALL ON TABLE hum213tf TO loltp;


--
-- Name: hum215tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum215tm FROM PUBLIC;
REVOKE ALL ON TABLE hum215tm FROM letl;
GRANT ALL ON TABLE hum215tm TO letl;
GRANT ALL ON TABLE hum215tm TO ladhoc;
GRANT ALL ON TABLE hum215tm TO lolap;
GRANT ALL ON TABLE hum215tm TO loltp;


--
-- Name: hum216tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum216tm FROM PUBLIC;
REVOKE ALL ON TABLE hum216tm FROM letl;
GRANT ALL ON TABLE hum216tm TO letl;
GRANT ALL ON TABLE hum216tm TO ladhoc;
GRANT ALL ON TABLE hum216tm TO lolap;
GRANT ALL ON TABLE hum216tm TO loltp;


--
-- Name: hum218tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum218tm FROM PUBLIC;
REVOKE ALL ON TABLE hum218tm FROM letl;
GRANT ALL ON TABLE hum218tm TO letl;
GRANT ALL ON TABLE hum218tm TO ladhoc;
GRANT ALL ON TABLE hum218tm TO lolap;
GRANT ALL ON TABLE hum218tm TO loltp;


--
-- Name: hum219tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum219tf FROM PUBLIC;
REVOKE ALL ON TABLE hum219tf FROM letl;
GRANT ALL ON TABLE hum219tf TO letl;
GRANT ALL ON TABLE hum219tf TO ladhoc;
GRANT ALL ON TABLE hum219tf TO lolap;
GRANT ALL ON TABLE hum219tf TO loltp;


--
-- Name: hum401tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum401tm FROM PUBLIC;
REVOKE ALL ON TABLE hum401tm FROM letl;
GRANT ALL ON TABLE hum401tm TO letl;
GRANT ALL ON TABLE hum401tm TO ladhoc;
GRANT ALL ON TABLE hum401tm TO lolap;
GRANT ALL ON TABLE hum401tm TO loltp;


--
-- Name: hum402tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum402tm FROM PUBLIC;
REVOKE ALL ON TABLE hum402tm FROM letl;
GRANT ALL ON TABLE hum402tm TO letl;
GRANT ALL ON TABLE hum402tm TO ladhoc;
GRANT ALL ON TABLE hum402tm TO lolap;
GRANT ALL ON TABLE hum402tm TO loltp;


--
-- Name: hum403tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum403tm FROM PUBLIC;
REVOKE ALL ON TABLE hum403tm FROM letl;
GRANT ALL ON TABLE hum403tm TO letl;
GRANT ALL ON TABLE hum403tm TO ladhoc;
GRANT ALL ON TABLE hum403tm TO lolap;
GRANT ALL ON TABLE hum403tm TO loltp;


--
-- Name: hum405tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum405tm FROM PUBLIC;
REVOKE ALL ON TABLE hum405tm FROM letl;
GRANT ALL ON TABLE hum405tm TO letl;
GRANT ALL ON TABLE hum405tm TO ladhoc;
GRANT ALL ON TABLE hum405tm TO lolap;
GRANT ALL ON TABLE hum405tm TO loltp;


--
-- Name: hum40btm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum40btm FROM PUBLIC;
REVOKE ALL ON TABLE hum40btm FROM letl;
GRANT ALL ON TABLE hum40btm TO letl;
GRANT ALL ON TABLE hum40btm TO ladhoc;
GRANT ALL ON TABLE hum40btm TO lolap;
GRANT ALL ON TABLE hum40btm TO loltp;


--
-- Name: hum421tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum421tf FROM PUBLIC;
REVOKE ALL ON TABLE hum421tf FROM letl;
GRANT ALL ON TABLE hum421tf TO letl;
GRANT ALL ON TABLE hum421tf TO ladhoc;
GRANT ALL ON TABLE hum421tf TO lolap;
GRANT ALL ON TABLE hum421tf TO loltp;


--
-- Name: hum493tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum493tm FROM PUBLIC;
REVOKE ALL ON TABLE hum493tm FROM letl;
GRANT ALL ON TABLE hum493tm TO letl;
GRANT ALL ON TABLE hum493tm TO ladhoc;
GRANT ALL ON TABLE hum493tm TO lolap;
GRANT ALL ON TABLE hum493tm TO loltp;


--
-- Name: hum4b2tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum4b2tm FROM PUBLIC;
REVOKE ALL ON TABLE hum4b2tm FROM letl;
GRANT ALL ON TABLE hum4b2tm TO letl;
GRANT ALL ON TABLE hum4b2tm TO ladhoc;
GRANT ALL ON TABLE hum4b2tm TO lolap;
GRANT ALL ON TABLE hum4b2tm TO loltp;


--
-- Name: hum507tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum507tf FROM PUBLIC;
REVOKE ALL ON TABLE hum507tf FROM letl;
GRANT ALL ON TABLE hum507tf TO letl;
GRANT ALL ON TABLE hum507tf TO ladhoc;
GRANT ALL ON TABLE hum507tf TO lolap;
GRANT ALL ON TABLE hum507tf TO loltp;


--
-- Name: hum508tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum508tf FROM PUBLIC;
REVOKE ALL ON TABLE hum508tf FROM letl;
GRANT ALL ON TABLE hum508tf TO letl;
GRANT ALL ON TABLE hum508tf TO ladhoc;
GRANT ALL ON TABLE hum508tf TO lolap;
GRANT ALL ON TABLE hum508tf TO loltp;


--
-- Name: hum516tf; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum516tf FROM PUBLIC;
REVOKE ALL ON TABLE hum516tf FROM letl;
GRANT ALL ON TABLE hum516tf TO letl;
GRANT ALL ON TABLE hum516tf TO ladhoc;
GRANT ALL ON TABLE hum516tf TO lolap;
GRANT ALL ON TABLE hum516tf TO loltp;


--
-- Name: hum701tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE hum701tm FROM PUBLIC;
REVOKE ALL ON TABLE hum701tm FROM letl;
GRANT ALL ON TABLE hum701tm TO letl;
GRANT ALL ON TABLE hum701tm TO ladhoc;
GRANT ALL ON TABLE hum701tm TO lolap;
GRANT ALL ON TABLE hum701tm TO loltp;


--
-- Name: ifgl_bsw_day; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ifgl_bsw_day FROM PUBLIC;
REVOKE ALL ON TABLE ifgl_bsw_day FROM letl;
GRANT ALL ON TABLE ifgl_bsw_day TO letl;
GRANT ALL ON TABLE ifgl_bsw_day TO ladhoc;
GRANT ALL ON TABLE ifgl_bsw_day TO lolap;
GRANT ALL ON TABLE ifgl_bsw_day TO loltp;


--
-- Name: ifgl_bsw_mon; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ifgl_bsw_mon FROM PUBLIC;
REVOKE ALL ON TABLE ifgl_bsw_mon FROM letl;
GRANT ALL ON TABLE ifgl_bsw_mon TO letl;
GRANT ALL ON TABLE ifgl_bsw_mon TO ladhoc;
GRANT ALL ON TABLE ifgl_bsw_mon TO lolap;
GRANT ALL ON TABLE ifgl_bsw_mon TO loltp;


--
-- Name: ifgl_coa_tbl; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ifgl_coa_tbl FROM PUBLIC;
REVOKE ALL ON TABLE ifgl_coa_tbl FROM letl;
GRANT ALL ON TABLE ifgl_coa_tbl TO letl;
GRANT ALL ON TABLE ifgl_coa_tbl TO ladhoc;
GRANT ALL ON TABLE ifgl_coa_tbl TO lolap;
GRANT ALL ON TABLE ifgl_coa_tbl TO loltp;


--
-- Name: ifgl_coa_tbl_b9; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ifgl_coa_tbl_b9 FROM PUBLIC;
REVOKE ALL ON TABLE ifgl_coa_tbl_b9 FROM letl;
GRANT ALL ON TABLE ifgl_coa_tbl_b9 TO letl;
GRANT ALL ON TABLE ifgl_coa_tbl_b9 TO ladhoc;
GRANT ALL ON TABLE ifgl_coa_tbl_b9 TO lolap;
GRANT ALL ON TABLE ifgl_coa_tbl_b9 TO loltp;


--
-- Name: ifgl_isw_day; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ifgl_isw_day FROM PUBLIC;
REVOKE ALL ON TABLE ifgl_isw_day FROM letl;
GRANT ALL ON TABLE ifgl_isw_day TO letl;
GRANT ALL ON TABLE ifgl_isw_day TO ladhoc;
GRANT ALL ON TABLE ifgl_isw_day TO lolap;
GRANT ALL ON TABLE ifgl_isw_day TO loltp;


--
-- Name: ifgl_isw_mon; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ifgl_isw_mon FROM PUBLIC;
REVOKE ALL ON TABLE ifgl_isw_mon FROM letl;
GRANT ALL ON TABLE ifgl_isw_mon TO letl;
GRANT ALL ON TABLE ifgl_isw_mon TO ladhoc;
GRANT ALL ON TABLE ifgl_isw_mon TO lolap;
GRANT ALL ON TABLE ifgl_isw_mon TO loltp;


--
-- Name: intratrace; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE intratrace FROM PUBLIC;
REVOKE ALL ON TABLE intratrace FROM letl;
GRANT ALL ON TABLE intratrace TO letl;
GRANT ALL ON TABLE intratrace TO ladhoc;
GRANT ALL ON TABLE intratrace TO lolap;
GRANT ALL ON TABLE intratrace TO loltp;


--
-- Name: lcx_hal_tot; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE lcx_hal_tot FROM PUBLIC;
REVOKE ALL ON TABLE lcx_hal_tot FROM letl;
GRANT ALL ON TABLE lcx_hal_tot TO letl;
GRANT ALL ON TABLE lcx_hal_tot TO ladhoc;
GRANT ALL ON TABLE lcx_hal_tot TO lolap;
GRANT ALL ON TABLE lcx_hal_tot TO loltp;


--
-- Name: ld030tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ld030tm FROM PUBLIC;
REVOKE ALL ON TABLE ld030tm FROM letl;
GRANT ALL ON TABLE ld030tm TO letl;
GRANT ALL ON TABLE ld030tm TO ladhoc;
GRANT ALL ON TABLE ld030tm TO lolap;
GRANT ALL ON TABLE ld030tm TO loltp;


--
-- Name: ld061tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ld061tm FROM PUBLIC;
REVOKE ALL ON TABLE ld061tm FROM letl;
GRANT ALL ON TABLE ld061tm TO letl;
GRANT ALL ON TABLE ld061tm TO ladhoc;
GRANT ALL ON TABLE ld061tm TO lolap;
GRANT ALL ON TABLE ld061tm TO loltp;


--
-- Name: ln050tm_l; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ln050tm_l FROM PUBLIC;
REVOKE ALL ON TABLE ln050tm_l FROM letl;
GRANT ALL ON TABLE ln050tm_l TO letl;
GRANT ALL ON TABLE ln050tm_l TO ladhoc;
GRANT ALL ON TABLE ln050tm_l TO lolap;
GRANT ALL ON TABLE ln050tm_l TO loltp;


--
-- Name: ln774tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ln774tm FROM PUBLIC;
REVOKE ALL ON TABLE ln774tm FROM letl;
GRANT ALL ON TABLE ln774tm TO letl;
GRANT ALL ON TABLE ln774tm TO ladhoc;
GRANT ALL ON TABLE ln774tm TO lolap;
GRANT ALL ON TABLE ln774tm TO loltp;


--
-- Name: ln834th; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ln834th FROM PUBLIC;
REVOKE ALL ON TABLE ln834th FROM letl;
GRANT ALL ON TABLE ln834th TO letl;
GRANT ALL ON TABLE ln834th TO ladhoc;
GRANT ALL ON TABLE ln834th TO lolap;
GRANT ALL ON TABLE ln834th TO loltp;


--
-- Name: ln836th; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ln836th FROM PUBLIC;
REVOKE ALL ON TABLE ln836th FROM letl;
GRANT ALL ON TABLE ln836th TO letl;
GRANT ALL ON TABLE ln836th TO ladhoc;
GRANT ALL ON TABLE ln836th TO lolap;
GRANT ALL ON TABLE ln836th TO loltp;


--
-- Name: ln840th; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ln840th FROM PUBLIC;
REVOKE ALL ON TABLE ln840th FROM letl;
GRANT ALL ON TABLE ln840th TO letl;
GRANT ALL ON TABLE ln840th TO ladhoc;
GRANT ALL ON TABLE ln840th TO lolap;
GRANT ALL ON TABLE ln840th TO loltp;


--
-- Name: ln848th; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ln848th FROM PUBLIC;
REVOKE ALL ON TABLE ln848th FROM letl;
GRANT ALL ON TABLE ln848th TO letl;
GRANT ALL ON TABLE ln848th TO ladhoc;
GRANT ALL ON TABLE ln848th TO lolap;
GRANT ALL ON TABLE ln848th TO loltp;


--
-- Name: ln850th; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ln850th FROM PUBLIC;
REVOKE ALL ON TABLE ln850th FROM letl;
GRANT ALL ON TABLE ln850th TO letl;
GRANT ALL ON TABLE ln850th TO ladhoc;
GRANT ALL ON TABLE ln850th TO lolap;
GRANT ALL ON TABLE ln850th TO loltp;


--
-- Name: ln852th; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ln852th FROM PUBLIC;
REVOKE ALL ON TABLE ln852th FROM letl;
GRANT ALL ON TABLE ln852th TO letl;
GRANT ALL ON TABLE ln852th TO ladhoc;
GRANT ALL ON TABLE ln852th TO lolap;
GRANT ALL ON TABLE ln852th TO loltp;


--
-- Name: loan_day_tbl; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE loan_day_tbl FROM PUBLIC;
REVOKE ALL ON TABLE loan_day_tbl FROM letl;
GRANT ALL ON TABLE loan_day_tbl TO letl;
GRANT ALL ON TABLE loan_day_tbl TO ladhoc;
GRANT ALL ON TABLE loan_day_tbl TO lolap;
GRANT ALL ON TABLE loan_day_tbl TO loltp;


--
-- Name: loan_mn9988_code; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE loan_mn9988_code FROM PUBLIC;
REVOKE ALL ON TABLE loan_mn9988_code FROM letl;
GRANT ALL ON TABLE loan_mn9988_code TO letl;
GRANT ALL ON TABLE loan_mn9988_code TO ladhoc;
GRANT ALL ON TABLE loan_mn9988_code TO lolap;
GRANT ALL ON TABLE loan_mn9988_code TO loltp;


--
-- Name: loan_mn9988_mst; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE loan_mn9988_mst FROM PUBLIC;
REVOKE ALL ON TABLE loan_mn9988_mst FROM letl;
GRANT ALL ON TABLE loan_mn9988_mst TO letl;
GRANT ALL ON TABLE loan_mn9988_mst TO ladhoc;
GRANT ALL ON TABLE loan_mn9988_mst TO lolap;
GRANT ALL ON TABLE loan_mn9988_mst TO loltp;


--
-- Name: misu_bis; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE misu_bis FROM PUBLIC;
REVOKE ALL ON TABLE misu_bis FROM letl;
GRANT ALL ON TABLE misu_bis TO letl;
GRANT ALL ON TABLE misu_bis TO ladhoc;
GRANT ALL ON TABLE misu_bis TO lolap;
GRANT ALL ON TABLE misu_bis TO loltp;


--
-- Name: ms_mst_cif; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE ms_mst_cif FROM PUBLIC;
REVOKE ALL ON TABLE ms_mst_cif FROM letl;
GRANT ALL ON TABLE ms_mst_cif TO letl;
GRANT ALL ON TABLE ms_mst_cif TO ladhoc;
GRANT ALL ON TABLE ms_mst_cif TO lolap;
GRANT ALL ON TABLE ms_mst_cif TO loltp;


--
-- Name: rt_ms_mst; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE rt_ms_mst FROM PUBLIC;
REVOKE ALL ON TABLE rt_ms_mst FROM letl;
GRANT ALL ON TABLE rt_ms_mst TO letl;
GRANT ALL ON TABLE rt_ms_mst TO ladhoc;
GRANT ALL ON TABLE rt_ms_mst TO lolap;
GRANT ALL ON TABLE rt_ms_mst TO loltp;


--
-- Name: sf_org_user; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE sf_org_user FROM PUBLIC;
REVOKE ALL ON TABLE sf_org_user FROM letl;
GRANT ALL ON TABLE sf_org_user TO letl;
GRANT ALL ON TABLE sf_org_user TO ladhoc;
GRANT ALL ON TABLE sf_org_user TO lolap;
GRANT ALL ON TABLE sf_org_user TO loltp;


--
-- Name: sr002tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE sr002tm FROM PUBLIC;
REVOKE ALL ON TABLE sr002tm FROM letl;
GRANT ALL ON TABLE sr002tm TO letl;
GRANT ALL ON TABLE sr002tm TO ladhoc;
GRANT ALL ON TABLE sr002tm TO lolap;
GRANT ALL ON TABLE sr002tm TO loltp;


--
-- Name: sr010tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE sr010tm FROM PUBLIC;
REVOKE ALL ON TABLE sr010tm FROM letl;
GRANT ALL ON TABLE sr010tm TO letl;
GRANT ALL ON TABLE sr010tm TO ladhoc;
GRANT ALL ON TABLE sr010tm TO lolap;
GRANT ALL ON TABLE sr010tm TO loltp;


--
-- Name: sr_prc_req_inf_sql; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE sr_prc_req_inf_sql FROM PUBLIC;
REVOKE ALL ON TABLE sr_prc_req_inf_sql FROM letl;
GRANT ALL ON TABLE sr_prc_req_inf_sql TO letl;
GRANT ALL ON TABLE sr_prc_req_inf_sql TO ladhoc;
GRANT ALL ON TABLE sr_prc_req_inf_sql TO lolap;
GRANT ALL ON TABLE sr_prc_req_inf_sql TO loltp;


--
-- Name: tbl_lcx_bis; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE tbl_lcx_bis FROM PUBLIC;
REVOKE ALL ON TABLE tbl_lcx_bis FROM letl;
GRANT ALL ON TABLE tbl_lcx_bis TO letl;
GRANT ALL ON TABLE tbl_lcx_bis TO ladhoc;
GRANT ALL ON TABLE tbl_lcx_bis TO lolap;
GRANT ALL ON TABLE tbl_lcx_bis TO loltp;


--
-- Name: temp_acnt_ac_code; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE temp_acnt_ac_code FROM PUBLIC;
REVOKE ALL ON TABLE temp_acnt_ac_code FROM letl;
GRANT ALL ON TABLE temp_acnt_ac_code TO letl;
GRANT ALL ON TABLE temp_acnt_ac_code TO ladhoc;
GRANT ALL ON TABLE temp_acnt_ac_code TO lolap;
GRANT ALL ON TABLE temp_acnt_ac_code TO loltp;


--
-- Name: temp_acnt_ac_code_all; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE temp_acnt_ac_code_all FROM PUBLIC;
REVOKE ALL ON TABLE temp_acnt_ac_code_all FROM letl;
GRANT ALL ON TABLE temp_acnt_ac_code_all TO letl;
GRANT ALL ON TABLE temp_acnt_ac_code_all TO ladhoc;
GRANT ALL ON TABLE temp_acnt_ac_code_all TO lolap;
GRANT ALL ON TABLE temp_acnt_ac_code_all TO loltp;


--
-- Name: temp_acnt_ac_code_old; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE temp_acnt_ac_code_old FROM PUBLIC;
REVOKE ALL ON TABLE temp_acnt_ac_code_old FROM letl;
GRANT ALL ON TABLE temp_acnt_ac_code_old TO letl;
GRANT ALL ON TABLE temp_acnt_ac_code_old TO ladhoc;
GRANT ALL ON TABLE temp_acnt_ac_code_old TO lolap;
GRANT ALL ON TABLE temp_acnt_ac_code_old TO loltp;


--
-- Name: temp_hum209tf_rlt; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE temp_hum209tf_rlt FROM PUBLIC;
REVOKE ALL ON TABLE temp_hum209tf_rlt FROM letl;
GRANT ALL ON TABLE temp_hum209tf_rlt TO letl;
GRANT ALL ON TABLE temp_hum209tf_rlt TO ladhoc;
GRANT ALL ON TABLE temp_hum209tf_rlt TO lolap;
GRANT ALL ON TABLE temp_hum209tf_rlt TO loltp;


--
-- Name: temp_hum215tm_rlt; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE temp_hum215tm_rlt FROM PUBLIC;
REVOKE ALL ON TABLE temp_hum215tm_rlt FROM letl;
GRANT ALL ON TABLE temp_hum215tm_rlt TO letl;
GRANT ALL ON TABLE temp_hum215tm_rlt TO ladhoc;
GRANT ALL ON TABLE temp_hum215tm_rlt TO lolap;
GRANT ALL ON TABLE temp_hum215tm_rlt TO loltp;


--
-- Name: temp_hum216tm_rlt; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE temp_hum216tm_rlt FROM PUBLIC;
REVOKE ALL ON TABLE temp_hum216tm_rlt FROM letl;
GRANT ALL ON TABLE temp_hum216tm_rlt TO letl;
GRANT ALL ON TABLE temp_hum216tm_rlt TO ladhoc;
GRANT ALL ON TABLE temp_hum216tm_rlt TO lolap;
GRANT ALL ON TABLE temp_hum216tm_rlt TO loltp;


--
-- Name: temp_hum421tf_idx; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE temp_hum421tf_idx FROM PUBLIC;
REVOKE ALL ON TABLE temp_hum421tf_idx FROM letl;
GRANT ALL ON TABLE temp_hum421tf_idx TO letl;
GRANT ALL ON TABLE temp_hum421tf_idx TO ladhoc;
GRANT ALL ON TABLE temp_hum421tf_idx TO lolap;
GRANT ALL ON TABLE temp_hum421tf_idx TO loltp;


--
-- Name: temp_ifgl_coa_tbl; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE temp_ifgl_coa_tbl FROM PUBLIC;
REVOKE ALL ON TABLE temp_ifgl_coa_tbl FROM letl;
GRANT ALL ON TABLE temp_ifgl_coa_tbl TO letl;
GRANT ALL ON TABLE temp_ifgl_coa_tbl TO ladhoc;
GRANT ALL ON TABLE temp_ifgl_coa_tbl TO lolap;
GRANT ALL ON TABLE temp_ifgl_coa_tbl TO loltp;


--
-- Name: trns_ad_mst; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE trns_ad_mst FROM PUBLIC;
REVOKE ALL ON TABLE trns_ad_mst FROM letl;
GRANT ALL ON TABLE trns_ad_mst TO letl;
GRANT ALL ON TABLE trns_ad_mst TO ladhoc;
GRANT ALL ON TABLE trns_ad_mst TO lolap;
GRANT ALL ON TABLE trns_ad_mst TO loltp;


--
-- Name: trns_ad_mst_1; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE trns_ad_mst_1 FROM PUBLIC;
REVOKE ALL ON TABLE trns_ad_mst_1 FROM letl;
GRANT ALL ON TABLE trns_ad_mst_1 TO letl;
GRANT ALL ON TABLE trns_ad_mst_1 TO ladhoc;
GRANT ALL ON TABLE trns_ad_mst_1 TO lolap;
GRANT ALL ON TABLE trns_ad_mst_1 TO loltp;


--
-- Name: trns_ad_mst_1003; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE trns_ad_mst_1003 FROM PUBLIC;
REVOKE ALL ON TABLE trns_ad_mst_1003 FROM letl;
GRANT ALL ON TABLE trns_ad_mst_1003 TO letl;
GRANT ALL ON TABLE trns_ad_mst_1003 TO ladhoc;
GRANT ALL ON TABLE trns_ad_mst_1003 TO lolap;
GRANT ALL ON TABLE trns_ad_mst_1003 TO loltp;


--
-- Name: trns_fi_doc; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE trns_fi_doc FROM PUBLIC;
REVOKE ALL ON TABLE trns_fi_doc FROM letl;
GRANT ALL ON TABLE trns_fi_doc TO letl;
GRANT ALL ON TABLE trns_fi_doc TO ladhoc;
GRANT ALL ON TABLE trns_fi_doc TO lolap;
GRANT ALL ON TABLE trns_fi_doc TO loltp;


--
-- Name: trns_seobu_rst; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE trns_seobu_rst FROM PUBLIC;
REVOKE ALL ON TABLE trns_seobu_rst FROM letl;
GRANT ALL ON TABLE trns_seobu_rst TO letl;
GRANT ALL ON TABLE trns_seobu_rst TO ladhoc;
GRANT ALL ON TABLE trns_seobu_rst TO lolap;
GRANT ALL ON TABLE trns_seobu_rst TO loltp;


--
-- Name: tum60atm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE tum60atm FROM PUBLIC;
REVOKE ALL ON TABLE tum60atm FROM letl;
GRANT ALL ON TABLE tum60atm TO letl;
GRANT ALL ON TABLE tum60atm TO ladhoc;
GRANT ALL ON TABLE tum60atm TO lolap;
GRANT ALL ON TABLE tum60atm TO loltp;


--
-- Name: tum611tm; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE tum611tm FROM PUBLIC;
REVOKE ALL ON TABLE tum611tm FROM letl;
GRANT ALL ON TABLE tum611tm TO letl;
GRANT ALL ON TABLE tum611tm TO ladhoc;
GRANT ALL ON TABLE tum611tm TO lolap;
GRANT ALL ON TABLE tum611tm TO loltp;


--
-- Name: xpr_arv_mkt_cus; Type: ACL; Schema: sdmin; Owner: letl
--

REVOKE ALL ON TABLE xpr_arv_mkt_cus FROM PUBLIC;
REVOKE ALL ON TABLE xpr_arv_mkt_cus FROM letl;
GRANT ALL ON TABLE xpr_arv_mkt_cus TO letl;
GRANT ALL ON TABLE xpr_arv_mkt_cus TO ladhoc;
GRANT ALL ON TABLE xpr_arv_mkt_cus TO lolap;
GRANT ALL ON TABLE xpr_arv_mkt_cus TO loltp;


SET search_path = sdmin_err, pg_catalog;

--
-- Name: acnt_ac_code_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE acnt_ac_code_err FROM PUBLIC;
REVOKE ALL ON TABLE acnt_ac_code_err FROM letl;
GRANT ALL ON TABLE acnt_ac_code_err TO letl;
GRANT ALL ON TABLE acnt_ac_code_err TO ladhoc;
GRANT ALL ON TABLE acnt_ac_code_err TO lolap;
GRANT ALL ON TABLE acnt_ac_code_err TO loltp;


--
-- Name: audt_ja_app_result_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE audt_ja_app_result_err FROM PUBLIC;
REVOKE ALL ON TABLE audt_ja_app_result_err FROM letl;
GRANT ALL ON TABLE audt_ja_app_result_err TO letl;
GRANT ALL ON TABLE audt_ja_app_result_err TO ladhoc;
GRANT ALL ON TABLE audt_ja_app_result_err TO lolap;
GRANT ALL ON TABLE audt_ja_app_result_err TO loltp;


--
-- Name: audt_ja_confirm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE audt_ja_confirm_err FROM PUBLIC;
REVOKE ALL ON TABLE audt_ja_confirm_err FROM letl;
GRANT ALL ON TABLE audt_ja_confirm_err TO letl;
GRANT ALL ON TABLE audt_ja_confirm_err TO ladhoc;
GRANT ALL ON TABLE audt_ja_confirm_err TO lolap;
GRANT ALL ON TABLE audt_ja_confirm_err TO loltp;


--
-- Name: audt_ja_depo_mrtg_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE audt_ja_depo_mrtg_err FROM PUBLIC;
REVOKE ALL ON TABLE audt_ja_depo_mrtg_err FROM letl;
GRANT ALL ON TABLE audt_ja_depo_mrtg_err TO letl;
GRANT ALL ON TABLE audt_ja_depo_mrtg_err TO ladhoc;
GRANT ALL ON TABLE audt_ja_depo_mrtg_err TO lolap;
GRANT ALL ON TABLE audt_ja_depo_mrtg_err TO loltp;


--
-- Name: audt_ja_opn_apv_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE audt_ja_opn_apv_err FROM PUBLIC;
REVOKE ALL ON TABLE audt_ja_opn_apv_err FROM letl;
GRANT ALL ON TABLE audt_ja_opn_apv_err TO letl;
GRANT ALL ON TABLE audt_ja_opn_apv_err TO ladhoc;
GRANT ALL ON TABLE audt_ja_opn_apv_err TO lolap;
GRANT ALL ON TABLE audt_ja_opn_apv_err TO loltp;


--
-- Name: audt_ja_ss_mst_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE audt_ja_ss_mst_err FROM PUBLIC;
REVOKE ALL ON TABLE audt_ja_ss_mst_err FROM letl;
GRANT ALL ON TABLE audt_ja_ss_mst_err TO letl;
GRANT ALL ON TABLE audt_ja_ss_mst_err TO ladhoc;
GRANT ALL ON TABLE audt_ja_ss_mst_err TO lolap;
GRANT ALL ON TABLE audt_ja_ss_mst_err TO loltp;


--
-- Name: audt_vaca_tbl_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE audt_vaca_tbl_err FROM PUBLIC;
REVOKE ALL ON TABLE audt_vaca_tbl_err FROM letl;
GRANT ALL ON TABLE audt_vaca_tbl_err TO letl;
GRANT ALL ON TABLE audt_vaca_tbl_err TO ladhoc;
GRANT ALL ON TABLE audt_vaca_tbl_err TO lolap;
GRANT ALL ON TABLE audt_vaca_tbl_err TO loltp;


--
-- Name: bind_depo_opn_trn_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE bind_depo_opn_trn_err FROM PUBLIC;
REVOKE ALL ON TABLE bind_depo_opn_trn_err FROM letl;
GRANT ALL ON TABLE bind_depo_opn_trn_err TO letl;
GRANT ALL ON TABLE bind_depo_opn_trn_err TO ladhoc;
GRANT ALL ON TABLE bind_depo_opn_trn_err TO lolap;
GRANT ALL ON TABLE bind_depo_opn_trn_err TO loltp;


--
-- Name: card_flc_mihando_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE card_flc_mihando_err FROM PUBLIC;
REVOKE ALL ON TABLE card_flc_mihando_err FROM letl;
GRANT ALL ON TABLE card_flc_mihando_err TO letl;
GRANT ALL ON TABLE card_flc_mihando_err TO ladhoc;
GRANT ALL ON TABLE card_flc_mihando_err TO lolap;
GRANT ALL ON TABLE card_flc_mihando_err TO loltp;


--
-- Name: card_flc_mst_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE card_flc_mst_err FROM PUBLIC;
REVOKE ALL ON TABLE card_flc_mst_err FROM letl;
GRANT ALL ON TABLE card_flc_mst_err TO letl;
GRANT ALL ON TABLE card_flc_mst_err TO ladhoc;
GRANT ALL ON TABLE card_flc_mst_err TO lolap;
GRANT ALL ON TABLE card_flc_mst_err TO loltp;


--
-- Name: code_detail_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE code_detail_err FROM PUBLIC;
REVOKE ALL ON TABLE code_detail_err FROM letl;
GRANT ALL ON TABLE code_detail_err TO letl;
GRANT ALL ON TABLE code_detail_err TO ladhoc;
GRANT ALL ON TABLE code_detail_err TO lolap;
GRANT ALL ON TABLE code_detail_err TO loltp;


--
-- Name: comm_bk_mast_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE comm_bk_mast_err FROM PUBLIC;
REVOKE ALL ON TABLE comm_bk_mast_err FROM letl;
GRANT ALL ON TABLE comm_bk_mast_err TO letl;
GRANT ALL ON TABLE comm_bk_mast_err TO ladhoc;
GRANT ALL ON TABLE comm_bk_mast_err TO lolap;
GRANT ALL ON TABLE comm_bk_mast_err TO loltp;


--
-- Name: comm_br_brch_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE comm_br_brch_err FROM PUBLIC;
REVOKE ALL ON TABLE comm_br_brch_err FROM letl;
GRANT ALL ON TABLE comm_br_brch_err TO letl;
GRANT ALL ON TABLE comm_br_brch_err TO ladhoc;
GRANT ALL ON TABLE comm_br_brch_err TO lolap;
GRANT ALL ON TABLE comm_br_brch_err TO loltp;


--
-- Name: comm_cd_every_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE comm_cd_every_err FROM PUBLIC;
REVOKE ALL ON TABLE comm_cd_every_err FROM letl;
GRANT ALL ON TABLE comm_cd_every_err TO letl;
GRANT ALL ON TABLE comm_cd_every_err TO ladhoc;
GRANT ALL ON TABLE comm_cd_every_err TO lolap;
GRANT ALL ON TABLE comm_cd_every_err TO loltp;


--
-- Name: comm_ep_emp_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE comm_ep_emp_err FROM PUBLIC;
REVOKE ALL ON TABLE comm_ep_emp_err FROM letl;
GRANT ALL ON TABLE comm_ep_emp_err TO letl;
GRANT ALL ON TABLE comm_ep_emp_err TO ladhoc;
GRANT ALL ON TABLE comm_ep_emp_err TO lolap;
GRANT ALL ON TABLE comm_ep_emp_err TO loltp;


--
-- Name: comm_im_paper_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE comm_im_paper_err FROM PUBLIC;
REVOKE ALL ON TABLE comm_im_paper_err FROM letl;
GRANT ALL ON TABLE comm_im_paper_err TO letl;
GRANT ALL ON TABLE comm_im_paper_err TO ladhoc;
GRANT ALL ON TABLE comm_im_paper_err TO lolap;
GRANT ALL ON TABLE comm_im_paper_err TO loltp;


--
-- Name: comm_menu_step_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE comm_menu_step_err FROM PUBLIC;
REVOKE ALL ON TABLE comm_menu_step_err FROM letl;
GRANT ALL ON TABLE comm_menu_step_err TO letl;
GRANT ALL ON TABLE comm_menu_step_err TO ladhoc;
GRANT ALL ON TABLE comm_menu_step_err TO lolap;
GRANT ALL ON TABLE comm_menu_step_err TO loltp;


--
-- Name: comm_mr_cif_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE comm_mr_cif_err FROM PUBLIC;
REVOKE ALL ON TABLE comm_mr_cif_err FROM letl;
GRANT ALL ON TABLE comm_mr_cif_err TO letl;
GRANT ALL ON TABLE comm_mr_cif_err TO ladhoc;
GRANT ALL ON TABLE comm_mr_cif_err TO lolap;
GRANT ALL ON TABLE comm_mr_cif_err TO loltp;


--
-- Name: comm_mr_mgr_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE comm_mr_mgr_err FROM PUBLIC;
REVOKE ALL ON TABLE comm_mr_mgr_err FROM letl;
GRANT ALL ON TABLE comm_mr_mgr_err TO letl;
GRANT ALL ON TABLE comm_mr_mgr_err TO ladhoc;
GRANT ALL ON TABLE comm_mr_mgr_err TO lolap;
GRANT ALL ON TABLE comm_mr_mgr_err TO loltp;


--
-- Name: comm_pb_ct_result_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE comm_pb_ct_result_err FROM PUBLIC;
REVOKE ALL ON TABLE comm_pb_ct_result_err FROM letl;
GRANT ALL ON TABLE comm_pb_ct_result_err TO letl;
GRANT ALL ON TABLE comm_pb_ct_result_err TO ladhoc;
GRANT ALL ON TABLE comm_pb_ct_result_err TO lolap;
GRANT ALL ON TABLE comm_pb_ct_result_err TO loltp;


--
-- Name: comm_pb_mg_cif_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE comm_pb_mg_cif_err FROM PUBLIC;
REVOKE ALL ON TABLE comm_pb_mg_cif_err FROM letl;
GRANT ALL ON TABLE comm_pb_mg_cif_err TO letl;
GRANT ALL ON TABLE comm_pb_mg_cif_err TO ladhoc;
GRANT ALL ON TABLE comm_pb_mg_cif_err TO lolap;
GRANT ALL ON TABLE comm_pb_mg_cif_err TO loltp;


--
-- Name: comm_vaca_tbl_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE comm_vaca_tbl_err FROM PUBLIC;
REVOKE ALL ON TABLE comm_vaca_tbl_err FROM letl;
GRANT ALL ON TABLE comm_vaca_tbl_err TO letl;
GRANT ALL ON TABLE comm_vaca_tbl_err TO ladhoc;
GRANT ALL ON TABLE comm_vaca_tbl_err TO lolap;
GRANT ALL ON TABLE comm_vaca_tbl_err TO loltp;


--
-- Name: crms_trace_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE crms_trace_err FROM PUBLIC;
REVOKE ALL ON TABLE crms_trace_err FROM letl;
GRANT ALL ON TABLE crms_trace_err TO letl;
GRANT ALL ON TABLE crms_trace_err TO ladhoc;
GRANT ALL ON TABLE crms_trace_err TO lolap;
GRANT ALL ON TABLE crms_trace_err TO loltp;


--
-- Name: cu040tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE cu040tf_err FROM PUBLIC;
REVOKE ALL ON TABLE cu040tf_err FROM letl;
GRANT ALL ON TABLE cu040tf_err TO letl;
GRANT ALL ON TABLE cu040tf_err TO ladhoc;
GRANT ALL ON TABLE cu040tf_err TO lolap;
GRANT ALL ON TABLE cu040tf_err TO loltp;


--
-- Name: cust_ba_base_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE cust_ba_base_err FROM PUBLIC;
REVOKE ALL ON TABLE cust_ba_base_err FROM letl;
GRANT ALL ON TABLE cust_ba_base_err TO letl;
GRANT ALL ON TABLE cust_ba_base_err TO ladhoc;
GRANT ALL ON TABLE cust_ba_base_err TO lolap;
GRANT ALL ON TABLE cust_ba_base_err TO loltp;


--
-- Name: cust_ba_juso_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE cust_ba_juso_err FROM PUBLIC;
REVOKE ALL ON TABLE cust_ba_juso_err FROM letl;
GRANT ALL ON TABLE cust_ba_juso_err TO letl;
GRANT ALL ON TABLE cust_ba_juso_err TO ladhoc;
GRANT ALL ON TABLE cust_ba_juso_err TO lolap;
GRANT ALL ON TABLE cust_ba_juso_err TO loltp;


--
-- Name: cust_rl_dt_tbl_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE cust_rl_dt_tbl_err FROM PUBLIC;
REVOKE ALL ON TABLE cust_rl_dt_tbl_err FROM letl;
GRANT ALL ON TABLE cust_rl_dt_tbl_err TO letl;
GRANT ALL ON TABLE cust_rl_dt_tbl_err TO ladhoc;
GRANT ALL ON TABLE cust_rl_dt_tbl_err TO lolap;
GRANT ALL ON TABLE cust_rl_dt_tbl_err TO loltp;


--
-- Name: cust_rl_vp_tbl_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE cust_rl_vp_tbl_err FROM PUBLIC;
REVOKE ALL ON TABLE cust_rl_vp_tbl_err FROM letl;
GRANT ALL ON TABLE cust_rl_vp_tbl_err TO letl;
GRANT ALL ON TABLE cust_rl_vp_tbl_err TO ladhoc;
GRANT ALL ON TABLE cust_rl_vp_tbl_err TO lolap;
GRANT ALL ON TABLE cust_rl_vp_tbl_err TO loltp;


--
-- Name: depo_ac_comm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE depo_ac_comm_err FROM PUBLIC;
REVOKE ALL ON TABLE depo_ac_comm_err FROM letl;
GRANT ALL ON TABLE depo_ac_comm_err TO letl;
GRANT ALL ON TABLE depo_ac_comm_err TO ladhoc;
GRANT ALL ON TABLE depo_ac_comm_err TO lolap;
GRANT ALL ON TABLE depo_ac_comm_err TO loltp;


--
-- Name: depo_bd_dbal_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE depo_bd_dbal_err FROM PUBLIC;
REVOKE ALL ON TABLE depo_bd_dbal_err FROM letl;
GRANT ALL ON TABLE depo_bd_dbal_err TO letl;
GRANT ALL ON TABLE depo_bd_dbal_err TO ladhoc;
GRANT ALL ON TABLE depo_bd_dbal_err TO lolap;
GRANT ALL ON TABLE depo_bd_dbal_err TO loltp;


--
-- Name: depo_cv_davg_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE depo_cv_davg_err FROM PUBLIC;
REVOKE ALL ON TABLE depo_cv_davg_err FROM letl;
GRANT ALL ON TABLE depo_cv_davg_err TO letl;
GRANT ALL ON TABLE depo_cv_davg_err TO ladhoc;
GRANT ALL ON TABLE depo_cv_davg_err TO lolap;
GRANT ALL ON TABLE depo_cv_davg_err TO loltp;


--
-- Name: depo_cv_info_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE depo_cv_info_err FROM PUBLIC;
REVOKE ALL ON TABLE depo_cv_info_err FROM letl;
GRANT ALL ON TABLE depo_cv_info_err TO letl;
GRANT ALL ON TABLE depo_cv_info_err TO ladhoc;
GRANT ALL ON TABLE depo_cv_info_err TO lolap;
GRANT ALL ON TABLE depo_cv_info_err TO loltp;


--
-- Name: depo_ex_inf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE depo_ex_inf_err FROM PUBLIC;
REVOKE ALL ON TABLE depo_ex_inf_err FROM letl;
GRANT ALL ON TABLE depo_ex_inf_err TO letl;
GRANT ALL ON TABLE depo_ex_inf_err TO ladhoc;
GRANT ALL ON TABLE depo_ex_inf_err TO lolap;
GRANT ALL ON TABLE depo_ex_inf_err TO loltp;


--
-- Name: depo_exp_tongbo_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE depo_exp_tongbo_err FROM PUBLIC;
REVOKE ALL ON TABLE depo_exp_tongbo_err FROM letl;
GRANT ALL ON TABLE depo_exp_tongbo_err TO letl;
GRANT ALL ON TABLE depo_exp_tongbo_err TO ladhoc;
GRANT ALL ON TABLE depo_exp_tongbo_err TO lolap;
GRANT ALL ON TABLE depo_exp_tongbo_err TO loltp;


--
-- Name: depo_mm_dbal_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE depo_mm_dbal_err FROM PUBLIC;
REVOKE ALL ON TABLE depo_mm_dbal_err FROM letl;
GRANT ALL ON TABLE depo_mm_dbal_err TO letl;
GRANT ALL ON TABLE depo_mm_dbal_err TO ladhoc;
GRANT ALL ON TABLE depo_mm_dbal_err TO lolap;
GRANT ALL ON TABLE depo_mm_dbal_err TO loltp;


--
-- Name: depo_mm_mbal_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE depo_mm_mbal_err FROM PUBLIC;
REVOKE ALL ON TABLE depo_mm_mbal_err FROM letl;
GRANT ALL ON TABLE depo_mm_mbal_err TO letl;
GRANT ALL ON TABLE depo_mm_mbal_err TO ladhoc;
GRANT ALL ON TABLE depo_mm_mbal_err TO lolap;
GRANT ALL ON TABLE depo_mm_mbal_err TO loltp;


--
-- Name: depo_mm_woltb_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE depo_mm_woltb_err FROM PUBLIC;
REVOKE ALL ON TABLE depo_mm_woltb_err FROM letl;
GRANT ALL ON TABLE depo_mm_woltb_err TO letl;
GRANT ALL ON TABLE depo_mm_woltb_err TO ladhoc;
GRANT ALL ON TABLE depo_mm_woltb_err TO lolap;
GRANT ALL ON TABLE depo_mm_woltb_err TO loltp;


--
-- Name: depo_rg_bond_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE depo_rg_bond_err FROM PUBLIC;
REVOKE ALL ON TABLE depo_rg_bond_err FROM letl;
GRANT ALL ON TABLE depo_rg_bond_err TO letl;
GRANT ALL ON TABLE depo_rg_bond_err TO ladhoc;
GRANT ALL ON TABLE depo_rg_bond_err TO lolap;
GRANT ALL ON TABLE depo_rg_bond_err TO loltp;


--
-- Name: depo_sj_mas_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE depo_sj_mas_err FROM PUBLIC;
REVOKE ALL ON TABLE depo_sj_mas_err FROM letl;
GRANT ALL ON TABLE depo_sj_mas_err TO letl;
GRANT ALL ON TABLE depo_sj_mas_err TO ladhoc;
GRANT ALL ON TABLE depo_sj_mas_err TO lolap;
GRANT ALL ON TABLE depo_sj_mas_err TO loltp;


--
-- Name: depo_tr_mas_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE depo_tr_mas_err FROM PUBLIC;
REVOKE ALL ON TABLE depo_tr_mas_err FROM letl;
GRANT ALL ON TABLE depo_tr_mas_err TO letl;
GRANT ALL ON TABLE depo_tr_mas_err TO ladhoc;
GRANT ALL ON TABLE depo_tr_mas_err TO lolap;
GRANT ALL ON TABLE depo_tr_mas_err TO loltp;


--
-- Name: ea13mt_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ea13mt_err FROM PUBLIC;
REVOKE ALL ON TABLE ea13mt_err FROM letl;
GRANT ALL ON TABLE ea13mt_err TO letl;
GRANT ALL ON TABLE ea13mt_err TO ladhoc;
GRANT ALL ON TABLE ea13mt_err TO lolap;
GRANT ALL ON TABLE ea13mt_err TO loltp;


--
-- Name: foex_de_dept_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE foex_de_dept_err FROM PUBLIC;
REVOKE ALL ON TABLE foex_de_dept_err FROM letl;
GRANT ALL ON TABLE foex_de_dept_err TO letl;
GRANT ALL ON TABLE foex_de_dept_err TO ladhoc;
GRANT ALL ON TABLE foex_de_dept_err TO lolap;
GRANT ALL ON TABLE foex_de_dept_err TO loltp;


--
-- Name: gita_rpcd_tbl_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE gita_rpcd_tbl_err FROM PUBLIC;
REVOKE ALL ON TABLE gita_rpcd_tbl_err FROM letl;
GRANT ALL ON TABLE gita_rpcd_tbl_err TO letl;
GRANT ALL ON TABLE gita_rpcd_tbl_err TO ladhoc;
GRANT ALL ON TABLE gita_rpcd_tbl_err TO lolap;
GRANT ALL ON TABLE gita_rpcd_tbl_err TO loltp;


--
-- Name: gita_rpdata_tbl_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE gita_rpdata_tbl_err FROM PUBLIC;
REVOKE ALL ON TABLE gita_rpdata_tbl_err FROM letl;
GRANT ALL ON TABLE gita_rpdata_tbl_err TO letl;
GRANT ALL ON TABLE gita_rpdata_tbl_err TO ladhoc;
GRANT ALL ON TABLE gita_rpdata_tbl_err TO lolap;
GRANT ALL ON TABLE gita_rpdata_tbl_err TO loltp;


--
-- Name: hu0b18tc_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0b18tc_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0b18tc_err FROM letl;
GRANT ALL ON TABLE hu0b18tc_err TO letl;
GRANT ALL ON TABLE hu0b18tc_err TO ladhoc;
GRANT ALL ON TABLE hu0b18tc_err TO lolap;
GRANT ALL ON TABLE hu0b18tc_err TO loltp;


--
-- Name: hu0b19tc_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0b19tc_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0b19tc_err FROM letl;
GRANT ALL ON TABLE hu0b19tc_err TO letl;
GRANT ALL ON TABLE hu0b19tc_err TO ladhoc;
GRANT ALL ON TABLE hu0b19tc_err TO lolap;
GRANT ALL ON TABLE hu0b19tc_err TO loltp;


--
-- Name: hu0b20tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0b20tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0b20tm_err FROM letl;
GRANT ALL ON TABLE hu0b20tm_err TO letl;
GRANT ALL ON TABLE hu0b20tm_err TO ladhoc;
GRANT ALL ON TABLE hu0b20tm_err TO lolap;
GRANT ALL ON TABLE hu0b20tm_err TO loltp;


--
-- Name: hu0b21tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0b21tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0b21tm_err FROM letl;
GRANT ALL ON TABLE hu0b21tm_err TO letl;
GRANT ALL ON TABLE hu0b21tm_err TO ladhoc;
GRANT ALL ON TABLE hu0b21tm_err TO lolap;
GRANT ALL ON TABLE hu0b21tm_err TO loltp;


--
-- Name: hu0b34tc_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0b34tc_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0b34tc_err FROM letl;
GRANT ALL ON TABLE hu0b34tc_err TO letl;
GRANT ALL ON TABLE hu0b34tc_err TO ladhoc;
GRANT ALL ON TABLE hu0b34tc_err TO lolap;
GRANT ALL ON TABLE hu0b34tc_err TO loltp;


--
-- Name: hu0b41tc_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0b41tc_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0b41tc_err FROM letl;
GRANT ALL ON TABLE hu0b41tc_err TO letl;
GRANT ALL ON TABLE hu0b41tc_err TO ladhoc;
GRANT ALL ON TABLE hu0b41tc_err TO lolap;
GRANT ALL ON TABLE hu0b41tc_err TO loltp;


--
-- Name: hu0b44tc_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0b44tc_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0b44tc_err FROM letl;
GRANT ALL ON TABLE hu0b44tc_err TO letl;
GRANT ALL ON TABLE hu0b44tc_err TO ladhoc;
GRANT ALL ON TABLE hu0b44tc_err TO lolap;
GRANT ALL ON TABLE hu0b44tc_err TO loltp;


--
-- Name: hu0d01tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0d01tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0d01tm_err FROM letl;
GRANT ALL ON TABLE hu0d01tm_err TO letl;
GRANT ALL ON TABLE hu0d01tm_err TO ladhoc;
GRANT ALL ON TABLE hu0d01tm_err TO lolap;
GRANT ALL ON TABLE hu0d01tm_err TO loltp;


--
-- Name: hu0d02tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0d02tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0d02tm_err FROM letl;
GRANT ALL ON TABLE hu0d02tm_err TO letl;
GRANT ALL ON TABLE hu0d02tm_err TO ladhoc;
GRANT ALL ON TABLE hu0d02tm_err TO lolap;
GRANT ALL ON TABLE hu0d02tm_err TO loltp;


--
-- Name: hu0d05tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0d05tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0d05tm_err FROM letl;
GRANT ALL ON TABLE hu0d05tm_err TO letl;
GRANT ALL ON TABLE hu0d05tm_err TO ladhoc;
GRANT ALL ON TABLE hu0d05tm_err TO lolap;
GRANT ALL ON TABLE hu0d05tm_err TO loltp;


--
-- Name: hu0d88tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0d88tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0d88tm_err FROM letl;
GRANT ALL ON TABLE hu0d88tm_err TO letl;
GRANT ALL ON TABLE hu0d88tm_err TO ladhoc;
GRANT ALL ON TABLE hu0d88tm_err TO lolap;
GRANT ALL ON TABLE hu0d88tm_err TO loltp;


--
-- Name: hu0d99tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0d99tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0d99tm_err FROM letl;
GRANT ALL ON TABLE hu0d99tm_err TO letl;
GRANT ALL ON TABLE hu0d99tm_err TO ladhoc;
GRANT ALL ON TABLE hu0d99tm_err TO lolap;
GRANT ALL ON TABLE hu0d99tm_err TO loltp;


--
-- Name: hu0e0ctm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0e0ctm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0e0ctm_err FROM letl;
GRANT ALL ON TABLE hu0e0ctm_err TO letl;
GRANT ALL ON TABLE hu0e0ctm_err TO ladhoc;
GRANT ALL ON TABLE hu0e0ctm_err TO lolap;
GRANT ALL ON TABLE hu0e0ctm_err TO loltp;


--
-- Name: hu0e13tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0e13tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0e13tm_err FROM letl;
GRANT ALL ON TABLE hu0e13tm_err TO letl;
GRANT ALL ON TABLE hu0e13tm_err TO ladhoc;
GRANT ALL ON TABLE hu0e13tm_err TO lolap;
GRANT ALL ON TABLE hu0e13tm_err TO loltp;


--
-- Name: hu0e26tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0e26tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0e26tm_err FROM letl;
GRANT ALL ON TABLE hu0e26tm_err TO letl;
GRANT ALL ON TABLE hu0e26tm_err TO ladhoc;
GRANT ALL ON TABLE hu0e26tm_err TO lolap;
GRANT ALL ON TABLE hu0e26tm_err TO loltp;


--
-- Name: hu0e27tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0e27tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0e27tm_err FROM letl;
GRANT ALL ON TABLE hu0e27tm_err TO letl;
GRANT ALL ON TABLE hu0e27tm_err TO ladhoc;
GRANT ALL ON TABLE hu0e27tm_err TO lolap;
GRANT ALL ON TABLE hu0e27tm_err TO loltp;


--
-- Name: hu0e2btm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0e2btm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0e2btm_err FROM letl;
GRANT ALL ON TABLE hu0e2btm_err TO letl;
GRANT ALL ON TABLE hu0e2btm_err TO ladhoc;
GRANT ALL ON TABLE hu0e2btm_err TO lolap;
GRANT ALL ON TABLE hu0e2btm_err TO loltp;


--
-- Name: hu0e32tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0e32tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0e32tm_err FROM letl;
GRANT ALL ON TABLE hu0e32tm_err TO letl;
GRANT ALL ON TABLE hu0e32tm_err TO ladhoc;
GRANT ALL ON TABLE hu0e32tm_err TO lolap;
GRANT ALL ON TABLE hu0e32tm_err TO loltp;


--
-- Name: hu0e63tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0e63tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0e63tm_err FROM letl;
GRANT ALL ON TABLE hu0e63tm_err TO letl;
GRANT ALL ON TABLE hu0e63tm_err TO ladhoc;
GRANT ALL ON TABLE hu0e63tm_err TO lolap;
GRANT ALL ON TABLE hu0e63tm_err TO loltp;


--
-- Name: hu0e64tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0e64tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0e64tm_err FROM letl;
GRANT ALL ON TABLE hu0e64tm_err TO letl;
GRANT ALL ON TABLE hu0e64tm_err TO ladhoc;
GRANT ALL ON TABLE hu0e64tm_err TO lolap;
GRANT ALL ON TABLE hu0e64tm_err TO loltp;


--
-- Name: hu0es1tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0es1tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0es1tm_err FROM letl;
GRANT ALL ON TABLE hu0es1tm_err TO letl;
GRANT ALL ON TABLE hu0es1tm_err TO ladhoc;
GRANT ALL ON TABLE hu0es1tm_err TO lolap;
GRANT ALL ON TABLE hu0es1tm_err TO loltp;


--
-- Name: hu0raatf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu0raatf_err FROM PUBLIC;
REVOKE ALL ON TABLE hu0raatf_err FROM letl;
GRANT ALL ON TABLE hu0raatf_err TO letl;
GRANT ALL ON TABLE hu0raatf_err TO ladhoc;
GRANT ALL ON TABLE hu0raatf_err TO lolap;
GRANT ALL ON TABLE hu0raatf_err TO loltp;


--
-- Name: hu3r5ttm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu3r5ttm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu3r5ttm_err FROM letl;
GRANT ALL ON TABLE hu3r5ttm_err TO letl;
GRANT ALL ON TABLE hu3r5ttm_err TO ladhoc;
GRANT ALL ON TABLE hu3r5ttm_err TO lolap;
GRANT ALL ON TABLE hu3r5ttm_err TO loltp;


--
-- Name: hu8d88tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu8d88tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu8d88tm_err FROM letl;
GRANT ALL ON TABLE hu8d88tm_err TO letl;
GRANT ALL ON TABLE hu8d88tm_err TO ladhoc;
GRANT ALL ON TABLE hu8d88tm_err TO lolap;
GRANT ALL ON TABLE hu8d88tm_err TO loltp;


--
-- Name: hu9e68tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hu9e68tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hu9e68tm_err FROM letl;
GRANT ALL ON TABLE hu9e68tm_err TO letl;
GRANT ALL ON TABLE hu9e68tm_err TO ladhoc;
GRANT ALL ON TABLE hu9e68tm_err TO lolap;
GRANT ALL ON TABLE hu9e68tm_err TO loltp;


--
-- Name: hud206tc_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hud206tc_err FROM PUBLIC;
REVOKE ALL ON TABLE hud206tc_err FROM letl;
GRANT ALL ON TABLE hud206tc_err TO letl;
GRANT ALL ON TABLE hud206tc_err TO ladhoc;
GRANT ALL ON TABLE hud206tc_err TO lolap;
GRANT ALL ON TABLE hud206tc_err TO loltp;


--
-- Name: hud207tc_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hud207tc_err FROM PUBLIC;
REVOKE ALL ON TABLE hud207tc_err FROM letl;
GRANT ALL ON TABLE hud207tc_err TO letl;
GRANT ALL ON TABLE hud207tc_err TO ladhoc;
GRANT ALL ON TABLE hud207tc_err TO lolap;
GRANT ALL ON TABLE hud207tc_err TO loltp;


--
-- Name: hud501tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hud501tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hud501tm_err FROM letl;
GRANT ALL ON TABLE hud501tm_err TO letl;
GRANT ALL ON TABLE hud501tm_err TO ladhoc;
GRANT ALL ON TABLE hud501tm_err TO lolap;
GRANT ALL ON TABLE hud501tm_err TO loltp;


--
-- Name: hud504tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hud504tf_err FROM PUBLIC;
REVOKE ALL ON TABLE hud504tf_err FROM letl;
GRANT ALL ON TABLE hud504tf_err TO letl;
GRANT ALL ON TABLE hud504tf_err TO ladhoc;
GRANT ALL ON TABLE hud504tf_err TO lolap;
GRANT ALL ON TABLE hud504tf_err TO loltp;


--
-- Name: hud511tc_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hud511tc_err FROM PUBLIC;
REVOKE ALL ON TABLE hud511tc_err FROM letl;
GRANT ALL ON TABLE hud511tc_err TO letl;
GRANT ALL ON TABLE hud511tc_err TO ladhoc;
GRANT ALL ON TABLE hud511tc_err TO lolap;
GRANT ALL ON TABLE hud511tc_err TO loltp;


--
-- Name: hud513tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hud513tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hud513tm_err FROM letl;
GRANT ALL ON TABLE hud513tm_err TO letl;
GRANT ALL ON TABLE hud513tm_err TO ladhoc;
GRANT ALL ON TABLE hud513tm_err TO lolap;
GRANT ALL ON TABLE hud513tm_err TO loltp;


--
-- Name: hud514tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hud514tf_err FROM PUBLIC;
REVOKE ALL ON TABLE hud514tf_err FROM letl;
GRANT ALL ON TABLE hud514tf_err TO letl;
GRANT ALL ON TABLE hud514tf_err TO ladhoc;
GRANT ALL ON TABLE hud514tf_err TO lolap;
GRANT ALL ON TABLE hud514tf_err TO loltp;


--
-- Name: hud520tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hud520tf_err FROM PUBLIC;
REVOKE ALL ON TABLE hud520tf_err FROM letl;
GRANT ALL ON TABLE hud520tf_err TO letl;
GRANT ALL ON TABLE hud520tf_err TO ladhoc;
GRANT ALL ON TABLE hud520tf_err TO lolap;
GRANT ALL ON TABLE hud520tf_err TO loltp;


--
-- Name: hud591tc_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hud591tc_err FROM PUBLIC;
REVOKE ALL ON TABLE hud591tc_err FROM letl;
GRANT ALL ON TABLE hud591tc_err TO letl;
GRANT ALL ON TABLE hud591tc_err TO ladhoc;
GRANT ALL ON TABLE hud591tc_err TO lolap;
GRANT ALL ON TABLE hud591tc_err TO loltp;


--
-- Name: hud593tc_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hud593tc_err FROM PUBLIC;
REVOKE ALL ON TABLE hud593tc_err FROM letl;
GRANT ALL ON TABLE hud593tc_err TO letl;
GRANT ALL ON TABLE hud593tc_err TO ladhoc;
GRANT ALL ON TABLE hud593tc_err TO lolap;
GRANT ALL ON TABLE hud593tc_err TO loltp;


--
-- Name: hud594tc_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hud594tc_err FROM PUBLIC;
REVOKE ALL ON TABLE hud594tc_err FROM letl;
GRANT ALL ON TABLE hud594tc_err TO letl;
GRANT ALL ON TABLE hud594tc_err TO ladhoc;
GRANT ALL ON TABLE hud594tc_err TO lolap;
GRANT ALL ON TABLE hud594tc_err TO loltp;


--
-- Name: hue017tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hue017tf_err FROM PUBLIC;
REVOKE ALL ON TABLE hue017tf_err FROM letl;
GRANT ALL ON TABLE hue017tf_err TO letl;
GRANT ALL ON TABLE hue017tf_err TO ladhoc;
GRANT ALL ON TABLE hue017tf_err TO lolap;
GRANT ALL ON TABLE hue017tf_err TO loltp;


--
-- Name: huf40dtm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE huf40dtm_err FROM PUBLIC;
REVOKE ALL ON TABLE huf40dtm_err FROM letl;
GRANT ALL ON TABLE huf40dtm_err TO letl;
GRANT ALL ON TABLE huf40dtm_err TO ladhoc;
GRANT ALL ON TABLE huf40dtm_err TO lolap;
GRANT ALL ON TABLE huf40dtm_err TO loltp;


--
-- Name: huf410tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE huf410tm_err FROM PUBLIC;
REVOKE ALL ON TABLE huf410tm_err FROM letl;
GRANT ALL ON TABLE huf410tm_err TO letl;
GRANT ALL ON TABLE huf410tm_err TO ladhoc;
GRANT ALL ON TABLE huf410tm_err TO lolap;
GRANT ALL ON TABLE huf410tm_err TO loltp;


--
-- Name: huf415tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE huf415tf_err FROM PUBLIC;
REVOKE ALL ON TABLE huf415tf_err FROM letl;
GRANT ALL ON TABLE huf415tf_err TO letl;
GRANT ALL ON TABLE huf415tf_err TO ladhoc;
GRANT ALL ON TABLE huf415tf_err TO lolap;
GRANT ALL ON TABLE huf415tf_err TO loltp;


--
-- Name: huf419tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE huf419tf_err FROM PUBLIC;
REVOKE ALL ON TABLE huf419tf_err FROM letl;
GRANT ALL ON TABLE huf419tf_err TO letl;
GRANT ALL ON TABLE huf419tf_err TO ladhoc;
GRANT ALL ON TABLE huf419tf_err TO lolap;
GRANT ALL ON TABLE huf419tf_err TO loltp;


--
-- Name: huf41atf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE huf41atf_err FROM PUBLIC;
REVOKE ALL ON TABLE huf41atf_err FROM letl;
GRANT ALL ON TABLE huf41atf_err TO letl;
GRANT ALL ON TABLE huf41atf_err TO ladhoc;
GRANT ALL ON TABLE huf41atf_err TO lolap;
GRANT ALL ON TABLE huf41atf_err TO loltp;


--
-- Name: huf41btf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE huf41btf_err FROM PUBLIC;
REVOKE ALL ON TABLE huf41btf_err FROM letl;
GRANT ALL ON TABLE huf41btf_err TO letl;
GRANT ALL ON TABLE huf41btf_err TO ladhoc;
GRANT ALL ON TABLE huf41btf_err TO lolap;
GRANT ALL ON TABLE huf41btf_err TO loltp;


--
-- Name: hum008tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum008tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum008tm_err FROM letl;
GRANT ALL ON TABLE hum008tm_err TO letl;
GRANT ALL ON TABLE hum008tm_err TO ladhoc;
GRANT ALL ON TABLE hum008tm_err TO lolap;
GRANT ALL ON TABLE hum008tm_err TO loltp;


--
-- Name: hum201tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum201tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum201tm_err FROM letl;
GRANT ALL ON TABLE hum201tm_err TO letl;
GRANT ALL ON TABLE hum201tm_err TO ladhoc;
GRANT ALL ON TABLE hum201tm_err TO lolap;
GRANT ALL ON TABLE hum201tm_err TO loltp;


--
-- Name: hum202tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum202tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum202tm_err FROM letl;
GRANT ALL ON TABLE hum202tm_err TO letl;
GRANT ALL ON TABLE hum202tm_err TO ladhoc;
GRANT ALL ON TABLE hum202tm_err TO lolap;
GRANT ALL ON TABLE hum202tm_err TO loltp;


--
-- Name: hum203tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum203tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum203tm_err FROM letl;
GRANT ALL ON TABLE hum203tm_err TO letl;
GRANT ALL ON TABLE hum203tm_err TO ladhoc;
GRANT ALL ON TABLE hum203tm_err TO lolap;
GRANT ALL ON TABLE hum203tm_err TO loltp;


--
-- Name: hum204tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum204tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum204tm_err FROM letl;
GRANT ALL ON TABLE hum204tm_err TO letl;
GRANT ALL ON TABLE hum204tm_err TO ladhoc;
GRANT ALL ON TABLE hum204tm_err TO lolap;
GRANT ALL ON TABLE hum204tm_err TO loltp;


--
-- Name: hum210tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum210tf_err FROM PUBLIC;
REVOKE ALL ON TABLE hum210tf_err FROM letl;
GRANT ALL ON TABLE hum210tf_err TO letl;
GRANT ALL ON TABLE hum210tf_err TO ladhoc;
GRANT ALL ON TABLE hum210tf_err TO lolap;
GRANT ALL ON TABLE hum210tf_err TO loltp;


--
-- Name: hum211tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum211tf_err FROM PUBLIC;
REVOKE ALL ON TABLE hum211tf_err FROM letl;
GRANT ALL ON TABLE hum211tf_err TO letl;
GRANT ALL ON TABLE hum211tf_err TO ladhoc;
GRANT ALL ON TABLE hum211tf_err TO lolap;
GRANT ALL ON TABLE hum211tf_err TO loltp;


--
-- Name: hum213tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum213tf_err FROM PUBLIC;
REVOKE ALL ON TABLE hum213tf_err FROM letl;
GRANT ALL ON TABLE hum213tf_err TO letl;
GRANT ALL ON TABLE hum213tf_err TO ladhoc;
GRANT ALL ON TABLE hum213tf_err TO lolap;
GRANT ALL ON TABLE hum213tf_err TO loltp;


--
-- Name: hum218tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum218tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum218tm_err FROM letl;
GRANT ALL ON TABLE hum218tm_err TO letl;
GRANT ALL ON TABLE hum218tm_err TO ladhoc;
GRANT ALL ON TABLE hum218tm_err TO lolap;
GRANT ALL ON TABLE hum218tm_err TO loltp;


--
-- Name: hum219tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum219tf_err FROM PUBLIC;
REVOKE ALL ON TABLE hum219tf_err FROM letl;
GRANT ALL ON TABLE hum219tf_err TO letl;
GRANT ALL ON TABLE hum219tf_err TO ladhoc;
GRANT ALL ON TABLE hum219tf_err TO lolap;
GRANT ALL ON TABLE hum219tf_err TO loltp;


--
-- Name: hum401tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum401tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum401tm_err FROM letl;
GRANT ALL ON TABLE hum401tm_err TO letl;
GRANT ALL ON TABLE hum401tm_err TO ladhoc;
GRANT ALL ON TABLE hum401tm_err TO lolap;
GRANT ALL ON TABLE hum401tm_err TO loltp;


--
-- Name: hum402tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum402tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum402tm_err FROM letl;
GRANT ALL ON TABLE hum402tm_err TO letl;
GRANT ALL ON TABLE hum402tm_err TO ladhoc;
GRANT ALL ON TABLE hum402tm_err TO lolap;
GRANT ALL ON TABLE hum402tm_err TO loltp;


--
-- Name: hum403tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum403tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum403tm_err FROM letl;
GRANT ALL ON TABLE hum403tm_err TO letl;
GRANT ALL ON TABLE hum403tm_err TO ladhoc;
GRANT ALL ON TABLE hum403tm_err TO lolap;
GRANT ALL ON TABLE hum403tm_err TO loltp;


--
-- Name: hum405tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum405tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum405tm_err FROM letl;
GRANT ALL ON TABLE hum405tm_err TO letl;
GRANT ALL ON TABLE hum405tm_err TO ladhoc;
GRANT ALL ON TABLE hum405tm_err TO lolap;
GRANT ALL ON TABLE hum405tm_err TO loltp;


--
-- Name: hum493tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum493tm_err FROM PUBLIC;
REVOKE ALL ON TABLE hum493tm_err FROM letl;
GRANT ALL ON TABLE hum493tm_err TO letl;
GRANT ALL ON TABLE hum493tm_err TO ladhoc;
GRANT ALL ON TABLE hum493tm_err TO lolap;
GRANT ALL ON TABLE hum493tm_err TO loltp;


--
-- Name: hum507tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum507tf_err FROM PUBLIC;
REVOKE ALL ON TABLE hum507tf_err FROM letl;
GRANT ALL ON TABLE hum507tf_err TO letl;
GRANT ALL ON TABLE hum507tf_err TO ladhoc;
GRANT ALL ON TABLE hum507tf_err TO lolap;
GRANT ALL ON TABLE hum507tf_err TO loltp;


--
-- Name: hum508tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum508tf_err FROM PUBLIC;
REVOKE ALL ON TABLE hum508tf_err FROM letl;
GRANT ALL ON TABLE hum508tf_err TO letl;
GRANT ALL ON TABLE hum508tf_err TO ladhoc;
GRANT ALL ON TABLE hum508tf_err TO lolap;
GRANT ALL ON TABLE hum508tf_err TO loltp;


--
-- Name: hum516tf_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE hum516tf_err FROM PUBLIC;
REVOKE ALL ON TABLE hum516tf_err FROM letl;
GRANT ALL ON TABLE hum516tf_err TO letl;
GRANT ALL ON TABLE hum516tf_err TO ladhoc;
GRANT ALL ON TABLE hum516tf_err TO lolap;
GRANT ALL ON TABLE hum516tf_err TO loltp;


--
-- Name: ifgl_bsw_day_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ifgl_bsw_day_err FROM PUBLIC;
REVOKE ALL ON TABLE ifgl_bsw_day_err FROM letl;
GRANT ALL ON TABLE ifgl_bsw_day_err TO letl;
GRANT ALL ON TABLE ifgl_bsw_day_err TO ladhoc;
GRANT ALL ON TABLE ifgl_bsw_day_err TO lolap;
GRANT ALL ON TABLE ifgl_bsw_day_err TO loltp;


--
-- Name: ifgl_bsw_mon_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ifgl_bsw_mon_err FROM PUBLIC;
REVOKE ALL ON TABLE ifgl_bsw_mon_err FROM letl;
GRANT ALL ON TABLE ifgl_bsw_mon_err TO letl;
GRANT ALL ON TABLE ifgl_bsw_mon_err TO ladhoc;
GRANT ALL ON TABLE ifgl_bsw_mon_err TO lolap;
GRANT ALL ON TABLE ifgl_bsw_mon_err TO loltp;


--
-- Name: ifgl_coa_tbl_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ifgl_coa_tbl_err FROM PUBLIC;
REVOKE ALL ON TABLE ifgl_coa_tbl_err FROM letl;
GRANT ALL ON TABLE ifgl_coa_tbl_err TO letl;
GRANT ALL ON TABLE ifgl_coa_tbl_err TO ladhoc;
GRANT ALL ON TABLE ifgl_coa_tbl_err TO lolap;
GRANT ALL ON TABLE ifgl_coa_tbl_err TO loltp;


--
-- Name: ifgl_isw_day_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ifgl_isw_day_err FROM PUBLIC;
REVOKE ALL ON TABLE ifgl_isw_day_err FROM letl;
GRANT ALL ON TABLE ifgl_isw_day_err TO letl;
GRANT ALL ON TABLE ifgl_isw_day_err TO ladhoc;
GRANT ALL ON TABLE ifgl_isw_day_err TO lolap;
GRANT ALL ON TABLE ifgl_isw_day_err TO loltp;


--
-- Name: ifgl_isw_mon_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ifgl_isw_mon_err FROM PUBLIC;
REVOKE ALL ON TABLE ifgl_isw_mon_err FROM letl;
GRANT ALL ON TABLE ifgl_isw_mon_err TO letl;
GRANT ALL ON TABLE ifgl_isw_mon_err TO ladhoc;
GRANT ALL ON TABLE ifgl_isw_mon_err TO lolap;
GRANT ALL ON TABLE ifgl_isw_mon_err TO loltp;


--
-- Name: intratrace_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE intratrace_err FROM PUBLIC;
REVOKE ALL ON TABLE intratrace_err FROM letl;
GRANT ALL ON TABLE intratrace_err TO letl;
GRANT ALL ON TABLE intratrace_err TO ladhoc;
GRANT ALL ON TABLE intratrace_err TO lolap;
GRANT ALL ON TABLE intratrace_err TO loltp;


--
-- Name: lcx_hal_tot_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE lcx_hal_tot_err FROM PUBLIC;
REVOKE ALL ON TABLE lcx_hal_tot_err FROM letl;
GRANT ALL ON TABLE lcx_hal_tot_err TO letl;
GRANT ALL ON TABLE lcx_hal_tot_err TO ladhoc;
GRANT ALL ON TABLE lcx_hal_tot_err TO lolap;
GRANT ALL ON TABLE lcx_hal_tot_err TO loltp;


--
-- Name: ld030tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ld030tm_err FROM PUBLIC;
REVOKE ALL ON TABLE ld030tm_err FROM letl;
GRANT ALL ON TABLE ld030tm_err TO letl;
GRANT ALL ON TABLE ld030tm_err TO ladhoc;
GRANT ALL ON TABLE ld030tm_err TO lolap;
GRANT ALL ON TABLE ld030tm_err TO loltp;


--
-- Name: ld061tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ld061tm_err FROM PUBLIC;
REVOKE ALL ON TABLE ld061tm_err FROM letl;
GRANT ALL ON TABLE ld061tm_err TO letl;
GRANT ALL ON TABLE ld061tm_err TO ladhoc;
GRANT ALL ON TABLE ld061tm_err TO lolap;
GRANT ALL ON TABLE ld061tm_err TO loltp;


--
-- Name: ln050tm_l_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ln050tm_l_err FROM PUBLIC;
REVOKE ALL ON TABLE ln050tm_l_err FROM letl;
GRANT ALL ON TABLE ln050tm_l_err TO letl;
GRANT ALL ON TABLE ln050tm_l_err TO ladhoc;
GRANT ALL ON TABLE ln050tm_l_err TO lolap;
GRANT ALL ON TABLE ln050tm_l_err TO loltp;


--
-- Name: ln774tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ln774tm_err FROM PUBLIC;
REVOKE ALL ON TABLE ln774tm_err FROM letl;
GRANT ALL ON TABLE ln774tm_err TO letl;
GRANT ALL ON TABLE ln774tm_err TO ladhoc;
GRANT ALL ON TABLE ln774tm_err TO lolap;
GRANT ALL ON TABLE ln774tm_err TO loltp;


--
-- Name: ln840th_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ln840th_err FROM PUBLIC;
REVOKE ALL ON TABLE ln840th_err FROM letl;
GRANT ALL ON TABLE ln840th_err TO letl;
GRANT ALL ON TABLE ln840th_err TO ladhoc;
GRANT ALL ON TABLE ln840th_err TO lolap;
GRANT ALL ON TABLE ln840th_err TO loltp;


--
-- Name: ln848th_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ln848th_err FROM PUBLIC;
REVOKE ALL ON TABLE ln848th_err FROM letl;
GRANT ALL ON TABLE ln848th_err TO letl;
GRANT ALL ON TABLE ln848th_err TO ladhoc;
GRANT ALL ON TABLE ln848th_err TO lolap;
GRANT ALL ON TABLE ln848th_err TO loltp;


--
-- Name: ln850th_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ln850th_err FROM PUBLIC;
REVOKE ALL ON TABLE ln850th_err FROM letl;
GRANT ALL ON TABLE ln850th_err TO letl;
GRANT ALL ON TABLE ln850th_err TO ladhoc;
GRANT ALL ON TABLE ln850th_err TO lolap;
GRANT ALL ON TABLE ln850th_err TO loltp;


--
-- Name: ln852th_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ln852th_err FROM PUBLIC;
REVOKE ALL ON TABLE ln852th_err FROM letl;
GRANT ALL ON TABLE ln852th_err TO letl;
GRANT ALL ON TABLE ln852th_err TO ladhoc;
GRANT ALL ON TABLE ln852th_err TO lolap;
GRANT ALL ON TABLE ln852th_err TO loltp;


--
-- Name: loan_day_tbl_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE loan_day_tbl_err FROM PUBLIC;
REVOKE ALL ON TABLE loan_day_tbl_err FROM letl;
GRANT ALL ON TABLE loan_day_tbl_err TO letl;
GRANT ALL ON TABLE loan_day_tbl_err TO ladhoc;
GRANT ALL ON TABLE loan_day_tbl_err TO lolap;
GRANT ALL ON TABLE loan_day_tbl_err TO loltp;


--
-- Name: loan_mn9988_code_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE loan_mn9988_code_err FROM PUBLIC;
REVOKE ALL ON TABLE loan_mn9988_code_err FROM letl;
GRANT ALL ON TABLE loan_mn9988_code_err TO letl;
GRANT ALL ON TABLE loan_mn9988_code_err TO ladhoc;
GRANT ALL ON TABLE loan_mn9988_code_err TO lolap;
GRANT ALL ON TABLE loan_mn9988_code_err TO loltp;


--
-- Name: loan_mn9988_mst_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE loan_mn9988_mst_err FROM PUBLIC;
REVOKE ALL ON TABLE loan_mn9988_mst_err FROM letl;
GRANT ALL ON TABLE loan_mn9988_mst_err TO letl;
GRANT ALL ON TABLE loan_mn9988_mst_err TO ladhoc;
GRANT ALL ON TABLE loan_mn9988_mst_err TO lolap;
GRANT ALL ON TABLE loan_mn9988_mst_err TO loltp;


--
-- Name: loan_rt_ms_mst_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE loan_rt_ms_mst_err FROM PUBLIC;
REVOKE ALL ON TABLE loan_rt_ms_mst_err FROM letl;
GRANT ALL ON TABLE loan_rt_ms_mst_err TO letl;
GRANT ALL ON TABLE loan_rt_ms_mst_err TO ladhoc;
GRANT ALL ON TABLE loan_rt_ms_mst_err TO lolap;
GRANT ALL ON TABLE loan_rt_ms_mst_err TO loltp;


--
-- Name: misu_bis_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE misu_bis_err FROM PUBLIC;
REVOKE ALL ON TABLE misu_bis_err FROM letl;
GRANT ALL ON TABLE misu_bis_err TO letl;
GRANT ALL ON TABLE misu_bis_err TO ladhoc;
GRANT ALL ON TABLE misu_bis_err TO lolap;
GRANT ALL ON TABLE misu_bis_err TO loltp;


--
-- Name: ms_mst_cif_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE ms_mst_cif_err FROM PUBLIC;
REVOKE ALL ON TABLE ms_mst_cif_err FROM letl;
GRANT ALL ON TABLE ms_mst_cif_err TO letl;
GRANT ALL ON TABLE ms_mst_cif_err TO ladhoc;
GRANT ALL ON TABLE ms_mst_cif_err TO lolap;
GRANT ALL ON TABLE ms_mst_cif_err TO loltp;


--
-- Name: rt_ms_mst_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE rt_ms_mst_err FROM PUBLIC;
REVOKE ALL ON TABLE rt_ms_mst_err FROM letl;
GRANT ALL ON TABLE rt_ms_mst_err TO letl;
GRANT ALL ON TABLE rt_ms_mst_err TO ladhoc;
GRANT ALL ON TABLE rt_ms_mst_err TO lolap;
GRANT ALL ON TABLE rt_ms_mst_err TO loltp;


--
-- Name: sf_org_user_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE sf_org_user_err FROM PUBLIC;
REVOKE ALL ON TABLE sf_org_user_err FROM letl;
GRANT ALL ON TABLE sf_org_user_err TO letl;
GRANT ALL ON TABLE sf_org_user_err TO ladhoc;
GRANT ALL ON TABLE sf_org_user_err TO lolap;
GRANT ALL ON TABLE sf_org_user_err TO loltp;


--
-- Name: sr002tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE sr002tm_err FROM PUBLIC;
REVOKE ALL ON TABLE sr002tm_err FROM letl;
GRANT ALL ON TABLE sr002tm_err TO letl;
GRANT ALL ON TABLE sr002tm_err TO ladhoc;
GRANT ALL ON TABLE sr002tm_err TO lolap;
GRANT ALL ON TABLE sr002tm_err TO loltp;


--
-- Name: sr010tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE sr010tm_err FROM PUBLIC;
REVOKE ALL ON TABLE sr010tm_err FROM letl;
GRANT ALL ON TABLE sr010tm_err TO letl;
GRANT ALL ON TABLE sr010tm_err TO ladhoc;
GRANT ALL ON TABLE sr010tm_err TO lolap;
GRANT ALL ON TABLE sr010tm_err TO loltp;


--
-- Name: sr_prc_req_inf_sql_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE sr_prc_req_inf_sql_err FROM PUBLIC;
REVOKE ALL ON TABLE sr_prc_req_inf_sql_err FROM letl;
GRANT ALL ON TABLE sr_prc_req_inf_sql_err TO letl;
GRANT ALL ON TABLE sr_prc_req_inf_sql_err TO ladhoc;
GRANT ALL ON TABLE sr_prc_req_inf_sql_err TO lolap;
GRANT ALL ON TABLE sr_prc_req_inf_sql_err TO loltp;


--
-- Name: temp_hum209tf_rlt_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE temp_hum209tf_rlt_err FROM PUBLIC;
REVOKE ALL ON TABLE temp_hum209tf_rlt_err FROM letl;
GRANT ALL ON TABLE temp_hum209tf_rlt_err TO letl;
GRANT ALL ON TABLE temp_hum209tf_rlt_err TO ladhoc;
GRANT ALL ON TABLE temp_hum209tf_rlt_err TO lolap;
GRANT ALL ON TABLE temp_hum209tf_rlt_err TO loltp;


--
-- Name: temp_hum215tm_rlt_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE temp_hum215tm_rlt_err FROM PUBLIC;
REVOKE ALL ON TABLE temp_hum215tm_rlt_err FROM letl;
GRANT ALL ON TABLE temp_hum215tm_rlt_err TO letl;
GRANT ALL ON TABLE temp_hum215tm_rlt_err TO ladhoc;
GRANT ALL ON TABLE temp_hum215tm_rlt_err TO lolap;
GRANT ALL ON TABLE temp_hum215tm_rlt_err TO loltp;


--
-- Name: temp_hum216tm_rlt_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE temp_hum216tm_rlt_err FROM PUBLIC;
REVOKE ALL ON TABLE temp_hum216tm_rlt_err FROM letl;
GRANT ALL ON TABLE temp_hum216tm_rlt_err TO letl;
GRANT ALL ON TABLE temp_hum216tm_rlt_err TO ladhoc;
GRANT ALL ON TABLE temp_hum216tm_rlt_err TO lolap;
GRANT ALL ON TABLE temp_hum216tm_rlt_err TO loltp;


--
-- Name: temp_hum421tf_idx_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE temp_hum421tf_idx_err FROM PUBLIC;
REVOKE ALL ON TABLE temp_hum421tf_idx_err FROM letl;
GRANT ALL ON TABLE temp_hum421tf_idx_err TO letl;
GRANT ALL ON TABLE temp_hum421tf_idx_err TO ladhoc;
GRANT ALL ON TABLE temp_hum421tf_idx_err TO lolap;
GRANT ALL ON TABLE temp_hum421tf_idx_err TO loltp;


--
-- Name: trns_ad_mst_1003_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE trns_ad_mst_1003_err FROM PUBLIC;
REVOKE ALL ON TABLE trns_ad_mst_1003_err FROM letl;
GRANT ALL ON TABLE trns_ad_mst_1003_err TO letl;
GRANT ALL ON TABLE trns_ad_mst_1003_err TO ladhoc;
GRANT ALL ON TABLE trns_ad_mst_1003_err TO lolap;
GRANT ALL ON TABLE trns_ad_mst_1003_err TO loltp;


--
-- Name: trns_ad_mst_1_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE trns_ad_mst_1_err FROM PUBLIC;
REVOKE ALL ON TABLE trns_ad_mst_1_err FROM letl;
GRANT ALL ON TABLE trns_ad_mst_1_err TO letl;
GRANT ALL ON TABLE trns_ad_mst_1_err TO ladhoc;
GRANT ALL ON TABLE trns_ad_mst_1_err TO lolap;
GRANT ALL ON TABLE trns_ad_mst_1_err TO loltp;


--
-- Name: trns_ad_mst_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE trns_ad_mst_err FROM PUBLIC;
REVOKE ALL ON TABLE trns_ad_mst_err FROM letl;
GRANT ALL ON TABLE trns_ad_mst_err TO letl;
GRANT ALL ON TABLE trns_ad_mst_err TO ladhoc;
GRANT ALL ON TABLE trns_ad_mst_err TO lolap;
GRANT ALL ON TABLE trns_ad_mst_err TO loltp;


--
-- Name: trns_fi_doc_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE trns_fi_doc_err FROM PUBLIC;
REVOKE ALL ON TABLE trns_fi_doc_err FROM letl;
GRANT ALL ON TABLE trns_fi_doc_err TO letl;
GRANT ALL ON TABLE trns_fi_doc_err TO ladhoc;
GRANT ALL ON TABLE trns_fi_doc_err TO lolap;
GRANT ALL ON TABLE trns_fi_doc_err TO loltp;


--
-- Name: trns_seobu_rst_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE trns_seobu_rst_err FROM PUBLIC;
REVOKE ALL ON TABLE trns_seobu_rst_err FROM letl;
GRANT ALL ON TABLE trns_seobu_rst_err TO letl;
GRANT ALL ON TABLE trns_seobu_rst_err TO ladhoc;
GRANT ALL ON TABLE trns_seobu_rst_err TO lolap;
GRANT ALL ON TABLE trns_seobu_rst_err TO loltp;


--
-- Name: tum60atm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE tum60atm_err FROM PUBLIC;
REVOKE ALL ON TABLE tum60atm_err FROM letl;
GRANT ALL ON TABLE tum60atm_err TO letl;
GRANT ALL ON TABLE tum60atm_err TO ladhoc;
GRANT ALL ON TABLE tum60atm_err TO lolap;
GRANT ALL ON TABLE tum60atm_err TO loltp;


--
-- Name: tum611tm_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE tum611tm_err FROM PUBLIC;
REVOKE ALL ON TABLE tum611tm_err FROM letl;
GRANT ALL ON TABLE tum611tm_err TO letl;
GRANT ALL ON TABLE tum611tm_err TO ladhoc;
GRANT ALL ON TABLE tum611tm_err TO lolap;
GRANT ALL ON TABLE tum611tm_err TO loltp;


--
-- Name: xpr_arv_mkt_cus_err; Type: ACL; Schema: sdmin_err; Owner: letl
--

REVOKE ALL ON TABLE xpr_arv_mkt_cus_err FROM PUBLIC;
REVOKE ALL ON TABLE xpr_arv_mkt_cus_err FROM letl;
GRANT ALL ON TABLE xpr_arv_mkt_cus_err TO letl;
GRANT ALL ON TABLE xpr_arv_mkt_cus_err TO ladhoc;
GRANT ALL ON TABLE xpr_arv_mkt_cus_err TO lolap;
GRANT ALL ON TABLE xpr_arv_mkt_cus_err TO loltp;


--
-- Greenplum Database database dump complete
--

