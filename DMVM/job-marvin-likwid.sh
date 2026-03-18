#!/bin/bash -l
#SBATCH -N 1 -p intelsr_devel --exclusive --time=00:10:00 --constraint=perfctr
#SBATCH --export=NONE
#SBATCH --account=tmp_hager_workshop

unset SLURM_EXPORT_ENV

module load inter GCC likwid

echo Hello World!

# choose between C and Fortran
#icx -Ofast -xHost -qopt-zmm-usage=high -o ./dmvm.exe C/dmvm.c
#ifx -Ofast -xHost -qopt-zmm-usage=high -o ./dmvm.exe F90/dmvm.f90

# choose between C and Fortran
#gcc -DLIKWID_PERFMON -mcmodel=large -Ofast -march=icelake-server -mprefer-vector-width=512 -o ./dmvm.exe C/dmvm-marker.c -llikwid
gcc -DLIKWID_PERFMON -mcmodel=large -Ofast -march=icelake-server -o ./dmvm.exe C/dmvm-marker.c -llikwid

likwid-perfctr -g MEM_DP -C S1:0-3 ./dmvm.exe 1000 1000
