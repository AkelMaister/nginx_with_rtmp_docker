FROM debian:latest
MAINTEAINER Akel <akel@domain.tld>

RUN /etc/init.d/dhcpv6_hack.sh
RUN /etc/init.d/ssh_key_hack.sh
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y --force-yes install autoconf automake build-essential libass-dev libfreetype6-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texinfo libx264-dev libmp3lame-dev cmake mercurial zlib1g-dev yasm nano mc libopus-dev cmake mercurial ; true

COPY ffmpeg_compile.sh /usr/local/src/ffmpeg_compile.sh
COPY nginx_configure.sh /usr/local/src/nginx_configure.sh
COPY generate_nginx_template.sh /usr/local/src/generate_nginx_template.sh
COPY entrypoint.sh /root/entrypoint.sh

RUN chmod +x /usr/local/src/ffmpeg_compile.sh
RUN chmod +x /usr/local/src/nginx_configure.sh
RUN chmod +x /usr/local/src/generate_nginx_template.sh
RUN chmod +x /root/entrypoint.sh

RUN /usr/local/src/ffmpeg_compile.sh
RUN /usr/local/src/nginx_configure.sh
RUN /usr/local/src/generate_nginx_template.sh

ENTRYPOINT /root/entrypoint.sh
