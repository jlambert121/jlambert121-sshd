require 'spec_helper'

describe 'sshd::config', :type => :class do

  it { should contain_file('/etc/ssh/sshd_config').with_mode('0400') }
  it { should contain_file('/etc/ssh/ldap.conf') }

end
