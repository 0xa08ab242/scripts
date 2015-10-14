#!/usr/bin/perl
########################################################################################
#	SourceFire eStreamer postprocessor script
#	This script was created to modify the output from the SourceFire eStreamer perl client
#	The intent is to make the output more compatible with the input format for our SIEM product which recognizes Snort syslog data
#	The modification at this stage will allow much easier maintenance of the SIEM, updates procedures will be much simpler
########################################################################################
#Imported files functions and modules
use Carp;
use strict;
use warnings;
use Time::Format qw(%time %strftime %manip);
use Time::Format_XS;
########################################################################################

#Variables (alphabetized...)
########################################################################################
my $classification_description = undef;
my $classification_name = undef;
my $classification_number = undef;
my $destination_address = undef;
my $destination_port = undef;
my $event_id = undef;
my $event_message = undef;
my $event_seconds = undef;
my $event_microseconds = undef;
my $generator_name = undef;
my $generator_description = undef;
my $generator_id_subtable = undef;
my $generator_number = undef;
my $icmp_code_description = undef;
my $icmp_code_number = undef;
my $icmp_type_description = undef;
my $icmp_type_number = undef;
my $impact_description = undef;
my $impact_number = undef;
my $ip_protocol = undef;
my $ip_protocol_description = undef;
my $ip_protocol_number = undef;
my $line_in = undef;
my $line_out = undef;
my $new_logfile_name = undef;
my $pad = undef;
my $priority_description = undef;
my $priority_number = undef;
my $sensor_id_number = undef;
my $sensor_name = undef;
my $snort_id_description = undef;
my $snort_id_number = undef;
my $source_address = undef;
my $source_port = undef;
my $tcp_udp_protocol_decription = undef;
my $tcp_udp_protocol_number = undef;
my $unix_time_description = undef;
my $version_number = undef;

$SIG{INT}					= \&graceful_close ;
$SIG{QUIT}					= \&graceful_close ;
$SIG{HUP}					= \&graceful_close ;
########################################################################################
#arrays (mostly alphabetized)
my @classification_n = undef;
my @classification_d = undef;
my @generator = undef;
my @generator_id_subtable = undef;
my @impact = undef;
my @input = undef;
my @ip_protocol = undef;
my @priority = undef;
my @sensor = undef;
my @snort_id_0 = undef;
my @snort_id_1 = undef;
my @snort_id_2 = undef;
my @snort_id_3 = undef;
my @snort_id_102 = undef;
my @snort_id_105 = undef;
my @snort_id_106 = undef;
my @snort_id_111 = undef;
my @snort_id_116 = undef;
my @snort_id_119 = undef;
my @snort_id_120 = undef;
my @snort_id_122 = undef;
my @snort_id_123 = undef;
my @snort_id_124 = undef;
my @snort_id_125 = undef;
my @snort_id_126 = undef;
my @snort_id_129 = undef;
my @snort_id_130 = undef;
my @snort_id_131 = undef;
my @snort_id_1001 = undef;
my @snort_id_1003 = undef;
my @snort_id_2001 = undef;
my @snort_id_2003 = undef;
########################################################################################
#hashes (mostly alphabetized)
my %generator_id_subtable = ( 0, undef );

$classification_n[0] = "Undefined";
$classification_n[1] = "not-suspicious";
$classification_n[2] = "unknown";
$classification_n[3] = "bad-unknown";
$classification_n[4] = "attempted-recon";
$classification_n[5] = "successful-recon-limited";
$classification_n[6] = "successful-recon-largescale";
$classification_n[7] = "attempted-dos";
$classification_n[8] = "successful-dos";
$classification_n[9] = "attempted-user";
$classification_n[10] = "unsuccessful-user";
$classification_n[11] = "successful-user";
$classification_n[12] = "attempted-admin";
$classification_n[13] = "successful-admin";
$classification_n[14] = "rpc-portmap-decode";
$classification_n[15] = "shellcode-detect";
$classification_n[16] = "string-detect";
$classification_n[17] = "suspicious-filename-detect";
$classification_n[18] = "suspicious-login";
$classification_n[19] = "system-call-detect";
$classification_n[20] = "tcp-connection";
$classification_n[21] = "trojan-activity";
$classification_n[22] = "unusual-client-port-connection";
$classification_n[23] = "network-scan";
$classification_n[24] = "denial-of-service";
$classification_n[25] = "non-standard-protocol";
$classification_n[26] = "protocol-command-decode";
$classification_n[27] = "web-application-activity";
$classification_n[28] = "web-application-attack";
$classification_n[29] = "misc-activity";
$classification_n[30] = "misc-attack";
$classification_n[31] = "icmp-event";
$classification_n[32] = "porn-filters";
$classification_n[33] = "policy-violation";
$classification_n[34] = "default-login-attempt";

