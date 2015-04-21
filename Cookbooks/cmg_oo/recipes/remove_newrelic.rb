#
# Cookbook Name:: cmg_oo
# Recipe:: remove_newrelic
#

rightscale_marker :begin

service "newrelic-sysmond" do
  :action stop
end

bash "remove_newrelic" do
  code <<-EOF
  	yum -y remove newrelic-sysmond
  EOF
end

rightscale_marker :end
