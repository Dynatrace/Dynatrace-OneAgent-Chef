#
# Cookbook:: dynatraceoneagent
# Recipe:: oneagent_windows_uninstall
#
# Copyright:: 2021, Dynatrace, LLC.

oneagent_ctl_bin_path = node['dynatraceoneagent']['oneagent_ctl_bin_path']

powershell_script 'uninstall_oneagent' do
  code <<-EOH
  $app = Get-WmiObject win32_product -filter "Name like 'Dynatrace OneAgent'"
  msiexec /x $app.IdentifyingNumber /quiet
  EOH
  only_if { ::File.exist?(oneagent_ctl_bin_path) }
end