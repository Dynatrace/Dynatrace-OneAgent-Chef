#
# Cookbook:: dynatraceoneagent
# Recipe:: default
#
# Copyright:: 2017, Dynatrace

if platform_family?('windows')
  include_recipe 'dynatraceoneagent::oneagent-windows'
else
  include_recipe 'dynatraceoneagent::oneagent-linux'
end


