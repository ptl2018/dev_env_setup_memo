# 更新Gradle镜像源为阿里源

信息源:

- [阿里云云效 Maven](https://developer.aliyun.com/mvn/guide)
- [Configuring projects from an init script](https://docs.gradle.org/current/userguide/init_scripts.html#sec:configuring_projects_from_an_init_script)

在以下位置寻找init.gradle文件。(如果不存在，请新建。)

- Windwos: `%USERPROFILE%/.gradle/init.gradle`
- Linux: `~/.gradle/init.gradle`

然后追加以下内容。

```groovy
allprojects {
    repositories {
        maven { url 'https://maven.aliyun.com/repository/central' }
        maven { url 'https://maven.aliyun.com/repository/public' }
        maven { url 'https://maven.aliyun.com/repository/gradle-plugin' }
        maven { url 'https://maven.aliyun.com/repository/apache-snapshots' }
    }
}
```
