program CMB_Heat

  ! Main program to simulate heat diffusion across Earth's CMB
  use precision
  use physics_module
  use grid_module
  use solver_module
  use io_module

  implicit none

  type(Physics) :: phys
  type(Grid3D) :: grid
  type(DiffusionSolver) :: solver

  ! Initialize physical parameters
  call init_physics(phys)

  ! Initialize 3D grid with 64^3 points and 5 km spacing
  call grid%initialize(64,64,64,5.0e3_dp, phys%T_core)

  ! Set solver time step and maximum time (50 years, 200,000 years total)
  solver%dt = 50.0_dp * 365.25_dp * 24.0_dp * 3600.0_dp
  solver%tmax = 2.0e5_dp * 365.25_dp * 24.0_dp * 3600.0_dp

  ! Solve the heat diffusion equation
  call solver%solve(grid, phys)

  ! Write the final temperature field to a binary file
  call write_binary(grid, "results/temperature_field.bin")
  
end program CMB_Heat
