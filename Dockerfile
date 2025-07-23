FROM alpine:3.20

ARG BUILD_ARCH

# 安装依赖
RUN apk add --no-cache wget tar jq

# 根据架构下载并安装 frpc（使用 ghproxy.net 加速，针对国内用户）
RUN case "${BUILD_ARCH}" in \
      "amd64") \
        wget https://ghproxy.net/https://github.com/fatedier/frp/releases/download/v0.63.0/frp_0.63.0_linux_amd64.tar.gz && \
        tar xzvf frp_0.63.0_linux_amd64.tar.gz && \
        mv frp_0.63.0_linux_amd64/frpc /usr/bin/frpc && \
        rm -rf frp_0.63.0_linux_amd64*; \
        ;; \
      "aarch64") \
        wget https://ghproxy.net/https://github.com/fatedier/frp/releases/download/v0.63.0/frp_0.63.0_linux_arm64.tar.gz && \
        tar xzvf frp_0.63.0_linux_arm64.tar.gz && \
        mv frp_0.63.0_linux_arm64/frpc /usr/bin/frpc && \
        rm -rf frp_0.63.0_linux_arm64*; \
        ;; \
      "armv7") \
        wget https://ghproxy.net/https://github.com/fatedier/frp/releases/download/v0.63.0/frp_0.63.0_linux_arm.tar.gz && \
        tar xzvf frp_0.63.0_linux_arm.tar.gz && \
        mv frp_0.63.0_linux_arm/frpc /usr/bin/frpc && \
        rm -rf frp_0.63.0_linux_arm*; \
        ;; \
      "armhf") \
        wget https://ghproxy.net/https://github.com/fatedier/frp/releases/download/v0.63.0/frp_0.63.0_linux_arm.tar.gz && \
        tar xzvf frp_0.63.0_linux_arm.tar.gz && \
        mv frp_0.63.0_linux_arm/frpc /usr/bin/frpc && \
        rm -rf frp_0.63.0_linux_arm*; \
        ;; \
      *) \
        echo "Unsupported architecture: ${BUILD_ARCH}"; exit 1; \
        ;; \
    esac

# 设置执行权限
RUN chmod +x /usr/bin/frpc

# 复制启动脚本
COPY run.sh /run.sh
RUN chmod +x /run.sh

# 运行脚本
CMD ["/run.sh"]
