#!/bin/sh

#  bm2.sh
#  bigmac2
#
#  Created by starplayrx on 12/31/20.
#
# BigMac Helper App by Todd Bruss (c) 2021
#
echo $2 | sudo -S "$1" > /dev/null 2>&1 &
