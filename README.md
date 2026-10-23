# 待反馈扩展公开更新文件

此仓库只存放加密的扩展运行包、公开版本索引和安装程序，不含私有源码或解密密钥。安装者仍可查看本机解密后的扩展运行文件。

当前首次安装和已有更新器迁移入口为 `bootstrap/v3/`，支持旧六文件和新七文件（Side Panel）运行包。v1.7.3 及后续版本需要新版更新器。`bootstrap/v2/` 保留供追溯，旧安装者需运行一次 v3 安装脚本升级更新器；已有安装复用本机配置，不要求重新输入安装码，不清除 Chrome 的缓存、待办、规则和标记。首次安装仍需维护者私下给安装码；不要公开安装码或本机 config.json。

已有安装的迁移命令：

Mac：

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/595911/jingdong-waiting-feedback-updates/main/bootstrap/v3/install-mac.sh)"
```

Windows PowerShell：

```powershell
iex (irm https://raw.githubusercontent.com/595911/jingdong-waiting-feedback-updates/main/bootstrap/v3/install-windows.ps1)
```

`bootstrap/v1/` 曾在 Windows 首装验证中失败，请勿使用。

`latest.json` 指向当前密文。后续扩展更新由用户主动点击；安装和升级后仍需用户在 Chrome 扩展管理页手动加载或重新加载。不关闭或重启 Chrome，不刷新业务页面。
