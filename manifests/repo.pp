class nagios-server::repo {
  $gpg_file_location = "/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6"
  $rpm_name = "rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm"

  package { 'yum-plugin-priorities' :
    ensure => installed,
  }

  file { "$gpg_file_location" :
    ensure => present,
  }
  
  Exec { 
    path => [ '/usr/bin', '/bin',],
  }
  ->
  case $operatingsystem {
    'centos' : {
      exec { "wget http://packages.sw.be/rpmforge-release/$rpm_name -O /tmp/":}
      ->
      exec { "rpm -Uvh $rpm_name":}
    }
  }
}
