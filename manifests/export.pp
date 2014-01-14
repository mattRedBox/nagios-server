class nagios-server::export {
    
  include nagios-server::defaults

      file_line { 'add_resource_dir':
          path => "$config_dir/nagios.cfg",
          line => "cfg_file=$resource_dir/$::fqdn",
      }

      @@nagios_host { $::fqdn:
         ensure  => present,
         alias   => $hostname,
         address => $ipaddress,
         use     => 'linux-server',
         target  => "$resource_dir/$::fqdn",
         require => File_line['add_resource_dir'],
      }

      @@nagios_hostextinfo { $::fqdn:
         ensure => present,
         icon_image_alt => $operatingsystem,
         icon_image => "base/$operatingsystem.png",
         statusmap_image => "base/$operatingsystem.gd2",
         target  => "$resource_dir/$::fqdn",
         require => File_line['add_resource_dir'],
      }

      @@nagios_service { "$::fqdn-check_ping":
         use => 'local-service',
         host_name => "$::fqdn",
         target  => "$resource_dir/$::fqdn",
         require => File_line['add_resource_dir'],
      }
}
