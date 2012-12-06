# == Class: ruby::windows
#
# This installs Ruby on Windows.
#
class ruby::windows(
  $install_dir = undef,
  $file_cache_dir = params_lookup('file_cache_dir', 'global'),
) {
  $source_url = "http://cdn.rubyinstaller.org/archives/1.9.3-p327/rubyinstaller-1.9.3-p327.exe"
  $installer_path = "${file_cache_dir}\\ruby.exe"

  $extra_args = $install_dir ? {
    undef   => "",
    default => " /dir=\"${install_dir}\"",
  }

  download { "ruby":
    source      => $source_url,
    destination => $installer_path,
  }

  exec { "install-ruby":
    command => "cmd.exe /C ${installer_path} /silent${extra_args}",
    creates => "${install_dir}/bin/ruby.exe",
    require => Download["ruby"],
  }
}
