class nagios-server::export {
    
  include nagios-server::defaults

      @@nagios_host { $::fqdn:
         ensure   => present,
         alias    => $hostname,
         address  => $ipaddress,
         use      => 'linux-server',
         target   => "$defaults::resource_dir/host/${::fqdn}.cfg",
         requires => "Resource[${::fqdn},'host']",
      }
      
      @@nagios_hostextinfo { $::fqdn:
         ensure => present,
         icon_image_alt => $operatingsystem,
         icon_image => "base/$operatingsystem.png",
         statusmap_image => "base/$operatingsystem.gd2",
         target  => "$defaults::resource_dir/hostextinfo/${::fqdn}.cfg",
         requires => "Resource[${::fqdn},'hostextinfo']",
      }

      @@nagios_service { "${::fqdn}-check_ping":
         use => 'local-service',
         host_name => $::fqdn,
         target  => "$defaults::resource_dir/check_ping/${::fqdn}.cfg",
         requires => "Resource[${::fqdn},'check_ping']",
      }
}
