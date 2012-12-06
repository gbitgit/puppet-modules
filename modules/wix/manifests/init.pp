# == Class: wix
#
# This installs the WiX toolkit.
#
class wix(
  $file_cache_dir = params_lookup('file_cache_dir', 'global'),
  $install_path,
) {
  $source_file_path = "${file_cache_dir}\\wix.zip"
  $source_url = "https://github.com/downloads/mitchellh/vagrant-installers/wix36-binaries.zip"

  download { "wix":
    source      => $source_url,
    destination => $source_file_path,
  }

  powershell { "extract-wix":
    content => template("wix/extract.erb"),
    creates => "${install_path}/heat.exe",
    require => Download["wix"],
  }
}