$classification_d[0] = "Undefined";
$classification_d[1] = "Not Suspicious Traffic";
$classification_d[2] = "Unknown Traffic";
$classification_d[3] = "Potentially Bad Traffic";
$classification_d[4] = "Attempted Information Leak";
$classification_d[5] = "Information Leak";
$classification_d[6] = "Large Scale Information Leak";
$classification_d[7] = "Attempted Denial of Service";
$classification_d[8] = "Denial of Service";
$classification_d[9] = "Attempted User Privlege Gain";
$classification_d[10] = "Unsuccessful User Privlege Gain";
$classification_d[11] = "Successful User Privlege Gain";
$classification_d[12] = "Attempted Administrator Privlege Gain";
$classification_d[13] = "Successful Administrator Privlege Gain";
$classification_d[14] = "Decode of an RPC Query";
$classification_d[15] = "Executable Code was Detected";
$classification_d[16] = "A Suspicious String was Detected";
$classification_d[17] = "A Suspicious Filename was Detected";
$classification_d[18] = "An Attempted Login Using a Suspicious Username was Detected";
$classification_d[19] = "A System Call was Detected";
$classification_d[20] = "A TCP Connection was Detected";
$classification_d[21] = "A Network Trojan was Detected";
$classification_d[22] = "A Client was Using an Unusual Port";
$classification_d[23] = "Detection of a Network Scan";
$classification_d[24] = "Dectection of a Denial of Service Attack";
$classification_d[25] = "Detection of a Non-Standard Protocol or Event";
$classification_d[26] = "Generic Protocol Command Decode";
$classification_d[27] = "Access to a Potentially Vulnerable Web Application";
$classification_d[28] = "Web Application Attack";
$classification_d[29] = "Miscellaneous Activity";
$classification_d[30] = "Miscellaneous Attack";
$classification_d[31] = "Generic ICMP Event";
$classification_d[32] = "Pornography was Detected";
$classification_d[33] = "Potential Corporate Privacy Violation";
$classification_d[34] = "Attempt to Login By a Default Username and Password";

# @generator = selected subset within the range of 0 - 2003, easier to input individual values
$generator[0] = undef;
$generator[1] = "Standard Text Rule";
$generator[2] = "Tagged Packets";
$generator[3] = "Shared Object Rule";
$generator[102] = "HTTP Decoder";
$generator[105] = "Back Orifice Detector";
$generator[106] = "RPC Detector";
$generator[111] = "Stream 4 Stateful Inspection and Reassembly";
$generator[116] = "Packet Decoder";
$generator[119] = "HTTP Inspection Preprocessor";
$generator[120] = "HTTP Inspection Anomalous Preprocessor";
$generator[122] = "Portscan Detector" ;
$generator[123] = "IP Defragmentor";
$generator[124] = "SMTP Decoder";
$generator[125] = "FTP Decoder";
$generator[126] = "Telnet Decoder";
$generator[129] = "Stream 5 Stateful Inspection and Reassembly";
$generator[130] = "DCE/RPC Preprocessor";
$generator[131] = "DNS Preprocessor";
$generator[1001] = "Suspended Standard Text Rule";
$generator[2001] = "Re-enabled Standard Text Rule";
$generator[1003] = "Suspended Shared Object Rule";
$generator[2003] = "Re-enabled Shared Object Rule";

