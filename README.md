tagtools
========

tagtools is a set of utilities for manipulating metadata in audio files.  Any
tag format (ID3, FLAC, Vorbis, etc.) supported by TagLib will work with these
utilities.

Contents
--------
 * __cptag__     - copies a tag from one file to another
 * __retag__     - reads in a tag and writes it back to the file, possibly
                   correcting some errors and standardizing padding
 * __tagdump__   - prints out some basic metadata about the file
 * __tagrename__ - renames files based on their tags. Requires tagpy.
 * __TagLib__    - A Perl extension for talking to TagLib. Probably obsolete.
