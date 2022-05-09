package Framework::Controller;
use strict;
use warnings FATAL => 'all';


sub header {
    "Content-type: text/html;charset=utf-8\n\n";
}

sub redirect {
    my ($self, $url) = @_;
    "Location: $url\n\n"
}

1;