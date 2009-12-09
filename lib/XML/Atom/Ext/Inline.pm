package XML::Atom::Ext::Inline;

use warnings;
use strict;

use base qw(XML::Atom::Base);

use XML::Atom::Link;
use XML::Atom::Feed;
use XML::Atom::Entry;
use XML::Atom::Util qw(childlist);

use Carp;

sub atom {
	my $obj = shift;
	if (@_) {
		if ($_[0]->isa('XML::Atom::Feed')) {
			my ($feed) = @_;
			my $ns_uri = $feed->{ns};
			my @elem = childlist($obj->elem, $ns_uri, 'entry');
			$obj->elem->removeChild($_) for @elem;
			return $obj->set($ns_uri, 'feed', $feed);
		}
		elsif ($_[0]->isa('XML::Atom::Feed')) {
			my ($entry) = @_;
			my $ns_uri = $entry->{ns}->{uri};
			my @elem = childlist($obj->elem, $ns_uri, 'feed');
			$obj->elem->removeChild($_) for @elem;
			return $obj->set($ns_uri, 'entry', $entry);			
		}
		else {
			my $r = ref $_[0];
			carp "can't embed $r - should be XML::Atom::Feed or XML::Atom::Entry";
		}
	}
	else {
		return $obj->get_object('http://www.w3.org/2005/Atom', 'feed', 'XML::Atom::Feed')
			|| $obj->get_object('http://www.w3.org/2005/Atom', 'entry', 'XML::Atom::Entry');
	}
}

=head1 NAME

XML::Atom::Ext::Inline - The great new XML::Atom::Ext::Inline!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use XML::Atom::Ext::Inline;

    my $foo = XML::Atom::Ext::Inline->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 function1

=cut

BEGIN {
	XML::Atom::Link->mk_object_accessor(inline => 'XML::Atom::Ext::Inline');
}

=head1 ATTRIBUTES

=head2 element_ns
 
Returns the L<XML::Atom::Namespace> object representing our
xmlns:ae="http://purl.org/atom/ext/">.

Do that guys from Oracle are going to make more sane namespace URL and prefix?
 
=cut
 
sub element_ns {
	return XML::Atom::Namespace->new(
		'ae' => q{http://dp-net.com/ae}
	);
}

sub element_name {'inline'}

=head1 AUTHOR

Dmitri Popov, C<< <operator at cv.dp-net.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-xml-atom-ext-inline at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=XML-Atom-Ext-Inline>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc XML::Atom::Ext::Inline


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=XML-Atom-Ext-Inline>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/XML-Atom-Ext-Inline>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/XML-Atom-Ext-Inline>

=item * Search CPAN

L<http://search.cpan.org/dist/XML-Atom-Ext-Inline>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Dmitri Popov, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of XML::Atom::Ext::Inline
