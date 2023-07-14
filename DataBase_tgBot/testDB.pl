use DBI;

# Подключение к БД
my $attr = {PrintError => 0, RaiseError => 0};
my $data_source = "DBI:mysql:<db_name>:localhost";
my $username = "db_username";
my $password = "db_password";
my $dbh = DBI->connect($data_source, $username, $password, $attr);
if (!$dbh) { die $DBI::errstr; }
$dbh->do('SET NAMES cp1251');


# Выполнение запроса к БД
my $rv = $dbh->selectrow_arrayref('SHOW TABLES');

die Dumper($rv);
