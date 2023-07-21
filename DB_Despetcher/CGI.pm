#!/usr/bin/perl -w
package CGI;

use strict;
use warnings;
require 'io_cgi.pm';

my $cgi_obj = undef;

sub new 
{
  my $class = shift;

  unless ($cgi_obj)
  {
    $cgi_obj = 'io_cgi'->new();
  }

  return $cgi_obj;
}

1;

