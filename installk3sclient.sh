#echo "description : this script should be run on k3s master node !!! and output file should be startasworkertemplate.sh"
#echo $#
if [ $# -ne  1 ]; then
	#echo "usage : parameter wrong!"
	echo "usage : bash installk3sclient.sh nodeip"
fi

echo "scp  /root/qyk3s2/k3s  root@$1:/root/k3s" > a.sh
echo "scp  /root/qyk3s2/startasworker2.sh  root@$1:/root/startasworker.sh" >> a.sh
echo "scp  /root/qyk3s2/qyk3sworker.service root@$1:/etc/systemd/system/qyk3sworker.service" >>a.sh
echo "ssh  root@$1 systemctl daemon-reload" >>a.sh
echo "ssh  root@$1 systemctl start qyk3sworker" >>a.sh
ssh 192.168.2.108 "date"
#sh a.sh
