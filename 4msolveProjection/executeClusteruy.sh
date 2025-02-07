#!/bin/bash
#SBATCH --job-name=msolveISSAC
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=380G
#SBATCH --time=120:00:00
#SBATCH --tmp=10G
#SBATCH --partition=normal
#SBATCH --qos=normal
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mvaldes@fing.edu.uy

threads=20
#maxPairs=1000
elimVars=29 # variables to eliminate 2*C^n_2 - 1

# input file (other folder)
input=../1idealGens/n6p0ideal.ms

# output file (here)
output=n6p0baseElim.ms

# code directory
dirCode=~/logFekete/4msolveProjection/
cd $dirCode

source /etc/profile.d/modules.sh

# reduced Grobner basis with msolve

# with avx512 instructions (binary from msolve webpage)
# submit execution with: sbatch --exclude=node31,node40,node41,node42,node43,node44,node45,node46,node47 executeClusteruy.sh
../msolve073IntelAvx512 -e $elimVars -g 2 -v 2 -t $threads -f $input -o $output

# without avx512 instructions (binary from msvole webpage)
# submit execution with: sbatch --nodelist=node41 executeClusteruy.sh

# show job stats
sstat -j $SLURM_JOB_ID.batch --format=JobID,MaxPages,MaxRSS,MaxVMSize,NTasks,NodeList

