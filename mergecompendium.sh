#!/bin/bash

# Przenosi tlumaczenia z wielkiego pliku compendium do plików .po

mergeDir () 
{
    DIR=$1
    DIRTMP=$DIR-tmp
    cp -R $DIR ./$DIRTMP
    cd $DIRTMP
    for i in `ls *.po`
    do
	msgmerge --compendium ../compendium.po --no-wrap -o ../$DIR/$i /dev/null $i
    done
    
    cd ..
    rm -Rf $DIRTMP
}

mergeDir po
#mergeDir po-idmua

svn st | grep -v ?