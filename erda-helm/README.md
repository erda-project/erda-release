# Erda Helm Chart 完整参数配置说明

本文档描述 Erda Helm Chart 支持的所有配置参数，包括 Erda 及 Erda 依赖的中间件的参数配置。  

Erda helm chart 包支持两种部署模式（`prod`和`demo`），对于资源类参数（如 CPU、Memory 以及 Storage）和副本数量等参数，因部署的模式不同而分别设置有对应的默认值。


## 全局参数

| 参数 | 描述 | 默认值 |
|:----|:---:|:---:|
| global.size | Erda 平台组件的部署方式，支持两种部署方式: demo 和 prod | demo |
| global.image.repository | Erda 组件镜像仓库 | registry.erda.cloud/erda |
| global.image.imagePullPolicy | 镜像拉取策略 | IfNotPresent |
| global.imagePullSecrets | 私有镜像拉取使用 secrets | [] |
| tags.work | / | / |
| tags.master | / | / |


## Cassandra 参数

### 参数说明

下表中：
* **demo** 表示对应 demo 部署模式的参数默认值
* **prod** 表示对应 prod 部署模式的参数默认值

| 参数 | 描述 | 默认值 |
|:----|:---|:---:|
| cassandra.operatorImageTag | cassandra-operator 镜像 tag (版本) | v1.1.3-release |
| cassandra.cassandraImageTag | cassandra 镜像 tag (版本) | 3.11.10 |
| cassandra.storageClassName | 存储 StorageClass 的名称 | "dice-local-volume" |
| cassandra.capacity | cassandra 单节点存储容量 | **prod**: 1000Gi <br> **demo**: 50Gi |
| cassandra.resources.requests.cpu | cassandra 实例的 cpu 资源请求数量 | **prod**: 2 <br> **demo**: 100m |
| cassandra.resources.requests.memory | cassandra 实例的 memory 资源请求数量 | **prod**: 4Gi <br> **demo**: 512Mi |
| cassandra.resources.limits.cpu | cassandra 实例的 cpu 资源限制数量 |**prod**: 4 <br> **demo**: 500m |
| cassandra.resources.limits.memory | cassandra 实例的 memory 资源限制数量 | **prod**: 16Gi <br> **demo**: 2048Mi |
| cassandra.racks| racks 列表，包含每个 rack 的名称, rack 的数量决定了高可用部署时 cassandra 实例的副本数量| - name: rack1 <br> - name: rack2 <br> - name: rack3 |

### 高可用配置说明

其中 cassandra operator 资请求较少，且单实例部署，不区分生产环境和 demo 环境配置
* request
    * cpu: 10m
    * memory: 50Mi
* limit
    * cpu: 1
    * memory: 512Mi


### Cassandra 高可用资源配置建议
针对不同节点规模的集群的高可用配置建议如下表所示：

| 集群规模 | 0～50 nodes | 50～100 nodes | 100～200 nodes | 200～300 nodes | 300+ nodes |
|:---|:---:|:---:|:---:|:---:|:---:|
| cassandra.resources.requests.cpu| "1" | "2" | "4" | "4" | "4" |
| cassandra.resources.requests.memory | "6Gi" | "12Gi" | "16Gi" | "16Gi" | "16Gi" |
| cassandra.resources.limits.cpu| "2" | "4" | "6" | "6" | "6" |
| cassandra.resources.limits.memory | "12Gi" | "16Gi" | "24Gi" | "24Gi" | "24Gi" |
| cassandra.capacity | 512G | 1T | 1.5T | 1.5T | 2T |
| cassandra.racks | 3 | 3 | 3-5 | 5-7 | 7 |



## ElasticSearch 参数

### 参数说明

下表中：
* **demo** 表示对应 demo 部署模式的参数默认值
* **prod** 表示对应 prod 部署模式的参数默认值

| 参数 | 描述 | 默认值 |
|:----|:---|:---:|
| elasticsearch.tag |ElasticSearch 镜像的 tag | 6.2.4 |
| elasticsearch.replicas | ElasticSearch 实例的副本数量 | **prod**: 3<br>**demo**: 1 |
| elasticsearch.numberOfMasters | 高可用部署时可作为 master 的节点的数量（设置为至少集群节点数量/2 + 1）|  **prod**: 2<br>**demo**: 1 |
| elasticsearch.storageClassName | 存储 StorageClass 的名称 | "dice-local-volume" |
| elasticsearch.capacity | ElasticSearch 单节点存储容量 |  **prod**: 1000Gi<br>**demo**: 50Gi |
| elasticsearch.javaOpts | ElasticSearch JAVA_OPTS (java heap size 建议设置为 0.75 * resources.limits.memory )|  **prod**: "-Xms6144m -Xmx6144m"<br>**demo**: "-Xms1024m -Xmx1024m" |
| elasticsearch.resources.requests.cpu | ElasticSearch 实例的 cpu 资源请求数量 | **prod**: 2<br>**demo**: 100m |
| elasticsearch.resources.requests.memory | ElasticSearch 实例的 memory 资源请求数量 | **prod**: 4Gi<br>**demo**: 512Mi |
| elasticsearch.resources.limits.cpu | ElasticSearch 实例的 cpu 资源限制数量 | **prod**: 4<br>**demo**: 500m |
| elasticsearch.resources.limits.memory | ElasticSearch 实例的 memory 资源限制数量 | **prod**: 8Gi<br>**demo**: 2048Mi |


