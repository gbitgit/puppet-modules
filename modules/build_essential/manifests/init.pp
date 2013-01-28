# == Class: build_essential
#
# This will install the base development tools for multiple platforms.
#
class build_essential {
  case $operatingsystem {
    'Archlinux': {
      package { "base-devel":
        ensure => installed,
      }
    }

    'CentOS': {
      package { ["gcc", "make", "automake"]:
        ensure => installed,
      }
    }

    'Ubuntu': {
      package {
        ["build-essential", "autoconf", "automake", "libtool"]:
          ensure => installed,
      }
    }
  }
}
