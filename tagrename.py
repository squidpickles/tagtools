#!/usr/bin/env python

#
# $Id$
#

import taglib
import os
import sys
import shutil
import re
import textwrap
import codecs

################
# Stuff you may want to change
#
# maximum length of any path element
kMaxLength = 68
#
# base directory for moving files
kBaseDir = u'/music'
#
# character(s) to append if name is truncated
kTruncated = u'\u2026'
#
# Various Artists name
kVariousArtists = u'Various Artists'
#################

# Size required to represent track number, plus separating space
kTrackSize = 3

# extensions handled by the renamer
kSupportedExtensions = (u'.mp3', u'.ogg', u'.flac', u'.mpc', u'.cue', u'.log')

# characters to strip from names
kCharsToStrip = re.compile(r'["\\\*\?<>|,;]')

# characters to replace with dashes
kCharsToDash = re.compile(r'[/:]')

# characters to replace with spaces
kCharsToSpace = re.compile(r'[_]')

# setup for trimming names to size limits
gTextWrapper = textwrap.TextWrapper(width=kMaxLength - kTrackSize - len(kTruncated), break_on_hyphens=False)

# stdout/stderr has no encoding; we need to set it up
sys.stdout = codecs.getwriter('utf-8')(sys.stdout)
sys.stderr = codecs.getwriter('utf-8')(sys.stderr)

def clean(name, max_text):
	truncated = False
	# Removes disallowed filename characters
	name = kCharsToStrip.sub(u'', name)
	# And substitutes others with dashes
	name = kCharsToDash.sub(u'-', name)
	# And changes ugly underscores to spaces -- we *are* using modern OSs, right?
	name = kCharsToSpace.sub(u' ', name)
	# And wraps text
	wrapped = gTextWrapper.wrap(name)[0]
	if name != wrapped:
		truncated = True
	name = wrapped
	# And removes ending dots
	name = name.rstrip(u'.')
	# And, finally, adds a truncated marker if it was truncated
	return name + kTruncated if truncated else name

last_dir = None
last_artist = None
last_album = None

# Yay! xargs is our friend...
for filename in sys.argv[1:]:
	filename = os.path.abspath(filename).decode('utf-8')
	if not os.path.isfile(filename):
		sys.stderr.write(u"file '{}' does not exist\n".format(filename))
		continue

	root, extension = os.path.splitext(filename.lower())
	if extension not in kSupportedExtensions:
		sys.stderr.write(u"Unknown filetype: {}\n".format(filename))
		continue

	dirname = os.path.dirname(filename)
	if extension in (u'.cue', u'.log'):
		if last_dir and last_artist and last_album and dirname == last_dir:
			new_name = os.path.join(kBaseDir, last_artist, last_album, u"album" + extension)
		else:
			sys.stderr.write(u"Unknown artist/album for '{}'; skipping\n".format(filename))
			continue
	else:
		max_text = kMaxLength - kTrackSize - len(extension)

		try:
			tag = taglib.tagopen(filename)
		except taglib.InvalidMedia as err:
			sys.stderr.write(u"Could not read tag for '{}': {}\n".format(filename, err))
			continue

		track_num = u''
		if 'track' in tag and tag.track:
			track_num = u'{:02d} '.format(tag.track[0])

		album_artist = tag.artist
		if 'album_artist' in tag and tag.album_artist and tag.album_artist != tag.artist:
			album_artist = tag.album_artist
		elif 'compilation' in tag and tag.compilation:
			album_artist = kVariousArtists

		if not album_artist or not tag.album or not tag.name:
			sys.stderr.write(u"Not enough tag info in '{}' to rename\n".format(filename))
			continue

		album = tag.album
		if 'disk' in tag and tag.disk and tag.disk[0] > 1:
			album += u' (disc {})'.format(tag.disk[0])

		artist = clean(album_artist, kMaxLength)
		album = clean(album, kMaxLength)
		title = clean(tag.name, max_text)

		last_dir = dirname
		last_artist = artist
		last_album = album

		if not artist or not album or not title:
			sys.stderr.write(u"Not enough tag info in '{}' to rename after cleaning\n".format(filename))
			continue

		new_name = os.path.join(kBaseDir, artist, album, u"".join((track_num, title, extension)))

	# no overwriting.  Maybe this can be a command-line switch?
	if os.path.exists(new_name):
		sys.stderr.write(u"'{}' already exists\n".format(new_name))
		continue

	new_dir = os.path.dirname(new_name)
	if not os.path.isdir(new_dir):
		sys.stdout.write(u"Making directory '{}'\n".format(new_dir));
		try:
			os.makedirs(new_dir)
			pass
		except os.error as err:
			sys.stderr.write(u"Error making directory '{}': {!s}".format(new_dir, err))
			continue

	sys.stdout.write(u"Renaming {} -> {}\n".format(filename, new_name));
	shutil.move(filename, new_name)

