#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#ifdef __cplusplus
}
#endif

#include "ppport.h"

#include <tstring.h>
#include <fileref.h>
#include <tag.h>

#define TITLE "title"
#define TITLE_LEN strlen(TITLE)

#define ARTIST "artist"
#define ARTIST_LEN strlen(ARTIST)

#define ALBUM "album"
#define ALBUM_LEN strlen(ALBUM)

#define TRACK "track"
#define TRACK_LEN strlen(TRACK)


MODULE = TagLib		PACKAGE = TagLib		

PROTOTYPES: ENABLE

HV *
read_tag(file)
    const char *file
  CODE:
    RETVAL = newHV();
    sv_2mortal((SV*)RETVAL);

    TagLib::FileRef f(file);

    if (f.isNull() || !f.tag()) {
      return;
    }

    TagLib::Tag *tag = f.tag();

    hv_store(RETVAL, TITLE, TITLE_LEN, newSVpv(tag->title().toCString(true), 0), 0);
    hv_store(RETVAL, ARTIST, ARTIST_LEN, newSVpv(tag->artist().toCString(true), 0), 0);
    hv_store(RETVAL, ALBUM, ALBUM_LEN, newSVpv(tag->album().toCString(true), 0), 0);
    hv_store(RETVAL, TRACK, TRACK_LEN, newSViv(tag->track()), 0);

  OUTPUT:
    RETVAL
