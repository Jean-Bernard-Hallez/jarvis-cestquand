#!/bin/bash
# ---------------------------------
jv_pg_ct_chainenumerique() {
[ $maman1 -eq 0 ] 2> /dev/null 
if [ $? -eq 0 -o $? -eq 1 ] 
then 
chainenum="Ok" 
else
chainenum=""
fi 

}

jv_pg_ct_lejourdelasemainecest() {

# echo il était une fois | sed 's/il était/ /g'
maman1=`echo "$maman" | cut -f 1 -d ' '`

jv_pg_ct_chainenumerique
if [[ "$chainenum" == "Ok" ]]; then
maman1=`echo "$maman" | cut -f 1 -d ' '`
maman2=`echo "$maman" | cut -f 2 -d ' '`
maman3=`echo "$maman" | cut -f 3 -d ' '`
if [[ "$maman3" = "" ]]; then
maman3=`date +%Y`
fi
else 

maman1=`echo "$maman" | cut -f 2 -d ' '`
jv_pg_ct_chainenumerique
if [[ "$chainenum" == "Ok" ]]; then
maman1=`echo "$maman" | cut -f 2 -d ' '`
maman2=`echo "$maman" | cut -f 3 -d ' '`
maman3=`echo "$maman" | cut -f 4 -d ' '`
if [[ "$maman3" = "" ]]; then
maman3=`date +%Y`
fi
else

maman1=`echo "$maman" | cut -f 3 -d ' '`
jv_pg_ct_chainenumerique
if [[ "$chainenum" == "Ok" ]]; then
maman1=`echo "$maman" | cut -f 3 -d ' '`
maman2=`echo "$maman" | cut -f 4 -d ' '`
maman3=`echo "$maman" | cut -f 5 -d ' '`
if [[ "$maman3" = "" ]]; then
maman3=`date +%Y`
fi
else

say "impossible de trouver une date dans votre formule"
return

fi; fi; fi

testlemoisinverse

ladate1=$(date -d "$cestpassemois/$maman1/$maman3" +%A)

if [[ "$cestpassemois" != "" ]]; then


say "le $maman1 $cestpassemoisd $maman3 c'est un $ladate1 "
fi



}


jv_pg_ct_combiendetemps() {
b=`echo "$order"| cut -c13-`
cestpourquand

if [[ "$ladate" == "" ]]; then
say "Désolé je n'ai rien trouvé pour $b"
return
fi
combiendetempsdate
combiendetempscestpour

	
}