### ElasticSearch 资源配置建议
针对不同节点规模的集群的高可用配置建议如下表所示：

| 集群规模 | 0～50 nodes | 50～100 nodes | 100～200 nodes | 200～300 nodes | 300+ nodes |
|:---|:---:|:---:|:---:|:---:|:---:|
| elasticsearch.resources.requests.cpu| "1" | "2" | "4" | "4" | "4" |
| elasticsearch.resources.requests.memory | "4Gi" | "8Gi" | "16Gi" | "16Gi" | "16Gi" |
| elasticsearch.resources.limits.cpu| "2" | "4" | "6" | "6" | "6" |
| elasticsearch.resources.limits.memory | "8Gi" | "16Gi" | "24Gi" | "24Gi" | "24Gi" |
| elasticsearch.capacity | 512G | 768G | 1T | 1.5T | 1.5T |
| elasticsearch.replicas | 3 | 3 | 3 | 3 | 5 |
| elasticsearch.numberOfMasters | 2 | 2 | 2 | 2 | 3|


## Etcd 参数

下表中：
* **demo** 表示对应 demo 部署模式的参数默认值
* **prod** 表示对应 prod 部署模式的参数默认值

| 参数 | 描述 | 默认值 |
|:----|:---|:---:|
| etcd.tag | etcd 镜像的 tag | 3.3.15-0 |
| etcd.storageClassName | 存储 StorageClass 的名称 | "dice-local-volume" |
| etcd.capacity | etcd 单节点存储容量 | **prod**: 32Gi<br>**demo**: 8Gi |
| etcd.resources.requests.cpu | etcd 实例的 cpu 资源请求数量 | **prod**: 1<br>**demo**: 100m |
| etcd.resources.requests.memory | etcd 实例的 memory 资源请求数量 | **prod**: 2Gi<br>**demo**: 512Mi |
| etcd.resources.limits.cpu | etcd 实例的 cpu 资源限制数量 | **prod**: 4<br>**demo**: 500m |
| etcd.resources.limits.memory | etcd 实例的 memory 资源限制数量 | **prod**: 8Gi<br>**demo**: 2048Mi |


## Zookeeper 参数

下表中：
* **demo** 表示对应 demo 部署模式的参数默认值
* **prod** 表示对应 prod 部署模式的参数默认值

| 参数 | 描述 | 默认值 |
|:----|:---|:---:|
| zookeeper.tag | zookeeper 镜像的 tag | 3.4.13-monitor |
| zookeeper.storageClassName | 存储 StorageClass 的名称 | "dice-local-volume" |
| zookeeper.capacity | zookeeper 单节点存储容量 | **prod**: 32Gi<br>**demo**: 4Gi |
| zookeeper.resources.requests.cpu | zookeeper 实例的 cpu 资源请求数量 | **prod**: 100m<br>**demo**: 100m |
| zookeeper.resources.requests.memory | zookeeper 实例的 memory 资源请求数量 | **prod**: 256Mi<br>**demo**: 256Mi |
| zookeeper.resources.limits.cpu | zookeeper 实例的 cpu 资源限制数量 | **prod**: 1<br>**demo**: 500m |
| zookeeper.resources.limits.memory | zookeeper 实例的 memory 资源限制数量 | **prod**: 512Mi<br>**demo**: 512Mi |



## Kafka 参数

### 参数说明

下表中：
* **demo** 表示对应 demo 部署模式的参数默认值
* **prod** 表示对应 prod 部署模式的参数默认值

| 参数 | 描述 | 默认值 |
|:----|:---|:---:|
| kafka.tag | kafka 镜像的 tag | 1.1.0-20210323-be01a9b |
| kafka.storageClassName | 存储 StorageClass 的名称 | "dice-local-volume" |
| kafka.capacity | kafka 单节点存储容量 | **prod**: 100Gi<br>**demo**: 16Gi |
| kafka.javaOpts | kafka JAVA_OPTS (建议设置为 0.75 * resources.limits.memory )| **prod**: "-Xms6144m -Xmx6144m" <br>**demo**: "-Xms1024m -Xmx1024m" |
| kafka.resources.requests.cpu | kafka 实例的 cpu 资源请求数量 | **prod**: 2<br>**demo**: 100m |
| kafka.resources.requests.memory | kafka 实例的 memory 资源请求数量 | **prod**: 4Gi<br>**demo**: 512Mi |
| kafka.resources.limits.cpu | kafka 实例的 cpu 资源限制数量 | **prod**: 4<br>**demo**: 500m |
| kafka.resources.limits.memory | kafka 实例的 memory 资源限制数量 | **prod**: 8Gi<br>**demo**: 2Gi |

