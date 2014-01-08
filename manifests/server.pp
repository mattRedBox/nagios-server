class nagios-server::server {
  package { ["nagios","nagios-plugins","nagios-plugins-nrpe"]:
    ensure => installed,
  }

  service { nagios:
    ensure  => running,
    enable  => true,
    require => Exec['make-nag-cfg-readable'],
  }

  # This is because puppet writes the config files so nagios can't read them
  exec {'make-nag-cfg-readable':
    path    => [ '/usr/bin', '/bin',],
    command => "find /etc/nagios -type f -name '*cfg' | xargs chmod +r",
  }

  file { 'resource-d':
    path   => '/etc/nagios/resource.d',
    ensure => directory,
    owner  => 'nagios',
  }

  # Collect the nagios_host resources
  Nagios_host <<||>> {
    require => File[resource-d],
    notify  => [Exec[make-nag-cfg-readable],Service[nagios]],
  }
}
