#echo "description : this script should be run on k3s master node !!! and output file should be startasworkertemplate.sh"
#echo $#
if [ $# -ne  1 ]; then
	#echo "usage : parameter wrong!"
	echo "usage : bash $0  nodeip"
fi

echo "ssh  root@$1 systemctl daemon-reload" >>astart.sh
echo "ssh  root@$1 systemctl start qyk3sworker" >>astart.sh
#ssh 192.168.2.108 "date"
sh astart.sh
