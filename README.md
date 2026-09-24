# IPv6 一键启用/禁用脚本

自动检测当前 IPv6 状态，并执行相反操作：如果当前 IPv6 已启用，则禁用它；如果当前已禁用，则启用它。

## 特性

- 自动判断当前 IPv6 状态
- 一键切换 IPv6 启用/禁用
- 修改运行时内核参数
- 写入 `/etc/sysctl.conf`，重启后仍然生效
- 需要 root 权限运行

## 一键运行

将下面的 `yourname/yourrepo` 替换为你的 GitHub 用户名和仓库名。

### 使用 curl

```bash
curl -fsSL https://raw.githubusercontent.com/SunMoonWithYou/toggle_ipv6/main/install.sh | sudo bash
```

### 使用 wget

```bash
wget -qO- https://raw.githubusercontent.com/SunMoonWithYou/toggle_ipv6/main/install.sh | sudo bash
```

## 说明

- 运行后会自动检测当前 IPv6 状态并切换
- 必须使用 root 权限
- 再次运行即可切换回来
- 如果默认分支不是 `main`，请将命令中的 `main` 改为 `master` 或其他分支名

## 注意事项

- 请确认远程脚本来源可信后再执行
- 脚本会修改 `/etc/sysctl.conf`
- 修改内核参数可能影响 Docker、容器、代理、网络服务等
- 生产环境建议使用 `/etc/sysctl.d/` 目录管理配置

## License

MIT
