#
# Cookbook:: dynatraceoneagent
# Recipe:: oneagent-linux
#
# Copyright:: 2017, Dynatrace

tmp_dir = "/tmp"
filename = "dynatrace-oneagent-Linux.sh"
download_link = node['download_link']

directory "#{tmp_dir}"

remote_file "#{tmp_dir}/#{filename}" do
   source "#{download_link}"
end

script "dynatrace-oneagent-Linux" do
   interpreter "sh"
   user "root"
   code <<-EOH
      /bin/sh #{tmp_dir}/#{filename}
   EOH
end

file "#{tmp_dir}/#{filename}" do
   action :delete
end
