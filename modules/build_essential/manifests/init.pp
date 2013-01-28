# == Class: build_essential
#
# This will install the base development tools for multiple platforms.
#
class build_essential {
  case $operatingsystem {
    'Archlinux': {
      exec { "pacman-base-devel":
        command => "pacman --noconfirm --noprogressbar -Sy base-devel",
        unless  => "pacman -Qg base-devel",
      }
    }

    'CentOS': {
      package { ["gcc", "make", "automake", "libtool"]:
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
