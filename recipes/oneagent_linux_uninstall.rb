#
# Cookbook:: dynatraceoneagent
# Recipe:: oneagent_linux_uninstall
#
# Copyright:: 2021, Dynatrace, LLC.

oneagent_install_dir = node['dynatraceoneagent']['oneagent_install_dir']
oneagent_ctl_bin_path = node['dynatraceoneagent']['oneagent_ctl_bin_path']

execute 'uninstall_oneagent' do
  command "#{oneagent_install_dir}/agent/uninstall.sh"
  timeout 6000
  only_if { ::File.exist?(oneagent_ctl_bin_path) }
end