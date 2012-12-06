# == Class: vagrant_installer::staging
#
# This makes the staging directory for Vagrant.
#
class vagrant_installer::staging {
  case $kernel {
    'Darwin', 'Linux': { include vagrant_installer::staging::posix }
    'windows': { include vagrant_installer::staging::windows }
    default:   { fail("Unknown operating system to stage.") }
  }
}
