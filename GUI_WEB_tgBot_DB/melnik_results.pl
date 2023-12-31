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
my $arrayref_of_res = $dbh->selectall_arrayref( "SELECT id, student_id, hw_num, result, date_of_complite FROM webprog5_melnik_results", { Slice => {} });
my @fin_arr;
my $arrayref_of_stud = $dbh->selectall_arrayref( "SELECT id, student_name, group_tg_id FROM student_id", { Slice => {} });

foreach my $row (@$arrayref_of_res)
{
  my $name = $row->{student_id};
  my $el = $dbh->selectrow_hashref("SELECT id, student_name, group_tg_id FROM student_id WHERE id=?", undef, $name);

  my %res = ( id => $row->{id}, student_id => $el->{student_name}, hw_num => $row->{hw_num}, result => $row->{result}, date_of_complite => $row->{date_of_complite});
  #my %res = ( id => $row->{id}, student_id => $group_id, hw_num => $el->{group_tg_id}, result => $row->{result}, date_of_complite => $row->{date_of_complite});
  if ($el->{group_tg_id} == $group_id)
  {
    push( @fin_arr, \%res );
  }
}
my $template = HTML::Template->new(filename => "melnik_results.html");

$template->param(info => \@fin_arr);
#$template->param(info => [{id => 1, student_id => 25, hw_num => 2, result => 10, date_of_complite => "25.02.2023"}]);

print "Content-Type: text/html\n";
print "Charset: windows-1251\n\n";
print $template->output;