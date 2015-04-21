#
# Cookbook Name:: cmg_oo
# Recipe:: set_newrelic_hostname
#

rightscale_marker :begin

nr_host = "#{node['newrelic']['server_monitoring']['deployment_prefix']} #{node['newrelic']['server_monitoring']['hostname']}"

bash "set_newrelic_hostname" do
  code <<-EOF
  	echo 'hostname="#{nr_host}"' >> /etc/newrelic/nrsysmond.cfg
  EOF
end

service "newrelic-sysmond" do
  action :restart
end

rightscale_marker :end
