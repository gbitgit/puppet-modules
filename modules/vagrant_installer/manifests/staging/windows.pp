# == Class: vagrant_installer::staging::windows
#
# This sets up the staging directory for Windows systems.
#
class vagrant_installer::staging::windows {
  $embedded_dir     = $vagrant_installer::params::embedded_dir
  $staging_dir      = $vagrant_installer::params::staging_dir
  $vagrant_revision = $vagrant_installer::params::vagrant_revision

  #------------------------------------------------------------------
  # Dependencies
  #------------------------------------------------------------------
  class { "ruby::windows":
    install_dir => $embedded_dir,
  }

  class { "rubyencoder::loaders":
    path => $embedded_dir,
  }

  class { "vagrant":
    embedded_dir => $embedded_dir,
    revision     => $vagrant_revision,
    require      => Class["ruby::windows"],
  }

  #------------------------------------------------------------------
  # Bin wrappers
  #------------------------------------------------------------------
  # Batch wrapper so that Vagrant can be executed from normal cmd.exe
  file { "${staging_dir}/bin/vagrant.bat":
    content => template("vagrant_installer/windows_vagrant.bat.erb"),
    require => Class["vagrant"],
  }

  # Normal Bash wrapper for Cygwin installations
  file { "${staging_dir}/bin/vagrant":
    content => template("vagrant_installer/vagrant.erb"),
    require => Class["vagrant"],
  }
}
