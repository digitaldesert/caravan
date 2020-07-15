#!/usr/bin/env perl

use Mojolicious::Lite;
use Minion::Backend::Pg;    # class needs to be loaded for `data_section`
use Mojo::Loader 'data_section';
use Mojo::Pg;

# ABSTRACT: unathenticated access to minion admin via /minion

# Instead of throwing around private credentials in environmental variables,
# service names are used from a volume-mounted `.pg_service.conf` file in the
# user's home directory.
my $service_name = $ENV{MINION_SERVICE_NAME} // 'minion-default';

# Checks the current migration version and dies loudly if it doesn't match
helper pg => sub {
    state $pg = Mojo::Pg->new("postgresql://?service=$service_name");
    $pg;
};

plugin 'Minion' => {Pg => app->pg};
plugin 'Minion::Admin';

get '/' => sub {
    my $c = shift;
    $c->render(text => 'You probably want to visit /minion');
};

app->start;