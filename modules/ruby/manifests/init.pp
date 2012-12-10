# == Class: ruby
#
# This installs Ruby from a binary or system package.
#
class ruby {
  package { ["ruby", "rubygems"]:
    ensure => installed,
  }

  case $operatingsystem {
    'Archlinux': {
      # Arch installs a very annoying default gemrc file that has
      # "--user-install" as the default. Get rid of that.
      file { "/etc/gemrc":
        ensure  => absent,
        require => [
          Package["ruby"],
          Package["rubygems"],
        ],
      }
    }

    'CentOS': {
      package { "ruby-devel":
        ensure => installed,
      }
    }
  }
}
