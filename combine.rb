#!/usr/bin/env ruby
#
configuration = ARGV[0]

libs = [
  'libgeos',
  'liblwgeom',
  'libproj',
  'libspatialite'
]

archs = [
  "./build/#{configuration}-armv7-iphoneos8.1",
  "./build/#{configuration}-armv7s-iphoneos8.1",
  "./build/#{configuration}-arm64-iphoneos8.1",
  "./build/#{configuration}-i386-iphonesimulator8.1",
  "./build/#{configuration}-x86_64-iphonesimulator8.1",
]

libs.each do |lib|
  lib_paths = archs.map do |arch|
    "\"#{arch}/#{lib}.a\""
  end

  cmd = "lipo -create -output \"./build/#{configuration}-universal/#{lib}.a\" #{lib_paths.join(' ')}"

  puts cmd

  `mkdir -p ./build/#{configuration}-universal`

  system(cmd)
end
