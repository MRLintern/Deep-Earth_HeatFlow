! Module containing the diffusion solver
module solver_module

  use precision
  use grid_module
  use physics_module
  use boundary_module
  use omp_lib

  implicit none

  type :: DiffusionSolver

     real(dp) :: dt                 ! time step (s)
     real(dp) :: tmax               ! maximum simulation time (s)
     integer  :: output_interval    ! interval for output (not used here)

  contains

     procedure :: solve

  end type DiffusionSolver

contains

  subroutine solve(this, grid, phys)

    ! Solves the heat equation using explicit finite difference
    class(DiffusionSolver), intent(in) :: this
    type(Grid3D), intent(inout) :: grid
    type(Physics), intent(in) :: phys

    integer :: i,j,k,step
    real(dp) :: time

    time = 0.0_dp
    step = 0

    ! Main time-stepping loop
    do while (time < this%tmax)

       step = step + 1

       ! -------------------------
       ! Update interior points using 3D explicit finite difference
       !$omp parallel do collapse(3)

       do i = 2, grid%nx-1
          do j = 2, grid%ny-1
             do k = 2, grid%nz-1

                grid%Tnew(i,j,k) = grid%T(i,j,k) + phys%kappa * this%dt * ( &
                  grid%T(i+1,j,k) + grid%T(i-1,j,k) + &
                  grid%T(i,j+1,k) + grid%T(i,j-1,k) + &
                  grid%T(i,j,k+1) + grid%T(i,j,k-1) - &
                  6.0_dp * grid%T(i,j,k) ) / (grid%dx**2)

             end do
          end do
       end do
       !$omp end parallel do

       ! Swap Tnew into T
       grid%T = grid%Tnew

       ! Apply boundary conditions after update
       call apply_boundaries(grid, phys)

       ! Increment time
       time = time + this%dt
       
    end do

  end subroutine solve

end module solver_module
