# Class: sshd
#
# This module manages the ssh daemon
#
# Sample Usage:
#   include sshd
#
class sshd (
  $provider        = 'ldap',
  $ldap_uri        = undef,
  $ldap_base       = undef,
  $ldap_tls_cacert = undef,
){

  if $provider == 'ldap' and (!$ldap_uri or !$ldap_base) {
    fail('sshd: ldap_uri and ldap_base are required when provider = ldap')
  }


  class { '::sshd::install': } ->
  class { '::sshd::config': } ~>
  class { '::sshd::service': }

}
