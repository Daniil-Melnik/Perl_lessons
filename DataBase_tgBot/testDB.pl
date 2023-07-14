use strict;
use warnings;
use DBI;

my $attr = {PrintError => 0, RaiseError => 0};
my $data_source = "DBI:mysql:webprog5_melniktgbot:localhost";
my $username = "webprog5_melnik";
my $password = "2WsxcdE3";
print "ok0\n";
my $dbh = DBI->connect($data_source, $username, $password, $attr);
print "ok1\n";
if (!$dbh) { die $DBI::errstr; }
print "ok2\n";
$dbh->do('SET NAMES cp1251');

my $rv = $dbh->selectall_arrayref('SHOW TABLES');

foreach my $db (@$rv)
{
    print @$db;
}

my $sth = $dbh->prepare("INSERT INTO student_id(student_name,group_num) VALUES (?,?)");
print "ok3\n";
$sth->execute( 2107, 20 );
print "ok4\n";

die "end";