### Kafka 资源配置建议
针对不同节点规模的集群的高可用配置建议如下表所示：

| 集群规模 | 0～50 nodes | 50～100 nodes | 100～200 nodes | 200～300 nodes | 300+ nodes |
|:----|:---:|:---:|:---:|:---:|:---:|
| kafka.resources.requests.cpu| "0.5" | "1" | "1" | "1" | "2" |
| kafka.resources.requests.memory | "1Gi" | "2Gi" | "2Gi" | “2Gi" | "4Gi" |
| kafka.resources.limits.cpu| "1" | "2" | "2" | "2" | "4" |
| kafka.resources.limits.memory | "2Gi" | "4Gi" | "4Gi" | "4Gi" | "8Gi" |
| kafka.capacity | 150G | 150G | 200G | 300G | 300G |


## kms 参数

下表中：
* **demo** 表示对应 demo 部署模式的参数默认值
* **prod** 表示对应 prod 部署模式的参数默认值

| 参数 | 描述 | 默认值 |
|:----|:---|:---:|
| kms.tag | kms 镜像的 tag | 1.0.0-20200608-f11445f |
| kms.replicas | 高可用部署时 kms 实例副本数量 | **prod**: 2<br>**demo**: 1 |
| kms.resources.requests.cpu | kms 实例的 cpu 资源请求数量 | **prod**: 500m<br>**demo**: 100m |
| kms.resources.requests.memory | kms 实例的 memory 资源请求数量 | **prod**: 1Gi<br>**demo**: 256Mi |
| kms.resources.limits.cpu | kms 实例的 cpu 资源限制数量 | **prod**: 1<br>**demo**: 500m |
| kms.resources.limits.memory | kms 实例的 memory 资源限制数量 | **prod**: 2048Mi<br>**demo**: 1024Mi |


## mysql 参数

### mysql 参数列表

下表中：
* **demo** 表示对应 demo 部署模式的参数默认值
* **prod** 表示对应 prod 部署模式的参数默认值
* **custom** 表示接入已有 mysql 示例而不是部署 mysql 的情况下需要提供的 mysql 访问连接信息

| 参数 | 描述 | 默认值 |
|:----|:---|:---:|
| mysql.tag | mysql 镜像的 tag | 5.7.34 |
| mysql.user | 数据库访问用户名| erda  |
| mysql.database | 据库访问目标数据库 | erda |
| mysql.password | 数据库访问密码| password |
| mysql.storageClassName | 存储 StorageClass 的名称 | "dice-local-volume" |
| mysql.capacity | mysql 单节点存储容量 | **prod**: 100Gi<br>**demo**: 10Gi |
| mysql.resources.requests.cpu | mysql 实例的 cpu 资源请求数量 | **prod**: 500m<br>**demo**: 100m |
| mysql.resources.requests.memory | mysql 实例的 memory 资源请求数量 | **prod**: 512Mi<br>**demo**: 256Mi |
| mysql.resources.limits.cpu | kmysql 实例的 cpu 资源限制数量 | **prod**: 2<br>**demo**: 500m |
| mysql.resources.limits.memory | mysql 实例的 memory 资源限制数量 | **prod**: 2Gi<br>**demo**: 1024Mi |
| **custom**|  |  |
| mysql.custom.address | 接入 mysql 的地址 | / |
| mysql.custom.port | 接入 mysql 的端口 | / |
| mysql.custom.database | 接入 mysql 的数据库 | / |
| mysql.custom.user | 访问接入 mysql 的用户名 | / |
| mysql.custom.password | 访问接入 mysql 的密码 | / |


### 接入外部 Mysql
如需接入外部 Mysql，可以通过修改 Erda 的 chart 包的 values.yaml 增加如下字段设置实现:

```yaml
mysql:
  enabled: false
  custom:
    address:      #  eg: 192.168.100.100
    port:         #  eg: 3306
    database:     #  eg: erda
    user:         #  eg: root
    password:     #  eg: HasdDwqwe23#

```
通过加入以上配置，在 Erda 部署过程中就不再部署 Mysql 组件，Erda 组件直接使用用户提供的 Mysql 数据库。

具体参数解释如下：

| 参数 | 描述 |
|:----|:---|
| mysql.enabled | 开关，接入用户提供的 mysql 时，必须设置为 false |
| mysql.custom.address | 接入用户提供的 mysql 主机地址 |
| mysql.custom.port | 接入用户提供的 mysql 主机端口 |
| mysql.custom.databases | 接入用户提供的 mysql 数据库 |
| mysql.custom.user | 接入用户提供的 mysql 数据库的访问用户名 |
| mysql.custom.password | 接入用户提供的 mysql 数据库的访问用户名对应的访问密码 |



