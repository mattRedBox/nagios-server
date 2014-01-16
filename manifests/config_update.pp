define nagios-server::config_update($exported_host, $exported_resource) {
  include nagios-server::defaults

  file { "${exported_host}_${exported_resource}":
    path    => "${defaults::resource_dir}/${exported_resource}",
    ensure  => directory,
    owner   => 'nagios',
    group   => 'nagios',
  }

  file_line { "${exported_host}_${exported_resource}":
    path => "${defaults::config_dir}/nagios.cfg",
    line => "cfg_dir=${defaults::resource_dir}/${exported_resource}",
  }
}
