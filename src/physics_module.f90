! Module containing the physical parameters of the problem

module physics_module

  use precision

  implicit none

  type :: Physics

     ! Material properties and boundary conditions
     real(dp) :: kappa       ! thermal diffusivity (m^2/s)
     real(dp) :: k           ! thermal conductivity (W/m/K)
     real(dp) :: rho         ! density (kg/m^3)
     real(dp) :: cp          ! specific heat (J/kg/K)
     real(dp) :: T_core      ! temperature at outer core (K)
     real(dp) :: T_mantle    ! temperature at lowermost mantle (K)
     real(dp) :: h_cmb       ! CMB heat transfer coefficient (W/m^2/K)

  end type Physics

contains

  subroutine init_physics(p)

    ! Initializes the physical constants with Earth-like values
    type(Physics), intent(out) :: p

    p%rho      = 11000.0_dp       ! outer core density
    p%cp       = 800.0_dp         ! heat capacity
    p%k        = 100.0_dp         ! thermal conductivity
    p%kappa    = p%k / (p%rho*p%cp)  ! thermal diffusivity

    p%T_core   = 4100.0_dp        ! typical outer core temperature
    p%T_mantle = 3200.0_dp        ! lowermost mantle temperature
    p%h_cmb    = 0.05_dp          ! coupling coefficient at CMB
    
  end subroutine init_physics

end module physics_module
