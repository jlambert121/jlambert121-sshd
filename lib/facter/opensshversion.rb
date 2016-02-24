require 'puppet'
Facter.add("opensshversion") do
  setcode do
    if Facter::Util::Resolution.which('rpm')
      Facter::Util::Resolution.exec('rpm -q openssh --nosignature --nodigest --qf \'%{VERSION}\'')
    end
  end
end
