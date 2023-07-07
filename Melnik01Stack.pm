#!/usr/bin/perl

=pod
The module is designed to perform basic operations with the stack
=cut
package Melnik01Stack;
use strict;
  
# new( %params )
# constructor of class
# %params - parameters for new element of class
# return element of class Stack
sub new
{
  my ($type) = shift;
  my %params = @_;

  my $self = {
    array => $params{'array'},
  };
  bless $self, $type;
  return $self;
}
  
# get_steck()
# getter of stack from element of class
# return reference to stack
sub get_stack
{
  my ($self) = @_;
  return $self->{array};
}
  
# get_len()
# get size of stack
# return scalar - length of stack
sub get_len
{
  my ($self) = @_;

  my $ref = $self->{array};
  return $#$ref + 1;
}
  
# get_peak()
# get peak element of stack
# return scalar - peak of stack
sub get_peak
{
  my ($self) = @_;
  my $len = $self->get_len();
  my $ref = $self->{array};
  if ($len == 0)
  {
    die "Stack is empty\n";
  }
  else
  {
    return $ref->[$len-1];
  }
  
}
  
# show_stack()
# print stack
sub show_stack
{
  my ($self) = @_;

  my $len = $self->get_len();
  print "\n";
  for (my $i = 0; $i < $len; $i++)
  {
    print( $self->{array}->[$i] . ' ' );
  }
  print "\n";
}
  
# add_element($element)
# push element into stack
# $element - new scalar element of stack
sub add_element
{
  my ($self, $element) = @_;
  if ($element //= 0)
  {
    my $ref = $self->{array};
    push( @$ref, $element );
  }
  else
  {
    die "element is empty";
  }
    
}

# remove_element()
# pop element from stack
sub remove_element
{
  my ($self) = @_;

  my $ref = $self->{array};
  my $len = $self->get_len();
  if ($len == 0)
  {
    die "stack is empty";
  }
  else
  {
    pop(@$ref);
  }
}
1;
