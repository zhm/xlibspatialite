# Updating SQLite

* Download amalgamation
* Replace all of the files, leaving redefines.h
* Add #include "redefines.h" at the top of sqlite.h and sqlite.c

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
* There seems to be issues with iconv on iOS and how SpatiaLite uses it.
  If you get errors in gg_utf8.c, just return NULL from gaiaGetLocaleCharset()
  Nothing in SpatiaLite uses this function, it's there for consumers
  of the SpatiaLite API.

```
gaiaGetLocaleCharset ()
{
/* identifies the locale charset */
#if defined(__MINGW32__) || defined(_WIN32)
    return locale_charset ();
#else /* not MINGW32 - WIN32 */
#if defined(__APPLE__) || defined(__ANDROID__)
    return NULL; //locale_charset ();
#else /* neither Mac OsX nor Android */
    return nl_langinfo (CODESET);
#endif
#endif
}
```

# Updating lwgeom

* Delete contents of lwgeom directory
* Copy entire new contents into directory
* Remove all files from lwgeom in Xcode project
* Add all new files back into Xcode project
* Rename liblwgeom.h.in to liblwgeom.h
* Copy postgis_config.h back into directory
* Find and replace

    #include "../postgis_config.h"

with

    #include "postgis_config.h"

* we don't need libjson support, so make sure HAVE_LIBJSON is 0 in postgis_config.h
* Remove the cunit directory from Xcode
* Remove lwin_wkt_parse.y from the Xcode project
* Remove lwin_wkt_lex.l from the Xcode project
* Remove lwgeom_sfcgal.c from the Xcode project (We aren't compiling in support for this library)

* To get a newer version of liblwgeom.h, run ./configure from the postgis source directory and copy it into this project
* You can also copy postgis_config.h from the newer source directory into the project

# Updating GEOS

* Download latest source
* ./configure
* Replace the entire contents of src, include, and capi with the new versions
* Make sure to remove include from the Xcode project
* You might have to hack GEOSversion because we don't have the SVN revision
* Comment out HAVE_ISNAN in platform.h if you get errors about ISNAN macro
