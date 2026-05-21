
apt-get update
apt-get -y upgrade 
apt-get install -y nginx
sed -i 's/80 default_server/82 default_server/g' /etc/nginx/sites-available/default
service nginx restart