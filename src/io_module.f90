! Module to handle binary output of the temperature field
module io_module

  use precision
  use grid_module

  implicit none

contains

  subroutine write_binary(grid, filename)

    type(Grid3D), intent(in) :: grid
    character(len=*), intent(in) :: filename
    integer :: unit

    ! Open file for unformatted (binary) writing
    open(newunit=unit, file=filename, &
         form="unformatted", access="stream", status="replace")

    ! Write grid metadata first
    write(unit) grid%nx, grid%ny, grid%nz
    write(unit) grid%dx

    ! Write 3D temperature array
    write(unit) grid%T

    close(unit)
    
  end subroutine write_binary

end module io_module
