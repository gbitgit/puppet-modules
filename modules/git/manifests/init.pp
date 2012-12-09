# == Class: git
#
# This installs git.
#
class git {
  package { "git-core":
    ensure => installed,
  }
}
