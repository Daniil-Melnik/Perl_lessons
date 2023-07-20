#!/usr/bin/perl -w
# must to rebrend
package DBConnect;

use strict;
use warnings;
use DBI;

my $instance = undef;


# Create a new connection link
sub new 
{
  my ($class, $dsn, $user, $pass, $attr) = @_;

  unless ($instance)
  {
    $instance = bless {
                        dsn => $dsn,
                        user => $user,
                        pass => $pass,
                        attr => $attr,
                      }, $class;
    
    $instance->connect();
  }

  return $instance;
}


# Connecting to the database
sub connect 
{
  my ($self) = @_;

  $self->{dbh} = DBI->connect( $self->{dsn}, $self->{user}, $self->{pass}, $self->{attr} );
}


# Get the current link to the connection
sub get_dbh
{
  my ($self) = @_;

  return $self->{dbh};
}

# Closing the connection to the database
sub disconnect
{
  my ($self) = @_;

  $self->{dbh}->disconnect if $self->{dbh};
  undef $instance;
}

1;
