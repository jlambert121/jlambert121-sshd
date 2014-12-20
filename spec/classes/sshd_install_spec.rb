require 'spec_helper'

describe 'sshd', :type => :class do
  let(:params) { { :ldap_uri => 'ldap://ldap.example.com', :ldap_base => 'ou=example,ou=com' } }

  it { should contain_package('openssh-server') }
  it { should contain_package('openssh-ldap') }

end