$impact[0] = "Gray: Unknown";
$impact[1] = "Blue: Unknown-Target";
$impact[2] = "Gray: Unknown";
$impact[3] = "Yellow: Currently-Not-Vulnerable";
$impact[4] = "Gray: Unknown";
$impact[5] = "Gray: Unknown";
$impact[6] = "Gray: Unknown";
$impact[7] = "Orange: Potentially-Vulnerable";
$impact[8] = "Gray: Unknown";
$impact[9] = "Gray: Unknown";
$impact[10] = "Gray: Unknown";
$impact[11] = "Red: Vulnerable";
$impact[12] = "Gray: Unknown";
$impact[13] = "Gray: Unknown";
$impact[14] = "Gray: Unknown";
$impact[15] = "Red: Vulnerable";
$impact[16] = "Gray: Unknown";
$impact[17] = "Gray: Unknown";
$impact[18] = "Gray: Unknown";
$impact[19] = "Red: Vulnerable";
$impact[20] = "Gray: Unknown";
$impact[21] = "Gray: Unknown";
$impact[22] = "Gray: Unknown";
$impact[23] = "Red: Vulnerable";
$impact[24] = "Gray: Unknown";
$impact[25] = "Gray: Unknown";
$impact[26] = "Gray: Unknown";
$impact[27] = "Red: Vulnerable";
$impact[28] = "Gray: Unknown";
$impact[29] = "Gray: Unknown";
$impact[30] = "Gray: Unknown";
$impact[31] = "Red: Vulnerable";
$impact[32] = "Black: Traffic Dropped";
$impact[33] = "Black: Traffic Dropped";
$impact[34] = "Black: Traffic Dropped";
$impact[35] = "Black: Traffic Dropped";
$impact[36] = "Black: Traffic Dropped";
$impact[37] = "Black: Traffic Dropped";
$impact[38] = "Black: Traffic Dropped";
$impact[39] = "Black: Traffic Dropped";
$impact[40] = "Black: Traffic Dropped";
$impact[41] = "Black: Traffic Dropped";
$impact[42] = "Black: Traffic Dropped";
$impact[43] = "Black: Traffic Dropped";
$impact[44] = "Black: Traffic Dropped";
$impact[45] = "Black: Traffic Dropped";
$impact[46] = "Black: Traffic Dropped";
$impact[47] = "Black: Traffic Dropped";
$impact[48] = "Black: Traffic Dropped";
$impact[49] = "Black: Traffic Dropped";
$impact[50] = "Black: Traffic Dropped";
$impact[51] = "Black: Traffic Dropped";
$impact[52] = "Black: Traffic Dropped";
$impact[53] = "Black: Traffic Dropped";
$impact[54] = "Black: Traffic Dropped";
$impact[55] = "Black: Traffic Dropped";
$impact[56] = "Black: Traffic Dropped";
$impact[57] = "Black: Traffic Dropped";
$impact[58] = "Black: Traffic Dropped";
$impact[59] = "Black: Traffic Dropped";
$impact[60] = "Black: Traffic Dropped";
$impact[61] = "Black: Traffic Dropped";
$impact[62] = "Black: Traffic Dropped";
$impact[63] = "Black: Traffic Dropped";

@ip_protocol = qw { HOPOPT ICMP IGMP GGP IP ST TCP CBT EGP IGP BBN-RCC-MON NVP-II PUP ARGUS EMCON XNET CHAOS UDP MUX DCN-MEAS HMP PRM XNS-IDP TRUNK-1 TRUNK-2 LEAF-1 LEAF-2 RDP IRTP ISO-TP4 NETBLT MFE-NSP MERIT-INP DCCP 3PC IDPR XTP DDP IDPR-CMTP TP++ IL IPv6 SDRP IPv6-Route IPv6-Frag IDRP RSVP GRE DSR BNA ESP AH I-NLSP SWIPE NARP MOBILE TLSP SKIP IPv6-ICMP IPv6-NoNxt IPv6-Opts anyhostinternalprotocol CFTP anylocalnetwork SAT-EXPAK KRYPTOLAN RVD IPPC anydistributedfilesystem SAT-MON VISA IPCV CPNX CPHB WSN PVP BR-SAT-MON SUN-ND WB-MON WB-EXPAK ISO-IP VMTP SECURE-VMTP VINES TTP NSFNET-IGP DGP TCF EIGRP OSPFIGP Sprite-RPC LARP MTP AX.25 IPIP MICP SCC-SP ETHERIP ENCAP anyprivateencryptionscheme GMTP IFMP PNNI PIM ARIS SCPS QNX A/N IPComp SNP Compaq-Peer IPX-in-IP VRRP PGM any0-hopprotocol L2TP DDX IATP STP SRP UTI SMP SM PTP ISISoverIPv4 FIRE CRTP CRUDP SSCOPMCE IPLT SPS PIPE SCTP FC RSVP-E2E-IGNORE MobilityHeader UDPLite MPLS-in-IP manet HIP Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Unassigned Useforexperimentationandtesting Useforexperimentationandtesting Reserved };

