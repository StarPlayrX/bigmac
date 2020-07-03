#!/bin/sh

#  installer.sh
#  Created by StarPlayrX on 7/1/20.

#mount -uw /

## run this from Catalina

nvram -p | grep boot-args
nvram boot-args="-no_compat_check amfi_get_out_of_my_way=1 keepsyms=1 -v rootless=0"
nvram -p | grep boot-args

csrutil status

#csrutil authenticated-root status

## may be able to set csr programically
#nvram csr-active-config="w%08%00%00"

#./'Install macOS Beta.app/Contents/MacOS/InstallAssistant' & echo '\r\n' &

defaults write /Library/Preferences/com.apple.security.libraryvalidation.plist DisableLibraryValidation -bool true

launchctl setenv DYLD_INSERT_LIBRARIES $PWD/🍟/Hax.dylib

