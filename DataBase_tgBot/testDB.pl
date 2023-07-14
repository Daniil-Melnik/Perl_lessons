use DBI;

# Подключение к БД
my $attr = {PrintError => 0, RaiseError => 0};
my $data_source = "DBI:mysql:webprog5_melniktgbot:localhost";
my $username = "melnik";
my $password = "2WsxcdE3";
print "ok0\n";
my $dbh = DBI->connect($data_source, $username, $password, $attr);
print "ok1\n";
if (!$dbh) { die $DBI::errstr; }
print "ok2\n";
$dbh->do('SET NAMES cp1251');


# Выполнение запроса к БД
my $rv = $dbh->selectrow_arrayref('SHOW TABLES');

die Dumper($rv);