cestpourquand() {

chemin=${PWD}"/plugins/jarvis-cestquand"
btotal=`echo $b | grep " " | wc -w`
bb=`echo "$b" | cut -d' ' -f$(( $btotal - 1 ))-`
bb=`jv_sanitize "$bb"`
lignetotal=`grep -c '#---#'  $chemin/config.sh`

while test  "$lignenumero" != "$lignetotal"

do
lignenumero=$(( $lignenumero + 1 ))
ligne=`grep '#---#'  $chemin/config.sh | sed -e "s/#---# //g" | sed -e "s/#//g" | sed -n $lignenumero\p`
ligne=`jv_sanitize "$ligne"`
	
	if [[ "$ligne" =~ "$bb" ]]; then 
	leNOM=`echo $ligne | cut -c12-`
	ladateJour=`echo $ligne | cut -c1-2`
	ladateMois=`echo $ligne | cut -c3-4`
	ladateAnnee=`echo $ligne | cut -c5-8`
	ladate="$ladateMois/$ladateJour/$ladateAnnee"
	fi

if [ "$lignenumero" -gt "$lignetotal" ]; then
return
fi

done

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
nomann=`jv_sanitize "$order"| cut -c29-`
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

#	say "C'est le $cestjour $ladate1"

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



jv_pg_ct_prochainevenement() {
chemin=${PWD}"/plugins/jarvis-cestquand"
NOW=$(date +"%m/%d/%Y")
NOWJour=$(date +"%d")
NOWMois=$(date +"%m")
NOWANNEE=$(date -d "$NOW" +%Y) # l'année en cours
MoisProchain=$(date -d "month" +"%m")

lignemoi=`grep '#---# '   $chemin/config.sh | sed -e "s/#//g" | grep -n '/'$NOWMois'/'`
ligneprochain=`grep '#---# '   $chemin/config.sh | sed -e "s/#//g" | grep -n '/'$MoisProchain'/'`
lignetotalmoiencours=`grep '#---# '   $chemin/config.sh | sed -e "s/#//g" | grep -c '/'$NOWMois'/'`
lignetotalprochain=`grep '#---# '   $chemin/config.sh | sed -e "s/#//g" | grep -c '/'$MoisProchain'/'`

# Je vérifie si il y aura des anniversaire ce moi ci:
if [ "$lignetotalmoiencours" = "0" ]; then
say "il n'y a rien pour ce mois-ci... "
cestpourquandprochainmoi
return
fi



while test  "$num" != "$lignetotalmoiencours"
num=$(($num + 1))

do

ligne=`grep '#---# '  $chemin/config.sh | grep '/'$NOWMois'/' | sed -e "s/#---# //g" | sed -e "s/#//g" | sed -n $num\p`
leNOM=`echo $ligne | cut -c12-`
ladateJour=`echo $ligne | cut -c1-2`
ladateMois=`echo $ligne | cut -c4-5`
ladateAnnee=`echo $ligne | cut -c7-10`
ladate="$ladateMois/$ladateJour/$ladateAnnee"
ladateMoisEntier=`date -d "$ladate" +"%B"`
ladatejourEntier=`date -d "$ladate" +"%A"`

local arbre=`echo "$NOWANNEE - $ladateAnnee" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"` # Résultat par soustraction des 2 dates afin d'avoir son age



# Je vérifie si le jour d'aujourd'hui est bien plus petit de jour date anniversaire

if [ "$NOWJour" -le "$ladateJour" ]; then # si aujourd'hui < ou = le jour recherché dans config

		resultprochain=`echo "$ladateJour - $NOWJour" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`

		if [ "$resultprochain" = "0" ]; then
		ajourdhui="Ok"
		say "C'est aujourd'hui et c'est $leNOM..."
		echo "1" > $jv_dir/plugins/jarvis-cestquand/riencemoici.txt
		else
			if [ "$arbre" = "0" ]; then
			resultprochain=`echo "$ladateJour - $NOWJour" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
			say "le $ladatejourEntier $ladateJour $ladateMoisEntier $lenom dans $resultprochain jours et ç'est pour $leNOM."
			echo "Ok" > $jv_dir/plugins/jarvis-cestquand/riencemoici.txt
			
			else
				resultprochain=`echo "$ladateJour - $NOWJour" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
				say "le $ladatejourEntier $ladateJour $ladateMoisEntier $lenom dans $resultprochain jours et ça sera les $arbre ans de $leNOM."
				echo "Ok" > $jv_dir/plugins/jarvis-cestquand/riencemoici.txt
			fi
			
		fi

fi

if [ "$num" -ge "$lignetotalmoiencours" ]; then
	if [ "$resultprochain" = "" ]; then
	say "il n'y a rien pour ce mois-ci... "
	num=""
	cestpourquandprochainmoi
	# return
	fi
return
fi
done




}


cestpourquandprochainmoi() {
# Je vérifie si il y aura des anniversaire le moi prochain:
if [ "$lignetotalprochain" = "0" ]; then
say "il n'y a rien pour le mois prochain désolé... "
# Voir quand le prochain evènement !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
return
fi

NOWJour="1"

while test  "$num" != "$lignetotalprochain"
num=$(($num + 1))
do


ligne=`grep '#---# '  $chemin/config.sh | grep '/'$MoisProchain'/' | sed -e "s/#---# //g" | sed -e "s/#//g" | sed -n $num\p`
leNOM=`echo $ligne | cut -c12-`
ladateJour=`echo $ligne | cut -c1-2`
ladateMois=`echo $ligne | cut -c4-5`
ladateAnnee=`echo $ligne | cut -c7-10`
ladate="$ladateMois/$ladateJour/$ladateAnnee"
ladate2="$ladateMois/$ladateJour/`date +"%Y"`"
ladateMoisEntier=`date -d "$ladate" +"%B"`
ladatejourEntier=`date -d "$ladate" +"%A"`
local arbre=`echo "$NOWANNEE - $ladateAnnee" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"` # Résultat par soustraction des 2 dates afin d'avoir son age
local etcest=`echo $((($(date -d $NOW +%s)-$(date -d $ladate2 +%s))/86400)) | sed "s/-//g"`  # Résultat en nombre de jour 

# Je vérifie si le jour d'aujourd'hui est bien plus petit de jour date anniversaire
if [[ "$NOWJour" -le "$ladateJour" ]]; then # si aujourd'hui < ou = le jour recherché dans config
		resultprochain=`echo "$ladateJour - $NOWJour" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`

		if [ "$resultprochain" = "0" ]; then
		ajourdhui="Ok"
		say "C'est aujourd'hui et c'est $leNOM..."
		echo "1" > $jv_dir/plugins/jarvis-cestquand/riencemoici.txt
		else

			resultprochain=`echo "$ladateJour - $NOWJour" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
			say "le $ladatejourEntier $ladateJour $ladateMoisEntier $lenom dans $etcest jours et ça sera les $arbre ans de $leNOM."
			echo "Ok" > $jv_dir/plugins/jarvis-cestquand/riencemoici.txt
		fi

fi

if [ "$num" -ge "$lignetotalprochain" ]; then
return
fi

done

}

atrier() {
ligne=`grep '#---# '  $chemin/config.sh | sed -n $num\p |  sed -e "s/#---# //g" | sed -e "s/#//g"`
leNOM=`echo $ligne | cut -c12-`
ladateJour=`echo $ligne | cut -c1-2`
ladateMois=`echo $ligne | cut -c4-5`
ladateAnnee=`echo $ligne | cut -c7-10`
ladate="$ladateMois/$ladateJour/$ladateAnnee"

if [[ "$NOWMois"  == "$ladateMois" ]]; then # si le moi en cours correspond au mois recherché dans config

local arbre=`echo "$ladateAnnee - $date2" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"` # Résultat par soustraction des 2 dates afin d'avoir son age

echo "$NOWJour -le $ladateJour" 
	if [ "$NOWJour" -le "$ladateJour" ]; then # si aujourd'hui < ou = le jour recherché dans config

		resultprochain=`echo "$ladateJour - $NOWJour" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`

		if [ "$resultprochain" = "0" ]; then
		nbrtour=`echo "$nbrtour + 1" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		ajourdhui="Ok"
		say "C'est aujourd'hui et c'est $leNOM..."
		echo "1" > $jv_dir/plugins/jarvis-cestquand/riencemoici.txt
		else
		nbrtour=`echo "$nbrtour + 1" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		resultprochain=`echo "$ladateJour - $NOWJour" | bc -l | sed "s/\([0-9]*\.[0-9][0-9]\).*/\1/"`
		say "le $ladate $lenom dans $resultprochain jours et ça sera les $arbre ans de $leNOM."
		echo"Ok" > $jv_dir/plugins/jarvis-cestquand/riencemoici.txt

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
	echo"" > $jv_dir/plugins/jarvis-cestquand/riencemoici.txt
	return
	fi
fi




if [[ "$nbrtour" == "0" ]]; then
say "ha, il n'y a rien pour ce mois-ci... $adirej"
echo"" > $jv_dir/plugins/jarvis-cestquand/riencemoici.txt
return
fi

if [[ "$adirej"  != " " ]] && [[ "$ajourdhui"  != "" ]]; then
say "il n'y a rien pour ce mois-ci... $adirej"
echo"" > $jv_dir/plugins/jarvis-cestquand/riencemoici.txt
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

testlemoisinverse() {
cestpassemois=""
cestpassemoisd=""

if [[ "$maman2" == "janvier" ]]; then
cestpassemois=1
cestpassemoisd="janvier"
return
fi

if [[ "$maman2" == "fevrier" ]]; then
cestpassemois=2
cestpassemoisd="février"
return
fi

if [[ "$maman2" == "mars" ]]; then
cestpassemoisd="mars"
cestpassemois=3
return
fi

if [[ "$maman2" == "avril" ]]; then
cestpassemoisd="avril"
cestpassemois=4
return
fi

if [[ "$maman2" == "mai" ]]; then
cestpassemoisd="mai"
cestpassemois=5
return
fi

if [[ "$maman2" == "juin" ]]; then
cestpassemoisd="juin"
cestpassemois=6
return
fi

if [[ "$maman2" == "juillet" ]]; then
cestpassemoisd="juillet"
cestpassemois=7
return
fi

if [[ "$maman2" == "aout" ]]; then
cestpassemoisd="août"
cestpassemois=8
return
fi


if [[ "$maman2" == "septembre" ]]; then
cestpassemoisd="septembre"
cestpassemois=9
return
fi

if [[ "$maman2" == "octobre" ]]; then
cestpassemoisd="octobre"
cestpassemois=10
return
fi

if [[ "$maman2" == "novembre" ]]; then
cestpassemoisd="novembre"
cestpassemois=11
return
fi

if [[ "$maman2" == "decembre" ]]; then
cestpassemoisd="décembre"
cestpassemois=12
return
fi

if [[ "$cestpassemois" == "" ]]; then
say "J'ai un problème de reconnaissance avec le mois énnoncée, veuillez reformuler"
fi

return
}

jv_pg_ct_pourpluginpiresclave() {
renvoiepir=`cat $jv_dir/plugins/jarvis-cestquand/riencemoici.txt`
say "$renvoiepir"
}


