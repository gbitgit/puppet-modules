# == Define: homebrew::package
#
# This installs a package with homebrew.
#
define homebrew::package(
  $package=$name,
  $creates=undef,
) {
  require homebrew
  include homebrew::params

  $user = $homebrew::params::user

  exec { "brew install ${package}":
    creates     => $creates,
    environment => "HOME=/Users/${user}",
    user        => $user,
  }
}
