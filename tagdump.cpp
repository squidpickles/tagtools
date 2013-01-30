#include <tpropertymap.h>
#include <fileref.h>
#include <tag.h>
#include <iostream>

int main(int argc, char *argv[])
{
	for(int i = 1; i < argc; i++) {

		TagLib::FileRef f(argv[i]);
		if(!f.isNull() && f.tag()) {
			TagLib::Tag *tag = f.tag();
			const TagLib::PropertyMap properties = tag->properties();
			for (TagLib::PropertyMap::ConstIterator property = properties.begin(); property != properties.end(); ++property) {
				std::cout << property->first << ": " << property->second << std::endl;
			}
		}
	}
	return 0;
}
