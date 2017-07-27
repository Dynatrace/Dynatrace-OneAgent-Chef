download_link = node['download_link']

windows_package 'Dynatrace OneAgent' do
  source "#{download_link}"
  installer_type :msi
  action :install
end
