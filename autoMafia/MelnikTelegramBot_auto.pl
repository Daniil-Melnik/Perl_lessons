use strict;
use warnings;
use lib "./";
use WebProgTelegramClient;
use DBI;
use Encode qw(decode encode);

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

my $attr = { PrintError => 0, RaiseError => 0 };
my $data_source = "DBI:mysql:webprog5_melniktgbot:localhost";
my $username = "webprog5_melnik";
my $password = "2WsxcdE3"; 

my $dbh = DBI->connect( $data_source, $username, $password, $attr );
if (!$dbh) { die $DBI::errstr; }

$dbh->do("SET NAMES utf8");
$dbh->do("SET character_set_connection = utf8");


$bot->call( 'sendMessage', { chat_id => $chat_id, text => "Привет" } );
#$bot->call( 'sendPhoto', { chat_id => $chat_id, photo => "https://i.ytimg.com/vi/65zkVM_gWDE/maxresdefault.jpg?7857057827" } );

my $time = time() - 600;
#print $time;

my $updates = $bot->call( 'getUpdates', { offset => $number_of_update + 1 } );
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
          my $sql = "SELECT name, discription, url FROM auto WHERE comand = ?";
          my $sth = $dbh->prepare($sql);

          # execute the query
          $sth->execute($message_command[0]);

          while(my @row = $sth->fetchrow_array()){
            print $row[1] . "\n";
            my $octets = encode("utf8", $row[1]);
            my $octets_1 = encode("cp1251", $row[1]);
            my $octets_2 = encode("iso-8859-1", $row[1]);

						open(my $fh, '>', 'text.txt') or die;
						print $fh $row[1];
						close $fh;
  					
						open(InFile, '<:encoding(UTF-8)', "text.txt");

						while (my $line = <InFile>)
            {
            	print $ line ;
							$bot->call( 'sendMessage', { chat_id => $chat_id, text => $line } );
            }
						close ( InFile );
						
						#print $octets . "\n";
						my $res = "Проверка";
#my $encoding_name_1 = Encode::Detect::Detector::detect($row[1]);
#my $encoding_name_2 = Encode::Detect::Detector::detect($res);
#print ("\n" . $row[1] . " " . $res . " " . $octets . "\n");
						#print $res . "\n";
            #$bot->call( 'sendMessage', { chat_id => $chat_id, text => $row[1] } );
						#$bot->call( 'sendMessage', { chat_id => $chat_id, text => $octets } );
						#$bot->call( 'sendMessage', { chat_id => $chat_id, text => $octets_1 } );
						#$bot->call( 'sendMessage', { chat_id => $chat_id, text => $octets_2 } );
            #$bot->call( 'sendPhoto', { chat_id => $chat_id, photo => $row[2] } );
            #print ($row[0] . " " . "\n" . $row[1] . "\n" . $row[2]);
          }
                 
          $sth->finish();
        }
      } 
    }

    $number_of_update = $update->{ update_id };
  }

print "ok1";




