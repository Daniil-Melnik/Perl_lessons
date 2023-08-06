use strict;
use warnings;
use lib "./";
use WebProgTelegramClient; 
use DBI;
use Encode qw(decode encode);

use Time::Local;
use DateTime;
use utf8;

my $token = '6164752146:AAHybXJiUKBnL6f5MRv-Hf7g8i574BW9Te4';
my $chat_id = '-1001971059114';

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


my $all_models_1 = "/ascot_bailey_S200\n
/berkley_kingfisher\n
/cossack\n
/culver_empire\n/culver_empire_police_special\n/culver_empire_detective_special\n
/delizia_grandeamerica\n/delizia_410_grand_america\n
/gai_353_military_truck\n
/hank_b\n/hank_b_fuel_tank\n
/houston_wasp\n
/isw_508\n
/jefferson_provincial\n/jefferson_futura\n
/lassiter_series_69\n/lassiter_series_69_detective_special\n/lassiter_series_75\n
/parry_city_bus\n/police_bus\n
/potomac_indian\n/potomac_elysium\n
/quicksilver_windsor\n/quicksilver_windsor_taxi\n
/roller_GL300\n
/shubert_series_AB\n/shubert_38\n/shubert_38_taxi\n/shubert_38_panel_truck\n/shubert_38_hearse\n/shubert_pickup\n/shubert_pickup_hot_rod\n/shubert_lkv\n/shubert_snow_plow\n/shubert_armored_truck\n/shubert_beverly\n/shubert_frigate\n
/sicily_military_truck\n
/smith_v8\n/smith_coupe\n/smith_custom_200\n/smith_custom_200_police_spec\n/smith_mainline\n/smith_deluxe_station_wagon\n/smith_34_hot_rod\n/smith_thunderbolt\n/smith_truck\n
/walker_rocket\n
/walter_coupe\n/walter_hot_rod\n/walter_utility\n/walter_military\n
/waybar_hot_rod\n
/milk_truck\n";


my $all_models_2 = "/ascot_bailey_S200\n
/berkley_kingfisher\n
/cossack\n
/culver_empire\n/culver_empire_police_special\n
/delizia_410_grand_america\n
/houston_wasp\n
/isw_508\n
/jefferson_provincial\n/jefferson_futura\n
/lassiter_series_69\n/lassiter_series_75\n
/potomac_indian\n/potomac_elysium\n
/quicksilver_windsor\n/quicksilver_windsor_taxi\n
/roller_GL300\n
/shubert_series_AB\n/shubert_38\n/shubert_38_taxi\n/shubert_38_panel_truck\n/shubert_38_hearse\n/shubert_pickup\n/shubert_pickup_hot_rod\n/shubert_lkv\n/shubert_snow_plow\n/shubert_armored_truck\n/shubert_beverly\n/shubert_frigate\n
/smith_v8\n/smith_coupe\n/smith_custom_200\n/smith_custom_200_police_spec\n/smith_mainline\n/smith_deluxe_station_wagon\n/smith_34_hot_rod\n/smith_thunderbolt\n/smith_truck\n
/walker_rocket\n
/walter_coupe\n/walter_hot_rod\n/walter_utility\n/walter_military\n
/waybar_hot_rod\n
/milk_truck\n";


my $all_models_3 = "/ascot_bailey_S200\n
/berkley_kingfisher\n
/cossack\n/culver_empire\n/culver_empire_police_special\n
/delizia_410_grand_america\n
/houston_wasp\n
/isw_508\n/jefferson_provincial\n/jefferson_futura\n
/lassiter_series_69\n/lassiter_series_75\n
/potomac_indian\n/potomac_elysium\n
/quicksilver_windsor\n/quicksilver_windsor_taxi\n
/roller_GL300\n
/shubert_series_AB\n/shubert_38\n/shubert_38_taxi\n/shubert_38_panel_truck\n/shubert_38_hearse\n/shubert_pickup\n/shubert_pickup_hot_rod\n/shubert_lkv\n/shubert_snow_plow\n/shubert_armored_truck\n/shubert_beverly\n/shubert_frigate\n/smith_v8\n/smith_coupe\n/smith_custom_200\n/smith_custom_200_police_spec\n/smith_mainline\n/smith_deluxe_station_wagon\n/smith_34_hot_rod\n/smith_thunderbolt\n
/walker_rocket\n/walter_coupe\n/walter_hot_rod\n/walter_utility\n/walter_military\n/waybar_hot_rod\n
/milk_truck\n";


open(my $fh, '<:encoding(UTF-8)', 'date.txt');
my $last_time = <$fh>;

my $usage_indicator = 1;

$bot->call( 'sendMessage', { chat_id => $chat_id, text => "Для открытия списка автомобилей нажмите /list\nДля выхода нажмите /stop" } );

while ($usage_indicator == 1)
{
  my $updates = $bot->call( 'getUpdates', { offset => $number_of_update + 1 } );
  if ($updates)
  {
    my $print_adding_message = 0;
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
          if ($date_of_message > $last_time)
          {
            print ($date_of_message  . $last_time);
            my @message_command = split('@', $message_text);
            if ($message_command[0] eq "/list")
            {
              $bot->call( 'sendMessage', { chat_id => $chat_id, text => $all_models_3 } );
              $print_adding_message = 0;
            }

            elsif ($message_command[0] eq "/stop")
            {
              $usage_indicator = 0;
              print "stopped";
            }

            else
            {
              # print ($date_of_message);
              my $sql = "SELECT name, discription, url FROM auto WHERE comand = ?";
              my $sth = $dbh->prepare($sql);

              # execute the query
              $sth->execute($message_command[0]);

              while(my @row = $sth->fetchrow_array()){

                open(my $fh, '>', 'text.txt') or die;
                print $fh $row[1];
                close $fh;
                
                open(InFile, '<:encoding(UTF-8)', "text.txt");
                my $res_line = $row[0] . "\n\n";
                while (my $line = <InFile>)
                {
                  print $ line ;
                  $res_line = $res_line . $line;
                }
                $bot->call( 'sendMessage', { chat_id => $chat_id, text => $res_line } );
                $bot->call( 'sendPhoto', { chat_id => $chat_id, photo => $row[2] } );
                close ( InFile );
              }
              $sth->finish();
              $print_adding_message = 1;
            }
            open(my $fh, '>', 'date.txt') or die;
            print $fh $date_of_message; 
          }
        } 
      }

      $number_of_update = $update->{ update_id };
    }
    if ($print_adding_message == 1)
    {
      $bot->call( 'sendMessage', { chat_id => $chat_id, text => "Для открытия списка автомобилей нажмите /list\nДля выхода нажмите /stop" } );
    }
  }

  print ".";
}
