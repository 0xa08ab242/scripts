#!C:\Perl\bin\ perl.exe
#
# sanitized IP addresses, but otherwise unchanged from  2009-04-29 version
########################################################################################
# README - General comments and instructions
########################################################################################
# On the Sensor or Defense Center create a client
# Download the pkcs12 file
# Split the pkcs12 into a key file and certificate file
# For example, using openssl this would be similar to the following commands:
#	openssl pkcs12 -in [ipaddress|hostname].pkcs12 -clcerts -nokeys -out [pick-a-name].crt
#	openssl pkcs12 -in [ipaddress|hostname].pkcs12 -nocerts -nodes -out [pick-a-name].key
# Edit the configuration information for the correct values in the Constants section
########################################################################################

########################################################################################
# Perl Module Dependencies (--max-depth = 1) | (alphabetized)
#
# To debug why you are not getting an ssl connection:
# Replace:
#	use IO::Socket::SSL qw();
# With:
#	use IO::Socket::SSL qw(debug3);
########################################################################################
use Carp;
use Data::Dumper;
use File::Basename;
use File::Temp qw(tempfile);
use Getopt::Long;
use IO::Tee;
use IO::Socket::SSL qw();
use lib "$FindBin::Bin/lib";
use POSIX qw(strftime);
use SFSGlobals qw(:DEFAULT);
use SFStreamer qw(:DEFAULT);
use strict;
use Text::CSV;
use Text::CSV_XS;
use Time::Local;
use warnings;

########################################################################################
# Constants and configuration information
#
# If debug is set to 1 then the module will
# print debugging data and log the data transferred
# data to $debug_log.in and $debug_log.out
########################################################################################
$debug = 1;
$debug_log = "streamer_data";

# my $server=[estreamer-server-ipaddress]  || die("I need a server");
my $server="X.X.X.X"  || die("I need a server");
# my $port=[estreamer-port-to-use]	  || Die("I need a port");
my $port="8302"    || Die("I need a port");
# my $crtfile=[estreamer-cert-file-to-use] || die("I need a cert to use");
my $crtfile="Y.Y.Y.Y.crt" || die("I need a cert to use");
# my $keyfile=[estreamer-key-file-to-use] || die("I need a private key");
my $keyfile="Y.Y.Y.Y.key" || die("I need a private key");
# my $output=[estreamer-output-folder-to-use] || die("I need an output folder");
my $output_dir="c:/tmp/output" || die("I need an output folder");
my $outfile="test-me.log" || die("I need an output file");
# my $state_file="X.X.X.X.state"  || die("I need a state file");
my $state_file="X.X.X.X.state"  || die("I need a state file");

########################################################################################
# Variables declaration, initialization, etc.
########################################################################################
my $client = undef;

$client = new IO::Socket::SSL(
	PeerAddr				=> "$server",
	PeerPort				=> "$port",
	Proto					=> 'tcp', 
	SSL_use_cert			=> 1,
	SSL_cert_file			=> "$crtfile",
	SSL_key_file			=> "$keyfile")
							|| die("Hey, no connection to " . $server .":". $port);
	debug("Hello from $0");

my $cmd;
my $count					= 0;
my $counter 				= 0;
my $csv 					= Text::CSV_XS->new( { eol => "\n" } );
my %delay					= ();
my $feed					= undef;
my %feed					= ();
my $gm_now					=  timegm(gmtime());
my $header_printed			= 0;
my $key 					= undef;
my $last;
my $local_config			= {};
my $new_logfile_name		= undef;
my $now;
my $remaining_data			= undef;
my %rnablock				=();
my %rule_map				= ();
my $graceful_close = 0;
my ($tmp_handle,$tmp_name)	=  tempfile( DIR => $local_config->{output_dir} , UNLINK => 0 )
							  or croak "Unable to open Temporary File for writing!";
	$tmp_handle->autoflush(1);
my $track = 0;

# Could build request configuration with this, if it was using this...
# will need to make changes on SFStreamer.pm for now
# instead of 0, use a configurable or storeable start time in UNIX time format

