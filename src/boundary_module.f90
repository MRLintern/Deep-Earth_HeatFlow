! Module to apply boundary conditions at the CMB patch
module boundary_module

  use precision
  use physics_module
  use grid_module

  implicit none

contains

  subroutine apply_boundaries(grid, phys)

    ! Applies temperature boundary conditions to the grid
    type(Grid3D), intent(inout) :: grid
    type(Physics), intent(in)   :: phys
    integer :: j, k
    real(dp) :: dx

    dx = grid%dx

    ! -------------------------
    ! Dirichlet boundary at the core
    ! Fix temperature at the first x-plane (core side)
    grid%T(1,:,:) = phys%T_core

    ! -------------------------
    ! Robin (mixed) boundary at the mantle side
    ! Approximates convective heat flux into mantle
    do j = 1, grid%ny
       do k = 1, grid%nz

          grid%T(grid%nx,j,k) = &
            (phys%k * grid%T(grid%nx-1,j,k) / dx + phys%h_cmb * phys%T_mantle) / &
            (phys%k / dx + phys%h_cmb)
            
       end do
    end do

  end subroutine apply_boundaries

end module boundary_module

