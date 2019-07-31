#!/usr/bin/env bash

# Docker image
# dockerpath="kbaafi/boston-houseprices-inference:latest"

# Kubernetes manifest for namespace =/.kubernetes/manifest.yaml
# create namespace
kubectl create -f .kubernetes/namespace.yaml

# Kubernetes deployment manifest =/.kubernetes/deployment.yaml
kubectl create -f .kubernetes/deployment.yaml

# Kubernetes manifest for service =/.kubernetes/service.yaml
kubectl create -f .kubernetes/service.yaml

# List of pods
kubectl get pods --namespace=boston-house-prices

# List of services
kubectl get svc -n boston-house-prices

