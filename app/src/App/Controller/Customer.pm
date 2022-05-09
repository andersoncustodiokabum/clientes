package App::Controller::Customer;
use strict;
use warnings FATAL => 'all';

use App::Entity::Customer;
use Moose;

extends 'Framework::Controller';

sub new {
    my ($class, $customer_repository, $cgi) = @_;

    bless {
        customer_repository => $customer_repository,
        cgi => $cgi
    }, $class;
}

sub index {
    my $self = shift;
    my $customer_repository = $self->{customer_repository};

    if ($self->{cgi}->param()) {
        $customer_repository->create(App::Entity::Customer->new({
            firstname => $self->{cgi}->param('firstname'),
            lastname => $self->{cgi}->param('lastname')
        }));

        print $self->redirect('/');
        exit;
    }

    print $self->header;
    print $self->{cgi}->h1('Teste PERL');

    print '<table border="1">';
    foreach ($customer_repository->get_all()) {
        my $customer = $_;
        print sprintf(
            "<tr><td>%s</td><td>%s</td><td>%s</td></tr>",
            $customer->get_id,
            $customer->get_firstname,
            $customer->get_lastname
        );
    }
    print '</table>';

    print $self->{cgi}->start_form;

    print $self->{cgi}->div('Firstname: ', $self->{cgi}->textfield(-name => 'firstname', -required));
    print $self->{cgi}->div('Lastname: ', $self->{cgi}->textfield(-name => 'lastname', -required));

    print $self->{cgi}->submit;
    print $self->{cgi}->end_form;
}

1;