#!/usr/bin/perl -w
use lib './';
use CGI;
use DataBase;


use strict;
use warnings;

eval 
{
  my $attr = { PrintError => 0, RaiseError => 0, AutoCommit => 1 };
  my $data_place = "DBI:mysql:webprog5_melniktgbot:localhost";
  my $username = "webprog5_melnik";
  my $pass = "2WsxcdE3";

  my $db_obj = DataBase->new( $data_place, $username, $pass, $attr );

  my $dbh = $db_obj->get_dbh();
  $dbh->do('SET NAMES cp1251');

  my $cgi = CGI->new;
  $cgi->get_params();
  my $cl = $cgi->param('class');
  my $event = $cgi->param('event');

  require $cl . ".pl";
  my $object = $cl->new;

  $object->$event();
 
  $db_obj->disconnect();
};

if ($@) {
  print '! - Error: ';
  print $@;
}
