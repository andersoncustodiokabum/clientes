package Server::services;
use strict;
use warnings FATAL => 'all';

our %definitions = (
    db_host => 'mysql',
    db_port => 3306,
    db_name => 'clientes',
    db_user => 'root',
    db_password => 'root',
    cgi => sub {
        use CGI qw/:standard/;
        CGI->new();
    },
    dsn => sub {
        my $container = shift;
        sprintf("DBI:mysql:database=%s;host=%s;port=%s",
            $container->get('db_name'),
            $container->get('db_host'),
            $container->get('db_port')
        )
    },
    dbh => sub {
        use DBI;
        
        my $container = shift;

        my %attr = (
            PrintError => 1,
            RaiseError => 1,
            mysql_enable_utf8 => 1
        );

        DBI->connect($container->get('dsn'), $container->get('db_user'), $container->get('db_password'), \%attr)
    },
    
    ##
    # Customers
    #
    infra_repository_customer => sub {
        use V1::Infrastructure::Persistence::Customer::Repository::Customer;
        
        my $container = shift;
        V1::Infrastructure::Persistence::Customer::Repository::Customer->new($container->get('dbh'));
    },

    list_customer => sub {
        use V1::Business::UseCase::Customer::ListCustomer;

        my $container = shift;
        V1::Business::UseCase::Customer::ListCustomer->new($container->get('infra_repository_customer'));
    },

    customer_controller => sub {
        use V1::Application::Api::Rest::Controller::Customer::Customer;
        
        my $container = shift;
        V1::Application::Api::Rest::Controller::Customer::Customer->new(
            $container->get('list_customer'),
            $container->get('cgi')
        );
    },
);

1;
