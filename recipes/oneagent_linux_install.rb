#
# Cookbook:: dynatraceoneagent
# Recipe:: oneagent_linux_install
#
# Copyright:: 2021, Dynatrace, LLC.

oneagent_installer_path = node['dynatraceoneagent']['oneagent_installer_path']
oneagent_preserve_installer = node['dynatraceoneagent']['oneagent_preserve_installer']
dynatrace_root_cert_path = node['dynatraceoneagent']['dynatrace_root_cert_path']
oneagent_install_params_hash = node['dynatraceoneagent']['oneagent_install_params_hash']
oneagent_ctl_bin_path = node['dynatraceoneagent']['oneagent_ctl_bin_path']
oneagent_install_params_hash = node['dynatraceoneagent']['oneagent_install_params_hash']
oneagent_certificate_verification_header = node['dynatraceoneagent']['oneagent_certificate_verification_header']
verify_installer_signature = node['dynatraceoneagent']['verify_installer_signature']
oneagent_installer_params = oneagent_install_params_hash.map{|key,value|"#{key}=#{value}"}.join(' ')

cookbook_file dynatrace_root_cert_path do
  source 'dt-root.cert.pem'
  mode '0644'
  action :create
  only_if { verify_installer_signature }
  not_if { ::File.exist?(oneagent_ctl_bin_path) }
end

execute 'verify_installer_signature' do
  command <<-EOF
            ( printf "%s" "#{oneagent_certificate_verification_header}"; \
              cat "#{oneagent_installer_path}" ) | \
              openssl cms -verify -CAfile "#{dynatrace_root_cert_path}" > /dev/null
        EOF
  only_if { verify_installer_signature  }
  creates oneagent_ctl_bin_path
end

execute 'install_oneagent' do
  command "/bin/sh #{oneagent_installer_path} #{oneagent_installer_params}"
  timeout 6000
  creates oneagent_ctl_bin_path
end

include_recipe 'dynatraceoneagent::oneagent_service'

if !oneagent_preserve_installer
  include_recipe 'dynatraceoneagent::oneagent_installer_cleanup'
end