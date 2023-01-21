#!/bin/bash

kubectl apply -f namespace.yaml
kubectl apply -f postgres-secret.yaml
kubectl apply -f postgres-db-config.yaml
kubectl apply -f postgres.yaml
kubectl apply -f grafana.yaml
kubectl apply -f robotframework.yaml