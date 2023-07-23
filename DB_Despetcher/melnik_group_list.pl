#!/usr/bin/perl -w

package melnik_group_list;

use strict;
use warnings;
use HTML::Template;
use DataBase;

my $cgi = CGI->new;

sub new
{
    my $class = shift;
    my $self = {};
    bless $self, $class;

    return $self;
}


sub show_list
{
  my $template = HTML::Template->new( filename => "melnik_group_list.html" );
  my $db_obj = DataBase->new();
  my $dbh = $db_obj->get_dbh();

  my $arrayref_of_groups = $dbh->selectall_arrayref( "SELECT id, tg_id FROM group_id WHERE id BETWEEN ? AND ?", { Slice => {} }, 0, 50 );

  $template->param(info => $arrayref_of_groups);
  #$template->param(info => [{id => 123, tg_id => "0235"}]);

  print "Content-Type: text/html\n";
  print "Charset: windows-1251\n\n";
  print $template->output;
}


sub add_group
{
  my $self = shift;

  my $group_id = $cgi->param_value( 'tg_id' );

  my $link = DataBase->new();
  my $dbh = $link->get_dbh();

  my $sth = $dbh->prepare( "INSERT INTO group_id (tg_id) VALUES (?);" );
  $sth->execute($group_id);

  $self->show_groups;
}

1

