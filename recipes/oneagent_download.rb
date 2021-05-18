#
# Cookbook:: dynatraceoneagent
# Recipe:: oneagent_download
#
# Copyright:: 2021, Dynatrace, LLC.

oneagent_installer_path = node['dynatraceoneagent']['oneagent_installer_path']
dynatrace_paas_token = node['dynatraceoneagent']['dynatrace_paas_token']
dynatrace_environment_url = node['dynatraceoneagent']['dynatrace_environment_url']
dynatrace_deployment_api = node['dynatraceoneagent']['dynatrace_deployment_api']
oneagent_os_type = node['dynatraceoneagent']['oneagent_os_type']
oneagent_installer_type = node['dynatraceoneagent']['oneagent_installer_type']
oneagent_installer_architecture = node['dynatraceoneagent']['oneagent_installer_architecture']
oneagent_version = node['dynatraceoneagent']['oneagent_version']
oneagent_package_state = node['dynatraceoneagent']['oneagent_package_state']
oneagent_ctl_bin_path = node['dynatraceoneagent']['oneagent_ctl_bin_path']

case oneagent_version
when 'latest'
  oneagent_download_link = "#{dynatrace_environment_url}#{dynatrace_deployment_api}/#{oneagent_os_type}/#{oneagent_installer_type}/latest?arch=#{oneagent_installer_architecture}"
else 
  oneagent_download_link = "#{dynatrace_environment_url}#{dynatrace_deployment_api}/#{oneagent_os_type}/#{oneagent_installer_type}/version/#{oneagent_version}?arch=#{oneagent_installer_architecture}"
end

unless ::File.exist?(oneagent_ctl_bin_path) and oneagent_package_state == 'installed'
  remote_file oneagent_installer_path do
    source oneagent_download_link
    headers( "Authorization"=>"Api-Token #{dynatrace_paas_token}" )
    action :create_if_missing
  end
end

case node['os']
when 'linux'
  if oneagent_package_state == 'installed'
    include_recipe 'dynatraceoneagent::oneagent_linux_install'
  elsif oneagent_package_state == 'removed'
    include_recipe 'dynatraceoneagent::oneagent_linux_uninstall'
  else
    raise "#{oneagent_package_state}' is not a valid option!"
  end
when 'windows'
  if oneagent_package_state == 'installed'
    include_recipe 'dynatraceoneagent::oneagent_windows_install'
  elsif oneagent_package_state == 'removed'
    include_recipe 'dynatraceoneagent::oneagent_windows_uninstall'
  else
    raise "#{oneagent_package_state}' is not a valid option!"
  end
else
  raise "#{node['os']}' is not supported!"
end