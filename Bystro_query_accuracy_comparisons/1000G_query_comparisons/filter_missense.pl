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

# Filters  missense variants

if(@ARGV < 1) {
  die "annotationFile ; Will do manual search for nonSynonymous";
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
my @gnomadKept;
while(<$snpFh>) {
  chomp;

  # gzip \$_ => \$compressed or die "wtf";

  my @fields = split '\t', $_;

  if($. == 1) {
    my $i = 0;

    for my $field(@fields) {
      if($field eq 'ensembl.exonicAlleleFunction') {
        $refSeqIdx = $i;
        last;
      }

      
      $i++;
    }

    say $_;
    next;
  }

  my $missenseFound;


  if($fields[$refSeqIdx] !~ /nonSynonymous/g) {
    next;
  }

  $missenseFound = 1;
  $countMissense++;
  say $_;
}

say STDERR "Found $countMissense ensembl.exonicAlleleFunction: nonSynonymous";
