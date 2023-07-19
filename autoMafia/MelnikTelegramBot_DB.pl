use strict;
use warnings;
use utf8;
use lib "./";
use Data::Dumper qw(Dumper);
use WebProgTelegramClient;

use DBI;

my $attr = { PrintError => 0, RaiseError => 0 };
my $data_source = "DBI:mysql:webprog5_melniktgbot:localhost";
my $username = "webprog5_melnik";
my $password = "2WsxcdE3";

my $dbh = DBI->connect( $data_source, $username, $password, $attr );
if (!$dbh) { die $DBI::errstr; }
$dbh->do('SET NAMES cp1251');

use Time::Local;

my $token = '6066175785:AAGbPy6vKuuneCAP8XI7XC8fJAl80nfeAfQ';
my $chat_id = '-1001874774612';

my $bot = WebProgTelegramClient->new( token => $token );
my $chat = $bot->call( 'getChat', { chat_id => $chat_id } );

my %all_members;
my %deadline = ( 1 => "13.07.2023", 2 => "15.07.2023" );

my $sth = $dbh->prepare( "INSERT INTO hw_id(hw_num,deadline) VALUES (?, ?)" );
$sth->execute( 1, $deadline{1} );
$sth->execute( 2, $deadline{2} );

my $number_of_update = 0;

my $updates = $bot->call( 'getUpdates', { offset => $number_of_update + 1 } );
my $group_num = 3;

# созранение данных в БД
foreach my $update ( @{ $updates->{result} } )
{
  my $upd_message = $update->{ message };
  if ( $upd_message )
  {
    my $user_of_message_id = $upd_message->{ from }->{ id };
    my $user_of_message_name = $upd_message->{ from }->{ first_name };

  
    if ( !$all_members{ $user_of_message_id } )
    {
      $sth = $dbh->prepare( "INSERT INTO student_id (student_name, group_num) VALUES (?, ?)" );
      $sth->execute( $user_of_message_name, $group_num );
      $all_members{ $user_of_message_id } = 1;
    }
  }
  $number_of_update = $update->{ update_id };
}

my $arrayref_of_row_hashrefs_students;
my $arrayref_of_row_hashrefs_hw_ids;
$arrayref_of_row_hashrefs_students = $dbh->selectall_arrayref( "SELECT id, student_name, group_num FROM student_id WHERE group_num BETWEEN ? AND ?", { Slice => {} }, 0, 5 );

foreach my $update ( @{ $updates->{result} } )
{
  my $upd_message = $update->{ message };
  if ( $upd_message )
  {
    my $user_of_message_id = $upd_message->{ from }->{ id };
    my $user_of_message_name = $upd_message->{ from }->{ first_name };
    my $date_of_message = $upd_message->{ date };
    my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime( $date_of_message );

    if ($upd_message->{text})
    {
      my ($hw_num) = $upd_message->{text} =~ /(\d+)/;
      my ($item) = grep 
      {
        $_->{ student_name } eq $user_of_message_name;
      } @$arrayref_of_row_hashrefs_students;

      my $sth = $dbh->prepare( "INSERT INTO webprog5_melnik_results(student_id, hw_num, result, date_of_complite) VALUES (?, ?, ?, ?)" );
      my @spl = split( /\./, $deadline{$hw_num} );
      # my $text = "23.22.22";
      # my @spl = split(/\./, $text); 
      my $result;
      # print @spl;
      # print ($deadline{$hw_num});
      # print $spl[0] . "." . $spl[1] . "." . $spl[2] . "\n";
      if ( ( $year-1900 <= $spl[2] ) && ( $mday <= $spl[0] ) && ( $mon <= $spl[1]+1 ) )
      {
        $result = 10;
      }
      else
      {
        $result = 0;
      }
      # $sth->execute($item->{id} ,$hw_num, $result, ($mday . "." . ($mon+1) . "." . ($year+1900)));
    }
  }
  $number_of_update = $update->{ update_id };
}

show_table();
print "\n";

# редактирование данных
my $sth2 = $dbh->prepare("UPDATE webprog5_melnik_results SET result = ? WHERE id = ?");
$sth2->execute( 8, 73 ) or die "Unable to update\n";
$sth2->execute( 4, 76 ) or die "Unable to update\n";

show_table();

# show_table($dbh)
# принимает на вход связь с БД, выводит в консоль таблицу результатов
sub show_table  
{
  shift;
  # выборка
  my $sth = $dbh->prepare("SELECT * FROM webprog5_melnik_results;");
  $sth->execute();
  while (my @arr = $sth->fetchrow_array())
  {
    print join ("\t", @arr), "\n";
  }
  $sth->finish();
}
