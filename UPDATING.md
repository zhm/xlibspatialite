# Updating SpatiaLite

* Delete old src/ directory
* Copy entire directory into project
* Remove src/ from project within Xcode
* Add entire contents back into src/ in Xcode
* Remove src/gaiageo/lemon and src/gaiageo/flex from Xcode
* Remove the src/gaiageo/lex.*.c files from the Xcode project
* Remove geoJSON, Ewkt, Gml, Kml, vanatuWkt .c/.h files from src/gaiageo
* Remove all .h files
* Remove all Makefile.am and Makefile.in files from Xcode
