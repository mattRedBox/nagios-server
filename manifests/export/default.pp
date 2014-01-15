class nagios-server::export::default {
  include nagios-server::export::file    
  class { 'nagios-server::export::host': }
  class { 'nagios-server::export::hostextinfo': }
  class { 'nagios-server::export::host::ping': }
}