$priority[0] = "Unassigned";
$priority[1] = "High";
$priority[2] = "Medium";
$priority[3] = "Low";

# Updated after version change, old list kept for testing purposes...
#@sensor = qw{ Undefined Luger Beretta Lyman Thompson Hawken Speer Nosler Browning Speer Speer Speer Marlin Mauser Beretta Hawken Hawken Hawken Marlin Speer Lyman };
@sensor = qw{ Undefined Luger Beretta Lyman Thompson Hawken Speer Nosler Browning Speer Speer Speer Marlin Mauser Beretta Hawken Hawken Hawken Marlin Speer Lyman };

#for the rule triggered events, the array populations are unnecessary since I coded the results into the if statements, however, keeping these here allows me to be consistent and if ever necessary to just append the possible values...
$snort_id_1[0] = "Undefined";
$snort_id_1[1] = "Rule Triggered Event";

$snort_id_2[0] = "Undefined";
$snort_id_2[1] = "Rule Triggered Event";

$snort_id_3[0] = "Undefined";
$snort_id_3[1] = "Rule Triggered Event";

$snort_id_102[0] = "Undefined HTTP Data in Packet";
$snort_id_102[1] = "Rule Triggered Event";

$snort_id_105[0] = "Undefined Back Orifice Detector";
$snort_id_105[1] = "Back Orifice traffic was Detected";
$snort_id_105[2] = "Back Orifice client traffic was Detected";
$snort_id_105[3] = "Back Orifice server traffic was Detected";
$snort_id_105[4] = "Back Orifice Snort bunner attack";

$snort_id_106[0] = "Undefined RPC Detector";
$snort_id_106[1] = "Fragmented RPC records detected";
$snort_id_106[2] = "Multiple instances of the same RPC record detected";
$snort_id_106[3] = "Abnormally large RPC record fragment detected";
$snort_id_106[4] = "RPC segment with missing fragments detected";
$snort_id_106[5] = "Zero-length RPC fragment";

$snort_id_111[0] = "Undefined Stream 4 Inspection";
$snort_id_111[1] = "Stealth activity detected";
$snort_id_111[2] = "Evasive TCP reset segment detected";
$snort_id_111[3] = "Evasive retransmission detected";
$snort_id_111[4] = "Window violation detected";
$snort_id_111[5] = "Data detected on the SYN flag";
$snort_id_111[6] = "Stealth full XMAS attack detected.";
$snort_id_111[7] = "Stealth SAPU";
$snort_id_111[8] = "Stealth FIN scan detected";
$snort_id_111[9] = "Stealth null scan detected";
$snort_id_111[10] = "Stealth NMAP XMAS scan detected";
$snort_id_111[11] = "Stealth Vecna scan detected";
$snort_id_111[12] = "Stealth Nmap fingerprint detected";
$snort_id_111[13] = "Stealth SYN FIN scan detected";
$snort_id_111[14] = "Forward overlap detected";
$snort_id_111[15] = "Time To Live evasion detected";
$snort_id_111[16] = "Evasive retransmission of data detected";
$snort_id_111[17] = "Evasive restransmission data split";
$snort_id_111[18] = "Multiple ACKed";
$snort_id_111[19] = "Emergency";
$snort_id_111[20] = "Suspend";
$snort_id_111[21] = "TCP Timestamp option has value of zero";
$snort_id_111[22] = "Too many overlapping TCP packets";
$snort_id_111[23] = "Packet in established TCP steam missing ACK";
$snort_id_111[24] = "Evasive FIN packet";
$snort_id_111[25] = "SYN on established";

