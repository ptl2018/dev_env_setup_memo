# 更新Maven镜像源为阿里源

信息源:  

- [阿里云云效 Maven](https://developer.aliyun.com/mvn/guide)
- [Maven官方文档](https://maven.apache.org/settings.html#mirrors)

在以下位置寻找settings.xml文件。(如果不存在，请新建。)

- Windwos: `%USERPROFILE%/.m2/settings.xml`
- Linux: `~/.m2/settings.xml`

然后在setting>mirrors里追加以下内容。

```xml
<mirror>
  <id>aliyunCentral</id>
  <mirrorOf>*</mirrorOf>
  <name>阿里云Central</name>
  <url>https://maven.aliyun.com/repository/central</url>
</mirror>
<mirror>
  <id>aliyunPublic</id>
  <mirrorOf>*</mirrorOf>
  <name>阿里云Public</name>
  <url>https://maven.aliyun.com/repository/public</url>
</mirror>
<mirror>
  <id>aliyunGradle-plugin</id>
  <mirrorOf>*</mirrorOf>
  <name>阿里云Gradle-plugin</name>
  <url>https://maven.aliyun.com/repository/gradle-plugin</url>
</mirror>
<mirror>
  <id>aliyunApache-snapshots</id>
  <mirrorOf>*</mirrorOf>
  <name>阿里云Apache-snapshots</name>
  <url>https://maven.aliyun.com/repository/apache-snapshots</url>
</mirror>
```
