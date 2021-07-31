#!/bin/sh

#  km.sh
#  
#
#  Created by StarPlayrX on 1/21/21.
#
# $1 = Volume Root
echo "Starting Kernel Collection Utility 2.0..."

#mount volume as read write
mount -uw "$1"

#Update all caches
echo 'Updating All Kernel Collections...'
/usr/bin/kmutil install --update-all --check-rebuild --repository /System/Library/Extensions --repository /Library/Extensions --repository /System/Library/DriverExtensions --repository /Library/DriverExtensions --repository /Library/Apple/System/Library/Extensions --volume-root "$1"/
 
#create prelinked kernel
echo 'Updating Prelinked Kernel...'
/usr/bin/kmutil create -n boot --boot-path /System/Library/PrelinkedKernels/prelinkedkernel -f 'OSBundleRequired'=='Local-Root' --kernel /System/Library/Kernels/kernel --repository /System/Library/Extensions --repository /Library/Extensions --repository /System/Library/DriverExtensions --repository /Library/DriverExtensions --repository /Library/Apple/System/Library/Extensions --volume-root "$1"/

#copy prelinked Kernel
echo 'Copying Prelinked Kernel...'
/usr/bin/ditto -v "$1"/System/Library/PrelinkedKernels/prelinkedkernel "$1"/Library/Apple/System/Library/PrelinkedKernels/prelinkedkernel

echo 'Copying Collections to Preboot Volume...'
"$1"/usr/sbin/kcditto

echo "Ending Kernel Collection Utility 2.0..."
