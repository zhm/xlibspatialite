CONFIGURATION=$1
ARCH=$2
SDK=$3
OUTPUT="./build/$CONFIGURATION-$ARCH-$SDK"
SCHEME="libspatialite"

mkdir -p $OUTPUT

xcodebuild -configuration $CONFIGURATION -arch $ARCH -scheme $SCHEME -sdk $SDK CONFIGURATION_BUILD_DIR=$OUTPUT
