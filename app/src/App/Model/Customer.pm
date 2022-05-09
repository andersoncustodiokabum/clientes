package App::Model::Customer;
use strict;
use warnings FATAL => 'all';

use App::Entity::Customer;

sub new {
    my ($class, $dbh) = @_;
    bless {
        dbh => $dbh
    }, $class;
}

sub all {
    my $self = shift;

    my $sql = "SELECT id, firstname, lastname FROM customer";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute();

    my @customers = ();

    while (my @row = $sth->fetchrow_array()) {
        push(@customers, App::Entity::Customer->new({ id => $row[0], firstname => $row[1], lastname => $row[2] }));
    }

    $sth->finish();

    @customers;
}

sub create {
    my ($self, $customer) = @_;
    my $sql = "INSERT INTO customer (firstname, lastname) VALUES (?, ?)";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($customer->get_firstname, $customer->get_lastname);
}


1;