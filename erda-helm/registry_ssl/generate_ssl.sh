#!/usr/bin/env bash

echo "$(dirname "${BASH_SOURCE[0]}")"
cd "$(dirname "${BASH_SOURCE[0]}")"


export ERDA_REGISTRY_NAME=${ERDA_REGISTRY_NAME:-"erda-registry"}

export ERDA_NAMESPACE=${ERDA_NAMESPACE:-"default"}
export KUBE_SERVICE_DNS_DOMAIN=${KUBE_SERVICE_DNS_DOMAIN:-"cluster.local"}


echo " openssl parameters -subj is:  /C=CN/ST=ZheJiang/L=Hangzhou/O=terminous.io/CN=${ERDA_REGISTRY_NAME}.${ERDA_NAMESPACE}.svc.${KUBE_SERVICE_DNS_DOMAIN}"

mkdir -p certs && openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/domain.key  -x509 -days 36500 -out certs/domain.crt -subj "/C=CN/ST=ZheJiang/L=Hangzhou/O=terminous.io/CN=${ERDA_REGISTRY_NAME}.${ERDA_NAMESPACE}.svc.${KUBE_SERVICE_DNS_DOMAIN}"



export REGISTRY_CRT=`cat certs/domain.crt | base64 | tr -d "\n"`
export REGISTRY_KEY=`cat certs/domain.key | base64 | tr -d "\n"`

# compose secrets and helm values files from telmpate files
envsubst < ./templates/registry-secret.yaml > ./registry-secret.yaml



