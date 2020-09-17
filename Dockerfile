FROM buildpack-deps:18.04-curl
MAINTAINER Swire Chen <idoop@msn.cn>

ADD https://raw.githubusercontent.com/easysoft/zentaopms/zentaopms_11.6.5_20191113/www/upgrade.php.tmp /tmp/upgrade.php

COPY docker-entrypoint /usr/local/bin/docker-entrypoint

HEALTHCHECK --start-period=20s --interval=45s --timeout=3s CMD wget http://localhost/ -O /dev/null || exit 1

EXPOSE 80

ENTRYPOINT ["docker-entrypoint"]

ENV ZENTAO_VER=12.4.2

ARG ZENTAO_URL=http://dl.cnezsoft.com/zentao/${ZENTAO_VER}/ZenTaoPMS.${ZENTAO_VER}.zbox_64.tar.gz

RUN chmod +x /usr/local/bin/docker-entrypoint; \
    cd /tmp/; \
    chmod +r upgrade.php; \
    curl -sSL ${ZENTAO_URL} -o zbox.tar.gz && \
    tar -zxf zbox.tar.gz && \
    rm -f zbox.tar.gz && \
    rm -rf zbox/data/mysql/zentaoep/ && \
    rm -rf zbox/data/mysql/zentaopro/ && \
    rm -rf zbox/app/zentaoep/ && \
    rm -rf zbox/app/zentaopro/ && \
    tar zcf zbox.tar.gz zbox/ && \
    rm -rf zbox/
