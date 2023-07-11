use strict;
use warnings;
use utf8;
BEGIN{ unshift @INC, "./" };
use FindBin;
use lib $FindBin::Bin;
use WebProgTelegramClient;

print "flag 1";

#хеш в которые будет добавлять пару ключ/значение  уникального пользователя, проверка гита
my %users;
 
my $token = '6066175785:AAGbPy6vKuuneCAP8XI7XC8fJAl80nfeAfQ';
my $chat_id = '-1001912609456';

my $bot = WebProgTelegramClient->new( token => $token );
my $chat = $bot->call('getChat', {chat_id => $chat_id});
my $number_of_update = 0;

$bot->call('sendMessage', { chat_id => $chat_id, text => "Запуск программы." });

while (1)
{
    my $updates = $bot->call('getUpdates', offset => $number_of_update + 1);
    
}

# my $last_update_id = 0;

# while (1) 
# {
#     print ".\n";
#   # получаем последнее обновление
#   my $updates = $tg->call('getUpdates', { offset => $last_update_id + 1 } );

#   foreach my $update ( @{$updates->{result}} )
#   {
#     # сюда запищи месендж
#     my $message = $update->{ message };

#     if( $message )
#     {
#       my $user_id = $message->{ from }->{ id };
#       my $user_name = $message->{ from }->{ first_name };
       
#         if ( $message->{ new_chat_members } ) 
#         {
#           foreach my $new_member ( @{$message->{ new_chat_members }} ) 
#           {
#             # Получаем id нового участника чата
#             my $new_member_id = $new_member->{ id };
#               # добавляем в хеш id  участника с значением "0";
#               $users{ $new_member_id } = 0;
#           }
#         }
#         # Проверяем в хеше равно ли значение участника - "0", проверка на уникальность сообщения участника
#         elsif ( $users{ $user_id } == 0 && $message->{ text } ) 
#         { 
#           # Присваевыем новое значение в хеш
#           $users{ $user_id } = 1;
#           my $response = "Привет, $user_name!";
#           $tg->call( 'sendMessage', { chat_id => $chat_id, text => $response } );
#         }

#         # Информация о пользователе, удалённом из группы
#         if( $message->{ left_chat_member } )
#         {
#           # Получаем юзера который вышел 
#           my $came_out_user = $message->{ left_chat_member };
#           # проверяем вышел ли кто-то из чата 
#           if ( $came_out_user && $came_out_user->{ first_name } )
#           {
#             my $first_name = $came_out_user->{ first_name };
#             my $chat_id = $message->{ chat }->{ id };
#             my $response = "желаем удачи, $first_name!, ";
#             # отправляем сообщение в чат 
#             $tg->call('sendMessage', { chat_id => $chat_id, text => $response });
#           }
#         }
#       }

#     $last_update_id = $update->{ update_id };

#   }

# }



# my $cl = WebProgTelegramClient->new( 'token' => '6066175785:AAGbPy6vKuuneCAP8XI7XC8fJAl80nfeAfQ' );
# $cl->sendMessage(chat_id => -1001912609456, text => 'Hello world!');

# print "ok";