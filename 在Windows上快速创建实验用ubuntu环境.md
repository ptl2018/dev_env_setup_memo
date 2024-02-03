# 在Windows上快速创建实验用ubuntu环境

**前提:**

请根据微软官方文档[WSL 2 上的 Docker 远程容器入门](https://learn.microsoft.com/zh-cn/windows/wsl/tutorials/wsl-containers)自行安装Docker。

```bash
# 第一次启动
docker run --name ub -it ubuntu
# 推出会话后，容器会自动关闭，下次使用时需重新启动容器。
docker start ub
# 上述命令仅仅是启动容器，并未连接到容器，所以用下述命令连接到容器。
docker attach ub
```
