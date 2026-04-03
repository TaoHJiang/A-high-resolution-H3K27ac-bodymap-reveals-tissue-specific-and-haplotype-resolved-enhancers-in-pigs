#!/bin/bash
#PBS -N haplo
#PBS -l nodes=1:ppn=5,mem=10gb
#PBS -e /home/pencode/qsublog
#PBS -o /home/pencode/qsublog
#PBS -m e
#PBS -q cu
#PBS -t 0-141

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
input=/home/PersonalFiles/pencode/12_CUT_Tag/2024_H3K4me3/bam
output=/work/jiangtao/2024_H3K4me3_phase/bam
cd ${input}
R2=(`ls *4M*bam`)
echo "R2 fastq file is: ${R2[$PBS_ARRAYID]}"
Sample=`echo ${R2[$PBS_ARRAYID]} | awk '{split($0,arra,"_bowtie2.mapped.bam"); print arra[1]}'`
cp ${Sample}_bowtie2.mapped.bam ${Sample}_bowtie2.mapped.bam.bai ${tmpdir}/${Work_dir}
#cp /home/Softwares/HS4M_dipcall_phased.vcf.gz ${tmpdir}/${Work_dir}

cd ${tmpdir}/${Work_dir}
singularity exec -B /tmpdisk:/tmpdisk /home/Singusoft/8.whatshap.sif whatshap haplotag -o ${Sample}_haplotagged.bam --ignore-read-groups --reference /home/pencode/genome/pig_gold/DRC.MotherHap.fa /home/pencode/2024H3K4me3/haplotye/ref/HS4M_dipcall_phased.vcf.gz ${Sample}_bowtie2.mapped.bam

samtools view -H ${Sample}_bowtie2.mapped.bam > header.sam
samtools view -@ 5 -h ${Sample}_haplotagged.bam | awk -F '\t' '$0 ~ "HP:i:1"' >H1
samtools view -@ 5 -h ${Sample}_haplotagged.bam | awk -F '\t' '$0 ~ "HP:i:2"' >H2

cat header.sam H1 >H1_head
cat header.sam H2 >H2_head
samtools view -bS H1_head >${Sample}_haplotagged_H1.bam
samtools view -bS H2_head >${Sample}_haplotagged_H2.bam

singularity exec -B /tmpdisk:/tmpdisk /home/Singusoft/142.macs.sif macs2 callpeak -f BAMPE -t ${Sample}_haplotagged_H1.bam -g 2.68e9 --qvalue 0.01 --nomodel --shift 0  -n  ${Sample}_H1 -B --SPMR --keep-dup all

singularity exec -B /tmpdisk:/tmpdisk /home/Singusoft/142.macs.sif macs2 callpeak -f BAMPE -t ${Sample}_haplotagged_H2.bam -g 2.68e9 --qvalue 0.01 --nomodel --shift 0  -n  ${Sample}_H2 -B --SPMR --keep-dup all

cp ${Sample}_haplotagged.bam ${Sample}_haplotagged_H1.bam ${Sample}_haplotagged_H2.bam ${Sample}_H1*  ${Sample}_H2* ${output}

echo "Current working directory is ${tmpdir}/${Work_dir}>)"
#echo "Using $nprocs processing and 
#hostname

#echo "Remove tmp files at ${Work_dir}"
rm -rf ${tmpdir}/${Work_dir}
#conda deactivate
#echo "Job finished at:" `date`
