#!/bin/bash
#PBS -N mapping
#PBS -l nodes=cu01:ppn=10,mem=20gb
#PBS -e /home/pencode/DIP3/qsublog
#PBS -o /home/pencode/DIP3/qsublog
#PBS -m e
#PBS -q cu
#PBS -t 29-29

# Kill script if any commands fail
set -e

#1. All anaconda2 and miniconda3 were setup at /opt/software
# You can source the two packages to import your software
#source /opt/software/miniconda3/bin/activate
source /opt/software/anaconda2/bin/activate

#2.Job Start Times
echo "Job Start at `date`"

#3.Get PBS parameter, The most used are nprocs and jobid
nprocs=`wc -l < $PBS_NODEFILE`


#4.Setup temp disk at computer nodes

uid="jiangtao" #change to your user id, I using zhiyan
ls_date=`date +m%d%H%M%S` #Using date and time as random number
Work_dir=${uid}_${ls_date}_${PBS_ARRAYID}  #Uniq String
tmpdir=/tmpdisk
echo "the temprory directory is $tmpdir"
mkdir -p ${tmpdir}/${Work_dir}

REF=/work/siyiLiu/refGenome/Gpig_index/bowtie2_DRC
input=/home/pencode/DIP3/CTCF_new_30/AJCT2250119147-CT140_30sample_20260126
output=/home/pencode/DIP3/CTCF_new_30/AJCT2250119147-CT140_30sample_20260126


cd ${input}
R2=(`ls *_val_1.fq.gz`)
echo "R2 fastq file is: ${R2[$PBS_ARRAYID]}"
Sample=`echo ${R2[$PBS_ARRAYID]} | awk '{split($0,arra,"_R1.raw_val_1.fq.gz"); print arra[1]}'`

cp ${Sample}_R1.raw_val_1.fq.gz ${Sample}_R2.raw_val_2.fq.gz ${tmpdir}/${Work_dir}

cd ${tmpdir}/${Work_dir}

/home/PersonalFiles/Liusiyi/software/bowtie2/bowtie2-2.5.1-linux-x86_64/bowtie2  -p 10 -x  ${REF} --local --very-sensitive --no-mixed --no-discordant --phred33  -I 10 -X 700  -1 ${Sample}_R1.raw_val_1.fq.gz -2 ${Sample}_R2.raw_val_2.fq.gz -S ${Sample}_bowtie2.sam &>${Sample}_bowtie2.txt

singularity exec  -B /tmpdisk:/tmpdisk /home/Singusoft/072.samtools.sif samtools view -F 0x04 -@ 10 ${Sample}_bowtie2.sam| awk -F '\t' 'function abs(x){return ((x < 0.0) ? -x : x)} {print abs($9)}'| sort | uniq -c | awk -v OFS="\t" '{print $2, $1/2}' > ${Sample}_fragmentLen.txt

singularity exec  -B /tmpdisk:/tmpdisk /home/Singusoft/072.samtools.sif samtools view -bS -F 0x04 -@ 10 ${Sample}_bowtie2.sam >${Sample}_bowtie2.mapped.bam

singularity exec  -B /tmpdisk:/tmpdisk /home/Singusoft/073.bedtools.sif bedtools bamtobed -bedpe -i ${Sample}_bowtie2.mapped.bam| awk 'BEGIN{OFS="\t"}{print $1,$2,$4,$6,$9,$10}' | grep -v 'chrM' | sort | uniq -c | awk 'BEGIN{mt=0;m0=0;m1=0;m2=0}($1==1){m1=m1+1} ($1==2){m2=m2+1} {m0=m0+1} {mt=mt+$1} END{printf "%d\t%d\t%d\t%d\t%f\t%f\t%f\n",mt,m0,m1,m2,m0/mt,m1/m0,m1/m2}' > ${Sample}.pbc.qc

rm ${Sample}_bowtie2.mapped.bam

singularity exec -B /tmpdisk:/tmpdisk /home/Singusoft/picard.sif java -Djava.io.tmpdir=${tmpdir}/${Work_dir} -jar /usr/local/bin/picard/picard.jar SortSam  I=${Sample}_bowtie2.sam O=${Sample}_bowtie2.sorted.sam SORT_ORDER=coordinate 

rm ${Sample}_bowtie2.sam

singularity exec -B /tmpdisk:/tmpdisk /home/Singusoft/picard.sif java  -Djava.io.tmpdir=${tmpdir}/${Work_dir} -jar /usr/local/bin/picard/picard.jar MarkDuplicates INPUT=${Sample}_bowtie2.sorted.sam \
OUTPUT=${Sample}_bowtie2.sorted.rmDup.sam REMOVE_DUPLICATES=true  \
CREATE_INDEX=true METRICS_FILE=${Sample}_sorted.metrics VALIDATION_STRINGENCY=LENIENT

rm ${Sample}_bowtie2.sorted.sam

singularity exec  -B /tmpdisk:/tmpdisk /home/Singusoft/072.samtools.sif samtools view -h -q 30 ${Sample}_bowtie2.sorted.rmDup.sam >${Sample}_bowtie2.sorted.rmDup.qualityScore.sam

rm ${Sample}_bowtie2.sorted.rmDup.sam

singularity exec  -B /tmpdisk:/tmpdisk /home/Singusoft/072.samtools.sif samtools view -bS -F 0x04 -@ 10 ${Sample}_bowtie2.sorted.rmDup.qualityScore.sam >${Sample}_bowtie2.mapped.bam

rm ${Sample}_bowtie2.sorted.rmDup.qualityScore.sam

singularity exec  -B /tmpdisk:/tmpdisk /home/Singusoft/072.samtools.sif samtools index -@ 10 ${Sample}_bowtie2.mapped.bam 


singularity exec -B /tmpdisk:/tmpdisk /home/Singusoft/142.macs.sif  macs2 callpeak -f BAMPE -t ${Sample}_bowtie2.mapped.bam -g 2.68e9 --qvalue 0.01 --nomodel --shift 0  -n  ${Sample} -B --SPMR --keep-dup all

cp  ${Sample}_bowtie2.txt ${Sample}.pbc.qc ${Sample}_fragmentLen.txt ${Sample}_sorted.metrics  ${output}

cp ${Sample}_bowtie2.mapped* ${output}

cp ${Sample}*xls ${Sample}*Peak *summit*  ${output}

echo "Current working directory is ${tmpdir}/${Work_dir}>)"
#echo "Using $nprocs processing and 
#hostname

#echo "Remove tmp files at ${Work_dir}"
rm -rf ${tmpdir}/${Work_dir}
#conda deactivate
#echo "Job finished at:" `date`

