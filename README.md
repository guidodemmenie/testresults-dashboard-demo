# dashboard-demo-data-generation

## Goal
Generate testresults to be put on a dashboard.

* TestSuite with passed testcases
* TestSuite with passed and flakey testcases
* TestSuite with testcases that aren't run once in a while
* One run completely fails

## Requirements
* [Robotframework](https://robotframework.org/)
* [TestArchiver](https://github.com/salabs/TestArchiver)
* [PostgreSQL](https://www.postgresql.org)
* [Grafana](https://grafana.com/)

## Setup
Using Docker and Portainer

* PostgreSQL -> AppTemplate
* Grafana -> [Grafana in Docker](https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/) 
* Robotframework and TestArchiver (./Dockerfile)

Run Script `generate-testresults.sh` and go to report.

## Grafana

### Variables
`buildnr` should be created
```sql
select distinct build_id from test_series_mapping tsm 
```

### Pass/Fail
```sql
select count(status) as PASS from 
    (select s.status from test_result s
    join test_series_mapping m on m.test_run_id = s.test_run_id
    join test_series ts on ts.id = m.series
    where status = 'PASS' and m.build_id = '${buildnr}' ) AS derived_table
```

### Errors
```sql
SELECT tc.name as TestCase, lm.message as LogMessage
FROM test_series_mapping tsm
    JOIN test_run tr ON tsm.test_run_id = tr.id
    JOIN test_result tres ON tr.id = tres.test_run_id
    JOIN test_case tc ON tres.test_id = tc.id 
    JOIN log_message lm ON tres.test_id = lm.test_id AND tsm.test_run_id = lm.test_run_id
WHERE 
   tres.status = 'FAIL' and 
   tsm.build_id = '${buildnr}' and
   lm.log_level = 'FAIL'
```

### Trend #testcases run per build*
```sql
SELECT
  $__timeGroupAlias(generated,$__interval),
  count(tc.id) AS "#testcases"
FROM test_run tr
    JOIN test_result tres ON tr.id = tres.test_run_id 
    JOIN test_case tc ON tres.test_id = tc.id
WHERE
  $__timeFilter(generated)
GROUP BY 1
ORDER BY 1
```