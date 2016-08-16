require 'spec_helper'

describe 'sshd' do
  let(:facts) { { :osfamily => 'Redhat', :operatingsystemmajrelease => '7', :opensshversion => '6.4p1', :operatingsystem => 'CentOS', :selinux => 'true' } }

  describe 'provider ldap' do
    let(:params) { { :provider => 'ldap', :ldap_uri => 'ldap://ldap.example.com', :ldap_base => 'ou=example,ou=com' } }

    it { should contain_package('openssh-server') }
    it { should contain_package('openssh-ldap') }
  end

  describe 'provider sss' do
    let(:params) { { :provider => 'sss' } }

    it { should contain_package('openssh-server') }
    it { should_not contain_package('openssh-ldap') }
  end
end
