#include <fileref.h>
#include <tag.h>

int main(int argc, char *argv[]) {

  if (argc < 3) {
    fprintf(stderr, "usage: %s source destination\n", argv[0]);
    exit(1);
  }

  TagLib::FileRef s(argv[1]);
  TagLib::FileRef d(argv[2]);

  if(!s.isNull() && s.tag()) {
    TagLib::Tag::duplicate(s.tag(), d.tag(), true);
    d.save();
    return 0;
  }
  fprintf(stderr, "No tag found in %s\n", argv[1]);
  return 1;
}
