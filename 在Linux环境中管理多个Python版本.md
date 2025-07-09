# 在Linux环境中管理多个Python版本

信息源:

- [pyenv](https://github.com/pyenv/pyenv)
  - [Install Python build dependencies](https://github.com/pyenv/pyenv/wiki#suggested-build-environment)
  - [Installation](https://github.com/pyenv/pyenv?tab=readme-ov-file#installation)
  - [plugins](https://github.com/pyenv/pyenv?tab=readme-ov-file#pyenv-plugins)
- [阿里云](https://mirrors.aliyun.com/python-release/source)

## 安装

### 安装依赖

```bash
sudo apt update; sudo apt install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```

### 安装pyenv

```bash
# 克隆代码
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
# 尝试编译动态 Bash 扩展以加速 Pyenv(执行或不执行皆可)
cd ~/.pyenv && src/configure && make -C src
```

### 配置环境变量

```bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc
```

### 安装plugin

    git clone https://github.com/pyenv/pyenv-update.git $(pyenv root)/plugins/pyenv-update
    git clone https://github.com/pyenv/pyenv-doctor.git $(pyenv root)/plugins/pyenv-doctor


### 将python安装包的下载地址替换为阿里源。

    find $(pyenv root)/plugins/python-build/share/python-build -type f -exec sed -i 's#www\.python\.org/ftp/python/[0-9]\+\.[0-9]\+\.[0-9]\+#mirrors.aliyun.com/python-release/source#g' {} +

上述操作将导致pyenv update失败。
可通过如下命令重置.pyenv文件夹

    cd $(pyenv root)
    git reset --hard
    pyenv update

执行完`pyenv update`后，请再次将python安装包的下载地址替换为阿里源, 以便下次安装新版本。


### 安装指定版本的Python

这里以3.9.20为例。

```bash
# 查看可安装的版本
pyenv install --list
# 安装指定版本
pyenv install 3.9.20
# 确认安装成功
pyenv versions
```

可以通过上述命令，安装多个Python版本。

切换Python版本。

```bash
# 设置全局Python版本为3.9.20
pyenv global 3.9.20
# 查看当前Python版本
python --version
# 恢复系统默认Python版本
pyenv global system
# 查看当前Python版本
python --version
```
