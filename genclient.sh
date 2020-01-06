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
	fi



	K3S_TOKEN=$(cat /var/lib/rancher/k3s/server/node-token)

	K3S_SERVER_IPPORT=$1
	echo "sudo ./k3s agent --server https://$K3S_SERVER_IPPORT --token $K3S_TOKEN" >startasworkertemplate.sh
	cp startasworkertemplate.sh startasworker2.sh
}
