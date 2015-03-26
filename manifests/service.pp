# Class sshd::service
#
# Manages sshd service
#
#
class sshd::service {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { 'sshd':
    ensure => 'running',
    enable => true,
  }

}