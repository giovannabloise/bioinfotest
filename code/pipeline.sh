#!/bin/bash

export OUT=../output/

#mapear contra genoma de referência

cd ../data

bwa mem -M hg19.fasta 510-7-BRCA_S8_L001_R1_001.fastq.gz 510-7-BRCA_S8_L001_R2_001.fastq.gz > ${OUT}BRCA_aligned.sam

#transformar .sam em .bam, gerar .bai, sortir

samtools sort ${OUT}BRCA_aligned.sam > ${OUT}BRCA_aligned.bam
samtools sort ${OUT}BRCA_aligned.sam > ${OUT}BRCA_aligned.sorted.bam
samtools index ${OUT}BRCA_aligned.sorted.bam

#realizar a genotipagem

freebayes -f hg19.fasta ${OUT}BRCA_aligned.sorted.bam -v ${OUT}BRCA_var.vcf --targets BRCA.list

#Realizar a anotação

snpEff ann hg19 ${OUT}BRCA_var.vcf > ${OUT}BRCA_var.ann.vcf
