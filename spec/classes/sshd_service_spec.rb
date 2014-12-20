require 'spec_helper'

describe 'sshd::service', :type => :class do

  it { should contain_service('sshd') }

end
