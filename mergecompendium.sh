#!/bin/bash

# Przenosi tlumaczenia z wielkiego pliku compendium do plikow .po

mergeDir () 
{
    DIR=$1
    DIRTMP=$DIR-tmp
    cp -R $DIR ./$DIRTMP
    cd $DIRTMP
    for i in `ls *.po`
    do
	echo -n "Merging $i: "
	msgmerge --compendium ../rbac37_compendium.po --no-wrap -o ../$DIR/$i /dev/null $i
    done
    
    cd ..
    rm -Rf $DIRTMP
}

mergeDir po
#mergeDir po-idmua

#svn st | grep -v ?