class nagios-server::export:host {
    
  include nagios-server::defaults
  include nagios-server::export::file

  export_file('host')
  ->
  @@nagios_host { $::fqdn:
    ensure  => present,
    alias   => $hostname,
    address => $ipaddress,
    use     => 'linux-server',
    target  => "$defaults::resource_dir/host/${::fqdn}.cfg",
  }
  
}
