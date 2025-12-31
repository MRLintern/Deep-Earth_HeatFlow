#!/bin/bash

set -e

mkdir -p build

gfortran -c -O3 -fopenmp -std=f2008 src/precision.f90        -J build -o build/precision.o
gfortran -c -O3 -fopenmp -std=f2008 src/physics_module.f90  -J build -I build -o build/physics_module.o
gfortran -c -O3 -fopenmp -std=f2008 src/grid_module.f90     -J build -I build -o build/grid_module.o
gfortran -c -O3 -fopenmp -std=f2008 src/boundary_module.f90 -J build -I build -o build/boundary_module.o
gfortran -c -O3 -fopenmp -std=f2008 src/io_module.f90       -J build -I build -o build/io_module.o
gfortran -c -O3 -fopenmp -std=f2008 src/solver_module.f90   -J build -I build -o build/solver_module.o
gfortran -c -O3 -fopenmp -std=f2008 src/main.f90            -J build -I build -o build/main.o

gfortran -fopenmp build/*.o -o build/CMB_Heat
