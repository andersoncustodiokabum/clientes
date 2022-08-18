#!/usr/bin/perl -Tw

BEGIN {
    push @INC, '../src';
};

use strict;
use warnings FATAL => 'all';

use CGI qw/:standard/;
use Framework::DI::Container;
use Framework::Router;
use Server::services;
use Server::routers;

my $container = Framework::DI::Container->new(\%Server::services::definitions);

my $controler = $container->get('customer_controller');
$controler->index();
