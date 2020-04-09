#!/usr/bin/env bash

function bump() {

  local VERSION="$1"
  local BUMP="$2"

  export MAJOR=`echo $VERSION | awk -F'[.-]' '{printf $1}'`
  export MINOR=`echo $VERSION | awk -F'[.-]' '{printf $2}'`
  export PATCH=`echo $VERSION | awk -F'[.-]' '{printf $3}'`

  if [ "$BUMP" == "MAJOR" ]
  then
    export NEW_MAJOR=`inc $MAJOR`
    export NEW_MINOR=0
    export NEW_PATCH=0
  elif [ "$BUMP" == "MINOR" ]
  then
    export NEW_MAJOR=$MAJOR
    export NEW_MINOR=`inc $MINOR`
    export NEW_PATCH=0
  elif [ "$BUMP" == "PATCH" ]
  then
    export NEW_MAJOR=$MAJOR
    export NEW_MINOR=$MINOR
    export NEW_PATCH=`inc $PATCH`
  else
    export NEW_MAJOR=$MAJOR
    export NEW_MINOR=$MINOR
    export NEW_PATCH=$PATCH
  fi

  echo "$NEW_MAJOR.$NEW_MINOR.$NEW_PATCH"
}
