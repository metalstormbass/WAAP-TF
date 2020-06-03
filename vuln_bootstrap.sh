#!/bin/bash
# Update and download Nginx
until sudo apt-get update && sudo apt-get -y install nginx;do
    sleep 1
done

# Update and download docker
until sudo  apt-get -y install docker;do
    sleep 1
done

# Pull Juice Repository
until sudo docker pull bkimminich/juice-shop;do
    sleep 1
done

# Start Docker
docker run --rm -d -p 3000:3000 bkimminich/juice-shop

# Gather IP address

ip_address=$(ifconfig ens192 | grep "inet " | awk -F'[: ]+' '{ print $3 }')

# Modify Nginx Config to allow access to Juice Store
sudo mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.disabled

sudo chmod a+w /etc/nginx/conf.d/juice.conf

sudo cat <<EOT >> /etc/nginx/conf.d/juice.conf
server {
  listen 80;
  listen [::]:80;

  server_name $ip_address;

  location / {
      proxy_pass http://localhost:3000/;
  }
}
EOT

sudo nginx -s reload

# Download the CPnanoAgent
until curl \
    --output /home/mike/cp-nano-egg.sh \
    --url https://chkpscripts.s3.amazonaws.com/cp-nano-egg.sh ; do
    sleep 1
done

# Install Nano Agent
sudo chmod 755 /home/mike/cp-nano-egg.sh
sudo /home/chkpuser/cp-nano-egg.sh --install --ignore accessControl --token <INSERT WAAP TOKEN HERE> --fog_address https://i2-agents.cloud.ngen.checkpoint.com

