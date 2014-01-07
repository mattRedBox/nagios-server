class nagios-service::export {
  @@nagios_host { $::fqdn:
    address       => $::ipaddress,
    check_command => 'check-host-alive!3000.0,80%!5000.0,100%!10',
    hostgroups    => 'all-servers',
    target        => "/etc/nagios/resource.d/host_${::fqdn}.cfg"
  }
}
