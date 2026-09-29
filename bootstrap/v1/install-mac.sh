#!/usr/bin/env bash
set -euo pipefail
[[ "$(uname -s)" == Darwin ]] || { echo '请在 macOS 终端运行。' >&2; exit 1; }
[[ -n "${JDFW_UPDATE_KEY_BASE64:-}" ]] || { echo '缺少私下交付的首次安装码。' >&2; exit 1; }
case "$(uname -m)" in
  arm64) target='darwin-arm64' ;;
  x86_64) target='darwin-amd64' ;;
  *) echo '不支持此 Mac CPU 架构。' >&2; exit 1 ;;
esac
base='https://raw.githubusercontent.com/595911/jingdong-waiting-feedback-updates/main/bootstrap/v1'
umask 077
stage="$(mktemp -d "${TMPDIR:-/tmp}/jdfw-feedback-install.XXXXXX")"
trap 'rm -rf "$stage"' EXIT
curl -fsSL "$base/$target/jdfw-feedback-updater" -o "$stage/jdfw-feedback-updater"
curl -fsSL "$base/$target/jdfw-feedback-updater.sha256" -o "$stage/jdfw-feedback-updater.sha256"
expected="$(tr -d '\r\n' < "$stage/jdfw-feedback-updater.sha256")"
[[ "$expected" =~ ^[0-9a-f]{64}$ ]] || { echo '安装程序摘要格式错误。' >&2; exit 1; }
actual="$(shasum -a 256 "$stage/jdfw-feedback-updater" | awk '{print $1}')"
[[ "$actual" == "$expected" ]] || { echo '安装程序摘要不匹配。' >&2; exit 1; }
chmod 700 "$stage/jdfw-feedback-updater"
"$stage/jdfw-feedback-updater" --install-latest
"$stage/jdfw-feedback-updater" --verify
if [[ "${JDFW_INSTALL_HEADLESS:-}" == 1 ]]; then exit 0; fi
load_dir="$HOME/.local/share/jdfw-feedback-update/extension"
printf '%s' "$load_dir" | pbcopy
open -a 'Google Chrome' 'chrome://extensions' || true
open -R "$load_dir" || true
echo "Chrome 加载目录已复制到剪贴板：$load_dir"
echo '请开启开发者模式，点击“加载已解压的扩展程序”并选择该目录；不要直接卸载旧 ID 扩展。'
