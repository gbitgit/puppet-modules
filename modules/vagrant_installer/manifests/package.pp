# == Class: vagrant_installer::package
#
# This makes the installer package for Vagrant.
#
class vagrant_installer::package {
  case $operatingsystem {
    'Darwin': { include vagrant_installer::package::darwin }
    'Ubuntu': { include vagrant_installer::package::ubuntu }
    default:  { fail("Unknown operating system to package for.") }
  }
}
