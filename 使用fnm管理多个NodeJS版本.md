# 使用fnm管理多个NodeJS版本

信息源:

1. [fnm](https://github.com/Schniz/fnm)
1. [阿里云NodeJS镜像](https://developer.aliyun.com/mirror/nodejs-release)
1. [阿里云NPM镜像](https://developer.aliyun.com/mirror/NPM)

## 安装并设置fnm

### 安装fnm

```bash
cd ~
git clone https://github.com/Schniz/fnm.git
bash fnm/.ci/install.sh -d ~/.fnm
echo 'eval "$(fnm env --use-on-cd)"' >> .bashrc # 此项用于不同文件夹下使用不同NodeJS版本。
fnm --version
```

### 更新NodeJS镜像源为阿里云

```bash
echo "export FNM_NODE_DIST_MIRROR=https://mirrors.aliyun.com/nodejs-release/" >> ~/.bashrc
source ~/.bashrc
```

## 安装NodeJS

1. 查找NodeJS的可用版本

    ```bash
    fnm ls-remote
    ```

1. 安装第一个版本（v16.20.2）

    ```bash
    fnm install v16.20.2
    node --version
    npm --version
    ```

1. 安装第二个版本（v18.19.0）。

    ```bash
    fnm install v18.19.0
    node --version
    npm --version
    ```

## 切换使用中的NodeJS版本

先使用`fnm list`命令查看当前有哪些本地版本可用。

示例:

```bash
$ fnm list
* v16.20.2 default
* v18.19.0
* system
```

更新使用中的NodeJS版本的方法有如下3种。

1. `fnm use <version>`:
  仅在当前shell会话下使用指定版本。但退出当前shell后，就会回到`fnm default`中指定的版本。  
    示例:

    ```bash
    fnm use v18.19.0
    node --version
    npm --version
    ```

1. `fnm default <version>`:  
    没有任何nodejs版本设定的时候用的版本。比如，刚登陆shell的时候。  
    注意： 它不会更新当前shell中使用的nodejs版本。  
    示例:

    ```bash
    fnm default v18.19.0
    ```

1. 根据设置文件自动调用`fnm use <version>`命令。
    1. 在文件夹中存在文件名如`.node-version`或 `.nvmrc`，
    内容为NodeJS的版本号的设置文件，就会使用设置文件中的版本。  
        示例:

        ```bash
        # 设置当前版本为v18.19.0
        ~$ fnm use v18.19.0
        Using Node v18.19.0
        # 确认当前版本
        ~$ node --version
        v18.19.0
        # 新建测试用目录
        ~$ mkdir version_change
        # 新建版本设置文件，并将版本号写入测试文件中。
        ~$ echo "v16.20.2" >> version_change/.node-version
        # 确认设置文件内容
        ~$ cat version_change/.node-version
        v16.20.2
        # 确认当前版本
        ~$ node --version
        v18.19.0
        # 更换工作目录为有设置文件的测试目录(此时，就会根据设置文件自动调用`fnm use <version>`)
        ~$ cd version_change
        Using Node v16.20.2
        # 确认当前版本
        ~/version_change$ node --version
        v16.20.2
        ```

    1. 如果本地没有安装设置文件中指定的版本，会问你要不要安装。输入`y`，按enter后会自动安装。
    1. 当切换回没有设置文件的目录时，并不会将NodeJS版本返回为之前的版本，而是继续使用上述设置文件中的版本。  
    即切换版本前不会记录之前使用的版本，也不会在切换后自动调用`fnm use <version>`。

## 更新NPM的镜像源为阿里云

1. 先使用`npm config get registry`确认当前镜像网址。

    ```bash
    ~$ npm config get registry
    https://registry.npmjs.org/
    ```

1. 更新并确认新镜像

    ```bash
    ~$ npm config set registry http://registry.npmmirror.com
    ~$ npm config get registry
    http://registry.npmmirror.com/
    ```

1. 尝试安装TypeScript

    ```bash
    # 生成测试目录，并切换工作目录
    ~$ mkdir npmTest && cd $_
    ~/npmTest$ npm install typescript --save-dev
    ...省略...
    npm notice New major version of npm available! 8.19.4 -> 10.4.0
    npm notice Changelog: https://github.com/npm/cli/releases/tag/v10.4.0
    npm notice Run npm install -g npm@10.4.0 to update!
    npm notice
    # 安装完成后查看TypeScript的版本。
    ~/npmTest$ npx tsc --version
    Version 5.3.3
    ```

1. npm的镜像源设置是根据安装的NodeJS设定的，所以每个版本NodeJS的镜像源都需要单独设置。
