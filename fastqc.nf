nextflow.enable.dsl = 2




params.path = null  

files_channel = Channel.fromFilePairs("${params.path}/*R[1,2].fastq.gz", checkIfExists: true )

process fastqc {
    publishDir "${params.path}/fastqc_result", mode: 'copy'
    container "https://depot.galaxyproject.org/singularity/fastqc%3A0.11.9--0"
    input:
        tuple val(sample_id), path(files)
    output:
        file "*_fastqc.*" 
    """
    fastqc -t 2 ${files[0]} ${files[1]}  
    """
}

process multiQc {
 publishDir "${params.path}", mode: "copy", overwrite: true
 container "https://depot.galaxyproject.org/singularity/multiqc%3A1.13a--pyhdfd78af_1"
  input:
       file "fastqc/*" 
    
  output:
       file "multiqc_report.html"

  """
  multiqc .
  """
}

workflow {  
if(params.path== null) {
        print "ERROR: Please provide an path to your *.fastq.gz folder(e.g. --path  home/fastQfiles)"
        System.exit(1)
    }
fastq_channel=fastqc(files_channel)   
multiQc(fastq_channel.collect())

}


//Wedad Ahmed