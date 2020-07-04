#!/bin/sh

#  installer.sh
#  Created by StarPlayrX on 7/1/20.

cat './🎨/ascii-art.ans'

mount -uw /

## run this from Catalina

echo "\r\ncurrent boot args"
nvram -p | grep boot-args
nvram boot-args="-no_compat_check amfi_get_out_of_my_way=1 keepsyms=1 -v rootless=1"

echo "\r\nset boot args"
nvram -p | grep boot-args

echo "\r\nCheck System Integrity"
csrutil status

#csrutil authenticated-root status

## may be able to set csr programically
#nvram csr-active-config="w%08%00%00"

#./'Install macOS Beta.app/Contents/MacOS/InstallAssistant' & echo '\r\n' &

echo "\r\nDisabling Library Validation"
defaults write /Library/Preferences/com.apple.security.libraryvalidation.plist DisableLibraryValidation -bool true

echo "\r\nLoading Hax into Memory"
hax="/🍟/Hax.dylib"
launchctl setenv DYLD_INSERT_LIBRARIES $(pwd)$hax

echo $(pwd)$hax
echo ""
