# Class sshd::install
#
# Manages sshd packages
#
#
class sshd::install (
){

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { 'openssh-server':
    ensure => 'latest',
    notify => Class['sshd::service'],
  }

  package { 'openssh-ldap':
    ensure => 'latest',
  }

}