class nagios-server::server {
  package { ["nagios","nagios-plugins","nagios-plugins-nrpe"]:
    ensure => installed,
  }

  service { nagios:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [Package['nagios'],Exec['make-nag-cfg-readable']],
  }

  # This is because puppet writes the config files so nagios can't read them
  exec {'make-nag-cfg-readable':
    path    => [ '/usr/bin', '/bin',],
    command => "find /etc/nagios -type f -name '*cfg' | xargs chmod +r",
  }

  file { ['/etc/nagios','/etc/nagios/resource-d']:
    ensure => directory,
    owner  => 'nagios',
  }
  ->
  # Collect the nagios_host resources
  Nagios_host <<||>> {
    require => File['/etc/nagios','/etc/nagios/resource-d'],
    notify  => [Exec[make-nag-cfg-readable],Service[nagios]],
  }
}
