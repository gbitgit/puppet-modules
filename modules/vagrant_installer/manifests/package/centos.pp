# == Class: vagrant_installer::package::centos
#
# This creates a package for Vagrant for CentOS.
#
class vagrant_installer::package::centos {
  require fpm

  $centos_prefix   = hiera("rpm_prefix")
  $dist_dir        = $vagrant_installer::params::dist_dir
  $staging_dir     = $vagrant_installer::params::staging_dir
  $vagrant_version = $vagrant_installer::params::vagrant_version

  $final_output_path = "${dist_dir}/vagrant_${hardwaremodel}.rpm"

  $fpm_args = "-p '${final_output_path}' -n vagrant -v '${vagrant_version}' -s dir -t rpm --prefix '${centos_prefix}' -C '${staging_dir}'"

  util::recursive_directory { $centos_prefix: }

  exec { "fpm-vagrant-rpm":
    command => "fpm ${fpm_args} .",
    cwd     => $staging_dir,
    creates => $final_output_path,
    require => Util::Recursive_directory[$centos_prefix],
  }
}
