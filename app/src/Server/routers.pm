package Server::routers;
use strict;
use warnings FATAL => 'all';

our @routers = (
    { path => '/', controller => 'customer_controller', action => 'list_customer' },
    { path => '/admin/login', controller => 'admin_login_controller', action => 'index' },
    { path => '/admin/customers/',  controller => 'admin_customer_controller', action => 'index' },
    { path => '/admin/customers/edit/([0-9]+)', controller => 'customer_controller', action => 'index' }
);

1;