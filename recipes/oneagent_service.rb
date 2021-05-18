#
# Cookbook:: dynatraceoneagent
# Recipe:: oneagent_service
#
# Copyright:: 2021, Dynatrace, LLC.

oneagent_service_state = node['dynatraceoneagent']['oneagent_service_state']

service node['dynatraceoneagent']['oneagent_service'] do
  supports status: true, restart: true
  action oneagent_service_state
  timeout 120 if platform_family?('windows')
end