use strict;
use warnings;
use utf8;
use lib "./";
use WebProgTelegramClient;

use DBI;

my $attr = {PrintError => 0, RaiseError => 0};
my $data_source = "DBI:mysql:webprog5_melniktgbot:localhost";
my $username = "webprog5_melnik";
my $password = "2WsxcdE3";

my $dbh = DBI->connect($data_source, $username, $password, $attr);
if (!$dbh) { die $DBI::errstr; }
$dbh->do('SET NAMES cp1251');


# use Time::Local;

# объ€вление токена бота и id группы дл€ дальнейшей работы
my $token = '6066175785:AAGbPy6vKuuneCAP8XI7XC8fJAl80nfeAfQ';
my $chat_id = '-1001874774612';

# создание базовых условий: создание бота, поиск чата, задание начального значени€ id обновлени€
my $bot = WebProgTelegramClient->new( token => $token );
my $chat = $bot->call( 'getChat', {chat_id => $chat_id} );

my %all_members;
my %deadline = {1 => "13.07.2023", 2 => "15.07.2023"};
my $sth = $dbh->prepare("INSERT INTO hw_id(hw_num,deadline) VALUES (?,?)");

$sth->execute(1, $deadline{1});
$sth->execute(2, $deadline{2});

my $number_of_update = 0;

# отладочное сообщение в канал о запуске программы
# $bot->call( 'sendMessage', { chat_id => $chat_id, text => "«апуск программы" } );

# бесконечный цикл дл€ посто€нного контрол€ за изменени€ми в группе

my $updates = $bot->call( 'getUpdates', { offset => $number_of_update + 1 } );
my $group_num = 3;

# рассмотрение всех обновлений
foreach my $update ( @{ $updates->{result} } )
{
  # выделение из обновлени€ сообщени€
  my $upd_message = $update->{ message };
  if ( $upd_message )
  {
    # выделение из сообщени€ основных его характеристик: id и им€ пользовател€, дату сообщени€
    my $user_of_message_id = $upd_message->{ from }->{ id };
    my $user_of_message_name = $upd_message->{ from }->{ first_name };

    # my $date_of_message = $upd_message->{ date };

    # конвертаци€ даты в обычный формат
    # my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime( $date_of_message );
    if (!$all_members{$user_of_message_id})
    {
      $sth = $dbh->prepare("INSERT INTO student_id(student_name,group_num) VALUES (?,?)");
      $sth->execute( $user_of_message_name, $group_num );
      $all_members{$user_of_message_id} = 1;
    }
  }
  $number_of_update = $update->{ update_id };
}

