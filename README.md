# NGINX-VTS-ENABLE-DOCKER-IMAGE

This Dockerfile creates a docker image using nginx as base image and enables vts mertics inside nginx.

[nginx-module-vts](https://github.com/vozlt/nginx-module-vts)
[nginx-vts-exporter](https://github.com/hnlq715/nginx-vts-exporter)

## To just run docker image of nginx 
```
docker build -t nginx-vts .
docker run -d -t -p 80:80 nginx-vts
```

## To export vts metric in promethues format 
```
docker-compose up -d
```

Change `nginx.conf` and `mysiteconf.conf` according to required configuration of your website/server and you are good to go.\
Add issues if any.\
note : `latest` version of nginx in `1.17.10` if your nginx version is different than `1.17.10` change the version in `Dockerfile`.

