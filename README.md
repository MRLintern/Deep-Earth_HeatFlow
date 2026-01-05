# Deep-Earth_HeatFlow

## Introduction
* A __Modern Fortran (2008+)__ solver, __Parallelising__ the __Jacobi Method__ with __OpenMP__ to model __Heat-Diffusion__ across __Earths's Core-Mantle Boundary (CMB)__.

## Geophysics Background
### Core-Mantle Boundary (CMB) Heat Transfer

* The __CMB__ is located at a depth of approximately 3000km.
* It separates the __Liquid Outer Core__ from the __Solid Lower Mantle__ and controls how heat generated in the core is transferred into the matle.
* Heat Flow across the CMB plays a role in:

	- Sustaining the __Geodynamo__ that generates __Earth’s Magnetic Field__,
	- Driving __Mantle Convection__ and __Plume Formation__,
	- Controlling the long-term thermal evolution of the core and mantle,
	- Influencing __Seismic__ and __Chemical Structures__ such as __Ultra-Low Velocity Zones (ULVZs)__.
	
### Model for the Project

* The project models __Thermal Diffusion across a Local Patch of the CMB__ using a simple but realistic framework.

#### Assumptions

* The CMB is approximated locally as a __Flat__, __Cartesian Surface__.
* Heat transport is dominated by __Thermal Diffusion__.
* Material properties are __Homogeneous and Isotropic__.
* No internal heat sources are included.
* __Fluid Motion__ and __Advection__ are neglected: __Pure Conduction Model__.

### Core-Mantle Thermal Coupling

#### Core Side (Dirichlet Boundary)

* The Outer Core is assumed to be:

	- Well mixed by __Vigorous Convection__.
	- Nearly __Isothermal__ at the CMB.
	
* This means we have a __Fixed Temperature (Dirichlet) Boundary Condition__:

	- `T = T_core`,
	
	- represents a __Thermally equilibrated liquid core__.
	
#### Mantle Side (Robin Boundary)

* The Lower Mantle is modeled as a __Thermal Reservoir__ that exchanges heat with the CMB via conduction and __Parameterised Convection__.
* This is represented by a __Robin (mixed) Boundary Condition__:

	- `-k(dT/dn) = h_cmb(T - T_mantle)`, where:
	- `k` is __Thermal Conductivity__,
	- `h_cmb` is an __effective Mantle Heat Transfer Coefficient__,
	- `T_mantle` is the __Lowermost Mantle Temperature__.
	
* This formation captures the idea that __Mantle Dynamics regulate CMB Heat Flux__ rather than enforcing a fixed temperature

### Governing Equation

* The temperature evolution inside the CMB patch follows the __3D Heat Diffusion Equation__:

	- `dT/dt = K(del . (del(T)))`, where:
	- `T` is temperature,
	- `K = k/(density * c_p)`, __Thermal Diffusivity__,
	- `c_p` is specific heat at constant pressure
	
* This equation is __Discretised__ using the __Finite Difference Method__ on a regular __Cartesian Grid__.
* The resulting __System Algebraic Equations__ are solved via the __Jacobi Iterative Method__.
* The __Jacobi Method__ is __Parallelised__ via the __OpenMP API__.

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
* `$ ./build/CMB_Heat`
* Now plotting the generated `.bin` file.
* `$ cd visualisation`
* `$ python3 CMB_Temperature_Field.py`; this will produce a plot of the 3D model. Note: this plot has been included in the `sample_plot` directory for viewing.
