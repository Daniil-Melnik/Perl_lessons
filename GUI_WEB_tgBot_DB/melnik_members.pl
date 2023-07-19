#!/usr/bin/perl -w
use strict;
use HTML::Template;
use DBI;
use warnings; 
use HTML::Template;
use lib './';
require 'io_cgi.pm';
use lib '/home/webprog5/data/www/webprogmelnik.trudogolik.ru/cgi-bin/';


my $io_cgi = 'io_cgi'->new;
$io_cgi->get_params();
my $group_id = $io_cgi->param('group');
my $attr = { PrintError => 0, RaiseError => 0 };
my $data_source = "DBI:mysql:webprog5_melniktgbot:localhost";
my $username = "webprog5_melnik";
my $password = "2WsxcdE3";

my $dbh = DBI->connect( $data_source, $username, $password, $attr );
if (!$dbh) { die $DBI::errstr; }

$dbh->do('SET NAMES cp1251');
my $arrayref_of_stud = $dbh->selectall_arrayref( "SELECT id, student_name FROM student_id WHERE group_tg_id = $group_id", { Slice => {} });
my $template = HTML::Template->new(filename => "melnik_members.html");

$template->param(info => $arrayref_of_stud);
#$template->param(info => [{id=>1, student_name=>$group_id}]);
$template->param(info => $arrayref_of_stud);


print "Content-Type: text/html\n";
print "Charset: windows-1251\n\n";
print $template->output;