## redis 参数

### redis operator 参数

说明：
* 由于 redis operator 本身资源占用较少，因此 prod 部署模式和 demo 部署模式 resources 使用相同的配置

| 参数 | 描述 | 默认值 |
|:----|:---|:---:|
| redis.redisOperator.tag | redis operator 镜像的 tag | 1.0.0-20200723-1a7a9f14 |
| redis.redisOperator.resources.requests.cpu | redis operator 实例的 cpu 资源请求数量 | 10m |
| redis.redisOperator.resources.requests.memory | redis operator 实例的 memory 资源请求数量 | 10Mi |
| redis.redisOperator.resources.limits.cpu | redis operator 实例的 cpu 资源限制数量 | 500m |
| redis.redisOperator.resources.limits.memory | redis operator 实例的 memory 资源限制数量 | 512Mi |


### redis failover 参数

下表中：
* **demo** 表示对应 demo 部署模式的参数默认值
* **prod** 表示对应 prod 部署模式的参数默认值

说明：
* 由于 redis sentinel 本身资源占用较少，因此 prod 部署模式和 demo 部署模式 resources 使用相同的配置

| 参数 | 描述 | 默认值 |
|:----|:---|:---:|
| redis.redisFailover.tag | redis 镜像的 tag | 3.2.12 |
| redis.redisFailover.secret | redis auth 授权认证密码（Base64 加密） | aUVWSUk2TFk2RWJyYzRIWA== |
| redis.redisFailover.redis.replicas | redis 实例服本数量 | **prod**: 2<br>**demo**: 1 |
| redis.redisFailover.redis.resources.requests.cpu | redis 实例的 cpu 资源请求数量 | **prod**: 150m<br>**demo**: 100m |
| redis.redisFailover.redis.resources.requests.memory | redis 实例的 memory 资源请求数量 | **prod**: 1Gi<br>**demo**: 256Mi |
| redis.redisFailover.redis.resources.limits.cpu | redis 实例的 cpu 资源限制数量 | **prod**: 300m<br>**demo**: 200m |
| redis.redisFailover.redis.resources.limits.memory | redis 实例的 memory 资源限制数量 | **prod**: 2Gi<br>**demo**: 1Gi |
| redis.redisFailover.sentinel.replicas | redis sentinel 实例服本数量 | **prod**: 3<br>**demo**: 1 |
| redis.redisFailover.sentinel.resources.requests.cpu | redis sentinel 实例的 cpu 资源请求数量 | 50m |
| redis.redisFailover.sentinel.resources.requests.memory | redis sentinel 实例的 memory 资源请求数量 | 64Mi |
| redis.redisFailover.sentinel.resources.limits.cpu | redis sentinel 实例的 cpu 资源限制数量 | 200m |
| redis.redisFailover.sentinel.resources.limits.memory | redis sentinel 实例的 memory 资源限制数量 | 256Mi |



## registry 参数

### 参数说明

下表中：
* **demo** 表示对应 demo 部署模式的参数默认值
* **prod** 表示对应 prod 部署模式的参数默认值
* **registry.custom** 表示自定义部署 registry到指定节点

| 参数 | 描述 | 默认值 |
|:----|:---|:---:|
| registry.tag | registry 镜像的 tag | 2.7.1 |
| registry.storageClassName | 存储 StorageClass 的名称 | "dice-local-volume" |
| registry.capacity | registry 单节点存储容量 | **prod**: 1000Gi<br>**demo**: 50Gi |
| registry.resources.requests.cpu | registry 实例的 cpu 资源请求数量 | **prod**: 500m<br>**demo**: 100m |
| registry.resources.requests.memory | registry 实例的 memory 资源请求数量 | **prod**: 512Mi<br>**demo**: 256Mi |
| registry.resources.limits.cpu | registry 实例的 cpu 资源限制数量 | **prod**: 1<br>**demo**: 500m |
| registry.resources.limits.memory | registry 实例的 memory 资源限制数量 | **prod**: 1Gi<br>**demo**: 512Mi |
| registry.networkMode | 如果值为 "host" 则设置 registry 容器网络模式为 host 模式 | / |
| **registry.custom** |  |  |
| registry.custom.nodeName | registry 采用 host 模式部署的节点名，此时registry 会部署在该节点，并且容器网络模式为 host 模式 | / |
| registry.custom.nodeIP | registry 采用 host 模式部署时节点的 IP 地址 | / |

## sonar 参数

下表中：
* **demo** 表示对应 demo 部署模式的参数默认值
* **prod** 表示对应 prod 部署模式的参数默认值

