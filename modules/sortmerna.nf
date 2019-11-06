/************************************************************************
* SORTMERNA
*
* Remove rRNA reads
************************************************************************/
process sortmerna {
  conda 'envs/sortmerna.yaml'
  publishDir "${params.output}/${params.dir}", mode: 'copy', pattern: "${name}*.other.fastq"
  publishDir "${params.output}/${params.dir}", mode: 'copy', pattern: "*.log"

  input:
  tuple val(name), file(reads)
  file(db)

  output:
  tuple val(name), file("${name}*.other.fastq")

  script:
  if (params.mode == 'single') {
  """
  sortmerna --ref ./rRNA_databases/silva-bac-16s-id90.fasta,./rRNA_databases/silva-bac-16s-id90:./rRNA_databases/silva-bac-23s-id98.fasta,./rRNA_databases/silva-bac-23s-id98:./rRNA_databases/silva-arc-16s-id95.fasta,./rRNA_databases/silva-arc-16s-id95:./rRNA_databases/silva-arc-23s-id98.fasta,./rRNA_databases/silva-arc-23s-id98:./rRNA_databases/silva-euk-18s-id95.fasta,./rRNA_databases/silva-euk-18s-id95:./rRNA_databases/silva-euk-28s-id98.fasta,./rRNA_databases/silva-euk-28s-id98:./rRNA_databases/rfam-5s-database-id98.fasta,./rRNA_databases/rfam-5s-database-id98:./rRNA_databases/rfam-5.8s-database-id98.fasta,./rRNA_databases/rfam-5.8s-database-id98 \
--reads ${reads[0]} \
--aligned ${name}.aligned.fastq \
--other ${name}.other.fastq \
--sam --fastx --log --blast 1 --num_alignments 1 -v 
  """
  }
  else {
  """
  """         
  }
}

/*
There is already Sortmerna v3 available, however, not on conda. 
Attention: sortmerna v3 has input parameters for plain and gzipped files. 
Thus, fastp could return gzipped files then. 
--threads ${params.cores} also only supported in v3
*/