# Fastqc-Multiqc-nextflow

// N.b: every time you need to run this script  without singularity write this command:
// nextflow run fastqc.nf  --path "your folder path " 

// this script should be in the  same  folder of singularity script (nextflow.config) incase :
// you run it using singularity and use the following command:
//nextflow run fastqc.nf -profile singularity --path "your folder path " 

in case you downloaded the fastqc and multiqc tools on your terminal :
you do not need to use singularity
