#include <fileref.h>
#include <tag.h>
#include <iostream>

int main(int argc, char *argv[]) {

	if (argc < 3) {
		std::cerr << "usage: " << argv[0] << " source destination" << std::endl;
		return 1;
	}
	TagLib::FileRef s(argv[1]);
	TagLib::FileRef d(argv[2]);
	if(!s.isNull() && s.tag()) {
		TagLib::Tag::duplicate(s.tag(), d.tag(), true);
		d.save();
		return 0;
	}
	std::cerr << "No tag found in " << argv[1] << std::endl;
	return 1;
}
