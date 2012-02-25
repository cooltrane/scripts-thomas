#!/usr/bin/perl
# script pour afficher les infos des disques montes sur le système avec une coloration
# jaune quand on depasse les $warning (par defaut 80%) d'utilisation, et rouge quand on 
# depasse les $critical (par defaut 90%)
# 
#
# A utiliser dans geektool en ajoutant un geeklet shell 
# -> http://projects.tynsoe.org/fr/geektool/
#
# v1 -- 27 decembre 2012
# (c) thomas 27 decembre 2012
use strict "vars";

# on ouvre le resultat de la commande df avec -h pour taille en Go et -l pour les systemes montes seulement
my $chemin_rep_nsca="/opt/local/etc/";
sub mac_disque {
    open (DF, "df -hl|");
    my @disques = <DF>;
    my @mac_disques;

    shift @disques;

    foreach (@disques) {                     # on parcours les lignes et on 

        my @arguments = split;
        my $point_montage = $arguments[5];
        chomp();
        push (@mac_disques, "$point_montage\n");
    }
    close (DF);
    return @mac_disques;
}

opendir REP, $chemin_rep_nsca or die "Impossible d'ouvrir $chemin_rep_nsca : $!";
chdir($chemin_rep_nsca) or die "Impossible d'ouvrir le répertoire $chemin_rep_nsca";
open CFG, ">>send_nsca.cfg" or die "Impossible d'ouvrir send_nsca.cfg : $!";
print CFG "test toto";
close CFG;
closedir REP;
