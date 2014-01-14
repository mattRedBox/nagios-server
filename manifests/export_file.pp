define nagios-server::export_file($exported_resource) {
  include nagios-server::defaults
  
  @@file { "${::fqdn}_${exported_resource}":
    path    => "${defaults::resource_dir}/${exported_resource}",
    ensure  => directory,
    owner   => 'nagios',
    group   => 'nagios',
  }
  
  @@file_line { "${::fqdn}_${exported_resource}":
    path => "${defaults::config_dir}/nagios.cfg",
    line => "cfg_dir=${defaults::resource_dir}/${exported_resource}",
  }
}
