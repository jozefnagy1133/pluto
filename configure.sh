#!/bin/sh

if [ "x$ROS_ARCH" = "x" ]; then
  echo Could not detect RosBE.
  exit 1
fi

BUILD_ENVIRONMENT=MinGW
ARCH=$ROS_ARCH
PLUTO_SOURCE_DIR=$(cd `dirname $0` && pwd)
PLUTO_OUTPUT_PATH=output-$BUILD_ENVIRONMENT-$ARCH
USE_NEW_STYLE=1

usage() {
  echo Invalid parameter given.
  exit 1
}

CMAKE_GENERATOR="Ninja"
while [ $# -gt 0 ]; do
  case $1 in
    -D)
      shift
      if echo "x$1" | grep 'x?*=*' > /dev/null; then
        ROS_CMAKEOPTS=$ROS_CMAKEOPTS" -D $1"
      else
        usage
      fi
    ;;

    -D?*=*|-D?*)
      ROS_CMAKEOPTS=$ROS_CMAKEOPTS" $1"
    ;;
    makefiles|Makefiles)
      CMAKE_GENERATOR="Unix Makefiles"
    ;;
    with-host-tools)
      USE_NEW_STYLE=0
    ;;
    *)
      usage
  esac

  shift
done

if [ "$PLUTO_SOURCE_DIR" = "$PWD" ]; then
  echo Creating directories in $PLUTO_OUTPUT_PATH
  mkdir -p "$PLUTO_OUTPUT_PATH"
  cd "$PLUTO_OUTPUT_PATH"
fi

mkdir -p pluto

#EXTRA_ARGS=""
if [ $USE_NEW_STYLE -eq 0]; then
  mkdir -p host-tools
  echo Prepairing host tools...
  cd host-tools
  rm -f CMakeCache.txt

  PLUTO_BUILD_TOOLS_DIR="$PWD"
  cmake -g "$CMAKE_GENERATOR" -DARCH:STRING=$ARCH $ROS_CMAKEOPTS -DNEW_STYLE_BUILD:BOOL=0 "$PLUTO_SOURCE_DIR"

  EXTRA_ARGS="$EXTRA_ARGS -DPLUTO_BUILD_TOOLS_DIR:PATH=$PLUTO_BUILD_TOOLS_DIR"

  cd ..
fi

echo Prepairing pluto...
cd pluto
rm -f CMakeCache.txt host-tools/CMakeCache.txt

cmake -G "$CMAKE_GENERATOR" -DENABLE_CCACHE:BOOL=0 -DCMAKE_TOOLCHAIN_FILE:FILEPATH=toolchain-gcc.cmake -DARCH:STRING=$ARCH -DNEW_STYLE_BUILD:BOOL=$USE_NEW_STYLE $EXTRA_ARGS $ROS_CMAKEOPTS "$PLUTO_SOURCE_DIR"

echo Configure script complete! Enter directories and execute appropriate build commands \(ex: ninja, make, makex, etc...\).
