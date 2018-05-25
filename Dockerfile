FROM ubuntu:trusty

# replace sources
ADD sources.list /etc/apt/sources.list

# change timezone
RUN echo "Asia/Shanghai" > /etc/timezone && \
                dpkg-reconfigure -f noninteractive tzdata

# no Upstart or DBus
# https://github.com/dotcloud/docker/issues/1724#issuecomment-26294856
RUN apt-mark hold initscripts udev plymouth mountall
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

RUN apt-get update \
    && apt-get install -y --no-install-recommends supervisor x11vnc lxde xvfb wget openjdk-7-jdk \
 && rm -rf /var/lib/apt/lists/*

ENV OPENOFFICE Apache_OpenOffice_4.1.5_Linux_x86-64_install-deb_zh-CN.tar.gz

RUN wget --no-check-certificate https://jaist.dl.sourceforge.net/project/openofficeorg.mirror/4.1.5/binaries/zh-CN/$OPENOFFICE -O /tmp/$OPENOFFICE
RUN mkdir /tmp/OpenOffice/ \
 && tar -zxvf /tmp/$OPENOFFICE -C /tmp/OpenOffice/ \
    && dpkg -i /tmp/OpenOffice/zh-CN/DEBS/*.deb \
    && dpkg -i /tmp/OpenOffice/zh-CN/DEBS/desktop-integration/*.deb \
 && rm -rf /tmp/$OPENOFFICE && rm -rf /tmp/OpenOffice

RUN rm /etc/xdg/lxsession/LXDE/autostart
COPY autostart /etc/xdg/lxsession/LXDE/autostart
COPY desktop-items-0.conf /root/.config/pcmanfm/LXDE/desktop-items-0.conf
COPY OpenOffice4 /root/Desktop/OpenOffice4
RUN chmod +x /root/Desktop/OpenOffice4

COPY noVNC /noVNC/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 6080 8100

CMD ["/usr/bin/supervisord"]
