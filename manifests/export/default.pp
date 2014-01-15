class nagios-server::export::default {
    
  class { 'nagios-server::export::host': }
  class { 'nagios-server::export::hostextinfo': }
  class { 'nagios-server::export::host::ping': }
}
