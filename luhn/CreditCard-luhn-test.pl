#!C:\Perl\bin\ perl.exe
#
# Started with Original source located on rosettacode.org
# modifying the source to make it easier to for me to understand
# adding the file input and file output functions
########################################################################################
$SIG{INT}						= \&graceful_close ;
$SIG{QUIT}						= \&graceful_close ;
$SIG{HUP}						= \&graceful_close ;
########################################################################################
# Variables
#
my $line_in = undef;
my $line_out = undef;
my $luhn_out = undef;
########################################################################################
# Arrays
#
my @input = undef;
########################################################################################
#### Begin MAIN
########################################################################################
#
open my $log_fh, '>>', 'CreditCard-validation.txt'
		or die "CreditCard-validation.txt: $!";
#
open my $input, '<', 'CreditCard-input.txt'
		or die "CreditCard-input.txt: $!";
#		
foreach (<$input>) {
#
	$line_in = $_;
	chomp($line_in);
#
	$line_out = $line_in;
	$luhn_out = luhn($_);
#
print $log_fh ("$luhn_out:$line_out\n");
}
#
close $log_fh;
close $input;
exit 0;
########################################################################################
#### End MAIN
########################################################################################
#
########################################################################################
#### Subroutines
########################################################################################
sub graceful_close {
	print "In Graceful Close...\n"; 
	close $log_fh;
	close $input;
	print "Done.\n"; 
	exit 0;
}
########################################################################################
sub luhn{
my (@n,$i,$sum) = split //, reverse $_[0];
#
my @a = map{int(2*$_ /10)+(2*$_ % 10)}(0..9);
# 
map {$sum += $i++ % 2 ? $a[$_]:$_}@n;
#
return ($sum % 10) ? 0:1;
#
}
########################################################################################
#### End Subroutines
########################################################################################
