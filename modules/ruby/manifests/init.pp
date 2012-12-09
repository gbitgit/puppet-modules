# == Class: ruby
#
# This installs Ruby from a binary or system package.
#
class ruby {
  package { ["ruby", "rubygems"]:
    ensure => installed,
  }

  if $operatingsystem == 'CentOS' {
    package { "ruby-devel":
      ensure => installed,
    }
  }
}
