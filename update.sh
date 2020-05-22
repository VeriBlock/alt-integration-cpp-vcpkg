#!/usr/bin/env bash
#
# Script to get veriblock-pop-cpp version being used in the master branch of VeriBlock/vbk-ri-btc repo and update
# the port file accordingly.
#
CURRENT_SHA512=$(< portfile.cmake head -n 9 | tail -n 1 | cut -f10 -d " ")
DOWNLOAD_PATH=$(cut -d "=" -f2 <<< $(curl -s https://raw.githubusercontent.com/VeriBlock/vbk-ri-btc/master/depends/packages/veriblock-pop-cpp.mk | grep '$(package)_download_path'))
VERIBLOCK_POP_CPP_VERSION=$(cut -d "=" -f2 <<< $(curl -s https://raw.githubusercontent.com/VeriBlock/vbk-ri-btc/master/depends/packages/veriblock-pop-cpp.mk | grep '$(package)_version' | head -n 1))
GIT_SHORT_SHA=$(cut -d "=" -f2 <<< $(curl -s https://raw.githubusercontent.com/VeriBlock/vbk-ri-btc/master/depends/packages/veriblock-pop-cpp.mk | grep '$(package)_version' | head -n 1) | cut -c1-7)
PACKAGE_NAME=${VERIBLOCK_POP_CPP_VERSION}.tar.gz
wget -q "${DOWNLOAD_PATH}${PACKAGE_NAME}"
SHA512=$(cut -d " " -f1 <<< "$(sha512sum "${PACKAGE_NAME}")")
rm -f -- "${PACKAGE_NAME}"

if [ "${SHA512}" == "${CURRENT_SHA512}" ]
then
  echo "veriblock-pop-cpp is up to date.. exiting."
else
  echo "Updating port file with new version."
  sed -i -r "s/^        REF .*$/        REF ${VERIBLOCK_POP_CPP_VERSION}/" ./portfile.cmake
  sed -i -r "s/^        SHA512 .*$/        SHA512 ${SHA512}/" ./portfile.cmake
  sed -i -r "s/^Version: 0.0.1-.*$/Version: 0.0.1-${GIT_SHORT_SHA}/" ./CONTROL
fi
