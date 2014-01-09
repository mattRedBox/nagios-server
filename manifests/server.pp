class nagios-server::server {
  package { ["nagios","nagios-plugins","nagios-plugins-nrpe"]:
    ensure => installed,
  }

  service { nagios:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [Package['nagios']],
  }

  # Collect the nagios_host resources
  Nagios_host <<||>> {
    require => File['/etc/nagios'],
    notify  => Service[nagios],
  }
}
