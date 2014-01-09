class nagios-server::repo {
  include defaults
  $name_short = "rpmforge-release"
  $name_long = "rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm"

  package { 'yum-plugin-priorities' :
    ensure => installed,
  }

  case $::operatingsystem {
    'centos' : {
      case $::operatingsystemrelease {
        /^6.*$/ : {
          exec { [
            "wget http://packages.sw.be/$name_short/$name_long -O /tmp/$name_long",
            "rpm -Uvh /tmp/$name_long",
            "rm -Rf /tmp/$name_long"
            ]:
            unless => "rpm -q --quiet $name_short", 
          } 
        }
      }
    }
  }
}
