# == Class: vagrant_installer::package::ubuntu
#
# This creates a package for Vagrant for Ubuntu.
#
class vagrant_installer::package::ubuntu {
  require fpm

  $deb_maintainer  = hiera("deb_maintainer")
  $deb_prefix      = hiera("deb_prefix")
  $dist_dir        = $vagrant_installer::params::dist_dir
  $staging_dir     = $vagrant_installer::params::staging_dir
  $vagrant_version = $vagrant_installer::params::vagrant_version

  $final_output_path = "${dist_dir}/vagrant_${hardwaremodel}.deb"

  $fpm_args = "-p '${final_output_path}' -n vagrant -v '${vagrant_version}' -s dir -t deb --prefix '${deb_prefix}' --maintainer '${deb_maintainer}'"

  exec { "fpm-vagrant-deb":
    command => "fpm ${fpm_args} .",
    cwd     => $staging_dir,
    creates => $final_output_path,
  }
}
