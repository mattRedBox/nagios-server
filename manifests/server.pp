class nagios-server::server {
  package { ["nagios","nagios-plugins","nagios-plugins-nrpe"]:
    ensure => installed,
  }

  file { 'resource.d':
    path   => "$defaults::resource_dir",
    ensure => directory,
    owner  => 'nagios',
  }
  ->
  file_line { 'resource.d':
    path => "$defaults::config_dir/nagios.cfg",
    line => "cfg_dir=$defaults::resource_dir",
  }
  ->
  service { nagios:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [Package['nagios']],
  }
  ->
  # Collect the nagios_host resources
  Nagios_host <<||>> {
    notify  => Service[nagios],
  }
  ->
  Nagios_service <<||>> {
    notify => Service[nagios],
  }
  ->
  Nagios_hostextinfo <<||>> {
    notify => Service[nagios],
  }
}
