class nagios-server::repo {
  $gpg_file_location = "/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6"

  package { 'yum-priorities' :
    ensure => installed,
  }

  file { "$gpg_file_location" :
    ensure => present,
  }

  case $operatingsystem {
    'centos' : {
      yumrepo { 'rpmforge-release' :
        baseurl => 'http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm',
        priority  => 10,
        timeout   => 60,
        enabled   => 1,
        gpgkey    => "$gpg_file_location",
        gpgcheck  => 1,
        require   => [
          Package['yum-priorities'],
          File[${gpg_file_location}]
        ],
      }
    }
  }
}
