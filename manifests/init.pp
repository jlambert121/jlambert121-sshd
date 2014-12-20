# Class: sshd
#
# This module manages the ssh daemon
#
# Sample Usage:
#   include sshd
#
class sshd (
  $ldap_uri,
  $ldap_base,
  $ldap_tls_cacert  = '/etc/pki/tls/certs/ca-bundle.crt',
){

  class { 'sshd::install': } ->
  class { 'sshd::config': } ~>
  class { 'sshd::service': }

}
