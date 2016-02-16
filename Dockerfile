FROM debian:7.9
MAINTEINER Akel <Akel@domain.tld>

RUN apt-get -y update
RUN apt-get -y install ffmpeg gcc libpcre3-dev libssl-dev avconv

RUN groupadd nginx
RUN useradd -g nginx nginx

RUN wget -O /usr/local/src/nginx.tar.gz http://nginx.org/download/nginx-1.6.3.tar.gz
RUN wget -O /usr/local/src/nginx-rtmp-module.zip https://github.com/arut/nginx-rtmp-module/archive/master.zip
RUN cd /usr/local/src && tar -xzvf nginx-1.6.3.tar.gz
RUN cd /usr/local/src && unzip master.zip
RUN cd /usr/local/src/nginx-1.6.3 && ./configure \
        --prefix=/etc/nginx \
        --sbin-path=/usr/sbin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx.pid \
        --lock-path=/var/run/nginx.lock \
        --http-client-body-temp-path=/var/cache/nginx/client_temp \
        --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
        --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
        --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
        --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
        --user=nginx \
        --group=nginx \
        --with-http_ssl_module \
        --with-http_realip_module \
        --with-http_addition_module \
        --with-http_sub_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_mp4_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_random_index_module \
        --with-http_secure_link_module \
        --with-http_stub_status_module \
        --with-http_auth_request_module \
        --with-mail \
        --with-mail_ssl_module \
        --with-file-aio \
        --add-module=/usr/local/src/nginx-rtmp-module-master \
        --with-ipv6
RUN cd /usr/local/src/nginx-1.6.3 && make -j4 && make install ;

EXPOSE 80 1935
