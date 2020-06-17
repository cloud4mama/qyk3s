# yum install redis
 
yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
 
yum --enablerepo=remi install redis
 
service redis start
 