$snort_id_116[0] = undef;
$snort_id_116[1] = "Packet is not an IPV4 datagram";
$snort_id_116[2] = "Invalid IPV4 header length detected";
$snort_id_116[3] = "IPV4 datagram longer than IP header";
$snort_id_116[4] = "IPV4 bad option length detected";
$snort_id_116[5] = "Truncated IPV4 option detected";
$snort_id_116[45] = "TCP datagram longer than TCP header";
$snort_id_116[46] = "Invalid TCP offset detected";
$snort_id_116[47] = "Large TCP offset detected";
$snort_id_116[54] = "TCP Option with a bad length value detected";
$snort_id_116[55] = "Truncated TCP option detected";
$snort_id_116[56] = "TTCP option detected";
$snort_id_116[57] = "Obsolete TCP option detected";
$snort_id_116[58] = "Experimental TCP option detected";
$snort_id_116[95] = "UDP datagram longer than UDP header";
$snort_id_116[96] = "Invalid UDP datagram length detected";
$snort_id_116[97] = "Short UDP datagram packet detected";
$snort_id_116[105] = "ICMP datagram longer than ICMP header";
$snort_id_116[106] = "ICMP datagram longer than timestamp header";
$snort_id_116[107] = "ICMP datagram longer than address header";
$snort_id_116[108] = "Unknown IPV4 datagram detected";
$snort_id_116[109] = "Truncated address resolution protocol (ARP) detected";
$snort_id_116[110] = "Truncated EAPOL header detected";
$snort_id_116[111] = "Truncated EAP key detected";
$snort_id_116[112] = "Truncated EAP header detected";
$snort_id_116[120] = "Bad PPPOE frame detected";
$snort_id_116[130] = "Bad VLAN frame detected";
$snort_id_116[131] = "Bad VLAN LLC detected";
$snort_id_116[132] = "Bad VLAN extra LLC information detected";
$snort_id_116[133] = "Bad 802.11 LLC header detected";
$snort_id_116[134] = "Bad 802.11 extra LLC information detected";
$snort_id_116[140] = "Bad token ring header detected";
$snort_id_116[141] = "Bad token ring ETHLLC header detected";
$snort_id_116[142] = "Bad token ring MRLEN header detected";
$snort_id_116[143] = "Bad token ring MR header detected";
$snort_id_116[150] = "Traffic with either the source or destination IP address set to the loopback address (127.0.0.1/8) detected";
$snort_id_116[151] = "Traffic with identical source and destination addresses detected";
$snort_id_116[160] = "Invalid GRE header length detected";
$snort_id_116[161] = "Multiple GRE encapsulations detected in packet";
$snort_id_116[162] = "Invalid GRE version (not 0 or 1)";
$snort_id_116[163] = "Invalid GRE version 0 header detected";
$snort_id_116[164] = "Invalid GRE version 1 header detected";
$snort_id_116[165] = "Invalid Transparent Ethernet Bridging header length detected in GRE encapsulation";
$snort_id_116[250] = "ICMP original IP header truncated";
$snort_id_116[251] = "ICMP original IP header not IPV4";
$snort_id_116[252] = "ICMP original datagram length less than original IP header length";
$snort_id_116[253] = "ICMP original IP payload less than 64 bits";
$snort_id_116[254] = "ICMP original IP payload greater than 576 bytes";
$snort_id_116[255] = "ICMP original IP fragmented and offset not 0";

$snort_id_119[0] = "Undefined HTTP Inspection";
$snort_id_119[1] = "Encoded ASCII HTTP data detected";
$snort_id_119[2] = "Double encoded HTTP data detected";
$snort_id_119[3] = "%U encoded HTTP data detected";
$snort_id_119[4] = "Bare byte encoded HTTP data detected";
$snort_id_119[5] = "Base 36-encoded HTTP data detected";
$snort_id_119[6] = "UTF-8 encoded HTTP data detected";
$snort_id_119[7] = "IIS Unicode data mapped to Unicode codepoints detected in HTTP data";
$snort_id_119[8] = "HTTP data using multiple slash obfuscation detected";
$snort_id_119[9] = "HTTP data using backslash obfuscation detected";
$snort_id_119[10] = "HTTP data containing self-referential directory obfuscation detected";
$snort_id_119[11] = "HTTP data containing directory traversal obfuscation detected";
$snort_id_119[12] = "HTTP data containing tab characters detected";
$snort_id_119[13] = "HTTP data containing linebreaks detected";
$snort_id_119[14] = "HTTP data containing the Non-RFC character specified in your intrusion policy detected";
$snort_id_119[15] = "HTTP data containing an oversized directory length detected";
$snort_id_119[16] = "HTTP data containing abnormally large data chunk sizes detected";
$snort_id_119[17] = "HTTP data proxy use detected";
$snort_id_119[18] = "Web root directory traversal";

