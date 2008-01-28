package TagLib;

use 5.008005;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = ( qw(read_tag) );

our @EXPORT = qw();

our $VERSION = '0.03';

require XSLoader;
XSLoader::load('TagLib', $VERSION);

# Preloaded methods go here.

1;
__END__

=head1 NAME

TagLib - Perl extension for reading audio metadata tags

=head1 SYNOPSIS

  use TagLib qw(read_tag);

  my $tag = read_tag('foo.mp3');

  my $artist = $tag->{'artist'};
  my $album = $tag->{'album'};
  my $title = $tag->{'title'};
  my $track = $tag->{'track'};

=head1 DESCRIPTION

You can use this to read the tags above in MP3, OGG, FLAC, and MPC files.
(Basically, it supports anything TagLib supports).  Writing and other
fanciness to come way, way later - maybe.


=head1 SEE ALSO

TagLib site, http://developer.kde.org/~wheeler/taglib.html

=head1 AUTHOR

Kevin Dorne, E<lt>sweetpea-perl@tentacle.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004, 2005, 2008 by Kevin Dorne

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.5 or,
at your option, any later version of Perl 5 you may have available.


=cut
