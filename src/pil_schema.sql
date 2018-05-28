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
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: gpadmin
--

COMMENT ON SCHEMA public IS 'Standard public schema';


--
-- Name: s2wlog; Type: SCHEMA; Schema: -; Owner: lr_dba
--

CREATE SCHEMA s2wlog;


ALTER SCHEMA s2wlog OWNER TO lr_dba;

--
-- Name: sn2ro; Type: SCHEMA; Schema: -; Owner: gpadmin
--

CREATE SCHEMA sn2ro;


ALTER SCHEMA sn2ro OWNER TO gpadmin;

--
-- Name: sn2ro_err; Type: SCHEMA; Schema: -; Owner: gpadmin
--

CREATE SCHEMA sn2ro_err;


ALTER SCHEMA sn2ro_err OWNER TO gpadmin;

--
-- Name: sn2ro_ext; Type: SCHEMA; Schema: -; Owner: gpadmin
--

CREATE SCHEMA sn2ro_ext;


ALTER SCHEMA sn2ro_ext OWNER TO gpadmin;

--
-- Name: webmt_sch; Type: SCHEMA; Schema: -; Owner: gpadmin
--

CREATE SCHEMA webmt_sch;


ALTER SCHEMA webmt_sch OWNER TO gpadmin;

--
-- Name: webmt_sch_err; Type: SCHEMA; Schema: -; Owner: gpadmin
--

CREATE SCHEMA webmt_sch_err;


ALTER SCHEMA webmt_sch_err OWNER TO gpadmin;

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: gpadmin
--

CREATE PROCEDURAL LANGUAGE plpgsql;
ALTER FUNCTION plpgsql_call_handler() OWNER TO lr_dba;
ALTER FUNCTION plpgsql_validator(oid) OWNER TO lr_dba;


--
-- Name: plpythonu; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: gpadmin
--

CREATE PROCEDURAL LANGUAGE plpythonu;
ALTER FUNCTION plpython_call_handler() OWNER TO gpadmin;


--
-- Name: plr; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: gpadmin
--

CREATE PROCEDURAL LANGUAGE plr;
ALTER FUNCTION plr_call_handler() OWNER TO gpadmin;


SET search_path = public, pg_catalog;

--
-- Name: tablefunc_crosstab_2; Type: TYPE; Schema: public; Owner: gpadmin
--

CREATE TYPE tablefunc_crosstab_2 AS (
	row_name text,
	category_1 text,
	category_2 text
);


ALTER TYPE public.tablefunc_crosstab_2 OWNER TO gpadmin;

--
-- Name: tablefunc_crosstab_3; Type: TYPE; Schema: public; Owner: gpadmin
--

CREATE TYPE tablefunc_crosstab_3 AS (
	row_name text,
	category_1 text,
	category_2 text,
	category_3 text
);


ALTER TYPE public.tablefunc_crosstab_3 OWNER TO gpadmin;

--
-- Name: tablefunc_crosstab_4; Type: TYPE; Schema: public; Owner: gpadmin
--

CREATE TYPE tablefunc_crosstab_4 AS (
	row_name text,
	category_1 text,
	category_2 text,
	category_3 text,
	category_4 text
);


ALTER TYPE public.tablefunc_crosstab_4 OWNER TO gpadmin;

--
-- Name: alpine_miner_ar_predict(integer, double precision[], text[], text, text); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_ar_predict(text_attribute integer, attribute_double double precision[], attribute_text text[], positive text, ar text) RETURNS text
    AS $$
declare
	--sqlstr text := '';
	i int := 0;
	result text := null;
	result_array text[];
	premise_conclusion_array text[];
	premise_array text[];
	conclusion_array text[];
	ar_array text[];
	--arribute_length integer := 0;
	conclusion_ok integer := 1;
	premise_str text;
	conclusion_str text;
	result_array_count integer := 1;
BEGIN
		if ar = '' or ar is null then
			return null;
		end if;
		ar_array := alpine_miner_split(ar, ';');
		for i in 1..alpine_miner_get_array_count(ar_array) loop
			premise_conclusion_array := alpine_miner_split(ar_array[i], ':');
			premise_str := premise_conclusion_array[1];
			premise_array := alpine_miner_split(premise_str, '|');
			conclusion_str := premise_conclusion_array[2];
			conclusion_array := alpine_miner_split(conclusion_str, '|');
			conclusion_ok := 1;
				if(text_attribute = 1) then
					if attribute_text[TO_NUMBER(conclusion_array[2],'99999999999999999999')] = positive then
						continue;
					end if;
				else
					if attribute_double[TO_NUMBER(conclusion_array[2],'99999999999999999999')] = positive then
						continue;
					end if;
				end if;

			for j in 1.. alpine_miner_get_array_count(premise_array) loop
				if(text_attribute = 1) then
					if attribute_text[TO_NUMBER(premise_array[j],'99999999999999999999')] !=  positive then
						conclusion_ok := 0;
						exit;
					end if;
				else
					if attribute_double[TO_NUMBER(premise_array[j],'99999999999999999999')] !=  positive then
						conclusion_ok := 0;
						exit;
					end if;
				end if;
			end loop;
			if conclusion_ok = 1 then
				if result_array is null or alpine_miner_contains(result_array, conclusion_array[1])  = 0 then
					result_array[result_array_count] := conclusion_array[1];
					result_array_count := result_array_count + 1;
					if result is not null then
						result := result||',';
					else
						result := '';
					end if;
					result := result || conclusion_array[1];
				end if;
			end if;
		end loop;
	RETURN result;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.alpine_miner_ar_predict(text_attribute integer, attribute_double double precision[], attribute_text text[], positive text, ar text) OWNER TO gpadmin;

--
-- Name: alpine_miner_contains(text[], text); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_contains(myarray text[], element text) RETURNS integer
    AS $$
begin
	for i in 1..alpine_miner_get_array_count(myarray) loop
		if myarray[i] = element then
			return 1;
		end if;
	end loop;
	return 0;
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.alpine_miner_contains(myarray text[], element text) OWNER TO gpadmin;

--
-- Name: alpine_miner_generate_random_table(text, bigint); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_generate_random_table(t text, rowcount bigint) RETURNS integer
    AS $$
DECLARE 
	--rand bigint;
	--rand double precision;
	count bigint := 1;
BEGIN
	WHILE count <= rowCount LOOP
		--select trunc(random()*rowCount) into rand;
		--select random() into rand;
		execute 'insert into '||t||' select '||count||','||random();
		count := count + 1;
	END LOOP;
return 1;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.alpine_miner_generate_random_table(t text, rowcount bigint) OWNER TO gpadmin;

--
-- Name: alpine_miner_get_array_count(text[]); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_get_array_count(myarray text[]) RETURNS integer
    AS $$
declare
	array_dims_result text;
	begin_pos int := 1;
	end_pos int := 1;
	temp_str text;
begin
	select array_dims(myarray) into array_dims_result;
	begin_pos := alpine_miner_instr(array_dims_result, ':')+1;
	end_pos := alpine_miner_instr(array_dims_result, ']') ;
	temp_str := substring(array_dims_result from begin_pos for (end_pos - begin_pos));
	return to_number(temp_str,'99999999999999999999');
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.alpine_miner_get_array_count(myarray text[]) OWNER TO gpadmin;

--
-- Name: alpine_miner_getdistribution(text, text); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_getdistribution(tablename text, schemaname text) RETURNS smallint[]
    AS $$

DECLARE
	 result smallint[];
