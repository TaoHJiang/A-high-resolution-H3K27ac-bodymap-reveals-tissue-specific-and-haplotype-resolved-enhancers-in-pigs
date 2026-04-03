#!/bin/bash
#PBS -N TSS_score
#PBS -l nodes=1:ppn=5,mem=10gb
#PBS -e /home/pencode/qsublog
#PBS -o /home/pencode/qsublog
#PBS -m e
#PBS -q cu
#PBS -t 8-35

# Kill script if any commands fail
set -e

#1. All anaconda2 and miniconda3 were setup at /opt/software
# You can source the two packages to import your software
#source /opt/software/miniconda3/bin/activate
#source /opt/software/anaconda2/bin/activate

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
#mkdir -p ${tmpdir}/${Work_dir}
#cd ${tmpdir}/${Work_dir}
input=/home/pencode/raw_data/2025_Liver/mapping
output=/home/pencode/test/liver/HS_Rep
cd ${input}
R2=(`ls *bam|grep -E "H3K27ac|H3K4me3"`)
echo "R2 fastq file is: ${R2[$PBS_ARRAYID]}"
Sample=`echo ${R2[$PBS_ARRAYID]} | awk '{split($0,arra,"_bowtie2.mapped.bam"); print arra[1]}'`
#cp ${Sample}_bowtie2.mapped.bam ${Sample}_bowtie2.mapped.bam.bai  ${tmpdir}/${Work_dir}

#cd ${tmpdir}/${Work_dir}
singularity exec  -B ${input}:/tmpdisk -B ${output}:/tmpdisk2 /home/Singusoft/143.deeptools.sif bamCoverage -p 5 \
--normalizeUsing RPKM -b /tmpdisk/${Sample}_bowtie2.mapped.bam -o /tmpdisk2/${Sample}.bw

singularity exec  -B /tmpdisk:/tmpdisk /home/Singusoft/143.deeptools.sif computeMatrix scale-regions \
 -p 2  -b 2500 -a 2500  \
 -R  /home/pencode/genome/pig_gold/DRCv20_final5.1.gtf \
 -S ${Sample}.bw   \
 -o ${Sample}_TSS.gz  \
 --outFileSortedRegions ${Sample}_genes.bed \
 --outFileNameMatrix ${Sample}_matrix.tab 

singularity exec  -B /tmpdisk:/tmpdisk /home/Singusoft/143.deeptools.sif  plotHeatmap -m ${Sample}_TSS.gz -out ${Sample}_TSS.png


#cp ${Sample}_TSS.png ${Sample}.bw ${Sample}_matrix.tab  ${output}
#cp  ${Sample}.bw ${output}
echo "Current working directory is ${tmpdir}/${Work_dir}>)"
#echo "Using $nprocs processing and 
#hostname

#echo "Remove tmp files at ${Work_dir}"
#rm -rf ${tmpdir}/${Work_dir}
#conda deactivate
#echo "Job finished at:" `date`
