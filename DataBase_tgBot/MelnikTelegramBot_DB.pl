use strict;
use warnings;
use utf8;
use lib "./";
use WebProgTelegramClient;

# use Time::Local;

# объявление токена бота и id группы для дальнейшей работы
my $token = '6066175785:AAGbPy6vKuuneCAP8XI7XC8fJAl80nfeAfQ';
my $chat_id = '-1001929018339';

# создание базовых условий: создание бота, поиск чата, задание начального значения id обновления
my $bot = WebProgTelegramClient->new( token => $token );
my $chat = $bot->call( 'getChat', {chat_id => $chat_id} );
my %all_members; 
my $number_of_update = 0;

# отладочное сообщение в канал о запуске программы
# $bot->call( 'sendMessage', { chat_id => $chat_id, text => "Запуск программы" } );

# бесконечный цикл для постоянного контроля за изменениями в группе
while (1)
{
  my $updates = $bot->call( 'getUpdates', { offset => $number_of_update + 1 } );

  # рассмотрение всех обновлений
  foreach my $update ( @{ $updates->{result} } )
  {
    # выделение из обновления сообщения
    my $upd_message = $update->{ message };
    if ( $upd_message )
    {
      # выделение из сообщения основных его характеристик: id и имя пользователя, дату сообщения
      my $user_of_message_id = $upd_message->{ from }->{ id };
      my $user_of_message_name = $upd_message->{ from }->{ first_name };
      # my $date_of_message = $upd_message->{ date };

      # конвертация даты в обычный формат
      # my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime( $date_of_message );

      # контроль появления новых пользователей через спец. хеш
      if ( $upd_message->{ new_chat_members } ) 
      {
        foreach my $new_member ( @{ $upd_message->{ new_chat_members } } ) 
        {
          my $new_member_id = $new_member->{id};
          $all_members{ $new_member_id } = 0;
        }
      }

      elsif ($all_members{ $user_of_message_id } == 0 && $upd_message->{ text }) 
      { 
        $all_members{ $user_of_message_id } = 1;
        my $ans = "Привет, " . $user_of_message_name . "!";;
        $bot->call( 'sendMessage', { chat_id => $chat_id, text => $ans } );
      }

      # контроль пользователей, покинувших группу
      if ( $upd_message->{ left_chat_member } )
        {
          my $left_member = $upd_message->{ left_chat_member };
          if ($left_member && $left_member->{ first_name })
          {
            my $left_member_name = $left_member->{ first_name };
            $bot->call('sendMessage', { chat_id => $chat_id, text => "Желаем удачи, " .  $left_member_name . "."});
          }
        }
    }
    $number_of_update = $update->{ update_id };
  }
}
