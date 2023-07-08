#!/usr/bin/perl

use 5.010;
use strict;
use warnings;
use constant NUM => 10;

print "Hello World\n\n";

print "Overview of variables and operations by value:\n\n";

my %hash;

my $first_param = 5;
my $second_param = 9;

%hash = (%hash, 'addition', $first_param + $second_param);
%hash = (%hash, 'subtraction', $first_param - $second_param);
%hash = (%hash, 'multiplication', $first_param * $second_param);
%hash = (%hash, 'division', $first_param / $second_param);

foreach my $k (keys %hash)
{
print "$k = $hash{$k}\n";
}
print "============================\n";
print "\nOverview of variables and operations by reference:\n\n";

my $hash1;
$hash1->{'addition'} = $first_param + $second_param;
$hash1->{'subtraction'} = $first_param - $second_param;
$hash1->{'multiplication'} = $first_param * $second_param;
$hash1->{'division'} = $first_param / $second_param;

foreach my $key (keys %{$hash1})
{
  my $value = $hash1->{$key};
  print "$key = $value\n";
}

# selection of values divisible by 3 or 2
my @array_val;
for (my $i = 0; $i < 10; $i++)
{
  push( @array_val, $i );
}
print "============================\n";
print "\nSelection of values divisible by 3 or 2 from array: \n";
print "\ninitial array: ";
foreach my $i (@array_val)
{
  print "$i ";
}

print "\nresult  array: ";
foreach my $i (@array_val)
{
  if ( ( $i % 2 == 0 ) || ( $i % 3 == 0 ) )
  {
    print "$i ";
  }
  else
  {
    print "* ";
  }
}

print "\n============================\n";

my $array_ref;
for (my $i = 0; $i < NUM; $i++)
{
  push( @$array_ref, $i );
}
for (my $i = 0; $i < NUM; $i++)
{
  $array_ref->[$i] %= 3; 
}

print "\nRemainders after dividing array elements by 3: \n";
print "\ninitial array: ";
foreach my $i (@array_val)
{
  print "$i ";
}

print "\nresult  array: ";
foreach my $i (@$array_ref)
{
    print "$i ";
}