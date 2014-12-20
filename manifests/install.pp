class sshd::install (
){

  package { 'openssh-server':
    ensure => 'latest',
    notify => Class['sshd::service'],
  }

  package { 'openssh-ldap':
    ensure => 'latest',
  }

}