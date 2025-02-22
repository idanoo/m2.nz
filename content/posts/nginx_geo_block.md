---
title: "GeoIP blocking countries using Nginx"
tags: ["nginx", "geoip", "spam", "geo block"]
date: 2024-04-06
---

Quick and easy way to block entire countries using simple nginx rules.
Note this is for Ubuntu/Nginx but may work on other systems.

Install required packages & add to nginx config.    
The GeoIP DB will be under /usr/shared/GeoIP/GeoIPv6.dat (Or GeoIP.dat for v4 only):
```shell
sudo apt install -y libnginx-mod-http-geoip geoip-database
echo 'geoip_country /usr/share/GeoIP/GeoIPv6.dat;' > /etc/nginx/conf.d/geoip.conf
```

Add this block under the main "http" block in nginx.conf:
```shell
# /etc/nginx/nginx.conf
map $geoip_country_code $allowed_country {
    default yes;
    BD no; # Country code to block - Can list mulitple
}
```

Then we need to add a simple check in our site vhost inside the `server {` block, but before the `location /` block:
```shell
# /etc/nginx/sites-enabled/site.conf or /etc/nginx/conf.d/site.conf
if ($allowed_country = no) {
    return 403;
}
```

Quick reload and boom! Done!
```shell
sudo systemctl reload nginx
```

Based off an older gist found on [Github here](https://gist.github.com/dunderrrrrr/8d3fced1f73de2d70ede38f39c88d215)
