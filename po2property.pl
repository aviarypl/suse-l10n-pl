#!/usr/bin/perl

$PONAME=$ARGV[0];
$wasmsgid = 0;
$fuzzy = 0;


open INPUTF, "< $PONAME"  or die "Can't open file '$PONAME'";

$propertynum = 0;

while (<INPUTF>)
{
    $line = $_;
    if ( $line =~ /^\#, fuzzy/ ) {
	$fuzzy = 1;
    }
    elsif ( $line =~ /^#\. / ) 
    {
	#property name
	$line =~ /#\. (.*)/;
	$property = $1;
	if ( $property )
	{
	    $properties[$propertynum] = $property;
	    $propertynum++;
	}
    }
    elsif ( $line =~ /^msgid/ )
    {
	# english text
	$line =~ /\"(.*)\"/;
	$original = $1;
	if ( $original )
	{
	    $wasmsgid = 1;
	}    
    }
    elsif ( $wasmsgid == 1 && ($line =~ /^msgstr/)  )
    {
	# wez tlumaczenie z cudzyslowow
	$line =~ /\"(.*)\"$/;
	$trans = $1;

	$i = 0;
	
	# usunięcie escape seqs z gettextu i dodanie \uXXXX dla pliterek
	$trans = escapeCharacters($trans);
	
	foreach (@properties) {
	    $prop =  $_;
	    if ( $prop ne "" ) {
		if ( $fuzzy == 1 || $trans eq "") {
		    $value = escapeCharacters($original);
		}
		else {
		    $value = $trans;
		}
		
		# czyszczenie tablicy properties
		$properties[$i] = "";
		$i++;
	
		# wypis 
	        print "$prop=$value\n"
    	    }
	}
        $wasmsgid = 0;
	$fuzzy = 0;
    }
    else
    {
	$wasmsgid = 0;
	$propertynum = 0;
    }
}

close INPUTF;

sub escapeCharacters {
 
    my $l = $_[0];

    # \" na "
    $l =~ s/\\\"/\"/g; 
    # \\ na \    
    $l =~ s/\\\\/\\/g; 
    
    $l=~s/ą/\\u0105/g; $l=~s/ć/\\u0107/g; $l=~s/ę/\\u0119/g; $l=~s/ł/\\u0142/g; $l=~s/ń/\\u0144/g;                                                            
    $l=~s/ó/\\u00F3/g; $l=~s/ś/\\u015B/g; $l=~s/ź/\\u017A/g; $l=~s/ż/\\u017C/g; $l=~s/Ą/\\u0104/g;                                                            
    $l=~s/Ć/\\u0106/g; $l=~s/Ę/\\u0118/g; $l=~s/Ł/\\u0141/g; $l=~s/Ń/\\u0143/g; $l=~s/Ó/\\u00F2/g;                                                            
    $l=~s/Ś/\\u015A/g; $l=~s/Ź/\\u0179/g; $l=~s/Ż/\\u017B/g; 

    return $l;
}

