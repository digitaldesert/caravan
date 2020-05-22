package Application::Controller::Test::Mail;
use Mojo::Base 'Mojolicious::Controller';
use MIME::Lite;

# This action will render a template
sub welcome {
  my $self = shift;
  my $config = $self->stash('config');

  my $to = 'jane@mailtrap.io';
  my $cc = 'john@mailtrap.io';
  my $from = 'piotr@mailtrap.io';
  my $subject = 'Test Email';
  my $message = 'Hey, I\'m really sorry for the 132 emails I sent you last quarter.';

  my $msg = MIME::Lite->new(
   From     => $from,
   To       => $to,
   Cc       => $cc,
   Subject  => $subject,
   Data     => $message
   );

  $msg->send( $config->{'mail'}->{'transport'}, $config->{'mail'}->{'host'} );
  print "Email Sent, Bro!\n";

  # Render template "example/welcome.html.ep" with message
  $self->render(json => [ 'Mail Sent!' ]);
}

1;