$snort_id_120[0] = "Undefined HTTP Inspection";
$snort_id_120[1] = "HTTP Traffic received by ports not specified as web server ports in your intrusion policy";

$snort_id_122[0] = "Undefined Portscan Detector";
$snort_id_122[1] = "TCP Portscan";
$snort_id_122[2] = "TCP Decoy Portscan";
$snort_id_122[3] = "TCP Portsweep";
$snort_id_122[4] = "TCP Distributed Portscan";
$snort_id_122[5] = "TCP Filtered Portscan";
$snort_id_122[6] = "TCP Filtered Decoy Portscan";
$snort_id_122[7] = "TCP Filtered Distributed Portscan";
$snort_id_122[8] = "TCP Filtered Portsweep";
$snort_id_122[9] = "IP Portscan";
$snort_id_122[10] = "IP Decoy Portscan";
$snort_id_122[11] = "IP Portsweep";
$snort_id_122[12] = "IP Distributed Portscan";
$snort_id_122[13] = "IP Filtered Portscan";
$snort_id_122[14] = "IP Filtered Decoy Portscan";
$snort_id_122[15] = "IP Filtered Distributed Portscan";
$snort_id_122[16] = "IP Filtered Portsweep";
$snort_id_122[17] = "UDP Portscan";
$snort_id_122[18] = "UDP Decoy Portscan";
$snort_id_122[19] = "UDP Portsweep";
$snort_id_122[20] = "UDP Distributed Portscan";
$snort_id_122[21] = "UDP Filtered Portscan";
$snort_id_122[22] = "UDP Filtered Decoy Portscan";
$snort_id_122[23] = "UDP Filtered Distributed Portscan";
$snort_id_122[24] = "UDP Filtered Portsweep";
$snort_id_122[25] = "ICMP Portsweep";
$snort_id_122[26] = "ICMP Filtered Portsweep";
$snort_id_122[27] = "Open port";

$snort_id_123[0] = "Undefined IP Defragmentor";
$snort_id_123[1] = "IP fragment with header options detected";
$snort_id_123[2] = "Teardrop attack detected";
$snort_id_123[3] = "Short fragment detected; possible DoS attack";
$snort_id_123[4] = "Oversized IP fragment detected; fragment ends after reassembled packet";
$snort_id_123[5] = "Zero-byte IP fragment detected";
$snort_id_123[6] = "IP fragment of negative length detected";
$snort_id_123[7] = "IP fragment of length greater than 65536 bytes detected";
$snort_id_123[8] = "Overlapping fragments detected";

$snort_id_124[0] = "Undefined SMTP Decoder";
$snort_id_124[1] = "Attempted command buffer overflow";
$snort_id_124[2] = "Attempted data header buffer overflow";
$snort_id_124[3] = "Attempted response buffer overflow";
$snort_id_124[4] = "Attempted specific command buffer overflow";
$snort_id_124[5] = "Unknown command";
$snort_id_124[6] = "Illegal command";
$snort_id_124[7] = "Attempted header name buffer overflow";

$snort_id_125[0] = "Undefined FTP";
$snort_id_125[1] = "Telnet command on FTP command channel";
$snort_id_125[2] = "Invalid FTP command";
$snort_id_125[3] = "FTP parameter length overflow";
$snort_id_125[4] = "FTP malformed parameter";
$snort_id_125[5] = "Possible string/format attempt in FTP command/parameter";
$snort_id_125[6] = "FTP response length overflow";
$snort_id_125[7] = "FTP command channel encrypted";
$snort_id_125[8] = "FTP bounce attack";
$snort_id_125[9] = "Evasive Telnet command on FTP command channel";

