#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")"

# enable the netdata, `enable` and `disable` supported, default is `enable`
if [[ -z $ERDA_NETDATA_ENABLE ]]; then
	export ERDA_NETDATA_ENABLE=enable
fi


# install and configuration nfs
if [[ $ERDA_NETDATA_ENABLE == "enable" ]]; then
	rm -rf ./bin
	mkdir ./bin
	os_name=`uname`
	if [ ${os_name} == "Darwin" ];then
		tar -xvf ../../third_party_package/orgalorg_1.0.1_darwin_amd64.tar.gz -C bin/
	elif [ ${os_name} == "Linux" ];then
		tar -xvf ../../third_party_package/orgalorg_1.0.1_linux_amd64.tar.gz -C bin/
	fi
	
	if [[ ! -e /netdata ]]; then
		rm -rf ./all_hosts.txt
		lines=`kubectl get nodes -o wide | grep -v NAME | wc -l`
		kubectl get nodes -o wide | grep -v NAME |awk '{print $6}' > ./all_hosts.txt
		cat ./all_hosts.txt | ./bin/orgalorg -x -s -u root -p -C  "yum install nfs-utils -y && systemctl enable rpcbind && systemctl start rpcbind && mkdir -p /netdata"
		cat ./all_hosts.txt | head -n 1 | ./bin/orgalorg -x -s -u root -p -C  'systemctl enable nfs && systemctl start nfs && chmod 755 /netdata && echo "/netdata *(rw,sync,no_root_squash,no_all_squash)" > /etc/exports && exportfs -rv'
		nfs_nodeIP=`cat ./all_hosts.txt | head -n 1`
		cat ./all_hosts.txt | tail -n `expr ${lines} - 1`  | ./bin/orgalorg -x -s -u root -p -C "mount -t nfs ${nfs_nodeIP}:/netdata /netdata"
		cat ./all_hosts.txt | ./bin/orgalorg -x -s -u root -p -C "echo "${nfs_nodeIP}:/netdata     /netdata                   nfs     defaults        0 0" >> /etc/fstab"
	fi
fi