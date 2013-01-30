#!/usr/bin/env perl

#
# $Id: tagrename 228 2004-11-26 01:03:58Z sweetpea $
#

use strict;
use warnings;
use TagLib;
use File::Basename;
use File::Path qw(make_path);
use File::Copy;

################
# Stuff you may want to change
#
# maximum length of any path element
my $MAX_LENGTH = 68;
#
# base directory for moving files
my $BASEDIR = '/music';
#
# character(s) to append if name is truncated
my $TRUNCATED = '…';
#################

my $TRACKSIZE = 3;

# begin

# Yay! xargs is our friend...
my $last_dir = '';
my $last_artist = '';
my $last_album = '';

while (my $file = shift) {
if (! -f $file) {
		warn "file '$file' does not exist\n";
		next;
	}

	my $extension = &get_extension($file);

	if (length($extension) == 0) {
		warn "Unknown filetype: $file\n";
		next;
	}

	my $dir = dirname($file);
	my $newname = '';

	if ($extension=~m#(cue|log)$#i) {
		if (length($last_dir) and length($last_artist) and length($last_album) and ($dir eq $last_dir)) {
			$extension = lc($extension);
			$newname = "$BASEDIR/$last_artist/$last_album/album$extension";
		} else {
			warn "Unknown artist/album for '$file'; skipping\n";
			next;
		}
	} else {
		my $max_text = $MAX_LENGTH - $TRACKSIZE - length($extension);

		# Hooray TagLib
		my $tag = TagLib::read_tag($file) or die "Error getting tag for '$file'";

		my $artist = $tag->{'artist'};
		my $album = $tag->{'album'};
		my $title = $tag->{'title'};
		my $tracknum = $tag->{'track'};

		# Track numbers are lovely for non-id3 music players, if they're present
		if ($tracknum > 0) {
			$tracknum = sprintf('%02u ', $tracknum);
		} else {
			$tracknum = '';
		}

		$artist = &clean($artist, $max_text);
		$album = &clean($album, $max_text);
		$title = &clean($title, $max_text);

		$last_dir = $dir;
		$last_artist = $artist;
		$last_album = $album;

		# and not enough info in the error message to diagnose it well.  Too bad, pal.
		if (!length($artist) || !length($album) || !length($title)) {
			warn("Not enough tag info in '$file' to rename\n");
			next;
		}

		# Glorious new name.  joy.  rapture.
		$newname = "$BASEDIR/$artist/$album/$tracknum$title$extension";
	}

	if (!length($newname)) {
		warn("Couldn't figure out a new name\n");
		next;
	}

	# We're cautious here; no overwriting.  Maybe this can be a command-line
	# switch
	if (-f $newname) {
		warn("'$newname' already exists\n");
		next;
	}

	# Oooh.  We even create directories.  Fancy!
	my $new_dir = dirname($newname);
	if (! -d $new_dir) {
		print("Making directory '$new_dir'\n");
		make_path($new_dir, {error => \my $err});
		if (@$err) {
			warn("Error making directory '$new_dir'\n");
			next;
		}
	}
	# and here we go.  Chatty, ain't we?
	print("Renaming $file -> $newname\n");
	move($file, $newname);
}

#####

sub clean() {
	my ($name, $max_text) = @_;

	# Removes disallowed filename characters
	$name=~s#["\\\*\?<>|,;]##g;
	# And substitutes others with dashes
	$name=~s#[/:]#-#g;
	# And changes ugly underscores to spaces -- we *are* using modern OSs, right?
	$name=~s#_# #g;

	# Are we over our size limit?
	if (length($name) > $max_text) {
		# Ah, well, let's start by removing any symbols at the end of the name
		$name=~s#\s*\W*$##;
		# Still over limit?  We'll remove words one at a time until we're ok
		while (length($name) > $max_text-length($TRUNCATED)) {
			$name=~s#\W+\w+$##;
		}
		# And we'll want to add the truncated indicator, if there is one.
		$name .= $TRUNCATED;
	}
	# Now we want to remove dots (who wants filename..mp3?)
	$name=~s#\.$##;
	# And if that exposes whitespace, we'll get rid of that, too
	$name=~s#\s+$##;
	# look how beautiful the name is now
	return $name;
}

sub get_extension() {
	# I hate this.  TagLib's doing the same thing too, more or less.  It's really
	# ugly.  Alas, file(1) doesn't detect these reliably...
	my $file = shift;

	if ($file=~m#\.(mp3|ogg|flac|mpc|cue|log)$#i) {
		return ".$1";
	} else {
		return '';
	}
}