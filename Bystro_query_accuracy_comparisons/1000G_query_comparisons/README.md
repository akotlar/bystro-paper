#Notes
There is a small difference in outputs, because Elasticsearch outputs the discordant field as false, as it is stored as a boolean, while Bystro's annotator outputs a 0, as Perl doesn't have a dedicated "false", and we have thus far chosen not to waste CPU cycles, disk space writing out "false' in the annotation.

# Procedure for 1M cadd > 15:

## manual filter on full dataset
`perl ./filter_cadd_15.pl ../Bystro_annotations/1M_annotation_ensembl.tsv.gz > 1000G_1M_cadd_15/1M_annotation_cadd_15_manual_filter.tsv`

## sort both the manual and nlp query results
`tail -n +2 1000G_1M_cadd_15/cadd_15_alt_actg.annotation.tsv | sort -k1,1 -k2,2n > 1000G_1M_cadd_15/cadd_15_alt_actg.annotation.sorted.tsv`


`tail -n +2 1000G_1M_cadd_15/1M_annotation_cadd_15_manual_filter.tsv | sort -k1,1 -k2,2n > 1000G_1M_cadd_15/1M_annotation_cadd_15_manual_filter.sorted.tsv`

## replace the boolean "false" with 0's to match initial output
`sed -i -e 's/false/0/g' 1000G_1M_cadd_15/cadd_15_alt_actg.annotation.sorted.tsv`

## diff
### we cut only first 41 columns, because minor differences exist in Elasticsearch's handling of 0 numerical values, and Perl's (Elasticsearch outputs/stores undefined value)
`diff <(cut -f1-41 1000G_1M_cadd_15/1M_annotation_cadd_15_manual_filter.sorted.tsv) <(cut -f1-41 1000G_1M_cadd_15/cadd_15_alt_actg.annotation.sorted.tsv) > 1000G_1M_cadd_15/diff.log`

# Procedure for 1M missense cadd > 15 maf < .001
## manual filter
`./filter_gnomad_exomes_missense.pl ../Bystro_annotations/1M_annotation_ensembl.tsv.gz > 1000G_1M_missense_cadd_15_maf_001/1M_missense_cadd_15_maf_001_manual_filter.tsv`

## replace boolean false with Perl 0
`sed -i -e 's/false/0/g' 1000G_1M_missense_cadd_15_maf_001/1M_missense_cadd_15_maf_001.annotation.tsv`

## sort
`tail -n +2 1000G_1M_missense_cadd_15_maf_001/1M_missense_cadd_15_maf_001.annotation.tsv | sort -k1,1 -k2,2n > 1000G_1M_missense_cadd_15_maf_001/1M_missense_cadd_15_maf_001.annotation.sorted.tsv`

`tail -n +2 1000G_1M_missense_cadd_15_maf_001/1M_missense_cadd_15_maf_001_manual_filter.tsv | sort -k1,1 -k2,2n > 1000G_1M_missense_cadd_15_maf_001/1M_missense_cadd_15_maf_001_manual_filter.sorted.tsv`

## diff
### Note: in this case cutting f1-41 has no added benefit; the 0 vs null issue not found in this subset
`diff <(cut -f1-41 1000G_1M_missense_cadd_15_maf_001/1M_missense_cadd_15_maf_001_manual_filter.sorted.tsv) <(cut -f1-41 1000G_1M_missense_cadd_15_maf_001/1M_missense_cadd_15_maf_001.annotation.sorted.tsv) > 1000G_1M_missense_cadd_15_maf_001/diff.log`

# Procedure for 1M cadd > 15 (no actg restriction)
## manual filter
`perl ./filter_cadd_15_all.pl ../Bystro_annotations/1M_annotation_ensembl.tsv.gz > 1000G_1M_cadd_15_all/1M_annotation_ensembl.cadd_15_all.tsv`

## replace boolean false with Perl 0 for data saved from search engine
### Elasticsearch outputs booleans as False; Bystro's Perl package as 0 for now. Informationally equivalent
`sed -i -e 's/false/0/g' 1000G_1M_cadd_15_all/1m_cadd_15_no_actg.annotation_nlp.tsv`

## sort
`tail -n +2 1000G_1M_cadd_15_all/1M_annotation_ensembl.cadd_15_all.tsv | sort -k1,1 -k2,2n > 1000G_1M_cadd_15_all/1M_annotation_ensembl.cadd_15_all.sorted.tsv`

`tail -n +2 1000G_1M_cadd_15_all/1m_cadd_15_no_actg.annotation_nlp.tsv | sort -k1,1 -k2,2n > 1000G_1M_cadd_15_all/1m_cadd_15_no_actg.annotation_nlp.sorted.tsv`