BEGIN
execute 'select attrnums from gp_distribution_policy where localoid in (select relid from pg_stat_user_tables where relname='''||tablename||''' and schemaname like '''||schemaname||''')' into result;


RETURN result;
 
END;
$$
    LANGUAGE plpgsql IMMUTABLE;


ALTER FUNCTION public.alpine_miner_getdistribution(tablename text, schemaname text) OWNER TO gpadmin;

--
-- Name: alpine_miner_instr(character varying, character varying); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_instr(character varying, character varying) RETURNS integer
    AS $_$
DECLARE
    pos integer;
BEGIN
    pos:= alpine_miner_instr($1, $2, 1);
    RETURN pos;
END;
$_$
    LANGUAGE plpgsql;


ALTER FUNCTION public.alpine_miner_instr(character varying, character varying) OWNER TO gpadmin;

--
-- Name: alpine_miner_instr(character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_instr(string character varying, string_to_search character varying, beg_index integer) RETURNS integer
    AS $$
DECLARE
    pos integer DEFAULT 0;
    temp_str varchar;
    beg integer;
    length integer;
    ss_length integer;
BEGIN
    IF beg_index > 0 THEN
        temp_str := substring(string FROM beg_index);
        pos := position(string_to_search IN temp_str);

        IF pos = 0 THEN
            RETURN 0;
        ELSE
            RETURN pos + beg_index - 1;
        END IF;
    ELSE
        ss_length := char_length(string_to_search);
        length := char_length(string);
        beg := length + beg_index - ss_length + 2;

        WHILE beg > 0 LOOP
            temp_str := substring(string FROM beg FOR ss_length);
            pos := position(string_to_search IN temp_str);

            IF pos > 0 THEN
                RETURN beg;
            END IF;

            beg := beg - 1;
        END LOOP;

        RETURN 0;
    END IF;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.alpine_miner_instr(string character varying, string_to_search character varying, beg_index integer) OWNER TO gpadmin;

--
-- Name: alpine_miner_kmeans_c_1_5(text, text, text[], integer, text, text, text, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_kmeans_c_1_5(table_name text, table_name_withoutschema text, column_name text[], column_number integer, id text, tempid text, clustername text, k integer, max_run integer, max_iter integer, distance integer) RETURNS double precision[]
    AS $$
DECLARE
    run integer:=1;
    none_stable integer;
    tmp_res_1 varchar(50);
    tmp_res_2 varchar(50);
    tmp_res_3 varchar(50);
    tmp_res_4 varchar(50);
    result1 varchar(50);
    column_array text;
    avg_array text;
    power_array text;
    d_array text;
    d_array1 text;
    x_array text;
    comp_array text;
    i integer := 0;
    j integer := 0;
    sql text;
    sql1 text:='';
    temptablename text;
    column_all text;
    comp_sql text;
    result_sql text;
    sampleid integer;
    sample_id text;
    sample_array text:='';
    data_array text;
    roww record;
    sample_array1 text[];
    sample_array2 text:='';
    alpine_id text;
    resultarray float[2];
    tempsum float;
    nullflag smallint:=0;
  
BEGIN

temptablename:=table_name_withoutschema;

if id='null'
then 
sql:= 'create temp table '||temptablename||'copy as(select *,row_number() over () '||tempid||' from '||table_name||' where ';
alpine_id:=tempid;
else
sql:= 'create temp table '||temptablename||'copy as(select * from '||table_name||' where ';
alpine_id:=id;
end if;


i := 1;
while i < (column_number) loop
	sql:=sql||' "'||column_name[i]||'" is not null and ';
	i := i + 1;	
end loop;
sql:=sql||' "'||column_name[i]||'" is not null';


sql:=sql||')distributed by('||alpine_id||')';

execute sql;

column_array := column_name[1];

i := 2;
while i < (column_number + 1) loop
	column_array := column_array||',"'||column_name[i]||'"';
	i := i + 1;
end loop;

------generate random table start------

sql:='select tablek1.seq sample_id,0::smallint as stable,';
column_all:='';
i := 1;
 while i<(k + 1) loop
 j := 1;
	while j<(column_number+1) loop
		column_all:=column_all||'"k'||i||''||column_name[j]||'"::numeric(25,10),';
		j := j + 1;
		end loop;
	i := i + 1;	
 end loop;
sql:=sql||column_all||'0::integer as iter from ';
--random table's line count is variable max_run,default value is 10--
--The point in same sample is in same row
i := 1;
 while i<(k + 1) loop
sql:=sql||'(select ';
	 j := 1;
	while j<(column_number+1) loop
	  sql:=sql||'"'||column_name[j]||'" "k'||i||column_name[j]||'",';
	  j := j + 1;
	end loop;
	if i=1 then sql:=sql||' row_number() over (order by random())-1 as seq from '||temptablename||'copy limit '||max_run||') as tablek'||i||' inner join ';
	else if i=k then sql:=sql||' row_number() over (order by random())-1 as seq from '||temptablename||'copy limit '||max_run||') as tablek'||i||' on tablek'||(i-1)||'.seq=tablek'||i||'.seq'; 
	else sql:=sql||' row_number() over (order by random())-1 as seq from '||temptablename||'copy limit '||max_run||') as tablek'||i||' on tablek'||(i-1)||'.seq=tablek'||i||'.seq inner join ';end if;
	end if;
	i := i + 1;
 end loop;

i := 1;
sample_array:=sample_array||'array[';
while i<(k + 1) loop
	 j := 1;
	while j<(column_number+1) loop
	if i=k and j=column_number then
	 sample_array:=sample_array||'"k'||i||column_name[j]||'"]';
	 else
	  sample_array:=sample_array||'"k'||i||column_name[j]||'",';
	  end if;
	  j := j + 1;
	end loop;
	i := i + 1;
 end loop;

sql:='create temp table '||temptablename||'_random_new as ('||sql||') distributed by (sample_id)';

execute sql;

---------generate random table end-------------

---------Adjust stable start--------------
while run<max_iter  loop
tmp_res_1:='tmp_res_1'||run::varchar;
tmp_res_2:='tmp_res_2'||run::varchar;
tmp_res_3:='tmp_res_3'||run::varchar;
tmp_res_4:='tmp_res_4'||run::varchar;
i := 2;
avg_array :=  'avg("'||column_name[1]||'")::numeric(25,10) "'||column_name[1]||'"';
while i < (column_number + 1) loop
        avg_array := avg_array||',avg("'||column_name[i]||'")::numeric(25,10) "'||column_name[i]||'"';
	i := i + 1;
end loop;

------------------

data_array:='array[';
i:=1;
while i<column_number loop
data_array:=data_array||'"'||column_name[i]||'",';
i:=i+1;
end loop;
data_array:=data_array||'"'||column_name[i]||'"]';



--------------
sql:='create temp table '||temptablename||tmp_res_2||' (sample_id integer,'||alpine_id||' character varying,cluster_id integer) distributed by ('||alpine_id||')';
execute sql;
i:=1;
sql:='select sample_id::smallint,'||sample_array||'::float[] from '||temptablename||'_random_new where stable=0 order by sample_id';
-- raise notice 'sql:%',sql;
     for roww in execute sql loop
	 sample_array1=roww.array;
	 sampleid=roww.sample_id;
	 sample_array2:='';
	j:=1;
	while j<column_number*k loop
	sample_array2:=sample_array2||sample_array1[j]||',';
	j:=j+1;
	end loop;
	sample_array2:=sample_array2||sample_array1[j];
	sample_array2:='array['||sample_array2||']';
	sql1:='insert into '||temptablename||tmp_res_2||' select '||sampleid||'::smallint,'||alpine_id||',alpine_miner_kmeans_distance_loop('||sample_array2;
	sql1:=sql1||'::float[],'||data_array||'::float[],'||k||','||distance||')as cluster_id from '||temptablename||'copy ';
	  --raise notice 'sqll:%',sql1;
	 execute sql1;
	 i:=i+1;
     end loop;

-----tmp_res_1 caculate unstable cluster---
sql:='drop table if exists '||temptablename||tmp_res_1||'; create temp table '||temptablename||tmp_res_1||'   as
(
select 
	sample_id,
 	cluster_id,
	'||avg_array||'
from '||temptablename||tmp_res_2||'
x,'||temptablename||'copy y
where x.'||alpine_id||'=y.'||alpine_id||'
 group by 1,2
)distributed by(sample_id,cluster_id)
 ;
 ';

execute sql;
 
--raise info '------------1--------------'; 

------------
comp_sql:='(case when ';
i:=1;
while i<(k + 1) loop
j:=1;
  while j<column_number+1 loop
  if i=k and j=column_number then comp_sql:=comp_sql||'x."k'||i||column_name[j]||'"=y."k'||i||column_name[j]||'"';
	else comp_sql:=comp_sql||'x."k'||i||column_name[j]||'"=y."k'||i||column_name[j]||'" and ';
	end if;
	j:=j+1;
  end loop;
  i:=i+1;
end loop;
comp_sql:=comp_sql||' then 1 else 0 end )as stable';

-----------

----------------
sql:='select tablek1.sample_id,0::smallint as stable,';
column_all:='';
i := 1;
 while i<(k + 1) loop
 j := 1;
	while j<(column_number+1) loop
		column_all:=column_all||'"k'||i||column_name[j]||'",';
		j := j + 1;
		end loop;
	i := i + 1;	
 end loop;
sql:=sql||column_all||'0::integer as iter from ';


i := 1;
 while i<(k + 1) loop
sql:=sql||'(select ';
	 j := 1;
	while j<(column_number+1) loop
	  sql:=sql||'"'||column_name[j]||'" "k'||i||column_name[j]||'",';
	  j := j + 1;
	end loop;
	if i=1 then sql:=sql||' sample_id from '||temptablename||tmp_res_1||' where cluster_id='||(i-1)||') as tablek'||i||' inner join ';
	else if i=k then sql:=sql||' sample_id from '||temptablename||tmp_res_1||' where cluster_id='||(i-1)||') as tablek'||i||' on tablek'||(i-1)||'.sample_id=tablek'||i||'.sample_id'; 
	else sql:=sql||' sample_id from '||temptablename||tmp_res_1||' where cluster_id='||(i-1)||') as tablek'||i||' on tablek'||(i-1)||'.sample_id=tablek'||i||'.sample_id inner join ';end if;
	end if;
	i := i + 1;
 end loop;

--------tmp_res_4 transform the point in same sample to same line.----
 sql:='drop table if exists '||temptablename||tmp_res_4||';create temp table '||temptablename||tmp_res_4||' as ('||sql||') distributed by (sample_id)';
execute sql;

x_array:='';
i := 1;
 while i<(k + 1) loop
 j:=1;
	while j<(column_number+1) loop
	x_array:=x_array||'x."k'||i||column_name[j]||'",';
	  j := j + 1;
	end loop;
	i := i + 1;
 end loop;
 raise notice 'x_array:%',x_array;
 --------tmp_res_3 judge which sample is stable----
sql:='drop table if exists '||temptablename||tmp_res_3||';create temp table '||temptablename||tmp_res_3||' as
(
	select 
		x.sample_id,
	 	'||comp_sql||','||x_array
	 	||run||' as iter
	from  '||temptablename||tmp_res_4||' x, '||temptablename||'_random_new  y
	where x.sample_id=y.sample_id

)
distributed by(sample_id)
;
';
----------------

execute sql;


sql:='insert into '||temptablename||tmp_res_3||' (select a.* from '||temptablename||'_random_new a left join '||temptablename||tmp_res_3||' as b on a.sample_id=b.sample_id';
sql:=sql||' where b.sample_id is null);';

sql:=sql||'drop table if exists '||temptablename||'_random_new;';
sql:=sql||'alter table '||temptablename||tmp_res_3||' rename to '||temptablename||'_random_new;';
execute sql;



execute 'select count(*)  from  '||temptablename||'_random_new where stable=0;' into none_stable;--into '||none_stable||'


raise notice '-------------------none_stable:%',none_stable;

if none_stable=0
then
	exit;
end if;

run := run+1;

end loop;
---------Adjust stable end--------------

sql:='select array[sample_id,len]
from
(
	select sample_id,len,row_number() over(order by len) as seq 
	from
	(
		select sample_id,avg(len) as len
		from
		(
		select sample_id,alpine_miner_kmeans_distance_result('||sample_array||'::float[],'||data_array||'::float[],'||k||','||distance||') as len
			from '||temptablename||'copy x inner join '||temptablename||'_random_new y on y.stable=1
			)a
		 	group by 1
		)b
)z
where seq=1';

raise notice '-------------------sql:%',sql;
execute sql into resultarray;
sampleid:=resultarray[1];

if sampleid is null then 
sampleid:=0;
nullflag:=1;
 end if;

--------deal result---------------- in (select sample_id from '||temptablename||'tmp_res_4) 
result1:='result1';
execute 'drop table if exists '||temptablename||result1;

execute 'create temp table '||temptablename||result1||' as 
(
	select * from  '||temptablename||'_random_new  where sample_id ='||sampleid||'
)distributed by(sample_id);'
;

if nullflag=1 then
sql:='select len
from
(
	select sample_id,len,row_number() over(order by len) as seq 
	from
	(
		select sample_id,avg(len) as len
		from
		(
		select sample_id,alpine_miner_kmeans_distance_result('||sample_array||'::float[],'||data_array||'::float[],'||k||','||distance||') as len
			from '||temptablename||'copy x inner join '||temptablename||result1||' y on y.stable=0
			)a
		 	group by 1
		)b
)z
where seq=1';
execute sql into tempsum;
raise notice '-------------------tempsum:%',tempsum;
resultarray[2]:=tempsum;
end if;


execute 'drop table if exists '||temptablename||'result2; create temp table '||temptablename||'result2 as select *,0::integer '||temptablename||'copy_flag from '||temptablename||'copy  distributed randomly;';





sql:='
	drop table if exists '||temptablename||'table_name_temp;create temp table '||temptablename||'table_name_temp as
		(
		select '||alpine_id||' as temp_id,alpine_miner_kmeans_distance_loop('||sample_array||'::float[],'||data_array||'::float[],'||k||','||distance||') as '||clustername||' 
		from '||temptablename||'result2 x inner join '||temptablename||result1||' y on x.'||temptablename||'copy_flag=0

		)  distributed randomly ;';

execute sql;

resultarray[1]:=run;


RETURN resultarray;
 
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.alpine_miner_kmeans_c_1_5(table_name text, table_name_withoutschema text, column_name text[], column_number integer, id text, tempid text, clustername text, k integer, max_run integer, max_iter integer, distance integer) OWNER TO gpadmin;

--
-- Name: alpine_miner_kmeans_c_array_1_5(text, text, text[], integer, text, text, text, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_kmeans_c_array_1_5(table_name text, table_name_withoutschema text, column_name text[], column_number integer, id text, tempid text, clustername text, k integer, max_run integer, max_iter integer, distance integer) RETURNS double precision[]
    AS $$
DECLARE
    run integer:=1;
    none_stable integer;
    tmp_res_1 varchar(50);
    tmp_res_2 varchar(50);
    tmp_res_3 varchar(50);
    tmp_res_4 varchar(50);
    result1 varchar(50);
    column_array text;
    avg_array text;
    x_array text;
    i integer := 0;
    j integer := 0;
    sql text;
    sql1 text:='';
    temptablename text;
    column_all text;
    comp_sql text;
    result_sql text;
    sampleid integer;
    sample_array text:='';
    data_array text;
    roww record;
    init_array text;
    init_array1 text;
    sample_array3 text[];
    sample_array1 text:='';
    sample_array2 text:='';
    column_new text:='';
     xx_array text;
     comp_sql_new text;
     alpine_id text;
     resultarray float[2];
    tempsum float;
    nullflag smallint:=0;
  
BEGIN

temptablename:=table_name_withoutschema;

if id='null'
then 
sql:= 'create temp table '||temptablename||'copy as(select *,row_number() over () '||tempid||' from '||table_name||' where ';
alpine_id:=tempid;
else
sql:= 'create temp table '||temptablename||'copy as(select * from '||table_name||' where ';
alpine_id:=id;
end if;

i := 1;
while i < (column_number) loop
	sql:=sql||' "'||column_name[i]||'" is not null and ';
	i := i + 1;	
end loop;
sql:=sql||' "'||column_name[i]||'" is not null';


sql:=sql||')distributed by('||alpine_id||')';

raise notice '----create copy sql:%',sql;
execute sql;

column_array := column_name[1];

i := 2;
while i < (column_number + 1) loop
	column_array := column_array||',"'||column_name[i]||'"';
	i := i + 1;
end loop;


-------------------------------
sql:='create temp table '||temptablename||'init as select tablek1.seq sample_id,0::smallint as stable,';
i := 1;
while i<(k + 1) loop
	sql:=sql||'k'||i||',';
	i := i + 1;
	end loop;
	sql:=sql||'0::integer as iter from';
i := 1;
 while i<(k + 1) loop
sql:=sql||'(select array[';
	 j := 1;
	while j<(column_number) loop
	  sql:=sql||'"'||column_name[j]||'",';
	  j := j + 1;
	end loop;
	sql:=sql||'"'||column_name[j]||'"] k'||i||',';
	if i=1 then sql:=sql||' row_number() over (order by random())-1 as seq from '||temptablename||'copy limit '||max_run||') as tablek'||i||' inner join ';
	else if i=k then sql:=sql||' row_number() over (order by random())-1 as seq from '||temptablename||'copy limit '||max_run||') as tablek'||i||' on tablek'||(i-1)||'.seq=tablek'||i||'.seq'; 
	else sql:=sql||' row_number() over (order by random())-1 as seq from '||temptablename||'copy limit '||max_run||') as tablek'||i||' on tablek'||(i-1)||'.seq=tablek'||i||'.seq inner join ';end if;
	end if;
	i := i + 1;
 end loop;
sql:=sql||'  distributed by (sample_id) ';
raise notice '----sql sql:%',sql;
execute sql;

sql:='create temp table '||temptablename||'_random_new as select sample_id,stable,';
i := 1;
while i<column_number+1 loop
	sql:=sql||'array[';
	j:=1;
	while j<k loop
	sql:=sql||'k'||j||'['||i||'],';
	j := j + 1;
	end loop;
	sql:=sql||'k'||j||'['||i||']]::float[] "'||column_name[i]||'",';
	i := i + 1;
	end loop;
	sql:=sql||' iter from '||temptablename||'init distributed by (sample_id)';
raise notice '----create random sql:%',sql;
execute sql;
-------------------------------
------generate random table start------

i := 1;
sample_array1:=sample_array1||'array[';
while i<(k + 1) loop
	 j := 1;
	while j<(column_number+1) loop
	if i=k and j=column_number then
	 sample_array1:=sample_array1||'y."'||column_name[j]||'"['||i||']]::float[]';
	 else
	 sample_array1:=sample_array1||'y."'||column_name[j]||'"['||i||'],';
	  end if;
	  j := j + 1;
	end loop;
	i := i + 1;
 end loop;
 
raise notice '----sample_array1 sql:%',sample_array1;
---------generate random table end-------------

---------Adjust stable start--------------
while run<max_iter  loop
tmp_res_1:='tmp_res_1'||run::varchar;
tmp_res_2:='tmp_res_2'||run::varchar;
tmp_res_3:='tmp_res_3'||run::varchar;
tmp_res_4:='tmp_res_4'||run::varchar;
i := 2;
avg_array :=  'avg("'||column_name[1]||'")::numeric(25,10) "'||column_name[1]||'"';
while i < (column_number + 1) loop
        avg_array := avg_array||',avg("'||column_name[i]||'")::numeric(25,10) "'||column_name[i]||'"';
	i := i + 1;
end loop;


------------------

data_array:='array[';
i:=1;
while i<column_number loop
data_array:=data_array||'x."'||column_name[i]||'",';
i:=i+1;
end loop;
data_array:=data_array||'x."'||column_name[i]||'"]';

---------------
sql:='create temp table '||temptablename||tmp_res_2||' (sample_id integer,'||alpine_id||' character varying,cluster_id integer) distributed by ('||alpine_id||')';
execute sql;
i:=1;
sql:='select sample_id::smallint,'||sample_array1||'::float[] from '||temptablename||'_random_new y where stable=0 order by sample_id';
-- raise notice 'sql:%',sql;
     for roww in execute sql loop
	 sample_array3=roww.array;
	 sampleid=roww.sample_id;
	 sample_array2:='';
	j:=1;
	while j<column_number*k loop
	sample_array2:=sample_array2||sample_array3[j]||',';
	j:=j+1;
	end loop;
	sample_array2:=sample_array2||sample_array3[j];
	sample_array2:='array['||sample_array2||']';
	sql1:='insert into '||temptablename||tmp_res_2||' select '||sampleid||'::smallint,'||alpine_id||',alpine_miner_kmeans_distance_loop('||sample_array2;
	sql1:=sql1||'::float[],'||data_array||'::float[],'||k||','||distance||')as cluster_id from '||temptablename||'copy x';
	  --raise notice 'sqll:%',sql1;
	 execute sql1;
	 i:=i+1;
     end loop;
---------------


--------tmp_res_2 caculate each point in random table's distance to each point in date table and get each point in date table should belong to which cluster----------
/*sql:='drop table if exists '||temptablename||tmp_res_2||';create temp table '||temptablename||tmp_res_2||' as (select 
	sample_id,'||id||',alpine_miner_kmeans_distance_loop('||sample_array1||'::float[],'||data_array||'::float[],'||k||','||distance||') as cluster_id
from '||temptablename||'copy x inner join '||temptablename||'_random_new y on y.stable=0) distributed by (sample_id,'||id||',cluster_id)';

execute sql;*/


-----tmp_res_1 caculate unstable cluster---
sql:='drop table if exists '||temptablename||tmp_res_1||'; create temp table '||temptablename||tmp_res_1||'   as
(
select 
	sample_id,
 	cluster_id,
	'||avg_array||'
from '||temptablename||tmp_res_2||'
x,'||temptablename||'copy y
where x.'||alpine_id||'=y.'||alpine_id||'
 group by 1,2
)distributed by(sample_id,cluster_id)
 ;
 ';

execute sql;
 
--raise info '------------1--------------'; 


sql:='drop table if exists '||temptablename||'temp;create temp table '||temptablename||'temp as select tablek1.sample_id,0::smallint as stable,';
i := 1;
 while i<(k + 1) loop
	sql:=sql||'k'||i||',';
	i := i + 1;	
 end loop;
sql:=sql||'0::integer as iter from ';

i := 1;
 while i<(k + 1) loop
sql:=sql||'(select array[';
	 j := 1;
	while j<(column_number) loop
	  sql:=sql||'"'||column_name[j]||'",';
	  j := j + 1;
	end loop;
	sql:=sql||'"'||column_name[j]||'"] k'||i||',';
	if i=1 then sql:=sql||' sample_id from '||temptablename||tmp_res_1||' where cluster_id='||(i-1)||') as tablek'||i||' inner join ';
	else if i=k then sql:=sql||' sample_id from '||temptablename||tmp_res_1||' where cluster_id='||(i-1)||') as tablek'||i||' on tablek'||(i-1)||'.sample_id=tablek'||i||'.sample_id'; 
	else sql:=sql||' sample_id from '||temptablename||tmp_res_1||' where cluster_id='||(i-1)||') as tablek'||i||' on tablek'||(i-1)||'.sample_id=tablek'||i||'.sample_id inner join ';end if;
	end if;
	i := i + 1;
 end loop;
execute sql;

sql:='drop table if exists '||temptablename||tmp_res_4||';create temp table '||temptablename||tmp_res_4||' as select sample_id,stable,';
i := 1;
while i<column_number+1 loop
	sql:=sql||'array[';
	j:=1;
	while j<k loop
	sql:=sql||'k'||j||'['||i||'],';
	j := j + 1;
	end loop;
	sql:=sql||'k'||j||'['||i||']]::float[] "'||column_name[i]||'",';
	i := i + 1;
	end loop;
	sql:=sql||' iter from '||temptablename||'temp distributed by (sample_id)';
raise notice '----create random sql:%',sql;
execute sql;

comp_sql_new:='(case when ';
i:=1;
while i<(k + 1) loop
j:=1;
  while j<column_number+1 loop
  if i=k and j=column_number then comp_sql_new:=comp_sql_new||'x."'||column_name[j]||'"['||i||']=y."'||column_name[j]||'"['||i||']';
	else comp_sql_new:=comp_sql_new||'x."'||column_name[j]||'"['||i||']=y."'||column_name[j]||'"['||i||'] and ';
	end if;
	j:=j+1;
  end loop;
  i:=i+1;
end loop;
comp_sql_new:=comp_sql_new||' then 1 else 0 end )as stable';
raise notice '----comp_sql_new :%',comp_sql_new;
------------

xx_array:='';
i := 1;
 while i<(column_number + 1) loop
 j:=1;
	xx_array:=xx_array||'array[';
	while j<k loop
	xx_array:=xx_array||'x."'||column_name[i]||'"['||j||'],';
	  j := j + 1;
	end loop;
	xx_array:=xx_array||'x."'||column_name[i]||'"['||j||']]::float[] "'||column_name[i]||'",';
	i := i + 1;
 end loop;
 raise notice 'xx_array:%',xx_array;
 
 --------tmp_res_3 judge which sample is stable----
sql:='drop table if exists '||temptablename||tmp_res_3||';create temp table '||temptablename||tmp_res_3||' as
(
	select 
		x.sample_id,
	 	'||comp_sql_new||','||xx_array
	 	||run||' as iter
	from  '||temptablename||tmp_res_4||' x, '||temptablename||'_random_new  y
	where x.sample_id=y.sample_id

)
distributed by(sample_id)
;
';
----------------

execute sql;

sql:='insert into '||temptablename||tmp_res_3||' (select a.* from '||temptablename||'_random_new a left join '||temptablename||tmp_res_3||' as b on a.sample_id=b.sample_id';
sql:=sql||' where b.sample_id is null);';

sql:=sql||'drop table if exists '||temptablename||'temp1;create temp table '||temptablename||'temp1 as select * from '||temptablename||tmp_res_3||' distributed by (sample_id);';
sql:=sql||'drop table if exists '||temptablename||'_random_new;';
sql:=sql||'alter table '||temptablename||'temp1 rename to '||temptablename||'_random_new;';
execute sql;


execute 'select count(*)  from  '||temptablename||'_random_new where stable=0;' into none_stable;--into '||none_stable||'


raise notice '-------------------none_stable:%',none_stable;

if none_stable=0
then
	exit;
end if;

run := run+1;

end loop;
---------Adjust stable end--------------

sql:='select array[sample_id,len]
from
(
	select sample_id,len,row_number() over(order by len) as seq 
	from
	(
		select sample_id,avg(len) as len
		from
		(
		select sample_id,alpine_miner_kmeans_distance_result('||sample_array1||'::float[],'||data_array||'::float[],'||k||','||distance||') as len
			from '||temptablename||'copy x inner join '||temptablename||'_random_new y on y.stable=1
			)a
		 	group by 1
		)b
)z
where seq=1';

raise notice '----get sample sql:%',sql;

execute sql into resultarray;
sampleid:=resultarray[1];

if sampleid is null then 
sampleid:=0;
nullflag:=1;
 end if;

--------deal result---------------- in (select sample_id from '||temptablename||'tmp_res_4) 
result1:='result1';
execute 'drop table if exists '||temptablename||result1;

execute 'create temp table '||temptablename||result1||' as 
(
	select * from  '||temptablename||'_random_new  where sample_id ='||sampleid||'
)distributed by(sample_id);'
;


if nullflag=1 then
sql:='select len
from
(
	select sample_id,len,row_number() over(order by len) as seq 
	from
	(
		select sample_id,avg(len) as len
		from
		(
		select sample_id,alpine_miner_kmeans_distance_result('||sample_array1||'::float[],'||data_array||'::float[],'||k||','||distance||') as len
			from '||temptablename||'copy x inner join '||temptablename||result1||' y on y.stable=0
			)a
		 	group by 1
		)b
)z
where seq=1';
execute sql into tempsum;
raise notice '-------------------tempsum:%',tempsum;
resultarray[2]:=tempsum;
end if;

execute 'drop table if exists '||temptablename||'result2; create temp table '||temptablename||'result2 as select *,0::integer '||temptablename||'copy_flag from '||temptablename||'copy  distributed randomly;';





sql:='
	drop table if exists '||temptablename||'table_name_temp;create temp table '||temptablename||'table_name_temp as
		(
		select '||alpine_id||' as temp_id,alpine_miner_kmeans_distance_loop('||sample_array1||'::float[],'||data_array||'::float[],'||k||','||distance||') as '||clustername||' 
		from '||temptablename||'result2 x inner join '||temptablename||result1||' y on x.'||temptablename||'copy_flag=0

		)  distributed randomly ;';

execute sql;

resultarray[1]:=run;

RETURN resultarray;
 
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.alpine_miner_kmeans_c_array_1_5(table_name text, table_name_withoutschema text, column_name text[], column_number integer, id text, tempid text, clustername text, k integer, max_run integer, max_iter integer, distance integer) OWNER TO gpadmin;

--
-- Name: alpine_miner_kmeans_c_array_array(text, text, text[], integer[], integer, text, text, text, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_kmeans_c_array_array(table_name text, table_name_withoutschema text, column_name text[], column_array_length integer[], column_number integer, id text, tempid text, clustername text, k integer, max_run integer, max_iter integer, distance integer) RETURNS double precision[]
    AS $$
DECLARE
    run integer:=1;
    none_stable integer;
    tmp_res_1 varchar(50):='';
    tmp_res_2 varchar(50):='';
    tmp_res_3 varchar(50):='';
    tmp_res_4 varchar(50):='';
    result1 varchar(50):='';
    column_array text:='';
    avg_array text:='';
    x_array text:='';
    i integer := 0;
    j integer := 0;
    l integer := 0;
    m integer := 0;
    n integer := 0;
    sql text:='';
    sql1 text:='';
    temptablename text:='';
    column_all text:='';
    comp_sql text:='';
    result_sql text:='';
    sampleid integer;
    sample_array text:='';
    data_array text:='';
    roww record;
    init_array text:='';
    init_array1 text:='';
    sample_array3 text[];
    sample_array1 text:='';
    sample_array2 text:='';
    column_new text:='';
     xx_array text;
     comp_sql_new text:='';
     alpine_id text:='';
     resultarray float[2];
    tempsum float;
    nullflag smallint:=0;
    column_array_sum integer:= 0;
    column_array_index integer:= 0;
    first boolean := true;
    temp_text text := '';
    temp_index integer := 0;
  
BEGIN

i := 1;
while i <= column_number loop
	if column_array_length[i] = 0 then
		column_array_sum := column_array_sum + 1;
	else
		column_array_sum := column_array_sum + column_array_length[i];
	end if ;
	i := i+ 1;
end loop;

temptablename:=table_name_withoutschema;

if id='null'
then 
sql:= 'create temp table '||temptablename||'copy as(select *,row_number() over () '||tempid||' from '||table_name||' where ';
alpine_id:=tempid;
else
sql:= 'create temp table '||temptablename||'copy as(select * from '||table_name||' where ';
alpine_id:=id;
end if;

i := 1;
while i < (column_number) loop
	sql:=sql||' "'||column_name[i]||'" is not null and ';
	i := i + 1;	
end loop;
sql:=sql||' "'||column_name[i]||'" is not null';


sql:=sql||') distributed by('||alpine_id||')';

--raise notice '0 asdf sql:%',sql;
execute sql;

column_array := column_name[1];

i := 2;
while i < (column_number + 1) loop
	column_array := column_array||',"'||column_name[i]||'"';
	i := i + 1;
end loop;


-------------------------------
sql:='create temp table '||temptablename||'init as select tablek1.seq sample_id,0::smallint as stable,';
i := 1;
while i<(k + 1) loop
	sql:=sql||'k'||i||',';
	i := i + 1;
	end loop;
	sql:=sql||'0::integer as iter from';
i := 1;
----raise notice 'k:%, column_number:%', k, column_number;
 while i<(k + 1) loop
sql:=sql||'(select array[';
	 j := 1;
	while j<=(column_number) loop
	  --sql:=sql||'"'||column_name[j]||'",';
          if j != 1 then
             sql:=sql||',';
          end if;
          if column_array_length[j] < 1 then
	  	sql:=sql||'"'||column_name[j]||'"';
          else
                l := 1;
                while l <= column_array_length[j] loop
          		if l != 1 then
		             sql:=sql||',';
		        end if;
                    sql:=sql||'"'||column_name[j]||'"['||l||']';
                    l := l + 1;
                end loop;
          end if;
	  j := j + 1;
	end loop;
	sql:=sql||'] k'||i||',';
	if i=1 then sql:=sql||' row_number() over (order by random())-1 as seq from '||temptablename||'copy limit '||max_run||') as tablek'||i||' inner join ';
	else if i=k then sql:=sql||' row_number() over (order by random())-1 as seq from '||temptablename||'copy limit '||max_run||') as tablek'||i||' on tablek'||(i-1)||'.seq=tablek'||i||'.seq'; 
	else sql:=sql||' row_number() over (order by random())-1 as seq from '||temptablename||'copy limit '||max_run||') as tablek'||i||' on tablek'||(i-1)||'.seq=tablek'||i||'.seq inner join ';end if;
	end if;
	i := i + 1;
 end loop;
sql:=sql||'  distributed by (sample_id) ';
--raise notice '1 asdf sql:%',sql;
execute sql;

sql:='create temp table '||temptablename||'_random_new as select sample_id,stable,';
i := 1;
column_array_index := 1;
temp_index := 0;
first := true;
while i<column_number+1 loop
	sql:=sql||'array[';
	j:=1;
	first := true;
	column_array_index := temp_index + 1;
	if column_array_length[i] < 1 then
	while j<=k loop
		if first is true then
			first := false;
		else
			sql := sql||',';
		end if;
		sql:=sql||'k'||j||'['||column_array_index||']'; 
	j := j + 1;
	end loop;
	else
		l := 1;
		while l <= column_array_length[i] loop
		  j := 1;
		  while j<=k loop
			if first is true then
				first := false;
			else
				sql := sql||',';
			end if;
			sql:=sql||'k'||j||'['||column_array_index||']';
		  j := j + 1;
		  end loop;
			l := l + 1;
			column_array_index := column_array_index + 1;
		end loop;
	end if;
	if column_array_length[i] < 1 then
		temp_index := temp_index + 1;
	else
		temp_index := temp_index + column_array_length[i];
	end if;
	sql:=sql||']::float[] "'||column_name[i]||'",';
	i := i + 1;
end loop;
	sql:=sql||' iter from '||temptablename||'init distributed by (sample_id)';
--raise notice '2 asdf sql:%',sql;
execute sql;
-------------------------------
------generate random table start------

i := 1;
first := true;
sample_array1:=sample_array1||'array[';
while i<(k + 1) loop
	 j := 1;
	while j<(column_number+1) loop
--	if i=k and j=column_number then
--	 sample_array1:=sample_array1||'y."'||column_name[j]||'"['||i||']]::float[]'; 
--	 else
--	 sample_array1:=sample_array1||'y."'||column_name[j]||'"['||i||'],';
--	  end if;
	if column_array_length[j] < 1 then
		if first is true then
			first := false;
		else
			sample_array1 := sample_array1||',';
		end if;
		sample_array1:=sample_array1||'y."'||column_name[j]||'"['||i||']';--     'k'||j||'['||column_array_index||']'; 
	else
		l := 1;
		column_array_index := i;
		while l <= column_array_length[j] loop
			if first is true then
				first := false;
			else
				sample_array1 := sample_array1||',';
			end if;
			sample_array1:=sample_array1||'y."'||column_name[j]||'"['||column_array_index||']';
			l := l + 1;
			column_array_index := column_array_index + k;
		end loop;
	end if;
	if i=k and j=column_number then
		sample_array1:=sample_array1||']::float[]';
	end if;
	  j := j + 1;
	end loop;
	i := i + 1;
 end loop;
 
----raise notice '----sample_array1 sql:%',sample_array1;
---------generate random table end-------------

---------Adjust stable start--------------
while run<max_iter  loop
tmp_res_1:='tmp_res_1'||run::varchar;
tmp_res_2:='tmp_res_2'||run::varchar;
tmp_res_3:='tmp_res_3'||run::varchar;
tmp_res_4:='tmp_res_4'||run::varchar;
i := 1;
first = true;
avg_array := '';
while i < (column_number + 1) loop
	if first is true then
		first := false;
	else
		avg_array := avg_array||',';
	end if;
	if column_array_length[i] < 1 then
		avg_array := avg_array||'avg("'||column_name[i]||'")::numeric(25,10)'; 
	else
		l := 1;
		avg_array := avg_array||'array[';
		while l <= column_array_length[i] loop
			if l != 1 then
				avg_array := avg_array||',';
			end if;
			avg_array := avg_array||'avg("'||column_name[i]||'"['||l||'])::numeric(25,10)';
			l := l + 1;
		end loop;
		avg_array := avg_array||']::numeric(25,10)[]';
	end if;
	avg_array := avg_array||' "'||column_name[i]||'"';
	--avg_array := avg_array||' "'||column_name[i]||'"';
        --avg_array := avg_array||',avg("'||column_name[i]||'")::numeric(25,10) "'||column_name[i]||'"';
	i := i + 1;
end loop;


------------------

data_array:='array[';
i:=1;
while i<=column_number loop
if (i != 1) then
	data_array := data_array||',';
end if;
--data_array:=data_array||'x."'||column_name[i]||'"';
	if column_array_length[i] < 1 then
		data_array:=data_array||'x."'||column_name[i]||'"'; 
	else
		l := 1;
		while l <= column_array_length[i] loop
			if l != 1 then
				data_array:=data_array||',';
			end if;
			--avg_array := avg_array||'avg("'||column_name[i]||'"['||l||'])::numeric(25,10)';
			data_array:=data_array||'x."'||column_name[i]||'"['||l||']';
			l := l + 1;
		end loop;
	end if;
i:=i+1;
end loop;
data_array:=data_array||']';
--data_array:=data_array||'x."'||column_name[i]||'"]';

---------------
sql:='create temp table '||temptablename||tmp_res_2||' (sample_id integer,'||alpine_id||' character varying,cluster_id integer) distributed by ('||alpine_id||')';
--raise notice '3 asdf sql:%',sql;
execute sql;
i:=1;
sql:='select sample_id::smallint,'||sample_array1||'::float[] from '||temptablename||'_random_new y where stable=0 order by sample_id';
-- --raise notice 'sql:%',sql;
--raise notice '4 asdf sql:%',sql;
     for roww in execute sql loop
	 sample_array3=roww.array;
	 sampleid=roww.sample_id;
	 sample_array2:='';
	j:=1;
	while j<column_array_sum*k loop
	sample_array2:=sample_array2||sample_array3[j]||',';
	j:=j+1;
	end loop;
	sample_array2:=sample_array2||sample_array3[j];
	sample_array2:='array['||sample_array2||']';
	sql1:='insert into '||temptablename||tmp_res_2||' select '||sampleid||'::smallint,'||alpine_id||',alpine_miner_kmeans_distance_loop('||sample_array2;
	sql1:=sql1||'::float[],'||data_array||'::float[],'||k||','||distance||')as cluster_id from '||temptablename||'copy x';
	  ----raise notice 'sqll:%',sql1;
	--raise notice '5 asdf sql:%',sql1;
	 execute sql1;
	 i:=i+1;
     end loop;
---------------


--------tmp_res_2 caculate each point in random table's distance to each point in date table and get each point in date table should belong to which cluster----------
/*sql:='drop table if exists '||temptablename||tmp_res_2||';create temp table '||temptablename||tmp_res_2||' as (select 
	sample_id,'||id||',alpine_miner_kmeans_distance_loop('||sample_array1||'::float[],'||data_array||'::float[],'||k||','||distance||') as cluster_id
from '||temptablename||'copy x inner join '||temptablename||'_random_new y on y.stable=0) distributed by (sample_id,'||id||',cluster_id)';

execute sql;*/


-----tmp_res_1 caculate unstable cluster---
sql:='drop table if exists '||temptablename||tmp_res_1||'; create temp table '||temptablename||tmp_res_1||'   as
(
select 
	sample_id,
 	cluster_id,
	'||avg_array||'
from '||temptablename||tmp_res_2||'
x,'||temptablename||'copy y
where x.'||alpine_id||'=y.'||alpine_id||'
 group by 1,2
)distributed by(sample_id,cluster_id)
 ;
 ';

--raise notice '6 asdf sql:%',sql;
execute sql;
 
--raise info '------------1--------------'; 


sql:='drop table if exists '||temptablename||'temp;create temp table '||temptablename||'temp as select tablek1.sample_id,0::smallint as stable,';
i := 1;
 while i<(k + 1) loop
	sql:=sql||'k'||i||',';
	i := i + 1;	
 end loop;
sql:=sql||'0::integer as iter from ';


i := 1;
while i<(k + 1) loop
	sql:=sql||'(select array[';
	 j := 1;
	while j<=(column_number) loop
          if (j != 1) then
             sql := sql ||',';
          end if;
	  --sql:=sql||'"'||column_name[j]||'"';
		if column_array_length[j] < 1 then
			sql:=sql||'"'||column_name[j]||'"';
		else
			l := 1;
			while l <= column_array_length[j] loop
				if l != 1 then
					sql := sql || ',';
				end if;
				sql:=sql||'"'||column_name[j]||'"['||l||']';
				l := l + 1;
			end loop;
		end if;
		j := j + 1;
	end loop;



	sql:=sql||'] k'||i||',';

	if i=1 then sql:=sql||' sample_id from '||temptablename||tmp_res_1||' where cluster_id='||(i-1)||') as tablek'||i||' inner join ';
	else if i=k then sql:=sql||' sample_id from '||temptablename||tmp_res_1||' where cluster_id='||(i-1)||') as tablek'||i||' on tablek'||(i-1)||'.sample_id=tablek'||i||'.sample_id'; 
	else sql:=sql||' sample_id from '||temptablename||tmp_res_1||' where cluster_id='||(i-1)||') as tablek'||i||' on tablek'||(i-1)||'.sample_id=tablek'||i||'.sample_id inner join ';
	end if;
	end if;
	i := i + 1;
 end loop;
--raise notice '7 asdf sql:%',sql;
execute sql;

sql:='drop table if exists '||temptablename||tmp_res_4||';create temp table '||temptablename||tmp_res_4||' as select sample_id,stable,';


i := 1;
column_array_index := 1;
first := true;
temp_index := 0;
while i<column_number+1 loop
	sql:=sql||'array[';
	j:=1;
		first := true;
		column_array_index := temp_index + 1;
		--sql:=sql||'k'||j||'['||i||']';
		if column_array_length[i] < 1 then
			j := 1;
			while j<=k loop
				if first is true then
					first := false;
				else
					sql := sql||',';
				end if;
				sql := sql||'k'||j||'['||column_array_index||']';
				j := j + 1;
			end loop;
		else
			l := 1;
			while l <= column_array_length[i] loop
				j := 1;
				while j<=k loop

				if first is true then
					first := false;
				else
					sql := sql||',';
				end if;

				sql := sql || 'k'||j||'['||column_array_index||']';
				j := j + 1;
				end loop;
				column_array_index := column_array_index + 1;
				l := l + 1;
			end loop;
		end if;
	if column_array_length[i] < 1 then
		temp_index := temp_index + 1;
	else
		temp_index := temp_index + column_array_length[i];
	end if;
	sql:=sql||']::float[] "'||column_name[i]||'",';
	i := i + 1;
	end loop;
	sql:=sql||' iter from '||temptablename||'temp distributed by (sample_id)';
----raise notice '----create random sql:%',sql;
--raise notice '8 asdf sql:%',sql;
execute sql;

comp_sql_new:='(case when ';
i:=1;
while i<(k + 1) loop
  j:=1;
  while j<column_number+1 loop
	if column_array_length[j] < 1 then
		temp_text := column_name[j]||'"['||i||']';
		comp_sql_new:=comp_sql_new||'x."'||temp_text||'=y."'||temp_text;
	else
		l := 1;
		column_array_index := i;
		while l <= column_array_length[j] loop
			if l  != 1 then
				comp_sql_new:=comp_sql_new||' and ';
			end if;
			temp_text := column_name[j]||'"['||column_array_index||']';
			comp_sql_new:=comp_sql_new||'x."'||temp_text||'=y."'||temp_text;
			l := l + 1;
			column_array_index := column_array_index + k;
		end loop;
	end if;

  	if i!=k or j!=column_number then 
		comp_sql_new:=comp_sql_new||' and ';
	end if;
	j:=j+1;
  end loop;
  i:=i+1;
end loop;
comp_sql_new:=comp_sql_new||' then 1 else 0 end )as stable';
----raise notice '----comp_sql_new :%',comp_sql_new;
------------

xx_array:='';
i := 1;
 while i<(column_number + 1) loop
	xx_array:=xx_array||'array[';

--	xx_array:=xx_array||'x."'||column_name[i]||'"['||j||']';
	if (column_array_length[i] < 1) then
		j := 1;
		while j<=k loop
		if j != 1 then
			xx_array := xx_array||',';
		end if;
		xx_array:=xx_array||'x."'||column_name[i]||'"['||j||']';
		j := j + 1;
		end loop;
	else
		l := 1;
		column_array_index := 1;
		while l <= column_array_length[i] loop
			j := 1;
			while j<=k loop
			if l != 1 or j != 1 then
				xx_array:=xx_array||',';
			end if;
			xx_array:=xx_array||'x."'||column_name[i]||'"['||column_array_index||']';
			column_array_index := column_array_index + 1;
			j := j + 1;
			end loop;
			l :=  l + 1;
		end loop;
	end if;
	xx_array:=xx_array||']::float[] "'||column_name[i]||'",';
	i := i + 1;
 end loop;
-- --raise notice 'xx_array:%',xx_array;
 
 --------tmp_res_3 judge which sample is stable----
sql:='drop table if exists '||temptablename||tmp_res_3||';create temp table '||temptablename||tmp_res_3||' as
(
	select 
		x.sample_id,
	 	'||comp_sql_new||','||xx_array
	 	||run||' as iter
	from  '||temptablename||tmp_res_4||' x, '||temptablename||'_random_new  y
	where x.sample_id=y.sample_id

)
distributed by(sample_id)
;
';
----------------

--raise notice '9 asdf sql:%',sql;
execute sql;

sql:='insert into '||temptablename||tmp_res_3||' (select a.* from '||temptablename||'_random_new a left join '||temptablename||tmp_res_3||' as b on a.sample_id=b.sample_id';
sql:=sql||' where b.sample_id is null);';

sql:=sql||'drop table if exists '||temptablename||'temp1;create temp table '||temptablename||'temp1 as select * from '||temptablename||tmp_res_3||' distributed by (sample_id);';
sql:=sql||'drop table if exists '||temptablename||'_random_new;';
sql:=sql||'alter table '||temptablename||'temp1 rename to '||temptablename||'_random_new;';
--raise notice '10 asdf sql:%',sql;
execute sql;


--raise notice '11 asdf sql:%',sql;
execute 'select count(*)  from  '||temptablename||'_random_new where stable=0;' into none_stable;--into '||none_stable||'


--raise notice '-------------------none_stable:%',none_stable;

if none_stable=0
then
	exit;
end if;

run := run+1;

end loop;
---------Adjust stable end--------------

sql:='select array[sample_id,len]
from
(
	select sample_id,len,row_number() over(order by len) as seq 
	from
	(
		select sample_id,avg(len) as len
		from
		(
		select sample_id,alpine_miner_kmeans_distance_result('||sample_array1||'::float[],'||data_array||'::float[],'||k||','||distance||') as len
			from '||temptablename||'copy x inner join '||temptablename||'_random_new y on y.stable=1
			)a
		 	group by 1
		)b
)z
where seq=1';

--raise notice '----get sample sql:%',sql;

--raise notice '12 asdf sql:%',sql;
execute sql into resultarray;
sampleid:=resultarray[1];

if sampleid is null then 
sampleid:=0;
nullflag:=1;
 end if;

--------deal result---------------- in (select sample_id from '||temptablename||'tmp_res_4) 
result1:='result1';
--raise notice '13 asdf sql:%',sql;
execute 'drop table if exists '||temptablename||result1;

--raise notice '14 asdf sql:%',sql;
sql := 'create temp table '||temptablename||result1||' as 
(
	select * from  '||temptablename||'_random_new  where sample_id ='||sampleid||'
)distributed by(sample_id);'
;
--raise notice '141 asdf sql:%',sql;
execute sql;

if nullflag=1 then
sql:='select len
from
(
	select sample_id,len,row_number() over(order by len) as seq 
	from
	(
		select sample_id,avg(len) as len
		from
		(
		select sample_id,alpine_miner_kmeans_distance_result('||sample_array1||'::float[],'||data_array||'::float[],'||k||','||distance||') as len
			from '||temptablename||'copy x inner join '||temptablename||result1||' y on y.stable=0
			)a
		 	group by 1
		)b
)z
where seq=1';
--raise notice '15 asdf sql:%',sql;
execute sql into tempsum;
--raise notice '-------------------tempsum:%',tempsum;
resultarray[2]:=tempsum;
end if;

--raise notice '16 asdf sql:%',sql;
execute 'drop table if exists '||temptablename||'result2; create temp table '||temptablename||'result2 as select *,0::integer '||temptablename||'copy_flag from '||temptablename||'copy  distributed randomly;';





sql:='
	drop table if exists '||temptablename||'table_name_temp;create temp table '||temptablename||'table_name_temp as
		(
		select '||alpine_id||' as temp_id,alpine_miner_kmeans_distance_loop('||sample_array1||'::float[],'||data_array||'::float[],'||k||','||distance||') as '||clustername||' 
		from '||temptablename||'result2 x inner join '||temptablename||result1||' y on x.'||temptablename||'copy_flag=0

		)  distributed randomly ;';

--raise notice '17 asdf sql:%',sql;
execute sql;

resultarray[1]:=run;

RETURN resultarray;
 
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.alpine_miner_kmeans_c_array_array(table_name text, table_name_withoutschema text, column_name text[], column_array_length integer[], column_number integer, id text, tempid text, clustername text, k integer, max_run integer, max_iter integer, distance integer) OWNER TO gpadmin;

--
-- Name: alpine_miner_kmeans_distance(integer, text[], integer, integer); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_kmeans_distance(distancetype integer, column_name text[], column_number integer, k integer) RETURNS text
    AS $$

DECLARE
	 caculate_array text:='';
	 temp1 text:='';
	 temp2 text:='';
	 temp3 text:='';
	 temp4 text:='';
	 i integer;
	 j integer;
	 m integer;

BEGIN
	if distancetype=1 --EuclideanDistance
	then 
		i:=1;
		while i<(k + 1) loop
		j:=1;
		caculate_array:=caculate_array||'(';
		while j<column_number loop
		caculate_array:=caculate_array||'(x."'||column_name[j]||'"::float-y."k'||i||column_name[j]||'")*(x."'||column_name[j]||'"::float-y."k'||i||column_name[j]||'")+';
		j:=j+1;
		end loop; 
		if i=k then caculate_array:=caculate_array||'(x."'||column_name[j]||'"::float-y."k'||i||column_name[j]||'")*(x."'||column_name[j]||'"::float-y."k'||i||column_name[j]||'")) as d'||(i-1);
		else caculate_array:=caculate_array||'(x."'||column_name[j]||'"::float-y."k'||i||column_name[j]||'")*(x."'||column_name[j]||'"::float-y."k'||i||column_name[j]||'")) as d'||(i-1)||',';
		end if;
		i:=i+1;
		end loop;
	elsif distancetype=2	--BregmanDivergence.GeneralizedIDivergence
	then
		i:=1;
		while i<(k + 1) loop
		j:=1;
		temp1:='(';
		temp2:='(';
			while j<column_number loop
			temp1:=temp1||'(y."k'||i||column_name[j]||'"*ln(y."k'||i||column_name[j]||'"::float/x."'||column_name[j]||'"))+';
			temp2:=temp2||'(y."k'||i||column_name[j]||'"::float-x."'||column_name[j]||'")+';
			j:=j+1;
			end loop; 
		temp1:=temp1||'(y."k'||i||column_name[j]||'"*ln(y."k'||i||column_name[j]||'"::float/x."'||column_name[j]||'")))';
		temp2:=temp2||'(y."k'||i||column_name[j]||'"::float-x."'||column_name[j]||'"))';
		temp3:='('||temp1||'-'||temp2||')';
		if i=k then temp3:=temp3||'as d'||(i-1);
		else temp3:=temp3||'as d'||(i-1)||',';		
		end if;
		caculate_array:=caculate_array||temp3;
		i:=i+1;
		end loop;
	elsif distancetype=3      --BregmanDivergence.KLDivergence
	then
		i:=1;
		while i<(k + 1) loop
		j:=1;
		caculate_array:=caculate_array||'(';
		while j<column_number loop
		caculate_array:=caculate_array||'(y."k'||i||column_name[j]||'"*log(2.0,(y."k'||i||column_name[j]||'"::float/x."'||column_name[j]||'")::numeric))+';
		j:=j+1;
		end loop; 
		if i=k then caculate_array:=caculate_array||'(y."k'||i||column_name[j]||'"*log(2.0,(y."k'||i||column_name[j]||'"::float/x."'||column_name[j]||'")::numeric))) as d'||(i-1);

		else caculate_array:=caculate_array||'(y."k'||i||column_name[j]||'"*log(2.0,(y."k'||i||column_name[j]||'"::float/x."'||column_name[j]||'")::numeric))) as d'||(i-1)||',';
		end if;
		i:=i+1;
		end loop;
	elsif distancetype=4      --CamberraNumericalDistance
	then
		i:=1;
		while i<(k + 1) loop
		j:=1;
		caculate_array:=caculate_array||'(';
		while j<column_number loop
		caculate_array:=caculate_array||'(abs((x."'||column_name[j]||'"::float)-(y."k'||i||column_name[j]||'"))/abs((x."'||column_name[j]||'"::float)+(y."k'||i||column_name[j]||'")))+';
		j:=j+1;
		end loop; 
		if i=k then caculate_array:=caculate_array||'(abs((x."'||column_name[j]||'"::float)-(y."k'||i||column_name[j]||'"))/abs((x."'||column_name[j]||'"::float)+(y."k'||i||column_name[j]||'")))) as d'||(i-1);
		else caculate_array:=caculate_array||'(abs((x."'||column_name[j]||'"::float)-(y."k'||i||column_name[j]||'"))/abs((x."'||column_name[j]||'"::float)+(y."k'||i||column_name[j]||'")))) as d'||(i-1)||',';
		end if;
		i:=i+1;
		end loop;
	elsif distancetype=5      --ManhattanDistance
	then	
		i:=1;
		while i<(k + 1) loop
		j:=1;
		caculate_array:=caculate_array||'(';
		while j<column_number loop
		caculate_array:=caculate_array||'abs((x."'||column_name[j]||'"::float)-(y."k'||i||column_name[j]||'"))+';
		j:=j+1;
		end loop; 
		if i=k then caculate_array:=caculate_array||'abs((x."'||column_name[j]||'"::float)-(y."k'||i||column_name[j]||'"))) as d'||(i-1);
		else caculate_array:=caculate_array||'abs((x."'||column_name[j]||'"::float)-(y."k'||i||column_name[j]||'"))) as d'||(i-1)||',';
		end if;
		i:=i+1;
		end loop;
	
	elsif distancetype=6      --CosineSimilarityDistance
	then	
		i:=1;
		while i<(k + 1) loop
		j:=1;
		temp1:='(';
		temp2:='(';
		temp3:='(';
		while j<column_number loop
		temp1:=temp1||'(x."'||column_name[j]||'"::float*y."k'||i||column_name[j]||'")+';
		temp2:=temp2||'(x."'||column_name[j]||'"::float*x."'||column_name[j]||'")+';
		temp3:=temp3||'(y."k'||i||column_name[j]||'"::float*y."k'||i||column_name[j]||'")+';
		j:=j+1;
		end loop; 
		temp1:=temp1||'(x."'||column_name[j]||'"::float*y."k'||i||column_name[j]||'"))';
		temp2:=temp2||'(x."'||column_name[j]||'"::float*x."'||column_name[j]||'"))';
		temp3:=temp3||'(y."k'||i||column_name[j]||'"::float*y."k'||i||column_name[j]||'"))';
		if i=k then 
		temp4:='acos(case when ('||temp1||'/(sqrt('||temp2||')*sqrt('||temp3||')))>1 then 1 when ('||temp1||'/(sqrt('||temp2||')*sqrt('||temp3||')))<-1 then -1 else ('||temp1||'/(sqrt('||temp2||')*sqrt('||temp3||'))) end ) as d'||(i-1);--
		else
		temp4:='acos(case when ('||temp1||'/(sqrt('||temp2||')*sqrt('||temp3||')))>1 then 1 when ('||temp1||'/(sqrt('||temp2||')*sqrt('||temp3||')))<-1 then -1 else ('||temp1||'/(sqrt('||temp2||')*sqrt('||temp3||'))) end ) as d'||(i-1)||',';--acos
		end if;
		caculate_array:=caculate_array||temp4;
		i:=i+1;
		end loop;
		
	elsif distancetype=7	--DiceNumericalSimilarityDistance
	then
		i:=1;
		while i<(k + 1) loop
		j:=1;
		temp1:='(';
		temp2:='(';
		temp3:='(';
		while j<column_number loop
		temp1:=temp1||'(x."'||column_name[j]||'"::float)+';
		temp2:=temp2||'(y."k'||i||column_name[j]||'"::float)+';
		temp3:=temp3||'(x."'||column_name[j]||'"::float*y."k'||i||column_name[j]||'")+';
		j:=j+1;
		end loop; 
		temp1:=temp1||'(x."'||column_name[j]||'"))';
		temp2:=temp2||'(y."k'||i||column_name[j]||'"))';
		temp3:=temp3||'(x."'||column_name[j]||'"*y."k'||i||column_name[j]||'"))';
		if i=k then 
		temp4:='(-2*'||temp3||'/('||temp1||'+'||temp2||')) as d'||(i-1);
		else
		temp4:='(-2*'||temp3||'/('||temp1||'+'||temp2||')) as d'||(i-1)||',';
		end if;
		caculate_array:=caculate_array||temp4;
		i:=i+1;
		end loop;
	elsif distancetype=8	--InnerProductSimilarityDistance
	then
		i:=1;
		while i<(k + 1) loop
		j:=1;
		caculate_array:=caculate_array||'-(';
		while j<column_number loop
		caculate_array:=caculate_array||'(x."'||column_name[j]||'"::float*y."k'||i||column_name[j]||'")+';
		j:=j+1;
		end loop; 
		if i=k then caculate_array:=caculate_array||'(x."'||column_name[j]||'"::float*y."k'||i||column_name[j]||'")) as d'||(i-1);
		else caculate_array:=caculate_array||'(x."'||column_name[j]||'"::float*y."k'||i||column_name[j]||'")) as d'||(i-1)||',';
		end if;
		caculate_array:=caculate_array||temp4;
		i:=i+1;
		end loop;
	elsif distancetype=9	--JaccardNumericalSimilarityDistance
	then
		i:=1;
		while i<(k + 1) loop
		j:=1;
		temp1:='(';
		temp2:='(';
		temp3:='(';
		while j<column_number loop
		temp1:=temp1||'(x."'||column_name[j]||'"::float)+';
		temp2:=temp2||'(y."k'||i||column_name[j]||'"::float)+';
		temp3:=temp3||'(x."'||column_name[j]||'"::float*y."k'||i||column_name[j]||'")+';
		j:=j+1;
		end loop; 
		temp1:=temp1||'(x."'||column_name[j]||'"))';
		temp2:=temp2||'(y."k'||i||column_name[j]||'"))';
		temp3:=temp3||'(x."'||column_name[j]||'"*y."k'||i||column_name[j]||'"))';
		if i=k then 
		temp4:='(-'||temp3||'/('||temp1||'+'||temp2||'-'||temp3||')) as d'||(i-1);
		else
		temp4:='(-'||temp3||'/('||temp1||'+'||temp2||'-'||temp3||')) as d'||(i-1)||',';
		end if;
		caculate_array:=caculate_array||temp4;
		i:=i+1;
		end loop;
/*	elseif distancetype=10	--ChebychevDistance 
	--select case when a1>a2 and a1>a3 and a1>a4 then a1 when a2>a3 and a2>a4 then a2 when a3>a4 then a3 else a4 end as d0
	then 
		i:=1;
		while i<(k + 1) loop
		j:=1;
		caculate_array:=caculate_array||'case ';
			while j<column_number loop
			m:=1;
			caculate_array:=caculate_array||' when ';
				while m<column_number-j loop
					caculate_array:=caculate_array||'abs(x."'||column_name[j]||'"::float-y."k'||i||column_name[j]||'")>abs(x."'||column_name[j+m]||'"::float-y."k'||i||column_name[j+m]||'") and ';
					m:=m+1;
				end loop;
				caculate_array:=caculate_array||'abs(x."'||column_name[j]||'"::float-y."k'||i||column_name[j]||'")>abs(x."'||column_name[j+m]||'"::float-y."k'||i||column_name[j+m]||'") then abs(x."'||column_name[j]||'"::float-y."k'||i||column_name[j]||'") ';
			j:=j+1;
			end loop; 
		if i=k then caculate_array:=caculate_array||' else abs(x."'||column_name[j]||'"::float-y."k'||i||column_name[j]||'") end as d'||(i-1);
		else caculate_array:=caculate_array||' else abs(x."'||column_name[j]||'"::float-y."k'||i||column_name[j]||'") end as d'||(i-1)||',';
		end if;
		i:=i+1;
		end loop;*/
	else
	end if;

raise notice 'caculate_array:%',caculate_array;
RETURN caculate_array;
 
END;
$$
    LANGUAGE plpgsql IMMUTABLE;


ALTER FUNCTION public.alpine_miner_kmeans_distance(distancetype integer, column_name text[], column_number integer, k integer) OWNER TO gpadmin;

--
-- Name: alpine_miner_kmeans_sp_1_5(text, text, text[], integer, text, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_kmeans_sp_1_5(table_name text, table_name_withoutschema text, column_name text[], column_number integer, id text, k integer, max_run integer, max_iter integer, distance integer) RETURNS integer
    AS $$
DECLARE
    run integer:=1;
    none_stable integer;
    tmp_res_1 varchar(50);
    tmp_res_2 varchar(50);
    tmp_res_3 varchar(50);
    tmp_res_4 varchar(50);
    result1 varchar(50);
    column_array text;
    columnname text;
    avg_array text;
    power_array text;
    d_array text;
    d_array1 text;
    x_array text;
    comp_array text;
    i integer := 0;
    j integer := 0;
    sql text;
    temptablename text;
    column_all text;
    caculate_array text;
    comp_sql text;
    result_sql text;
    sampleid integer;
  
BEGIN

temptablename:=table_name_withoutschema;

execute 'create temp table '||temptablename||'copy as(select * from '||table_name||' )distributed by('||id||')';

column_array := column_name[1];

i := 2;
while i < (column_number + 1) loop
	column_array := column_array||',"'||column_name[i]||'"';
	i := i + 1;
end loop;

------generate random table start------

sql:='select tablek1.seq sample_id,0::smallint as stable,';
column_all:='';
i := 1;
 while i<(k + 1) loop
 j := 1;
	while j<(column_number+1) loop
		column_all:=column_all||'"k'||i||''||column_name[j]||'"::numeric(25,10),';
		j := j + 1;
		end loop;
	i := i + 1;	
 end loop;
sql:=sql||column_all||'0::integer as iter from ';
--random table's line count is variable max_run,default value is 10--
--The point in same sample is in same row
i := 1;
 while i<(k + 1) loop
sql:=sql||'(select ';
	 j := 1;
	while j<(column_number+1) loop
	  sql:=sql||'"'||column_name[j]||'" "k'||i||column_name[j]||'",';
	  j := j + 1;
	end loop;
	if i=1 then sql:=sql||' row_number() over (order by random())-1 as seq from '||table_name||' limit '||max_run||') as tablek'||i||' inner join ';
	else if i=k then sql:=sql||' row_number() over (order by random())-1 as seq from '||table_name||' limit '||max_run||') as tablek'||i||' on tablek'||(i-1)||'.seq=tablek'||i||'.seq'; 
	else sql:=sql||' row_number() over (order by random())-1 as seq from '||table_name||' limit '||max_run||') as tablek'||i||' on tablek'||(i-1)||'.seq=tablek'||i||'.seq inner join ';end if;
	end if;
	i := i + 1;
 end loop;

sql:='create temp table '||temptablename||'_random_new as ('||sql||') distributed by (sample_id)';
raise notice 'sql:%',sql;
execute sql;

---------generate random table end-------------

---------Adjust stable start--------------
while run<max_iter  loop
tmp_res_1:='tmp_res_1'||run::varchar;
tmp_res_2:='tmp_res_2'||run::varchar;
tmp_res_3:='tmp_res_3'||run::varchar;
tmp_res_4:='tmp_res_4'||run::varchar;
i := 2;
avg_array :=  'avg("'||column_name[1]||'")::numeric(25,10) "'||column_name[1]||'"';
while i < (column_number + 1) loop
        avg_array := avg_array||',avg("'||column_name[i]||'")::numeric(25,10) "'||column_name[i]||'"';
	i := i + 1;
end loop;


i := 0;
j := 0;
d_array := 'case ';
d_array1 := 'case ';
while i < k - 1 loop
	j := i+1;
	d_array := d_array||' when d'||i||'<=d'||j;
	d_array1 := d_array1||' when d'||i||'<=d'||j;
	j := j + 1;
	while j < k loop
		d_array := d_array||' and d'||i||'<=d'||j;
		d_array1 := d_array1||' and d'||i||'<=d'||j;
		j:= j+1;
	end loop;
	d_array := d_array||' then '||i;
	d_array1 := d_array1||' then d'||i;
	i := i + 1;
end loop;
d_array := d_array||' else '||(k-1)||' end';
d_array1 := d_array1||' else d'||(k-1)||' end';
--d_array1 example:d0<=d1 and d0<=d2 then d0 when d1<=d2 then d1 else d2 end
------------------
caculate_array:='';

columnname:='array[';
i:=1;
while i<column_number loop
columnname:=columnname||''''||column_name[i]||''',';
i:=i+1;
end loop;
columnname:=columnname||''''||column_name[i]||''']';

