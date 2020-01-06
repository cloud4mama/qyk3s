#echo "description : this script should be run on k3s master node !!! and output file should be startasworkertemplate.sh"
#echo $#
if [ $# -ne  1 ]; then
	#echo "usage : parameter wrong!"
	echo "usage : bash add_node.sh nodeip"
fi

echo "scp  ./k3s  root@$1:/root/k3s" > a.sh
echo "scp  ./startasworker2.sh  root@$1:/root/startasworker2.sh" >> a.sh
echo "scp  ./qyk3sworker.service root@$1:/etc/systemd/system/qyk3sworker.service" >>a.sh
echo "ssh  root@$1 systemctl daemon-reload" >>a.sh
echo "ssh  root@$1 systemctl start qyk3sworker" >>a.sh
#sh a.sh
