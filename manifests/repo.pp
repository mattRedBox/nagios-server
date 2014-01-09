class nagios-server::repo {
  include nagios-server::defaults

  Exec {
    path   => $defaults::exec_path,
    logout => true,
  }

  $name_short = "rpmforge-release"
  $name_long = "rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm"

  package { 'yum-plugin-priorities' :
    ensure => installed,
  }
  ->
  case $::operatingsystem {
    'CentOS' : {
      case $::operatingsystemmajrelease {
        '6' : {
          exec { "rpm -Uv http://packages.sw.be/$name_short/$name_long",
            unless => "/bin/rpm -q --quiet $name_short", 
          } 
        }
      }
    }
  }
  ->
  yumrepo { 'rpmforge':
    priority => 10,
  }
}
