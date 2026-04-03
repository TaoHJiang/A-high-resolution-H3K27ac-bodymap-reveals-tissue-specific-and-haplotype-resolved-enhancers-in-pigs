#!/bin/bash
#PBS -N FRIP_score
#PBS -l nodes=1:ppn=2,mem=2gb
#PBS -e /home/pencode/qsublog
#PBS -o /home/pencode/qsublog
#PBS -m e
#PBS -q cu
#PBS -t 0-1

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
#cd ${tmpdir}/${Work_dir}
input=/home/pencode/DIP3/H3K27me3_new_30
output=/home/pencode/DIP3/H3K27me3_new_30
cd ${input}
R2=(`ls *bowtie2.mapped.bam`)
echo "R2 fastq file is: ${R2[$PBS_ARRAYID]}"
Sample=`echo ${R2[$PBS_ARRAYID]} | awk '{split($0,arra,"_bowtie2.mapped.bam"); print arra[1]}'`
#cp ${Sample}_bowtie2.mapped.bam  ${tmpdir}/${Work_dir}
#cd ${output}
#cp ${Sample}_peaks.narrowPeak ${tmpdir}/${Work_dir}

cd ${tmpdir}/${Work_dir}

totalReads=$(samtools view -c ${input}/${Sample}_bowtie2.mapped.bam|awk '{print $1}')
Reads_in_peak=$(bedtools sort -i ${input}/${Sample}*Peak | bedtools merge -i stdin | bedtools intersect -u -a ${input}/${Sample}_bowtie2.mapped.bam -b stdin -ubam | samtools view -c|awk '{print $1}') 

echo 'Reads_in_peak: ' $Reads_in_peak>>${Sample}_FRIP_score.txt
echo 'totalReads: ' $totalReads >>${Sample}_FRIP_score.txt

echo 'FRiP value:' $(bc <<< "scale=2;100*$Reads_in_peak/$totalReads")'%' >>${Sample}_FRIP_score.txt


cp ${Sample}_FRIP_score.txt ${output}
echo "Current working directory is ${tmpdir}/${Work_dir}>)"
#echo "Using $nprocs processing and 
#hostname

#echo "Remove tmp files at ${Work_dir}"
rm -rf ${tmpdir}/${Work_dir}
#conda deactivate
#echo "Job finished at:" `date`
