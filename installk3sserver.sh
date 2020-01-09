#!/bin/bash

set -e 

info()
{
    echo '[INFO] ' "$@"
}
fatal()
{
    echo '[ERROR] ' "$@" >&2
    exit 1
}

# --- fatal if no systemd or openrc ---
verify_system() {
    if [ -x /sbin/openrc-run ]; then
        HAS_OPENRC=true
        return
    fi
    if [ -d /run/systemd ]; then
        HAS_SYSTEMD=true
        return
    fi
    fatal 'Can not find systemd or openrc to use as a process supervisor for k3s'
}

{	
	verify_system

	echo "will install k3s and start as server. then generate files to start worker."
	
	#[ $# -ne  1 ] || echo " parameter wrong!"
	if  [ $# -ne  1 ] ; then 
    		#echo "usage : parameter wrong!"
    		echo "usage : bash $0 localip:localport "
		exit
	fi
        cp k3s /root/
	chmod a+x /root/k3s
	cp qyk3server.service /etc/systemd/system/qyk3server.service

	systemctl daemon-reload
	systemctl start qyk3server

	sleep 30s

	K3S_TOKEN=$(cat /var/lib/rancher/k3s/server/node-token)

	K3S_SERVER_IPPORT=$1

	echo $1 >serveripport.debug
	echo "#!/bin/sh" > startasworkertemplate.sh
	echo "sudo /root/k3s agent --docker --server https://$K3S_SERVER_IPPORT --token $K3S_TOKEN" >> startasworkertemplate.sh
	cp startasworkertemplate.sh /root/startasworker.sh
        chmod a+x /root/startasworker.sh
}
