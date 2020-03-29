# elan-pull
A nextflow pipeline for filtering files based on QC results copying them to a location of your choosing.
This repository is under development and you should expect breaking changes at any time.
This pipeline was designed to handle uploaded data for the COG-UK consortium.

## Execute

```
nextflow run elan-pull.nf --location <path> --breadth 50.00 --depth 10.00
```

### Params

* `location` location to pull filtered artifacts
* `breadth` filter records by the percentage of the FASTA that is not ambiguous
* `depth` filter records that do not have at least `breadth` percent of the BAM covered to at least this depth

