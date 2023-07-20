#!/usr/bin/perl -w

package melnik_group_list;

use strict;
use warnings;

use HTML::Template;
use DBConnect;


sub new
{
    my $class = shift;
    my $self = {};

    bless $self, $class;
    return $self;
}


sub show_list
{
  my $cgi = CGISParams->new;

  my $template = HTML::Template->new( filename => "./melnik_group_list.html" );

  my $link = DBConnect->new();
  my $dbh = $link->get_dbh();

  my $arrayref_of_groups = $dbh->selectall_arrayref( "SELECT id, tg_id FROM group_id WHERE id BETWEEN ? AND ?", { Slice => {} }, 0, 50 );

  $template->param(info => $arrayref_of_groups);

  print "Content-Type: text/html\n";
  print "Charset: windows-1251\n\n";
  # $template->param(class => $cl);
  # $template->param(event => $event);
  print $template->output;
}

1

