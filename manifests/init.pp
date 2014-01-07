# == Class: nagios
#
# Full description of class nagios here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { nagios:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class nagios-server {
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
