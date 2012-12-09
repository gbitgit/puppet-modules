# == Class: git
#
# This installs git.
#
class git {
  $package = $operatingsystem ? {
    'CentOS' => "git",
    default  => "git-core",
  }

  package { $package:
    ensure => installed,
  }
}
