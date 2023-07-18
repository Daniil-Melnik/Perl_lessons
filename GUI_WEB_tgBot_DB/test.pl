use strict;
use warnings;
use utf8;
use lib "./";
use HTML::Template;

my $template = HTML::Template->new(filename => 'index.html');

# массив 
$template->param(employee_info => [{name => 'Sam', job => 'programmer'}, {name => 'Steve', job => 'soda jerk'}]);

print "Content-Type: text/html\n";
print "Charset: windows-1251\n\n";
print  $template->output;

