# 搭建Java开发环境(Ubuntu)

信息源:

1. [Install Azul Zulu on Debian-based Linux(Azul官网)](https://docs.azul.com/core/install/debian)
1. [Manage Multiple Azul Zulu Versions on Linux](https://docs.azul.com/core/manage-multiple-zulu-versions/linux)
1. [jenv](https://github.com/jenv/jenv)

---

在国外一般使用[SDKMAN](https://sdkman.io/)，在Linux/Mac上安装及管理JDK版本。但是在国内，因速度太慢，不是太方便。  
本文介绍在国内较为快速，方便的安装及管理JDK版本的方法。  
仅仅时安装JDK的话，仅执行到 [安装zuluJDK](#安装zulujdk)即可。  
如果需要管理多个JDK版本，请参照[安装jenv](#安装jenv)。  

## 安装zuluJDK

1. 导入 Azul的 public key:

    ```bash
    sudo apt install gnupg ca-certificates curl
    curl -s https://repos.azul.com/azul-repo.key | sudo gpg --dearmor -o /usr/share/keyrings/azul.gpg
    echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | sudo tee /etc/apt/sources.list.d/zulu.list
    ```

1. 更新可用软件列表:  
    ```sudo apt update```
1. 查找要安装的软件包名称(此方法有待改进):
    ```sudo apt search jdk | grep "jdk/"```
1. 安装JDK  (如果只需要一个确定的版本，请从命令中删除其它版本)
    ```sudo apt install -y zulu8-jdk zulu11-jdk zulu17-jdk zulu21-jdk```
1. 使用`java --version`命令确认java可用。  

## 安装jenv

jenv是用来管理使用的java版本的工具。

```bash
git clone https://github.com/jenv/jenv.git ~/.jenv
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(jenv init -)"' >> ~/.bashrc
source ~/.bashrc
```

请使用`jenv --version`命令确认安装成功。

## 更改默认JDK版本

1. 确认已安装的JDK及相应路径。

    ```bash
    sudo update-alternatives --config javac
    ```

    执行上述命令后屏幕上会显示系统中存在的JDK版本。  
    并等待用户输入`Selection`列中的数字。  
    在这里我们只确认JDK的安装位置，不进行修改。
    所以，按enter键直接结束。  
    **注意，上述命令中用的是`javac`，而不是`java`。**

    示例:

    ```bash
    ~$ sudo update-alternatives --config javac
    There are 4 choices for the alternative java (providing /usr/bin/javac).

      Selection    Path                             Priority   Status
    ------------------------------------------------------------
    * 0            /usr/lib/jvm/zulu21/bin/javac      2213001   auto mode
      1            /usr/lib/jvm/zulu11/bin/javac      2116801   manual mode
      2            /usr/lib/jvm/zulu17/bin/javac      2174601   manual mode
      3            /usr/lib/jvm/zulu21/bin/javac      2213001   manual mode
      4            /usr/lib/jvm/zulu8/bin/javac    1807401   manual mode

    Press <enter> to keep the current choice[*], or type selection number:
    ~$
    ```

1. 向jenv导入java环境  
    命令格式：`jenv add ${java安装目录}`  
    示例:

    ```bash
    ~$ jenv add /usr/lib/jvm/zulu8/
    zulu64-1.8.0.392 added
    1.8.0.392 added
    1.8 added
    ...省略...
    ~$ jenv add /usr/lib/jvm/zulu21/
    zulu64-21.0.1 added
    21.0.1 added
    21.0 added
    21 added
    ~$
    ```

1. 确认导入成果

    ```bash
    ~$ jenv versions
    * system (set by /home/userName/.jenv/version)
      1.8
      1.8.0.392
      ...省略...
      21
      21.0
      21.0.1
      zulu64-1.8.0.392
      zulu64-11.0.21
      zulu64-17.0.9
      zulu64-21.0.1
    ~$
    ```

    从上述结果可知，`jenv add`命令会将同一个jdk，以多个名称进行登录。

1. 更新使用的JDK版本

    使用`java --version`确认当前java版本。

    ```bash
    ~$ java --version
    openjdk 21.0.1 2023-10-17 LTS
    OpenJDK Runtime Environment Zulu21.30+15-CA (build 21.0.1+12-LTS)
    OpenJDK 64-Bit Server VM Zulu21.30+15-CA (build 21.0.1+12-LTS, mixed mode, sharing)
    ```

    更新使用的JDK版本。(备注: 执行global,local等命令后，必须执行rehash才能反映到系统上。)

    ```bash
    jenv global 11
    jenv rehash
    ```

    使用`java --version`确认当前java版本。

    ```bash
    java --version
    openjdk 11.0.21 2023-10-17 LTS
    OpenJDK Runtime Environment Zulu11.68+17-CA (build 11.0.21+9-LTS)
    OpenJDK 64-Bit Server VM Zulu11.68+17-CA (build 11.0.21+9-LTS, mixed mode)
    ```
