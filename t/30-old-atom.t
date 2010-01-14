use Test::More tests => 6;

use XML::Atom;
use XML::Atom::Ext::Inline;

my $feed = XML::Atom::Feed->new();

my $parent_feed = XML::Atom::Feed->new();
$parent_feed->title('foo bar');

my $inline = XML::Atom::Ext::Inline->new();
$inline->atom($parent_feed);
    
my $link = XML::Atom::Link->new();
$link->rel('up');
$link->inline($inline);

$feed->add_link($link);

isa_ok $inline, 'XML::Atom::Ext::Inline';
is $feed->link->inline->atom->title, 'foo bar';

my $child_feed = XML::Atom::Feed->new();
$child_feed->title('lala');

my $inline_down = XML::Atom::Ext::Inline->new();
$inline_down->atom($child_feed);
    
my $link_down = XML::Atom::Link->new();
$link_down->rel('down');
$link_down->inline($inline_down);

$feed->add_link($link_down);

my @links = $feed->link;
is scalar @links, 2;
is $links[1]->inline->atom->title, 'lala';

my $sub_child_feed = XML::Atom::Feed->new(Version => '1.0');
$sub_child_feed->title('oh dear');

my $inline_down_down = XML::Atom::Ext::Inline->new();
$inline_down_down->atom($sub_child_feed);

my $link_down_down = XML::Atom::Link->new();
$link_down_down->rel('down');
$link_down_down->inline($inline_down_down);

$links[1]->inline->atom->add_link($link_down_down);

@links = $feed->link;
is scalar @links, 2;
is $links[1]->inline->atom->link->inline->atom->title, 'oh dear';

#print $feed->as_xml();