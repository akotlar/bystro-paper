#! /usr/bin/perl
use 5.10.0;
# If fully strict, Dave's code breaks
use strict 'vars';

use DDP;
use Digest::MD5 qw(md5 md5_hex md5_base64);
use List::Util qw(reduce);
use Math::Round qw(round);
use IO::Compress::Gzip qw(gzip $GzipError) ;
use MCE::Loop;
use Scalar::Util qw/looks_like_number/;
use Math::SigFigs qw(:all);

# use Math::BigFloat;

#  use bignum;
# if(@ARGV < 3) {
#   die "hg19bedFile snpFile gnomadVcf dryRun debug firstSampleIdx(optional)    .... Requires seq-vcf package";
# }

if(@ARGV < 1) {
  die "annotationFile ; Will do manual search for gnomad.exomes.af < .001 nonSynonymous cadd > 15)";
}


# open(my $bedFh, '<', $ARGV[0]);

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
      if ($field eq 'cadd') {
        $caddIdx = $i;
      } elsif($field eq 'gnomad.exomes.af') {
        $gnomadIdx = $i;
      } elsif($field eq 'ensembl.exonicAlleleFunction') {
        $refSeqIdx = $i;
      }

      
      $i++;
    }

    say $_;
    next;
  }
  # p $fields[$refSeqIdx];
  # my @refSeqVals = map { split ";", $_ } split /\|/, $fields[$refSeqIdx];
  my @caddVals = map { split ";", $_ } split /\|/, $fields[$caddIdx];
  my @gnomadVals = split /\|/, $fields[$gnomadIdx];

  # p @refSeqVals;
  # p @caddVals;
  # p @gnomadVals;
  my $missenseFound;
  my $caddFound;
  my $gnomadFound;

  for my $val (@gnomadVals) {
    my $num = FormatSigFigs($val,3);

    if($val ne '!' && $num < .001) {
      $gnomadFound = 1;
      push @gnomadKept, $num;
      $countGnomad++;
      last;
    }
  }

  for my $val (@caddVals) {
    if($val ne '!' && $val > 15) {
      $caddFound = 1;
      $countCadd++;
      last;
    }
  }

  if($fields[$refSeqIdx] !~ /nonSynonymous/g) {
    next;
  }

  $missenseFound = 1;
  $countMissense++;

  # for my $val (@refSeqVals) {
  #   if($val eq 'nonSynonymous') {
  #     $missenseFound = 1;
  #     $countMissense++;
  #     last;
  #   }
  # }

  if($caddFound && $gnomadFound && $missenseFound) {
    $countOk++;
    say $_;
  }
}

say STDERR "Kept $countOk values that were gnomad.exomes.af < .001 nonSynonymous cadd > 15";
say STDERR "Found $countCadd cadd > 15 sites";
say STDERR "Found $countGnomad gnomad.exomes.af < .001 sites";
say STDERR "Found $countMissense ensembl.exonicAlleleFunction: nonSynonymous";

my $max = 0;

for my $val (@gnomadKept) {
  if ($max < $val) {
    $max = $val;
  }
}

say STDERR "Max gnomad val accepted was $max";
