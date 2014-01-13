class nagios-server::defaults {
  $exec_path = [
        '/usr/local/bin',
        '/opt/local/bin',
        '/usr/bin',
        '/usr/sbin',
        '/bin',
        '/sbin']

  $config_dir = '/etc/nagios'
  $resource_dir = "$config_dir/resource.d"
}
