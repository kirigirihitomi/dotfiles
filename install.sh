#!/bin/bash

set -e

echo "🚀 开始配置 Zsh 环境..."

# 1. 安装 Oh My Zsh (如果没安装)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "安装 Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 2. 安装常用的插件 (自动克隆到 oh-my-zsh 目录)
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

echo "安装插件: zsh-autosuggestions & zsh-syntax-highlighting..."
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# 3. 链接配置文件
# 这里假设你的仓库里有 .zshrc 文件
# 使用 ln -sf 强制创建软链接，将仓库里的配置映射到系统根目录
echo "应用配置文件..."
DOTFILES_DIR=$(cd $(dirname $0); pwd)
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# 如果你有 Powerlevel10k 配置
if [ -f "$DOTFILES_DIR/.p10k.zsh" ]; then
    ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
fi

echo "✨ 配置完成！请重新载入 Zsh 或执行 'source ~/.zshrc'"
