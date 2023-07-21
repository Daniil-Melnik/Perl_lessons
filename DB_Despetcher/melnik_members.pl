#!/usr/bin/perl -w

package melnik_members;

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

  my $template = HTML::Template->new( filename => "melnik_members.html" );

  my $arrayref_of_stud = $dbh->selectall_arrayref( "SELECT id, student_name FROM student_id WHERE group_tg_id = $group_id", { Slice => {} });

  $template->param(info => $arrayref_of_stud);
  #$template->param(info => [{id => 123, tg_id => "0235"}]);

  print "Content-Type: text/html\n";
  print "Charset: windows-1251\n\n";
  # $template->param(class => $cl);
  # $template->param(event => $event);
  print $template->output;
}

1