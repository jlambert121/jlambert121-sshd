require 'spec_helper'

describe 'sshd', :type => :class do
  let(:facts) { { :osfamily => 'Redhat', :operatingsystemmajrelease => '7', :opensshversion => '6.4p1' } }
  let(:params) { { :ldap_uri => 'ldap://ldap.example.com', :ldap_base => 'ou=example,ou=com' } }

  context 'RH7' do
    it do
        should contain_file('/etc/ssh/sshd_config').with(
          :mode    =>'0400',
          :content => /AuthorizedKeysCommandUser nobody/
        )
      end
  end

  context 'RH6' do
    let(:facts) { { :osfamily => 'Redhat', :operatingsystemmajrelease => '6', :opensshversion => '5.3p1' } }
    it do
      should contain_file('/etc/ssh/sshd_config').with(
        :mode    =>'0400',
        :content => /AuthorizedKeysCommandRunAs nobody/
      )
    end
  end

  context 'ldap provider' do
    let(:params) { { :ldap_uri => 'ldap://ldap.example.com', :ldap_base => 'ou=example,ou=com', :provider => 'ldap' } }
    context 'no CACERT' do
      it { should contain_file('/etc/ssh/ldap.conf').with(:content => /BASE\s+ou=example,ou=com\nURI\s+ldap:\/\/ldap\.example\.com/) }
      it { should contain_file('/etc/ssh/sshd_config').with(:content => /AuthorizedKeysCommand \/usr\/libexec\/openssh\/ssh-ldap-wrapper/)}
    end

    context 'with CACERT' do
      let(:params) { { :ldap_uri => 'ldap://ldap.example.com', :ldap_base => 'ou=example,ou=com', :ldap_tls_cacert => '/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem', :provider => 'ldap' } }
      it { should contain_file('/etc/ssh/ldap.conf').with(:content => /BASE\s+ou=example,ou=com\nURI\s+ldap:\/\/ldap\.example\.com\nTLS_CACERT\s+\/etc\/pki\/ca\-trust\/extracted\/pem\/tls\-ca\-bundle\.pem/) }
    end
  end

  context 'sss provider' do
    let(:params) { { :provider => 'sss' } }
    it { should contain_file('/etc/ssh/sshd_config').with(:content => /AuthorizedKeysCommand \/usr\/bin\/sss_ssh_authorizedkeys/)}
  end
end
