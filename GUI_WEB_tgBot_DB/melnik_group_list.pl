#!/usr/bin/perl -w
use strict;
use HTML::Template;
use DBI;
 
use lib '/home/webprog5/data/www/webprogmelnik.trudogolik.ru/cgi-bin/';

my $attr = { PrintError => 0, RaiseError => 0 };
my $data_source = "DBI:mysql:webprog5_melniktgbot:localhost";
my $username = "webprog5_melnik";
my $password = "2WsxcdE3";

my $dbh = DBI->connect( $data_source, $username, $password, $attr );
if (!$dbh) { die $DBI::errstr; }
$dbh->do('SET NAMES cp1251');

my $arrayref_of_groups = $dbh->selectall_arrayref( "SELECT id, tg_id FROM group_id WHERE id BETWEEN ? AND ?", { Slice => {} }, 0, 50 );

my $template = HTML::Template->new(filename => "melnik_group_list.html");

$template->param(info => $arrayref_of_groups);

print "Content-Type: text/html\n";
print "Charset: windows-1251\n\n";
print $template->output;

