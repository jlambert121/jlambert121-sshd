require 'spec_helper'

describe 'sshd', :type => :class do
  let(:params) { { :ldap_uri => 'ldap://ldap.example.com', :ldap_base => 'ou=example,ou=com' } }

  it { should contain_file('/etc/ssh/sshd_config').with_mode('0400') }
  it { should contain_file('/etc/ssh/ldap.conf') }

end
