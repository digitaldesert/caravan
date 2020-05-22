package Application::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::Util qw/dumper/;

# This action will render a template
sub welcome {
  my $self = shift;
  # Render template "example/welcome.html.ep" with message
  $self->render(json => [ 'Welcome to the Mojolicious real-time web framework!' ]);
}

1;