| 参数 | 描述 | 默认值 |
|:----|:---|:---:|
| sonar.tag | sonar 镜像的 tag | 8.4.2 |
| sonar.token | sonar admin 授权认证 token（Base64 加密） | LY9DepZ7iDUsyH8TFoDR85ok7y2nw1 |
| sonar.password | sonar admin auth 授权认证密码（Base64 加密） | 78tE846484lQQFUwY51h0Yr96ZQ063 |
| sonar.ingressHost | sonar 访问域名 | "sonar.erda.io" |
| sonar.resources.requests.cpu | sonar 实例的 cpu 资源请求数量 | **prod**: 750m<br>**demo**: 100m |
| sonar.resources.requests.memory | sonar 实例的 memory 资源请求数量 | **prod**: 1536Mi<br>**demo**: 512Mi |
| sonar.resources.limits.cpu | sonar 实例的 cpu 资源限制数量 | **prod**: 1500m<br>**demo**: 500m |
| sonar.resources.limits.memory | sonar 实例的 memory 资源限制数量 | **prod**: 3Gi<br>**demo**: 2Gi |




## volume-provisioner 参数

说明：
* 由于 volume-provisioner 本身资源占用较少，因此 prod 部署模式和 demo 部署模式 resources 使用相同的配置

| 参数 | 描述 | 默认值 |
|:----|:---|:---:|
| volume-provisioner.tag | volume-provisioner 镜像的 tag | 1.0.0-20210416-1a3758f |
| volume-provisioner.provisioner.local.hostpath | local volume 卷使用此挂载点作为存储卷来源 | /data |
| volume-provisioner.provisioner.nfs.hostpath | nfs volume 卷使用此挂载点作为存储卷来源 | /netdata|
| volume-provisioner.resources.requests.cpu | volume-provisioner 实例的 cpu 资源请求数量 | 10m |
| volume-provisioner.resources.requests.memory | volume-provisioner 实例的 memory 资源请求数量 | 10Mi |
| volume-provisioner.resources.limits.cpu | volume-provisioner 实例的 cpu 资源限制数量 | 100m |
| volume-provisioner.resources.limits.memory | volume-provisioner 实例的 memory 资源限制数量 | 256Mi |


