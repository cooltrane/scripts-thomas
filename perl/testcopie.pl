#!/usr/bin/perl
use strict "vars";
use File::Copy;

my $fich1="copie.org.net-snmpd.plist";
my $fich2="toto.copie.org.net-snmpd.plist";

copy($fich1,$fich2);
