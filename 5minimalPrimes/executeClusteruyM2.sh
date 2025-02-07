#!/bin/bash
#SBATCH --job-name=M2minPrimes
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100G
#SBATCH --time=20:00:00
#SBATCH --tmp=9G
#SBATCH --partition=normal
#SBATCH --qos=normal
#SBATCH --mail-type=ALL
#SBATCH --mail-user=usuario@dominio

source /etc/profile.d/modules.sh

# create instance of M2 Singularity image (with the name of the job)
singularity instance start ~/m2-v1.2_latest.sif $SLURM_JOB_ID

# code directory
dirCode=~/logFekete/5minimalPrimes/
cd $dirCode

# needed to avoid error of "too many heap sections"
export GC_INITIAL_HEAP_SIZE=50G
export GC_MAXIMUM_HEAP_SIZE=50G

# execute M2 command (factor should be previously set in M2 file)
singularity exec instance://${SLURM_JOB_ID} M2 minPrimes.m2

# stop the instance
singularity instance stop $SLURM_JOB_ID

sstat -j $SLURM_JOB_ID.batch --format=JobID,MaxPages,MaxRSS,MaxVMSize,NTasks,NodeList
