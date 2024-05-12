# 更新Gradle Wrapper镜像源

信息源:  

- [Gradle Wrapper 国内源](https://seepine.com/dev/gradle/wrapper/)
- [Gradle Wrapper Reference](https://docs.gradle.org/current/userguide/gradle_wrapper.html#sec:adding_wrapper)
- [腾讯镜像下载页](https://mirrors.cloud.tencent.com/apache/maven/maven-3/)
- [阿里云镜像下载页](https://mirrors.aliyun.com/apache/maven/maven-3/)

在项目中找到以下文件。

- `gradle/wrapper/gradle-wrapper.properties`

然后替换以下内容。

腾讯镜像:

```proerties
# distributionUrl=https\://services.gradle.org/distributions/gradle-8.7-bin.zip
distributionUrl=https://mirrors.cloud.tencent.com/gradle/gradle-8.7-bin.zip
```
