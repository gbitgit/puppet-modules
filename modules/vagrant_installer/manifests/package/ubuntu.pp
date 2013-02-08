# == Class: vagrant_installer::package::ubuntu
#
# This creates a package for Vagrant for Ubuntu.
#
class vagrant_installer::package::ubuntu {
  require fpm

  $deb_maintainer  = hiera("deb_maintainer")
  $deb_prefix      = hiera("deb_prefix")
  $dist_dir        = $vagrant_installer::params::dist_dir
  $file_cache_dir  = $vagrant_installer::params::file_cache_dir
  $staging_dir     = $vagrant_installer::params::staging_dir
  $vagrant_version = $vagrant_installer::params::vagrant_version

  $final_output_path = "${dist_dir}/vagrant_${hardwaremodel}.deb"

  $fpm_args = "-p '${final_output_path}' -n vagrant -v '${vagrant_version}' -s dir -t deb --prefix '/' --maintainer '${deb_maintainer}' --deb-user root --deb-group root"

  #------------------------------------------------------------------
  # Stage for Linux
  #
  # In Linux we want to automatically add /usr/bin/vagrant and
  # such so additional staging is necessary.
  #------------------------------------------------------------------
  $linux_prefix = "/opt/vagrant"
  $script_stage_linux = "${file_cache_dir}/linux_stage"

  util::script { $script_stage_linux:
    content => template("vagrant_installer/package/linux_stage.sh.erb"),
  }

  exec { $script_stage_linux:
    cwd     => $staging_dir,
    unless  => "test -d opt",
    require => Util::Script[$script_stage_linux],
  }

  util::script { "${staging_dir}/usr/bin/vagrant":
    content => template("vagrant_installer/vagrant_linux_proxy.erb"),
    require => Exec[$script_stage_linux],
  }

  exec { "fpm-vagrant-deb":
    command => "fpm ${fpm_args} .",
    cwd     => $staging_dir,
    creates => $final_output_path,
    require => [
      Exec[$script_stage_linux],
      Util::Script["${staging_dir}/usr/bin/vagrant"],
    ],
  }
}
