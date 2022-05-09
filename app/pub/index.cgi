#!/usr/bin/perl -Tw

BEGIN {
    push @INC, '../src';
};

use strict;
use warnings FATAL => 'all';

use CGI qw/:standard/;
use Framework::DI::Container;
use App::services;

my $container = Framework::DI::Container->new(\%App::services::definitions);

my $controler = $container->get('customer_controller');
$controler->index();
