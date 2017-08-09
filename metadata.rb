name 'dynatraceoneagent'
maintainer 'Piotr Mejer'
maintainer_email 'piotr.mejer@dynatrace.com'
license 'MIT'
description 'Installs the Dynatrace One Agent.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'
source_url 'https://github.com/Dynatrace/Dynatrace-OneAgent-Chef'
issues_url 'https://github.com/Dynatrace/Dynatrace-OneAgent-Chef/issues'
chef_version '>= 12.1'
%w( debian ubuntu redhat centos fedora amazon windows ).each do |os|
  supports os
end
