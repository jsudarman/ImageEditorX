# Build script:  Modify MY_WORKSPACE to XCode directory 
# Output: ~/ANMobilePaymentLib containing headers, Debug and Release static library (*.a) and Nibs files.


export MY_WORKSPACE=.

#!/bin/sh
function failed()
{
    echo "Failed: $@" >&2
    exit 1
}

set -ex
export OUTPUT=ANMobilePaymentLib
export OUTPUTDIR=$MY_WORKSPACE/ANMobilePaymentLib
export COFFEEAPP=CoffeeShopApp
export COFFEEAPPDIR=$MY_WORKSPACE/$COFFEEAPP
export COFFEEAPPMOBILELIB=$MY_WORKSPACE/$COFFEEAPP/$OUTPUT
export OUTPUTNIBS=$OUTPUT/Nibs
rm -rf $OUTPUTDIR
rm -rf $COFFEEAPPMOBILELIB
mkdir -p $OUTPUT
mkdir -p $OUTPUTNIBS

. "$MY_WORKSPACE/build.config"

cd $MY_WORKSPACE;

for sdk in $SDKS; do
    for config in $CONFIGURATIONS; do
	if [ $sdk == "iphoneos5.0" ]; then
        	xcodebuild -configuration $config -sdk $sdk "ARCHS=armv6 armv7" clean;
        	xcodebuild -configuration $config -sdk $sdk "ARCHS=armv6 armv7" || failed build;
	else
		xcodebuild -configuration $config -sdk $sdk "ARCHS=i386 x86_64" "VALID_ARCHS=i386 x86_64"  clean;
                xcodebuild -configuration $config -sdk $sdk "ARCHS=i386 x86_64" "VALID_ARCHS=i386 x86_64" || failed build;
	fi
    done
done

lipo -output $OUTPUT/libANMobilePaymentRelease.a -create $MY_WORKSPACE/build/Release-iphoneos/libANMobilePaymentLib.a $MY_WORKSPACE/build/Release-iphonesimulator/libANMobilePaymentLib.a || failed lipo;
chmod +x $OUTPUT/libANMobilePaymentRelease.a

#lipo -output $OUTPUT/libANMobilePaymentDebug.a -create $MY_WORKSPACE/build/Debug-iphoneos/libANMobilePaymentLib.a $MY_WORKSPACE/build/Debug-iphonesimulator/libANMobilePaymentLib.a || failed lipo;
#chmod +x $OUTPUT/libANMobilePaymentDebug.a

for xib in $XIBS; do
	ibtool --compile $OUTPUTNIBS/$xib.nib $xib.xib || failed xibs;
done

for header in $HEADERS; do
	cp $header $OUTPUT/$header || failed headers;
done

for image in $IMAGES; do
	cp $image $OUTPUT/$image || failed images;
done

cp SDK\ License\ Agreement\ \(10.20.10\).pdf $OUTPUT

cp README $OUTPUT

# Zip of binary static library
zip -r -T -y "anet_ios_binary-1.1.1.zip" $OUTPUT -x '*/.*' '*/Icon' '*/__MACOSX' || failed "Zipping binary static library"

# Zip of SDK
zip -r -T -y "anet_ios_sdk-1.1.1.zip" * -x '*/.*' -x '*/Icon' -x '*/__MACOSX' $COFFEEAPP/\* build/\* anet_ios_binary.zip anet_ios_samples.zip $OUTPUT.xcodeproj/\*.mode1v3 -x $OUTPUT.xcodeproj/\*.pbxuser || failed "Zipping SDK"

echo "Finshed Build Script"
