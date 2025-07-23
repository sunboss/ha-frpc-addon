#!/bin/sh

CONFIG_FILE="/share/frpc.ini"
LOG_FILE="/share/frpc.log"

# 从环境变量获取配置
SERVER_ADDR=${SERVER_ADDR}
SERVER_PORT=${SERVER_PORT}
TOKEN=${TOKEN}
LOCAL_PORT=${LOCAL_PORT}
PROXY_NAME=${PROXY_NAME}
PROXY_TYPE=${PROXY_TYPE}
ADMIN_PORT=${ADMIN_PORT}
ADMIN_USER=${ADMIN_USER}
ADMIN_PWD=${ADMIN_PWD}

# 验证必要参数
if [ -z "${SERVER_ADDR}" ]; then
  echo "Error: server_addr is required" | tee -a ${LOG_FILE}
  exit 1
fi

# 生成 frpc.ini 配置文件
cat > ${CONFIG_FILE} << EOF
[common]
server_addr = ${SERVER_ADDR}
server_port = ${SERVER_PORT}
log_file = ${LOG_FILE}
log_level = info
EOF

# 添加 token
if [ -n "${TOKEN}" ]; then
  echo "token = ${TOKEN}" >> ${CONFIG_FILE}
fi

# 添加 Admin UI（如果 admin_user 不为空）
if [ -n "${ADMIN_USER}" ]; then
  cat >> ${CONFIG_FILE} << EOF
admin_addr = 0.0.0.0
admin_port = ${ADMIN_PORT}
admin_user = ${ADMIN_USER}
admin_pwd = ${ADMIN_PWD}
EOF
fi

# 添加代理配置
cat >> ${CONFIG_FILE} << EOF

[${PROXY_NAME}]
type = ${PROXY_TYPE}
local_ip = 0.0.0.0
local_port = ${LOCAL_PORT}
EOF

# 启动 frpc
echo "Starting frpc with config: ${CONFIG_FILE}" | tee -a ${LOG_FILE}
/usr/bin/frpc -c ${CONFIG_FILE}
