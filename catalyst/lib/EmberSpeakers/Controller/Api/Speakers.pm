package EmberSpeakers::Controller::Api::Speakers;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

EmberSpeakers::Controller::Api::Speakers - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

__PACKAGE__->config(
	action => {
		'*' => {
			# Attributes common to all actions
			# in this controller
			Consumes => 'JSON',
			Path => '',
		}
	}
);

# end action is always called at the end of the route
sub end :Private {
	my ( $self, $c ) = @_;
	# Render the stash using our JSON view
	$c->forward($c->view('JSON'));
}

# We use the error action to handle errors
sub error :Private {
	my ( $self, $c, $code, $reason ) = @_;
	$reason ||= 'Unknown Error';
	$code ||= 500;

	$c->res->status($code);
	# Error text is rendered as JSON as well
	$c->stash->{data} = { error => $reason };
}


# List all gifts in the collection
# GET /gifts
sub list :GET Args(0) {
	my ( $self, $c ) = @_;
	$c->stash->{speakers} = $c->model('Speakers')->all;
}

# Get info on a specific item
# GET /gifts/:gift_id
sub retrieve :GET Args(1) {
	my ( $self, $c, $gift_id ) = @_;
	my $gift = $c->model('Speakers')->retrieve($gift_id);

	# In case of an error, call error action and abort
	$c->detach('error', [404, "No such gift: $gift_id"]) if ! $gift;

	# If we're here all went well, so fill the stash with our item
	$c->stash->{data} = $gift;
}

# Create a new item
# POST /gifts
sub create :POST Args(0) {
	my ( $self, $c ) = @_;
	my $gift_data = $c->req->body_data;

	my $id = $c->model('Speakers')->add_new($gift_data);

	$c->detach('error', [400, "Invalid gift data"]) if ! $id;

	# Location header is the route to the new item
	$c->res->location("/gifts/$id");
}

# Update an existing item
# POST /gifts/:gift_id
sub update :POST Args(1) {
	my ( $self, $c, $gift_id ) = @_;
	my $gift_data = $c->req->body_data;

	my $ok = $c->model('Speakers')->update($gift_id, $gift_data);
	$c->detach('error', [400, "Fail to update gift: $gift_id"]) if ! $ok;
}

# Delete an item
# DELETE /gifts/:gift_id
sub delete :DELETE Args(1) {
	my ( $self, $c, $gift_id ) = @_;
	my $ok = $c->model('Speakers')->delete_gift($gift_id);
	$c->detach('error', [400, "Invalid gift id: $gift_id"]) if ! $ok;
}



=encoding utf8

=head1 AUTHOR

Sheeju Alex,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
