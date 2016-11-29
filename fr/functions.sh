#!/bin/bash

combiendetemps() {

b=`echo "$order"| cut -c13-`
cestquand
if [[ "$ladate" == "" ]]; then
return
fi

NOW=$(date +"%m/%d/%Y")
ladate=$(date -d $ladate +%m/%d/%Y)
NOW1=$(date +"%d/%m/%Y")
ladate1=$(date -d $ladate +%d" "%B" "%Y)
cestdans=$((($(date -d $ladate +%s)-$(date -d $NOW +%s))/86400))
cestjour=$(date -d $ladate +%A)


verifcestdans=`echo "$cestdans"| cut -c1`
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

cestquand () {

while read device
do
local nom="$(jv_sanitize "$device" ".*")"
local cherche="$(jv_sanitize "$b" ".*")"
if [[ "$nom" == "$cherche" ]]; then
ladate="$(echo "$pourquand" | jq -r ".devices[] | select(.nom==\"$device\") | .voiciladate")"
return
fi
done <<< "$(echo "$pourquand" | jq -r '.devices[].nom')"
echo "DÃ©solÃ©, pas de date trouvÃ© pour $b"

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

