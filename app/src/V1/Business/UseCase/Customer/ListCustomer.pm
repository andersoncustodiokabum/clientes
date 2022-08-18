package V1::Business::UseCase::Customer::ListCustomer;
use strict;
use warnings FATAL => 'all';

sub new {
    my ($class, $repository_customer) = @_;
    my $self = { repository_customer => $repository_customer };
    bless $self, $class;

    $self;
}

sub execute {
    my $self = shift;

    $self->{repository_customer}->get_all;
}

1;