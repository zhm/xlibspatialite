
ACTION="clean build"

DEVICE=iphoneos8.1
SIMULATOR=iphonesimulator8.1

# DEVICE_BUILD_DIR_RELEASE='./build/Release-device'
# DEVICE_BUILD_DIR_DEBUG='./build/Debug-device'

# DEVICE64_BUILD_DIR_RELEASE='./build/Release-device'
# DEVICE64_BUILD_DIR_DEBUG='./build/Debug-device'

# SIMULATOR_BUILD_DIR_RELEASE='./build/Release-simulator'
# SIMULATOR_BUILD_DIR_DEBUG='./build/Debug-simulator'

# SIMULATOR_BUILD_DIR_RELEASE='./build/Release-simulator'
# SIMULATOR_BUILD_DIR_DEBUG='./build/Debug-simulator'

UNIVERSAL_BUILD_DIR_RELEASE='./build/Release-universal'
UNIVERSAL_BUILD_DIR_DEBUG='./build/Debug-universal'

rm -rf $UNIVERSAL_BUILD_DIR_RELEASE
rm -rf $UNIVERSAL_BUILD_DIR_DEBUG

# mkdir -p $DEVICE_BUILD_DIR_RELEASE
# mkdir -p $DEVICE_BUILD_DIR_DEBUG
# mkdir -p $SIMULATOR_BUILD_DIR_RELEASE
# mkdir -p $SIMULATOR_BUILD_DIR_DEBUG
# mkdir -p $UNIVERSAL_BUILD_DIR_RELEASE
# mkdir -p $UNIVERSAL_BUILD_DIR_DEBUG

./build-arch.sh Debug armv7  $DEVICE
./build-arch.sh Debug armv7s $DEVICE
./build-arch.sh Debug arm64  $DEVICE
./build-arch.sh Debug i386   $SIMULATOR
./build-arch.sh Debug x86_64 $SIMULATOR

./build-arch.sh Release armv7  $DEVICE
./build-arch.sh Release armv7s $DEVICE
./build-arch.sh Release arm64  $DEVICE
./build-arch.sh Release i386   $SIMULATOR
./build-arch.sh Release x86_64 $SIMULATOR

./combine.rb Debug
./combine.rb Release

# xcodebuild -configuration Release -scheme libspatialite -sdk $DEVICE CONFIGURATION_BUILD_DIR=$DEVICE_BUILD_DIR_RELEASE
# xcodebuild -configuration Debug -scheme libspatialite -sdk $DEVICE CONFIGURATION_BUILD_DIR=$DEVICE_BUILD_DIR_DEBUG

# xcodebuild -configuration Release -scheme libspatialite -sdk $SIMULATOR CONFIGURATION_BUILD_DIR=$SIMULATOR_BUILD_DIR_RELEASE
# xcodebuild -configuration Debug -scheme libspatialite -sdk $SIMULATOR CONFIGURATION_BUILD_DIR=$SIMULATOR_BUILD_DIR_DEBUG

# lipo -create -output "${UNIVERSAL_BUILD_DIR_DEBUG}/libgeos.a" "${DEVICE_BUILD_DIR_DEBUG}/libgeos.a" "${SIMULATOR_BUILD_DIR_DEBUG}/libgeos.a"
# lipo -create -output "${UNIVERSAL_BUILD_DIR_DEBUG}/liblwgeom.a" "${DEVICE_BUILD_DIR_DEBUG}/liblwgeom.a" "${SIMULATOR_BUILD_DIR_DEBUG}/liblwgeom.a"
# lipo -create -output "${UNIVERSAL_BUILD_DIR_DEBUG}/libproj.a" "${DEVICE_BUILD_DIR_DEBUG}/libproj.a" "${SIMULATOR_BUILD_DIR_DEBUG}/libproj.a"
# lipo -create -output "${UNIVERSAL_BUILD_DIR_DEBUG}/libspatialite.a" "${DEVICE_BUILD_DIR_DEBUG}/libspatialite.a" "${SIMULATOR_BUILD_DIR_DEBUG}/libspatialite.a"


# lipo -create -output "${UNIVERSAL_BUILD_DIR_RELEASE}/libgeos.a" "${DEVICE_BUILD_DIR_RELEASE}/libgeos.a" "${SIMULATOR_BUILD_DIR_RELEASE}/libgeos.a"
# lipo -create -output "${UNIVERSAL_BUILD_DIR_RELEASE}/liblwgeom.a" "${DEVICE_BUILD_DIR_RELEASE}/liblwgeom.a" "${SIMULATOR_BUILD_DIR_RELEASE}/liblwgeom.a"
# lipo -create -output "${UNIVERSAL_BUILD_DIR_RELEASE}/libproj.a" "${DEVICE_BUILD_DIR_RELEASE}/libproj.a" "${SIMULATOR_BUILD_DIR_RELEASE}/libproj.a"
# lipo -create -output "${UNIVERSAL_BUILD_DIR_RELEASE}/libspatialite.a" "${DEVICE_BUILD_DIR_RELEASE}/libspatialite.a" "${SIMULATOR_BUILD_DIR_RELEASE}/libspatialite.a"

rm -rf ./public

mkdir -p ./public

cp ./sqlite3/redefines.h ./public/redefines.h
cp ./sqlite3/sqlite3.h ./public/spatialite_sqlite3.h
cp ./sqlite3/sqlite3ext.h ./public/spatialite_sqlite3ext.h
cp ./spatialite/headers/spatialite.h ./public/spatialite.h

mkdir -p ./public/spatialite
cp -R ./spatialite/headers/spatialite/* ./public/spatialite

mkdir ./public/lib

cp "${UNIVERSAL_BUILD_DIR_RELEASE}/libgeos.a" ./public/lib
cp "${UNIVERSAL_BUILD_DIR_RELEASE}/liblwgeom.a" ./public/lib
cp "${UNIVERSAL_BUILD_DIR_RELEASE}/libproj.a" ./public/lib
cp "${UNIVERSAL_BUILD_DIR_RELEASE}/libspatialite.a" ./public/lib
