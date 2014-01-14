class nagios-server::export {
    
  include nagios-server::defaults

      @@nagios_host { $::fqdn:
         ensure  => present,
         alias   => $hostname,
         address => $ipaddress,
         use     => 'linux-server',
         target  => "$resource_dir/$::fqdn_host.cfg",
         require => File_line['add_resource_dir'],
      }
      
      @@nagios_hostextinfo { $::fqdn:
         ensure => present,
         icon_image_alt => $operatingsystem,
         icon_image => "base/$operatingsystem.png",
         statusmap_image => "base/$operatingsystem.gd2",
         target  => "$resource_dir/$::fqdn_hostextinfo.cfg",
         require => File_line['add_resource_dir'],
      }

      @@nagios_service { "$::fqdn-check_ping":
         use => 'local-service',
         host_name => "$::fqdn",
         target  => "$resource_dir/$::fqdn_check_ping.cfg",
         require => File_line['add_resource_dir'],
      }
}
