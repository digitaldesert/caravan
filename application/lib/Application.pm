package Application;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by config file
  my $config = $self->plugin('Config');

  # Configure the application
  $self->secrets($config->{secrets});

  # Configure some namespaces
  push @{$self->app->commands->namespaces}, 'Application::Command';

  # Configure some hooks
  $self->app->hook(before_command => sub {
    my ($command, $args) = @_;
    say $self->app->dumper($command);
  });

  # Router
  my $r = $self->routes;

  # Namespaced route to controller
  $r->route('/test/:controller/:action/:id')->to(namespace => 'Application::Controller::Test', controller=>'example', action=>'welcome', id => 1);

  # Global route to controller (catch-all *should lead to homepage*)
  $r->route('/:controller/:action/:id')->to(controller=>'example', action=>'welcome', id => 1);

}

1;

