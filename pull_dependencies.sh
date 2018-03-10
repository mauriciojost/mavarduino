#!/bin/bash

# This script will pull the dependency libraries from GitHub
# using dependencies settings with platformio syntax: 
# - esp8266/Arduino#master
# - mauriciojost/log4ino-arduino#1.0.0
# - git@bitbucket.org:mauriciojost/main4ino-arduino.git#master
# In an attempt to stop using platformio (community not big enough yet).

ROOT_DIR=`dirname $(readlink -e $0)`
CONFIG_FILE=$1
LIBS_DIR=$ROOT_DIR/lib_deps_external
SRC_DIR=$ROOT_DIR/src

function pull_dependency() {
  local d="$1"
  if [[ "$d" =~ ^(.*)/(.*)\.git#(.*):(.*)$ ]]; 
  then 
    local giturl=${BASH_REMATCH[1]}/${BASH_REMATCH[2]}.git
    local gitproject=${BASH_REMATCH[2]}
    local gitbranch=${BASH_REMATCH[3]}
    local gitfiles=${BASH_REMATCH[4]}
  elif [[ "$d" =~ ^(.*)/(.*)#(.*):(.*)$ ]]; 
  then 
    local gituser=${BASH_REMATCH[1]}
    local gitproject=${BASH_REMATCH[2]}
    local giturl="https://github.com/$gituser/$gitproject.git"
    local gitbranch=${BASH_REMATCH[3]}
    local gitfiles=${BASH_REMATCH[4]}
  else 
    echo "Unkown syntax, discarding: $d"
  fi
  echo "Pulling: $giturl / $gitbranch (files: $gitfiles)"
  cd $LIBS_DIR
  git clone -b "$gitbranch" "$giturl"

  local dep_dir="$gitproject"
  local src_dir="$SRC_DIR"
  echo "Linking $dep_dir/$gitfiles to $src_dir/..."
  ln -sf `readlink -e $dep_dir/$gitfiles` $src_dir/

}



source $CONFIG_FILE

rm -fr "$LIBS_DIR"
mkdir -p "$LIBS_DIR"
for dep in $LIB_DEPS_EXTERNAL
do
  pull_dependency "$dep"
done