$snort_id_126[0] = "Undefined Telnet";
$snort_id_126[1] = "Telnet consecutive Are You There (AYT) overflow";
$snort_id_126[2] = "Telnet data encrypted";
$snort_id_126[3] = "Subnegotiation Begin without matching Subnegotiation End";

$snort_id_129[0] = "Undefined Stream 5 Inspection";
$snort_id_129[1] = "SYN on established session";
$snort_id_129[2] = "Data on SYN packet";
$snort_id_129[3] = "Data sent on stream not accepting data";
$snort_id_129[4] = "TCP Timestamp is outside of PAWs window";
$snort_id_129[5] = "Bad segment";
$snort_id_129[6] = "Window size larger than policy allows";
$snort_id_129[7] = "Limit on number of overlapping TCP segments";
$snort_id_129[8] = "Data sent in stream after TCP reset";
$snort_id_129[9] = "TCP client possible hijacked; different Ethernet address";
$snort_id_129[10] = "TCP server possible hijacked; different Ethernet address";

$snort_id_130[0] = "Undefined";
$snort_id_130[1] = "maximum memory allocated to the preprocessor for reassembling fragments reached";

$snort_id_131[0] = "Undefined";
$snort_id_131[1] = "Obsolete DNS RData type";
$snort_id_131[2] = "Experimental DNS RData type";
$snort_id_131[3] = "Client RData text overflow";

$snort_id_1001[0] = "Undefined";
$snort_id_1001[1] = "Rule Triggered Event";

$snort_id_2001[0] = "Undefined";
$snort_id_2001[1] = "Rule Triggered Event";

$snort_id_1003[0] = "Undefined";
$snort_id_1003[1] = "Rule Triggered Event";

$snort_id_2003[0] = "Undefined";
$snort_id_2003[1] = "Rule Triggered Event";

########################################################################################
#### End variables and arrays

#	open STDERR, error logs - add in debug function later...
########################################################################################
#$debug = 0;
#$debug_log = "./streamer_postproc_debug";
########################################################################################

#### Begin MAIN
########################################################################################

#Open filehandles for read, write, and errors
#	open STDIN, input source

#	open STDOUT, output destination
#open my $log_fh, '>>', 'estreamer_output.log'
#	or die "Could not open estreamer_output.log: $!";
#
#$line = <STDIN>;
# (<STDIN>> {

#$line_in ="estreamer:src_addr,192.168.200.194,priority:1,sid,7,event_usec,209513,src_port,54773,ip_proto,6,event_id,52779,dst_addr,192.168.79.120,impact_flag,1,dst_port,25,sensor_id,20,pad,0,event_sec,1215025231,rev,1,class,12,gen,124,evt_msg,";
open my $log_fh, '>>', 'estreamer_postproc.log'
		or die "Could not open postproc.log: $!";

open my $input, '<', 'modified_sourcefire_logs.conf'
		or die "Could not open modified_sourcefire_logs.conf: $!";
		
