package App::services;
use strict;
use warnings FATAL => 'all';

use CGI qw/:standard/;
use DBI;

use App::Controller::Customer;
use App::Model::Customer;
use App::Repository::Customer;

our %definitions = (
    db_host => 'mysql',
    db_port => 3306,
    db_name => 'clientes',
    db_user => 'root',
    db_password => 'root',
    cgi => CGI->new(),
    dsn => sub {
        my $container = shift;
        sprintf("DBI:mysql:database=%s;host=%s;port=%s",
            $container->get('db_name'),
            $container->get('db_host'),
            $container->get('db_port')
        )
    },
    dbh => sub {
        my $container = shift;

        my %attr = (
            PrintError => 1,
            RaiseError => 1
        );

        DBI->connect($container->get('dsn'), $container->get('db_user'), $container->get('db_password'), \%attr)
    },

    customer_model => sub {
        my $container = shift;
        App::Model::Customer->new($container->get('dbh'));
    },

    customer_repository => sub {
        my $container = shift;
        App::Repository::Customer->new($container->get('customer_model'));
    },

    customer_controller => sub {
        my $container = shift;
        App::Controller::Customer->new(
            $container->get('customer_repository'),
            $container->get('cgi')
        );
    }
);

1;