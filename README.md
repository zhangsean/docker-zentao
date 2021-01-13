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

- `latest`
- `12.5.3`
- `12.5.3`
- `12.5.3`
- `20.0.beta1`
- `12.5.1`
- `12.4.3`
- `12.4.2`
- `12.4.1`
- `12.3.3`
- `12.3.2`
- `12.3.1`
- `12.3`
- `12.2`
- `12.1`
- `12.0.1`
- `12.0`
- `11.7`
- `11.6`
- `11.5`

### QuickStart

Export zentao only:

``` bash
mkdir -p /data/zbox && \
docker run -itd \
        -p 80:80 \
        -e ADMINER_USER="root" \
        -e ADMINER_PASSWD="password" \
        -v /data/zbox/:/opt/zbox/ \
        --add-host smtp.exmail.qq.com:163.177.90.125 \
        --name zentao-server \
        zhangsean/zentao:latest
```

Export zentao and mysql:

``` bash
mkdir -p /data/zbox && \
docker run -itd \
        -p 80:80 \
        -p 3306:3306 \
        -e BIND_ADDRESS=false \
        -e ADMINER_USER="root" \
        -e ADMINER_PASSWD="password" \
        -v /data/zbox/:/opt/zbox/ \
        --add-host smtp.exmail.qq.com:163.177.90.125 \
        --name zentao-server \
        zhangsean/zentao:latest
```

> Note: Make sure your host feed available on either port `80` or `3306`.

### Environment configuration

* `ADMINER_USER` : set the web login database Adminer account.
* `ADMINER_PASSWD` : set the web login database Adminer password.
* `BIND_ADDRESS` : if set value with `false`,the MySQL server will not bind address.
* If can't send mail, you can use `extra_host` in docker-compose.yaml, or param `--add-host` in `dokcer run` command.

> Note:
The Zentao administrator account is **admin**,and default initialization password is **123456**.
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
        -v /data/zbox/:/opt/zbox/ \
        --add-host smtp.exmail.qq.com:163.177.90.125 \
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
After you complete the upgrade task in your zentao website and confirm everything looks good, delete the backups to save your disk space.`docker rm -f zentao-server-bak && rm -rf /data/zbox-bak`
> [See Detail](https://www.zentao.net/book/zentaopmshelp/67.html)

### Building the image

Clone this repo, modify `Dockerfile` or `docker-entrypoint` if you want.
Then execute the following command:

```bash
docker build -t zentao .
```
