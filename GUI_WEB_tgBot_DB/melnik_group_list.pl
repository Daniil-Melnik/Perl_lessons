#!/usr/bin/perl -w
use strict;
use HTML::Template;
 
use lib '/home/webprog5/data/www/webprogmelnik.trudogolik.ru/cgi-bin/';

my $template = HTML::Template->new(filename => "melnik_group_list.html");

$template->param(info => [{name => 'Sam', job => 'programmer'}, {name => 'Steve', job => 'soda jerk'}]);

print "Content-Type: text/html\n";
print "Charset: windows-1251\n\n";
print $template->output;

