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
  $ldap_tls_cacert = undef,
){

  class { 'sshd::install': } ->
  class { 'sshd::config': } ~>
  class { 'sshd::service': }

}
