#!/usr/bin/perl -w
package DataBase;

use strict;
use warnings;
use DBI;

my $db_obj = undef;

sub new 
{
  my ($class, $dsn, $user, $pass, $attr) = @_;

  unless ($db_obj)
  {
    $db_obj = bless { dsn => $dsn, user => $user, pass => $pass, attr => $attr, }, $class;
    $db_obj->connect();
  }
  return $db_obj;
}


sub connect 
{
  my ($self) = @_;

  $self->{dbh} = DBI->connect( $self->{dsn}, $self->{user}, $self->{pass}, $self->{attr} );
}

sub get_dbh
{
  my ($self) = @_;

  return $self->{dbh};
}

sub disconnect
{
  my ($self) = @_;

  $self->{dbh}->disconnect if $self->{dbh};
  undef $db_obj;
}

1;
