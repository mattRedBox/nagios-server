class nagios-server::export {
    
  include nagios-server::defaults

      @@nagios_host { $::fqdn:
         ensure  => present,
         alias   => $hostname,
         address => $ipaddress,
         use     => 'linux-server',
         target  => "$defaults::resource_dir/${::fqdn}_host.cfg",
      }
      
      @@nagios_hostextinfo { $::fqdn:
         ensure => present,
         icon_image_alt => $operatingsystem,
         icon_image => "base/$operatingsystem.png",
         statusmap_image => "base/$operatingsystem.gd2",
         target  => "$defaults::resource_dir/${::fqdn}_hostextinfo.cfg",
      }

      @@nagios_service { "${::fqdn}-check_ping":
         use => 'local-service',
         host_name => $::fqdn,
         target  => "$defaults::resource_dir/${::fqdn}_check_ping.cfg",
      }
}
