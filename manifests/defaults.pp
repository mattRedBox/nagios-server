class nagios-server::defaults {
  $exec_path = [
        '/usr/local/bin',
        '/opt/local/bin',
        '/usr/bin',
        '/usr/sbin',
        '/bin',
        '/sbin']

  Exec { 
    path => $exec_path, 
    logoutput => true,
  }
}
