-- Register libraries
REGISTER /usr/lib/pig/piggybank.jar;

-- Shortcut definitions
DEFINE LogLoader org.apache.pig.piggybank.storage.apachelog.CombinedLogLoader();
DEFINE DayExtractor org.apache.pig.piggybank.evaluation.util.apachelogparser.DateExtractor('yyyy-MM-dd');

-- load the data
logs = LOAD '/root/data/countries.log' USING LogLoader as (remoteAddr, country, user, time, method, uri, proto, status, bytes, referer, userAgent);

-- Describe logs
DESCRIBE logs;

-- filter the data
filtered_logs = FILTER logs BY bytes != '-';

-- Describe filtered_logs
DESCRIBE filtered_logs;

-- Group records
grouped_logs = GROUP filtered_logs BY country;

-- Process logs
sum_bytes = FOREACH grouped_logs GENERATE group, SUM(filtered_logs.bytes);

DUMP sum_bytes;
