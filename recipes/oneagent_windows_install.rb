#
# Cookbook:: dynatraceoneagent
# Recipe:: oneagent_windows_install
#
# Copyright:: 2021, Dynatrace, LLC.

oneagent_download_dir = node['dynatraceoneagent']['oneagent_download_dir']
oneagent_preserve_installer = node['dynatraceoneagent']['oneagent_preserve_installer']
oneagent_installer_path = node['dynatraceoneagent']['oneagent_installer_path']
oneagent_ctl_bin_path = node['dynatraceoneagent']['oneagent_ctl_bin_path']
oneagent_install_params_hash = node['dynatraceoneagent']['oneagent_install_params_hash']
oneagent_installer_params = oneagent_install_params_hash.map{|key,value|"#{key}=#{value}"}.join(' ')

windows_package 'Dynatrace OneAgent' do
  source oneagent_installer_path
  installer_type :custom
  action :install
  options "#{oneagent_installer_params} --quiet"
end

include_recipe 'dynatraceoneagent::oneagent_service'

if !oneagent_preserve_installer
  include_recipe 'dynatraceoneagent::oneagent_installer_cleanup'
end