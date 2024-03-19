# Aliases for speeding up workflow 🚀🚀

download_vim (){
    curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o ~/nvim.appimage
    chmod u+x ~/nvim.appimage

    ~/nvim.appimage --appimage-extract
    ~/squashfs-root/AppRun --version

    # expose nvim globally.
    md ~/.nvim
    sudo mv ~/squashfs-root/* ~/.nvim
    sudo ln -s ~/.nvim/AppRun /usr/bin/nvim

    echo "if script failed to run, make sure the '/squashfs-root' dir and '/usr/bin/nvim' symlink do not exist"
}


alias fd='fdfind'

alias update_nvim='download_vim()'

# shortcut vim
v () {
  nvim $@ || vim $@
}

cdf  (){
    # search directories
    path_result=$(fd . -t d -E node_modules -p $1 | fzf)
    if [[ $path_result ]] then
        cd $path_result
    fi
}

cdfh () {
    # search hidden directories. --max-depth is used for performance gains
    path_result=$(fd . -t d -HE=node_modules --max-depth=5 -p $1 | fzf ) || .
    if [[ $path_result ]] then
        cd $path_result
    fi
}

cdfp () {
    # search hidden directories. --max-depth is used for performance gains
    path_result=$(fd -IHg ".git" $1 | fzf ) || .
    if [[ $path_result ]] then
        cd $path_result
    fi
}

# alias python
alias py='python3'
alias python='python3'
