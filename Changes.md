# Changes

This file lists updates and changes to the current version of [Bystro](https://bystro.io) online
web application and available annotation files.

Updates to the software are enumerated in the Bystro repository:

- https://github.com/wingolab-org/bystro/blob/master/Changes.md

## Date: 01-04-2018

  * By default **maf** query shortcut (i.e "maf < .01") now searches **gnomad.exomes.af** + **gnomad.genomes.af** rather than **dbSNP.alleleFreqs**
    
  * In Table 3 and Supplementary file 1: Table S5 of the publication, Bystro had been configured to use **ensembl** transcripts, in order to make a more direct comparison with Gemini.
  * We have revertd back to **refSeq** for the publicly available databases and online service.
    * Users are free to build ensembl tracks when using the command line version