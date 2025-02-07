#!/bin/bash
#SBATCH --job-name=msolveISSAC
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=50G
#SBATCH --time=60:00:00
#SBATCH --tmp=10G
#SBATCH --partition=normal
#SBATCH --qos=normal
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mvaldes@fing.edu.uy

threads=20
#maxPairs=1000

# input file (other folder)
input=../1idealGens/n4p0ideal.ms

# output file (here)
output=n4p0base.ms

# code directory
dirCode=~/logFekete/2msolveBasis/
cd $dirCode

source /etc/profile.d/modules.sh

# reduced Grobner basis with msolve

# with avx512 instructions (binary from msolve webpage)
# submit execution with: sbatch --exclude=node31,node40,node41,node42,node43,node44,node45,node46,node47 executeClusteruy.sh
../msolve073IntelAvx512 -g 2 -v 2 -t $threads -f $input -o $output

# without avx512 instructions (binary from msvole webpage)
# submit execution with: sbatch --nodelist=node41 executeClusteruy.sh

# show job stats
sstat -j $SLURM_JOB_ID.batch --format=JobID,MaxPages,MaxRSS,MaxVMSize,NTasks,NodeList

