! Module defining the 3D Cartesian grid for the CMB patch

module grid_module

  use precision

  implicit none

  type :: Grid3D

     ! Number of grid points in x, y, z directions
     integer :: nx, ny, nz
     real(dp) :: dx               ! uniform grid spacing (km)

     ! Temperature fields
     real(dp), allocatable :: T(:,:,:)    ! current temperature
     real(dp), allocatable :: Tnew(:,:,:) ! updated temperature

  contains

     procedure :: initialize

  end type Grid3D

contains

  subroutine initialize(this, nx, ny, nz, dx, Tinit)

    ! Allocates memory and sets initial temperature
    class(Grid3D), intent(inout) :: this
    integer, intent(in) :: nx, ny, nz
    real(dp), intent(in) :: dx, Tinit

    this%nx = nx
    this%ny = ny
    this%nz = nz
    this%dx = dx

    allocate(this%T(nx,ny,nz))
    allocate(this%Tnew(nx,ny,nz))

    ! Initialize both T and Tnew to initial temperature
    this%T = Tinit
    this%Tnew = Tinit
    
  end subroutine initialize

end module grid_module
