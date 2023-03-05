sudo apt update -y

dpkg --get-selections | grep apache

sudo apachectl -k restart

serv_stat=$(service apache2 status)

if apache2 -v; then
        echo "Apache server is installed"
else  sudo apt install apache2 -y
fi

if  $serv_stat == "active (running)" ; then
  echo "server running"
else sudo systemctl start apache2
fi


if sudo systemctl is-enabled apache2; then
	echo " Apache2 enable"

else sudo systemctl enable apache2
fi

myname="Hari"
timestamp=$(date '+%d%m%Y-%H%M%S')
s3_bucket="upgrad-hari"

tar cvf /tmp/${myname}-httpd-logs-${timestamp}.tar /var/log/apache2/*.log
dpkg -s awscli
if [ $? -eq 0 ]
then
    echo "awscli  is installed."
else
    echo "awscli is not installed,installing awscli"
    sudo apt install awscli -y
fi
aws s3 cp /tmp/${myname}-httpd-logs-${timestamp}.tar s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
