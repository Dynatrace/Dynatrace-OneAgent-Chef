#
# Cookbook Name:: dynatrace
# Attributes:: default
#
# The Dynatrace download_link.
default['download_link'] = 'https://{tenant_id}.sprint.dynatracelabs.com/api/v1/deployment/installer/agent/unix/default/latest?Api-Token={token_id}&arch=x86'
