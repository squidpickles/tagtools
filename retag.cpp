#include <fileref.h>
#include <tag.h>

int main(int argc, char *argv[]) {

  for (int i = 1; i < argc; i++) {
    printf("%s: ", argv[i]);

    TagLib::FileRef f(argv[i]);

    if(!f.isNull() && f.tag()) {
      f.save();
      printf("ok\n");
    } else {
      printf("no tag found\n");
    }
  }
  return 0;
}
