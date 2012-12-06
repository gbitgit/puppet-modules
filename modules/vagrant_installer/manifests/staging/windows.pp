# == Class: vagrant_installer::staging::windows
#
# This sets up the staging directory for Windows systems.
#
class vagrant_installer::staging::windows {
  $embedded_dir     = $vagrant_installer::params::embedded_dir
  $vagrant_revision = $vagrant_installer::params::vagrant_revision

  class { "ruby::windows":
    install_dir => $embedded_dir,
  }

  class { "vagrant":
    embedded_dir => $embedded_dir,
    revision     => $vagrant_revision,
    require      => Class["ruby::windows"],
  }
}
