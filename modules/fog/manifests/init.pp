# == Class: fog
#
# This installs the fog gem.
#
class fog {
  require build_essential
  require ruby

  $pre_packages = $operatingsystem ? {
    'CentOS' => ["libxml2", "libxml2-devel", "libxslt", "libxslt-devel"],
    default  => ["libxml2-dev", "libxslt1-dev"],
  }

  package { $pre_packages:
    ensure => installed,
    before => Package["fog"],
  }

  package { "fog":
    provider => gem,
  }
}
