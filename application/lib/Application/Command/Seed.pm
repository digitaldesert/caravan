package Application::Command::Seed;
use Mojo::Base 'Mojolicious::Command';
use Mojo::Pg::Migrations;

# Short description
has description => 'seed databases';

# Usage message from SYNOPSIS
has usage => sub { shift->extract_usage };

sub run {
  my ($self, @args) = @_;
  my ($seeddir) = $self->app->home->child('seeds');
  say for $seeddir->list->each;
  #say "Seed DIR is -> ".$self->app->home->child('seeds');

}

1;

=head1 SYNOPSIS

  Usage: APPLICATION mycommand [OPTIONS]

  Options:
    -s, --something   Does something

=cut

