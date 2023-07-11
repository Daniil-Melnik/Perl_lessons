use strict;
use warnings;
use utf8;
use lib "./";
use WebProgTelegramClient;

use Time::Local;

my %users;
my %messages;
 
my $token = '6066175785:AAGbPy6vKuuneCAP8XI7XC8fJAl80nfeAfQ';
my $chat_id = '-1001907883977';

my $bot = WebProgTelegramClient->new( token => $token );
my $chat = $bot->call('getChat', {chat_id => $chat_id});
my $number_of_update = 0;

$bot->call('sendMessage', { chat_id => $chat_id, text => "Запуск программы" });

while (1)
{
  my $updates = $bot->call('getUpdates', { offset => $number_of_update + 1 } );

  foreach my $update ( @{$updates->{result}} )
  {
    my $upd_message = $update->{ message };
    if ($upd_message)
    {
      my $user_of_message_id = $upd_message->{ from }->{ id };
      my $user_of_message_name = $upd_message->{ from }->{ first_name };
      my $date_of_message = $upd_message->{ date };

      my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime($date_of_message);

      if ( $upd_message->{ new_chat_members } ) 
      {
        foreach my $new_member ( @{$upd_message->{ new_chat_members }} ) 
        {

          my $new_member_id = $new_member->{ id };

          $users{ $new_member_id } = 0;
        }
      }

      elsif ( $users{ $user_of_message_id } == 0 && $upd_message->{ text } ) 
      { 

        $users{ $user_of_message_id } = 1;
        my $ans;
    
        if (($hour >= 0) && ($hour <= 12))
        {
          $ans = "Доброе утро, " . $user_of_message_name . "!";
        }
        elsif (($hour > 12) && ($hour <= 18))
        {
          $ans = "Добрый день, " . $user_of_message_name . "!";
        }
        elsif (($hour > 18) && ($hour < 24))
        {
          $ans = "Добрый вечер, " . $user_of_message_name . "!";
        }
        $bot->call( 'sendMessage', { chat_id => $chat_id, text => $ans } );
      }

      if ($upd_message->{ left_chat_member })
        {
          my $left_member = $upd_message->{ left_chat_member };
          if ($left_member && $left_member->{ first_name })
          {
            my $ans;
            my $left_member_name = $left_member->{ first_name };
            $bot->call('sendMessage', { chat_id => $chat_id, text => "До новых встреч, " .  $left_member_name . "."});
          }
        }
    }
    $number_of_update = $update->{ update_id };
  }
}
