class nagios-server::export::hostextinfo {
    
  include nagios-server::defaults
  include nagios-server::export::file
  
  export_file{'hostextinfo':}
  
  @@nagios_hostextinfo { $::fqdn:
    ensure          => present,
    icon_image_alt  => $::operatingsystem,
    icon_image      => "base/${::operatingsystem}.png",
    statusmap_image => "base/${::operatingsystem}.gd2",
    target          => "$defaults::resource_dir/hostextinfo/${::fqdn}.cfg",
    require         => Export_file['hostextinfo'],
  }
}
