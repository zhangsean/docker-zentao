# Docker Image for Zentao
[![Docker Pulls](https://img.shields.io/docker/pulls/zhangsean/zentao.svg)](https://hub.docker.com/r/zhangsean/zentao)
[![Docker Automated build](https://img.shields.io/docker/automated/zhangsean/zentao.svg)](https://hub.docker.com/r/zhangsean/zentao)
[![Docker Build Status](https://img.shields.io/docker/build/zhangsean/zentao.svg)](https://hub.docker.com/r/zhangsean/zentao)
[![ImageLayers Size](https://img.shields.io/microbadger/image-size/zhangsean/zentao/latest.svg)](https://hub.docker.com/r/zhangsean/zentao)
[![ImageLayers Layers](https://img.shields.io/microbadger/layers/zhangsean/zentao/latest.svg)](https://hub.docker.com/r/zhangsean/zentao)

[![DockerHub Badge](https://dockeri.co/image/zhangsean/zentao)](https://hub.docker.com/r/zhangsean/zentao)

Auto build docker image for zentao(禅道),include open source edition and pro edition.

DockerHub: [https://hub.docker.com/r/zhangsean/zentao](https://hub.docker.com/r/zhangsean/zentao)

Office Support: [http://www.zentao.net/](http://www.zentao.net/)

### Tags

**Open soure edition**

- `11.5`,`latest`
- `11.4.1`
- `10.0`,`10.1`,`10.3`,`10.4`,`10.5`,`10.6`
- `9.6.3`,`9.7`,`9.8`,`9.8.3`

**Pro edition**

- `pro-8.2`,`pro`
- `pro-7.1`,`pro-7.3`,`pro-7.5.1`
- `pro-6.7.3`

### QuickStart

open soure edition:
``` bash
mkdir -p /data/zbox && \
docker run -d -p 80:80 -p 3306:3306 \
        -e ADMINER_USER="root" -e ADMINER_PASSWD="password" \
        -e BIND_ADDRESS="false" \
        -e SMTP_HOST="163.177.90.125 smtp.exmail.qq.com" \
        -v /data/zbox/:/opt/zbox/ \
        --name zentao-server \
        zhangsean/zentao:latest
```

pro edition:
``` bash
mkdir -p /data/zbox && \
docker run -d -p 80:80 -p 3306:3306 \
        -e USER="root" -e PASSWD="password" \
        -e BIND_ADDRESS="false" \
        -v /data/zbox/:/opt/zbox/ \
        --name zentao-server-pro \
        zhangsean/zentao:pro
```

Note: Make sure your Host feed available on either port `80` or `3306`.

### Environment configuration

* `ADMINER_USER` : set the web login database Adminer account.
* `ADMINER_PASSWD` : set the web login database Adminer password. 
* `BIND_ADDRESS` : if set value with `false`,the MySQL server will not bind address.
* `SMTP_HOST` : set the smtp server IP and host.(If can't send mail,it will be helpful.)

Note: The zentao administrator account is **admin**,and init password is **123456**.
      And MySQL root account password is **123456**,please change password when you first login.

### Upgrade Version

> If you want upgrade the zentao version, just run a container with the latest docker image and mount the same zbox path `$volume/zbox/`.
```bash
# stop and backup old container
docker stop zentao-server
docker rename zentao-server zentao-server-bak
# backup zbox
cp -r /data/zbox /data/zbox-bak
# pull the latest image
docker pull zhangsean/zentao:latest
# run new container with the latest image and mount the same path
docker run -d -p 80:80 -p 3306:3306 \
        -e ADMINER_USER="root" -e ADMINER_PASSWD="password" \
        -e BIND_ADDRESS="false" \
        -e SMTP_HOST="163.177.90.125 smtp.exmail.qq.com" \
        -v /data/zbox/:/opt/zbox/ \
        --name zentao-server \
        zhangsean/zentao:latest
docker logs -f zentao-server
```
You will see the upgrading process logs like following.
```
Installed Zentao version: 11.0
New Zentao version: 11.4
Backuping config/my.php and upload ...
Upgrading Zentao ...
Restoring config/my.php and upload ...
Upgraded Zentao version to: 11.4
Please visit your Zentao website to complete the upgrade task.
Start Apache success
Start Mysql success
```
Wait until `Start Mysql success`, visit your zentao website to complete the upgrade task step by step.

After you complete the upgrade task in your zentao website and confirm everything looks good, delete the backups to save your disk space.
```bash
docker rm -f zentao-server-bak
rm -rf /data/zbox-bak
```
> [See Detail](https://www.zentao.net/book/zentaopmshelp/67.html)

### Building the image

Clone this repo, modify `Dockerfile` or `docker-entrypoint` if you want.
Then execute the following command:

```bash
docker build -t zentao .
```
