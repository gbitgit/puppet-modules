# == Class: vagrant_installer::staging::windows
#
# This sets up the staging directory for Windows systems.
#
class vagrant_installer::staging::windows {
  $embedded_dir = $vagrant_installer::params::embedded_dir

  class { "ruby::windows":
    install_dir => $embedded_dir,
  }
}
