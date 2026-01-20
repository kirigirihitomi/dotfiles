#!/bin/bash

# 获取当前脚本所在目录的绝对路径
DOTFILES_DIR=$(cd $(dirname $0); pwd)
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

echo "🛠️ 正在为您同步 Ayu Mirage Zsh 配置..."

# 1. 确保 Oh My Zsh 已安装
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 安装 Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 2. 安装你配置中需要的第三方插件
echo "🔌 检查插件..."
# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi
# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# 3. 链接配置文件
# 使用 -f 强制覆盖，确保容器内的 .zshrc 指向你仓库里的这一份
echo "🔗 链接 .zshrc 文件..."
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# 链接配置文件
echo "🔗 正在强制覆盖 .zshrc..."
# 先删除容器自带的，防止链接失败
rm -f "$HOME/.zshrc"
# 建立软链接
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# 【关键】强制刷新一次权限，并确保文件末尾没有被容器脚本偷偷修改
# 有些镜像会在启动时检测 .zshrc，如果没有特定标记会重新生成
touch "$HOME/.zshrc"