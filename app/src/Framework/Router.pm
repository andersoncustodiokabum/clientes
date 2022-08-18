package Framework::Router;
use strict;
use warnings FATAL => 'all';

sub new {
    my ($class, $cgi, $routers) = @_;

    bless {
        cgi => $cgi,
        routers => $routers
    }, $class;
}

sub get_match {
    my $self = shift;

    foreach my $route (@{$self->{routers}}) {
        my $pattern = '^' . $route->{path} . '$';
        my @match = ($ENV{REQUEST_URI} =~ $pattern);

        if (@match) {
            return ($route, \@match);
        }
    }

    return ();
}

1;