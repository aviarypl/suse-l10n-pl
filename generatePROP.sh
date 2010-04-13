#!/bin/bash
# #####################
# Generuje pliki properties z plików .po do przygotowanej struktury katalogów
#
# UWAGA: katalog docelowy powinien zawierać odpowiednią strukturę katalogów i pliki .properties.
#	 Na początek można po prostu skopiować angielski orginał.
#     
# Pliki .po muszą mieć koniecznie teksty (msgstr/msgid) jednolinijkowe
# #####################

# katalog docelowy 
DEST_DIR=$1

# katalog po
PO_DIR=$2

PO2PROPERTY="./po2property.pl"

# spr parametrów
if [ "$DEST_DIR" =  "" ] 
then
    echo "Nie podano katalogu docelowego"
    exit 1;
fi

if [ ! -d $DEST_DIR ] 
then
    echo "Katalog docelowy ($DEST_DIR) nie istnieje"
    exit 1;
fi

if [ ! -d $PO_DIR ] 
then
    echo "Katalog źródłowy ($PO_DIR) nie istnieje"
    exit 1;
fi


for i in `ls $PO_DIR/*.po`
do
    # fragment nazwy do wyszukania pliku docelowego: blabla_pl.po > blabla_
    PROP_FILE=`basename $i | sed -n "s/_pl\.po/_/p"` 
    
    echo "Processing $i ..."
    
    # szukamy pliku
    DEST_FILE=`find $DEST_DIR -name ${PROP_FILE}* -type f`
    
    for j in $DEST_FILE
    do
	# ew. korekcja dla _pl. w nazwie
	PROP_PL=$j
	DX=`echo $j  | sed -n "s/_en\.properties/_pl\.properties/p"`
	if [ "$DX" != "" ] 
	then
		# usuwamy stary (bo może być _en.properties)
		rm -f $j
		PROP_PL=$DX
	fi 
    
	# odpalamy generację .properties dla jednego pliku
	$PO2PROPERTY $i > $PROP_PL
    done
    
done
echo OK