raise notice 'column_name:%',columnname;

sql:='select alpine_miner_Kmeans_distance('||distance||','||columnname||','||column_number||','||k||')';
raise notice 'sql:%',sql;
execute sql into caculate_array;

--------tmp_res_2 caculate each point in random table's distance to each point in date table and get each point in date table should belong to which cluster----------
sql:='drop table if exists '||temptablename||tmp_res_2||';create temp table '||temptablename||tmp_res_2||' as (select 
	sample_id,'||id||',
	     '||d_array||' as cluster_id
from
(
select 
sample_id,'||id||',	     
'||caculate_array||'
 from '||temptablename||'copy x inner join '||temptablename||'_random_new y
   on y.stable=0) as foo) distributed by (sample_id,'||id||',cluster_id)';

execute sql;

-----tmp_res_1 caculate unstable cluster---
sql:='drop table if exists '||temptablename||tmp_res_1||'; create temp table '||temptablename||tmp_res_1||'   as
(
select 
	sample_id,
 	cluster_id,
	'||avg_array||'
from '||temptablename||tmp_res_2||'
x,'||temptablename||'copy y
where x.'||id||'=y.'||id||'
 group by 1,2
)distributed by(sample_id,cluster_id)
 ;
 ';

execute sql;
 
--raise info '------------1--------------'; 

------------
comp_sql:='(case when ';
i:=1;
while i<(k + 1) loop
j:=1;
  while j<column_number+1 loop
  if i=k and j=column_number then comp_sql:=comp_sql||'x."k'||i||column_name[j]||'"=y."k'||i||column_name[j]||'"';
	else comp_sql:=comp_sql||'x."k'||i||column_name[j]||'"=y."k'||i||column_name[j]||'" and ';
	end if;
	j:=j+1;
  end loop;
  i:=i+1;
end loop;
comp_sql:=comp_sql||' then 1 else 0 end )as stable';

-----------

----------------
sql:='select tablek1.sample_id,0::smallint as stable,';
column_all:='';
i := 1;
 while i<(k + 1) loop
 j := 1;
	while j<(column_number+1) loop
		column_all:=column_all||'"k'||i||column_name[j]||'",';
		j := j + 1;
		end loop;
	i := i + 1;	
 end loop;
sql:=sql||column_all||'0::integer as iter from ';


i := 1;
 while i<(k + 1) loop
sql:=sql||'(select ';
	 j := 1;
	while j<(column_number+1) loop
	  sql:=sql||'"'||column_name[j]||'" "k'||i||column_name[j]||'",';
	  j := j + 1;
	end loop;
	if i=1 then sql:=sql||' sample_id from '||temptablename||tmp_res_1||' where cluster_id='||(i-1)||') as tablek'||i||' inner join ';
	else if i=k then sql:=sql||' sample_id from '||temptablename||tmp_res_1||' where cluster_id='||(i-1)||') as tablek'||i||' on tablek'||(i-1)||'.sample_id=tablek'||i||'.sample_id'; 
	else sql:=sql||' sample_id from '||temptablename||tmp_res_1||' where cluster_id='||(i-1)||') as tablek'||i||' on tablek'||(i-1)||'.sample_id=tablek'||i||'.sample_id inner join ';end if;
	end if;
	i := i + 1;
 end loop;

--------tmp_res_4 transform the point in same sample to same line.----
 sql:='drop table if exists '||temptablename||tmp_res_4||';create temp table '||temptablename||tmp_res_4||' as ('||sql||') distributed by (sample_id)';
execute sql;

x_array:='';
i := 1;
 while i<(k + 1) loop
 j:=1;
	while j<(column_number+1) loop
	x_array:=x_array||'x."k'||i||column_name[j]||'",';
	  j := j + 1;
	end loop;
	i := i + 1;
 end loop;
 raise notice 'x_array:%',x_array;
 --------tmp_res_3 judge which sample is stable----
sql:='drop table if exists '||temptablename||tmp_res_3||';create temp table '||temptablename||tmp_res_3||' as
(
	select 
		x.sample_id,
	 	'||comp_sql||','||x_array
	 	||run||' as iter
	from  '||temptablename||tmp_res_4||' x, '||temptablename||'_random_new  y
	where x.sample_id=y.sample_id

)
distributed by(sample_id)
;
';
----------------

execute sql;


execute 'delete from '||temptablename||'_random_new a using '||temptablename||tmp_res_3||' b where a.sample_id=b.sample_id';



execute 'insert into  '||temptablename||'_random_new select * from '||temptablename||tmp_res_3;



execute 'select count(*)  from  '||temptablename||'_random_new where stable=0;' into none_stable;--into '||none_stable||'


raise notice '-------------------none_stable:%',none_stable;

if none_stable=0
then
	exit;
end if;

run := run+1;

end loop;
---------Adjust stable end--------------

sql:='select sample_id
from
(
	select sample_id,row_number() over(order by len) as seq 
	from
	(
		select sample_id,sum(len) as len
		from
		(
				select 
					sample_id,'||id||',
					'||d_array1||' as len
				from
				(	     
				select 
					    	sample_id,
					    	'||id||',
						'||caculate_array||'
					    from
					      '||temptablename||'copy x inner join '||temptablename||'_random_new y
					      on y.stable=1
				)t
			)a
		 	group by 1
		)b
)z
where seq=1';



execute sql into sampleid;

if sampleid is null then sampleid=0;
 end if;

--------deal result---------------- in (select sample_id from '||temptablename||'tmp_res_4) 
result1:='result1';
execute 'drop table if exists '||temptablename||result1;

execute 'create temp table '||temptablename||result1||' as 
(
	select * from  '||temptablename||'_random_new  where sample_id ='||sampleid||'
)distributed by(sample_id);'
;

execute 'drop table if exists '||temptablename||'result2; create temp table '||temptablename||'result2 as select *,0::integer '||temptablename||'copy_flag from '||temptablename||'copy;';


result_sql:='select '||id||' as temp_id,'||d_array||' as cluster from
(
select x.'||id||','||caculate_array||' 
from '||temptablename||'result2 x inner join '||temptablename||result1||' y on x.'||temptablename||'copy_flag=0
) as foo
';
raise notice 'result_sql:%',result_sql;



execute '
	drop table if exists '||temptablename||'table_name_temp;create temp table '||temptablename||'table_name_temp as
		(
		'||result_sql||'
		);';


RETURN run;
 
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.alpine_miner_kmeans_sp_1_5(table_name text, table_name_withoutschema text, column_name text[], column_number integer, id text, k integer, max_run integer, max_iter integer, distance integer) OWNER TO gpadmin;

--
-- Name: alpine_miner_null_to_0(bigint); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_null_to_0(x bigint) RETURNS bigint
    AS $$
BEGIN
if x is null
then return 0;
else return x;
end if;END;
$$
    LANGUAGE plpgsql IMMUTABLE;


ALTER FUNCTION public.alpine_miner_null_to_0(x bigint) OWNER TO gpadmin;

--
-- Name: alpine_miner_null_to_0(double precision); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_null_to_0(x double precision) RETURNS double precision
    AS $$
BEGIN
if x is null
then return 0;
else return x;
end if;END;
$$
    LANGUAGE plpgsql IMMUTABLE;


ALTER FUNCTION public.alpine_miner_null_to_0(x double precision) OWNER TO gpadmin;

--
-- Name: alpine_miner_split(text, text); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION alpine_miner_split(p_list text, p_del text) RETURNS text[]
    AS $$
declare
    l_idx   integer;
    l_list   text := p_list;
    l_value    text;
    result text[];
    result_count int := 0;
begin
    loop
        l_idx := alpine_miner_instr(l_list,p_del);
        result_count := result_count + 1;
        if l_idx > 0 then
            result[result_count]:= (substr(l_list,1,l_idx-1));
            l_list := substr(l_list,l_idx+length(p_del));
        else
            result[result_count] := l_list;
            exit;
        end if;
    end loop;
    return result;
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.alpine_miner_split(p_list text, p_del text) OWNER TO gpadmin;

--
-- Name: reffunc(refcursor); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION reffunc(refcursor) RETURNS refcursor
    AS $_$ 
BEGIN
OPEN $1 FOR SELECT col FROM sn2ro.test;
RETURN $1;
END;
$_$
    LANGUAGE plpgsql;


ALTER FUNCTION public.reffunc(refcursor) OWNER TO gpadmin;

--
-- Name: sp_qry_com(character varying, integer, character varying); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION sp_qry_com(v_shell_nm character varying, v_con_cnt integer, v_param character varying) RETURNS character varying
    AS $$
DECLARE
        v_schema_nm   varchar(10) := 'on_1';
        v_row_cnt     integer     := -1    ;
        v_tot_sql     text                 ;
        v_sql         text                 ;
        v_start_tm    timestamp            ;
        v_end_tm      timestamp            ;
        v_tmp_tb_nm   varchar(50)          ;
v_err_msg text;

BEGIN
        v_tmp_tb_nm :=  'tmp_'||trim(to_char(random()*1000000000000, '00000000000000'));
        v_sql     :=  '
SELECT  ''1'' TMP1
        ,       A.goods_CODE
        ,       SUM(A.IWEL_WAMT) IWEL_WAMT
        ,       Z.DATE_COUNT
FROM            '||v_schema_nm||'.tb_subl_fo_0_1  A
        ,       '||v_schema_nm||'.TB_STORE_Do_1           B
WHERE   A.STORE_CODE    =       B.STORE_CODE
 AND    A.BIZ_CODE      IN      ( ''S'' , ''F'' )
 AND    A.DATE_CODE     BETWEEN ''20100101'' AND ''20100131''
 and    a.store_code = '''||trim(v_param)||'''
GROUP BY   1,2,4
ORDER BY   1,2,4
';

      v_start_tm    :=  clock_timestamp();

      v_tot_sql :=  ' create temp table '||v_tmp_tb_nm||' as '||v_sql|| ' distributed randomly
';
      EXECUTE v_tot_sql;

      GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

      v_end_tm    :=  clock_timestamp();

insert into on_1.t_qry_log_1
             (shell_nm, qry_tp, con_cnt, start_tm, end_tm, param, rslt_cnt)
       values
             (v_shell_nm, 'com', v_con_cnt, v_start_tm, v_end_tm, v_param, v_row_cnt) ;

      return 'SUCCESS'; --trim(to_char(v_row_cnt, '9999999999'));
EXCEPTION
WHEN others THEN
    v_err_msg := sqlerrm;
    RAISE NOTICE 'ERROR_MSG : %' , v_err_msg;
return sqlerrm;

END;

$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.sp_qry_com(v_shell_nm character varying, v_con_cnt integer, v_param character varying) OWNER TO gpadmin;

--
-- Name: sum2_ins1(bigint); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION sum2_ins1(end_loop bigint) RETURNS character varying
    AS $$
declare
    v_start timestamp;
    v_end timestamp;
begin
   v_start := clock_timestamp();
   for i in 1..end_loop loop
        insert into SUM_VALUE
         ( EQP_SUM_RAWID, SUM_DTTS, STEP_ID, STEP_NAME, SUM_PARAM_NAME, SUM_VALUE )
        values (  nextval('myseq'), localtimestamp,  'STEP_IDSTE', 'STEP_NAME1STEP_NAME1'
        , 'SUM_PARAM_NAME123456SUM_PARAM_NAME123456', 543.232425 ); 
   end loop;
   v_end := clock_timestamp();
   return 'Success, elap: '||v_end-v_start||', '||v_start||', '||v_end;
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.sum2_ins1(end_loop bigint) OWNER TO gpadmin;

--
-- Name: sum3_ins1(bigint); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION sum3_ins1(end_loop bigint) RETURNS character varying
    AS $$
declare
    v_start timestamp;
    v_end timestamp;
begin
   v_start := clock_timestamp();
   for i in 1..end_loop loop
        insert into SUM_VALUE
         ( EQP_SUM_RAWID, SUM_DTTS, STEP_ID, STEP_NAME, SUM_PARAM_NAME, SUM_VALUE )
        values (  1, localtimestamp,  'STEP_IDSTE', 'STEP_NAME1STEP_NAME1'
        , 'SUM_PARAM_NAME123456SUM_PARAM_NAME123456', 543.232425 ); 
   end loop;
   v_end := clock_timestamp();
   return 'Success, elap: '||v_end-v_start||', '||v_start||', '||v_end;
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.sum3_ins1(end_loop bigint) OWNER TO gpadmin;

--
-- Name: sum_ins(bigint); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION sum_ins(end_loop bigint) RETURNS character varying
    AS $$

-- select public.trace_ins1(10000);
-- select public.trace_ins10(1000);
-- select public.trace_ins100(100);
-- 
-- select public.temp2_ins1(10000);
-- select public.temp2_ins10(100000);
-- 
-- select public.sum_ins(10000);
-- select public.sum_ins10(1000);
-- select public.sum_ins100(10000);



declare
    v_start timestamp;
    v_end timestamp;
begin
   v_start := clock_timestamp();
   for i in 1..end_loop loop
        insert into SUM_VALUE
         ( EQP_SUM_RAWID, SUM_DTTS, STEP_ID, STEP_NAME, SUM_PARAM_NAME, SUM_VALUE )
        values (  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 ); 
   end loop;
   v_end := clock_timestamp();
   return 'Success, elap: '||v_end-v_start||', '||v_start||', '||v_end;
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.sum_ins(end_loop bigint) OWNER TO gpadmin;

--
-- Name: sum_ins10(bigint); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION sum_ins10(end_loop bigint) RETURNS character varying
    AS $$
declare
    v_start timestamp;
    v_end timestamp;
