#!/bin/bash

export OUT=../output/

#alinhamento

cd ../data

bwa mem -M -t 40 hg19.fasta 510-7-BRCA_S8_L001_R1_001.fastq.gz 510-7-BRCA_S8_L001_R2_001.fastq.gz > ${OUT}BRCA_aligned.sam


#transformar .sam em .bam, gerar .bai, sortir

samtools sort ${OUT}BRCA_aligned.sam > ${OUT}BRCA_aligned.bam

samtools sort ${OUT}BRCA_aligned.sam > ${OUT}BRCA_aligned.sorted.bam

samtools index ${OUT}BRCA_aligned.sorted.bam


#realizar a genotipagem

freebayes -f hg19.fasta ${OUT}BRCA_aligned.sorted.bam -v ${OUT}BRCA_var.vcf --targets BRCA.list

#Realizar a anotação

snpEff ann hg19 ${OUT}BRCA_var.vcf > ${OUT}BRCA_var.ann.vcf


#contagem de reads no fastq
#echo $(cat BRCA_S8_L001_R1_001.fastq|wc -l)/4
#awk '{s++}END{print s/4}' file.fastq


#contagem de contigs
#grep -c "LOCUS" hg19.fasta
#grep -c "^>" hg19.f

#alinhamentos em determinada região
#samtools view -L chr17.lis
#BRCA_aligned.sorted.bam -c

#samtools view -c -F 4 BRCA_aligned.sam

