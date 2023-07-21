#!/usr/bin/perl -w

package melnik_results;

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

  #$template->param(info => [{id => 123, tg_id => "0235"}]);

  print "Content-Type: text/html\n";
  print "Charset: windows-1251\n\n";
  # $template->param(class => $cl);
  # $template->param(event => $event);
  print $template->output;
}

1