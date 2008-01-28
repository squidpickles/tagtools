# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl TagLib.t'

#########################

use Test::More tests => 6;
BEGIN { use_ok('TagLib') };

my $TAG_FILE = 't/foo.mp3';

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.
my $tag = TagLib::read_tag($TAG_FILE);

isa_ok($tag, 'HASH');
is($tag->{'artist'}, 'Värttinä', 'Artist');
is($tag->{'album'}, 'Vihma', 'Album');
is($tag->{'title'}, 'Vihmax (Vihma Remix)');
is($tag->{'track'}, 13);
