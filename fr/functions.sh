#!/bin/bash

# bash plugins/jarvis-cestquand/verifdate1.sh

prochainevenement123() {
vardateprochain="plugins/jarvis-cestquand/dateprochaine.txt"
if [ -f "$vardateprochain" ]; then
echo "Ok il existe le fichier........"
# variable=`grep xferErrs $vardateprochai | cut -d"," -f1`

variablecompte=`grep -o , $vardateprochain|wc -l`
variable=`grep , $vardateprochain`
variablecut=`echo $variable |cut -d"," -f1`
say "Attention... il y a un évenement $variablecut"
curl "http://192.168.0.17:8087?order=c'est quand $variablecut"

# fichier existe
# compte le nombre de variable et prononce l'anniversaire par repérage de virgule
else
echo "Fichier existe pas....."
b=$(date -d "$ladate" +%m) # mois de la date à vérifier
nbrtour=0
dirtour=""
while read device
do
nom="$(jv_sanitize "$device" ".*")"
cherche="$(jv_sanitize "$b" ".*")"
ladate="$(echo "$cestpourquand" | jq -r ".devices[] | select(.nom==\"$device\") | .voiciladate")"
leNOM="$(echo "$cestpourquand" | jq -r ".devices[] | select(.nom==\"$device\") | .nom")"
ladateMois=`echo $ladate | cut -d"/" -f1`
ladateJour=`echo $ladate | cut -d"/" -f2`
NOW=$(date +"%m/%d/%Y")
NOWMois=$(date +"%m")
NOWJour=$(date +"%d")
ladate1=$(date -d $ladate +%d" "%B" ")
cestjour=$(date -d $ladate +%A)
date1=$(date -d "$NOW" +%Y) # l'année en cours
date2=$(date -d "$ladate" +%Y) # année de la date à vérifier
arbre=`echo "$date1 - $date2" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`

echo "----- $leNOM --$NOWMois--$ladateMois-"

if [[ "$NOWMois"  == "$ladateMois" ]]; then

	if [[ "$NOWJour" < "$ladateJour" ]]; then
		if [[ "$arbre" = "0" ]]; then
		nbrtour=`echo "$nbrtour + 1" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		enregdateprochaine="$leNOM..."
		else
		nbrtour=`echo "$nbrtour + 1" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		enregdateprochaine=("$leNOM, $enregdateprochaine")
		fi

		if [[ "$nbrtour" = "2" ]]; then	
		return
		fi
	fi


fi


done <<< "$(echo "$cestpourquand" | jq -r '.devices[].nom')"
#----------------------
echo "$enregdateprochaine" > $vardateprochain
echo "Fin du calcul il y a $enregdateprochaine"

if [[ "$nbrtour"  == "0" ]]; then
enregdateprochaine=""
fi

fi
}


prochainevenement() {
b=$(date -d "$ladate" +%m) # mois de la date à vérifier
nbrtour=0
dirtour=""
# NOW="03/01/2016"
# NOWMois="03"
# NOWJour="01"
cestpourquandprochain
}


combiendetemps() {
b=`echo "$order"| cut -c13-`
cestpourquand
if [[ "$ladate" == "" ]]; then
return
fi
combiendetempsdate
combiendetempscestpour
}

combiendetempsdate() {
NOW=$(date +"%m/%d/%Y")
ladate=$(date -d $ladate +%m/%d/%Y)
NOW1=$(date +"%d/%m/%Y")
ladate1=$(date -d $ladate +%d" "%B" "%Y)
cestdans=$((($(date -d $ladate +%s)-$(date -d $NOW +%s))/86400))
cestjour=$(date -d $ladate +%A)
verifcestdans=`echo "$cestdans"| cut -c1`
}

