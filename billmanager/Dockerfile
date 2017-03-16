FROM debian:jessie

MAINTAINER Pavel Bezrukov, https://bezr.pro

ARG lang=ru_RU.UTF-8
ARG language=ru_RU:ru
ARG tz=Europe/Moscow
ARG billmgrVersion=advanced

ENV DEBIAN_FRONTEND noninteractive
ENV CORE_DIR /usr/local/mgr5

RUN apt-get update && apt-get install -y apt-utils locales && \
    locale-gen --purge $lang en_US.UTF-8 && \
    sed -i -e "s/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen && \
    sed -i -e "s/# $lang UTF-8/$lang UTF-8/" /etc/locale.gen && \
    echo -e "LANG=\"$lang\"\nLANGUAGE=\"$language\"\n" > /etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=$lang && \
    ln -sf /usr/share/zoneinfo/$tz /etc/localtime && \
    echo "$tz" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

ENV LANG ${lang}
ENV LANGUAGE ${language}
ENV LC_ALL ${lang}

RUN apt-get update && apt-get install -y wget curl mc vim nano htop rsync man

RUN wget http://cdn.ispsystem.com/install.sh && \
    sh install.sh --release stable --ignore-hostname --silent --no-letsencrypt --disable-fail2ban billmanager-$billmgrVersion

COPY mgr5/etc/ihttpd.conf ${CORE_DIR}/etc/ihttpd.conf
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 1500

CMD ["billmgr"]