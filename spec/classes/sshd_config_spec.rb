require 'spec_helper'

describe 'sshd', :type => :class do
  let(:facts) { { :osfamily => 'Redhat', :operatingsystemmajrelease => '7', :opensshversion => '6.4p1' } }
  let(:params) { { :ldap_uri => 'ldap://ldap.example.com', :ldap_base => 'ou=example,ou=com' } }

  context 'RH7' do
    it { should contain_file('/etc/ssh/sshd_config').with(
      :mode    =>'0400',
      :content => /AuthorizedKeysCommandUser nobody/
    ) }
  end

  context 'RH6' do
    let(:facts) { { :osfamily => 'Redhat', :operatingsystemmajrelease => '6', :opensshversion => '5.3p1' } }
    it { should contain_file('/etc/ssh/sshd_config').with(
      :mode    =>'0400',
      :content => /AuthorizedKeysCommandRunAs nobody/
    ) }
  end

  context 'generic' do
    context 'no CACERT' do
      it { should contain_file('/etc/ssh/ldap.conf').with(
        :content => /BASE\s+ou=example,ou=com\nURI\s+ldap:\/\/ldap\.example\.com/
      ) }
    end

    context 'with CACERT' do
      let(:params) { { :ldap_uri => 'ldap://ldap.example.com', :ldap_base => 'ou=example,ou=com', :ldap_tls_cacert => '/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem' } }
      it { should contain_file('/etc/ssh/ldap.conf').with(
        :content => /BASE\s+ou=example,ou=com\nURI\s+ldap:\/\/ldap\.example\.com\nTLS_CACERT\s+\/etc\/pki\/ca\-trust\/extracted\/pem\/tls\-ca\-bundle\.pem/
      ) }
    end
  end
end
