#!/usr/bin/perl -w

package melnik_group_list;

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

  my $template = HTML::Template->new( filename => "melnik_homework.html" );

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

  $template->param(info => \@fin_arr);

  print "Content-Type: text/html\n";
  print "Charset: windows-1251\n\n";
  # $template->param(class => $cl);
  # $template->param(event => $event);
  print $template->output;
}

1

