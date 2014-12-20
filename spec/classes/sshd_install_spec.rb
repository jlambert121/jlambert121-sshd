require 'spec_helper'

describe 'sshd::install', :type => :class do

  it { should contain_package('openssh-server') }
  it { should contain_package('openssh-ldap') }

end
