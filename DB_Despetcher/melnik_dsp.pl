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
  
  # create database object with connection
  my $db_obj = DataBase->new( $data_place, $username, $pass, $attr );
  
  my $dbh = $db_obj->get_dbh();
  $dbh->do('SET NAMES cp1251');

  # getting cgi params: class and event
  my $cgi = CGI->new;
  $cgi->get_params();
  my $cl = $cgi->param('class');
  my $event = $cgi->param('event');

  #my $cl = "melnik_group_list";
  #my $event = "add";
  
  # making new object of class
  require $cl . ".pl";
  my $object = $cl->new;
  
  # event
  $object->$event();
  
  # disconnection db
  $db_obj->disconnect();
};

if ($@) {
  print 'ERROR: ';
  print $@;
}
