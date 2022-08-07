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
* [MySQL](https://www.mysql.com/)
* [Grafana](https://grafana.com/)

## Setup
Using Docker and Portainer

* MySQL -> AppTemplate
* Grafana -> [Grafana in Docker](https://grafana.com/docs/grafana/latest/setup-grafana/installation/docker/) 
* Robotframework and TestArchiver (./Dockerfile)
