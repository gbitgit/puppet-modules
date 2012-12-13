# == Class: sudo
#
# This configures sudo.
#
class sudo {
  include sudo::params

  $conf_dir = $sudo::params::conf_dir

  file { $conf_dir:
    ensure => directory,
    owner  => "root",
    group  => "root",
    mode   => "0755",
  }

  file { "/etc/sudoers":
    content => template("sudo/sudoers.erb"),
    owner   => "root",
    group   => "root",
    mode    => "0440",
    require => File[$conf_dir],
  }
}
