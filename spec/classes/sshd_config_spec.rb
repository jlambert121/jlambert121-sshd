require 'spec_helper'

describe 'sshd', :type => :class do
  let(:facts) { { :osfamily => 'Redhat', :operatingsystemmajrelease => '7', :opensshversion => '6.4p1', :operatingsystem => 'CentOS', :selinux => 'true' } }
  let(:params) { { :ldap_uri => 'ldap://ldap.example.com', :ldap_base => 'ou=example,ou=com' } }

  context 'RH7' do
    it do
      should contain_file('/etc/ssh/sshd_config').with(
        :mode    =>'0400',
        :content => /AuthorizedKeysCommandUser nobody/
      )
    end
    it { should contain_file('/etc/pam.d/sshd').with(:source => 'puppet:///modules/sshd/sshd' ) }
  end

  context 'RH6' do
    let(:facts) { { :osfamily => 'Redhat', :operatingsystemmajrelease => '6', :opensshversion => '5.3p1', :operatingsystem => 'CentOS', :selinux => 'true' } }
    it do
      should contain_file('/etc/ssh/sshd_config').with(
        :mode    =>'0400',
        :content => /AuthorizedKeysCommandRunAs nobody/
      )
    end
    it { should contain_file('/etc/pam.d/sshd').with(:source => 'puppet:///modules/sshd/sshd.rh6' ) }
  end

  context 'ldap provider' do
    let(:params) { { :ldap_uri => 'ldap://ldap.example.com', :ldap_base => 'ou=example,ou=com', :provider => 'ldap' } }

    it { should contain_selboolean('authlogin_nsswitch_use_ldap').with(:value => 'on') }

    context 'without selinux' do
      let(:facts) { { :osfamily => 'Redhat', :operatingsystemmajrelease => '7', :opensshversion => '6.4p1', :operatingsystem => 'CentOS', :selinux => 'false' } }
      it { should_not contain_selboolean('authlogin_nsswitch_use_ldap').with(:value => 'on') }
    end

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

  context 'with port' do
    let(:params) { { :port => 1022, :provider => 'sss' } }
    it { should contain_file('/etc/ssh/sshd_config').with(:content => /Port 1022/)}
    it { should contain_selinux__port('allow-ssh-port').with(:port => 1022 ) }

    context 'without selinux' do
      let(:facts) { { :selinux => false, :operatingsystemmajrelease => '7', :operatingsystem => 'CentOS', :opensshversion => '6.4p1', :osfamily => 'Redhat' } }
      it { should_not contain_selinux__port('allow-ssh-port') }
    end
  end
end
