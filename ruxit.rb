tmp_dir = "/tmp"
filename = "ruxit-Agent-Linux.sh"
tenant = "aexocnxmyl"
token = "MQ5FPdEtFPYuVwbu"

directory "#{tmp_dir}"

remote_file "#{tmp_dir}/#{filename}" do
   source "https://#{tenant}.live.ruxit.com/installer/agent/unix/latest/#{token}"
end

script "ruxit-Agent-Linux" do
   interpreter "sh"
   user "root"
   code <<-EOH
      /bin/sh #{tmp_dir}/#{filename}
   EOH
end

file "#{tmp_dir}/#{filename}" do
   action :delete
end