#!/bin/bash

function install_vim() {
    if [[ -d $HOME/.vim ]]; then
        rm -rf $HOME/.vim
    fi

    if [[ -f $HOME/.vimrc ]]; then 
        rm -rf $HOME/.vimrc
    fi

    tar xf vimfiles.tar.gz
    
    if (( $? )); then 
        echo "decompress vimfiles.tar.gz failed!"
        return -1
    fi

    cp -r vimfiles/_vimrc $HOME/.vimrc
    cp -r vimfiles/vimfiles $HOME/.vim 

    chmod +x $HOME/.vim/bin/unix/*
}

function make_deps() {
    cd deps

    tar xf cscope.tar.bz && cd cscope && ./configure && make && cd ..
    if (( $? )); then 
        echo "build cscope failed!"
        return -1
    fi

    tar xf ctags.tar.bz && cd ctags && ./configure && make && cd ..
    if (( $? )); then 
        echo "build ctags failed!"
        return -1
    fi
    
    rm -rf $HOME/.vim/bin/unix/ctags
    rm -rf $HOME/.vim/bin/unix/cscope

    cp -f ctags/ctags $HOME/.vim/bin/unix/ctags
    cp -f cscope/src/cscope $HOME/.vim/bin/unix/cscope

    rm -rf ctags 
    rm -rf cscope

    cd ..
}

function make_go_deps() {
    cd deps/godeps/
    ./build.sh

    rm -rf $HOME/.vim/bin/unix/errcheck
    rm -rf $HOME/.vim/bin/unix/gocode
    rm -rf $HOME/.vim/bin/unix/godef
    rm -rf $HOME/.vim/bin/unix/gofmt
    rm -rf $HOME/.vim/bin/unix/goimports
    rm -rf $HOME/.vim/bin/unix/golint
    rm -rf $HOME/.vim/bin/unix/gorename
    rm -rf $HOME/.vim/bin/unix/gotags
    rm -rf $HOME/.vim/bin/unix/oracle

    cp -f godeps/bin/errcheck  $HOME/.vim/bin/unix/errcheck
    cp -f godeps/bin/gocode    $HOME/.vim/bin/unix/gocode
    cp -f godeps/bin/godef     $HOME/.vim/bin/unix/godef
    cp -f godeps/bin/gofmt     $HOME/.vim/bin/unix/gofmt
    cp -f godeps/bin/goimports $HOME/.vim/bin/unix/goimports
    cp -f godeps/bin/golint    $HOME/.vim/bin/unix/golint
    cp -f godeps/bin/gorename  $HOME/.vim/bin/unix/gorename
    cp -f godeps/bin/gotags    $HOME/.vim/bin/unix/gotags
    cp -f godeps/bin/oracle    $HOME/.vim/bin/unix/oracle  

    rm -rf godeps
}

function uninstall_vim() {
    rm -rf $HOME/.vim
    rm -rf $HOME/.vimrc
}

case $1 in 
    "deps")
        make_deps
        echo "install deps done"
        ;;
    "godeps") 
        make_go_deps
        echo "install godeps done"
        ;;
    "uninstall")
        uninstall_vim 
        echo "uninstall vim done"
        ;;
    *)
        install_vim
        echo "install vim done"
esac
