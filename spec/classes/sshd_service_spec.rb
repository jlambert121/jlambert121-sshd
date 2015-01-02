require 'spec_helper'

describe 'sshd', :type => :class do
  let(:facts) { { :osfamily => 'Redhat', :operatingsystemmajrelease => '7', :opensshversion => '6.4p1' } }
  let(:params) { { :ldap_uri => 'ldap://ldap.example.com', :ldap_base => 'ou=example,ou=com' } }

  it { should contain_service('sshd') }

end
