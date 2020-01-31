FROM buildpack-deps:18.04-curl
MAINTAINER Swire Chen <idoop@msn.cn>

ADD https://raw.githubusercontent.com/easysoft/zentaopms/zentaopms_11.6.5_20191113/www/upgrade.php.tmp /tmp/upgrade.php

COPY docker-entrypoint /usr/local/bin/docker-entrypoint

HEALTHCHECK --start-period=20s --interval=45s --timeout=3s CMD wget http://localhost/ -O /dev/null || exit 1

EXPOSE 80

ENTRYPOINT ["docker-entrypoint"]

ENV ZENTAO_VER=12.0

ARG ZENTAO_URL=http://dl.cnezsoft.com/zentao/${ZENTAO_VER}/ZenTaoPMS.${ZENTAO_VER}.stable.zbox_64.tar.gz

RUN chmod +x /usr/local/bin/docker-entrypoint; \
    curl -SL ${ZENTAO_URL} -o /tmp/zbox.tar.gz && \
    tar -zxf /tmp/zbox.tar.gz -C /tmp/ && \
    cd /tmp/zbox/ && \
    rm -rf data/mysql/zentaoep/ && \
    rm -rf data/mysql/zentaopro/ && \
    rm -rf app/zentaoep/ && \
    rm -rf app/zentaopro/ && \
    rm -f /tmp/zbox.tar.gz && \
    cd /tmp/ && \
    tar zcf /tmp/zbox.tar.gz /tmp/zbox/ && \
    rm -rf /tmp/zbox/
