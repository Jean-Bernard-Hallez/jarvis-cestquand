#!/bin/bash
# ---------------------------------

jv_pg_ct_queljourdesemaine() {
echo "$order"
# ladate1=$(date -d "2/2/2017" +%A)
#echo "$ladate1"
}

jv_pg_ct_prochainevenement() {
b=$(date -d "$ladate" +%m) # mois de la date à vérifier
nbrtour=0
dirtour=""
# NOW="03/01/2016"
# NOWMois="03"
# NOWJour="01"
cestpourquandprochain
}


jv_pg_ct_combiendetemps() {
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
local etcest=`echo $((($(date -d $NOW +%s)-$(date -d $date3 +%s))/86400)) | sed "s/-//g"`
 # Résultat par soustraction pour nbr de jour restant

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

	say  "$b, c'est le $cestjour $ladate1, c'est dans $etcest jour "
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
local adirej=""
local ajourdhui=""


if [[ "$NOWMois"  == "$ladateMois" ]]; then


	if [ "$NOWJour" -le "$ladateJour" ]; then

resultprochain=`echo "$ladateJour - $NOWJour" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`

#		if [[ "$arbre" == "1" ]]; then
		if [ "$resultprochain" = "0" ]; then
		nbrtour=`echo "$nbrtour + 1" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		ajourdhui="Ok"
		say "C'est aujourd'hui et c'est $leNOM..."
		else
		nbrtour=`echo "$nbrtour + 1" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		resultprochain=`echo "$ladateJour - $NOWJour" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		say "le $ladate $lenom dans $resultprochain jours et ça sera les $arbre ans de $leNOM."
		fi

		if [[ "$nbrtour" = "2" ]]; then	
		return
		fi

	fi
	
fi

if [ "$NOWMois" -lt "$ladateMois" ]; then
		nbrtour=`echo "$nbrtour + 1" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		adirej="Prochain évènement pas avant le $ladate1 pour $leNOM."
	if [[ "$nbrtour" = "1" ]]; then	
	say "il n'y a rien pour ce mois-ci... $adirej"
	return
	fi
fi


done <<< "$(echo "$cestpourquand" | jq -r '.devices[].nom')"
if [[ "$nbrtour" == "0" ]]; then
say "il n'y a rien pour ce mois-ci... $adirej"
return
fi

if [[ "$adirej"  != " " ]] && [[ "$ajourdhui"  != "" ]]; then
say "il n'y a rien pour ce mois-ci... $adirej"
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


