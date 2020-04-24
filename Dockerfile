FROM nginx:latest

RUN apt-get update

RUN apt-get install -y gcc\
		       libpcre3\
		       libpcre3-dev\
		       build-essential\
		       libapr1-dev\
		       libssl-dev\
		       zlib1g-dev\
		       wget

WORKDIR /test

RUN wget https://github.com/vozlt/nginx-module-vts/archive/v0.1.18.tar.gz

RUN wget https://nginx.org/download/nginx-1.17.10.tar.gz

RUN tar xvf v0.1.18.tar.gz

RUN tar xvf nginx-1.17.10.tar.gz

WORKDIR /test/nginx-1.17.10

RUN ./configure --prefix=/etc/nginx\
		--sbin-path=/usr/sbin/nginx\
		--modules-path=/usr/lib/nginx/modules\
		--conf-path=/etc/nginx/nginx.conf\
		--error-log-path=/var/log/nginx/error.log\
		--http-log-path=/var/log/nginx/access.log\
		--pid-path=/var/run/nginx.pid\
		--lock-path=/var/run/nginx.lock\
		--http-client-body-temp-path=/var/cache/nginx/client_temp\
		--http-proxy-temp-path=/var/cache/nginx/proxy_temp\
		--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp\
		--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp\
		--http-scgi-temp-path=/var/cache/nginx/scgi_temp\
		--user=nginx\
		--group=nginx\
		--with-compat\
		--with-file-aio\
		--with-threads\
		--with-http_addition_module\
		--with-http_auth_request_module\
		--with-http_dav_module\
		--with-http_flv_module\
		--with-http_gunzip_module\
		--with-http_gzip_static_module\
		--with-http_mp4_module\
		--with-http_random_index_module\
		--with-http_realip_module\
		--with-http_secure_link_module\
		--with-http_slice_module\
		--with-http_ssl_module\
		--with-http_stub_status_module\
		--with-http_sub_module\
		--with-http_v2_module\
		--with-mail\
		--with-mail_ssl_module\
		--with-stream\
		--with-stream_realip_module\
		--with-stream_ssl_module\
		--with-stream_ssl_preread_module\
		--with-cc-opt='-g -O2 -fdebug-prefix-map=/data/builder/debuild/nginx-1.17.10/debian/debuild-base/nginx-1.17.10=. -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC'\
		--with-ld-opt='-Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie'\
		--add-module=../nginx-module-vts-0.1.18

RUN make -j 4

RUN ls objs/

RUN cp objs/ngx_http_vhost_traffic_status_module.so /etc/nginx/modules/

WORKDIR /etc/nginx

RUN rm nginx.conf

COPY nginx.conf nginx.conf

WORKDIR /etc/nginx/conf.d/

RUN rm default.conf

COPY mysiteconf.conf mysiteconf.conf

