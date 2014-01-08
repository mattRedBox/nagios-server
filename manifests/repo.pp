class nagios-server::repo {
  $rpm_name = "rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm"

  package { 'yum-plugin-priorities' :
    ensure => installed,
  }

  case $operatingsystem {
    'centos' : {
      exec { "wget http://packages.sw.be/rpmforge-release/$rpm_name -O /tmp/$rpm_name":
        path => [ '/usr/bin', '/bin',],
      }
      ->
      exec { "rpm -Uvh /tmp/$rpm_name":
        path => [ '/usr/bin', '/bin',],
      }
    }
  }
}