foreach (<$input>) {
# preliminary cleanup and normalization of the lines to be processed
	$line_in = $_;						#move the  implied array to the named one
	chomp($line_in);					#remove trailing newline characters
	$line_in =~ s/:/,/g;				#replace all colons with commas
	$line_out = $line_in;				#save_initial line to prepend to output
@input = split /,\s*/, $line_in;		#split the line into delimited fields, match the fields with their associated values
# data value population from input fields
	$source_address = $input[2];
	$priority_number = $input[4];
	$snort_id_number = $input[6];
	$event_microseconds = $input[8];
	$source_port = $input[10];
	$ip_protocol_number = $input[12];
	$event_id = $input[14];
	$destination_address = $input[16];
	$impact_number = $input[18];
	$destination_port = $input[20];	
	$sensor_id_number = $input[22];
	$pad = $input[24];
	$event_seconds = $input[26];
	$version_number = $input[28];
	$classification_number = $input[30];
	$generator_number = $input[32];
#now that we have populated the data from the message, we can lookup and calculate the remaining variables
	$classification_name = $classification_n[$classification_number];
	$classification_description = $classification_d[$classification_number];
	$generator_name = $generator[$generator_number];
	$impact_description = $impact[$impact_number];
	$ip_protocol_description = $ip_protocol[$ip_protocol_number];
	$priority_description = $priority[$priority_number];
	$sensor_name = $sensor[$sensor_id_number];
	if ($generator_number == 0) {
	$snort_id_description = $snort_id_0[$snort_id_number];
	} elsif ($generator_number == 1) { 
	$snort_id_description = "Rule Triggered Event";	
	} elsif ($generator_number == 2) { 
	$snort_id_description = "Rule Triggered Event";	
	} elsif ($generator_number == 3) { 
	$snort_id_description = "Rule Triggered Event";	
	} elsif ($generator_number == 102) { 
	$snort_id_description = "Rule Triggered Event";	
	} elsif ($generator_number == 105) { 
	$snort_id_description = $snort_id_105[$snort_id_number];	
	} elsif ($generator_number == 106) { 
	$snort_id_description = $snort_id_106[$snort_id_number];	
	} elsif ($generator_number == 111) { 
	$snort_id_description = $snort_id_111[$snort_id_number];	
	} elsif ($generator_number == 116) { 
	$snort_id_description = $snort_id_116[$snort_id_number];	
	} elsif ($generator_number == 119) { 
	$snort_id_description = $snort_id_119[$snort_id_number];	
	} elsif ($generator_number == 120) {
	$snort_id_description = $snort_id_120[$snort_id_number];	
	} elsif ($generator_number == 122) {
	$snort_id_description = $snort_id_122[$snort_id_number];	
	} elsif ($generator_number == 123) {
	$snort_id_description = $snort_id_123[$snort_id_number];	
	} elsif ($generator_number == 124) {
	$snort_id_description = $snort_id_124[$snort_id_number];	
	} elsif ($generator_number == 125) {
	$snort_id_description = $snort_id_125[$snort_id_number];	
	} elsif ($generator_number == 126) {
	$snort_id_description = $snort_id_126[$snort_id_number];	
	} elsif ($generator_number == 129) {
	$snort_id_description = $snort_id_129[$snort_id_number];	
	} elsif ($generator_number == 130) {
	$snort_id_description = $snort_id_130[$snort_id_number];	
	} elsif ($generator_number == 131) {
	$snort_id_description = $snort_id_131[$snort_id_number];		
	} elsif ($generator_number == 1001) {
	$snort_id_description = "Rule Triggered Event";			
	} elsif ($generator_number == 1003) {
	$snort_id_description = "Rule Triggered Event";		
	} elsif ($generator_number == 2001) {
	$snort_id_description = "Rule Triggered Event";		
	} elsif ($generator_number == 2003) {
	$snort_id_description = "Rule Triggered Event";		
}

	$unix_time_description = $time{'yyyy-mm-dd'."T".'hh:mm:ss',$event_seconds};
	$event_message ="$classification_name,$generator_name,$impact_description,$priority_description,$sensor_name,$unix_time_description,[$generator_number:$snort_id_number:$version_number] $snort_id_description: [Classification: $classification_description] [Priority: $priority_number] {$ip_protocol_description} $source_address:$source_port -> $destination_address:$destination_port";
	print $log_fh ("$line_out$event_message\n");		#initial output function is to the screen, later this will be to a file of our choosing...
#	print "$line_out$event_message\n";
#	print "$snort_id_description\n";
#	print "$generator_id_subtable\n";
#	print "$snort_id_number\n";
#	print "$generator_number\n";
}

close $log_fh;
close $input;
exit 0;
# Example of a Line by line while loop
#    while (defined($line = <STDIN>)) {
#      print "I saw $line";
# we would want to use this, but change the actions, so instead of print we need to match the variables we have defined as constants...(note we need to double-quote the IP addresses)
#	$classification_number = ;
#	$generator_number = ;
#	$impact_number = ;
#	$ip_protocol_number = ;
#	$priority_number = ;
#	$sensor_id_number = ;
#	$snort_id_number = ;
#	$event_seconds = ;
#	$version_number = ;
#	$source_address = "$1";
#	$source_port = ;
#	$destination_address = "";
#	$destination_port = ;
#    }
	
#	print $log_fh "$_$event_message\n";
	#}

########################################################################################
# Subroutines
########################################################################################
sub graceful_close {
	print "In Graceful Close...\n"; 
	close $log_fh;
	close $input;
	print "Done.\n"; 
	exit 0;
}
########################################################################################
