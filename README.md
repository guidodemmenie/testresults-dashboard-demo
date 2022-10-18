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

Using Podman/Docker and Minikube

### Podman

``` bash
brew install podman
podman machine init --cpu 2
```

### Minikube

``` bash
brew install minikube
minikube start --driver=podman --container-runtime=containerd --insecure-registry "10.0.0.0/24" --cni=auto
minikube addons enable registry
```

`--insecure-registry "10.0.0.0/24"` to enable pulling images from minikube registry

`--cni=auto` to enable networking to work

### Containers

* PostgreSQL
  * [postgres.yaml](/postgres.yaml)
  * For more info: [github](https://github.com/docker-library/docs/blob/master/postgres/README.md)
* Grafana
  * [grafana.yaml](/grafana.yaml)
  * For more info: [grafana with docker](https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/)
* Robotframework and TestArchiver
  * [robotframework.yaml](/robotframework.yaml)
  * [Dockerfile](/Dockerfile)

To build the image for robotframework run

``` bash
minikube image build -t localhost:5000/robotframework:latest .
minikube image push localhost:5000/robotframework:latest
```

Apply all manifests

``` bash
kubectl apply -f namespace.yaml
kubectl apply -f postgres-secret.yaml
kubectl apply -f postgres-db-config.yaml
kubectl apply -f postgres.yaml
kubectl apply -f grafana.yaml
kubectl apply -f robotframework.yaml
```

Attach to the robotframework pod and run the script `generate-testresults.sh` and go to report.

Opening the services to access reports and grafana (in separate shells):

``` bash
minikube service rf-dashboard -n rf-dashboard-demo --url
minikube service rf-robotframework -n rf-dashboard-demo --url
```

To open the reports:
`http://localhost:<portnr>/<buildnr>/report.html`
To open first build:
`http://localhost:<portnr>/20280014/report.html`

## Grafana

The [grafana-dashboard.json](/grafana-dashboard.json) can be imported, the queries used are explaned here.

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
SELECT s.name as TestSuite, tc.name as TestCase, lm.message as LogMessage
FROM test_series_mapping tsm
JOIN test_run tr ON tsm.test_run_id = tr.id
JOIN test_result tres ON tr.id = tres.test_run_id
JOIN test_case tc ON tres.test_id = tc.id
JOIN suite s ON tc.suite_id = s.id
JOIN log_message lm ON tres.test_id = lm.test_id AND tsm.test_run_id = lm.test_run_id
WHERE
               tres.status = 'FAIL' and
               tsm.build_id = '${buildnr}' and
               lm.log_level = 'FAIL'

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

### Trend #testcases run per build

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

### Trend Pass/Fail over time

```sql
SELECT
  $__timeGroupAlias(generated,$__interval),
  count(tres.status) AS "PASS"
FROM test_run tr
    JOIN test_result tres ON tr.id = tres.test_run_id
    JOIN test_case tc ON tres.test_id = tc.id
WHERE
  $__timeFilter(generated) AND
  tres.status = 'PASS'
GROUP BY 1
ORDER BY 1
```
