package Framework::DI::Container;
use strict;
use warnings FATAL => 'all';

sub new {
    my ($class, $definitions) = @_;

    bless {
        definitions => $definitions,
        resolved_entries => { }
    }, $class;
}

sub get {
    my ($self, $id) = @_;

    if (!$self->has($id)) {
        die("No DI found for '$id'")
    }

    if (exists $self->{resolved_entries}->{$id}) {
        return $self->{resolved_entries}->{$id};
    }

    my $definition = $self->{definitions}->{$id};

    if (ref($definition) eq 'CODE') {
        $definition = $definition->($self);
    }

    $self->{resolved_entries}{$id} = $definition;

    $definition;
}

sub has {
    my ($self, $id) = @_;

    return exists $self->{definitions}->{$id};
}

1;