#!/bin/bash

# 检查操作系统类型
OS=$(uname -s)

# 获取当前 IPv6 状态
ipv6_status=$(sysctl net.ipv6.conf.all.disable_ipv6 | awk '{print $3}')

# 检查是否为 root 用户
if [ "$(id -u)" -ne 0 ]; then
  echo "请使用 root 权限运行此脚本！"
  exit 1
fi

# 关闭 IPv6
disable_ipv6() {
  echo "禁用 IPv6..."
  sysctl -w net.ipv6.conf.all.disable_ipv6=1
  sysctl -w net.ipv6.conf.default.disable_ipv6=1
  sysctl -w net.ipv6.conf.lo.disable_ipv6=1

  # 处理不同的发行版
  if [[ "$OS" == "Linux" ]]; then
    # 对于 Ubuntu/Debian 系统，禁用 IPv6
    if [ -f /etc/sysctl.conf ]; then
      echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
      echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
      echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
    fi
  fi

  echo "IPv6 已禁用."
}

# 启用 IPv6
enable_ipv6() {
  echo "启用 IPv6..."
  sysctl -w net.ipv6.conf.all.disable_ipv6=0
  sysctl -w net.ipv6.conf.default.disable_ipv6=0
  sysctl -w net.ipv6.conf.lo.disable_ipv6=0

  # 处理不同的发行版
  if [[ "$OS" == "Linux" ]]; then
    # 对于 Ubuntu/Debian 系统，启用 IPv6
    if [ -f /etc/sysctl.conf ]; then
      sed -i '/net.ipv6.conf.all.disable_ipv6/d' /etc/sysctl.conf
      sed -i '/net.ipv6.conf.default.disable_ipv6/d' /etc/sysctl.conf
      sed -i '/net.ipv6.conf.lo.disable_ipv6/d' /etc/sysctl.conf
    fi
  fi

  echo "IPv6 已启用."
}

# 检查当前 IPv6 状态并切换
if [ "$ipv6_status" -eq 1 ]; then
  echo "当前 IPv6 已禁用，正在启用 IPv6..."
  enable_ipv6
else
  echo "当前 IPv6 已启用，正在禁用 IPv6..."
  disable_ipv6
fi
