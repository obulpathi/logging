-- Register libraries
REGISTER /usr/lib/pig/piggybank.jar;

-- Shortcut definitions
DEFINE LogLoader org.apache.pig.piggybank.storage.apachelog.CombinedLogLoader();
DEFINE DayExtractor org.apache.pig.piggybank.evaluation.util.apachelogparser.DateExtractor('yyyy-MM-dd');

-- load the data
logs = LOAD '/root/data/raw.log' USING LogLoader as (remoteAddr, remoteLogname, user, time, method, uri, proto, status, bytes, referer, userAgent);

-- filter the data
SPLIT logs INTO good IF (bytes!='-' ), bad OTHERWISE;

-- select a sample from bad logs
-- some = SAMPLE logs 0.01;
-- records = GROUP some ALL;
records = GROUP bad ALL;

-- count
errors = FOREACH records GENERATE COUNT(bad);

-- dump or store
-- DUMP output
STORE errors INTO '/root/output/errors';
