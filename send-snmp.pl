#Simple perl script to run an snmpnext towards the host provided by end user in stdin,
#uses the mib and snmp community provided by end user or else by default will use the system mib

use strict;
use Data::Dumper;
use Net::SNMP;

print "Target IP address:\n";
my $target = <STDIN>;
chomp $target;    #chomp removes newline from the variable

print "Community String:\n";
my $comm = <STDIN>;
chomp $comm;

print "OID: (default will be system-oid)\n";
my $input_oid = <STDIN>;
chomp $input_oid;

my $oid = "";

if ($input_oid eq "") {
    print "Empty\n";
    $oid = '1.3.6.1.2.1.1';
} else {
    $oid = $input_oid;
}

my ($sess, $err) = Net::SNMP->session(
    -hostname  => $target,
    -community => $comm,
    -version => '2c',
);

if (!defined $sess) {
    print "Error connecting to target ". $target . ": ". $err;
    next;
}

my $result = $sess->get_table( -baseoid => "$oid" ) || die printf("ERROR: %s.\n", $sess->error);
$sess->close;

print "Result:\n",Dumper(\$result);
