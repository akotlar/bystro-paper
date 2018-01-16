# [Bystro](https://bystro.io) Manuscript Repository

This repository contains data pertinent to Bystro's manuscript.

## About

[Bystro](https://bystro.io) is a free online sequencing annotator coupled with a powerful natural-
language search engine. It enables users to upload next generation sequencing
data, including large data sets (i.e., up to terabyte-size) and perform
complex filtering in a fast and reliable manner.

Try it @ https://bystro.io

## Citation

Kotlar AV, Trevino CE, Zwick ME, Cutler DJ, and Wingo TS. Bystro: rapid online
variant annotation and natural-language filtering at whole-genome scale. 2018.
Genome Biol. Accepted: 04-01-2018.

## Changes

Bystro is an actively developed software project and the web application is
also updated with updated genomic data as they become available. Thus, we
expect queries on exemplar data may change in subtle ways over time. Changes
that are likely to alter these results and major version updates will be
documented in the [Changes.md](./Changes.md) file in this repository.

## Manuscripts

The final manuscript may be found [here](https://dx.doi.org/10.1186/s13059-018-1387-3).

The pre-print manuscript may be found [here](https://www.biorxiv.org/content/early/2017/08/09/146514).

## Software

The Bystro command line software and database is available @
https://github.com/akotlar/bystro

Bystro is routinely updated with the additional and updated data sources that
may alter results for analyses performed in the manuscripts. These *Differences*
are enumerated in the [Changes.md](./Changes.md) file in this repository.

## Data Used

1. [1000G Phase3 Chr1 50K lines (**8MB**)](https://s3.amazonaws.com/1000g-vcf/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.rand50klines.vcf.gz)
2. [1000G Phase3 Chr1 100K lines (**17MB**)](https://s3.amazonaws.com/1000g-vcf/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.100Klines_rand.vcf.gz)
3. [1000G Phase3 Chr1 150K lines (**24MB**)](https://s3.amazonaws.com/1000g-vcf/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.150Klines_rand.vcf.gz)
3. [1000G Phase3 Chr1 200K lines (**33MB**)](https://s3.amazonaws.com/1000g-vcf/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.200Klines_rand.vcf.gz)
4. [1000G Phase3 Chr1 250K lines (**40MB**)](https://s3.amazonaws.com/1000g-vcf/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.250Klines_rand.vcf.gz)
4. [1000G Phase3 Chr1 300K lines (**50MB**)](https://s3.amazonaws.com/1000g-vcf/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.300Klines_rand.vcf.gz)
5. [1000G Phase3 Chr1 1M lines (**166MB**)](https://s3.amazonaws.com/1000g-vcf/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.1Mlines.vcf.gz)
6. [1000G Phase3 Chr1 2M lines (**327MB**)](https://s3.amazonaws.com/1000g-vcf/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.2Mlines.vcf.gz)
7. [1000G Phase3 Chr1 4M lines (**650MB**)](https://s3.amazonaws.com/1000g-vcf/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.4M.vcf.gz)
8. [1000G Phase3 Chr1 (**1GB**)](https://s3.amazonaws.com/1000g-vcf/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz)
9. [1000G Phase3 (**14.5GB**)](https://s3.amazonaws.com/1000g-vcf/phase3.vcf.gz)
    * **Warning: 853GB uncompressed**
10. [1000G Phase1 (**129GB**)](https://s3.amazonaws.com/1000g-vcf/phase1.vcf.gz)
    * **Warning: 890GB uncompressed**
11. [Yen et al. 2017 accuracy test data](https://s3.amazonaws.com/1000g-vcf/13073_2016_396_MOESM2_ESM.vcf)
## Query Accuracy

##### Compares Bystro to Perl scripts in matching various annotation features

1. Results and scripts used: [Bystro_query_accuracy_comparisons](./Bystro_query_accuracy_comparisons)
2. Full results + raw annotations: [Bystro_query_accuracy_comparisons.tar.gz
**Warning: 1.4GB**](https://www.dropbox.com/s/3o1rhp9in6pzo7k/Bystro_query_accuracy_comparisons.tar.gz?dl=0)

## Bystro/GEMINI _*de novo*_ query comparison

##### Identifying _de novo_ variants using Bystro, compared with GEMINI

1. [Bystro_GEMINI_denovo_comparison](./Bystro_GEMINI_denovo_comparison)
