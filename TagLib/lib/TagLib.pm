package TagLib;

use 5.008005;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use TagLib ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.02';

require XSLoader;
XSLoader::load('TagLib', $VERSION);

# Preloaded methods go here.

1;
__END__

=head1 NAME

TagLib - Perl extension for reading audio metadata tags

=head1 SYNOPSIS

  use TagLib;

  my $filename = 'test.mp3';
  my $tag = %{&TagLib::read_tag($filename)};

  my $artist = $tag{'artist'};
  my $album = $tag{'album'};
  my $title = $tag{'title'};
  my $track = $tag{'track'};

=head1 DESCRIPTION

You can use this to read the tags above in MP3, OGG, FLAC, and MPC files.
(Basically, it supports anything TagLib supports).  Writing and other
fanciness to come way, way later - maybe.

=head2 EXPORT

None by default.


=head1 SEE ALSO

TagLib site, http://developer.kde.org/~wheeler/taglib.html

=head1 AUTHOR

Kevin Dorne, E<lt>kevin@catalyst.net.nzE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004,2005 by Kevin Dorne

Licensing terms to come later.  For now:

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.5 or,
at your option, any later version of Perl 5 you may have available.


=cut
