#!/bin/bash

find `pwd` -name "*.c" -o -name "*.h" -o -name "*.S" > cscope.files

echo "Cscope is setting up"
echo "============================================================================="

cscope -q -R -b -i cscope.files
if [ $? -eq 0 ]; then
    echo "Symbol table created"
else
    echo "Cscope Not found, Installing cscope "
    sudo apt-get install cscope
    cscope -q -R -b -i cscope.files
fi

if [ -f cscope.out ]; then echo "cscope.out created"; else echo "Creating symbol table failed"; fi

DIRECTORY=~/.vim
if [ ! -d "$DIRECTORY" ]; then
   # Control will enter here if $DIRECTORY doesn't exist.
   mkdir ~/.vim
fi

DIRECTORY=~/.vim/plugin
if [ ! -d "$DIRECTORY" ]; then
   # Control will enter here if $DIRECTORY doesn't exist.
   mkdir ~/.vim/plugin
fi

if [ ! -f ~/.vim/plugin/cscope_maps.vim ]; then
    echo "cscope maps not found, trying to fetch it"
    wget -U firefox "http://cscope.sourceforge.net/cscope_maps.vim"
    echo "Setting up cscope_maps"
    sed --in-place 's/[[:space:]]\+$//' cscope_maps.vim
    mv cscope_maps.vim ~/.vim/plugin/
fi

if [ ! -f ~/.vimrc ]; then
   # Control will enter here if $DIRECTORY doesn't exist.
   echo "creating ~/.vimrc file"
   touch ~/.vimrc
fi

if [ -z $CSCOPE_DB ]; then #echo "set"; else echo "not set"; fi
    echo Setting '$CSCOPE_DB' to "`pwd`/cscope.out"
    echo "export CSCOPE_DB=`pwd`/cscope.out" >> ~/.bashrc
    echo "Adding cscope database to vimrc"
    echo cs add '$CSCOPE_DB' >> ~/.vimrc
else
    echo Setting CSCOPE_DB2 to "`pwd`/cscope.out"
    echo "export CSCOPE_DB2=`pwd`/cscope.out" >> ~/.bashrc
    echo "Adding cscope database to vimrc"
    echo cs add '$CSCOPE_DB2' >> ~/.vimrc
fi

echo " "
echo "-------------------------------------"
echo " Now execute ---- $ source ~/.bashrc "
echo "-------------------------------------"
echo " "

echo "Then try the following shortcuts from your source files"
echo "CTRL-\ then press 'g' global: to find find global definition(s) of the token under cursor"
echo "CTRL-\ then press 'c' calls:  find all calls to the function name under cursor"
echo "CTRL-\ then press 's' symbol: find all matches to the word under cursor"
echo "Check more shortcuts on ~/.vim/plugin/cscope_maps.vim"

