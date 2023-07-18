#!/usr/bin/perl -w

use lib './';
require 'io_cgi.pm';
use strict;
use warnings;
use DBI;

my $io_cgi = 'io_cgi'->new;
$io_cgi->get_params();
my $group_id = $io_cgi->param('group_id');


my $attr = { PrintError => 0, RaiseError => 1 };

my $data_source = "DBI:mysql:webprog5_melniktgbot:localhost";
my $username = "webprog5_melnik";
my $password = "2WsxcdE3";
my $dbh = DBI->connect( $data_source, $username, $password, $attr ) or die $DBI::errstr;


my $sth = $dbh->prepare( "INSERT INTO group_id (tg_id) VALUES (?);" );
$sth->execute($group_id);

print "Location: melnik_group_list.pl\n\n"; 
print "Content-type: text/html\n\n"; 

