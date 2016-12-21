#!/bin/bash


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
local cestpassemois=$(date -d "$ladate" +%m) # mois de la date à vérifier
local cestmois=$(date -d "$NOW" +%m) # mois en cours
testlemois

	if  [[ "$etcest" == "0" ]]; then
	echo "$nomann fÃªtes ses $arbre an aujoud'hui ! Bon Anniversaire !!!"
	return
	fi

	echo "C'est le $cestjour $ladate1"

	if [[ "$cestpassemois" -le "$cestmois" ]]; then
		if [[ "$arbre" == 0 ]]; then
		echo "c'est passÃ© il y a $etcest jours"
		else
		echo "$nomann a dÃ©ja fÃªtÃ© ses $arbre ans il y a $etcest jours"
		fi
		return
	else
		echo "$nomann fÃªtes ses $arbre ans dans $etcest jours"
		return
	fi

fi

	if [[ "$cestdans" == "0" ]]; then
	echo "$b, c'est le $ladate1"
	echo "C'est aujoud'hui !"
	else
	echo "$b, c'est le $cestjour $ladate1"
	echo "C'est dans $cestdans jour"
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
echo "DÃ©solÃ©, pas de date trouvÃ© pour $b"
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
ladate1=$(date -d $ladate +%d" "%B" "%Y)
cestjour=$(date -d $ladate +%A)
local date1=$(date -d "$NOW" +%Y) # l'année en cours
local date2=$(date -d "$ladate" +%Y) # année de la date à vérifier
local arbre=`echo "$date1 - $date2" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`



if [[ "$NOWMois"  == "$ladateMois" ]]; then
	if [[ "$NOWJour" < "$ladateJour" ]]; then
		if [[ "$arbre" = "0" ]]; then
		nbrtour=`echo "$nbrtour + 1" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		dirtour="le $cestjour $ladate1 et c'est $leNOM...$dirtour"
		else
		nbrtour=`echo "$nbrtour + 1" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		resultprochain=`echo "$ladateJour - $NOWJour" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		dirtour="le $cestjour $ladate1 soit dans $resultprochain jours et ca serra $leNOM qui aura $arbre ans... $dirtour"
		fi
	fi
	
fi
done <<< "$(echo "$cestpourquand" | jq -r '.devices[].nom')"
if [[ "$nbrtour"  == "0" ]]; then
echo "il n'y a rien pour ce mois-ci..."
else
echo "pour ce mois-ci, il y a $nbrtour dates: $dirtour"
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

