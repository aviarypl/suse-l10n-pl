#!/usr/bin/perl

#
# TODO: dekodowane polskich encji typu u0107 w odczytanych stringach
#


$IN = $ARGV[0];
$CURRENT = $ARGV[1];

# Odczytujemy angielskie linie
{
    open( $FH, "< $IN");
    while (<$FH>)
    {
	chomp; $line=$_;    
	
	$offset = -1;
	$found = 0;
	$result = -1;
        while ($result == -1 || $found == 0) {
	    $result = index($line, "=", $offset);
	    if ($result == -1) {
		# bez = w linii
		last;
	    }
#	    print "RRRRRRR $result RRRRRRR".substr($line, $result-1, 1)."\n";
	    if ( "\\" ne substr($line, $result-1, 1) ) {
		$found = 1;
	    }
	    $offset = $result + 1;
	}
	if ($result != -1) {
	    #$line=~/=/;
	    $key=substr($line, 0, $result);
	    $value=substr($line, $result + 1);
	    $out{$value}=$key."|||".$out{$value};
	    $comment{$value} = $comment{$value}."#. $key\n";
    	    $en{$value}=$key;
	    $pl{$key} = "";
#	    print $key."\n";
	}
    }
    close ($FH);
}

if ( $CURRENT ne "") {
# Odczytujemy dotychczasowe spolszczenia i podmieniamy stringi jesli juz sa spolszczone
    open( $FH, "< $CURRENT");
    while (<$FH>)
    {
	$line=$_;
	chomp $line;

        $offset = -1;                                                                                                                                                             
        $found = 0;                                                                                                                                                               
        $result = -1;       
        while ($result == -1 || $found == 0) {
	    $result = index($line, "=", $offset);
	    if ( "\\" ne substr($line, $result-1, 1) ) {
		$found = 1;
	    }
	    $offset = $result + 1;
	}
	if ($result != -1) {
    	    $key=substr($line, 0, $result);                                                                                                                                       
            $value=substr($line, $result + 1);          	
	    $pl{$key}=$value;
#	    print $key."\n";
	}
    }
    close($FH);
}
# Wyrzucamy na STDOUT wynik

system "cat hdr.po.tmp";

foreach $in (sort keys %out)
{
    if ($in ne "") {
	$txt = "";
	print $comment{$in};
	$msgid = $in;
	$msgid =~ s/(["\\])/\\$1/g;
#        print "msgid \"".$in."\"\n";
	print "msgid \"".$msgid."\"\n";
	if ( $in ne $pl{$en{$in}} ) {
	    $txt = decodePLEntities($pl{$en{$in}});
	    $txt =~ s/(["\\])/\\$1/g;
        }
        print "msgstr \"".$txt."\"\n\n";
    #    print "\"".$in."\",\"".$pl{$en{$in}}."\"\n";
    }
}


sub decodePLEntities {

    my $l = $_[0];
    $l=~s/\\u0105/ą/g; $l=~s/\\u0107/ć/g; $l=~s/\\u0119/ę/g; $l=~s/\\u0142/ł/g; $l=~s/\\u0144/ń/g;
    $l=~s/\\u00F3/ó/g; $l=~s/\\u015B/ś/g; $l=~s/\\u017A/ź/g; $l=~s/\\u017C/ż/g; $l=~s/\\u0104/Ą/g;
    $l=~s/\\u0106/Ć/g; $l=~s/\\u0118/Ę/g; $l=~s/\\u0141/Ł/g; $l=~s/\\u0143/Ń/g; $l=~s/\\u00F2/Ó/g;
    $l=~s/\\u015A/Ś/g; $l=~s/\\u0179/Ź/g; $l=~s/\\u017B/Ż/g;     

    return $l;
}

