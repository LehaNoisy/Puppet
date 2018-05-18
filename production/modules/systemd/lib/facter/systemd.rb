# Fact: systemd
#
# Purpose:
#   Determine whether systemd is the init system on the node
#
# Resolution:
#   Check the name of the process 1 (ps -p 1)
#
# Caveats:
#

# Fact: systemd_version
#
# Purpose:
#   Determine the version of systemd installed
#
# Resolution:
#  Check the output of systemctl --version
#
# Caveats:
#

# Fact: systemd_internal_services
#
# Purpose:
#   List all systemd internal real services + their state
#
# Resolution:
#  Check the output of systemctl --version
#
# Caveats:
#
Facter.add(:systemd) do
  confine :kernel => :linux
  setcode do
    Facter.value(:service_provider) == 'systemd'
  end
end

Facter.add(:systemd_version) do
  confine :systemd => true
  setcode do
    Facter::Util::Resolution.exec("systemctl --version | awk '/systemd/{ print $2 }'")
  end
end

Facter.add(:systemd_internal_services) do
  confine :systemd => true
  setcode do
    command_output = Facter::Util::Resolution.exec(
      'systemctl list-unit-files --no-legend --no-pager "systemd-*" -t service --state=enabled,disabled,enabled-runtime,indirect'
    )
    lines = command_output.lines.lazy.map { |line| line.split(/\s+/) }
    lines.each_with_object({}) do |(service, status, *), result|
      result[service] = status
    end
  end
end