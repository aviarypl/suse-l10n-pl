#!/bin/bash

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

mergeDir po-rbac
mergeDir po-idmua

svn st | grep -v ?