#
# Cookbook:: dynatraceoneagent
# Recipe:: oneagent_installer_cleanup
#
# Copyright:: 2021, Dynatrace, LLC.

oneagent_installer_path = node['dynatraceoneagent']['oneagent_installer_path']
dynatrace_root_cert_path = node['dynatraceoneagent']['dynatrace_root_cert_path']

file oneagent_installer_path do
  action :delete
end

if node['os'] == 'linux'
  file dynatrace_root_cert_path do
    action :delete
  end
end