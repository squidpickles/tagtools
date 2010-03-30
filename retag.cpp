#include <fileref.h>
#include <tag.h>
#include <iostream>

int main(int argc, char *argv[]) {

	for (int i = 1; i < argc; i++) {
		std::cout << argv[i] << ": ";
		TagLib::FileRef f(argv[i]);
		if(!f.isNull() && f.tag()) {
			f.save();
			std::cout << "ok" << std::endl;
		} else {
			std::cout << "no tag found" << std::endl;
		}
	}
	return 0;
}
