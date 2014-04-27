# Default node definition.
#

node 'default' {

  ##
  # Hiera.
  ##

  # Base classes.
  hiera_include("classes")

  ##
  # Things that cannot be in hiera.
  ##

  # Ensure we have an update to date set of packages.
  exec { "apt-update":
    command => "/usr/bin/apt-get update"
  }
  Exec["apt-update"] -> Package <| |>

}
