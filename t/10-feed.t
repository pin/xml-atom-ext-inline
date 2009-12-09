use Test::More tests => 5;

use XML::Atom::Feed;
use XML::Atom::Ext::Inline;

use URI;
use Data::Dumper;

my $feed = XML::Atom::Feed->new('t/samples/feed.xml');
isa_ok $feed, 'XML::Atom::Feed';
is $feed->title, 'test';

my $first_link = $feed->link;
#print Dumper(@+links);
#is scalar @$links, 2;
isa_ok $first_link, 'XML::Atom::Link';

my $inline = $first_link->inline;
isa_ok $inline, 'XML::Atom::Ext::Inline';

my $parent_feed = $inline->atom;
#print $inline->as_xml();
isa_ok $parent_feed, 'XML::Atom::Feed';

#$inline->atom($feed);
#is $parent_feed->title, 'фото';
#print $feed->as_xml();
