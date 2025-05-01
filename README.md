```
ln -s ~/projects/personal/dotfiles/.wezterm.lua ~/
ln -s ~/projects/personal/dotfiles/.tmux ~/
ln -s ~/projects/personal/dotfiles/.tmux.conf ~/
ln -s ~/projects/personal/dotfiles/zsh/.zshrc ~/
ln -s ~/projects/personal/dotfiles/cht.sh ~/
ln -s ~/projects/personal/dotfiles/nvim/cspell.json ~/
ln -s ~/projects/personal/dotfiles/nvim/cspell.json ~/.config/
ln -s ~/projects/personal/dotfiles/nvim ~/.config/
ln -s ~/projects/personal/dotfiles/starship.toml ~/.config/
```

install omz

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
git clone https://github.com/mroth/evalcache ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/evalcache
```

install tpm

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

arg complete

```
pip install argcomplete
activate-global-python-argcomplete
```
