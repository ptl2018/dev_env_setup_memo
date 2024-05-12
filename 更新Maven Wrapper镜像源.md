# 更新Maven Wrapper镜像源为国内源

信息源:  

- [Maven Wrapper 国内源](https://seepine.com/dev/maven/wrapper/)
- [Maven Wrapper 官方文档](https://maven.apache.org/wrapper)
- [腾讯镜像下载页](https://mirrors.cloud.tencent.com/apache/maven/maven-3/)
- [阿里云镜像下载页](https://mirrors.aliyun.com/apache/maven/maven-3/)

在项目中找到以下文件。

- `.mvn/wrapper/maven-wrapper.properties`

然后替换以下内容。

腾讯镜像:

```proerties
# distributionUrl=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.6/apache-maven-3.9.6-bin.zip
distributionUrl=https://mirrors.cloud.tencent.com/apache/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip
```

阿里云镜像:

```proerties
# distributionUrl=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.6/apache-maven-3.9.6-bin.zip
distributionUrl=https://mirrors.aliyun.com/apache/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip
```
