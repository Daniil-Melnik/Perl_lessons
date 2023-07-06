#!/usr/bin/perl

use strict;
use lib "./";
use Melnik01Stack;

my $cl = Melnik01Stack->new( 'array' => [1, 2, 3] );

my $ref = $cl->get_stack();
print "\nlength of stack before pushing: " . $cl->get_len();
$cl->show_stack();

# pushing elements to stack
# $cl->add_element("5");
# $cl->add_element("7");
# $cl->add_element("1");
# $cl->add_element("3");
$cl->add_element("9");
print "\nlength of stack after pushing: " . $cl->get_len();
$cl->show_stack();

# pop element from stack
$cl->remove_element();
print "\nlength of stack after pop: " . $cl->get_len();
$cl->show_stack();
