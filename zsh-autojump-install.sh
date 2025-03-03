#!/bin/bash

# 安装必要的软件包
sudo yum install -y zsh git python3 util-linux-user ython3-pip

# 安装 oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# 下载 zsh-autosuggestions 插件
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# 下载 zsh-syntax-highlighting 插件
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 手动安装 autojump
if ! command -v autojump &> /dev/null; then
    echo "autojump 未安装，开始手动安装..."
    git clone https://github.com/wting/autojump.git /tmp/autojump
    cd /tmp/autojump
    python3 install.py
    cd ~
    rm -rf /tmp/autojump
    echo "autojump 安装完成！"
else
    echo "autojump 已安装，跳过手动安装步骤。"
fi

# 修改 ZSH_THEME
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="eastwood"/g' ~/.zshrc

# 启用插件
sed -i 's/plugins=(git)/plugins=(git autojump zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

# 配置 autojump 集成到 zsh
echo "[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh" >> ~/.zshrc

# 将默认 shell 更改为 zsh
if command -v chsh &> /dev/null; then
    echo "尝试使用 chsh 更改默认 shell..."
    sudo chsh -s $(which zsh) $(whoami)
else
    echo "chsh 命令未找到，尝试使用 usermod 更改默认 shell..."
    sudo usermod -s $(which zsh) $(whoami)
fi

# 如果上述方法失败，手动编辑 /etc/passwd 文件
if [[ $(echo $SHELL) != $(which zsh) ]]; then
    echo "自动更改默认 shell 失败，正在尝试手动编辑 /etc/passwd 文件..."
    ZSH_PATH=$(which zsh)
    sudo sed -i "s|^$(whoami):.*:.*:.*:.*:.*:.*$|$(whoami):x:$(id -u):$(id -g):$(whoami):/home/$(whoami):$ZSH_PATH|" /etc/passwd
fi

# 提示用户重新登录以应用更改
echo "安装完成！请重新登录以应用更改。"
