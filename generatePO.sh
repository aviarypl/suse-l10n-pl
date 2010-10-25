#!/bin/bash
# #####################
# generuje pliki .po na podstawie angielskich plikow .properties
# #####################

# katalog z angielskimi properties
ORI_DIR=$1

# katalog z dotychczasowymi tłumaczeniami
TRA_DIR=$2

DEST_DIR=$3

# koncowki nazw poszczegolnych plikow
ENTXT="_en"
PLTXT="_pl"

PROPERTY2PO="./property2po.pl"

mkdir $DEST_DIR 2>/dev/null

# spr parametrów
if [ "$1" =  "" ] 
then
    echo "Nie podano katalogu plików angielskich"
    exit 1;
fi

if [ "$2" =  "" ] 
then
    MAKE_POT=1
else
    MAKE_POT=0
    if [ ! -d $2 ] 
    then
	echo "Katalog plików polskich ($2) nie istnieje"
	exit 1;
    fi

fi

# koncowki nazw poszczegolnych plikow
ENTXT="_en"
PLTXT="_pl"


processFile() {
    # przygotowanie ścieżki i nazwy pliku docelowego (polskiego)
    TRA_FILE=`basename "$1"`
    
    echo "Processing $TRA_FILE ..."
    
    TRA_FILE=`echo "$TRA_FILE"  | sed -n "s!_en!_pl!p"`
    PO_FILE_NAME=`echo "$TRA_FILE" | sed -n "s/\.properties/\.po/p"` 

    if [ $MAKE_POT -eq 0 ] 
    then
		TRA_FILE_FPATH=`find "$TRA_DIR" -name "$TRA_FILE" -type f`
    else
		TRA_FILE_FPATH=""
    fi
    
    # odpalamy generację .po dla jednego pliku
    #echo $PROPERTY2PO $i $TRA_FILE_FPATH
#    if [ -f $DEST_DIR/$PO_FILE_NAME ]
#    then
#	 $PROPERTY2PO $i $TRA_FILE_FPATH > $DEST_DIR/${PO_FILE_NAME}.1
#    else
        $PROPERTY2PO "$1" "$TRA_FILE_FPATH" > "$DEST_DIR/$PO_FILE_NAME"
#    fi
    
    echo OK
}

find $ORI_DIR -type f -name *.properties | while read f; do processFile "$f"; done;
