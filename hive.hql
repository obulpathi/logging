-- This is a Hive program. Hive is an SQL-like language that compiles
-- into Hadoop Map/Reduce jobs. It's very popular among data analysts
-- because it allows them to query enormous Hadoop data stores using
-- a language much like SQL.

-- Logs are stored on the Hadoop Distributed File System, in the
-- directory /root/logs/.  They're ordinary Apache logs in *.gz format.
--
-- We want to pretend that these gzipped log files are a database table,
-- and use a regular expression to split lines into database columns.

Options: CLI, JDBC; ODBC;

Data: Tables / Partitions / Buckets

hive
hive -f script.q
hive -e 'SELECT * FROM dummy'
hive -e "CREATE TABLE dummy (value STRING); LOAD DATA LOCAL INPATH '/tmp/dummy.txt' OVERWRITE INTO TABLE dummy"

SHOW TABLES;
DROP TABLE <table>;

CREATE TABLE logs(
  host STRING,
  identity STRING,
  user STRING,
  time STRING,
  request STRING,
  status STRING,
  size STRING,
  referer STRING,
  agent STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
  'input.regex'='^(\\S+) \\S+ \\S+ \\[([^\\[]+)\\] "(\\w+) (\\S+) (\\S+)" (\\d+) (\\d+) "([^"]+)" "([^"]+)".*'
);

LOAD DATA LOCAL INPATH '/root/data/hive.log' OVERWRITE INTO TABLE logs;

SELECT * from logs;













IO Formats:

"input.regex" = "([^ ]*) ([^ ]*) ([^ ]*) (-|\\[[^\\]]*\\]) ([^ \"]*|\"[^\"]*\") (-|[0-9]*) (-|[0-9]*)(?: ([^ \"]*|\"[^\"]*\") ([^ \"]*|\"[^\"]*\"))?"
"input.regex" = "([^ ]*) ([^ ]*) ([^ ]*) (-|\\[[^\\]]*\\]) ([^ \"]*|\"[^\"]*\") (-|[0-9]*) (-|[0-9]*)(?: ([^ \"]*|\"[^\"]*\") ([^ \"]*|\"[^\"]*\"))?"
"output.format.string" = "%1$s %2$s %3$s %4$s %5$s %6$s %7$s %8$s %9$s"
