# 更新Podman镜像源

由于国内防火墙的原因，下载镜像速度慢。
所以在这里设置国内镜像源。

参考： [podman镜像加速配置](https://www.cnblogs.com/jawide/p/15861070.html)

环境: WSL(Ubnuntu 24.04) + podman(4.9.3)

1. 生成镜像源设置文件

    ```bash
    cat << EOF > ~/registries.conf
    unqualified-search-registries = ["docker.io"]

    [[registry]]
    prefix = "docker.io"
    location = "docker.io"

    [[registry.mirror]]
    location = "docker.m.daocloud.io"

    [[registry.mirror]]
    location = "docker.nju.edu.cn"

    [[registry.mirror]]
    location = "dockerproxy.com"

    [[registry.mirror]]
    location = "registry.docker-cn.com"

    [[registry.mirror]]
    location = "hub-mirror.c.163.com"

    [[registry.mirror]]
    location = "mirror.baidubce.com"

    [[registry.mirror]]
    location = "ghcr.io"

    EOF
    ```

1. 备份元镜像设置文件

    ```bash
    sudo mv /etc/containers/registries.conf /etc/containers/registries.conf.bk
    ```

1. 确认备份文件

    ```bash
    ls /etc/containers
    ```

1. 覆盖镜像源设置文件

    ```bash
    sudo cp ~/registries.conf /etc/containers/registries.conf
    ```

1. 删除最初生成的镜像源文件

    ```bash
    rm ~/registries.conf
    ```