# instead of $FLAG_IDS_IMPACT_FLAG, could choose from other types:
# Possible options include:
#	$FLAG_PKTS
#	$FLAG_METADATA
#	$FLAG_IDS
#	$FLAG_RNA
#	$FLAG_POLICY_EVENTS
#	$FLAG_IMPACT_ALERTS
#	$FLAG_IDS_IMPACT_FLAG
#	$FLAG_RNA_EVENTS_2
#	$FLAG_RNA_FLOW
#	$FLAG_POLICY_EVENTS_2
#	$FLAG_RNA_EVENTS_3
#	$FLAG_HOST_ONLY
#	$FLAG_RNA_FLOW_3
#	$FLAG_POLICY_EVENTS_3
#	$FLAG_METADATA_2
#	$FLAG_METADATA_3
#	$FLAG_WAIT_FOR_CONFIG
#	$FLAG_RNA_EVENTS_4
#	$FLAG_RNA_FLOW_4
#	$FLAG_POLICY_EVENTS_4
#	$FLAG_METADATA_4
#	$FLAG_RUA
#	$FLAG_HOST_SINGLE
#	$FLAG_HOST_MULTI
#	$FLAG_POLICY_EVENTS_5

$SIG{INT}					= \&graceful_close ;
$SIG{QUIT}					= \&graceful_close ;
$SIG{HUP}					= \&graceful_close ;

########################################################################################
# Runtime Execution Logic
########################################################################################

print "Hello, world!\n";
print "The time is ",$gm_now," !\n";
print "The time is ",scalar localtime," !\n";

open my $log_fh, '>>', 'estreamer.log'
		or die "Could not open estreamer.log: $!";

# req_data($client,1086652945,$FLAG_IDS_IMPACT_FLAG);
# req_data($client,1086652945, $FLAG_IDS_IMPACT_FLAG | $FLAG_METADATA_4);
 req_data($client,1233000000, $FLAG_IDS_IMPACT_FLAG);

# req_data($client,1086652945,$FLAG_RNA_EVENTS_4 | $FLAG_IDS_IMPACT_FLAG | $FLAG_METADATA_4);

### my loop for windows
# Need to configure for local time if it is not set to UTC
# We also need to adject to the end time relative to now
# while ( $feed{'event_sec'} < ($gm_now) ) {
 while ( 1 ) {
	%feed = get_feed($client);

	if(!$header_printed){
		foreach my $key (  @{$feed{'order'}} ) {
			print $log_fh ($key . ",");
		}
		print $log_fh "\n";
		$header_printed = 0;
	}

		foreach my $key (  @{$feed{'order'}} ) {
			print $log_fh ($feed{$key} . ",");
		}
		print $log_fh "\n";
		
		ack_data($client);

}
print "Closing eStreamer Client Connection\n";
close $client;
print "Writing data...\n";
graceful_close();
print "DONE!\n";

# print $log_fh "We have no stream data today!\n";
# print $log_fh "We have retrieved everything up to ",strftime("%y%m%d %H:%M:%S", localtime())," \n";

########################################################################################
# Subroutines
########################################################################################
sub graceful_close {
	print "In Graceful Close...\n"; 
	# first lets close our temporary file
	# $tmp_handle->close();
#	my $new_logfile_name = strftime("%y%m%d.%H%M%S", localtime()) . "_estreamer" . ".log";
	my $new_logfile_name = "SourceFire_eStreamer_" . strftime("%y-%m-%d-T%H%M%S", localtime()) . ".log";
	close $log_fh;
	rename('estreamer.log' , $new_logfile_name)
		or die "Could not rename estreamer.log: $!";
	print "Done.\n";
	if ($debug == 1){
		my $new_debug_name_in = strftime("%y%m%d.%H%M%S", localtime()) . "_estreamer_debug" . ".in";
		my $new_debug_name_out = strftime("%y%m%d.%H%M%S", localtime()) . "_estreamer_debug" . ".out";
		close $debug_log;
		rename('streamer_data.in' , $new_debug_name_in)
			or die "Could not rename streamer_data.in: $!";
		rename('streamer_data.out' , $new_debug_name_out)
			or die "Could not rename streamer_data.out: $!";
	}
	exit 0;
}
########################################################################################
sub log_message {
  local *FH = shift;

  print FH @_, "\n";
}