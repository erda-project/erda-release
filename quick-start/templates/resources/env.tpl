# service addr
ADMIN_ADDR=admin:9095
CORE_SERVICES_ADDR=core-services:9526
DOP_ADDR=dop:9527
ECP_ADDR=ecp:9029
CMP_ADDR=cmp:9027
CLUSTER_MANAGER_ADDR=cluster-manager:9094
CLUSTER_DIALER_ADDR=cluster-dialer:80
MSP_ADDR=msp:8080
EVENTBOX_ADDR=eventbox:9528
SCHEDULER_ADDR=scheduler:9091
UC_ADDR=uc:8080
UI_ADDR=ui:80
QA_ADDR=qa:3033
CMDB_ADDR=cmdb:9093
PIPELINE_ADDR=pipeline:3081
DICEHUB_ADDR=dicehub:10000
OPENAPI_ADDR=openapi:9529
GITTAR_ADDR=gittar:5566
GITTAR_ADAPTOR_ADDR=gittar-adaptor:1086
UC_ADAPTOR_ADDR=uc-adaptor:12580
APIM_ADDR=uc-apim:3083
ORCHESTRATOR_ADDR=orchestrator:8081
KMS_ADDR=kms:3082
COLLECTOR_ADDR=collector:7076
SONAR_ADDR=addon-sonar.default.svc.cluster.local:9000
MONITOR_ADDR=monitor:7096
REGISTRY_ADDR=addon-registry.default.svc.cluster.local:5000
NEXUS_ADDR=addon-nexus.default.svc.cluster.local:8081
HEPA_ADDR=hepa:8080

# common
DEBUG=true
DICE_ON_DICE=xxxx

# kratos
UC_ENABLED=false
ORY_ENABLED=true
ORY_KRATOS_ADDR=kratos:4433
ORY_KRATOS_PRIVATE_ADDR=kratos:4434
SESSION_COOKIE_NAME=ory_kratos_session
KRATOS_PRIVATE_ADDR=kratos:4434
KRATOS_ADDR=kratos:4433
ORY_KRATOS_ADMIN_ADDR=kratos:4434

# openapi
SELF_PUBLIC_ADDR=one.erda.local:9529
SELF_PUBLIC_URL=openapi:9529
EXPORT_USER_WITH_ROLE=true
CUSTOM_NAMESPACE=local
FDP_UI_ADDR=fdp-ui:80
DICE_LOGIN_CALLBACK=http://one.erda.local:9529/logincb
COOKIE_DOMAIN=.erda.local
CSRF_COOKIE_DOMAIN=.erda.local
REDIRECT_URL_WHITE_LIST=http://uc.erda.local:8080/oauth/authorize
GOLANG_PROTOBUF_REGISTRATION_CONFLICT=ignore

# public urls
UC_PUBLIC_URL=http://uc.erda.local:8080
UC_PUBLIC_ADDR=uc.erda.local:8080
COLLECTOR_PUBLIC_ADDR=collector.erda.local
OPENAPI_PUBLIC_ADDR=openapi.erda.local
OPENAPI_PUBLIC_URL=http://openapi.erda.local
GITTAR_PUBLIC_ADDR=gittar.erda.local
GITTAR_PUBLIC_URL=http://gittar.erda.local

NEXUS_PUBLIC_URL=http://nexus-sys.dev.terminus.io
NEXUS_PASSWORD=e9FCb8h5cz1960rHLSPGq7H5k85eE9
NEXUS_USERNAME=admin

UI_PUBLIC_ADDR=one.erda.local
UI_PUBLIC_URL=http://one.erda.local
UC_CLIENT_ID=dice
UC_CLIENT_SECRET=secret
COLLECTOR_PUBLIC_URL=https://collector.erda.local
DICE_ROOT_DOMAIN=erda.local

# k8s
KUBERNETES_VERSION=v1.16.4
MASTER_MONITOR_ADDR=10.0.7.5:6443,10.0.7.6:6443,10.0.7.7:6443
KUBERNETES_VENDOR=cs
MASTER_ADDR=10.0.7.5:6443,10.0.7.6:6443,10.0.7.7:6443
HELM_REPO_URL=https://charts.erda.cloud/erda

# mysql
MYSQL_HOST=mysql
MYSQL_PORT=3306
MYSQL_PASSWORD=123456
MYSQL_DATABASE=erda
MYSQL_USERNAME=root

# redis
REDIS_SENTINELS_ADDR=redis-sentinel:26379
REDIS_SENTINELS=redis-sentinel:26379
REDIS_PASSWORD=123456
REDIS_MASTER_NAME=mymaster
REDIS_MASTER_HOST=redis

# kafka
BOOTSTRAP_SERVERS=kafka:9092

# zookeeper
ZOOKEEPER_ADDR=zookeeper:2181

# elasticsearch
ES_SECURITY_USERNAME=undefined
ES_URL=http://elasticsearch:9200
ES_SECURITY_ENABLE=false

# cassandra
CASSANDRA_ADDR=cassandra
CASSANDRA_SECURITY_USERNAME=cassandra
CASSANDRA_SECURITY_PASSWORD=cassandra
CASSANDRA_SECURITY_ENABLE=true

# etcd
ETCDCTL_API=3
ETCD_ENDPOINTS=http://etcd:2379

# sonar
SONAR_PUBLIC_URL=http://sonar-sys.erda.local
SONAR_ADMIN_TOKEN=123456
SONAR_ADMIN_PASSWORD=123456
AVATAR_STORAGE_URL=file:///avatars

# erda
ISTIO_INSTALLED=true

CMDB_CONTAINER_TOPIC=spot-metaserver_container

ISTIO_VERSION=1.6.12
LB_MONITOR_URL=http://10.0.7.7:80

CMDB_HOST_TOPIC=spot-metaserver_host
CMDB_GROUP=spot_cmdb_group

GLUSTERFS_MONITOR_URL=http://10.0.6.200:24007

ISTIO_ALIYUN=false

MASTER_VIP_ADDR=172.21.0.1:443
MASTER_VIP_URL=https://172.21.0.1:443
LB_ADDR=10.0.7.7:80

IS_FDP_CLUSTER=true
DICE_VERSION=%ERDA_VERSION%
DICE_PROTOCOL=http
DICE_SSH_USER=root
DICE_INSIDE=false
DICE_SIZE=test
CLUSTER_DNS=172.21.0.10
DICE_CLUSTER_TYPE=kubernetes
DICE_IS_EDGE=false
DICE_CLUSTER_NAME=erda-docker-mock
DICE_HTTPS_PORT=443
DICE_HTTP_PORT=80
DICE_STORAGE_MOUNTPOINT=/netdata
DICE_CPU_ORIGIN=0.300000
DICE_MEM_ORIGIN=512
DICE_CPU_REQUEST=0.050000
DICE_MEM_REQUEST=256
DICE_CPU_LIMIT=0.300000
DICE_MEM_LIMIT=512
