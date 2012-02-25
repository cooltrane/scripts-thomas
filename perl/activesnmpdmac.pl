#!/usr/bin/perl

use strict "vars";
use File::Copy;

my $repLaunchD="/System/Library/LaunchDaemons/";
my $plistSnmp="org.net-snmpd.plist";
my $copiePlist="copie.org.net-snmpd.plist";


sub copieplist() {
    opendir REPLD, "$repLaunchD" or die "Impossible d'ouvrir le répertoire $repLaunchD : $!\n";

    chdir("$repLaunchD") or die "Impossible d'ouvrir le répertoire $repLaunchD : $!\n";
    copy($plistSnmp,$copiePlist); 
    if (-e $plistSnmp) {
        unlink $plistSnmp if (-e $copiePlist);
    }
    open COPIE, "<$copiePlist" or die "Impossible d'ouvrir le fichier $copiePlist : $!\n"; 
    open PLIST, ">>$plistSnmp" or die "Impossibe d'ouvrir le fichier $plistSnmp : $!\n";

    while (<COPIE>) { s/Disabled/Enabled/; print PLIST "$_"; }

    close PLIST;
    close COPIE;
    closedir REPLD;
}
&copieplist();
