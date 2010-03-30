#include <tstring.h>
#include <fileref.h>
#include <tag.h>
#include <iostream>

int main(int argc, char *argv[])
{
	for(int i = 1; i < argc; i++) {

		TagLib::FileRef f(argv[i]);
		if(!f.isNull() && f.tag()) {
			TagLib::Tag *tag = f.tag();
			std::cout << "Title: " << tag->title().toCString(true) << std::endl;
			std::cout << "Artist: " << tag->artist().toCString(true) << std::endl;
			std::cout << "Album: " << tag->album().toCString(true) << std::endl;
			std::cout << "Track: " << tag->track() << std::endl;
			std::cout << "Year: " << tag->year() << std::endl;
			std::cout << "Genre: " << tag->genre().toCString(true) << std::endl;
			std::cout << "Comment: " << tag->comment().toCString(true) << std::endl;
		}
	}
	return 0;
}
