## ELK docker 镜像

- https://docs.docker.com/compose/networking/#specify-custom-networks
- https://docs.docker.com/compose/compose-file/#volumes
- https://docs.docker.com/engine/reference/commandline/volume_create/#related-commands
- [kibana](https://www.elastic.co/downloads/kibana)
- [logstash](https://www.elastic.co/downloads/logstash)
- [docker](https://docs.docker.com/engine/installation/linux/docker-ce/centos/#install-from-a-package)
- [logstash conf](https://github.com/dwbutler/logstash-logger/tree/master/samples)
- [curator](https://www.elastic.co/guide/en/elasticsearch/client/curator/5.x/about-features.html)

### setup docker

https://docs.docker.com/engine/installation/linux/docker-ce/centos/

```shell
sudo yum remove docker docker-common docker-selinux docker-engine
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum-config-manager --disable docker-ce-edge
sudo yum install docker-ce
sudo systemctl start docker
sudo docker run hello-world
sudo pip install docker-compose
```

## 配置镜像启动脚本

这里是容器里面的启动脚本需要手动配置 `/acs/conf/ews_startup.sh` 可以参见

```shell
cp docker-compose.yml.example docker-compose.yml
cp conf/kibana.yml.example conf/kibana.yml
cp logstash/config/sample/ logstash/config/
docker-compose up -d # -d Detached mode
```

## debug

```shell
docker exec -it kibana bash
```

kibana loading sample data

- https://www.elastic.co/guide/en/kibana/current/tutorial-load-dataset.html
- https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-bulk.html

```shell
cd tmp
curl https://download.elastic.co/demos/kibana/gettingstarted/accounts.zip --output accounts.zip
curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/bank/account/_bulk?pretty' --data-binary @accounts.json

curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/shakespeare/doc/_bulk?pretty' --data-binary @shakespeare_6.0.json
```

## security

- https://www.elastic.co/guide/en/x-pack/current/xpack-security.html
- https://www.elastic.co/guide/en/kibana/6.1/using-kibana-with-security.html
- https://www.elastic.co/subscriptions

设置 kibana 密码

```shell
PUT http://localhost:5601/_xpack/security/user/kibana/_password
{
  "password" : "11111111"
}
```

## 服务访问地址

```shell
# kibana
http://localhost:5601/
# elasticsearch
http://localhost:9200/
# Logstash logstash input
localhost 5044
# Logstash tcp udp input
localhost:5000
# Logstash API endpoint
http://localhost:9600/
```
