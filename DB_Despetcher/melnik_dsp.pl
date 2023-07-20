#!/usr/bin/perl -w
use lib '.';
use CGISParams;
use DBConnect;

# use DBI;
# use HTML::Template;
# use Data::Dumper;

use strict;
use warnings;

eval 
{
  # DataBase Config
  my $attr        = { PrintError => 0, RaiseError => 0, AutoCommit => 1 };
  my $database    = 'webprog5_melniktgbot';
  my $db_username = "webprog5_melnik";
  my $db_password = "2WsxcdE3";
  my $data_source = "DBI:mysql:$database:localhost";

  # Create a new connection link
  my $link = DBConnect->new( $data_source, $db_username, $db_password, $attr );

  # Get the current link to the connection
  my $dbh = $link->get_dbh();
  $dbh->do('SET NAMES cp1251');

  # Get cgi params 
  my $cgi = CGISParams->new;
  $cgi->get_params();
  my $cl = $cgi->param('class');
  my $event = $cgi->param('event');

  # my $cl = "NikitinGroup";
  # my $event = "show_list";

  # Create a new instance of the requested class
  require $cl . ".pl";
  my $object = $cl->new;

  # Calling the requested method of the requested class
  $object->$event();
 
  # Closing the connection to the database
  $link->disconnect();
};

# Handling Errors
if ($@) {
  print '! - Error: ';
  print $@;
}
