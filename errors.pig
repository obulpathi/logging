-- Register libraries
REGISTER /usr/lib/pig/piggybank.jar;

-- Shortcut definitions
DEFINE LogLoader org.apache.pig.piggybank.storage.apachelog.CombinedLogLoader();
DEFINE DayExtractor org.apache.pig.piggybank.evaluation.util.apachelogparser.DateExtractor('yyyy-MM-dd');

-- load the data
logs = LOAD '/root/data/errors.log' USING LogLoader as (remoteAddr, remoteLogname, user, time, method, uri, proto, status, bytes, referer, userAgent);
logs = LOAD '/root/data/user.log' USING LogLoader as (remoteAddr, remoteLogname, user, time, method, uri, proto, status, bytes, referer, userAgent);

-- filter the data
filtered_logs = FILTER logs BY bytes != '-';

-- Group records
grouped_logs = GROUP filtered_logs BY user;

-- Process logs
sum_bytes = FOREACH grouped_logs GENERATE group, SUM(filtered_logs.bytes);

-- DUMP sum_bytes;
STORE sum_bytes INTO '/root/output/sum_bytes';
