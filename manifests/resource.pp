define nagios-server::resource($host_name, $resource) {
  include nagios-server::defaults
  
  @@file { "${host_name}_${resource}":
    path   => "${defaults::resource_dir}/${resource}",
    ensure => directory,
    owner  => 'nagios',
    group  => 'nagios',
  }
  
  @@file_line { "${host_name}_${resource}":
    path => "${defaults::config_dir}/nagios.cfg",
    line => "cfg_dir=${defaults::resource_dir}/${resource}",
  }
}