begin
-- select public.trace_ins1(10000);
-- select public.trace_ins10(1000);
-- select public.trace_ins100(100);
-- 
-- select public.temp2_ins1(10000);
-- select public.temp2_ins10(100000);
-- 
-- select public.sum_ins(10000);
-- select public.sum_ins10(1000);
-- select public.sum_ins100(10000);

   v_start := clock_timestamp();
   for i in 1..end_loop loop
        insert into SUM_VALUE
         ( EQP_SUM_RAWID, SUM_DTTS, STEP_ID, STEP_NAME, SUM_PARAM_NAME, SUM_VALUE )
        values 
	(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
        ; 
   end loop;
   v_end := clock_timestamp();
   return 'Success10, elap: '||v_end-v_start||', '||v_start||', '||v_end;
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.sum_ins10(end_loop bigint) OWNER TO gpadmin;

--
-- Name: sum_ins100(bigint); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION sum_ins100(end_loop bigint) RETURNS character varying
    AS $$
declare
    v_start timestamp;
    v_end timestamp;
begin
-- select public.trace_ins1(10000);
-- select public.trace_ins10(1000);
-- select public.trace_ins100(100);
-- 
-- select public.temp2_ins1(10000);
-- select public.temp2_ins10(100000);
-- 
-- select public.sum_ins(10000);
-- select public.sum_ins10(1000);
-- select public.sum_ins100(10000);

   v_start := clock_timestamp();
   for i in 1..end_loop loop
        insert into SUM_VALUE
         ( EQP_SUM_RAWID, SUM_DTTS, STEP_ID, STEP_NAME, SUM_PARAM_NAME, SUM_VALUE )
        values 
	(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
	-- 10 
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
	-- 20 
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
	-- 30 
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
	-- 40 
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
	-- 50 
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
	-- 60 
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
	-- 70 
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
	-- 80 
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
	-- 90 
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
       ,(  i, localtimestamp,  lpad('T',10,'STEP_ID'), lpad('T',20,'STEP_NAME'), lpad('T',40,'SUM_PARAM_NAME'), 543.232425 )
	-- 100 
        ; 
   end loop;
   v_end := clock_timestamp();
   return 'Success100, elap: '||v_end-v_start||', '||v_start||', '||v_end;
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.sum_ins100(end_loop bigint) OWNER TO gpadmin;

--
-- Name: temp2_ins1(integer); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION temp2_ins1(cnt integer) RETURNS character varying
    AS $$

-- select public.trace_ins1(10000);
-- select public.trace_ins10(1000);
-- select public.trace_ins100(100);
-- 
-- select public.temp2_ins1(10000);
-- select public.temp2_ins10(100000);
-- 
-- select public.sum_ins(10000);
-- select public.sum_ins10(1000);
-- select public.sum_ins100(10000);

declare
    v_start timestamp;
    v_end timestamp;
    v_src_data varchar(1000) := 'This section provides an overview of TOAST (The Oversized-Attribute Storage Technique). 이 섹션은 TOAST에 대한 개요이다.(Size초과 속성 저장 기술) PostgreSQL uses a fixed page size (commonly 8 kB), and does not allow tuples to span multiple pages. PostgreSQL은 보통 8kB인 고정 page를 사용하고, Row가 여러 페이지에 나누어지는 것을 허용하지 않는다. Therefore, it is not possible to store very large field values directly. 그러므로 매우 큰 field를 직접 저장할 수 없다. To overcome this limitation, large field values are compressed and/or broken up into multiple physical rows. 이러한 한계를 극복하기 위해서, field 값을 압축하고 여러 물리적 row에 나눈다. This happens transparently to the user, with only small impact on most of the backend code. 이것은 작은 영향으로 사용자에게는 알리지 않는다. 알리지 않는다는 의미는 사용자는 저정방식에 따라 SQL을 다르게 작성할 필요 없이 일반 SQL 그대로 사용하면된다는 것이다. The technique is affectionately known as TOAST (or the best thing since sliced bread';
begin
   v_start := clock_timestamp();
   for i in 1..cnt loop
       insert into DATA_TEMP ( EQP_MODULE_ID, EQP_DCP_ID, TRACE_DTTS, STATUS_CD,  
      		FILE_DATA_1, FILE_DATA_2, FILE_DATA_3, FILE_DATA_4, FILE_DATA_5,
      		LOT_ID, SUBSTRATE_ID, PRODUCT_ID, RECIPE_ID, STEP_ID )
        values ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', 
            v_src_data, v_src_data, v_src_data, v_src_data, v_src_data,
            lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') );
   end loop;
   v_end := clock_timestamp();
   return 'Success, elap: '||v_end-v_start||', '||v_start||', '||v_end;
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.temp2_ins1(cnt integer) OWNER TO gpadmin;

--
-- Name: temp2_ins10(integer); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION temp2_ins10(cnt integer) RETURNS character varying
    AS $$

-- select public.trace_ins1(10000);
-- select public.trace_ins10(1000);
-- select public.trace_ins100(100);
-- 
-- select public.temp2_ins1(10000);
-- select public.temp2_ins10(100000);
-- 
-- select public.sum_ins(10000);
-- select public.sum_ins10(1000);
-- select public.sum_ins100(10000);

declare
    v_start timestamp;
    v_end timestamp;
    v_src_data varchar(1000) := 'This section provides an overview of TOAST (The Oversized-Attribute Storage Technique). 이 섹션은 TOAST에 대한 개요이다.(Size초과 속성 저장 기술) PostgreSQL uses a fixed page size (commonly 8 kB), and does not allow tuples to span multiple pages. PostgreSQL은 보통 8kB인 고정 page를 사용하고, Row가 여러 페이지에 나누어지는 것을 허용하지 않는다. Therefore, it is not possible to store very large field values directly. 그러므로 매우 큰 field를 직접 저장할 수 없다. To overcome this limitation, large field values are compressed and/or broken up into multiple physical rows. 이러한 한계를 극복하기 위해서, field 값을 압축하고 여러 물리적 row에 나눈다. This happens transparently to the user, with only small impact on most of the backend code. 이것은 작은 영향으로 사용자에게는 알리지 않는다. 알리지 않는다는 의미는 사용자는 저정방식에 따라 SQL을 다르게 작성할 필요 없이 일반 SQL 그대로 사용하면된다는 것이다. The technique is affectionately known as TOAST (or the best thing since sliced bread';
begin
   v_start := clock_timestamp();
   for i in 1..cnt loop
       insert into DATA_TEMP ( EQP_MODULE_ID, EQP_DCP_ID, TRACE_DTTS, STATUS_CD,  
      		FILE_DATA_1, FILE_DATA_2, FILE_DATA_3, FILE_DATA_4, FILE_DATA_5,
      		LOT_ID, SUBSTRATE_ID, PRODUCT_ID, RECIPE_ID, STEP_ID )
        values 
        ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) ;
   end loop;
   v_end := clock_timestamp();
   return 'Success10, elap: '||v_end-v_start||', '||v_start||', '||v_end;
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.temp2_ins10(cnt integer) OWNER TO gpadmin;

--
-- Name: temp_ins1(integer); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION temp_ins1(cnt integer) RETURNS character varying
    AS $$
-- select public.trace_ins1(10000);
-- select public.trace_ins10(1000);
-- select public.trace_ins100(100);
-- 
-- select public.temp2_ins1(10000);
-- select public.temp2_ins10(100000);
-- 
-- select public.sum_ins(10000);
-- select public.sum_ins10(1000);
-- select public.sum_ins100(10000);


declare
    v_start timestamp;
    v_end timestamp;
    v_src_data varchar(1000) := 'This section provides an overview of TOAST (The Oversized-Attribute Storage Technique). 이 섹션은 TOAST에 대한 개요이다.(Size초과 속성 저장 기술) PostgreSQL uses a fixed page size (commonly 8 kB), and does not allow tuples to span multiple pages. PostgreSQL은 보통 8kB인 고정 page를 사용하고, Row가 여러 페이지에 나누어지는 것을 허용하지 않는다. Therefore, it is not possible to store very large field values directly. 그러므로 매우 큰 field를 직접 저장할 수 없다. To overcome this limitation, large field values are compressed and/or broken up into multiple physical rows. 이러한 한계를 극복하기 위해서, field 값을 압축하고 여러 물리적 row에 나눈다. This happens transparently to the user, with only small impact on most of the backend code. 이것은 작은 영향으로 사용자에게는 알리지 않는다. 알리지 않는다는 의미는 사용자는 저정방식에 따라 SQL을 다르게 작성할 필요 없이 일반 SQL 그대로 사용하면된다는 것이다. The technique is affectionately known as TOAST (or the best thing since sliced bread';
begin
   v_start := clock_timestamp();
   for i in 1..cnt loop
       insert into DATA_TEMP ( EQP_MODULE_ID, EQP_DCP_ID, TRACE_DTTS, STATUS_CD,  
      		FILE_DATA_1, FILE_DATA_2, FILE_DATA_3, FILE_DATA_4, FILE_DATA_5,
      		LOT_ID, SUBSTRATE_ID, PRODUCT_ID, RECIPE_ID, STEP_ID )
        values ( i, lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', 
            v_src_data, v_src_data, v_src_data, v_src_data, v_src_data,
            lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') );
   end loop;
   v_end := clock_timestamp();
   return 'Success, elap: '||v_end-v_start||', '||v_start||', '||v_end;
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.temp_ins1(cnt integer) OWNER TO gpadmin;

--
-- Name: temp_ins10(integer); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION temp_ins10(cnt integer) RETURNS character varying
    AS $$
declare
    v_start timestamp;
    v_end timestamp;
    v_src_data varchar(1000) := 'This section provides an overview of TOAST (The Oversized-Attribute Storage Technique). 이 섹션은 TOAST에 대한 개요이다.(Size초과 속성 저장 기술) PostgreSQL uses a fixed page size (commonly 8 kB), and does not allow tuples to span multiple pages. PostgreSQL은 보통 8kB인 고정 page를 사용하고, Row가 여러 페이지에 나누어지는 것을 허용하지 않는다. Therefore, it is not possible to store very large field values directly. 그러므로 매우 큰 field를 직접 저장할 수 없다. To overcome this limitation, large field values are compressed and/or broken up into multiple physical rows. 이러한 한계를 극복하기 위해서, field 값을 압축하고 여러 물리적 row에 나눈다. This happens transparently to the user, with only small impact on most of the backend code. 이것은 작은 영향으로 사용자에게는 알리지 않는다. 알리지 않는다는 의미는 사용자는 저정방식에 따라 SQL을 다르게 작성할 필요 없이 일반 SQL 그대로 사용하면된다는 것이다. The technique is affectionately known as TOAST (or the best thing since sliced bread';
begin
   v_start := clock_timestamp();
   for i in 1..cnt loop
       insert into DATA_TEMP ( EQP_MODULE_ID, EQP_DCP_ID, TRACE_DTTS, STATUS_CD,  
      		FILE_DATA_1, FILE_DATA_2, FILE_DATA_3, FILE_DATA_4, FILE_DATA_5,
      		LOT_ID, SUBSTRATE_ID, PRODUCT_ID, RECIPE_ID, STEP_ID )
        values 
        ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) ;
   end loop;
   v_end := clock_timestamp();
   return 'Success10, elap: '||v_end-v_start||', '||v_start||', '||v_end;
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.temp_ins10(cnt integer) OWNER TO gpadmin;

--
-- Name: temp_ins100(integer); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION temp_ins100(cnt integer) RETURNS character varying
    AS $$
declare
    v_start timestamp;
    v_end timestamp;
    v_src_data varchar(1000) := 'This section provides an overview of TOAST (The Oversized-Attribute Storage Technique). 이 섹션은 TOAST에 대한 개요이다.(Size초과 속성 저장 기술) PostgreSQL uses a fixed page size (commonly 8 kB), and does not allow tuples to span multiple pages. PostgreSQL은 보통 8kB인 고정 page를 사용하고, Row가 여러 페이지에 나누어지는 것을 허용하지 않는다. Therefore, it is not possible to store very large field values directly. 그러므로 매우 큰 field를 직접 저장할 수 없다. To overcome this limitation, large field values are compressed and/or broken up into multiple physical rows. 이러한 한계를 극복하기 위해서, field 값을 압축하고 여러 물리적 row에 나눈다. This happens transparently to the user, with only small impact on most of the backend code. 이것은 작은 영향으로 사용자에게는 알리지 않는다. 알리지 않는다는 의미는 사용자는 저정방식에 따라 SQL을 다르게 작성할 필요 없이 일반 SQL 그대로 사용하면된다는 것이다. The technique is affectionately known as TOAST (or the best thing since sliced bread';
begin
   v_start := clock_timestamp();
   for i in 1..cnt loop
       insert into DATA_TEMP ( EQP_MODULE_ID, EQP_DCP_ID, TRACE_DTTS, STATUS_CD,  
      		FILE_DATA_1, FILE_DATA_2, FILE_DATA_3, FILE_DATA_4, FILE_DATA_5,
      		LOT_ID, SUBSTRATE_ID, PRODUCT_ID, RECIPE_ID, STEP_ID )
        values 
        ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
	-- 10 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
	-- 20 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
	-- 30 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
	-- 40 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
	-- 50 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
	-- 60 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
	-- 70 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
	-- 80 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
	-- 90 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( i||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) ;
	-- 100
	end loop;
   v_end := clock_timestamp();
   return 'Success100, elap: '||v_end-v_start||', '||v_start||', '||v_end;
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.temp_ins100(cnt integer) OWNER TO gpadmin;

--
-- Name: trace_ins1(integer); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION trace_ins1(cnt integer) RETURNS character varying
    AS $$

-- select public.trace_ins1(10000);
-- select public.trace_ins10(1000);
-- select public.trace_ins100(100);
-- 
-- select public.temp2_ins1(10000);
-- select public.temp2_ins10(100000);
-- 
-- select public.sum_ins(10000);
-- select public.sum_ins10(1000);
-- select public.sum_ins100(10000);

declare
    v_start timestamp;
    v_end timestamp;
    v_src_data varchar(1000) := 'This section provides an overview of TOAST (The Oversized-Attribute Storage Technique). 이 섹션은 TOAST에 대한 개요이다.(Size초과 속성 저장 기술) PostgreSQL uses a fixed page size (commonly 8 kB), and does not allow tuples to span multiple pages. PostgreSQL은 보통 8kB인 고정 page를 사용하고, Row가 여러 페이지에 나누어지는 것을 허용하지 않는다. Therefore, it is not possible to store very large field values directly. 그러므로 매우 큰 field를 직접 저장할 수 없다. To overcome this limitation, large field values are compressed and/or broken up into multiple physical rows. 이러한 한계를 극복하기 위해서, field 값을 압축하고 여러 물리적 row에 나눈다. This happens transparently to the user, with only small impact on most of the backend code. 이것은 작은 영향으로 사용자에게는 알리지 않는다. 알리지 않는다는 의미는 사용자는 저정방식에 따라 SQL을 다르게 작성할 필요 없이 일반 SQL 그대로 사용하면된다는 것이다. The technique is affectionately known as TOAST (or the best thing since sliced bread';
    v_file_data varchar(40000);
begin
   v_start := clock_timestamp();
   v_file_data := v_src_data;
   for i in 1..38 loop
	v_file_data := v_file_data || v_src_data;
   end loop;
   for i in 1..cnt loop
        insert into TRACE ( EQP_MODULE_ID, EQP_DCP_ID, STATUS_CD, START_DTTS, END_DTTS, SAMPLE_COUNT, TRACE_FAULT_COUNT, TRACE_WARNING_COUNT, MSPC_FAULT_COUNT, ALARM_COUNT
            , FILE_DATA, LOT_ID,  SUBSTRATE_ID, PRODUCT_ID, RECIPE_ID, STEP_ID )
        values ( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day'
             , 100, 10, 10, 10, 10
             , v_file_data
             , lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') );
   end loop;
   v_end := clock_timestamp();
   return 'Success';   
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.trace_ins1(cnt integer) OWNER TO gpadmin;

--
-- Name: trace_ins10(integer); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION trace_ins10(cnt integer) RETURNS character varying
    AS $$

-- select public.trace_ins1(10000);
-- select public.trace_ins10(1000);
-- select public.trace_ins100(100);
-- 
-- select public.temp2_ins1(10000);
-- select public.temp2_ins10(100000);
-- 
-- select public.sum_ins(10000);
-- select public.sum_ins10(1000);
-- select public.sum_ins100(10000);

declare
    v_start timestamp;
    v_end timestamp;
    v_src_data varchar(1000) := 'This section provides an overview of TOAST (The Oversized-Attribute Storage Technique). 이 섹션은 TOAST에 대한 개요이다.(Size초과 속성 저장 기술) PostgreSQL uses a fixed page size (commonly 8 kB), and does not allow tuples to span multiple pages. PostgreSQL은 보통 8kB인 고정 page를 사용하고, Row가 여러 페이지에 나누어지는 것을 허용하지 않는다. Therefore, it is not possible to store very large field values directly. 그러므로 매우 큰 field를 직접 저장할 수 없다. To overcome this limitation, large field values are compressed and/or broken up into multiple physical rows. 이러한 한계를 극복하기 위해서, field 값을 압축하고 여러 물리적 row에 나눈다. This happens transparently to the user, with only small impact on most of the backend code. 이것은 작은 영향으로 사용자에게는 알리지 않는다. 알리지 않는다는 의미는 사용자는 저정방식에 따라 SQL을 다르게 작성할 필요 없이 일반 SQL 그대로 사용하면된다는 것이다. The technique is affectionately known as TOAST (or the best thing since sliced bread';
    v_file_data varchar(40000);
begin
   v_start := clock_timestamp();
   v_file_data := v_src_data;
   for i in 1..38 loop
	v_file_data := v_file_data || v_src_data;
   end loop;
   for i in 1..cnt loop
        insert into TRACE ( EQP_MODULE_ID, EQP_DCP_ID, STATUS_CD, START_DTTS, END_DTTS, SAMPLE_COUNT, TRACE_FAULT_COUNT, TRACE_WARNING_COUNT, MSPC_FAULT_COUNT, ALARM_COUNT
            , FILE_DATA, LOT_ID,  SUBSTRATE_ID, PRODUCT_ID, RECIPE_ID, STEP_ID )
        values 
	    ( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
        ;
   end loop;
   v_end := clock_timestamp();
   return 'Success';   
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.trace_ins10(cnt integer) OWNER TO gpadmin;

--
-- Name: trace_ins100(integer); Type: FUNCTION; Schema: public; Owner: gpadmin
--

CREATE FUNCTION trace_ins100(cnt integer) RETURNS character varying
    AS $$
-- select public.trace_ins1(10000);
-- select public.trace_ins10(1000);
-- select public.trace_ins100(100);
-- 
-- select public.temp2_ins1(10000);
-- select public.temp2_ins10(100000);
-- 
-- select public.sum_ins(10000);
-- select public.sum_ins10(1000);
-- select public.sum_ins100(10000);

declare
    v_start timestamp;
    v_end timestamp;
    v_src_data varchar(1000) := 'This section provides an overview of TOAST (The Oversized-Attribute Storage Technique). 이 섹션은 TOAST에 대한 개요이다.(Size초과 속성 저장 기술) PostgreSQL uses a fixed page size (commonly 8 kB), and does not allow tuples to span multiple pages. PostgreSQL은 보통 8kB인 고정 page를 사용하고, Row가 여러 페이지에 나누어지는 것을 허용하지 않는다. Therefore, it is not possible to store very large field values directly. 그러므로 매우 큰 field를 직접 저장할 수 없다. To overcome this limitation, large field values are compressed and/or broken up into multiple physical rows. 이러한 한계를 극복하기 위해서, field 값을 압축하고 여러 물리적 row에 나눈다. This happens transparently to the user, with only small impact on most of the backend code. 이것은 작은 영향으로 사용자에게는 알리지 않는다. 알리지 않는다는 의미는 사용자는 저정방식에 따라 SQL을 다르게 작성할 필요 없이 일반 SQL 그대로 사용하면된다는 것이다. The technique is affectionately known as TOAST (or the best thing since sliced bread';
    v_file_data varchar(40000);
begin
   v_start := clock_timestamp();
   v_file_data := v_src_data;
   for i in 1..38 loop
	v_file_data := v_file_data || v_src_data;
   end loop;
   for i in 1..cnt loop
        insert into TRACE ( EQP_MODULE_ID, EQP_DCP_ID, STATUS_CD, START_DTTS, END_DTTS, SAMPLE_COUNT, TRACE_FAULT_COUNT, TRACE_WARNING_COUNT, MSPC_FAULT_COUNT, ALARM_COUNT
            , FILE_DATA, LOT_ID,  SUBSTRATE_ID, PRODUCT_ID, RECIPE_ID, STEP_ID )
        values 
		( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	-- 10
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	-- 20
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	-- 30
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	-- 40
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	-- 50
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	-- 60
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	-- 70
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	-- 80
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	-- 90
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	   ,( i, lpad('D',100,'EQP_DCP_ID'), 'R', localtimestamp, localtimestamp+'1 day', 100, 10, 10, 10, 10, v_file_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
	-- 100
             ;
   end loop;
   v_end := clock_timestamp();
   return 'Success';   
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION public.trace_ins100(cnt integer) OWNER TO gpadmin;

SET search_path = s2wlog, pg_catalog;

--
-- Name: insert_wldtime(integer); Type: FUNCTION; Schema: s2wlog; Owner: gpadmin
--

CREATE FUNCTION insert_wldtime(iv_cnt integer) RETURNS void
    AS $$

--BGN : Use Case--------------------------------------------------------
-- SET SEARCH_PATH = s2wlog;
-- SELECT insert_wldtime(10);
--END : Use Case--------------------------------------------------------

DECLARE
	y INTEGER;

BEGIN
  y:=0;
  LOOP
    IF (y = iv_cnt) THEN 
      RETURN;
    ELSE
      y = y+1;
      INSERT INTO wldtime(time_key, dt, wk, mh, yr)
        VALUES(
            now(),
            EXTRACT(DAY   FROM clock_timestamp()),
            EXTRACT(WEEK  FROM clock_timestamp()),
            EXTRACT(MONTH FROM clock_timestamp()),
            EXTRACT(YEAR  FROM clock_timestamp())
        );
    END IF; 
  END LOOP;
  RETURN;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION s2wlog.insert_wldtime(iv_cnt integer) OWNER TO gpadmin;

SET search_path = sn2ro, pg_catalog;

--
-- Name: analyze(); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION "analyze"() RETURNS void
    AS $$
DECLARE
    result text := '';
    searchsql text := '';
    var_match text := '';

BEGIN
  searchsql := '

SELECT ''ANALYZE ''||nspname||''.''||relname||'';''                AS qry
  FROM pg_class
    INNER JOIN pg_namespace
    ON pg_namespace.oid          =  pg_class.relnamespace
    LEFT OUTER JOIN pg_partitions
    ON pg_partitions.schemaname  = pg_namespace.nspname   AND
       pg_partitions.tablename   = pg_class.relname
  WHERE pg_class.reltuples       =  0                       AND
        pg_class.relpages        =  0                     AND
        pg_class.relkind         =  ''r''                   AND
        pg_partitions.tablename  IS NULL                  AND
        pg_partitions.schemaname IS NULL
  ORDER BY 1
  LIMIT 1

                ';



    result := 'SUCCESS';

  FOR var_match IN EXECUTE(searchsql) LOOP
    begin
      EXECUTE var_match;
      EXCEPTION WHEN others THEN
        result := 'ERROR';
    end;
    EXECUTE 'INSERT INTO public.anal_list VALUES (' || '''' || var_match || ''',' || ''''',' || ''''')';    
  END LOOP;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro."analyze"() OWNER TO gpadmin;

--
-- Name: count_ao(character varying, character varying); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION count_ao(p_schema character varying, p_table character varying) RETURNS bigint
    AS $_$


--BGN : Usage Example---------------------------------------------------
--Testing with a simple AO ROW table on my laptop - 256M rows
--count_ao function returns the number of rows in sub second, while count(*) takes almost 50sec
--select sn2ro.count_ao('public','foo'); --839ms   , --256,000,000 rows
--select count(*) from public.foo;         --49789 ms, --256,000,000 rows
--END : Usage Example---------------------------------------------------

--BGN : Note-----------------------------------------------------------
-- Function assumes tables/child tables are all AO, otherwise an error is returned
-- Runtime depends on: 1) number of segments, 2) number of partitions (in case the input table is partitioned) --> the less, the faster, but in any case would always be faster than count(1|*) and wont scan the base data files
-- The function is defined with "security definer" clause so non-superusers can also execute the function
-- known issues: if there are catalog corruptions (ahmm…inconsistencies) then you might get wrong results, the issue exists in get_ao_distribution() itself
--END : Note------------------------------------------------------------

--BGN : Use Case--------------------------------------------------------
-- SET SEARCH_PATH = sn2ro;
-- SELECT insert_sn_tst_100byte(10);
--END : Use Case--------------------------------------------------------

DECLARE
    v_count_partitions INTEGER;
    v_rowcount DOUBLE PRECISION;
    v_full_tablename varchar := $1 ||'.'||$2 ;
BEGIN
--Partitioned tables
IF EXISTS (select 1 from pg_partitions p where schemaname=$1 and tablename=$2 limit 1) THEN
SELECT SUM(cnt) INTO v_rowcount FROM 
(SELECT schemaname,partitiontablename, (select sum(tupcount) from get_ao_distribution((schemaname|| '.' || partitiontablename)::regclass)) cnt 
FROM pg_partitions WHERE schemaname=$1 and tablename=$2) aa;
ELSE
--Single Child Partition/Non-Partitioned table
EXECUTE 'select sum(tupcount) from pg_catalog.get_ao_distribution (' || quote_literal(v_full_tablename) || '::regclass)'
INTO v_rowcount;
END IF;
    RETURN v_rowcount;
    
END;
$_$
    LANGUAGE plpgsql STABLE SECURITY DEFINER;


ALTER FUNCTION sn2ro.count_ao(p_schema character varying, p_table character varying) OWNER TO gpadmin;

--
-- Name: create_external_table(name, name); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION create_external_table(iv_nspname name, iv_relname name) RETURNS character varying
    AS $$

--BGN : Use Case--------------------------------------------------------
-- SET SEARCH_PATH = sn2ro;
-- SELECT create_external_table('sn2ro','sn_tst_partition');
--END : Use Case--------------------------------------------------------
DECLARE
  return_value VARCHAR;
  x            RECORD;
  y            INT;

BEGIN
  y            := 0                      ;
  return_value := 'CREATE EXTERNAL TABLE';

  FOR x IN
  SELECT
    a.attname                                        AS column
    ,pg_catalog.format_type(a.atttypid, a.atttypmod) AS datatype
  FROM pg_catalog.pg_attribute a
  WHERE
    a.attnum > 0
    AND NOT a.attisdropped
    AND a.attrelid = (
                     SELECT c.oid
                     FROM pg_catalog.pg_class c
                       LEFT JOIN pg_catalog.pg_namespace n
                       ON n.oid = c.relnamespace
                     WHERE
                       c.relname LIKE iv_relname
                       AND pg_catalog.pg_table_is_visible(c.oid)
                     )
  ORDER BY a.attnum
  LOOP
    y = y + 1;
    IF (y = 1) 
    THEN return_value := return_value 
                         || ' ' 
                         || quote_ident(iv_nspname) 
                         || '_ext.ext_' 
                         || quote_ident(iv_relname) 
                         || '(' 
                         || x.column
                         || ' ' 
                         || x.datatype
         ;
    ELSE return_value := return_value 
                         || ',' 
                         || x.column
                         || ' ' 
                         || x.datatype
         ;
    END IF;
  END LOOP;

  return_value := return_value 
                  || ')'
  ;
  
  return_value := return_value 
                  || ' LOCATION ' 
                  || '(''' 
                  || 'gpfdist://192.168.0.63:8080/' 
                  || quote_ident(iv_relname) 
                  || '.csv'
                  || ''')'
  ;
  
  return_value := return_value 
                  || ' FORMAT ''csv''' 
                  || ' (delimiter '','' null '''' escape ''"'' quote ''"'')'
  ;
  
  return_value := return_value 
--                  || ' ENCODING ''UTF8'''
                  || ' ENCODING ''UHC'''
  ;
  
  return_value := return_value 
                  || ' LOG ERRORS INTO '
                  || quote_ident(iv_nspname) 
                  || '_err.err_' 
                  || quote_ident(iv_relname) 
                  || ' SEGMENT REJECT LIMIT 1000 ROWS' 
  ;
  
  RETURN return_value;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.create_external_table(iv_nspname name, iv_relname name) OWNER TO gpadmin;

--
-- Name: create_external_table(name); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION create_external_table(iv_nspname name) RETURNS void
    AS $$

--BGN : Use Case--------------------------------------------------------
-- SET SEARCH_PATH = sn2ro;
-- SELECT create_external_table('sn2ro');
--END : Use Case--------------------------------------------------------
DECLARE
  return_value VARCHAR;
  x            RECORD;
  y            INT;

BEGIN
  y            := 0                      ;
  return_value := 'CREATE EXTERNAL TABLE';

  FOR x IN
  SELECT
    count(*) OVER (PARTITION BY pg_catalog.pg_namespace.nspname) AS sub
    ,count(*) OVER (PARTITION BY pg_catalog.pg_class.relkind) AS ALL
    ,pg_catalog.pg_namespace.nspname AS nspname
    ,pg_catalog.pg_class.relname AS relname
    ,CASE pg_catalog.pg_class.relkind
      WHEN 'r'
        THEN 'table'
      WHEN 'v'
        THEN 'view'
      WHEN 'i'
        THEN 'index'
      WHEN 'S'
        THEN 'sequence'
      WHEN 's'
        THEN 'special'
    END AS "TYPE"
    ,CASE pg_catalog.pg_class.relstorage
      WHEN 'h'
        THEN 'heap'
      WHEN 'a'
        THEN 'append only'
      WHEN 'v'
        THEN 'none'
      WHEN 'c'
        THEN 'append only columnar'
      WHEN 'x'
        THEN 'external'
    END AS "Storage"
    ,pg_catalog.pg_user.usename AS "OWNER"

  FROM pg_catalog.pg_class
  INNER JOIN pg_catalog.pg_namespace ON pg_catalog.pg_namespace.oid = pg_catalog.pg_class.relnamespace
  LEFT JOIN pg_catalog.pg_user ON pg_catalog.pg_user.usesysid = pg_catalog.pg_class.relowner
  WHERE
    pg_catalog.pg_class.relkind IN ('r')
    AND pg_catalog.pg_class.oid NOT IN (
      SELECT parchildrelid
      FROM pg_partition_rule
      )
    AND
    --      pg_catalog.pg_namespace.nspname NOT IN ('pg_catalog', 'pg_toast', 'information_schema', 'bibizindex') AND
    pg_catalog.pg_namespace.nspname = iv_nspname
    AND pg_catalog.pg_class.relstorage NOT IN ('x') 
    -- AND pg_catalog.pg_table_is_visible(pg_catalog.pg_class.oid)
  ORDER BY 3
           ,4
           ,5
  LOOP
    return_value := create_external_table(quote_ident(iv_nspname),quote_ident(x.relname));
    EXECUTE return_value;
  END LOOP;
  RETURN;
END
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.create_external_table(iv_nspname name) OWNER TO gpadmin;

--
-- Name: dba_partition_last(name, name, name); Type: FUNCTION; Schema: sn2ro; Owner: lr_dba
--

CREATE FUNCTION dba_partition_last(iv_dbname name, iv_nspname name, iv_relname name, OUT ev_subrc integer, OUT columnname name, OUT data_type character varying, OUT character_maximum_length integer, OUT partitionboundary text, OUT partitiontablename name, OUT partitionname name, OUT partitionrank integer) RETURNS record
    AS $$
--SRT : Use Case--------------------------------------------------------
-- SELECT * FROM sn2ro.dba_partition_last('pil', 'sn2ro','sn_tst_partition');
--END : Use Case--------------------------------------------------------
DECLARE
  lv_prangestart text        := '';  --Partition Start Date
  lv_prangeend   text        := '';  --Partition End Date 
  ls_record      record           ;  --Recort of Result in SELECT
BEGIN
  ev_subrc = 0;
--SRT : Get Last Partition----------------------------------------------
  SELECT
           pg_partition_columns.columnname                     ,
           information_schema.columns.data_type                ,
           information_schema.columns.character_maximum_length ,
           pg_partitions.partitionboundary                     ,
           pg_partitions.partitiontablename                    ,
           pg_partitions.partitionname                         ,
           pg_partitions.partitionrank                         
    INTO ls_record
    FROM pg_partition_columns
      INNER JOIN pg_partitions
      ON pg_partitions.schemaname                       = pg_partition_columns.schemaname AND
         pg_partitions.tablename                        = pg_partition_columns.tablename  AND
         pg_partitions.partitiontype                    = 'range'                         AND
         pg_partitions.partitionisdefault               = 'f'
      INNER JOIN information_schema.columns            
      ON information_schema.columns.table_catalog       = iv_dbname                       AND
         information_schema.columns.table_schema        = pg_partition_columns.schemaname AND
         information_schema.columns.table_name          = pg_partition_columns.tablename  AND
         information_schema.columns.column_name         = pg_partition_columns.columnname
   WHERE pg_partition_columns.schemaname                = iv_nspname                      AND
         pg_partition_columns.tablename                 = iv_relname                      AND
         pg_partition_columns.partitionlevel            = 0                               AND
         pg_partition_columns.position_in_partition_key = 1
    ORDER BY pg_partitions.partitionrank DESC
    LIMIT 1;
 
  IF NOT FOUND THEN
    ev_subrc = 8;
    RETURN;
  END IF;
  columnname               := ls_record.columnname;
  data_type                := ls_record.data_type;
  character_maximum_length := ls_record.character_maximum_length;
  partitionboundary        := ls_record.partitionboundary;
  partitiontablename       := ls_record.partitiontablename;
  partitionname            := ls_record.partitionname;
  partitionrank            := ls_record.partitionrank;
--END : Get Last Partition----------------------------------------------
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.dba_partition_last(iv_dbname name, iv_nspname name, iv_relname name, OUT ev_subrc integer, OUT columnname name, OUT data_type character varying, OUT character_maximum_length integer, OUT partitionboundary text, OUT partitiontablename name, OUT partitionname name, OUT partitionrank integer) OWNER TO lr_dba;

--
-- Name: dba_partition_log(integer, timestamp without time zone, name, name, name, text, name); Type: FUNCTION; Schema: sn2ro; Owner: lr_dba
--

CREATE FUNCTION dba_partition_log(iv_logno integer, iv_bgntm timestamp without time zone, iv_nspname name, iv_relname name, iv_result name, iv_message text, iv_pname name) RETURNS void
    AS $$
--BGN : Use Case--------------------------------------------------------
-- SELECT sn2ro.dba_partition_log('log number', 'begin time', 'sn2ro', 'sn_tst_partition', 'E', 'Log Message', 'Partition Name')
--END : Use Case--------------------------------------------------------
DECLARE
  lv_endtm             timestamp           ;
  lv_duration          double precision    ;
  lv_bgndt_varchar     varchar(8)          ;
BEGIN
--SRT : Logging---------------------------------------------------------
  lv_endtm    := clock_timestamp();   -- End Time
  lv_duration := (extract(epoch from (lv_endtm - iv_bgntm))) * 1000;    -- Duration in seconds
  SELECT to_char(iv_bgntm, 'YYYYMMDD') INTO lv_bgndt_varchar;  -- Begin Date with varchar type
  EXECUTE 'INSERT INTO sn2ro.dba_partition_log VALUES ('
          || iv_logno
          || ', '
          || quote_literal(iv_bgntm)  
          || ', '
          || quote_literal(iv_nspname)
          || ', '
          || quote_literal(iv_relname)
          || ', '
          || quote_literal(iv_result)
          || ', '
          || quote_literal(iv_message)
          || ', '
          || quote_literal(iv_pname)
          || ', '
          || quote_literal(lv_endtm)
          || ', '
          || quote_literal(lv_duration)
          || ', '
          || quote_literal(lv_bgndt_varchar)
          || ')'
  ;
  RETURN;       
--END : Logging---------------------------------------------------------

END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.dba_partition_log(iv_logno integer, iv_bgntm timestamp without time zone, iv_nspname name, iv_relname name, iv_result name, iv_message text, iv_pname name) OWNER TO lr_dba;

--
-- Name: dba_partition_month(name, name, name); Type: FUNCTION; Schema: sn2ro; Owner: lr_dba
--

CREATE FUNCTION dba_partition_month(iv_dbname name, iv_nspname name, iv_relname name) RETURNS void
    AS $$
--BGN : Use Case--------------------------------------------------------
-- SELECT sn2ro.dba_partition_month('pil', 'sn2ro','sn_tst_partition');
--END : Use Case--------------------------------------------------------
DECLARE

  ls_record_prev          record               ; --Recort of Result in SELECT
  ls_record_last          record               ; --Recort of Result in SELECT
  ls_record_reloptions    record               ; --Recort of Result in SELECT
                                              
  lv_idx_for_searching_old_partition integer   ; --파티션 옵션을 바꿀 대상을 찾기 위하여 사용하는 숫자값
                                              
  lv_partition_column     name           := '' ; --Partition Column
  lv_data_type            varchar(30)    := '' ; --Data Type
  lv_character_maximum_length integer    := 0  ; --Length
                                              
  lv_prangestart_new      text           := '' ; --New Partition Start Date
  lv_prangeend_new        text           := '' ; --New Partition End Date
  lv_pname_new            name           := '' ; --New Partition Name
  lv_partitionrank_new    integer        := 0  ; --New Partition Rank
                                              
  lv_prangestart_old      text           := '' ; --Old Partition Start Date
  lv_prangeend_old        text           := '' ; --Old Partition End Date  
  lv_pname_old            name           := '' ; --Old Partition Name      
  lv_partitionrank_old    integer              ; --Old Partition Rank      
                                              
  lv_appendonlytext       text           := '' ; --appendonly
  lv_compressleveltext    text           := '' ; --compresslevel
  lv_orientationtext      text           := '' ; --orientatioin
  lv_m_default_retention  integer        := 0  ; --appendonly가 아니고 압축하지 않으며 row 베이스로 유지되는 최종 파티션 갯수
                                              
  lv_yyyymm               varchar(6)     := '' ; --For Month Value Handling
  lv_yyyymmdd             varchar(8)     := '' ; --For Date Value Handling
                                    
-- For Logging                                     
  lc_logno                integer        := 0  ; --Partition Log Number
  lc_bgntm                timestamp            ;
  lc_success              char(1)        := 'S';
  lc_error                char(1)        := 'E';
  lv_message              text           := '' ;
  lc_message_success      text           := 'safely partitioned' ;

BEGIN
------------------------------------------------------------------------
-- Work for Monthly Level Partitioning
------------------------------------------------------------------------
--BGN : Constant Setting since when this function has started----------------
  lc_logno := nextval('sn2ro.dba_partition_lognr_seq');
  lc_bgntm := clock_timestamp();   -- Begin Time
--END : Constant Setting since when this function has started----------------

  IF lv_pname_new IS NULL OR lv_pname_new = '' OR lv_pname_new = ' ' THEN
    lv_pname_new := 'n/a';
  END IF;

--BGN : Get RELOPTIONS--------------------------------------------------
  SELECT * INTO ls_record_reloptions FROM sn2ro.dba_partition_reloptions(iv_nspname,iv_relname);
-- Exception Handling
  IF ls_record_reloptions.ev_subrc <> 0 THEN
    lv_message = 'there is no reloptions. check the table sn2ro.dba_partition_config !';
    PERFORM sn2ro.dba_partition_log(lc_logno,lc_bgntm,iv_nspname,iv_relname,lc_error,lv_message,lv_pname_new);
    RETURN;
  END IF;
 
-- RELOPTIONS
  lv_appendonlytext      := 'appendonly=' || ls_record_reloptions.ev_appendonlytext;      --appendonly option
  lv_compressleveltext   := 'compresslevel=' || ls_record_reloptions.ev_compressleveltext;   --compresslevel option
  lv_orientationtext     := 'orientation=' || ls_record_reloptions.ev_orientationtext;     --orientation option
  lv_m_default_retention := ls_record_reloptions.ev_m_default_retention; --appendonly가 아니고 압축하지 않으며 row 베이스로 유지되는 최종 파티션 갯수

-- 파티션 옵션이 바뀌어야 하는 대상을 찾기 위하여 사용되는 Index
  lv_idx_for_searching_old_partition := lv_m_default_retention - 1; 
--END : Get RELOPTIONS--------------------------------------------------

--BGN : Select the old partition----------------------------------------
-- Get the old partition info
  SELECT *
     INTO ls_record_prev
     FROM sn2ro.dba_partition_prev(iv_dbname, iv_nspname, iv_relname, lv_idx_for_searching_old_partition);
  IF ls_record_prev.ev_subrc = 0 THEN
    lv_yyyymm          := substring(ls_record_prev.partitionname,2,8)::varchar(6);
    lv_yyyymmdd        := lv_yyyymm || '01';
    lv_prangestart_old := to_char((lv_yyyymmdd::date                       ),'YYYYMMDD');
    lv_prangeend_old   := to_char((lv_yyyymmdd::date + '1 months'::interval),'YYYYMMDD');
    lv_pname_old       := 'p' || substring(lv_prangestart_old,1,7)::varchar(6);
  END IF;
--END : Select the old partition----------------------------------------

--BGN : Get info for new partition--------------------------------------
  SELECT *
     INTO ls_record_last
     FROM sn2ro.dba_partition_last(iv_dbname, iv_nspname, iv_relname);
  IF ls_record_last.ev_subrc <> 0 THEN
    lv_message = 'this is not a partitioned table !';
    PERFORM sn2ro.dba_partition_log(lc_logno,lc_bgntm,iv_nspname,iv_relname,lc_error,lv_message,lv_pname_new);
    RETURN;
  END IF;
  lv_partition_column         := ls_record_last.columnname;
  lv_data_type                := ls_record_last.data_type;
  lv_character_maximum_length := ls_record_last.character_maximum_length;

  lv_yyyymm          := substring(ls_record_last.partitionname,2,8)::varchar(6);
  lv_yyyymmdd        := lv_yyyymm || '01';
  lv_prangestart_new := to_char((lv_yyyymmdd::date + '1 months'::interval),'YYYYMMDD');
  lv_prangeend_new   := to_char((lv_yyyymmdd::date + '2 months'::interval),'YYYYMMDD');
  lv_pname_new       := 'p' || substring(lv_prangestart_new,1,7)::varchar(6);

--For Case of YYYYMM Character Type
  IF lv_data_type = 'character' OR
     lv_data_type = 'character varying' THEN
    IF lv_character_maximum_length = 6 THEN
      lv_prangestart_old = substring(lv_prangestart_old,1,7)::varchar(6);
      lv_prangeend_old   = substring(lv_prangeend_old,1,7)::varchar(6);

      lv_prangestart_new = substring(lv_prangestart_new,1,7)::varchar(6);
      lv_prangeend_new   = substring(lv_prangeend_new,1,7)::varchar(6);
    END IF; 
  END IF;

--END : of Get info for new partition-----------------------------------

--BGN : SPLIT of DEFAULT PARTITION with NEW PARTITION-------------------
  BEGIN
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' SPLIT DEFAULT PARTITION '
            ||' START ('
            || quote_literal(lv_prangestart_new) 
            ||') INCLUSIVE END ('
            || quote_literal(lv_prangeend_new)
            ||') EXCLUSIVE INTO (PARTITION '
            || quote_ident(lv_pname_new)
            || ', DEFAULT PARTITION);'
    ;

-- Exception Handling
  EXCEPTION WHEN others THEN     -- EXCEPTION HANDLING
--{ Logging Process
    lv_message := sqlerrm;
    PERFORM sn2ro.dba_partition_log(lc_logno,lc_bgntm,iv_nspname,iv_relname,lc_error,lv_message,lv_pname_new);
    RETURN;
--} Logging Process
  END;
--END : SPLIT of DEFAULT PARTITION with NEW PARTITION-------------------

  IF ls_record_prev.ev_subrc <> 0 THEN
--{ Logging Process
    lv_message := lc_message_success;
    PERFORM sn2ro.dba_partition_log(lc_logno,lc_bgntm,iv_nspname,iv_relname,lc_success,lv_message,lv_pname_new);
    RETURN;
--} Logging Process
  END IF;
  BEGIN
--BGN : Securing Partition Table Data-----------------------------------
-- Drop Temp Table
    EXECUTE 'DROP TABLE IF EXISTS '
            || quote_ident(iv_nspname)
            ||'.'
            ||'tmp_'
            || quote_ident(iv_relname)
            ||'_1_prt_'
            || quote_ident(lv_pname_old)
            ||';'
      ;

-- Create Temp Table

    IF lv_appendonlytext = 'appendonly=false' THEN
      EXECUTE 'CREATE TABLE '
              || quote_ident(iv_nspname)
              ||'.'
              ||'tmp_'
              || quote_ident(iv_relname)
              ||'_1_prt_'
              || quote_ident(lv_pname_old)
              ||' (LIKE '
              || quote_ident(iv_nspname)
              ||'.'
              || quote_ident(iv_relname)
              ||')'
              ||' WITH ('
              || lv_appendonlytext
              ||')'
              ||';'
      ;
    ELSE
      EXECUTE 'CREATE TABLE '
              || quote_ident(iv_nspname)
              ||'.'
              ||'tmp_'
              || quote_ident(iv_relname)
              ||'_1_prt_'
              || quote_ident(lv_pname_old)
              ||' (LIKE '
              || quote_ident(iv_nspname)
              ||'.'
              || quote_ident(iv_relname)
              ||')'
              ||' WITH ('
              || lv_appendonlytext
              ||','
              || lv_compressleveltext
              ||','
              || lv_orientationtext
              ||')'
              ||';'
      ;
    END IF; 


-- Authorization Adjust
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            ||'tmp_'
            || quote_ident(iv_relname)
            ||'_1_prt_'
            || quote_ident(lv_pname_old)
            ||' OWNER TO lr_dba;'
    ;

-- DATA TRANSFER FROM PARTITION TO TMP_PARTITION TABLE
    EXECUTE 'INSERT INTO '
            || quote_ident(iv_nspname)
            ||'.'
            ||'tmp_'
            || quote_ident(iv_relname)
            ||'_1_prt_'
            || quote_ident(lv_pname_old)
            ||' SELECT * FROM '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||'_1_prt_'
            || quote_ident(lv_pname_old)
            ||';'
    ;

--END: Securing Partition Table Data------------------------------------

--BGN: EXCHANGE PARTITION-----------------------------------------------
-- Exchange an old partition with a temporary table
    EXECUTE 'ALTER TABLE '
              || quote_ident(iv_nspname)
              ||'.'
              || quote_ident(iv_relname)
              ||' EXCHANGE PARTITION FOR ('
              || quote_literal(lv_prangestart_old)
              || ') '  
              ||'WITH TABLE '
              || quote_ident(iv_nspname)
              ||'.'
              ||'tmp_'
              || quote_ident(iv_relname)
              ||'_1_prt_'
              || quote_ident(lv_pname_old)
              ||';'
    ;
-- ALTER TABLE sn2ro.sn_tst_partition
--   EXCHANGE PARTITION FOR ('20050601')
--   WITH TABLE sn2ro.tmp_sn_tst_partition_1_prt_p201106;
--END: EXCHANGE PARTITION-----------------------------------------------

-- Exception Handling
  EXCEPTION WHEN others THEN     -- EXCEPTION HANDLING
--{ Logging Process
    lv_message := sqlerrm;
    PERFORM sn2ro.dba_partition_log(lc_logno,lc_bgntm,iv_nspname,iv_relname,lc_error,lv_message,lv_pname_new);
    RETURN;
--} Logging Process
  END;

--{ Logging Process
  lv_message := lc_message_success;
  PERFORM sn2ro.dba_partition_log(lc_logno,lc_bgntm,iv_nspname,iv_relname,lc_success,lv_message,lv_pname_new);
  RETURN;
--} Logging Process
 
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.dba_partition_month(iv_dbname name, iv_nspname name, iv_relname name) OWNER TO lr_dba;

--
-- Name: dba_partition_prev(name, name, name, integer); Type: FUNCTION; Schema: sn2ro; Owner: lr_dba
--

CREATE FUNCTION dba_partition_prev(iv_dbname name, iv_nspname name, iv_relname name, iv_left integer, OUT ev_subrc integer, OUT columnname name, OUT partitionboundary text, OUT partitiontablename name, OUT partitionname name, OUT partitionrank integer) RETURNS record
    AS $$
--SRT : Use Case--------------------------------------------------------
-- SELECT * FROM sn2ro.dba_partition_prev('pil', 'sn2ro','sn_tst_partition',2);
--END : Use Case--------------------------------------------------------
DECLARE
  lv_prangestart    text       := '';  --Partition Start Date
  lv_prangeend      text       := '';  --Partition End Date
  lv_partitionrank  integer         ;  --Partition Rank
  ls_record_last    record          ;  --Record of Result in SELECT
  ls_record_prev    record          ;  --Record of Result in SELECT
BEGIN
  ev_subrc = 0;
--SRT : Get Last Partition----------------------------------------------
  SELECT *
    INTO ls_record_last
    FROM sn2ro.dba_partition_last(iv_dbname, iv_nspname, iv_relname);
  lv_partitionrank   := ls_record_last.partitionrank;

  IF lv_partitionrank > iv_left THEN
    lv_partitionrank := lv_partitionrank - iv_left;
  ELSE
    ev_subrc = 8;
    RETURN;
  END IF; 

  SELECT
         pg_partition_columns.columnname,
         pg_partitions.partitionboundary,
         pg_partitions.partitiontablename,
         pg_partitions.partitionname,
         pg_partitions.partitionrank
    INTO ls_record_prev
    FROM pg_partition_columns
      INNER JOIN pg_partitions
      ON pg_partitions.schemaname                        = pg_partition_columns.schemaname AND
         pg_partitions.tablename                         = pg_partition_columns.tablename  AND
         pg_partitions.partitiontype                     = 'range'                         AND
         pg_partitions.partitionisdefault                = 'f'
    WHERE pg_partition_columns.schemaname                = iv_nspname                      AND
          pg_partition_columns.tablename                 = iv_relname                      AND
          pg_partition_columns.partitionlevel            = 0                               AND
          pg_partition_columns.position_in_partition_key = 1                               AND
          pg_partitions.partitionrank = lv_partitionrank;
  IF not found THEN ev_subrc = 8; END IF;       

  columnname         := ls_record_prev.columnname;
  partitionboundary  := ls_record_prev.partitionboundary;
  partitiontablename := ls_record_prev.partitiontablename;
  partitionname      := ls_record_prev.partitionname;
  partitionrank      := ls_record_prev.partitionrank;
--END : Get Last Partition----------------------------------------------
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.dba_partition_prev(iv_dbname name, iv_nspname name, iv_relname name, iv_left integer, OUT ev_subrc integer, OUT columnname name, OUT partitionboundary text, OUT partitiontablename name, OUT partitionname name, OUT partitionrank integer) OWNER TO lr_dba;

--
-- Name: dba_partition_reloptions(name, name); Type: FUNCTION; Schema: sn2ro; Owner: lr_dba
--

CREATE FUNCTION dba_partition_reloptions(iv_nspname name, iv_relname name, OUT ev_subrc integer, OUT ev_appendonlytext text, OUT ev_compressleveltext text, OUT ev_orientationtext text, OUT ev_m_default_retention integer) RETURNS record
    AS $$
--SRT : Use Case--------------------------------------------------------
-- SELECT sn2ro.dba_partition_reloptions('sn2ro','sn_tst_partition');
--END : Use Case--------------------------------------------------------
DECLARE
  lv_sqlrecord         record         ;  --Recort of Result in SELECT
BEGIN
  ev_subrc = 0;
--SRT : Get RELOPTIONS--------------------------------------------------
  SELECT
         sn2ro.dba_partition_config.schemaname          AS schemaname,
         sn2ro.dba_partition_config.tablename           AS tablename,
         sn2ro.dba_partition_config.appendonlytext      AS appendonlytext,
         sn2ro.dba_partition_config.compressleveltext   AS compressleveltext,
         sn2ro.dba_partition_config.orientationtext     AS orientationtext,
         sn2ro.dba_partition_config.m_default_retention AS m_default_retention
    INTO lv_sqlrecord
    FROM sn2ro.dba_partition_config
    WHERE sn2ro.dba_partition_config.schemaname = iv_nspname AND
          sn2ro.dba_partition_config.tablename  = iv_relname;
  IF found THEN 
    ev_appendonlytext      := lv_sqlrecord.appendonlytext;
    ev_compressleveltext   := lv_sqlrecord.compressleveltext;
    ev_orientationtext     := lv_sqlrecord.orientationtext;
    ev_m_default_retention := lv_sqlrecord.m_default_retention;
  ELSE
    ev_subrc = 8;
  END IF;
--END : Get RELOPTIONS--------------------------------------------------
END;
$$
    LANGUAGE plpgsql IMMUTABLE;


ALTER FUNCTION sn2ro.dba_partition_reloptions(iv_nspname name, iv_relname name, OUT ev_subrc integer, OUT ev_appendonlytext text, OUT ev_compressleveltext text, OUT ev_orientationtext text, OUT ev_m_default_retention integer) OWNER TO lr_dba;

--
-- Name: dba_partition_year(name, name, character varying); Type: FUNCTION; Schema: sn2ro; Owner: lr_dba
--

CREATE FUNCTION dba_partition_year(iv_nspname name, iv_relname name, iv_yyyy character varying) RETURNS void
    AS $$
--BGN : Use Case--------------------------------------------------------
-- SELECT sn2ro.dba_partition_year('sn2ro','sn_tst_partition','2002');
--END : Use Case--------------------------------------------------------
DECLARE
  lv_partition_column  name           := '';
  lv_data_type         varchar(30)    := '';
  lv_character_maximum_length integer      ;

  lv_appendonlytext    text           := ''; --appendonly text
  lv_compressleveltext text           := ''; --compresslevel text
  lv_orientationtext   text           := ''; --orientation text
 

  lv_subrc             integer             ;  --Return Value ( 0 is OK )
  lv_prangestart_new   text           := '';  --New Partition Start Date
  lv_prangeend_new     text           := '';  --New Partition End Date
  lv_pname_new         name           := '';  --New Partition Name
  lv_partitionrank_new integer             ;  --New Partition Rank
                                     
  lv_prangestart_old   text           := '';  --Old Partition Start Date
  lv_prangeend_old     text           := '';  --Old Partition End Date  
  lv_pname_old         name           := '';  --Old Partition Name      
  lv_partitionrank_old integer             ;  --Old Partition Rank      
                                          
  ls_record_old        record              ;  --Recort of Result in SELECT
  ls_record_new        record              ;  --Recort of Result in SELECT
  ls_record_reloptions record              ;  --Recort of Result in SELECT
  ls_record_last       record              ;  --Recort of Result in SELECT
                                          
                                          
  lv_yyyymm            varchar(6) :=''     ;  --For Month Value Handling
  lv_yyyymmdd          varchar(8) :=''     ;  --For Date Value Handling

-- For Logging                                     
  lc_logno                integer        := 0  ; --Partition Log Number
  lc_bgntm                timestamp            ;
  lc_success              char(1)        := 'S';
  lc_error                char(1)        := 'E';
  lv_message              text           := '' ;
  lc_message_success      text           := 'safely partitioned' ;

  lv_sqlset            record              ;
  lv_endtm             timestamp           ;
  lv_bgndt_varchar     varchar(8)          ;
  lv_relname           text                ;
  lv_lines             integer             ;
BEGIN
------------------------------------------------------------------------
-- Yearly Level Partitioning
------------------------------------------------------------------------
--BGN : Constant Setting since when this function has started-----------
  lc_logno := nextval('sn2ro.dba_partition_lognr_seq');
  lc_bgntm := clock_timestamp();   -- Begin Time
--END : Constant Setting since when this function has started-----------

--BGN : Securing Partition Table Data-----------------------------------
  lv_yyyymmdd        := iv_yyyy || '01' || '01';
  lv_pname_new       := 'p' || substring(iv_yyyy,1,5)::varchar(4);

  lv_prangestart_new := to_char((lv_yyyymmdd::date                      ),'YYYYMMDD');
  lv_prangeend_new   := to_char((lv_yyyymmdd::date + '1 years'::interval),'YYYYMMDD');


--BGN : Get RELOPTIONS--------------------------------------------------
  SELECT * INTO ls_record_reloptions FROM dba.partition_reloptions(iv_nspname,iv_relname);
-- Exception Handling
  IF ls_record_reloptions.ev_subrc <> 0 THEN
--{ Logging Process
    lv_message = 'there is no reloptions. check the table dba.partition_config !';
    PERFORM sn2ro.dba_partition_log(lc_logno,lc_bgntm,iv_nspname,iv_relname,lc_error,lv_message,lv_pname_new);
    RETURN;
--} Logging Process
  END IF;
 
-- RELOPTIONS
  lv_appendonlytext      := ls_record_reloptions.ev_appendonlytext;      --appendonly option
  lv_compressleveltext   := ls_record_reloptions.ev_compressleveltext;   --compresslevel option
  lv_orientationtext     := ls_record_reloptions.ev_orientationtext;     --orientation option
--  lv_m_default_retention := ls_record_reloptions.ev_m_default_retention; --appendonly가 아니고 압축하지 않으며 row 베이스로 유지되는 최종 파티션 갯수

--END : Get RELOPTIONS--------------------------------------------------
--
  SELECT *
     INTO ls_record_last
     FROM dba.partition_last(iv_nspname, iv_relname);
  IF ls_record_last.ev_subrc <> 0 THEN
--{ Logging Process
    lv_message = 'this is not a partitioned table !';
    PERFORM sn2ro.dba_partition_log(lc_logno,lc_bgntm,iv_nspname,iv_relname,lc_error,lv_message,lv_pname_new);
    RETURN;
--} Logging Process
  END IF;

  lv_partition_column         := ls_record_last.columnname;
  lv_data_type                := ls_record_last.data_type;
  lv_character_maximum_length := ls_record_last.character_maximum_length;

--For Case of YYYYMM Character Type
  IF lv_data_type = 'character' OR
     lv_data_type = 'character varying' THEN
    IF lv_character_maximum_length = 6 THEN
      lv_prangestart_new = substring(lv_prangestart_new,1,7)::varchar(6);
      lv_prangeend_new   = substring(lv_prangeend_new,1,7)::varchar(6);
    END IF; 
  END IF;


-- Drop Temp Table
  BEGIN
    EXECUTE 'DROP TABLE IF EXISTS '
            || quote_ident(iv_nspname)
            ||'.'
            ||'tmp_'
            || quote_ident(iv_relname)
            ||'_1_prt_'
            || quote_ident(lv_pname_new)
            ||';'
    ;

-- Create Temp Table
    IF lv_appendonlytext = 'appendonly=false' THEN
      EXECUTE 'CREATE TABLE '
              || quote_ident(iv_nspname)
              ||'.'
              ||'tmp_'
              || quote_ident(iv_relname)
              ||'_1_prt_'
              || quote_ident(lv_pname_new)
              ||' (LIKE '
              || quote_ident(iv_nspname)
              ||'.'
              || quote_ident(iv_relname)
              ||')'
              ||' WITH ('
              || lv_appendonlytext
              ||')'
              ||';'
      ;
    ELSE
      EXECUTE 'CREATE TABLE '
              || quote_ident(iv_nspname)
              ||'.'
              ||'tmp_'
              || quote_ident(iv_relname)
              ||'_1_prt_'
              || quote_ident(lv_pname_new)
              ||' (LIKE '
              || quote_ident(iv_nspname)
              ||'.'
              || quote_ident(iv_relname)
              ||')'
              ||' WITH ('
              || lv_appendonlytext
              ||','
              || lv_compressleveltext
              ||','
              || lv_orientationtext
              ||')'
              ||';'
      ;
    END IF;
-- Authorization Adjust
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            ||'tmp_'
            || quote_ident(iv_relname)
            ||'_1_prt_'
            || quote_ident(lv_pname_new)
            ||' OWNER TO lr_dba;'
    ;

-- DATA TRANSFER FROM PARTITION TO TMP_PARTITION TABLE
    EXECUTE 'INSERT INTO '
          || quote_ident(iv_nspname)
          ||'.'
          ||'tmp_'
          || quote_ident(iv_relname)
          ||'_1_prt_'
          || quote_ident(lv_pname_new)
          ||' SELECT * FROM '
          || quote_ident(iv_nspname)
          ||'.'
          || quote_ident(iv_relname)
          ||' WHERE '
          || quote_ident(lv_partition_column)
          ||'>='
          || quote_literal(lv_prangestart_new)
          ||' AND '
          || quote_ident(lv_partition_column)
          ||'<'
          || quote_literal(lv_prangeend_new)
          ||';'
    ;
--END: Securing Partition Table Data------------------------------------

--BGN : PARTITIONI DROP-------------------------------------------------
    lv_pname_old       := lv_pname_new || '01';
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' DROP PARTITION IF EXISTS '
            || quote_ident(lv_pname_old)
            ||';'
    ;
    lv_pname_old       := lv_pname_new || '02';
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' DROP PARTITION IF EXISTS '
            || quote_ident(lv_pname_old)
            ||';'
    ;
    lv_pname_old       := lv_pname_new || '03';
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' DROP PARTITION IF EXISTS '
            || quote_ident(lv_pname_old)
            ||';'
    ;
    lv_pname_old       := lv_pname_new || '04';
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' DROP PARTITION IF EXISTS '
            || quote_ident(lv_pname_old)
            ||';'
    ;
    lv_pname_old       := lv_pname_new || '05';
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' DROP PARTITION IF EXISTS '
            || quote_ident(lv_pname_old)
            ||';'
    ;
    lv_pname_old       := lv_pname_new || '06';
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' DROP PARTITION IF EXISTS '
            || quote_ident(lv_pname_old)
            ||';'
    ;
    lv_pname_old       := lv_pname_new || '07';
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' DROP PARTITION IF EXISTS '
            || quote_ident(lv_pname_old)
            ||';'
    ;
    lv_pname_old       := lv_pname_new || '08';
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' DROP PARTITION IF EXISTS '
            || quote_ident(lv_pname_old)
            ||';'
    ;
    lv_pname_old       := lv_pname_new || '09';
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' DROP PARTITION IF EXISTS '
            || quote_ident(lv_pname_old)
            ||';'
    ;
    lv_pname_old       := lv_pname_new || '10';
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' DROP PARTITION IF EXISTS '
            || quote_ident(lv_pname_old)
            ||';'
    ;
    lv_pname_old       := lv_pname_new || '11';
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' DROP PARTITION IF EXISTS '
            || quote_ident(lv_pname_old)
            ||';'
    ;
    lv_pname_old       := lv_pname_new || '12';
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' DROP PARTITION IF EXISTS '
            || quote_ident(lv_pname_old)
            ||';'
    ;
   
--END : PARTITIONI DROP-------------------------------------------------

--BGN : SPLIT of DEFAULT PARTITION with NEW PARTITION-------------------
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' SPLIT DEFAULT PARTITION '
            ||' START ('
            || quote_literal(lv_prangestart_new) 
            ||') INCLUSIVE END ('
            || quote_literal(lv_prangeend_new)
            ||') EXCLUSIVE INTO (PARTITION '
            || quote_ident(lv_pname_new)
            || ', DEFAULT PARTITION);'
    ;
--END : SPLIT of DEFAULT PARTITION with NEW PARTITION-------------------

--BGN: EXCHANGE PARTITION-----------------------------------------------
-- Exchange an old partition with a temporary table
    EXECUTE 'ALTER TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            || quote_ident(iv_relname)
            ||' EXCHANGE PARTITION FOR ('
            || quote_literal(lv_prangestart_new)
            || ') '  
            ||'WITH TABLE '
            || quote_ident(iv_nspname)
            ||'.'
            ||'tmp_'
            || quote_ident(iv_relname)
            ||'_1_prt_'
            || quote_ident(lv_pname_new)
            ||';'
    ;

--END: EXCHANGE PARTITION-----------------------------------------------
-- Exception Handling
  EXCEPTION WHEN others THEN     -- EXCEPTION HANDLING
--{ Logging Process
    lv_message := sqlerrm;
    PERFORM sn2ro.dba_partition_log(lc_logno,lc_bgntm,iv_nspname,iv_relname,lc_error,lv_message,lv_pname_new);
    RETURN;
--} Logging Process
  END;

--{ Logging Process
  lv_message := lc_message_success;
  PERFORM sn2ro.dba_partition_log(lc_logno,lc_bgntm,iv_nspname,iv_relname,lc_success,lv_message,lv_pname_new);
  RETURN;
--} Logging Process

END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.dba_partition_year(iv_nspname name, iv_relname name, iv_yyyy character varying) OWNER TO lr_dba;

--
-- Name: f_graph(); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION f_graph() RETURNS text
    AS $$ 

#BGN : Use Case--------------------------------------------------------
# SET SEARCH_PATH = sn2ro;
# SELECT f_graph();
#END : Use Case--------------------------------------------------------

sql <- paste("SELECT x,y FROM temp ORDER BY x,y", sep="")
str <- pg.spi.exec(sql)
#str <- pg.spi.exec("SELECT x,y FROM temp ORDER BY x,y")

pdf("/fileserver/tmp/myplot.pdf"); 
plot(str,type="l",main="Graphics Demonstration",sub="Line Graph"); 
dev.off(); 
print("done"); 
$$
    LANGUAGE plr;


ALTER FUNCTION sn2ro.f_graph() OWNER TO gpadmin;

--
-- Name: f_k1(); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION f_k1() RETURNS text
    AS $_$ 

#BGN : Use Case--------------------------------------------------------
# SET SEARCH_PATH = sn2ro;
# SELECT f_k1();
#END : Use Case--------------------------------------------------------

x <- rbind(matrix(rnorm(100, sd = 0.3), ncol = 2), matrix(rnorm(100, mean = 1, sd = 0.3), ncol = 2))
colnames(x) <- c("x", "y")
#plot(x)

(cl <- kmeans(x, 2, nstart = 25))
pdf("/fileserver/tmp/myplot.pdf"); 
plot(x, col = cl$cluster)
points(cl$centers, col = 1:2, pch = 8, cex=2)
dev.off(); 
print("done"); 

$_$
    LANGUAGE plr;


ALTER FUNCTION sn2ro.f_k1() OWNER TO gpadmin;

--
-- Name: get_column_names(character varying); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION get_column_names(character varying) RETURNS character varying
    AS $_$
declare
	table_name varchar;     
	return_value varchar;	
	x record;
	Y INTEGER;
	BEGIN
Y:=0;
return_value:='';
for x in SELECT
    a.attname as column,
    pg_catalog.format_type(a.atttypid, a.atttypmod) as "Datatype"
FROM
    pg_catalog.pg_attribute a
WHERE
    a.attnum > 0
    AND NOT a.attisdropped
    AND a.attrelid = (
        SELECT c.oid
        FROM pg_catalog.pg_class c
            LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
        WHERE c.relname like $1
            AND pg_catalog.pg_table_is_visible(c.oid)
    )
loop
if (y = 0)
then 
return_value = x.column;
else
return_value := return_value ||','|| x.column;
end if; 
Y = Y+1;

end loop;

return return_value;
    END;
$_$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.get_column_names(character varying) OWNER TO gpadmin;

--
-- Name: hplr(name); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION hplr(kkk name) RETURNS character varying
    AS $$
# PL/R function body
$$
    LANGUAGE plr;


ALTER FUNCTION sn2ro.hplr(kkk name) OWNER TO gpadmin;

--
-- Name: hpy_sample(name); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION hpy_sample(kkk name) RETURNS character varying
    AS $$
# PL/Python function body
$$
    LANGUAGE plpythonu;


ALTER FUNCTION sn2ro.hpy_sample(kkk name) OWNER TO gpadmin;

--
-- Name: insert_sn_tst_100byte(integer); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION insert_sn_tst_100byte(iv_cnt integer) RETURNS character varying
    AS $$

--BGN : Use Case--------------------------------------------------------
-- SET SEARCH_PATH = sn2ro;
-- SELECT insert_sn_tst_100byte(10);
--END : Use Case--------------------------------------------------------

DECLARE
  lv_time_begin     varchar(30);
  lv_time_end       varchar(30);
  lv_return_message text;
BEGIN
  lv_time_begin = clock_timestamp();      -- Begin Time
  FOR idx IN 1..iv_cnt LOOP
    INSERT INTO sn_tst_100byte VALUES (idx, '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890');
  END LOOP;
  lv_time_end   = clock_timestamp();      -- End Time  
  lv_return_message = 
                      'Begin Time: ' 
                      || lv_time_begin
                      || ' -- ' 
                      || 'End Time: ' 
                      || lv_time_end ;  
--  RETURN 'Success';
  RETURN lv_return_message;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.insert_sn_tst_100byte(iv_cnt integer) OWNER TO gpadmin;

--
-- Name: insert_year(); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION insert_year() RETURNS void
    AS $$
--BGN : Use Case--------------------------------------------------------
-- SET SEARCH_PATH = sn2ro;
-- SELECT * FROM insert_year();
--END : Use Case--------------------------------------------------------
BEGIN 
  FOR i IN 1982..1983 LOOP
    EXECUTE 'INSERT INTO sn2ro.sn_text_year VALUES (' || i::text || ')';
  END LOOP;
END; 
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.insert_year() OWNER TO gpadmin;

--
-- Name: manage_partitions(); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION manage_partitions() RETURNS trigger
    AS $_$
DECLARE

    -- current partition (last created partition)
    v_curr_partition_name       VARCHAR(32);

    -- new partition (will be created)
    v_partition_name            VARCHAR(32);

    -- previous partition (will be dropped)
    v_prev_partition_name       VARCHAR(32);

    -- interval of the new partition
    v_date_from                 TIMESTAMP;
    v_date_to                   TIMESTAMP;

    -- ID of the lock (should be unique within the application)
    v_lock_id                   INTEGER := 1;
    v_exists                    BOOLEAN;

    -- used to build new trigger procedure
    v_trigger                   TEXT := '';

    -- when should the new partition be created?
    v_current_limit             TIMESTAMP := TG_ARGV[0];

BEGIN

    IF (NEW.created >= v_current_limit) THEN

        -- lock (prevent race conditions)
        PERFORM pg_advisory_lock(v_lock_id);

        -- current partition (we have already crossed the limit, so we have to go 1 month back to get it)
        v_date_from := date_trunc('month', NEW.created) - '1 month'::interval;
        v_curr_partition_name := 'table_' || EXTRACT(YEAR FROM v_date_from) || '_' || EXTRACT(MONTH FROM v_date_from);

        -- previous partition (will be dropped)
        v_date_from := date_trunc('month', NEW.created) - '2 months'::interval;
        v_prev_partition_name := 'table_' || EXTRACT(YEAR FROM v_date_from) || '_' || EXTRACT(MONTH FROM v_date_from);

        -- create the next partition
        v_date_from := date_trunc('month', NEW.created);
        v_date_to := v_date_from + '1 month'::interval;
        v_partition_name := 'table_' || EXTRACT(YEAR FROM v_date_from) || '_' || EXTRACT(MONTH FROM v_date_from);

        -- check if the partition does not exist, and if not then create it
        SELECT COUNT(*) = 1 INTO v_exists FROM pg_tables WHERE schemaname = 'public' AND tablename = v_partition_name;

        IF (NOT v_exists) THEN

            -- create the new partition
            EXECUTE 'CREATE TABLE ' || v_partition_name || ' (PRIMARY KEY (id), CHECK (created >= ''' || v_date_from || ''' AND created < ''' || v_date_to || ''')) INHERITS (sn2ro.table_base)';

            -- refresh this trigger, so that it fires for the next partition
            EXECUTE 'DROP TRIGGER manage_partitions ON sn2ro.table_base';
            EXECUTE 'CREATE TRIGGER manage_partitions BEFORE INSERT ON sn2ro.table_base FOR EACH ROW EXECUTE PROCEDURE manage_partitions(''' || v_date_to || ''')';

            -- refresh the partitioning trigger (keep two partitions in it)
            EXECUTE 'CREATE OR REPLACE FUNCTION partitioning_trigger() RETURNS trigger AS $t$ BEGIN ' ||
                    'IF (NEW.created >= ''' || (v_date_from - '1 month'::interval) || ''' AND NEW.created < ''' || v_date_from || ''') THEN INSERT INTO ' || v_curr_partition_name || ' VALUES (NEW.*);' ||
                    'ELSIF (NEW.created >= ''' || v_date_from || ''' AND NEW.created < ''' || v_date_to || ''') THEN INSERT INTO ' || v_partition_name || ' VALUES (NEW.*); END IF;' ||
                    'RETURN NULL;' ||
                    'END; $t$ LANGUAGE plpgsql;';

            -- remove the previous partition (if it exists)
            SELECT COUNT(*) = 1 INTO v_exists FROM pg_tables WHERE schemaname = 'public' AND tablename = v_prev_partition_name;

            IF (v_exists) THEN

                EXECUTE 'DROP TABLE ' || v_prev_partition_name;

            END IF;

        END IF;

        -- unlock the lock
        PERFORM pg_advisory_unlock(v_lock_id);

    END IF;

    -- return the row, so that it may be forwarded to the partitioning trigger
    RETURN NEW;

END;
$_$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.manage_partitions() OWNER TO gpadmin;

--
-- Name: meminfo(); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION meminfo(OUT metric text, OUT val bigint) RETURNS SETOF record
    AS $$
select trim(split_part(sn2ro.r_meminfo(),':',1))
as metric,
split_part(trim(split_part(sn2ro.r_meminfo(),':',2)),' ',1)::bigint
as val;
$$
    LANGUAGE sql;


ALTER FUNCTION sn2ro.meminfo(OUT metric text, OUT val bigint) OWNER TO gpadmin;

--
-- Name: parse_dyn_sql(text); Type: FUNCTION; Schema: sn2ro; Owner: lr_dba
--

CREATE FUNCTION parse_dyn_sql(text) RETURNS text
    AS $_$ BEGIN RETURN $1; END $_$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.parse_dyn_sql(text) OWNER TO lr_dba;

--
-- Name: partitioning_trigger(); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION partitioning_trigger() RETURNS trigger
    AS $$
BEGIN

    IF (NEW.created >= '2000-11-01 00:00:00' AND NEW.created < '2000-12-01 00:00:00') THEN
        INSERT INTO table_2009_11 VALUES (NEW.*);
    END IF;

    RETURN NULL;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.partitioning_trigger() OWNER TO gpadmin;

--
-- Name: pg_partition_table_size(text); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION pg_partition_table_size(text) RETURNS numeric
    AS $_$   
select sum(to_number(pg_size_pretty(pg_relation_size(inhrelid::regclass)),'999999999')) 
  from pg_inherits where inhparent=$1::regclass;   
$_$
    LANGUAGE sql;


ALTER FUNCTION sn2ro.pg_partition_table_size(text) OWNER TO gpadmin;

--
-- Name: plr_array_accum(double precision[], double precision); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION plr_array_accum(double precision[], double precision) RETURNS double precision[]
    AS '$libdir/plr', 'plr_array_accum'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION sn2ro.plr_array_accum(double precision[], double precision) OWNER TO gpadmin;

--
-- Name: r_median(double precision[]); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION r_median(double precision[]) RETURNS double precision
    AS $$
median(arg1)
$$
    LANGUAGE plr IMMUTABLE;


ALTER FUNCTION sn2ro.r_median(double precision[]) OWNER TO gpadmin;

--
-- Name: r_meminfo(); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION r_meminfo() RETURNS SETOF text
    AS $$
system("cat /proc/meminfo",intern=TRUE)
$$
    LANGUAGE plr;


ALTER FUNCTION sn2ro.r_meminfo() OWNER TO gpadmin;

--
-- Name: reffunc(refcursor); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION reffunc(_ref refcursor) RETURNS refcursor
    AS $$ 
--BGN : Use Case--------------------------------------------------------
-- BEGIN; 
-- SELECT sn2ro.reffunc('funccursor'); 
-- FETCH ALL IN funccursor; 
-- COMMIT; 
--END : Use Case--------------------------------------------------------
BEGIN 
    OPEN _ref FOR EXECUTE 'SELECT * FROM pg_class'; 
    RETURN _ref;
END; 
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.reffunc(_ref refcursor) OWNER TO gpadmin;

--
-- Name: temp2_ins100(integer); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION temp2_ins100(cnt integer) RETURNS character varying
    AS $$
declare
    v_start timestamp;
    v_end timestamp;
    v_src_data varchar(1000) := 'This section provides an overview of TOAST (The Oversized-Attribute Storage Technique). 이 섹션은 TOAST에 대한 개요이다.(Size초과 속성 저장 기술) PostgreSQL uses a fixed page size (commonly 8 kB), and does not allow tuples to span multiple pages. PostgreSQL은 보통 8kB인 고정 page를 사용하고, Row가 여러 페이지에 나누어지는 것을 허용하지 않는다. Therefore, it is not possible to store very large field values directly. 그러므로 매우 큰 field를 직접 저장할 수 없다. To overcome this limitation, large field values are compressed and/or broken up into multiple physical rows. 이러한 한계를 극복하기 위해서, field 값을 압축하고 여러 물리적 row에 나눈다. This happens transparently to the user, with only small impact on most of the backend code. 이것은 작은 영향으로 사용자에게는 알리지 않는다. 알리지 않는다는 의미는 사용자는 저정방식에 따라 SQL을 다르게 작성할 필요 없이 일반 SQL 그대로 사용하면된다는 것이다. The technique is affectionately known as TOAST (or the best thing since sliced bread';
begin
   v_start := clock_timestamp();
   for i in 1..cnt loop
       insert into DATA_TEMP ( EQP_MODULE_ID, EQP_DCP_ID, TRACE_DTTS, STATUS_CD,  
      		FILE_DATA_1, FILE_DATA_2, FILE_DATA_3, FILE_DATA_4, FILE_DATA_5,
      		LOT_ID, SUBSTRATE_ID, PRODUCT_ID, RECIPE_ID, STEP_ID )
        values 
        ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      --10
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      --20
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      --30
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      --40
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      --50
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      --60
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      --70
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      --80
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      --90
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') )
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) 
      , ( nextval('myseq')||lpad('M',100,'EQP_MODULE_ID'), lpad('D',100,'EQP_DCP_ID'), localtimestamp, 'R', v_src_data, v_src_data, v_src_data, v_src_data, v_src_data, lpad('L',10,'LOT_ID'), lpad('S',10,'SUBSTRATE_ID'), lpad('P',10,'PRODUCT_ID'), lpad('R',10,'RECIPE_ID'),  lpad('T',10,'STEP_ID') ) ;
      --100
   end loop;
   v_end := clock_timestamp();
   return 'Success10, elap: '||v_end-v_start||', '||v_start||', '||v_end;
end;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.temp2_ins100(cnt integer) OWNER TO gpadmin;

--
-- Name: update_sn_tst_100byte(integer); Type: FUNCTION; Schema: sn2ro; Owner: gpadmin
--

CREATE FUNCTION update_sn_tst_100byte(iv_cnt integer) RETURNS character varying
    AS $$

--BGN : Use Case--------------------------------------------------------
-- SET SEARCH_PATH = sn2ro;
-- SELECT update_sn_tst_100byte(10);
--END : Use Case--------------------------------------------------------

DECLARE
  lv_time_begin     varchar(30);
  lv_time_end       varchar(30);
  lv_return_message text;
BEGIN
  lv_time_begin = clock_timestamp();      -- Begin Time
  FOR idx IN 1..iv_cnt LOOP
    UPDATE sn_tst_100byte 
      SET inf01 = '0987654321098765432109876543210987654321098765432109876543210987654321098765432109876543210987654321'
      WHERE key01 = 5;
  END LOOP;
  lv_time_end   = clock_timestamp();      -- End Time  
  lv_return_message = 
                      'Begin Time: ' 
                      || lv_time_begin
                      || ' -- ' 
                      || 'End Time: ' 
                      || lv_time_end ;  
--  RETURN 'Success';
  RETURN lv_return_message;
END;
$$
    LANGUAGE plpgsql;


ALTER FUNCTION sn2ro.update_sn_tst_100byte(iv_cnt integer) OWNER TO gpadmin;

--
-- Name: array_accum(anyelement); Type: AGGREGATE; Schema: sn2ro; Owner: gpadmin
--

CREATE AGGREGATE array_accum(anyelement) (
    SFUNC = array_append,
    STYPE = anyarray,
    INITCOND = '{}'
);


ALTER AGGREGATE sn2ro.array_accum(anyelement) OWNER TO gpadmin;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

--
-- Name: data_temp; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE data_temp (
    eqp_module_id character varying(1024) NOT NULL,
    eqp_dcp_id character varying(128) NOT NULL,
    trace_dtts timestamp without time zone NOT NULL,
    status_cd character varying(32) NOT NULL,
    trace_fault_count integer,
    mspc_fault_count integer,
    trace_warning_count integer,
    file_data_1 character varying(4000),
    file_data_2 character varying(4000),
    file_data_3 character varying(4000),
    file_data_4 character varying(4000),
    file_data_5 character varying(4000),
    file_data_6 character varying(4000),
    file_data_7 character varying(4000),
    file_data_8 character varying(4000),
    file_data_9 character varying(4000),
    context_key character varying(1024),
    data_quality_index bigint,
    operation_id character varying(128),
    lot_id character varying(128) NOT NULL,
    lot_type_cd character varying(32),
    cassette_slot integer,
    substrate_id character varying(1024) NOT NULL,
    product_id character varying(128),
    recipe_id character varying(128),
    step_id character varying(64),
    rsd_01 character varying(1024),
    rsd_02 character varying(1024),
    rsd_03 character varying(1024),
    rsd_04 character varying(1024),
    rsd_05 character varying(1024),
    rsd_06 character varying(1024),
    rsd_07 character varying(1024),
    rsd_08 character varying(1024),
    rsd_09 character varying(1024),
    rsd_10 character varying(1024),
    rsd_11 character varying(1024),
    rsd_12 character varying(1024),
    rsd_13 character varying(1024),
    rsd_14 character varying(1024),
    rsd_15 character varying(1024),
    rsd_16 character varying(1024),
    rsd_17 character varying(1024),
    rsd_18 character varying(1024),
    rsd_19 character varying(1024),
    rsd_20 character varying(1024),
    weekday character varying(1) DEFAULT to_char(('now'::text)::timestamp without time zone, 'D'::text) NOT NULL,
    create_by character varying(32),
    create_dtts timestamp without time zone,
    last_update_by character varying(32),
    last_update_dtts timestamp without time zone
) DISTRIBUTED BY (eqp_module_id) PARTITION BY LIST(weekday) 
          (
          PARTITION p01 VALUES('1') WITH (tablename='data_temp_1_prt_p01', appendonly=false ), 
          PARTITION p02 VALUES('2') WITH (tablename='data_temp_1_prt_p02', appendonly=false ), 
          PARTITION p03 VALUES('3') WITH (tablename='data_temp_1_prt_p03', appendonly=false ), 
          PARTITION p04 VALUES('4') WITH (tablename='data_temp_1_prt_p04', appendonly=false ), 
          PARTITION p05 VALUES('5') WITH (tablename='data_temp_1_prt_p05', appendonly=false ), 
          PARTITION p06 VALUES('6') WITH (tablename='data_temp_1_prt_p06', appendonly=false ), 
          PARTITION p07 VALUES('7') WITH (tablename='data_temp_1_prt_p07', appendonly=false )
          );


ALTER TABLE public.data_temp OWNER TO gpadmin;

--
-- Name: err_ext_snull; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_ext_snull (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE public.err_ext_snull OWNER TO gpadmin;

--
-- Name: ext_tb_linux; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_tb_linux (
    a character varying(10),
    b character varying(10),
    c character varying(10)
) LOCATION (
    'gpfdist://192.168.0.61:8081/ext_tb_linux.txt'
) FORMAT 'text' (delimiter E'|' null E' ' escape E'\\')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public.ext_tb_linux OWNER TO gpadmin;

--
-- Name: myseq; Type: SEQUENCE; Schema: public; Owner: gpadmin
--

CREATE SEQUENCE myseq
    START WITH 10
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 100000;


ALTER TABLE public.myseq OWNER TO gpadmin;

--
-- Name: sum_value; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE sum_value (
    eqp_sum_rawid bigint NOT NULL,
    sum_dtts timestamp without time zone NOT NULL,
    step_id character varying(64),
    step_name character varying(64),
    sum_param_name character varying(1024),
    sum_value double precision
) DISTRIBUTED BY (eqp_sum_rawid);


ALTER TABLE public.sum_value OWNER TO gpadmin;

--
-- Name: tb_ext_test; Type: EXTERNAL TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE tb_ext_test (
    a character varying(10),
    b character varying(10),
    c character varying(10)
) LOCATION (
    'gpfdist://192.168.0.61:8081/tb_ext_test.txt'
) FORMAT 'text' (delimiter E'|' null E'\\N' escape E'\\')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE public.tb_ext_test OWNER TO gpadmin;

--
-- Name: temp; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE temp (
    x integer,
    y integer
) DISTRIBUTED BY (x);


ALTER TABLE public.temp OWNER TO gpadmin;

--
-- Name: trace; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE TABLE trace (
    eqp_module_id character varying(1024),
    eqp_dcp_id character varying(128),
    status_cd character varying(32),
    start_dtts timestamp without time zone,
    end_dtts timestamp without time zone,
    sample_count integer,
    trace_fault_count integer,
    trace_warning_count integer,
    mspc_fault_count integer,
    alarm_count integer,
    file_data text,
    data_quality_index bigint,
    operation_id character varying(128),
    lot_id character varying(128),
    lot_type_cd character varying(32),
    cassette_slot integer,
    substrate_id character varying(1024),
    product_id character varying(128),
    recipe_id character varying(128),
    step_id character varying(64),
    main_module_id character varying(1024),
    context_key character varying(1024),
    rsd_01 character varying(1024),
    rsd_02 character varying(1024),
    rsd_03 character varying(1024),
    rsd_04 character varying(1024),
    rsd_05 character varying(1024),
    rsd_06 character varying(1024),
    rsd_07 character varying(1024),
    rsd_08 character varying(1024),
    rsd_09 character varying(1024),
    rsd_10 character varying(1024),
    rsd_11 character varying(1024),
    rsd_12 character varying(1024),
    rsd_13 character varying(1024),
    rsd_14 character varying(1024),
    rsd_15 character varying(1024),
    rsd_16 character varying(1024),
    rsd_17 character varying(1024),
    rsd_18 character varying(1024),
    rsd_19 character varying(1024),
    rsd_20 character varying(1024),
    create_dtts timestamp without time zone,
    create_by character varying(32),
    last_update_dtts timestamp without time zone,
    last_update_by character varying(32),
    rawid bigint
) DISTRIBUTED BY (eqp_module_id) PARTITION BY RANGE(start_dtts) 
          (
          PARTITION pd20121126 START ('2012-11-26 00:00:00'::timestamp without time zone) END ('2012-11-27 00:00:00'::timestamp without time zone) WITH (tablename='trace_1_prt_pd20121126', appendonly=false ), 
          PARTITION pd20121127 START ('2012-11-27 00:00:00'::timestamp without time zone) END ('2012-11-28 00:00:00'::timestamp without time zone) WITH (tablename='trace_1_prt_pd20121127', appendonly=false ), 
          DEFAULT PARTITION default_part  WITH (tablename='trace_1_prt_default_part', appendonly=false )
          );


ALTER TABLE public.trace OWNER TO gpadmin;

SET search_path = s2wlog, pg_catalog;

--
-- Name: datelookup; Type: TABLE; Schema: s2wlog; Owner: gpadmin; Tablespace: 
--

CREATE TABLE datelookup (
    daydate date NOT NULL,
    yeardate date,
    monthdate date,
    weekdate date,
    quarterdate date,
    monthday integer,
    monthdays integer,
    monthname character varying(20),
    monthshortname character varying(20),
    calendaryear integer,
    calendarmonth integer,
    calendarweek integer,
    calendarquarter integer,
    leapyear character varying(20),
    monthweek integer,
    yearday integer,
    weekday integer,
    dayname character varying(20),
    dayshortname character varying(20),
    northseason character varying(20),
    southseason character varying(20)
) DISTRIBUTED BY (daydate);


ALTER TABLE s2wlog.datelookup OWNER TO gpadmin;

--
-- Name: dimension_time; Type: TABLE; Schema: s2wlog; Owner: gpadmin; Tablespace: 
--

CREATE TABLE dimension_time (
    day_key integer NOT NULL,
    day_timestamp timestamp without time zone NOT NULL,
    day_name character varying(32) NOT NULL,
    day_text character varying(32) NOT NULL,
    day_weekdayname character varying(32) NOT NULL,
    day_isworkday integer NOT NULL,
    day_numberinweek integer NOT NULL,
    day_numberinmonth integer NOT NULL,
    day_numberinyear integer NOT NULL,
    day_numberinfiscalyear integer NOT NULL,
    day_numbersincebeginning integer NOT NULL,
    week_key integer NOT NULL,
    week_name character varying(32) NOT NULL,
    week_text character varying(32) NOT NULL,
    week_numberinyear integer NOT NULL,
    month_key integer NOT NULL,
    month_name character varying(32) NOT NULL,
    month_text character varying(32) NOT NULL,
    month_numberinyear integer NOT NULL,
    month_numberinfiscalyear integer NOT NULL,
    season_key integer NOT NULL,
    season_name character varying(32) NOT NULL,
    season_text character varying(32) NOT NULL,
    quarter_key integer NOT NULL,
    quarter_name character varying(32) NOT NULL,
    quarter_text character varying(32) NOT NULL,
    quarter_numberinyear integer NOT NULL,
    fiscalquarter_key integer NOT NULL,
    fiscalquarter_name character varying(32) NOT NULL,
    fiscalquarter_text character varying(32) NOT NULL,
    fiscalquarter_numberinfiscalyear integer NOT NULL,
    semester_key integer NOT NULL,
    semester_name character varying(32) NOT NULL,
    semester_text character varying(32) NOT NULL,
    semester_numberinyear integer NOT NULL,
    fiscalsemester_key integer NOT NULL,
    fiscalsemester_name character varying(32) NOT NULL,
    fiscalsemester_text character varying(32) NOT NULL,
    fiscalsemester_numberinfiscalyear integer NOT NULL,
    year_key integer NOT NULL,
    year_name character varying(32) NOT NULL,
    year_text character varying(32) NOT NULL,
    fiscalyear_key integer NOT NULL,
    fiscalyear_name character varying(32) NOT NULL,
    fiscalyear_text character varying(32) NOT NULL,
    istoday integer NOT NULL
) DISTRIBUTED BY (day_key);


ALTER TABLE s2wlog.dimension_time OWNER TO gpadmin;

--
-- Name: wldbrowser; Type: TABLE; Schema: s2wlog; Owner: gpadmin; Tablespace: 
--

CREATE TABLE wldbrowser (
    contents_key character varying(10),
    browser_key character varying(10),
    os_key character varying(10),
    user_key character varying(10),
    time_key character varying(10),
    sc_status_key character varying(10),
    visit_count character varying(10),
    service_time character varying(10),
    request character varying(10),
    response character varying(10),
    fr_contents character varying(10),
    sessionnm character varying(10),
    seq_in_sessionnm character varying(10),
    up_in_session character varying(10)
) DISTRIBUTED BY (contents_key ,browser_key);


ALTER TABLE s2wlog.wldbrowser OWNER TO gpadmin;

--
-- Name: wldcategory; Type: TABLE; Schema: s2wlog; Owner: gpadmin; Tablespace: 
--

CREATE TABLE wldcategory (
    contents_key character varying(10),
    browser_key character varying(10),
    os_key character varying(10),
    user_key character varying(10),
    time_key character varying(10),
    sc_status_key character varying(10),
    visit_count character varying(10),
    service_time character varying(10),
    request character varying(10),
    response character varying(10),
    fr_contents character varying(10),
    sessionnm character varying(10),
    seq_in_sessionnm character varying(10),
    up_in_session character varying(10)
) DISTRIBUTED BY (contents_key ,browser_key);


ALTER TABLE s2wlog.wldcategory OWNER TO gpadmin;

--
-- Name: wldcontents; Type: TABLE; Schema: s2wlog; Owner: gpadmin; Tablespace: 
--

CREATE TABLE wldcontents (
    contents_key character varying(10),
    browser_key character varying(10),
    os_key character varying(10),
    user_key character varying(10),
    time_key character varying(10),
    sc_status_key character varying(10),
    visit_count character varying(10),
    service_time character varying(10),
    request character varying(10),
    response character varying(10),
    fr_contents character varying(10),
    sessionnm character varying(10),
    seq_in_sessionnm character varying(10),
    up_in_session character varying(10)
) DISTRIBUTED BY (contents_key ,browser_key);


ALTER TABLE s2wlog.wldcontents OWNER TO gpadmin;

--
-- Name: wlddate; Type: TABLE; Schema: s2wlog; Owner: gpadmin; Tablespace: 
--

CREATE TABLE wlddate (
    yyyymmdd character varying(8),
    yyyymm character varying(6),
    yyyy character varying(4),
    day double precision,
    month double precision,
    year double precision,
    monthname text,
    dayofyear double precision,
    weekdayname text,
    calendarweek double precision,
    formatteddate text,
    quartal text,
    yearquartal text,
    yearmonth text,
    yearcalendarweek text,
    weekend text,
    americanholiday text,
    austrianholiday text,
    canadianholiday text,
    period text,
    cwstart date,
    cwend date,
    monthstart date,
    monthend timestamp without time zone
) DISTRIBUTED BY (yyyymmdd);


ALTER TABLE s2wlog.wlddate OWNER TO gpadmin;

--
-- Name: wldos; Type: TABLE; Schema: s2wlog; Owner: gpadmin; Tablespace: 
--

CREATE TABLE wldos (
    contents_key character varying(10),
    browser_key character varying(10),
    os_key character varying(10),
    user_key character varying(10),
    time_key character varying(10),
    sc_status_key character varying(10),
    visit_count character varying(10),
    service_time character varying(10),
    request character varying(10),
    response character varying(10),
    fr_contents character varying(10),
    sessionnm character varying(10),
    seq_in_sessionnm character varying(10),
    up_in_session character varying(10)
) DISTRIBUTED BY (contents_key ,browser_key);


ALTER TABLE s2wlog.wldos OWNER TO gpadmin;

--
-- Name: wldregion; Type: TABLE; Schema: s2wlog; Owner: gpadmin; Tablespace: 
--

CREATE TABLE wldregion (
    contents_key character varying(10),
    browser_key character varying(10),
    os_key character varying(10),
    user_key character varying(10),
    time_key character varying(10),
    sc_status_key character varying(10),
    visit_count character varying(10),
    service_time character varying(10),
    request character varying(10),
    response character varying(10),
    fr_contents character varying(10),
    sessionnm character varying(10),
    seq_in_sessionnm character varying(10),
    up_in_session character varying(10)
) DISTRIBUTED BY (contents_key ,browser_key);


ALTER TABLE s2wlog.wldregion OWNER TO gpadmin;

--
-- Name: wldsc_status; Type: TABLE; Schema: s2wlog; Owner: gpadmin; Tablespace: 
--

CREATE TABLE wldsc_status (
    contents_key character varying(10),
    browser_key character varying(10),
    os_key character varying(10),
    user_key character varying(10),
    time_key character varying(10),
    sc_status_key character varying(10),
    visit_count character varying(10),
    service_time character varying(10),
    request character varying(10),
    response character varying(10),
    fr_contents character varying(10),
    sessionnm character varying(10),
    seq_in_sessionnm character varying(10),
    up_in_session character varying(10)
) DISTRIBUTED BY (contents_key ,browser_key);


ALTER TABLE s2wlog.wldsc_status OWNER TO gpadmin;

--
-- Name: wldtime; Type: TABLE; Schema: s2wlog; Owner: lr_dba; Tablespace: 
--

CREATE TABLE wldtime (
    time_key timestamp without time zone,
    dt character varying(10),
    wk character varying(10),
    mh character varying(10),
    yr character varying(10)
) DISTRIBUTED BY (time_key);


ALTER TABLE s2wlog.wldtime OWNER TO lr_dba;

--
-- Name: wlduser; Type: TABLE; Schema: s2wlog; Owner: gpadmin; Tablespace: 
--

CREATE TABLE wlduser (
    contents_key character varying(10),
    browser_key character varying(10),
    os_key character varying(10),
    user_key character varying(10),
    time_key character varying(10),
    sc_status_key character varying(10),
    visit_count character varying(10),
    service_time character varying(10),
    request character varying(10),
    response character varying(10),
    fr_contents character varying(10),
    sessionnm character varying(10),
    seq_in_sessionnm character varying(10),
    up_in_session character varying(10)
) DISTRIBUTED BY (contents_key ,browser_key);


ALTER TABLE s2wlog.wlduser OWNER TO gpadmin;

--
-- Name: wlf001; Type: TABLE; Schema: s2wlog; Owner: lr_dba; Tablespace: 
--

CREATE TABLE wlf001 (
    contents_key character varying(10) NOT NULL,
    browser_key character varying(10) NOT NULL,
    os_key character varying(10) NOT NULL,
    user_key character varying(10) NOT NULL,
    time_key character varying(10) NOT NULL,
    sc_status_key character varying(10) NOT NULL,
    visit_count character varying(10) NOT NULL,
    service_time character varying(10) NOT NULL,
    request character varying(10) NOT NULL,
    response character varying(10) NOT NULL
) DISTRIBUTED BY (contents_key ,browser_key);


ALTER TABLE s2wlog.wlf001 OWNER TO lr_dba;

--
-- Name: wlfvisit; Type: TABLE; Schema: s2wlog; Owner: gpadmin; Tablespace: 
--

CREATE TABLE wlfvisit (
    contents_key character varying(10),
    browser_key character varying(10),
    os_key character varying(10),
    user_key character varying(10),
    time_key character varying(10),
    sc_status_key character varying(10),
    visit_count character varying(10),
    service_time character varying(10),
    request character varying(10),
    response character varying(10),
    fr_contents character varying(10),
    sessionnm character varying(10),
    seq_in_sessionnm character varying(10),
    up_in_session character varying(10)
) DISTRIBUTED BY (contents_key ,browser_key);


ALTER TABLE s2wlog.wlfvisit OWNER TO gpadmin;

SET search_path = sn2ro, pg_catalog;

--
-- Name: a; Type: TABLE; Schema: sn2ro; Owner: lr_oltp; Tablespace: 
--

CREATE TABLE a (
    a integer,
    b character varying(100)
) DISTRIBUTED BY (a);


ALTER TABLE sn2ro.a OWNER TO lr_oltp;

--
-- Name: asia; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE asia (
    id integer,
    year integer,
    month integer,
    day integer,
    region text,
    CONSTRAINT sales_1_prt_2_2_prt_asia_check CHECK ((region = 'asia'::text)),
    CONSTRAINT sales_1_prt_2_check CHECK (((year >= 2002) AND (year < 2003)))
) DISTRIBUTED BY (id);


ALTER TABLE sn2ro.asia OWNER TO gpadmin;

--
-- Name: child; Type: TABLE; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE TABLE child (
    key01 character varying(10) NOT NULL,
    key02 character varying(10) NOT NULL,
    inf01 character varying(10) NOT NULL
) DISTRIBUTED BY (key01);


ALTER TABLE sn2ro.child OWNER TO lr_dba;

--
-- Name: connectby_tree; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE connectby_tree (
    keyid text,
    parent_keyid text,
    pos integer
) DISTRIBUTED BY (keyid);


ALTER TABLE sn2ro.connectby_tree OWNER TO gpadmin;

--
-- Name: dba_partition_config; Type: TABLE; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE TABLE dba_partition_config (
    schemaname name NOT NULL,
    tablename name NOT NULL,
    appendonlytext text,
    compressleveltext text,
    orientationtext text,
    m_default_retention integer
) DISTRIBUTED BY (schemaname ,tablename);


ALTER TABLE sn2ro.dba_partition_config OWNER TO lr_dba;

--
-- Name: COLUMN dba_partition_config.schemaname; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_config.schemaname IS 'Schema Name';


--
-- Name: COLUMN dba_partition_config.tablename; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_config.tablename IS 'Table Name';


--
-- Name: COLUMN dba_partition_config.m_default_retention; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_config.m_default_retention IS 'Month Default Retention';


--
-- Name: dba_partition_lognr_seq; Type: SEQUENCE; Schema: sn2ro; Owner: lr_dba
--

CREATE SEQUENCE dba_partition_lognr_seq
    START WITH 25
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sn2ro.dba_partition_lognr_seq OWNER TO lr_dba;

--
-- Name: dba_partition_log; Type: TABLE; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE TABLE dba_partition_log (
    lognr integer DEFAULT nextval('dba_partition_lognr_seq'::regclass) NOT NULL,
    bgntm timestamp without time zone,
    nspname name,
    relname name,
    result character(1),
    message text,
    pname name,
    endtm timestamp without time zone,
    duration double precision,
    bgndt_varchar character varying(8)
) DISTRIBUTED BY (lognr);


ALTER TABLE sn2ro.dba_partition_log OWNER TO lr_dba;

--
-- Name: COLUMN dba_partition_log.lognr; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_log.lognr IS 'LOG NUMBER';


--
-- Name: COLUMN dba_partition_log.bgntm; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_log.bgntm IS 'BEGIN TIME';


--
-- Name: COLUMN dba_partition_log.nspname; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_log.nspname IS 'SCHEMA';


--
-- Name: COLUMN dba_partition_log.relname; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_log.relname IS 'TABLE';


--
-- Name: COLUMN dba_partition_log.result; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_log.result IS 'RESULT';


--
-- Name: COLUMN dba_partition_log.message; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_log.message IS 'MESSAGE';


--
-- Name: COLUMN dba_partition_log.pname; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_log.pname IS 'PARTITION NAME';


--
-- Name: COLUMN dba_partition_log.endtm; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_log.endtm IS 'END TIME';


--
-- Name: COLUMN dba_partition_log.duration; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_log.duration IS 'DURATION IN MILLISECONDS';


--
-- Name: COLUMN dba_partition_log.bgndt_varchar; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_log.bgndt_varchar IS 'BEGIN DATE';


--
-- Name: dba_partition_master; Type: TABLE; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE TABLE dba_partition_master (
    id integer NOT NULL,
    table_name integer,
    partition_value character(15),
    auto_script_name character(100),
    reg_date time with time zone
) DISTRIBUTED BY (id);


ALTER TABLE sn2ro.dba_partition_master OWNER TO lr_dba;

--
-- Name: COLUMN dba_partition_master.table_name; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_master.table_name IS 'table name';


--
-- Name: COLUMN dba_partition_master.partition_value; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_master.partition_value IS 'day/week/month/year';


--
-- Name: COLUMN dba_partition_master.auto_script_name; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_master.auto_script_name IS '파티션 자동화 스크립트명';


--
-- Name: COLUMN dba_partition_master.reg_date; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN dba_partition_master.reg_date IS '등록날짜';


--
-- Name: dba_partition_master_id_seq; Type: SEQUENCE; Schema: sn2ro; Owner: lr_dba
--

CREATE SEQUENCE dba_partition_master_id_seq
    START WITH 14
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sn2ro.dba_partition_master_id_seq OWNER TO lr_dba;

--
-- Name: dba_partition_master_id_seq1; Type: SEQUENCE; Schema: sn2ro; Owner: lr_dba
--

CREATE SEQUENCE dba_partition_master_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sn2ro.dba_partition_master_id_seq1 OWNER TO lr_dba;

--
-- Name: dba_partition_master_id_seq1; Type: SEQUENCE OWNED BY; Schema: sn2ro; Owner: lr_dba
--

ALTER SEQUENCE dba_partition_master_id_seq1 OWNED BY dba_partition_master.id;


--
-- Name: etc_gp_etl_log; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE etc_gp_etl_log (
    sys_dvsn character varying(2),
    work_date character varying(8),
    pgm_nm character varying(100),
    job_seq integer,
    load_dvsn character varying(1),
    prj_nm character varying(100),
    table_nm character varying(100),
    base_date_fr date,
    base_date_to date,
    job_stt_date date,
    job_stt_time time(6) without time zone,
    job_end_date date,
    job_end_time time(6) without time zone,
    job_lead_time time(6) without time zone,
    proc_cnt bigint,
    norm_yn character varying(1),
    err_cd character varying(20),
    etc_ctx1 character varying(100),
    etc_ctx2 character varying(100),
    gp_upd_staff_no character varying(50),
    gp_upd_date timestamp without time zone NOT NULL
) DISTRIBUTED BY (work_date);


ALTER TABLE sn2ro.etc_gp_etl_log OWNER TO gpadmin;

--
-- Name: ext_snull; Type: EXTERNAL TABLE; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE EXTERNAL TABLE ext_snull (
    col01 character varying(10),
    col02 character varying(10),
    col03 character varying(10)
) LOCATION (
    'gpfdist://192.168.0.62:8080/a_list_snull.out'
) FORMAT 'text' (delimiter E'	' null E'\\N' escape E'\\')
ENCODING 'UTF8'
LOG ERRORS INTO public.err_ext_snull SEGMENT REJECT LIMIT 5 ROWS;


ALTER EXTERNAL TABLE sn2ro.ext_snull OWNER TO lr_dba;

--
-- Name: ext_tb_psql_c_show_all; Type: EXTERNAL TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_tb_psql_c_show_all (
    name character varying(44),
    setting character varying(133),
    description character varying(178)
) LOCATION (
    'gpfdist://localhost:8080/psql_c_show_all.dat'
) FORMAT 'text' (delimiter E'|' null E'' escape E'\\')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE sn2ro.ext_tb_psql_c_show_all OWNER TO gpadmin;

--
-- Name: ext_tb_windows; Type: EXTERNAL TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_tb_windows (
    a character varying(10),
    b character varying(10),
    c character varying(10)
) LOCATION (
    'gpfdist://192.168.0.50:8080/tb_ext_wintable.*'
) FORMAT 'text' (delimiter E'|' null E'' escape E'OFF')
ENCODING 'UTF8';


ALTER EXTERNAL TABLE sn2ro.ext_tb_windows OWNER TO gpadmin;

--
-- Name: factory_code_p7; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE factory_code_p7 (
    product_id character varying(40) NOT NULL ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    equipment_group_id character varying(40) NOT NULL ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    apd_seq_no integer NOT NULL ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    receive_timestamp timestamp without time zone NOT NULL ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    factory_code character varying(40) NOT NULL ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    apd_data_id character varying(40) NOT NULL ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    etl_insert_update_timestamp timestamp without time zone NOT NULL ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    apd_data_group_id character varying(40) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    apd_collection_code character(1) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    character_data_value character varying(200) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    number_data_value double precision ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    CONSTRAINT tb_fda_pdw_apd_detail_1_prt_p20121231_2_prt_p7_check CHECK (((factory_code)::text = 'P7'::text)),
    CONSTRAINT tb_fda_pdw_apd_detail_1_prt_p20121231_check CHECK (((receive_timestamp >= '2012-12-31 00:00:00'::timestamp without time zone) AND (receive_timestamp < '2013-01-01 00:00:00'::timestamp without time zone)))
)
WITH (appendonly=true, orientation=column, compresslevel=5, compresstype=zlib) DISTRIBUTED BY (product_id);


ALTER TABLE sn2ro.factory_code_p7 OWNER TO gpadmin;

--
-- Name: factory_code_p8; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE factory_code_p8 (
    product_id character varying(40) NOT NULL ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    equipment_group_id character varying(40) NOT NULL ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    apd_seq_no integer NOT NULL ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    receive_timestamp timestamp without time zone NOT NULL ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    factory_code character varying(40) NOT NULL ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    apd_data_id character varying(40) NOT NULL ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    etl_insert_update_timestamp timestamp without time zone NOT NULL ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    apd_data_group_id character varying(40) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    apd_collection_code character(1) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    character_data_value character varying(200) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    number_data_value double precision ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    CONSTRAINT tb_fda_pdw_apd_detail_1_prt_p20121231_2_prt_p8_check CHECK (((factory_code)::text = 'P8'::text)),
    CONSTRAINT tb_fda_pdw_apd_detail_1_prt_p20121231_check CHECK (((receive_timestamp >= '2012-12-31 00:00:00'::timestamp without time zone) AND (receive_timestamp < '2013-01-01 00:00:00'::timestamp without time zone)))
)
WITH (appendonly=true, orientation=column, compresslevel=5, compresstype=zlib) DISTRIBUTED BY (product_id);


ALTER TABLE sn2ro.factory_code_p8 OWNER TO gpadmin;

--
-- Name: factory_code_p9; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE factory_code_p9 (
    product_id character varying(40) NOT NULL ENCODING (compresstype=none,blocksize=32768,compresslevel=0),
    equipment_group_id character varying(40) NOT NULL ENCODING (compresstype=none,blocksize=32768,compresslevel=0),
    apd_seq_no integer NOT NULL ENCODING (compresstype=none,blocksize=32768,compresslevel=0),
    receive_timestamp timestamp without time zone NOT NULL ENCODING (compresstype=none,blocksize=32768,compresslevel=0),
    factory_code character varying(40) NOT NULL ENCODING (compresstype=none,blocksize=32768,compresslevel=0),
    apd_data_id character varying(40) NOT NULL ENCODING (compresstype=none,blocksize=32768,compresslevel=0),
    etl_insert_update_timestamp timestamp without time zone NOT NULL ENCODING (compresstype=none,blocksize=32768,compresslevel=0),
    apd_data_group_id character varying(40) ENCODING (compresstype=none,blocksize=32768,compresslevel=0),
    apd_collection_code character(1) ENCODING (compresstype=none,blocksize=32768,compresslevel=0),
    character_data_value character varying(200) ENCODING (compresstype=none,blocksize=32768,compresslevel=0),
    number_data_value double precision ENCODING (compresstype=none,blocksize=32768,compresslevel=0),
    CONSTRAINT tb_fda_pdw_apd_detail_1_prt_p20121231_2_prt_p9_check CHECK (((factory_code)::text = 'P9'::text)),
    CONSTRAINT tb_fda_pdw_apd_detail_1_prt_p20121231_check CHECK (((receive_timestamp >= '2012-12-31 00:00:00'::timestamp without time zone) AND (receive_timestamp < '2013-01-01 00:00:00'::timestamp without time zone)))
)
WITH (orientation=column, appendonly=true) DISTRIBUTED BY (product_id);


ALTER TABLE sn2ro.factory_code_p9 OWNER TO gpadmin;

--
-- Name: foo; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE foo (
    f0 integer,
    f1 text,
    f2 double precision
) DISTRIBUTED BY (f0);


ALTER TABLE sn2ro.foo OWNER TO gpadmin;

--
-- Name: gp_customers; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE gp_customers (
    kunnr_nr character varying(10) NOT NULL,
    gpdb_version name,
    gphd_version name,
    kunnr_nm name,
    remarks text
) DISTRIBUTED BY (kunnr_nr);


ALTER TABLE sn2ro.gp_customers OWNER TO gpadmin;

--
-- Name: parent; Type: TABLE; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE TABLE parent (
    key01 character varying(10) NOT NULL,
    inf01 character varying(10) NOT NULL,
    inf02 text,
    inf03 integer,
    inf04 character(10),
    inf05 character varying(10)
) DISTRIBUTED BY (key01);


ALTER TABLE sn2ro.parent OWNER TO lr_dba;

--
-- Name: partition_config; Type: TABLE; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE TABLE partition_config (
    schemaname name NOT NULL,
    tablename name NOT NULL,
    appendonlytext text,
    compressleveltext text,
    orientationtext text,
    m_default_retention integer
) DISTRIBUTED BY (schemaname ,tablename);


ALTER TABLE sn2ro.partition_config OWNER TO lr_dba;

--
-- Name: COLUMN partition_config.schemaname; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN partition_config.schemaname IS 'Schema Name';


--
-- Name: COLUMN partition_config.tablename; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN partition_config.tablename IS 'Table Name';


--
-- Name: COLUMN partition_config.m_default_retention; Type: COMMENT; Schema: sn2ro; Owner: lr_dba
--

COMMENT ON COLUMN partition_config.m_default_retention IS 'Month Default Retention';


--
-- Name: postgres_log; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE postgres_log (
    log_time timestamp with time zone NOT NULL,
    user_name text,
    database_name text,
    process_id text,
    thread_id text,
    connection_from_host text,
    connection_from_port text,
    session_start_time timestamp with time zone,
    session_line_num bigint,
    session_id text,
    command_tag text,
    what_2 text,
    what_3 text,
    what_4 text,
    what_5 text,
    what_6 text,
    level text,
    sql_state_code text,
    message text,
    detail text,
    hint text,
    internal_query text,
    internal_query_pos integer,
    context text,
    query text,
    query_pos integer,
    location text,
    app_name text,
    app_id text NOT NULL
) DISTRIBUTED BY (log_time ,app_id);


ALTER TABLE sn2ro.postgres_log OWNER TO gpadmin;

--
-- Name: role2queue; Type: VIEW; Schema: sn2ro; Owner: gpadmin
--

CREATE VIEW role2queue AS
    SELECT pg_roles.rolname, pg_resqueue.rsqname FROM pg_roles, pg_resqueue, gp_toolkit.gp_resqueue_status WHERE (pg_roles.rolresqueue = gp_resqueue_status.queueid);


ALTER TABLE sn2ro.role2queue OWNER TO gpadmin;

--
-- Name: sales; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE sales (
    id integer,
    year integer,
    month integer,
    day integer,
    region text
) DISTRIBUTED BY (id) PARTITION BY RANGE(year)
          SUBPARTITION BY LIST(region) 
          (
          START (2002) END (2003) EVERY (1) WITH (tablename='sales_1_prt_2', appendonly=false ) 
                  (
                  SUBPARTITION usa VALUES('usa') WITH (tablename='sales_1_prt_2_2_prt_usa', appendonly=false ), 
                  SUBPARTITION europe VALUES('europe') WITH (tablename='sales_1_prt_2_2_prt_europe', appendonly=false ), 
                  SUBPARTITION asia VALUES('asia') WITH (tablename='sales_1_prt_2_2_prt_asia', appendonly=false ), 
                  DEFAULT SUBPARTITION other_regions  WITH (tablename='sales_1_prt_2_2_prt_other_regions', appendonly=false )
                  ), 
          START (2003) END (2004) EVERY (1) WITH (tablename='sales_1_prt_3', appendonly=false ) 
                  (
                  SUBPARTITION usa VALUES('usa') WITH (tablename='sales_1_prt_3_2_prt_usa', appendonly=false ), 
                  SUBPARTITION europe VALUES('europe') WITH (tablename='sales_1_prt_3_2_prt_europe', appendonly=false ), 
                  SUBPARTITION asia VALUES('asia') WITH (tablename='sales_1_prt_3_2_prt_asia', appendonly=false ), 
                  DEFAULT SUBPARTITION other_regions  WITH (tablename='sales_1_prt_3_2_prt_other_regions', appendonly=false )
                  ), 
          START (2004) END (2005) EVERY (1) WITH (tablename='sales_1_prt_4', appendonly=false ) 
                  (
                  SUBPARTITION usa VALUES('usa') WITH (tablename='sales_1_prt_4_2_prt_usa', appendonly=false ), 
                  SUBPARTITION europe VALUES('europe') WITH (tablename='sales_1_prt_4_2_prt_europe', appendonly=false ), 
                  SUBPARTITION asia VALUES('asia') WITH (tablename='sales_1_prt_4_2_prt_asia', appendonly=false ), 
                  DEFAULT SUBPARTITION other_regions  WITH (tablename='sales_1_prt_4_2_prt_other_regions', appendonly=false )
                  ), 
          START (2005) END (2006) EVERY (1) WITH (tablename='sales_1_prt_5', appendonly=false ) 
                  (
                  SUBPARTITION usa VALUES('usa') WITH (tablename='sales_1_prt_5_2_prt_usa', appendonly=false ), 
                  SUBPARTITION europe VALUES('europe') WITH (tablename='sales_1_prt_5_2_prt_europe', appendonly=false ), 
                  SUBPARTITION asia VALUES('asia') WITH (tablename='sales_1_prt_5_2_prt_asia', appendonly=false ), 
                  DEFAULT SUBPARTITION other_regions  WITH (tablename='sales_1_prt_5_2_prt_other_regions', appendonly=false )
                  ), 
          START (2006) END (2007) EVERY (1) WITH (tablename='sales_1_prt_6', appendonly=false ) 
                  (
                  SUBPARTITION usa VALUES('usa') WITH (tablename='sales_1_prt_6_2_prt_usa', appendonly=false ), 
                  SUBPARTITION europe VALUES('europe') WITH (tablename='sales_1_prt_6_2_prt_europe', appendonly=false ), 
                  SUBPARTITION asia VALUES('asia') WITH (tablename='sales_1_prt_6_2_prt_asia', appendonly=false ), 
                  DEFAULT SUBPARTITION other_regions  WITH (tablename='sales_1_prt_6_2_prt_other_regions', appendonly=false )
                  ), 
          START (2007) END (2008) EVERY (1) WITH (tablename='sales_1_prt_7', appendonly=false ) 
                  (
                  SUBPARTITION usa VALUES('usa') WITH (tablename='sales_1_prt_7_2_prt_usa', appendonly=false ), 
                  SUBPARTITION europe VALUES('europe') WITH (tablename='sales_1_prt_7_2_prt_europe', appendonly=false ), 
                  SUBPARTITION asia VALUES('asia') WITH (tablename='sales_1_prt_7_2_prt_asia', appendonly=false ), 
                  DEFAULT SUBPARTITION other_regions  WITH (tablename='sales_1_prt_7_2_prt_other_regions', appendonly=false )
                  ), 
          START (2008) END (2009) EVERY (1) WITH (tablename='sales_1_prt_8', appendonly=false ) 
                  (
                  SUBPARTITION usa VALUES('usa') WITH (tablename='sales_1_prt_8_2_prt_usa', appendonly=false ), 
                  SUBPARTITION europe VALUES('europe') WITH (tablename='sales_1_prt_8_2_prt_europe', appendonly=false ), 
                  SUBPARTITION asia VALUES('asia') WITH (tablename='sales_1_prt_8_2_prt_asia', appendonly=false ), 
                  DEFAULT SUBPARTITION other_regions  WITH (tablename='sales_1_prt_8_2_prt_other_regions', appendonly=false )
                  ), 
          START (2009) END (2010) EVERY (1) WITH (tablename='sales_1_prt_9', appendonly=false ) 
                  (
                  SUBPARTITION usa VALUES('usa') WITH (tablename='sales_1_prt_9_2_prt_usa', appendonly=false ), 
                  SUBPARTITION europe VALUES('europe') WITH (tablename='sales_1_prt_9_2_prt_europe', appendonly=false ), 
                  SUBPARTITION asia VALUES('asia') WITH (tablename='sales_1_prt_9_2_prt_asia', appendonly=false ), 
                  DEFAULT SUBPARTITION other_regions  WITH (tablename='sales_1_prt_9_2_prt_other_regions', appendonly=false )
                  ), 
          DEFAULT PARTITION outlying_years  WITH (tablename='sales_1_prt_outlying_years', appendonly=false ) 
                  (
                  SUBPARTITION usa VALUES('usa') WITH (tablename='sales_1_prt_outlying_years_2_prt_usa', appendonly=false ), 
                  SUBPARTITION europe VALUES('europe') WITH (tablename='sales_1_prt_outlying_years_2_prt_europe', appendonly=false ), 
                  SUBPARTITION asia VALUES('asia') WITH (tablename='sales_1_prt_outlying_years_2_prt_asia', appendonly=false ), 
                  DEFAULT SUBPARTITION other_regions  WITH (tablename='sales_1_prt_outlying_years_2_prt_other_regions', appendonly=false )
                  )
          );
 ALTER TABLE sales 
SET SUBPARTITION TEMPLATE  
          (
          SUBPARTITION usa VALUES('usa') WITH (tablename='sales'), 
          SUBPARTITION europe VALUES('europe') WITH (tablename='sales'), 
          SUBPARTITION asia VALUES('asia') WITH (tablename='sales'), 
          DEFAULT SUBPARTITION other_regions  WITH (tablename='sales')
          )
;


ALTER TABLE sn2ro.sales OWNER TO gpadmin;

--
-- Name: seq01; Type: SEQUENCE; Schema: sn2ro; Owner: gpadmin
--

CREATE SEQUENCE seq01
    START WITH 25
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sn2ro.seq01 OWNER TO gpadmin;

--
-- Name: sn_adm_ddlsql; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE sn_adm_ddlsql (
    seq character varying(10),
    sql text
) DISTRIBUTED BY (seq);


ALTER TABLE sn2ro.sn_adm_ddlsql OWNER TO gpadmin;

--
-- Name: sn_dba_table_info; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE sn_dba_table_info (
    nspname name NOT NULL,
    relname name NOT NULL,
    reltuples bigint,
    relsize bigint,
    dbname name NOT NULL
) DISTRIBUTED BY (relname);


ALTER TABLE sn2ro.sn_dba_table_info OWNER TO gpadmin;

--
-- Name: sn_life_card; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE sn_life_card (
    cardnr character varying(20) NOT NULL,
    cardmonth character varying(6) NOT NULL,
    cardamt numeric,
    cardnm character varying(30)
) DISTRIBUTED BY (cardnr);


ALTER TABLE sn2ro.sn_life_card OWNER TO gpadmin;

--
-- Name: sn_mta_tableinfo; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE sn_mta_tableinfo (
    schemanm character varying(30) NOT NULL,
    tablenm character varying(30) NOT NULL,
    fieldnm character varying(30) NOT NULL,
    fieldty character varying(30) NOT NULL,
    fieldlength character varying(30),
    fieldnm_desc character varying(100)
) DISTRIBUTED BY (fieldnm);


ALTER TABLE sn2ro.sn_mta_tableinfo OWNER TO gpadmin;

--
-- Name: COLUMN sn_mta_tableinfo.schemanm; Type: COMMENT; Schema: sn2ro; Owner: gpadmin
--

COMMENT ON COLUMN sn_mta_tableinfo.schemanm IS 'Schema Name';


--
-- Name: COLUMN sn_mta_tableinfo.tablenm; Type: COMMENT; Schema: sn2ro; Owner: gpadmin
--

COMMENT ON COLUMN sn_mta_tableinfo.tablenm IS 'Table Name';


--
-- Name: COLUMN sn_mta_tableinfo.fieldnm; Type: COMMENT; Schema: sn2ro; Owner: gpadmin
--

COMMENT ON COLUMN sn_mta_tableinfo.fieldnm IS 'Field Name';


--
-- Name: COLUMN sn_mta_tableinfo.fieldty; Type: COMMENT; Schema: sn2ro; Owner: gpadmin
--

COMMENT ON COLUMN sn_mta_tableinfo.fieldty IS 'Field Type';


--
-- Name: COLUMN sn_mta_tableinfo.fieldlength; Type: COMMENT; Schema: sn2ro; Owner: gpadmin
--

COMMENT ON COLUMN sn_mta_tableinfo.fieldlength IS 'Field Length';


--
-- Name: COLUMN sn_mta_tableinfo.fieldnm_desc; Type: COMMENT; Schema: sn2ro; Owner: gpadmin
--

COMMENT ON COLUMN sn_mta_tableinfo.fieldnm_desc IS 'Field Name Description';


--
-- Name: sn_text_year; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE sn_text_year (
    col text
) DISTRIBUTED BY (col);


ALTER TABLE sn2ro.sn_text_year OWNER TO gpadmin;

--
-- Name: sn_tst_100byte; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE sn_tst_100byte (
    key01 numeric NOT NULL,
    inf01 character varying(100)
) DISTRIBUTED BY (key01);


ALTER TABLE sn2ro.sn_tst_100byte OWNER TO gpadmin;

--
-- Name: sn_tst_partition; Type: TABLE; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE TABLE sn_tst_partition (
    yyyymmdd character varying(8),
    yyyymm character varying(6),
    yyyy character varying(4),
    day double precision,
    month double precision,
    year double precision,
    monthname text,
    dayofyear double precision,
    weekdayname text,
    calendarweek double precision,
    formatteddate text,
    dt date,
    quartal text,
    yearquartal text,
    yearmonth text,
    yearcalendarweek text,
    weekend text,
    americanholiday text,
    austrianholiday text,
    canadianholiday text,
    period text,
    cwstart date,
    cwend date,
    monthstart date,
    monthend timestamp without time zone
) DISTRIBUTED RANDOMLY PARTITION BY RANGE(yyyymmdd) 
          (
          PARTITION p2000 START ('2000101'::character varying) END ('20010101'::character varying) WITH (tablename='sn_tst_partition_1_prt_p2000', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200101 START ('20010101'::character varying) END ('20010201'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200101', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200102 START ('20010201'::character varying) END ('20010301'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200102', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200103 START ('20010301'::character varying) END ('20010401'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200103', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200104 START ('20010401'::character varying) END ('20010501'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200104', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200105 START ('20010501'::character varying) END ('20010601'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200105', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200106 START ('20010601'::character varying) END ('20010701'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200106', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200107 START ('20010701'::character varying) END ('20010801'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200107', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200108 START ('20010801'::character varying) END ('20010901'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200108', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200109 START ('20010901'::character varying) END ('20011001'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200109', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200110 START ('20011001'::character varying) END ('20011101'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200110', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200111 START ('20011101'::character varying) END ('20011201'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200111', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200112 START ('20011201'::character varying) END ('20020101'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200112', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200201 START ('20020101'::character varying) END ('20020201'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200201', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200202 START ('20020201'::character varying) END ('20020301'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200202', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200203 START ('20020301'::character varying) END ('20020401'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200203', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200204 START ('20020401'::character varying) END ('20020501'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200204', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200205 START ('20020501'::character varying) END ('20020601'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200205', orientation=column, appendonly=true ) 
                    COLUMN yyyymmdd ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyymm ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yyyy ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN day ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN month ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN year ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dayofyear ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekdayname ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN calendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN formatteddate ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN dt ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN quartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearquartal ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearmonth ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN yearcalendarweek ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN weekend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN americanholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN austrianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN canadianholiday ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN period ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN cwend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthstart ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768) 
                    COLUMN monthend ENCODING (compresslevel=1, compresstype=zlib, blocksize=32768), 
          PARTITION p200206 START ('20020601'::character varying) END ('20020701'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200206', appendonly=false ), 
          PARTITION p200207 START ('20020701'::character varying) END ('20020801'::character varying) WITH (tablename='sn_tst_partition_1_prt_p200207', appendonly=false ), 
          DEFAULT PARTITION pdefault  WITH (tablename='sn_tst_partition_1_prt_pdefault', appendonly=false )
          );


ALTER TABLE sn2ro.sn_tst_partition OWNER TO lr_dba;

--
-- Name: snull; Type: TABLE; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE TABLE snull (
    col01 character varying(10) NOT NULL,
    col02 character varying(10) NOT NULL,
    col03 text,
    col04 integer,
    col05 character(10),
    col06 character varying(10)
) DISTRIBUTED BY (col01 ,col02);


ALTER TABLE sn2ro.snull OWNER TO lr_dba;

--
-- Name: songlist; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE songlist (
    artistid integer NOT NULL,
    id integer NOT NULL,
    priorid integer,
    title character varying(20)
) DISTRIBUTED BY (artistid);


ALTER TABLE sn2ro.songlist OWNER TO gpadmin;

--
-- Name: t0; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE t0 (
    custid integer,
    itemnr integer
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro.t0 OWNER TO gpadmin;

--
-- Name: table_base; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE table_base (
    id integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    data text
) DISTRIBUTED BY (id);


ALTER TABLE sn2ro.table_base OWNER TO gpadmin;

--
-- Name: table_base_id_seq; Type: SEQUENCE; Schema: sn2ro; Owner: gpadmin
--

CREATE SEQUENCE table_base_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE sn2ro.table_base_id_seq OWNER TO gpadmin;

--
-- Name: table_base_id_seq; Type: SEQUENCE OWNED BY; Schema: sn2ro; Owner: gpadmin
--

ALTER SEQUENCE table_base_id_seq OWNED BY table_base.id;


--
-- Name: table_2009_11; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE table_2009_11 (CONSTRAINT table_2009_11_created_check CHECK (((created >= '2009-11-01 00:00:00'::timestamp without time zone) AND (created < '2009-12-01 00:00:00'::timestamp without time zone)))
)
INHERITS (table_base) DISTRIBUTED BY (id);


ALTER TABLE sn2ro.table_2009_11 OWNER TO gpadmin;

--
-- Name: tb_fda_pdw_apd_detail; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
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
) DISTRIBUTED BY (product_id) PARTITION BY RANGE(receive_timestamp)
          SUBPARTITION BY LIST(factory_code) 
          (
          PARTITION p20121201 START ('2012-12-01 00:00:00'::timestamp without time zone) END ('2012-12-02 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121201', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121201_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121201_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121201_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121202 START ('2012-12-02 00:00:00'::timestamp without time zone) END ('2012-12-03 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121202', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121202_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121202_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121202_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121203 START ('2012-12-03 00:00:00'::timestamp without time zone) END ('2012-12-04 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121203', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121203_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121203_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121203_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121204 START ('2012-12-04 00:00:00'::timestamp without time zone) END ('2012-12-05 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121204', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121204_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121204_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121204_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121205 START ('2012-12-05 00:00:00'::timestamp without time zone) END ('2012-12-06 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121205', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121205_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121205_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121205_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121206 START ('2012-12-06 00:00:00'::timestamp without time zone) END ('2012-12-07 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121206', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121206_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121206_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121206_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121207 START ('2012-12-07 00:00:00'::timestamp without time zone) END ('2012-12-08 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121207', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121207_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121207_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121207_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121208 START ('2012-12-08 00:00:00'::timestamp without time zone) END ('2012-12-09 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121208', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121208_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121208_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121208_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121209 START ('2012-12-09 00:00:00'::timestamp without time zone) END ('2012-12-10 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121209', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121209_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121209_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121209_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121210 START ('2012-12-10 00:00:00'::timestamp without time zone) END ('2012-12-11 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121210', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121210_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121210_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121210_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121211 START ('2012-12-11 00:00:00'::timestamp without time zone) END ('2012-12-12 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121211', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121211_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121211_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121211_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121212 START ('2012-12-12 00:00:00'::timestamp without time zone) END ('2012-12-13 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121212', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121212_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121212_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121212_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121213 START ('2012-12-13 00:00:00'::timestamp without time zone) END ('2012-12-14 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121213', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121213_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121213_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121213_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121214 START ('2012-12-14 00:00:00'::timestamp without time zone) END ('2012-12-15 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121214', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121214_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121214_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121214_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121215 START ('2012-12-15 00:00:00'::timestamp without time zone) END ('2012-12-16 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121215', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121215_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121215_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121215_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121216 START ('2012-12-16 00:00:00'::timestamp without time zone) END ('2012-12-17 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121216', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121216_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121216_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121216_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121217 START ('2012-12-17 00:00:00'::timestamp without time zone) END ('2012-12-18 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121217', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121217_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121217_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121217_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121218 START ('2012-12-18 00:00:00'::timestamp without time zone) END ('2012-12-19 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121218', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121218_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121218_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121218_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121219 START ('2012-12-19 00:00:00'::timestamp without time zone) END ('2012-12-20 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121219', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121219_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121219_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121219_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121220 START ('2012-12-20 00:00:00'::timestamp without time zone) END ('2012-12-21 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121220', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121220_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121220_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121220_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121221 START ('2012-12-21 00:00:00'::timestamp without time zone) END ('2012-12-22 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121221', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121221_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121221_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121221_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121222 START ('2012-12-22 00:00:00'::timestamp without time zone) END ('2012-12-23 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121222', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121222_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121222_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121222_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121223 START ('2012-12-23 00:00:00'::timestamp without time zone) END ('2012-12-24 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121223', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121223_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121223_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121223_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121224 START ('2012-12-24 00:00:00'::timestamp without time zone) END ('2012-12-25 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121224', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121224_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121224_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121224_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121225 START ('2012-12-25 00:00:00'::timestamp without time zone) END ('2012-12-26 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121225', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121225_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121225_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121225_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121226 START ('2012-12-26 00:00:00'::timestamp without time zone) END ('2012-12-27 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121226', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121226_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121226_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121226_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121227 START ('2012-12-27 00:00:00'::timestamp without time zone) END ('2012-12-28 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121227', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121227_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121227_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121227_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121228 START ('2012-12-28 00:00:00'::timestamp without time zone) END ('2012-12-29 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121228', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121228_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121228_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121228_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121229 START ('2012-12-29 00:00:00'::timestamp without time zone) END ('2012-12-30 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121229', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121229_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121229_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121229_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121230 START ('2012-12-30 00:00:00'::timestamp without time zone) END ('2012-12-31 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121230', orientation=column, appendonly=true ) 
                    COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                    COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121230_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121230_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121230_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20121231 START ('2012-12-31 00:00:00'::timestamp without time zone) END ('2013-01-01 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121231', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121231_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121231_2_prt_p8', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20121231_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresslevel=5, compresstype=zlib, blocksize=32768)
                  ), 
          PARTITION p20120101 START ('2013-01-01 00:00:00'::timestamp without time zone) END ('2013-01-02 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120101', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120101_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120101_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120101_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120102 START ('2013-01-02 00:00:00'::timestamp without time zone) END ('2013-01-03 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120102', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120102_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120102_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120102_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120103 START ('2013-01-03 00:00:00'::timestamp without time zone) END ('2013-01-04 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120103', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120103_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120103_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120103_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120104 START ('2013-01-04 00:00:00'::timestamp without time zone) END ('2013-01-05 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120104', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120104_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120104_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120104_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120105 START ('2013-01-05 00:00:00'::timestamp without time zone) END ('2013-01-06 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120105', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120105_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120105_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120105_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120106 START ('2013-01-06 00:00:00'::timestamp without time zone) END ('2013-01-07 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120106', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120106_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120106_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120106_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120107 START ('2013-01-07 00:00:00'::timestamp without time zone) END ('2013-01-08 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120107', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120107_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120107_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120107_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120108 START ('2013-01-08 00:00:00'::timestamp without time zone) END ('2013-01-09 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120108', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120108_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120108_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120108_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120109 START ('2013-01-09 00:00:00'::timestamp without time zone) END ('2013-01-10 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120109', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120109_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120109_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120109_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120110 START ('2013-01-10 00:00:00'::timestamp without time zone) END ('2013-01-11 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120110', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120110_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120110_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120110_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120111 START ('2013-01-11 00:00:00'::timestamp without time zone) END ('2013-01-12 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120111', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120111_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120111_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120111_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120112 START ('2013-01-12 00:00:00'::timestamp without time zone) END ('2013-01-13 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120112', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120112_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120112_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120112_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120113 START ('2013-01-13 00:00:00'::timestamp without time zone) END ('2013-01-14 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120113', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120113_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120113_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120113_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120114 START ('2013-01-14 00:00:00'::timestamp without time zone) END ('2013-01-15 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120114', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120114_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120114_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120114_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120115 START ('2013-01-15 00:00:00'::timestamp without time zone) END ('2013-01-16 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120115', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120115_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120115_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120115_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120116 START ('2013-01-16 00:00:00'::timestamp without time zone) END ('2013-01-17 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120116', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120116_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120116_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120116_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120117 START ('2013-01-17 00:00:00'::timestamp without time zone) END ('2013-01-18 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120117', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120117_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120117_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120117_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120118 START ('2013-01-18 00:00:00'::timestamp without time zone) END ('2013-01-19 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120118', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120118_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120118_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120118_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120119 START ('2013-01-19 00:00:00'::timestamp without time zone) END ('2013-01-20 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120119', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120119_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120119_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120119_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120120 START ('2013-01-20 00:00:00'::timestamp without time zone) END ('2013-01-21 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120120', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120120_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120120_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120120_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120121 START ('2013-01-21 00:00:00'::timestamp without time zone) END ('2013-01-22 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120121', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120121_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120121_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120121_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120122 START ('2013-01-22 00:00:00'::timestamp without time zone) END ('2013-01-23 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120122', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120122_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120122_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120122_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120123 START ('2013-01-23 00:00:00'::timestamp without time zone) END ('2013-01-24 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120123', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120123_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120123_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120123_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120124 START ('2013-01-24 00:00:00'::timestamp without time zone) END ('2013-01-25 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120124', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120124_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120124_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120124_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120125 START ('2013-01-25 00:00:00'::timestamp without time zone) END ('2013-01-26 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120125', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120125_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120125_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120125_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120126 START ('2013-01-26 00:00:00'::timestamp without time zone) END ('2013-01-27 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120126', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120126_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120126_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120126_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  ), 
          PARTITION p20120127 START ('2013-01-27 00:00:00'::timestamp without time zone) END ('2013-01-28 00:00:00'::timestamp without time zone) WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120127', appendonly=false ) 
                  (
                  SUBPARTITION p7 VALUES('P7') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120127_2_prt_p7', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768), 
                  SUBPARTITION p8 VALUES('P8') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120127_2_prt_p8', appendonly=false ), 
                  SUBPARTITION p9 VALUES('P9') WITH (tablename='tb_fda_pdw_apd_detail_1_prt_p20120127_2_prt_p9', orientation=column, appendonly=true ) 
                            COLUMN product_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN equipment_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_seq_no ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN receive_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN factory_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN etl_insert_update_timestamp ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_data_group_id ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN apd_collection_code ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN character_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768) 
                            COLUMN number_data_value ENCODING (compresstype=zlib, compresslevel=5, blocksize=32768)
                  )
          );


ALTER TABLE sn2ro.tb_fda_pdw_apd_detail OWNER TO gpadmin;

--
-- Name: temp; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE temp (
    x integer,
    y integer
) DISTRIBUTED BY (x);


ALTER TABLE sn2ro.temp OWNER TO gpadmin;

--
-- Name: tmp01; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tmp01 (
    wdate character varying(8),
    ip integer,
    pcid integer,
    auctid integer
) DISTRIBUTED BY (ip);


ALTER TABLE sn2ro.tmp01 OWNER TO gpadmin;

--
-- Name: tmp_sn_tst_partition; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE tmp_sn_tst_partition (
    yyyymmdd character varying(8),
    yyyymm character varying(6),
    yyyy character varying(4),
    day double precision,
    month double precision,
    year double precision,
    monthname text,
    dayofyear double precision,
    weekdayname text,
    calendarweek double precision,
    formatteddate text,
    dt date,
    quartal text,
    yearquartal text,
    yearmonth text,
    yearcalendarweek text,
    weekend text,
    americanholiday text,
    austrianholiday text,
    canadianholiday text,
    period text,
    cwstart date,
    cwend date,
    monthstart date,
    monthend timestamp without time zone
) DISTRIBUTED BY (yyyymmdd);


ALTER TABLE sn2ro.tmp_sn_tst_partition OWNER TO gpadmin;

--
-- Name: tmp_sn_tst_partition_1_prt_p200212; Type: TABLE; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE TABLE tmp_sn_tst_partition_1_prt_p200212 (
    yyyymmdd character varying(8),
    yyyymm character varying(6),
    yyyy character varying(4),
    day double precision,
    month double precision,
    year double precision,
    monthname text,
    dayofyear double precision,
    weekdayname text,
    calendarweek double precision,
    formatteddate text,
    dt date,
    quartal text,
    yearquartal text,
    yearmonth text,
    yearcalendarweek text,
    weekend text,
    americanholiday text,
    austrianholiday text,
    canadianholiday text,
    period text,
    cwstart date,
    cwend date,
    monthstart date,
    monthend timestamp without time zone,
    CONSTRAINT sn_tst_partition_1_prt_p200212_check CHECK ((((yyyymmdd)::text >= '20021201'::text) AND ((yyyymmdd)::text < '20030101'::text)))
)
WITH (appendonly=false) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro.tmp_sn_tst_partition_1_prt_p200212 OWNER TO lr_dba;

--
-- Name: tmp_sn_tst_partition_1_prt_p200301; Type: TABLE; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE TABLE tmp_sn_tst_partition_1_prt_p200301 (
    yyyymmdd character varying(8),
    yyyymm character varying(6),
    yyyy character varying(4),
    day double precision,
    month double precision,
    year double precision,
    monthname text,
    dayofyear double precision,
    weekdayname text,
    calendarweek double precision,
    formatteddate text,
    dt date,
    quartal text,
    yearquartal text,
    yearmonth text,
    yearcalendarweek text,
    weekend text,
    americanholiday text,
    austrianholiday text,
    canadianholiday text,
    period text,
    cwstart date,
    cwend date,
    monthstart date,
    monthend timestamp without time zone,
    CONSTRAINT sn_tst_partition_1_prt_p200301_check CHECK ((((yyyymmdd)::text >= '20030101'::text) AND ((yyyymmdd)::text < '20030201'::text)))
)
WITH (appendonly=false) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro.tmp_sn_tst_partition_1_prt_p200301 OWNER TO lr_dba;

--
-- Name: tmp_sn_tst_partition_1_prt_p201106; Type: TABLE; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE TABLE tmp_sn_tst_partition_1_prt_p201106 (
    yyyymmdd character varying(8) ENCODING (compresslevel=1,compresstype=zlib,blocksize=32768),
    yyyymm character varying(6) ENCODING (compresslevel=1,compresstype=zlib,blocksize=32768),
    yyyy character varying(4) ENCODING (compresslevel=1,compresstype=zlib,blocksize=32768)
)
WITH (appendonly=true, compresslevel=1, orientation=column) DISTRIBUTED BY (yyyymmdd);


ALTER TABLE sn2ro.tmp_sn_tst_partition_1_prt_p201106 OWNER TO lr_dba;

--
-- Name: vw_postgres_log; Type: VIEW; Schema: sn2ro; Owner: gpadmin
--

CREATE VIEW vw_postgres_log AS
    SELECT postgres_log.log_time, postgres_log.user_name, postgres_log.database_name, postgres_log.process_id, postgres_log.thread_id, postgres_log.connection_from_host, postgres_log.connection_from_port, postgres_log.session_start_time, postgres_log.session_line_num, postgres_log.session_id, postgres_log.command_tag, postgres_log.what_2, postgres_log.what_3, postgres_log.what_4, postgres_log.what_5, postgres_log.what_6, postgres_log.level, postgres_log.sql_state_code, postgres_log.message, postgres_log.detail, postgres_log.hint, postgres_log.internal_query, postgres_log.internal_query_pos, postgres_log.context, postgres_log.query, postgres_log.query_pos, postgres_log.location, postgres_log.app_name, postgres_log.app_id FROM postgres_log WHERE (postgres_log.app_id <> ALL (ARRAY['1091'::text, '1526'::text, '799'::text, '396'::text]));


ALTER TABLE sn2ro.vw_postgres_log OWNER TO gpadmin;

--
-- Name: year_2002; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE year_2002 (
    id integer,
    year integer,
    month integer,
    day integer,
    region text
)
WITH (appendonly=true) DISTRIBUTED BY (id);


ALTER TABLE sn2ro.year_2002 OWNER TO gpadmin;

--
-- Name: 학진; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE "학진" (
    "한글abc" character varying(8)
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro."학진" OWNER TO gpadmin;

--
-- Name: 한글이름테이블; Type: TABLE; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

CREATE TABLE "한글이름테이블" (
    "한글컬럼a" character varying(8),
    "한글컬럼b" character varying(8)
) DISTRIBUTED BY ("한글컬럼a");


ALTER TABLE sn2ro."한글이름테이블" OWNER TO gpadmin;

SET search_path = sn2ro_err, pg_catalog;

--
-- Name: err_etc_gp_etl_log; Type: TABLE; Schema: sn2ro_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_etc_gp_etl_log (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro_err.err_etc_gp_etl_log OWNER TO gpadmin;

--
-- Name: err_partition_config; Type: TABLE; Schema: sn2ro_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_partition_config (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro_err.err_partition_config OWNER TO gpadmin;

--
-- Name: err_postgres_log; Type: TABLE; Schema: sn2ro_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_postgres_log (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro_err.err_postgres_log OWNER TO gpadmin;

--
-- Name: err_sn_adm_ddlsql; Type: TABLE; Schema: sn2ro_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_sn_adm_ddlsql (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro_err.err_sn_adm_ddlsql OWNER TO gpadmin;

--
-- Name: err_sn_tst_partition; Type: TABLE; Schema: sn2ro_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_sn_tst_partition (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro_err.err_sn_tst_partition OWNER TO gpadmin;

--
-- Name: err_snull; Type: TABLE; Schema: sn2ro_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_snull (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro_err.err_snull OWNER TO gpadmin;

--
-- Name: err_t0; Type: TABLE; Schema: sn2ro_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_t0 (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro_err.err_t0 OWNER TO gpadmin;

--
-- Name: err_table_2009_11; Type: TABLE; Schema: sn2ro_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_table_2009_11 (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro_err.err_table_2009_11 OWNER TO gpadmin;

--
-- Name: err_table_base; Type: TABLE; Schema: sn2ro_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_table_base (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro_err.err_table_base OWNER TO gpadmin;

--
-- Name: err_tb_fda_pdw_apd_detail; Type: TABLE; Schema: sn2ro_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_tb_fda_pdw_apd_detail (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro_err.err_tb_fda_pdw_apd_detail OWNER TO gpadmin;

--
-- Name: err_test; Type: TABLE; Schema: sn2ro_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_test (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro_err.err_test OWNER TO gpadmin;

--
-- Name: err_tmp_sn_tst_partition; Type: TABLE; Schema: sn2ro_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_tmp_sn_tst_partition (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro_err.err_tmp_sn_tst_partition OWNER TO gpadmin;

--
-- Name: err_tmp_sn_tst_partition_1_prt_p201106; Type: TABLE; Schema: sn2ro_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_tmp_sn_tst_partition_1_prt_p201106 (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro_err.err_tmp_sn_tst_partition_1_prt_p201106 OWNER TO gpadmin;

--
-- Name: sn_tst_partition; Type: TABLE; Schema: sn2ro_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE sn_tst_partition (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE sn2ro_err.sn_tst_partition OWNER TO gpadmin;

SET search_path = sn2ro_ext, pg_catalog;

--
-- Name: ext_etc_gp_etl_log; Type: EXTERNAL TABLE; Schema: sn2ro_ext; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_etc_gp_etl_log (
    sys_dvsn character varying(2),
    work_date character varying(8),
    pgm_nm character varying(100),
    job_seq integer,
    load_dvsn character varying(1),
    prj_nm character varying(100),
    table_nm character varying(100),
    base_date_fr date,
    base_date_to date,
    job_stt_date date,
    job_stt_time time(6) without time zone,
    job_end_date date,
    job_end_time time(6) without time zone,
    job_lead_time time(6) without time zone,
    proc_cnt bigint,
    norm_yn character varying(1),
    err_cd character varying(20),
    etc_ctx1 character varying(100),
    etc_ctx2 character varying(100),
    gp_upd_staff_no character varying(50),
    gp_upd_date timestamp without time zone
) LOCATION (
    'gpfdist://192.168.0.63:8080/etc_gp_etl_log.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UHC'
LOG ERRORS INTO sn2ro_err.err_etc_gp_etl_log SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sn2ro_ext.ext_etc_gp_etl_log OWNER TO gpadmin;

--
-- Name: ext_partition_config; Type: EXTERNAL TABLE; Schema: sn2ro_ext; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_partition_config (
    schemaname name,
    tablename name,
    appendonlytext text,
    compressleveltext text,
    orientationtext text,
    m_default_retention integer
) LOCATION (
    'gpfdist://192.168.0.63:8080/partition_config.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UHC'
LOG ERRORS INTO sn2ro_err.err_partition_config SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sn2ro_ext.ext_partition_config OWNER TO gpadmin;

--
-- Name: ext_postgres_log; Type: EXTERNAL TABLE; Schema: sn2ro_ext; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_postgres_log (
    log_time timestamp with time zone,
    user_name text,
    database_name text,
    process_id text,
    thread_id text,
    connection_from_host text,
    connection_from_port text,
    session_start_time timestamp with time zone,
    session_line_num bigint,
    session_id text,
    command_tag text,
    what_2 text,
    what_3 text,
    what_4 text,
    what_5 text,
    what_6 text,
    level text,
    sql_state_code text,
    message text,
    detail text,
    hint text,
    internal_query text,
    internal_query_pos integer,
    context text,
    query text,
    query_pos integer,
    location text,
    app_name text,
    app_id text
) LOCATION (
    'gpfdist://192.168.0.63:8080/postgres_log.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UHC'
LOG ERRORS INTO sn2ro_err.err_postgres_log SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sn2ro_ext.ext_postgres_log OWNER TO gpadmin;

--
-- Name: ext_sn_adm_ddlsql; Type: EXTERNAL TABLE; Schema: sn2ro_ext; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_sn_adm_ddlsql (
    seq character varying(10),
    sql text
) LOCATION (
    'gpfdist://192.168.0.63:8080/sn_adm_ddlsql.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UHC'
LOG ERRORS INTO sn2ro_err.err_sn_adm_ddlsql SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sn2ro_ext.ext_sn_adm_ddlsql OWNER TO gpadmin;

--
-- Name: ext_sn_tst_partition_r; Type: EXTERNAL TABLE; Schema: sn2ro_ext; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_sn_tst_partition_r (
    yyyymmdd character varying(8),
    yyyymm character varying(6),
    yyyy character varying(4),
    day double precision,
    month double precision,
    year double precision,
    monthname text,
    dayofyear double precision,
    weekdayname text,
    calendarweek double precision,
    formatteddate text,
    dt date,
    quartal text,
    yearquartal text,
    yearmonth text,
    yearcalendarweek text,
    weekend text,
    americanholiday text,
    austrianholiday text,
    canadianholiday text,
    period text,
    cwstart date,
    cwend date,
    monthstart date,
    monthend timestamp without time zone
) LOCATION (
    'gpfdist://mdw:8181/sn_tst_partition1.csv',
    'gpfdist://mdw:8182/sn_tst_partition2.csv',
    'gpfdist://mdw:8191/sn_tst_partition5.csv',
    'gpfdist://mdw:8192/sn_tst_partition6.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8'
LOG ERRORS INTO sn2ro_err.sn_tst_partition SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sn2ro_ext.ext_sn_tst_partition_r OWNER TO gpadmin;

--
-- Name: ext_sn_tst_partition_w; Type: EXTERNAL TABLE; Schema: sn2ro_ext; Owner: gpadmin; Tablespace: 
--

CREATE WRITABLE EXTERNAL TABLE ext_sn_tst_partition_w (
    yyyymmdd character varying(8),
    yyyymm character varying(6),
    yyyy character varying(4),
    day double precision,
    month double precision,
    year double precision,
    monthname text,
    dayofyear double precision,
    weekdayname text,
    calendarweek double precision,
    formatteddate text,
    dt date,
    quartal text,
    yearquartal text,
    yearmonth text,
    yearcalendarweek text,
    weekend text,
    americanholiday text,
    austrianholiday text,
    canadianholiday text,
    period text,
    cwstart date,
    cwend date,
    monthstart date,
    monthend timestamp without time zone
) LOCATION (
    'gpfdist://mdw:8181/sn_tst_partition1.csv',
    'gpfdist://mdw:8182/sn_tst_partition2.csv',
    'gpfdist://mdw:8191/sn_tst_partition5.csv',
    'gpfdist://mdw:8192/sn_tst_partition6.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UTF8' DISTRIBUTED RANDOMLY;


ALTER EXTERNAL TABLE sn2ro_ext.ext_sn_tst_partition_w OWNER TO gpadmin;

--
-- Name: ext_snull; Type: EXTERNAL TABLE; Schema: sn2ro_ext; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_snull (
    col01 character varying(10),
    col02 character varying(10),
    col03 text,
    col04 integer,
    col05 character(10),
    col06 character varying(10)
) LOCATION (
    'gpfdist://192.168.0.63:8080/snull.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UHC'
LOG ERRORS INTO sn2ro_err.err_snull SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sn2ro_ext.ext_snull OWNER TO gpadmin;

--
-- Name: ext_t0; Type: EXTERNAL TABLE; Schema: sn2ro_ext; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_t0 (
    custid integer,
    itemnr integer
) LOCATION (
    'gpfdist://192.168.0.63:8080/t0.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UHC'
LOG ERRORS INTO sn2ro_err.err_t0 SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sn2ro_ext.ext_t0 OWNER TO gpadmin;

--
-- Name: ext_table_2009_11; Type: EXTERNAL TABLE; Schema: sn2ro_ext; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_table_2009_11 (
    id integer,
    created timestamp without time zone,
    data text
) LOCATION (
    'gpfdist://192.168.0.63:8080/table_2009_11.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UHC'
LOG ERRORS INTO sn2ro_err.err_table_2009_11 SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sn2ro_ext.ext_table_2009_11 OWNER TO gpadmin;

--
-- Name: ext_table_base; Type: EXTERNAL TABLE; Schema: sn2ro_ext; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_table_base (
    id integer,
    created timestamp without time zone,
    data text
) LOCATION (
    'gpfdist://192.168.0.63:8080/table_base.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UHC'
LOG ERRORS INTO sn2ro_err.err_table_base SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sn2ro_ext.ext_table_base OWNER TO gpadmin;

--
-- Name: ext_test; Type: EXTERNAL TABLE; Schema: sn2ro_ext; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_test (
    col text
) LOCATION (
    'gpfdist://192.168.0.63:8080/test.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UHC'
LOG ERRORS INTO sn2ro_err.err_test SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sn2ro_ext.ext_test OWNER TO gpadmin;

--
-- Name: ext_tmp_sn_tst_partition; Type: EXTERNAL TABLE; Schema: sn2ro_ext; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_tmp_sn_tst_partition (
    yyyymmdd character varying(8),
    yyyymm character varying(6),
    yyyy character varying(4),
    day double precision,
    month double precision,
    year double precision,
    monthname text,
    dayofyear double precision,
    weekdayname text,
    calendarweek double precision,
    formatteddate text,
    dt date,
    quartal text,
    yearquartal text,
    yearmonth text,
    yearcalendarweek text,
    weekend text,
    americanholiday text,
    austrianholiday text,
    canadianholiday text,
    period text,
    cwstart date,
    cwend date,
    monthstart date,
    monthend timestamp without time zone
) LOCATION (
    'gpfdist://192.168.0.63:8080/tmp_sn_tst_partition.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UHC'
LOG ERRORS INTO sn2ro_err.err_tmp_sn_tst_partition SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sn2ro_ext.ext_tmp_sn_tst_partition OWNER TO gpadmin;

--
-- Name: ext_tmp_sn_tst_partition_1_prt_p201106; Type: EXTERNAL TABLE; Schema: sn2ro_ext; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_tmp_sn_tst_partition_1_prt_p201106 (
    yyyymmdd character varying(8),
    yyyymm character varying(6),
    yyyy character varying(4)
) LOCATION (
    'gpfdist://192.168.0.63:8080/tmp_sn_tst_partition_1_prt_p201106.csv'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UHC'
LOG ERRORS INTO sn2ro_err.err_tmp_sn_tst_partition_1_prt_p201106 SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE sn2ro_ext.ext_tmp_sn_tst_partition_1_prt_p201106 OWNER TO gpadmin;

SET search_path = webmt_sch, pg_catalog;

--
-- Name: app_t_gamelog_01; Type: TABLE; Schema: webmt_sch; Owner: lr_dba; Tablespace: 
--

CREATE TABLE app_t_gamelog_01 (
    work_ymd integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    startdate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    enddate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    logtype integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    serveridx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    channelidx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    userno bigint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    accountid character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    makecodeno integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    device character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    devicetype smallint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charname character varying(50) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charlevel integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    ip character varying(15) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charweekhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charheart integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    playtime integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768)
)
WITH (appendonly=true, compresslevel=5, orientation=column, compresstype=zlib) DISTRIBUTED BY (work_ymd);


ALTER TABLE webmt_sch.app_t_gamelog_01 OWNER TO lr_dba;

--
-- Name: app_t_gamelog_02; Type: TABLE; Schema: webmt_sch; Owner: lr_dba; Tablespace: 
--

CREATE TABLE app_t_gamelog_02 (
    work_ymd integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    startdate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    enddate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    logtype integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    serveridx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    channelidx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    userno bigint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    accountid character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    makecodeno integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    device character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    devicetype smallint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charname character varying(50) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charlevel integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    ip character varying(15) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charweekhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charheart integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    playtime integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768)
)
WITH (appendonly=true, compresslevel=5, orientation=column, compresstype=zlib) DISTRIBUTED BY (work_ymd);


ALTER TABLE webmt_sch.app_t_gamelog_02 OWNER TO lr_dba;

--
-- Name: app_t_gamelog_03; Type: TABLE; Schema: webmt_sch; Owner: lr_dba; Tablespace: 
--

CREATE TABLE app_t_gamelog_03 (
    work_ymd integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    startdate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    enddate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    logtype integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    serveridx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    channelidx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    userno bigint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    accountid character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    makecodeno integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    device character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    devicetype smallint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charname character varying(50) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charlevel integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    ip character varying(15) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charweekhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charheart integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    playtime integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768)
)
WITH (appendonly=true, compresslevel=5, orientation=column, compresstype=zlib) DISTRIBUTED BY (work_ymd);


ALTER TABLE webmt_sch.app_t_gamelog_03 OWNER TO lr_dba;

--
-- Name: app_t_gamelog_1; Type: TABLE; Schema: webmt_sch; Owner: lr_dba; Tablespace: 
--

CREATE TABLE app_t_gamelog_1 (
    work_ymd integer,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    logtype integer,
    serveridx integer,
    channelidx integer,
    userno bigint,
    accountid character varying(100),
    makecodeno integer,
    device character varying(100),
    devicetype smallint,
    charname character varying(50),
    charlevel integer,
    ip character varying(15),
    getscore integer,
    charhighscore integer,
    charweekhighscore integer,
    charheart integer,
    getexp integer,
    charexp integer,
    getcandy integer,
    charcandy integer,
    playtime integer
) DISTRIBUTED BY (work_ymd);


ALTER TABLE webmt_sch.app_t_gamelog_1 OWNER TO lr_dba;

--
-- Name: app_t_gamelog_2; Type: TABLE; Schema: webmt_sch; Owner: lr_dba; Tablespace: 
--

CREATE TABLE app_t_gamelog_2 (
    work_ymd integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    startdate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    enddate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    logtype integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    serveridx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    channelidx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    userno bigint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    accountid character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    makecodeno integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    device character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    devicetype smallint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charname character varying(50) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charlevel integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    ip character varying(15) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charweekhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charheart integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    playtime integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768)
)
WITH (appendonly=true, compresslevel=5, orientation=column, compresstype=zlib) DISTRIBUTED BY (work_ymd);


ALTER TABLE webmt_sch.app_t_gamelog_2 OWNER TO lr_dba;

--
-- Name: app_t_gamelog_3; Type: TABLE; Schema: webmt_sch; Owner: lr_dba; Tablespace: 
--

CREATE TABLE app_t_gamelog_3 (
    work_ymd integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    startdate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    enddate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    logtype integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    serveridx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    channelidx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    userno bigint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    accountid character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    makecodeno integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    device character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    devicetype smallint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charname character varying(50) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charlevel integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    ip character varying(15) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charweekhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charheart integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    playtime integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768)
)
WITH (appendonly=true, compresslevel=5, orientation=column, compresstype=zlib) DISTRIBUTED BY (work_ymd);


ALTER TABLE webmt_sch.app_t_gamelog_3 OWNER TO lr_dba;

--
-- Name: app_t_gamelog_31; Type: TABLE; Schema: webmt_sch; Owner: lr_dba; Tablespace: 
--

CREATE TABLE app_t_gamelog_31 (
    work_ymd integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    startdate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    enddate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    logtype integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    serveridx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    channelidx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    userno bigint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    accountid character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    makecodeno integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    device character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    devicetype smallint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charname character varying(50) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charlevel integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    ip character varying(15) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charweekhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charheart integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    playtime integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768)
)
WITH (appendonly=true, compresslevel=5, orientation=column, compresstype=zlib) DISTRIBUTED BY (work_ymd);


ALTER TABLE webmt_sch.app_t_gamelog_31 OWNER TO lr_dba;

--
-- Name: app_t_gamelog_32; Type: TABLE; Schema: webmt_sch; Owner: lr_dba; Tablespace: 
--

CREATE TABLE app_t_gamelog_32 (
    work_ymd integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    startdate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    enddate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    logtype integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    serveridx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    channelidx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    userno bigint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    accountid character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    makecodeno integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    device character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    devicetype smallint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charname character varying(50) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charlevel integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    ip character varying(15) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charweekhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charheart integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    playtime integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768)
)
WITH (appendonly=true, compresslevel=5, orientation=column, compresstype=zlib) DISTRIBUTED BY (work_ymd);


ALTER TABLE webmt_sch.app_t_gamelog_32 OWNER TO lr_dba;

--
-- Name: app_t_gamelog_33; Type: TABLE; Schema: webmt_sch; Owner: lr_dba; Tablespace: 
--

CREATE TABLE app_t_gamelog_33 (
    work_ymd integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    startdate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    enddate timestamp without time zone ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    logtype integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    serveridx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    channelidx integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    userno bigint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    accountid character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    makecodeno integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    device character varying(100) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    devicetype smallint ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charname character varying(50) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charlevel integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    ip character varying(15) ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charweekhighscore integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charheart integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charexp integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    getcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    charcandy integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768),
    playtime integer ENCODING (compresslevel=5,compresstype=zlib,blocksize=32768)
)
WITH (appendonly=true, compresslevel=5, orientation=column, compresstype=zlib) DISTRIBUTED BY (work_ymd);


ALTER TABLE webmt_sch.app_t_gamelog_33 OWNER TO lr_dba;

--
-- Name: app_t_itemlog_01; Type: TABLE; Schema: webmt_sch; Owner: lr_dba; Tablespace: 
--

CREATE TABLE app_t_itemlog_01 (
    work_ymd integer,
    eventdate timestamp without time zone,
    logtype integer,
    serveridx integer,
    channelidx integer,
    userno bigint,
    accountid character varying(100),
    makecodeno integer,
    device character varying(100),
    devicetype smallint,
    charname character varying(50),
    charlevel integer,
    ip character varying(15),
    itemtemplateid1 integer,
    itemtemplateid2 integer,
    itemtemplateid3 integer,
    chggold integer,
    chargold integer,
    chgcandy integer,
    charcandy integer,
    chgheart integer,
    charheart integer,
    storetype smallint,
    etc character varying(200)
) DISTRIBUTED BY (work_ymd);


ALTER TABLE webmt_sch.app_t_itemlog_01 OWNER TO lr_dba;

--
-- Name: app_t_player_01; Type: TABLE; Schema: webmt_sch; Owner: lr_dba; Tablespace: 
--

CREATE TABLE app_t_player_01 (
    userno bigint,
    joindate timestamp without time zone,
    lastlogin timestamp without time zone,
    life integer,
    lifeusetime timestamp without time zone,
    highscore integer,
    highdate timestamp without time zone,
    recentscore integer,
    recentdate timestamp without time zone,
    exp integer,
    money integer,
    gold integer,
    event character varying(50)
) DISTRIBUTED BY (userno);


ALTER TABLE webmt_sch.app_t_player_01 OWNER TO lr_dba;

SET search_path = webmt_sch_err, pg_catalog;

--
-- Name: err_app_t_player_01; Type: TABLE; Schema: webmt_sch_err; Owner: gpadmin; Tablespace: 
--

CREATE TABLE err_app_t_player_01 (
    cmdtime timestamp with time zone,
    relname text,
    filename text,
    linenum integer,
    bytenum integer,
    errmsg text,
    rawdata text,
    rawbytes bytea
) DISTRIBUTED RANDOMLY;


ALTER TABLE webmt_sch_err.err_app_t_player_01 OWNER TO gpadmin;

SET search_path = webmt_sch, pg_catalog;

--
-- Name: ext_app_t_player_01; Type: EXTERNAL TABLE; Schema: webmt_sch; Owner: gpadmin; Tablespace: 
--

CREATE EXTERNAL TABLE ext_app_t_player_01 (
    userno bigint,
    joindate timestamp without time zone,
    lastlogin timestamp without time zone,
    life integer,
    lifeusetime timestamp without time zone,
    highscore integer,
    highdate timestamp without time zone,
    recentscore integer,
    recentdate timestamp without time zone,
    exp integer,
    money integer,
    gold integer,
    event character varying(50)
) LOCATION (
    'gpfdist://172.16.57.91:9100/PLAYER_01.txt'
) FORMAT 'csv' (delimiter E',' null E'' escape E'"' quote E'"')
ENCODING 'UHC'
LOG ERRORS INTO webmt_sch_err.err_app_t_player_01 SEGMENT REJECT LIMIT 1000 ROWS;


ALTER EXTERNAL TABLE webmt_sch.ext_app_t_player_01 OWNER TO gpadmin;

SET search_path = sn2ro, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: sn2ro; Owner: lr_dba
--

ALTER TABLE dba_partition_master ALTER COLUMN id SET DEFAULT nextval('dba_partition_master_id_seq1'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: sn2ro; Owner: gpadmin
--

ALTER TABLE table_base ALTER COLUMN id SET DEFAULT nextval('table_base_id_seq'::regclass);


SET search_path = s2wlog, pg_catalog;

--
-- Name: datelookup_pkey; Type: CONSTRAINT; Schema: s2wlog; Owner: gpadmin; Tablespace: 
--

ALTER TABLE ONLY datelookup
    ADD CONSTRAINT datelookup_pkey PRIMARY KEY (daydate);


--
-- Name: dimension_time_pkey; Type: CONSTRAINT; Schema: s2wlog; Owner: gpadmin; Tablespace: 
--

ALTER TABLE ONLY dimension_time
    ADD CONSTRAINT dimension_time_pkey PRIMARY KEY (day_key);


SET search_path = sn2ro, pg_catalog;

--
-- Name: child_pkey; Type: CONSTRAINT; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

ALTER TABLE ONLY child
    ADD CONSTRAINT child_pkey PRIMARY KEY (key01, key02);


--
-- Name: dba_partition_config_pkey; Type: CONSTRAINT; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

ALTER TABLE ONLY dba_partition_config
    ADD CONSTRAINT dba_partition_config_pkey PRIMARY KEY (schemaname, tablename);


--
-- Name: dba_partition_log_pkey; Type: CONSTRAINT; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

ALTER TABLE ONLY dba_partition_log
    ADD CONSTRAINT dba_partition_log_pkey PRIMARY KEY (lognr);


--
-- Name: gp_kunnr_info_pkey; Type: CONSTRAINT; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

ALTER TABLE ONLY gp_customers
    ADD CONSTRAINT gp_kunnr_info_pkey PRIMARY KEY (kunnr_nr);


--
-- Name: parent_pkey; Type: CONSTRAINT; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

ALTER TABLE ONLY parent
    ADD CONSTRAINT parent_pkey PRIMARY KEY (key01);


--
-- Name: partition_config_0; Type: CONSTRAINT; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

ALTER TABLE ONLY partition_config
    ADD CONSTRAINT partition_config_0 PRIMARY KEY (schemaname, tablename);


--
-- Name: postgres_log_pkey; Type: CONSTRAINT; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

ALTER TABLE ONLY postgres_log
    ADD CONSTRAINT postgres_log_pkey PRIMARY KEY (log_time, app_id);


--
-- Name: sn_life_card_pkey; Type: CONSTRAINT; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

ALTER TABLE ONLY sn_life_card
    ADD CONSTRAINT sn_life_card_pkey PRIMARY KEY (cardnr, cardmonth);


--
-- Name: snull_0; Type: CONSTRAINT; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

ALTER TABLE ONLY snull
    ADD CONSTRAINT snull_0 PRIMARY KEY (col01, col02);


--
-- Name: table_2009_11_pkey; Type: CONSTRAINT; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

ALTER TABLE ONLY table_2009_11
    ADD CONSTRAINT table_2009_11_pkey PRIMARY KEY (id);


--
-- Name: table_base_pkey; Type: CONSTRAINT; Schema: sn2ro; Owner: gpadmin; Tablespace: 
--

ALTER TABLE ONLY table_base
    ADD CONSTRAINT table_base_pkey PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- Name: idx_data_temp_pk; Type: INDEX; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE INDEX idx_data_temp_pk ON data_temp USING btree (eqp_module_id, eqp_dcp_id, lot_id, substrate_id, status_cd, trace_dtts, weekday);


--
-- Name: idx_sum_value_01; Type: INDEX; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE INDEX idx_sum_value_01 ON sum_value USING btree (eqp_sum_rawid, sum_param_name, step_id, sum_dtts, sum_value, step_name);


--
-- Name: idx_trace_01; Type: INDEX; Schema: public; Owner: gpadmin; Tablespace: 
--

CREATE INDEX idx_trace_01 ON trace USING btree (eqp_module_id, eqp_dcp_id, lot_id, recipe_id, status_cd, start_dtts);


SET search_path = sn2ro, pg_catalog;

--
-- Name: sn_tst_partition_1; Type: INDEX; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE INDEX sn_tst_partition_1 ON sn_tst_partition USING btree (dt);


--
-- Name: sn_tst_partition_1_prt_p200212_dt_key; Type: INDEX; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE INDEX sn_tst_partition_1_prt_p200212_dt_key ON tmp_sn_tst_partition_1_prt_p200212 USING btree (dt);


--
-- Name: sn_tst_partition_1_prt_p200301_dt_key; Type: INDEX; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE INDEX sn_tst_partition_1_prt_p200301_dt_key ON tmp_sn_tst_partition_1_prt_p200301 USING btree (dt);


--
-- Name: sn_tst_partition_2; Type: INDEX; Schema: sn2ro; Owner: lr_dba; Tablespace: 
--

CREATE INDEX sn_tst_partition_2 ON sn_tst_partition USING btree (upper(monthname));


--
-- Name: manage_partitions; Type: TRIGGER; Schema: sn2ro; Owner: gpadmin
--

CREATE TRIGGER manage_partitions
    BEFORE INSERT ON table_base
    FOR EACH ROW
    EXECUTE PROCEDURE manage_partitions('2009-12-01');


--
-- Name: partitioning_trigger; Type: TRIGGER; Schema: sn2ro; Owner: gpadmin
--

CREATE TRIGGER partitioning_trigger
    BEFORE INSERT ON table_base
    FOR EACH ROW
    EXECUTE PROCEDURE partitioning_trigger();


--
-- Name: child_key01_fkey; Type: FK CONSTRAINT; Schema: sn2ro; Owner: lr_dba
--

ALTER TABLE ONLY child
    ADD CONSTRAINT child_key01_fkey FOREIGN KEY (key01) REFERENCES parent(key01);


--
-- Name: public; Type: ACL; Schema: -; Owner: gpadmin
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM gpadmin;
GRANT ALL ON SCHEMA public TO gpadmin;
GRANT ALL ON SCHEMA public TO lr_dba;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: sn2ro; Type: ACL; Schema: -; Owner: gpadmin
--

REVOKE ALL ON SCHEMA sn2ro FROM PUBLIC;
REVOKE ALL ON SCHEMA sn2ro FROM gpadmin;
GRANT ALL ON SCHEMA sn2ro TO gpadmin;
GRANT ALL ON SCHEMA sn2ro TO lr_oltp;


--
-- Name: count_ao(character varying, character varying); Type: ACL; Schema: sn2ro; Owner: gpadmin
--

REVOKE ALL ON FUNCTION count_ao(p_schema character varying, p_table character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION count_ao(p_schema character varying, p_table character varying) FROM gpadmin;
GRANT ALL ON FUNCTION count_ao(p_schema character varying, p_table character varying) TO gpadmin;
GRANT ALL ON FUNCTION count_ao(p_schema character varying, p_table character varying) TO PUBLIC;


--
-- Greenplum Database database dump complete
--

