package V1::Business::Domain::Customer::Entity::Customer;

use strict;
use warnings FATAL => 'all';

sub new {
    my ($class, $args) = @_;
    
    my $self = {
        id => $args->{id},
        firstname => $args->{firstname},
        lastname => $args->{lastname}
    };
    
    bless $self, $class;
    
    $self;
}

sub get_id {
    my $self = shift;
    $self->{id};
}

sub set_id {
    my ($self, $new_id) = @_;
    $self->{id} = $new_id;
    $self;
}

sub get_firstname {
    my $self = shift;
    $self->{firstname};
}

sub set_firstname {
    my ($self, $new_firstname) = @_;
    $self->{firstname} = $new_firstname;
    $self;
}

sub get_lastname {
    my $self = shift;
    $self->{lastname};
}

sub set_lastname {
    my ($self, $new_lastname) = @_;
    $self->{lastname} = $new_lastname;
    $self;
}

1;