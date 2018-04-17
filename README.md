# php72
一个根据php:72官方镜像扩展过的一个docker镜像，添加了一些扩展包括：gd、pdo_mysql、redis、memcached、igbinary、xdebug。如果是生成环境建议将xdebug扩展去掉重新构建镜像。

# 构建

    docker build -t="leonwong/php72" .

# 注意
如果在使用过程中遇到目录挂载，无法写入的问题，可以将www-data用户和组的id修改为1002,这是本镜像默认设置的。

    usermod -u 1002 www-data
    groupmod -g 1002 www-data

