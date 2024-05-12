# 更新pip镜像源

信息源:

- [阿里云云效 pypi](https://developer.aliyun.com/mirror/pypi)
- [清华大学开源软件镜像站](https://mirrors.tuna.tsinghua.edu.cn/help/pypi/)
- [官方文档](https://pip.pypa.io/en/stable/topics/configuration/#location)

在以下位置寻找配置文件。(如果不存在，请新建。)

Windows: `%HOME%/pip/pip.ini`  
Linux: `$HOME/.config/pip/pip.conf`

然后追加以下内容。

```ini
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
extra-index-url = 
    https://mirrors.aliyun.com/pypi/simple/
[install]
trusted-host = 
    pypi.tuna.tsinghua.edu.cn
    mirrors.aliyun.com
```
