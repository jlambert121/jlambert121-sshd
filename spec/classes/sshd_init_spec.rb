require 'spec_helper'

describe 'sshd', :type => :class do

  it { should contain_class('sshd::install') }
  it { should contain_class('sshd::config') }
  it { should contain_class('sshd::service') }

end
