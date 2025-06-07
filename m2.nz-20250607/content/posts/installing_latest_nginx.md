---
title: "Nginx stable install on debian/ubuntu from official repos"
tags: ["nginx", "debian", "ubuntu"]
date: 2025-02-22
---

A lot of the time, intsalling nginx from ubuntu/debian repositories is out of date and sometimes we just want the latest version :shrug:.

First up we want to install all required software and pull the latest signing key.

**Run the following commands as the root user**
```shell
apt install -y curl gnupg2 ca-certificates lsb-release debian-archive-keyring
curl -s https://nginx.org/keys/nginx_signing.key | gpg --dearmor > /usr/share/keyrings/nginx-archive-keyring.gpg
```

The next step will vary depending on if you are using debian or ubuntu.

**Debian:**
```shell
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/debian `lsb_release -cs` nginx" \
    | tee /etc/apt/sources.list.d/nginx.list
```

**Ubuntu:**
```shell
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | tee /etc/apt/sources.list.d/nginx.list
```

Once we have the packages && keyring setup, it's time to install:
```shell
apt update && apt install -y nginx
```

Keep in mind, the latest version will have the vhosts configured under `/etc/nginx/conf.d` instead of the legacy `sites-enabled` folder. 