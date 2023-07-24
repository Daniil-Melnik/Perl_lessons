use strict;
use warnings;
use lib "./";
use WebProgTelegramClient;
use DBI;

use Time::Local;
use DateTime;
use utf8;
#use cp1251;

my $token = '6164752146:AAHybXJiUKBnL6f5MRv-Hf7g8i574BW9Te4';
my $chat_id = '-1001910130358';

my $bot = WebProgTelegramClient->new( token => $token );
my $chat = $bot->call( 'getChat', {chat_id => $chat_id} );
my %all_members; 
my $number_of_update = 0;

# my $attr = { PrintError => 0, RaiseError => 0 };
# my $data_source = "DBI:mysql:webprog5_melniktgbot:localhost";
# my $username = "webprog5_melnik";
# my $password = "2WsxcdE3";

# my $dbh = DBI->connect( $data_source, $username, $password, $attr );
# if (!$dbh) { die $DBI::errstr; }

# $dbh->do('SET NAMES cp1251');


#$bot->call( 'sendMessage', { chat_id => $chat_id, text => "/culverempire\n/shubertAB\n/ascotbaileyS200\n/smiththunderbolt\n/shubertbeverly\n/patomac_indian\n/smith_custom_200\n/lassiter_series_75\n/smith_deluxe_station_wagon
#/walter_military" } );
#$bot->call( 'sendPhoto', { chat_id => $chat_id, photo => "https://i.ytimg.com/vi/65zkVM_gWDE/maxresdefault.jpg?7857057827" } );

my $time = time() - 500;
#print $time;

my $updates = $bot->call( 'getUpdates', { offset => $number_of_update + 1 } );
$bot->call( 'sendMessage', { chat_id => $chat_id, text => "Привет" } );
foreach my $update ( @{ $updates->{result} } )
  {
    my $upd_message = $update->{ message };
    if ( $upd_message )
    {
      my $user_of_message_id = $upd_message->{ from }->{ id };
      my $user_of_message_name = $upd_message->{ from }->{ first_name };
      my $date_of_message = $upd_message->{ date };
      my $message_text = $upd_message->{ text };

      if ((index($message_text, "/") == 0)&&(index($message_text, "@") != -1))
      {
        if ($date_of_message >= $time)
        {
          my @message_command = split('@', $message_text);
          # print ($date_of_message);
          # my $sql = "SELECT name, discription, url FROM auto WHERE comand = ?";
          # my $sth = $dbh->prepare($sql);

          # # execute the query
          # $sth->execute($message_command[0]);

          # while(my @row = $sth->fetchrow_array()){
          #   $bot->call( 'sendMessage', { chat_id => $chat_id, text => $row[1] } );
          #   #$bot->call( 'sendPhoto', { chat_id => $chat_id, photo => $row[2] } );
          #   #print ($row[0] . " " . "\n" . $row[1] . "\n" . $row[2]);
          # }
                 
          # $sth->finish();
        }
      } 
    }

    $number_of_update = $update->{ update_id };
  }

print "ok1";




