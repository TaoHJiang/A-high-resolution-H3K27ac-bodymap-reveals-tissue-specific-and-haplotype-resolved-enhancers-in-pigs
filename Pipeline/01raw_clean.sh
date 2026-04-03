#!/bin/bash
#PBS -N raw_clean
#PBS -l nodes=1:ppn=10,mem=20gb
#PBS -e /home/pencode/DIP3/qsublog
#PBS -o /home/pencode/DIP3/qsublog
#PBS -m e
#PBS -q cu
#PBS -t 0-29

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
input=/home/pencode/DIP3/CTCF_new_30/AJCT2250119147-CT140_30sample_20260126
output=/home/pencode/DIP3/CTCF_new_30/AJCT2250119147-CT140_30sample_20260126

cd ${input}
R2=(`ls  *_R1.raw.fq.gz`)
echo "R2 fastq file is: ${R2[$PBS_ARRAYID]}"
Sample=`echo ${R2[$PBS_ARRAYID]} | awk '{split($0,arra,"_R1.raw.fq.gz"); print arra[1]}'`
#cp ${Sample}_R1.raw.fq.gz ${Sample}_R2.raw.fq.gz ${tmpdir}/${Work_dir}

cd ${tmpdir}/${Work_dir}
/opt/software/anaconda2/bin/trim_galore -j 10 --paired ${input}/${Sample}_R1.raw.fq.gz ${input}/${Sample}_R2.raw.fq.gz --gzip -o ./

cp ${Sample}*gz  ${output}

echo "Current working directory is ${tmpdir}/${Work_dir}>)"
#echo "Using $nprocs processing and 
#hostname

#echo "Remove tmp files at ${Work_dir}"
rm -rf ${tmpdir}/${Work_dir}
#conda deactivate
#echo "Job finished at:" `date`
