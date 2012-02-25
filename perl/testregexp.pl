#!/usr/bin/perl

use strict "vars";
my $repLaunchD="/System/Library/LaunchDaemons/";
my $plistSnmp="org.net-snmp.snmpd.plist";
my $copiePlist="copie.org.net-snmpd.plist";

opendir REPLD, "$repLaunchD" or die "Impossible d'ouvrir le répertoire $repLaunchD : $!\n";
    chdir("$repLaunchD") or die "Impossible d'ouvrir le répertoire $repLaunchD : $!\n";

    open PLIST, "<$plistSnmp" or die "Impossible d'ouvrir ou de créer le fichier $plistSnmp : $!\n";

        while (<PLIST>) { s/\<key\>Disabled\<\/key\>/\<key\>Enabled\<\/key\>/; print "$_"; }

    close PLIST;

closedir REPLD
