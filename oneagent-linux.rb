tmp_dir = "/tmp"
filename = "dynatrace-oneagent-Linux.sh"
environment = "<insert your environment id here>"
token = "<insert your token here>"

directory "#{tmp_dir}"

remote_file "#{tmp_dir}/#{filename}" do
   source "https://#{environment}.live.dynatrace.com/installer/agent/unix/latest/#{token}"
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
