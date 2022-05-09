package App::Repository::Customer;
use strict;
use warnings FATAL => 'all';

use App::Entity::Customer;

sub new {
    my ($class, $model) = @_;
    bless {
        model => => $model
    }, $class;
}

sub get_all {
    my $self = shift;
    $self->{model}->all;
}

sub create {
    my ($self, $customer) = @_;
    $self->{model}->create($customer);
}

1;