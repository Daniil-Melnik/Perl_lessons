#!/usr/bin/perl -w

package DataBase;

use strict;
use warnings;
use DBI;
use Data::Dumper;

our $singleton = undef;

sub new 
{
  my $class = @_;
  my $conf = @_;

  return $singleton if defined $singleton;

  my $self = {
    config => $conf,
  };

  my $dbh = DBI->connect( $conf->{data_place}, $config->{user}, $config->{pass}, $config->{attr} );
  if (!$dbh) { die $DBI::errstr; }
  $dbh->do('SET NAMES cp1251');

  $self->{dbh} = $dbh;

  $singleton = bless($self, $class);
  return $singleton;
}


sub disconnect
{
  my ($self) = @_;

  $self->{dbh}->disconnect;
}
1;