package V1::Application::Api::Rest::Controller::Customer::Customer;
use strict;
use warnings FATAL => 'all';

use V1::Business::Domain::Customer::Entity::Customer;
use Moose;
use JSON;

extends 'Framework::Controller';

sub new {
    my ($class, $list_customer, $cgi) = @_;
    
    my $self = {
        list_customer => $list_customer,
        cgi => $cgi
    };
    
    bless $self, $class;

    $self;
}

sub index {
    my ($self) = @_;

    print $self->{cgi}->header(-type => 'application/json', -charset => 'utf-8');
    
    my @customers = ();

    foreach ($self->{list_customer}->execute()) {
        my $customer = $_;
        push @customers, {
            id => $customer->get_id,
            fullname => $customer->get_firstname . ' ' . $customer->get_lastname
        }
            
    }

    print encode_json \@customers;
}

1;