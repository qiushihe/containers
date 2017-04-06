#!/bin/bash

# Docker bash orchestration script
# https://gist.github.com/qiushihe/9a75384f35218deb78caa65e01924847

###################################################################################################

function printHelp {
  echo "Usage: docker-do.sh [COMMAND] [COMMAND OPTIONS...]"
  echo ""
  echo "COMMAND: rebuild - Rebuild container and its image"
  echo "  $ docker-do.sh rebuild [CONTAINER] [IMAGE] [BUILD-DIR] [CONTAINER-OPTS...] -- [CONTAINER-REST...]"
  echo ""
  echo "COMMAND: clean - Delete container and its image"
  echo "  $ docker-do.sh clean [CONTAINER] [IMAGE]"
  echo ""
  echo "COMMAND: publish - Build and publish an image"
  echo "  $ docker-do.sh publish [IMAGE] [BUILD-DIR] [TAG]"
}

###################################################################################################

ARGV=( "$@" )

function ARGV_pop {
  unset ARGV[0]
  ARGV=( "${ARGV[@]}" )
}

function ARGV_shiftInto {
  local dest=$1
  local src="'${ARGV[0]}'"

  ARGV_pop

  eval $dest="'$src'"
}

function ARGV_shiftIntoUntil {
  local dest=$1; shift
  local stopBefore=$1

  result=()
  while :; do
    local current="${ARGV[0]}"

    if [ -z "$current" ]; then
      break
    elif [ "$current" == "$stopBefore" ]; then
      break
    fi

    result+=( "$current" )
    ARGV_pop
  done

  eval $dest="'${result[@]}'"
}

###################################################################################################

ARGV_shiftInto cmd

if [ "$cmd" == "rebuild" ]; then
  ARGV_shiftInto container
  ARGV_shiftInto image
  ARGV_shiftInto buildDir

  ARGV_shiftIntoUntil options --
  ARGV_pop # remove the "--"
  rest="${ARGV[@]}"

  echo "Rebuild:"
  echo "  * container: $container"
  echo "  * image: $image"
  echo "  * build dir: $buildDir"
  echo "  * container options: $options"
  echo "  * container rest: $rest"

  docker build -t $image $buildDir
  docker stop $container
  docker rm $container
  docker create --name $container $options $image $rest
elif [ "$cmd" == "clean" ]; then
  ARGV_shiftInto container
  ARGV_shiftInto image

  echo "Clean:"
  echo "  * container: $container"
  echo "  * image: $image"

  docker stop $container
  docker rm $container
  docker rmi $image
elif [ "$cmd" == "publish" ]; then
  ARGV_shiftInto image
  ARGV_shiftInto buildDir
  ARGV_shiftInto tag

  echo "Publish:"
  echo "  * image: $image"
  echo "  * build dir: $buildDir"

  docker build -t $image $buildDir
  docker tag $(docker images | grep -e "^$image[[:space:]]\+latest[[:space:]]\+" | awk '{print $3}') $image:$tag
  docker push $image
else
  printHelp
fi