combiendetempscestpour() {
if  [[ "$verifcestdans" == "-" ]]; then
nomann=`echo "$order"| cut -c31-`
cestdans=$((($(date -d $ladate +%s)-$(date -d $NOW +%s))/86400)) 
local date1=$(date -d "$NOW" +%Y) # l'année en cours
local date2=$(date -d "$ladate" +%Y) # année de la date à vérifier
local date3=$(date -d "$ladate" +%m/%d/$(date -d "$NOW" +%Y)) # configuration date pour soustraction
local arbre=`echo "$date1 - $date2" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"` # Résultat par soustraction des 2 dates afin d'avoir son age
local etcest=$((($(date -d $NOW +%s)-$(date -d $date3 +%s))/86400)) # Résultat par soustraction pour nbr de jour restant
# correction de 2 à un chiffre"
cestpassemois=$(date -d "$NOW" +%m) # mois en cours
local cestpassejour=$(date -d "$NOW" +%d) # jour en cours
local cestpasslejour=$(date -d "$ladate" +%d) # jour de la date à vérifier

testlemois
local cestmois=$cestpassemois
# Ok

local cestpassemois=$(date -d "$ladate" +%m) # mois de la date à vérifier
testlemois


	if  [[ "$etcest" == "0" ]]; then
	say "$nomann fêtes ses $arbre an aujoud'hui ! Bon Anniversaire !!!"
	return
	fi

	say "C'est le $cestjour $ladate1"

	if [[ "$cestpassemois" -le "$cestmois" ]]; then

		if [[ "$arbre" == 0 ]]; then
		say  "c'est passé il y a $etcest jours"
		fi

	        if [[ "$cestpasslejour" -le "$cestpassejour" ]]; then
		# mettre ici si passé ou si ca va arriver !!
                # c"est passé jour date est plus petit que maintenant
		say "$nomann a déja fêté ses $arbre ans il y a $etcest jours"
		fi

		if [[ "$cestpasslejour" -gt "$cestpassejour" ]]; then
                # ce n'est pas passé jour date est plus grand que maintenant
		local etcestp=`echo $etcest | sed "s/-//g"`
		say "$nomann fêtes ses $arbre ans dans $etcestp jours"
		fi
		return
	fi

fi

	if [[ "$cestdans" == "0" ]]; then
	say  "$b, c'est le $ladate1, c'est aujoud'hui !"
	else
	say  "$b, c'est le $cestjour $ladate1, c'est dans $cestdans jour"
	fi
}

cestpourquand() {
while read device
do
local nom="$(jv_sanitize "$device" ".*")"
local cherche="$(jv_sanitize "$b" ".*")"
if [[ "$nom" == "$cherche" ]]; then
ladate="$(echo "$cestpourquand" | jq -r ".devices[] | select(.nom==\"$device\") | .voiciladate")"
return
fi
done <<< "$(echo "$cestpourquand" | jq -r '.devices[].nom')"
say "Désolé, pas de date trouvé pour $b"
}



cestpourquandprochain() {
while read device
do
local nom="$(jv_sanitize "$device" ".*")"
local cherche="$(jv_sanitize "$b" ".*")"
ladate="$(echo "$cestpourquand" | jq -r ".devices[] | select(.nom==\"$device\") | .voiciladate")"
leNOM="$(echo "$cestpourquand" | jq -r ".devices[] | select(.nom==\"$device\") | .nom")"
ladateMois=`echo $ladate | cut -d"/" -f1`
ladateJour=`echo $ladate | cut -d"/" -f2`
NOW=$(date +"%m/%d/%Y")
NOWMois=$(date +"%m")
NOWJour=$(date +"%d")
ladate1=$(date -d $ladate +%d" "%B" ")
cestjour=$(date -d $ladate +%A)
local date1=$(date -d "$NOW" +%Y) # l'année en cours
local date2=$(date -d "$ladate" +%Y) # année de la date à vérifier
local arbre=`echo "$date1 - $date2" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`


if [[ "$NOWMois"  == "$ladateMois" ]]; then

	if [[ "$NOWJour" < "$ladateJour" ]]; then
		if [[ "$arbre" = "0" ]]; then
		nbrtour=`echo "$nbrtour + 1" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		say "le $cestjour $ladate1 et c'est $leNOM..."
		else
		nbrtour=`echo "$nbrtour + 1" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		resultprochain=`echo "$ladateJour - $NOWJour" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		say "le $cestjour $ladate1 dans $resultprochain jours et ça sera les $arbre ans de $leNOM."
		fi

		if [[ "$nbrtour" = "2" ]]; then	
		return
		fi

	fi
	
fi
done <<< "$(echo "$cestpourquand" | jq -r '.devices[].nom')"

if [[ "$nbrtour"  == "0" ]]; then
say "il n'y a rien pour ce mois-ci..."
fi
	
}


testlemois() {

if [[ "$cestpassemois" == "01" ]]; then
cestpassemois=1
return
fi

if [[ "$cestpassemois" == "02" ]]; then
cestpassemois=2
return
fi

if [[ "$cestpassemois" == "03" ]]; then
cestpassemois=3
return
fi

if [[ "$cestpassemois" == "04" ]]; then
cestpassemois=4
return
fi

if [[ "$cestpassemois" == "05" ]]; then
cestpassemois=5
return
fi

if [[ "$cestpassemois" == "06" ]]; then
cestpassemois=6
return
fi

if [[ "$cestpassemois" == "07" ]]; then
cestpassemois=7
return
fi

if [[ "$cestpassemois" == "08" ]]; then
cestpassemois=8
return
fi


if [[ "$cestpassemois" == "09" ]]; then
cestpassemois=9
return
fi
return
}


