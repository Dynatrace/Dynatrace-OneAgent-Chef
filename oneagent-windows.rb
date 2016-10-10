environment = "<insert your environment id here>"
token = "<insert your token here>"

windows_package 'Dynatrace OneAgent' do
  source "https://#{environment}.live.dynatrace.com/installer/agent/windows/msi/latest/#{token}"
  installer_type :msi
  action :install
end
