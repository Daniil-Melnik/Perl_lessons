use strict;
use warnings;
use utf8;
use lib "./";
use WebProgTelegramClient;

# use Time::Local;

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
# my $arrayref_of_res = $dbh->selectall_arrayref( "SELECT id, student_id, hw_num, result, date_of_complite FROM webprog5_melnik_results", { Slice => {} });

#$bot->call( 'sendMessage', { chat_id => $chat_id, text => "start_1" } );
#$bot->call( 'sendPhoto', { chat_id => $chat_id, photo => "https://i.ytimg.com/vi/65zkVM_gWDE/maxresdefault.jpg?7857057827" } );

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

      if (index($message_text, "/") == 0)
      {
        print "true\n";
      } 
    }
    $number_of_update = $update->{ update_id };
  }

print "ok1";




