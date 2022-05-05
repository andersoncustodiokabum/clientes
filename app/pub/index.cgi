#!/usr/bin/perl -wT

print "Content-type: text/html;charset=utf-8\n\n";


use DBI;
use FCGI;

# MySQL database configuration
my $host = 'mysql';
my $database = 'clientes';
my $port = 3306;
my $dsn = "DBI:mysql:database=$database;host=$host;port=$port";
my $username = "root";
my $password = '';

# connect to MySQL database
my %attr = ( PrintError=>0,  # turn off error reporting via warn()
             RaiseError=>1);   # turn on error reporting via die()           

my $dbh  = DBI->connect($dsn,$username,$password, \%attr);



print "<h1>Hello World In CGI Perl</h1>";


my $sql = "SELECT firstname, lastname FROM customer";
my $sth = $dbh->prepare($sql);

$sth->execute();

while(my @row = $sth->fetchrow_array()){
    printf("<p>%s %s</p>\n",$row[0],$row[1]);
}       

$sth->finish();
