class sshd::service {

  service { 'sshd':
    ensure => 'running',
    enable => true,
  }

}