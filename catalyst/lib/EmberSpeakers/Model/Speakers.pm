#
# lib/EmberSpeakers/Model/Speakers.pm
#
# Developed by Sheeju Alex <sheeju@exceleron.com>
# Copyright (c) 2014 Exceleron Inc
# All rights reserved.
#
# Changelog:
# 2014-05-25 - created
#

package EmberSpeakers::Model::Speakers;

use strict;
use base 'Catalyst::Model';
use List::Util qw/first max/;
use List::MoreUtils qw/first_index/;

my @data = (
	{ id => 1, name => 'Bugs Bunny'},
	{ id => 2, name => 'Wile E. Coyote'},
	{ id => 3, name => 'Yosemite Sam'},
);

sub all {
	return [ map { id => $_->{id}, name => $_->{name} }, @data ];
}

sub retrieve {
	my ( $self, $id ) = @_;
	return first { $_->{id} == $id } @data;
}

sub add_new {
	my ( $self, $gift_data ) = @_;
	# Verify all fields in place
	return if ! $gift_data->{name};

	my $next_id = max(map $_->{id}, @data) + 1;
	push @data, { %$gift_data, id => $next_id };
	return $#data;
}

sub update {
	my ( $self, $gift_id, $gift_data ) = @_;
	return if ! defined($gift_data->{name}) ||
	! defined($gift_data->{id});

	my $idx = first_index { $_->{id} == $gift_id } @data;
	return if ! defined($idx);

	$data[$idx] = { %$gift_data, id => $gift_id };
	return 1;
}

sub delete_gift {
	my ( $self, $gift_id ) = @_;
	my $idx = first_index { $_->{id} == $gift_id } @data;

	return if ! defined($idx);

	splice @data, $idx, 1;
}

# Used for testing purposes
sub _get_data { return @data }

1;

__END__

=head1 NAME

Speakers - <<<description of module>>>

=head1 SYNOPSIS

  use Speakers;

  my $xxx = new Speakers;

=head1 DESCRIPTION

The Speakers module allows you ...
<<<your description here>>>

=head2 EXPORT

<<here describe exported methods>>>

=head1 SEE ALSO

=head1 AUTHORS

Sheeju Alex, <sheeju@exceleron.com>

=cut

# vim: ts=4
# vim600: fdm=marker fdl=0 fdc=3

