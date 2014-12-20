class sshd::config (
  $ldap_uri        = $::sshd::ldap_uri,
  $ldap_base       = $::sshd::ldap_base,
  $ldap_tls_cacert = $::sshd::ldap_tls_cacert,
){

  file { '/etc/ssh/ldap.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('sshd/ldap.conf.erb'),
  }

  file { '/etc/ssh/sshd_config':
    ensure  => 'file',
    mode    => '0400',
    owner   => 'root',
    group   => 'root',
    require => Package['openssh-server'],
    notify  => Service[ 'sshd' ],
    content => template('sshd/sshd_config'),
  }

  file { '/etc/pam.d/sshd':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0444',
    source => 'puppet:///modules/sshd/sshd',

  }
}