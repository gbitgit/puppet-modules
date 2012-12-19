# == Class: wget
#
# This installs wget.
#
class wget {
  if $operatingsystem == 'Darwin' {
    require homebrew

    # Install via homebrew
    exec { "brew install wget":
      creates     => "/usr/local/bin/wget",
      environment => "HOME=/Users/${homebrew::user}",
      user        => $homebrew::user,
    }
  } else {
    package { "wget":
      ensure => installed,
    }
  }
}
