#include <tstring.h>
#include <fileref.h>
#include <tag.h>

int main(int argc, char *argv[])
{
  for(int i = 1; i < argc; i++) {

    TagLib::FileRef f(argv[i]);

    if(!f.isNull() && f.tag()) {

      TagLib::Tag *tag = f.tag();

      printf("Title: %s\n", tag->title().toCString(true));
      printf("Artist: %s\n", tag->artist().toCString(true));
      printf("Album: %s\n", tag->album().toCString(true));
      printf("Track: %d\n", tag->track());
      printf("Year: %d\n", tag->year());
      printf("Genre: %s\n", tag->genre().toCString(true));
      printf("Comment: %s\n", tag->comment().toCString(true));
    }

  }
  return 0;
}
