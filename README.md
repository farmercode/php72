# php72
一个根据php:72官方镜像扩展过的一个docker镜像，添加了一些扩展包括：gd、pdo_mysql、redis、memcached、igbinary、xdebug。如果是生成环境建议将xdebug扩展去掉重新构建镜像。

# 构建

    docker build -t="leonwong/php72" .


