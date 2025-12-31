# Deep-Earth_HeatFlow

## Introduction
* A __Modern Fortran (2008+)__ solver, __Parallelising__ the __Jacobi Method__ with __OpenMP__ to model __Heat-Diffusion__ across __Earths's Core-Mantle Boundary (CMB)__.

## Geophysics Background
* TODO.

## Requirements
* `gfortran` compiler.
* `OpenMP`.
* `Python 3.X`.
* `NumPy`.
* `Matplotlib`.

## Resources
* ___Introduction to Modern Fortran for the Earth System Sciences___ by __Dragos B. Chirila__ & __Gerrit Lohmann__.

## Running and Using the Software
* `$ git clone git@github.com:MRLintern/CMB_HeatFlow.git`
* `$ cd CMB_HeatFlow`
* `$ chmod +x build.sh`
* `$ ./build`
* `$ ./build/CMB_Heat
* Now plotting the generated `.bin` file.
* `$ cd visualisation`
* `$ python3 CMB_Temperature_Field.py`; this will produce a plot of the 3D model. Note: this plot has been included in the `sample_plot` directory for viewing.