## diff
### we cut only first 41 columns, because minor differences exist in Elasticsearch's handling of 0 numerical values, and Perl's (Elasticsearch outputs/stores undefined value)
`diff <(cut -f1-41 1000G_1M_cadd_15_all/1m_cadd_15_no_actg.annotation_nlp.sorted.tsv) <(cut -f1-41 1000G_1M_cadd_15_all/1M_annotation_ensembl.cadd_15_all.sorted.tsv) > 1000G_1M_cadd_15_all/diff.log`

# Procedure for 1M alt:(A || C || T || G)
## manual filter
`perl ./filter_alt_actg.pl ../Bystro_annotations/1M_annotation_ensembl.tsv.gz > 1000G_Alt_ACTG/1M_alt_actg_manual_filter.tsv`

## shrink the downloaded annotation file, because it's huge
`pigz -d -c /Users/alexkotlar/Downloads/alt_actg/alt_actg.annotation.tsv.gz  | cut -f1-41 > 1000G_Alt_ACTG/alt_actg.annotation.41col.tsv`

## replace boolean false with Perl 0 for data saved from search engine
### Elasticsearch outputs booleans as False; Bystro's Perl package as 0 for now. Informationally equivalent
`sed -i -e 's/false/0/g' 1000G_Alt_ACTG/alt_actg.annotation.41col.tsv`

## sort
`tail -n +2 1000G_Alt_ACTG/1M_alt_actg_manual_filter.tsv | sort -k1,1 -k2,2n > 1000G_Alt_ACTG/1M_alt_actg_manual_filter.sorted.tsv`

`tail -n +2 1000G_Alt_ACTG/alt_actg.annotation.41col.tsv | sort -k1,1 -k2,2n > 1000G_Alt_ACTG/alt_actg.annotation.41col.sorted.tsv`

## diff
### we cut only first 41 columns, because minor differences exist in Elasticsearch's handling of 0 numerical values, and Perl's (Elasticsearch outputs/stores undefined value)
`diff <(cut -f1-41 1000G_Alt_ACTG/1M_alt_actg_manual_filter.sorted.tsv) 1000G_Alt_ACTG/alt_actg.annotation.41col.sorted.tsv`

# Procedure for gnomad.exomes.af < .001
## manual filter
`perl filter_gnomad_exomes.pl ../Bystro_annotations/1M_annotation_ensembl.tsv.gz > 1000G_1M_maf_001/1M_gnomad_001_manual_filter.tsv`

## replace boolean false with Perl 0 for data saved from search engine
### Elasticsearch outputs booleans as False; Bystro's Perl package as 0 for now. Informationally equivalent
`sed -i -e 's/false/0/g' 1000G_1M_maf_001/1m_maf_001.annotation.tsv`

## sort
`tail -n +2 1000G_1M_maf_001/1M_gnomad_001_manual_filter.tsv | sort -k1,1 -k2,2n > 1000G_1M_maf_001/1M_gnomad_001_manual_filter.sorted.tsv`

`tail -n +2 1000G_1M_maf_001/1m_maf_001.annotation.tsv | sort -k1,1 -k2,2n > 1000G_1M_maf_001/1m_maf_001.annotation.sorted.tsv`

## diff
### we cut only first 41 columns, because minor differences exist in Elasticsearch's handling of 0 numerical values, and Perl's (Elasticsearch outputs/stores undefined value)
`diff <(cut -f1-41 1000G_1M_maf_001/1M_gnomad_001_manual_filter.sorted.tsv) <(cut -f1-41 1000G_1M_maf_001/1m_maf_001.annotation.sorted.tsv) > 1000G_1M_maf_001/diff.log`

# Procedure for missense (nonsynonymous)
## manual filter
`perl ./filter_missense.pl ../Bystro_annotations/1M_annotation_ensembl.tsv.gz > 1000G_1M_missense/1M_annotation_ensembl_missense_manual_filter.tsv`

## replace boolean false with Perl 0 for data saved from search engine
### Elasticsearch outputs booleans as False; Bystro's Perl package as 0 for now. Informationally equivalent
`sed -i -e 's/false/0/g' 1000G_1M_missense/1m_missense.annotation.tsv`

## sort
`tail -n +2 1000G_1M_missense/1M_annotation_ensembl_missense_manual_filter.tsv | sort -k1,1 -k2,2n > 1000G_1M_missense/1M_annotation_ensembl_missense_manual_filter.sorted.tsv`

`tail -n +2 1000G_1M_missense/1m_missense.annotation.tsv | sort -k1,1 -k2,2n > 1000G_1M_missense/1m_missense.annotation.sorted.tsv`

## diff
### we cut only first 41 columns, because minor differences exist in Elasticsearch's handling of 0 numerical values, and Perl's (Elasticsearch outputs/stores undefined value)
`diff <(cut -f1-41 1000G_1M_missense/1M_annotation_ensembl_missense_manual_filter.sorted.tsv) <(cut -f1-41 1000G_1M_missense/1m_missense.annotation.sorted.tsv) > 1000G_1M_missense/diff.log`
