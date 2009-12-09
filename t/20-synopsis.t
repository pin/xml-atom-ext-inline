use Test::More tests => 2;

use XML::Atom;
use XML::Atom::Ext::Inline;

my $feed = XML::Atom::Feed->new(Version => '1.0');
my $parent_feed = XML::Atom::Feed->new(Version => '1.0');
$parent_feed->title('foo bar');

my $inline = XML::Atom::Ext::Inline->new();
$inline->atom($parent_feed);
    
my $link = XML::Atom::Link->new(Version => '1.0');
$link->rel('up');
$link->inline($inline);

$feed->add_link($link);

isa_ok $inline, 'XML::Atom::Ext::Inline';
is $feed->link->inline->atom->title, 'foo bar';