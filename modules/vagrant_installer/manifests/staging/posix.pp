# == Class: vagrant_installer::staging::posix
#
# This sets up the staging directory for POSIX compliant systems.
#
class vagrant_installer::staging::posix {
  include vagrant_installer::params

  $embedded_dir     = $vagrant_installer::params::embedded_dir
  $staging_dir      = $vagrant_installer::params::staging_dir
  $vagrant_revision = $vagrant_installer::params::vagrant_revision

  #------------------------------------------------------------------
  # Calculate variables based on operating system
  #------------------------------------------------------------------
  $extra_autotools_ldflags = $operatingsystem ? {
    'Darwin' => "-R${embedded_dir}/lib",
    default  => '',
  }

  $default_autotools_environment = {
    "CFLAGS"                   =>
      "-I${embedded_dir}/include -L${embedded_dir}/lib",
    "LDFLAGS"                  =>
      "-I${embedded_dir}/include -L${embedded_dir}/lib ${extra_autotools_ldflags}",
    "MACOSX_DEPLOYMENT_TARGET" => "10.5",
  }

  if $operatingsystem == 'Darwin' {
    $libffi_autotools_environment = {
      "LDFLAGS" => "-Wl,-install_name,@rpath/libffi.dylib",
    }

    $libyaml_autotools_environment = {
      "LDFLAGS" => "-Wl,-install_name,@rpath/libyaml.dylib",
    }

    $readline_autotools_environment = {
      "LDFLAGS" => "-Wl,-install_name,@rpath/libreadline.dylib",
    }

    $ruby_autotools_environment = {
      "LDFLAGS" => "-Wl,-rpath,@loader_path/../lib -Wl,-rpath,@executable_path/../lib",
    }

    $zlib_autotools_environment = {
      "LDFLAGS" => "-Wl,-install_name,@rpath/libz.dylib",
    }
  } elsif $kernel == 'Linux' {
    $ruby_autotools_environment = {
      "LD_RUN_PATH" => '\$ORIGIN/../lib',
    }
  }

  #------------------------------------------------------------------
  # Classes
  #------------------------------------------------------------------
  class { "libffi":
    autotools_environment => autotools_merge_environments(
      $default_autotools_environment, $libffi_autotools_environment),
    prefix                => $embedded_dir,
    make_notify           => Exec["reset-ruby"],
  }

  class { "libyaml":
    autotools_environment => autotools_merge_environments(
      $default_autotools_environment, $libyaml_autotools_environment),
    prefix                => $embedded_dir,
    make_notify           => Exec["reset-ruby"],
  }

  class { "zlib":
    autotools_environment => autotools_merge_environments(
      $default_autotools_environment, $zlib_autotools_environment),
    prefix                => $embedded_dir,
    make_notify           => Exec["reset-ruby"],
  }

  class { "readline":
    autotools_environment => autotools_merge_environments(
      $default_autotools_environment, $readline_autotools_environment),
    prefix                => $embedded_dir,
    make_notify           => Exec["reset-ruby"],
  }

  class { "openssl":
    autotools_environment => $default_autotools_environment,
    prefix                => $embedded_dir,
    make_notify           => Exec["reset-ruby"],
  }

  class { "ruby":
    autotools_environment => autotools_merge_environments(
      $default_autotools_environment, $ruby_autotools_environment),
    prefix                => $embedded_dir,
    make_notify           => Exec["reset-vagrant"],
    require               => [
      Class["libffi"],
      Class["libyaml"],
      Class["zlib"],
      Class["openssl"],
      Class["readline"],
    ],
  }

  class { "vagrant":
    autotools_environment => $default_autotools_environment,
    embedded_dir          => $embedded_dir,
    revision              => $vagrant_revision,
    require               => Class["ruby"],
  }

  #------------------------------------------------------------------
  # Bin wrappers
  #------------------------------------------------------------------
  # Vagrant
  file { "${staging_dir}/bin/vagrant":
    content => template("vagrant_installer/vagrant.erb"),
    mode    => "0755",
    require => Class["vagrant"],
  }
}
