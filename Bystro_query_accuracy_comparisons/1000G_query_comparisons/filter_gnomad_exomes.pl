#! /usr/bin/perl
use 5.10.0;
use strict;
use warnings;

use DDP;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use List::Util qw(reduce);
use Math::Round qw(round);
use IO::Compress::Gzip qw(gzip $GzipError) ;
use MCE::Loop;
use Scalar::Util qw/looks_like_number/;
use Math::SigFigs qw(:all);

# Will filter gnomad.exomes.af < .001

if(@ARGV < 1) {
  die "annotationFile ; Will do manual search for gnomad.exomes.af < .001)";
}

my $snpFh;
if($ARGV[0] =~ /\.gz$/) {
  open($snpFh, '-|', "pigz -d -c $ARGV[0]");
} else {
  open($snpFh, '<', $ARGV[0]);
}

my $caddIdx;
my $gnomadIdx;
my $refSeqIdx;
my $countOk = 0;
my $countMissense = 0;
my $countGnomad = 0;
my $countCadd = 0;
my @gnomadKept;
while(<$snpFh>) {
  chomp;

  # gzip \$_ => \$compressed or die "wtf";

  my @fields = split '\t', $_;

  if($. == 1) {
    my $i = 0;

    for my $field(@fields) {
      if($field eq 'gnomad.exomes.af') {
        $gnomadIdx = $i;
        last;
      }

      
      $i++;
    }

    say $_;
    next;
  }

  my $gnomadVal = $fields[$gnomadIdx];

  if($gnomadVal eq '!') {
    next;
  }

  $gnomadVal = FormatSigFigs($gnomadVal,3);

  if($gnomadVal < .001) {
    say $_;
    $countGnomad++;
  }
}

say STDERR "Found $countGnomad gnomad.exomes.af < .001 sites";
