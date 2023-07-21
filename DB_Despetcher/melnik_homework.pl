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
my $arrayref_of_hw = $dbh->selectall_arrayref( "SELECT num, deadline, id, group_tg_id FROM homework_id", { Slice => {} });
my @fin_arr;

foreach my $row (@$arrayref_of_hw)
{
  if ($row->{group_tg_id} == $group_id)
  {
    my %res = ( id => $row->{id}, num => $row->{num}, deadline => $row->{deadline});
    push( @fin_arr, \%res );
  }
}
my $template = HTML::Template->new(filename => "melnik_homework.html");

$template->param(info => \@fin_arr);
#$template->param(info => [{id => 1, student_id => 25, hw_num => 2, result => 10, date_of_complite => "25.02.2023"}]);

print "Content-Type: text/html\n";
print "Charset: windows-1251\n\n";
print $template->output;
#---------------------------------------------

#!/usr/bin/perl -w

package melnik_homework;

use strict;
use warnings;

use HTML::Template;
use DataBase;


sub new
{
    my $class = shift;
    my $self = {};

    bless $self, $class;
    return $self;
}


sub show_list
{
  my $cgi = CGI->new;

  my $group_id = $cgi->param('id');

  my $link = DataBase->new();
  my $dbh = $link->get_dbh();

  my $arrayref_of_hw = $dbh->selectall_arrayref( "SELECT num, deadline, id, group_tg_id FROM homework_id", { Slice => {} });
  my @fin_arr;

  foreach my $row (@$arrayref_of_hw)
  {
    if ($row->{group_tg_id} == $group_id)
    {
      my %res = ( id => $row->{id}, num => $row->{num}, deadline => $row->{deadline});
      push( @fin_arr, \%res );
    }
  }
  my $template = HTML::Template->new(filename => "melnik_homework.html");

  $template->param(info => \@fin_arr);
  #$template->param(info => [{id => 123, tg_id => "0235"}]);

  print "Content-Type: text/html\n";
  print "Charset: windows-1251\n\n";
  # $template->param(class => $cl);
  # $template->param(event => $event);
  print $template->output;
}

1