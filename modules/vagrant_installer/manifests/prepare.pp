# == Class: vagrant_installer::prepare
#
# This prepares everything for creating installers. This is run in a run
# stage prior to the main stage, so you must be VERY CAREFUL about
# resource ordering here.
#
class vagrant_installer::prepare {
  include vagrant_installer::params

  $staging_dir  = $vagrant_installer::params::staging_dir
  $embedded_dir = $vagrant_installer::params::embedded_dir
  $dist_dir     = $vagrant_installer::params::dist_dir

  # Sometimes when we're debugging, its nice to keep these directories
  # around to keep the Puppet runs fast. This will make that happen.
  if !$param_keep_dirs {
    file { [$dist_dir, $staging_dir]:
      ensure  => absent,
      force   => true,
      recurse => true,
      tag     => "prepare-clear",
    }

    # Run these prior to any of the directories, so that we
    # delete them prior to making them.
    File <| tag == "prepare-clear" |> -> Util::Recursive_directory <| tag == "prepare" |>
  }

  util::recursive_directory { [
    $staging_dir,
    "${staging_dir}/bin",
    $embedded_dir,
    "${embedded_dir}/bin",
    "${embedded_dir}/include",
    "${embedded_dir}/lib",
    "${embedded_dir}/share",
    $dist_dir,]:
    tag => "prepare",
  }
}
