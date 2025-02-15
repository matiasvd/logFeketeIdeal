#!/bin/bash
#SBATCH --job-name=M2dimDegree
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100G
#SBATCH --time=10:00:00
#SBATCH --tmp=9G
#SBATCH --partition=normal
#SBATCH --qos=normal
#SBATCH --mail-type=ALL
#SBATCH --mail-user=usuario@dominio

source /etc/profile.d/modules.sh

# submit execution with command: sbatch executeClusteruyM2.sh

# create instance of M2 Singularity image (with the name of the job)
singularity instance start ~/m2_v1.24.11.sif $SLURM_JOB_ID

# code directory
dirCode=~/logFekete/3dimDegree
cd $dirCode

# needed to avoid error of "too many heap sections"
export GC_INITIAL_HEAP_SIZE=50G
export GC_MAXIMUM_HEAP_SIZE=50G

# execute M2 command (input basis file to use should be previously set in M2 file)
singularity exec instance://${SLURM_JOB_ID} M2 dimDegree.m2

# stop the instance
singularity instance stop $SLURM_JOB_ID

sstat -j $SLURM_JOB_ID.batch --format=JobID,MaxPages,MaxRSS,MaxVMSize,NTasks,NodeList
