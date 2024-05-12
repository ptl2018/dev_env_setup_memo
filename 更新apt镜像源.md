# 更新apt镜像源为

信息源: [阿里Ubuntu 镜像源](https://developer.aliyun.com/mirror/ubuntu)

以下操作中使用的命令请参照[菜鸟教程的Linux 命令大全](https://www.runoob.com/linux/linux-command-manual.html)。  
如有必要，我会写上其它的参考网站。

## 更新apt镜像源

1. 确认自己的ubuntu版本。  
执行`cat /etc/os-release`命令。  
版本为22.04时输出如下。(主要看`VERSION_ID`就可以了。)  

    ```bash
    PRETTY_NAME="Ubuntu 22.04.3 LTS"
    NAME="Ubuntu"
    VERSION_ID="22.04"
    VERSION="22.04.3 LTS (Jammy Jellyfish)"
    VERSION_CODENAME=jammy
    ...省略...
    UBUNTU_CODENAME=jammy
    ```

1. 创建新的镜像设置文件。  
   根据自己的ubuntu版本，从上述镜像源拷贝设置内容，并添加到如下模板中，然后执行。  
    参考命令:  
    1. [Heredoc 入门](https://zhuanlan.zhihu.com/p/93993398)  
    1. [~:用户目录](https://wangdoc.com/bash/expansion#%E6%B3%A2%E6%B5%AA%E7%BA%BF%E6%89%A9%E5%B1%95)  

    模板:

    ```bash
    cat << EOF > ~/sources.list
    ${拷贝的内容}
    EOF
    ```

    示例:

    ```bash
    cat << EOF > ~/sources.list
    deb https://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
    deb-src https://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse

    deb https://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
    deb-src https://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse

    deb https://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
    deb-src https://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse

    # deb https://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse
    # deb-src https://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse

    deb https://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
    deb-src https://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse

    EOF
    ```

1. 执行`cat ~/sources.list`命令，确认文件内容和预期一样。

1. 备份原来的镜像源设置文件。

    ```bash
    sudo mv /etc/apt/sources.list /etc/apt/sources.list.bk
    ```

1. 用`ls /etc/apt/`命令确认，已备份。

1. 将新的镜像设置文件放到原有目录

    ```bash
    sudo cp ~/sources.list /etc/apt/sources.list
    ```

1. **确认文件已放到该放的地方，并确认内容。**

    ```bash
    cat /etc/apt/sources.list
    ```

## 尝试使用镜像源更新可用软件列表和安装软件

1. 更新可用软件列表: `sudo apt update`

    ```bash
    ~$ sudo apt update
    Get:1 https://mirrors.aliyun.com/ubuntu jammy InRelease [270 kB]
    Get:2 https://mirrors.aliyun.com/ubuntu jammy-security InRelease [110 kB]
    Get:3 https://mirrors.aliyun.com/ubuntu jammy-updates InRelease [119 kB]
    Get:4 https://mirrors.aliyun.com/ubuntu jammy-backports InRelease [109 kB]
    ...省略...
    Fetched 52.4 MB in 32s (1614 kB/s)
    Reading package lists... Done
    Building dependency tree... Done
    Reading state information... Done
    61 packages can be upgraded. Run 'apt list --upgradable' to see them.
    ```

    <details>
      <summary>遇到Certificate问题时的解决方法</summary>
      相关错误日志:
      <pre><blockcode>Certificate verification failed: The certificate is NOT trusted. The certificate issuer is unknown.  Could not handshake: Error in the certificate verification. [IP: 111.62.160.100 443]
      Err:6 https://mirrors.aliyun.com/ubuntu jammy-security Release</blockcode></pre>

      1. sources.list的https临时改为http。  
      ```sudo sed -i "s/https/http/g" /etc/apt/sources.list```
      1. 更新可用软件列表。  
      ```sudo apt update```
      1. 因为ca-certificates的版本旧的或也会出问题，重新安装ca-certificates。  
      ```sudo apt reinstall -y ca-certificates```
      1. sources.list的http改回https。  
      ```sudo sed -i "s/http/https/g" /etc/apt/sources.list```
      1. 再次尝试更新可用软件列表。  
      ```sudo apt update```

      参考信息: <https://www.cnblogs.com/zyinworld/p/17501290.html>
    </details>

1. 安装软件(zip和unzip): `sudo apt install -y zip unzip`

    ```bash
    ~$ sudo apt install -y zip unzip
    Reading package lists... Done
    Building dependency tree... Done
    Reading state information... Done
    The following NEW packages will be installed:
      unzip zip
    0 upgraded, 2 newly installed, 0 to remove and 61 not upgraded.
    Need to get 350 kB of archives.
    After this operation, 929 kB of additional disk space will be used.
    Get:1 https://mirrors.aliyun.com/ubuntu jammy-security/main amd64 unzip amd64 6.0-26ubuntu3.1 [174 kB]
    Get:2 https://mirrors.aliyun.com/ubuntu jammy/main amd64 zip amd64 3.0-12build2 [176 kB]
    Fetched 350 kB in 1s (562 kB/s)
    ...省略...
    Processing triggers for man-db (2.10.2-1) ...
    ```

1. 使用`which`确认软件已安装。

    ```bash
    ~$ which zip
    /usr/bin/zip
    ~$ which unzip
    /usr/bin/unzip
    ```

## 删除临时创建的sources.list

```bash
~$ ls
sources.list
~$ rm ~/sources.list
~$ ls
~$
```
