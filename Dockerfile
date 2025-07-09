FROM debian:bookworm-slim

# 将镜像源设置为清华大学的镜像源
# 参考: https://mirrors.tuna.tsinghua.edu.cn/help/debian/
# 备注: 此镜像源使用http协议连接，不安全。仅是为了安装用于https协议的库的临时对策
RUN printf '%s\n' \
  "Types: deb" \
  "URIs: http://mirrors.tuna.tsinghua.edu.cn/debian" \
  "Suites: bookworm bookworm-updates bookworm-backports" \
  "Components: main contrib non-free non-free-firmware" \
  "Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg" \
  "" \
  "Types: deb" \
  "URIs: http://mirrors.tuna.tsinghua.edu.cn/debian-security" \
  "Suites: bookworm-security" \
  "Components: main contrib non-free non-free-firmware" \
  "Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg" \
  > /etc/apt/sources.list.d/debian.sources
# 安装用于https协议的库
RUN apt update && apt install -y apt-transport-https ca-certificates

# 将镜像源连接方式改为https
RUN sed -i 's/http/https/g' /etc/apt/sources.list.d/debian.sources

# 清空之前用http协议连接的镜像源缓存,重新获取apt信息
RUN apt clean && \
  rm -rf /var/lib/apt/lists/* \
  apt update

CMD ["bash"]