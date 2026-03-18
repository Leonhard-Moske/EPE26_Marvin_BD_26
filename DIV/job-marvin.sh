#!/bin/bash -l
#SBATCH -N 1 -p intelsr_devel --exclusive --time=00:05:00 --constraint=perfctr
#SBATCH --reservation=hager_workshop_intelsr
#SBATCH --account=tmp_hager_workshop

unset SLURM_EXPORT_ENV

module load intel
echo Hello World!

# choose between C and Fortran
icx -Ofast -xHost -qopt-zmm-usage=high -o div.exe  div.c
srun --cpu-bind=none --cpu-freq=2000000-2000000:performance ./div.exe
icx -O3 -xSSE4.2 -o div.exe  div.c
srun --cpu-bind=none --cpu-freq=2000000-2000000:performance ./div.exe
icx -O1 -no-vec  -o div.exe  div.c
srun --cpu-bind=none --cpu-freq=2000000-2000000:performance ./div.exe
icx -O3 -xAVX2 -o div.exe  div.c
srun --cpu-bind=none --cpu-freq=2000000-2000000:performance ./div.exe

#srun --cpu-bind=none --cpu-freq=2000000-2000000:performance ./div.exe