# Erda 参数配置
| 参数 | 描述 | 默认值 |
|:----|:---|:---:|
| erda.clusterName | 集群名称 | erda |
| erda.clusterName | erda 所在 Kubernetes 集群的标识 | erda |
| erda.domain | erda 当前集群绑定的泛域名 | "erda.io" |
| erda.masterCluster.domain | erda master 集群的泛域名, 主要用于 slave 集群 | - |
| erda.masterCluster.protocol | erda master 集群的请求协议 http/https/http,https，主要用于 slave 集群 | http |
| erda.operator.tag | erda-operator 镜像 tag |  |
| erda.operator.resources.requests.cpu | 设置 erda-operator 实例 Pod 的 CPU 资源请求值 | "10m" |
| erda.operator.resources.requests.memory | 设置 erda-operator 实例 Pod 的 Memory 资源请求值 | "10Mi" |
| erda.operator.resources.limits.cpu | 设置 erda-operator 实例 Pod 的 CPU 资源限制值 | "100m" |
| erda.operator.resources.limits.memory | 设置 erda-operator 实例 Pod 的 Memory 资源限制值 | "128Mi" |
| erda.clusterConfig.protocol | 声明当前 erda 集群的请求协议，http/https/http,https | - |
| erda.clusterConfig.clusterType | erda 集群标识，比如 Kubernetes, EDAS | kubernetes |
| erda.tags.init | erda 初始化任务镜像 tag | init-image:1.0.0-20210510-21a3c66 |
| erda.tags.erda | erda 组件镜像 tag | erda:1.0.0-20210510-d7dd555 |
| erda.tags.uc | erda uc 组件镜像 tag | erda-uc:1.0.0-20210425-d4c5a312 |
| erda.tags.ui  | erda ui-ce 组件镜像 tag | erda-ui:1.0.0-20210508-f228247 |
| erda.tags.telegraf | erda telegraf, telegraf-platform, telegraf-app 组件镜像 tag | telegraf:1.0.0-20210510-dc02a9d |
| erda.tags.filebeat | erda filebeat 组件镜像 tag | filebeat:1.0.0-20210422-5b97371 |
| erda.tags.analyzer.alert | erda analyzer-alert,  analyzer-alert-task  组件镜像 tag | erda-analyzer-alert:1.0.0-20210422-69e9f84 |
| erda.tags.analyzer.error | erda analyzer-error-insight,analyzer-error-insight-task 组件镜像 tag | erda-analyzer-error-insight:1.0.0-20210422-69e9f84 |
| erda.tags.analyzer.metrics | erda analyzer-metrics 组件镜像 tag | erda-analyzer-metrics:1.0.0-20210422-69e9f84 |
| erda.component.admin.replicas | erda admin 组件副本数 | 2 |
| erda.component.admin.resources.cpu | erda admin 组件实例 Pod 的 CPU 资源请求值 | **prod**: "100m"<br>**demo**: "100m" |
| erda.component.admin.resources.mem | erda admin 组件实例 Pod 的 Memory 资源请求值 | **prod**:"128Mi"<br>**demo**: "128Mi" |
| erda.component.admin.resources.max_cpu | erda admin 组件实例 Pod 的 CPU 资源限制值 | **prod**:"200m""<br>**demo**: "100m" |
| erda.component.admin.resources.max_mem | erda admin 组件实例 Pod 的 Memory 资源限制值 | **prod**:"256Mi""<br>**demo**: "128Mi" |
| erda.component.clusterManager.replicas | erda clusterManager 组件副本数 | 2 |
| erda.component.clusterManager.resources.cpu | erda clusterManager 组件实例 Pod 的 CPU 资源请求值 | **prod**: "100m"<br>**demo**: "100m" |
| erda.component.clusterManager.resources.mem | erda clusterManager 组件实例 Pod 的 Memory 资源请求值 | **prod**: "128Mi"<br>**demo**: "128Mi" |
| erda.component.clusterManager.resources.max_cpu | erda clusterManager 组件实例 Pod 的 CPU 资源限制值 | **prod**: "200m"<br>**demo**: "100m" |
| erda.component.clusterManager.resources.max_mem | erda clusterManager 组件实例 Pod 的 Memory 资源限制值 | **prod**: "256Mi"<br>**demo**: "128Mi" |
| erda.component.collector.replicas | erda collector 组件副本数 | 2 |
| erda.component.collector.resources.cpu | erda collector 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.collector.resources.mem | erda collector 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.collector.resources.max_cpu | erda collector 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.collector.resources.max_mem | erda collector 组件实例 Pod 的 Memory 资源限制值 | "1024Mi" |
| erda.component.coreServices.replicas | erda coreServices 组件副本数 | 2 |
| erda.component.coreServices.resources.cpu | erda coreServices 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.coreServices.resources.mem | erda coreServices 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.coreServices.resources.max_cpu | erda coreServices 组件实例 Pod 的 CPU 资源限制值 | "300m" |
| erda.component.coreServices.resources.max_mem | erda coreServices 组件实例 Pod 的 Memory 资源限制值 | "512Mi" |
| erda.component.dicehub.replicas | erda dicehub 组件副本数 | 2 |
| erda.component.dicehub.resources.cpu | erda dicehub 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.dicehub.resources.mem | erda dicehub 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.dicehub.resources.max_cpu | erda dicehub 组件实例 Pod 的 CPU 资源限制值 | "150m" |
| erda.component.dicehub.resources.max_mem | erda dicehub 组件实例 Pod 的 Memory 资源限制值 | "1024Mi" |
| erda.component.hepa.replicas | erda hepa 组件副本数 | 2 |
| erda.component.hepa.resources.cpu | erda hepa 组件实例 Pod 的 CPU 资源请求值 | **prod**: "100m"<br>**demo**: "100m"  |
| erda.component.hepa.resources.mem | erda hepa 组件实例 Pod 的 Memory 资源请求值 | **prod**: "512Mi"<br>**demo**: "128Mi" |
| erda.component.hepa.resources.max_cpu | erda hepa 组件实例 Pod 的 CPU 资源限制值 | **prod**: "500m"<br>**demo**: "500m" |
| erda.component.hepa.resources.max_mem | erda hepa 组件实例 Pod 的 Memory 资源限制值 | - |
| erda.component.monitor.replicas | erda monitor 组件副本数 | 2 |
| erda.component.monitor.resources.cpu | erda monitor 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.monitor.resources.mem | erda monitor 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.monitor.resources.max_cpu | erda monitor 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.monitor.resources.max_mem | erda monitor 组件实例 Pod 的 Memory 资源限制值 | "512Mi" |
| erda.component.msp.replicas | erda msp 组件副本数 | 2 |
| erda.component.msp.resources.cpu | erda msp 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.msp.resources.mem | erda msp 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.msp.resources.max_cpu | erda msp 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.msp.resources.max_mem | erda msp 组件实例 Pod 的 Memory 资源限制值 | "512Mi" |
| erda.component.openapi.replicas| erda openapi 组件副本数 | 2 |
| erda.component.openapi.resources.cpu | erda openapi 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.openapi.resources.mem | erda openapi 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.openapi.resources.max_cpu | erda openapi 组件实例 Pod 的 CPU 资源限制值 |"500m" |
| erda.component.openapi.resources.max_mem | erda openapi 组件实例 Pod 的 Memory 资源限制值 | "512Mi" |
| erda.component.scheduler.replicas | erda scheduler 组件副本数 | 2 |
| erda.component.scheduler.resources.cpu | erda scheduler 组件实例 Pod 的 CPU 资源请求值 | **prod**: "100m"<br>**demo**: "100m" |
| erda.component.scheduler.resources.mem | erda scheduler 组件实例 Pod 的 Memory 资源请求值 | **prod**: "128Mi"<br>**demo**: "128Mi" |
| erda.component.scheduler.resources.max_cpu | erda scheduler 组件实例 Pod 的 CPU 资源限制值 | **prod**: "1"<br>**demo**: "500m" |
| erda.component.scheduler.resources.max_mem | erda scheduler 组件实例 Pod 的 Memory 资源限制值 | **prod**: "2048Mi"<br>**demo**: "512Mi" |
| erda.component.streaming.replicas | erda streaming 组件副本数 | 2 |
| erda.component.streaming.resources.cpu | erda streaming 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.streaming.resources.mem | erda streaming 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.streaming.resources.max_cpu | erda streaming 组件实例 Pod 的 CPU 资源限制值 | "1500m"  |
| erda.component.streaming.resources.max_mem | erda streaming 组件实例 Pod 的 Memory 资源限制值 | "1024Mi" |
| erda.component.ui.replicas | erda ui 组件副本数 | 2 |
| erda.component.ui.resources.cpu | erda ui 组件实例 Pod 的 CPU 资源请求值  | "200m" |
| erda.component.ui.resources.mem | erda ui 组件实例 Pod 的 Memory 资源请求值 | "256Mi" |
| erda.component.ui.resources.max_cpu | erda ui 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.ui.resources.max_mem | erda ui 组件实例 Pod 的 Memory 资源限制值 | "512Mi" |
| erda.component.ucAdaptor.replicas | erda ucAdaptor 组件副本数 | 2 |
| erda.component.ucAdaptor.resources.cpu | erda ucAdaptor 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.ucAdaptor.resources.mem | erda ucAdaptor 组件实例 Pod 的 Memory 资源请求值 | "64Mi" |
| erda.component.ucAdaptor.resources.max_cpu | erda ucAdaptor 组件实例 Pod 的 CPU 资源限制值 | "200m" |
| erda.component.ucAdaptor.resources.max_mem | erda ucAdaptor 组件实例 Pod 的 Memory 资源限制值 | - |
| erda.component.uc.replicas | erda uc 组件副本数 | 2 |
| erda.component.uc.resources.cpu | erda uc 组件实例 Pod 的 CPU 资源请求值 | "10m" |
| erda.component.uc.resources.mem | erda uc 组件实例 Pod 的 Memory 资源请求值 | "100Mi" |
| erda.component.uc.resources.max_cpu | erda uc 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.uc.resources.max_mem | erda uc 组件实例 Pod 的 Memory 资源限制值 | "2048Mi" |
| erda.component.analyzerAlert.resources.cpu | erda analyzerAlert 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.analyzerAlert.resources.mem | erda analyzerAlert 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.analyzerAlert.resources.max_cpu | erda analyzerAlert 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.analyzerAlert.resources.max_mem | erda analyzerAlert 组件实例 Pod 的 Memory 资源限制值 | "1024Mi" |
| erda.component.analyzerAlertTask.resources.cpu | erda analyzerAlertTask 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.analyzerAlertTask.resources.mem | erda analyzerAlertTask 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.analyzerAlertTask.resources.max_cpu | erda analyzerAlertTask 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.analyzerAlertTask.resources.max_mem | erda analyzerAlertTask 组件实例 Pod 的 Memory 资源限制值 | "2048Mi" |
| erda.component.analyzerErrorInsight.resources.cpu | erda analyzerErrorInsight 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.analyzerErrorInsight.resources.mem | erda analyzerErrorInsight 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.analyzerErrorInsight.resources.max_cpu | erda analyzerErrorInsight 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.analyzerErrorInsight.resources.max_mem | erda analyzerErrorInsight 组件实例 Pod 的 Memory 资源限制值 | "2048Mi" |
| erda.component.analyzerErrorInsightTask.resources.cpu | erda analyzerErrorInsightTask 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.analyzerErrorInsightTask.resources.mem | erda analyzerErrorInsightTask 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.analyzerErrorInsightTask.resources.max_cpu | erda analyzerErrorInsightTask 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.analyzerErrorInsightTask.resources.max_mem | erda analyzerErrorInsightTask 组件实例 Pod 的 Memory 资源限制值 | "2048Mi" |
| erda.component.analyzerMetrics.resources.cpu | erda analyzerMetrics 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.analyzerMetrics.resources.mem | erda analyzerMetrics 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.analyzerMetrics.resources.max_cpu | erda analyzerMetrics 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.analyzerMetrics.resources.max_mem | erda analyzerMetrics 组件实例 Pod 的 Memory 资源限制值 | "2048Mi" |
| erda.component.analyzerMetricsTask.resources.cpu | erda analyzerMetricsTask 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.analyzerMetricsTask.resources.mem | erda analyzerMetricsTask 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.analyzerMetricsTask.resources.max_cpu | erda analyzerMetricsTask 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.analyzerMetricsTask.resources.max_mem | erda analyzerMetricsTask 组件实例 Pod 的 Memory 资源限制值 | "2048Mi" |
| erda.component.actionRunnerScheduler.resources.cpu | erda actionRunnerScheduler 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.actionRunnerScheduler.resources.mem | erda actionRunnerScheduler 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.actionRunnerScheduler.resources.max_cpu | erda actionRunnerScheduler 组件实例 Pod 的 CPU 资源限制值 | "300m" |
| erda.component.actionRunnerScheduler.resources.max_mem | erda actionRunnerScheduler 组件实例 Pod 的 Memory 资源限制值 | - |
| erda.component.clusterAgent.resources.cpu | erda clusterAgent 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.clusterAgent.resources.mem | erda clusterAgent 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.clusterAgent.resources.max_cpu | erda clusterAgent 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.clusterAgent.resources.max_mem | erda clusterAgent 组件实例 Pod 的 Memory 资源限制值 | "1024Mi" |
| erda.component.clusterDialer.resources.cpu | erda clusterDialer 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.clusterDialer.resources.mem | erda clusterDialer 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.clusterDialer.resources.max_cpu | erda clusterDialer 组件实例 Pod 的 CPU 资源限制值 | "2" |
| erda.component.clusterDialer.resources.max_mem | erda clusterDialer 组件实例 Pod 的 Memory 资源限制值 | "2048Mi" |
| erda.component.cmp.resources.cpu | erda cmp 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.cmp.resources.mem | erda cmp 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.cmp.resources.max_cpu | erda cmp 组件实例 Pod 的 CPU 资源限制值 | "200m" |
| erda.component.cmp.resources.max_mem | erda cmp 组件实例 Pod 的 Memory 资源限制值 | - |
| erda.component.dop.resources.cpu | erda dop 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.dop.resources.mem | erda dop 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.dop.resources.max_cpu | erda dop 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.dop.resources.max_mem | erda dop 组件实例 Pod 的 Memory 资源限制值 | "2048Mi" |
| erda.component.eventbox.resources.cpu | erda eventbox 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.eventbox.resources.mem | erda eventbox 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.eventbox.resources.max_cpu | erda eventbox 组件实例 Pod 的 CPU 资源限制值 | "2" |
| erda.component.eventbox.resources.max_mem | erda eventbox 组件实例 Pod 的 Memory 资源限制值 | "2560Mi" |
| erda.component.filebeat.resources.cpu | erda filebeat 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.filebeat.resources.mem | erda filebeat 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.filebeat.resources.max_cpu | erda filebeat 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.filebeat.resources.max_mem | erda filebeat 组件实例 Pod 的 Memory 资源限制值 | "512Mi" |
| erda.component.gittar.resources.cpu | erda gittar 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.gittar.resources.mem | erda gittar 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.gittar.resources.max_cpu | erda gittar 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.gittar.resources.max_mem | erda gittar 组件实例 Pod 的 Memory 资源限制值 | "1536Mi" |
| erda.component.pipeline.resources.cpu | erda pipeline 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.pipeline.resources.mem | erda pipeline 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.pipeline.resources.max_cpu | erda pipeline 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.pipeline.resources.max_mem | erda pipeline 组件实例 Pod 的 Memory 资源限制值 | "1536Mi" |
| erda.component.telegraf.resources.cpu | erda telegraf 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.telegraf.resources.mem | erda telegraf 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.telegraf.resources.max_cpu | erda telegraf 组件实例 Pod 的 CPU 资源限制值 | "500m" |
| erda.component.telegraf.resources.max_mem | erda telegraf 组件实例 Pod 的 Memory 资源限制值 | "512Mi" |
| erda.component.telegrafApp.resources.cpu | erda telegrafApp 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.telegrafApp.resources.mem | erda telegrafApp 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.telegrafApp.resources.max_cpu | erda telegrafApp 组件实例 Pod 的 CPU 资源限制值 | "500m" |
| erda.component.telegrafApp.resources.max_mem | erda telegrafApp 组件实例 Pod 的 Memory 资源限制值 | "512Mi" |
| erda.component.telegrafPlatform.resources.cpu | erda telegrafPlatform 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.telegrafPlatform.resources.mem | erda telegrafPlatform 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.telegrafPlatform.resources.max_cpu | erda telegrafPlatform 组件实例 Pod 的 CPU 资源限制值 | "1" |
| erda.component.telegrafPlatform.resources.max_mem | erda telegrafPlatform 组件实例 Pod 的 Memory 资源限制值 | "1536Mi" |
| erda.component.orchestrator.resources.cpu | orchestrator ucAdaptor 组件实例 Pod 的 CPU 资源请求值 | "100m" |
| erda.component.orchestrator.resources.mem | erda orchestrator 组件实例 Pod 的 Memory 资源请求值 | "128Mi" |
| erda.component.orchestrator.resources.max_cpu | erda orchestrator 组件实例 Pod 的 CPU 资源限制值 | "1000m" |
| erda.component.orchestrator.resources.max_mem | erda orchestrator 组件实例 Pod 的 Memory 资源限制值 | "256Mi" |