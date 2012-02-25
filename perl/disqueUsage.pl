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

open (DF, "df -hl|");
my @disques = <DF>;
my $warning = 80;
my $critical = 90;

# on initialise les variables pour coloriser le texte
my $ROUGE="\e[31m";
my $VERT="\e[32m";
my $JAUNE="\e[33m";
my $NOCOLOR="\e[0m";			 # ne pas oublier celle là pour arrêter la 
					 # colorisation. Il semble qu'en terminal
					 # on puisse ommettre le 0 mais pas pour geektool

shift @disques; 			 # on enleve la premiere ligne qui
					 # contient les etiquettes
foreach (@disques) { 			 # on parcours les lignes et on 
					 # initialises les variables en remplacant 
					 # les "Gi" americains par des "Go" bien francais
	my @arguments = split;
	my $taille = $arguments[1]; $taille =~ s/Gi/Go/g;
	my $utilise = $arguments[2]; $utilise =~ s/Gi/Go/g;
	my $disponible = $arguments[3]; $disponible  =~ s/Gi/Go/g;
	my $capacite = $arguments[4];
	my $point_montage = $arguments[5];

	$point_montage =~ s#/Volumes/##; # on enleve le chemin avant le nom du disque
	$capacite =~ s/\%//; 		 # on supprime le % à la fin de capacite pour 
					 # pouvoir le traiter comme un nombre dans les 
					 # comparaisons qui vont suivre pour la 
					 # colorisation


	chomp();
	if ($capacite >= $critical) {           # si on depasse 90% d'utilisation en ROUGE
		$point_montage = ${ROUGE}.$point_montage.$NOCOLOR;
		$utilise = ${ROUGE}.$utilise.${NOCOLOR};
	}
	elsif ($capacite >= $warning) {        # si on depasse 80% en JAUNE 
					 # (dans cet ordre sinon tout est jaune)
		$point_montage = ${JAUNE}.$point_montage.$NOCOLOR;
		$utilise = ${JAUNE}.$utilise.${NOCOLOR};
	}
	else {}
	print "$point_montage : total : $taille -- utilise : $utilise -- libre : $disponible  utilisation de $capacite \%\n";
	
	}
close (DF);
