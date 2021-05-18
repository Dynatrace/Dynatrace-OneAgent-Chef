#
# Cookbook:: dynatraceoneagent
# Attributes:: default
#
# Copyright:: 2021, Dynatrace, LLC.

# OneAgent Download Parameters
default['dynatraceoneagent']['dynatrace_environment_url'] = nil
default['dynatraceoneagent']['dynatrace_paas_token'] = nil
default['dynatraceoneagent']['dynatrace_deployment_api'] = '/api/v1/deployment/installer/agent'
default['dynatraceoneagent']['oneagent_version'] = 'latest'
default['dynatraceoneagent']['oneagent_installer_architecture'] = 'x86'
default['dynatraceoneagent']['oneagent_installer_type'] = 'default'
default['dynatraceoneagent']['oneagent_preserve_installer'] = true

# OneAgent Install Parameters
default['dynatraceoneagent']['oneagent_install_params_hash'] = {
  '--set-infra-only'             => 'false',
  '--set-app-log-content-access' => 'true',
}
default['dynatraceoneagent']['oneagent_service_state'] = [:enable, :start]
default['dynatraceoneagent']['oneagent_package_state']  = 'installed'

case node['os']
when 'linux'
  # Parameters for OneAgent Download
  default['dynatraceoneagent']['oneagent_download_dir'] = '/tmp'
  default['dynatraceoneagent']['oneagent_installer_filename'] = "Dynatrace-OneAgent-Linux-#{node['dynatraceoneagent']['oneagent_version']}.sh"
  default['dynatraceoneagent']['oneagent_os_type'] = 'unix'
  default['dynatraceoneagent']['oneagent_installer_path'] = "#{node['dynatraceoneagent']['oneagent_download_dir']}/#{node['dynatraceoneagent']['oneagent_installer_filename']}"
  default['dynatraceoneagent']['verify_installer_signature'] = true
  default['dynatraceoneagent']['dynatrace_root_cert_file_name'] = 'dt-root.cert.pem'
  default['dynatraceoneagent']['dynatrace_root_cert_path'] = "#{node['dynatraceoneagent']['oneagent_download_dir']}/#{node['dynatraceoneagent']['dynatrace_root_cert_file_name']}"
  default['dynatraceoneagent']['oneagent_certificate_verification_header'] = "Content-Type: multipart/signed;
    protocol=\"application/x-pkcs7-signature\"; micalg=\"sha-256\";
    boundary=\"--SIGNED-INSTALLER\"\n\n----SIGNED-INSTALLER\n"

  # Parameters for OneAgent Installer
  if node['dynatraceoneagent']['oneagent_install_params_hash']['INSTALL_PATH']
    default['dynatraceoneagent']['oneagent_install_dir'] = node['dynatraceoneagent']['oneagent_install_params_hash']['INSTALL_PATH']
  else
    default['dynatraceoneagent']['oneagent_install_dir'] = "/opt/dynatrace/oneagent"
  end
  default['dynatraceoneagent']['oneagent_ctl_bin_path'] = "#{node['dynatraceoneagent']['oneagent_install_dir']}/agent/tools/oneagentctl"
  default['dynatraceoneagent']['oneagent_service'] = 'oneagent'

when 'windows'
  # Parameters for OneAgent Download
  default['dynatraceoneagent']['oneagent_download_dir'] = "#{ENV['TEMP']}"
  default['dynatraceoneagent']['oneagent_installer_filename'] = "Dynatrace-OneAgent-Windows-#{node['dynatraceoneagent']['oneagent_version']}.exe"
  default['dynatraceoneagent']['oneagent_installer_path'] = "#{node['dynatraceoneagent']['oneagent_download_dir']}\\#{node['dynatraceoneagent']['oneagent_installer_filename']}"
  default['dynatraceoneagent']['oneagent_os_type'] = 'windows'

  # Parameters for OneAgent Installer
  if node['dynatraceoneagent']['oneagent_install_params_hash']['INSTALL_PATH']
    default['dynatraceoneagent']['oneagent_install_dir'] = node['dynatraceoneagent']['oneagent_install_params_hash']['INSTALL_PATH']
  else
    default['dynatraceoneagent']['oneagent_install_dir'] = "#{ENV['PROGRAMFILES']}\\dynatrace\\oneagent"
  end
  default['dynatraceoneagent']['oneagent_ctl_bin_path'] = "#{node['dynatraceoneagent']['oneagent_install_dir']}\\agent\\tools\\oneagentctl.exe"
  default['dynatraceoneagent']['oneagent_service'] = 'Dynatrace OneAgent'

else
  raise "`#{node['os']}' is not supported!"
end
