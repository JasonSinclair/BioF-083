#Author: Jason Sinclair
#Description: this is a pipleine for RNAseq
#letting shell know where the programs are
source /etc/profile.d/markcbm.sh
cp -R /home/manager/linux Desktop/.
cd ~/Desktop/linux/advanced/rnaseq/
fastqc fastq/*.fastq
cd index
bowtie-build mm9_chr1.fa mm9_chr1
cd ..
tophat2  -G mm9_chr1.gtf -o  tophat_wt/  index/mm9_chr1 fastq/myoblast_wt.fastq
tophat2  -G mm9_chr1.gtf -o  tophat_del/  index/mm9_chr1 fastq/myoblast_del.fastq
ls
ls tophat_wt/
ls tophat_del/
cat tophat_wt/align_summary.txt 
cat tophat_del/align_summary.txt 
samtools19 index tophat_wt/accepted_hits.bam
samtools19 index tophat_del/accepted_hits.bam
cuffdiff --no-update-check -o cuffdiff_out -L wt,del mm9_chr1.gtf tophat_wt/accepted_hits.bam tophat_del/accepted_hits.bam
ls -lh cuffdiff_out
echo "The RNA-Seq pipline is complete"
