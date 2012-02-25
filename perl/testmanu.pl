#!/usr/bin/perl
use strict "vars";
sub totorename {
    foreach (@_) {
            my $nomfichier = $_; 
            my $nouveauNomfichier = $nomfichier;
            $nouveauNomfichier =~ s/([^.]*)\.csv/new_$1\.csv/; 
        }
}

sub totocsv(){
    while (<>) {
        my $ligne = $_;
        $ligne =~ s/;/,/g;
        }
}

foreach (@_) {
    my $nomfichier = shift @_;
    my $newnomfichier = &totorename("$nomfichier");
    print "le nom du fihcier est $nomfichier le nouveau nom est $newnomfichier\n";
}
