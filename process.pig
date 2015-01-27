-- In many ways, programming in Pig Latin is like working at the level of an
-- RDBMS query planner, which figures out how to turn a declarative statement
-- into a system of steps.

-- Register libraries
REGISTER /usr/lib/pig/piggybank.jar;

-- Shortcut definitions
DEFINE LogLoader org.apache.pig.piggybank.storage.apachelog.CombinedLogLoader();
DEFINE DayExtractor org.apache.pig.piggybank.evaluation.util.apachelogparser.DateExtractor('yyyy-MM-dd');

-- load the data
logs = LOAD '/root/data/user.log' USING LogLoader as (remoteAddr, project, user, time, method, uri, proto, status, bytes, referer, userAgent);

-- Describe logs
DESCRIBE logs;

-- filter the data
filtered_logs = FILTER logs BY bytes != '-';

-- Group records
grouped_logs = GROUP filtered_logs BY user;

-- Process logs
sum_bytes = FOREACH grouped_logs GENERATE group, SUM(filtered_logs.bytes);

DUMP sum_bytes;
-- STORE sum_bytes INTO '/root/output/sum_bytes';
