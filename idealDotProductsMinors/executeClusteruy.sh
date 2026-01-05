#!/bin/bash
#SBATCH --job-name=DotProdMinors
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=350G
#SBATCH --time=120:00:00
#SBATCH --tmp=10G
#SBATCH --partition=normal
#SBATCH --qos=normal
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mvaldes@fing.edu.uy

threads=40
# maxPairs=1000

# input file
input=n7p0idealMaxRank3.ms

# output file
output=n7p0idealMaxRank3BasisLT.ms

# code directory
dirCode=~/idealDotProductsMinors/
cd $dirCode

# path to msolve (relative to dirCode)
# binMsolve=~/msolve094amdAVX512
binMsolve=~/msolve094IntelAVX512
# binMsolve=~/msolve094Intel

source /etc/profile.d/modules.sh

# reduced Grobner basis with msolve

# with avx512 instructions (binary from msolve webpage)
# submit execution with: sbatch --exclude=node31,node40,node41,node42,node43,node44,node45,node46,node47 executeClusteruy.sh

# without avx512 instructions (binary from msvole webpage)
# submit execution with: sbatch --nodelist=node41 executeClusteruy.sh

#####
# save all the monomials of the basis, not only the leading terms
#####
# $binMsolve -g 2 -v 2 -t $threads -f $input -o $output

#####
# eliminate first m variables
#####
# $binMsolve -g 2 -v 2 -e 7 -t $threads -f $input -o $output

#####
# save only the leading monomials of the final basis (smaller file)
#####
$binMsolve -g 1 -v 2 -t $threads -f $input -o $output


# show job stats
sstat -j $SLURM_JOB_ID.batch --format=JobID,MaxPages,MaxRSS,MaxVMSize,NTasks,NodeList

