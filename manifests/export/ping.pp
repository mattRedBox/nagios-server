class nagios-server::export::ping {
    
  include nagios-server::defaults
  include nagios-server::export::file

  export_file('check_ping')
  ->
  @@nagios_service { "${::fqdn}-check_ping":
    use => 'check_ping',
    host_name => $::fqdn,
    target  => "$defaults::resource_dir/check_ping/${::fqdn}.cfg",
  }

}
