# == Class: fog
#
# This installs the fog gem.
#
class fog {
  require ruby

  package { ["libxml2-dev", "libxslt1-dev"]:
    ensure => installed,
    before => Package["fog"],
  }

  package { "fog":
    provider => gem,
  }
}
