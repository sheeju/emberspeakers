use strict;
use warnings;

use EmberSpeakers;

my $app = EmberSpeakers->apply_default_middlewares(EmberSpeakers->psgi_app);
$app;

