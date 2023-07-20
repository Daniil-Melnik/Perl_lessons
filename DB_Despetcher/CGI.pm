#!/usr/bin/perl -w
# must to rebrend
package CGI;

use strict;
use warnings;
require 'io_cgi.pl';

my $io_cgi = undef;

sub new 
{
  my $class = shift;

  unless ($io_cgi)
  {
    $io_cgi = 'io_cgi'->new();
  }

  return $io_cgi;
}

1;
