# Class: sshd
#
# This module manages the ssh daemon
#
# Sample Usage:
#   include sshd
#
class sshd (
  $ldap_uri         = 'ldap://ldap.example.com',
  $ldap_base        = 'dc=example,dc=com',
  $ldap_tls_cacert  = '/etc/pki/tls/certs/ca-bundle.crt',
){

  class { 'sshd::install': } ->
  class { 'sshd::config': } ~>
  class { 'sshd::service': }

}
