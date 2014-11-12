#
# Cookbook Name:: cmg_oo
# Recipe:: sendgrid_default_postfix
#

rightscale_marker :begin

template "/etc/postfix/main.cf" do
  source "main.cf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables( 
            :host => node[:cloud][:private_ips][0]
             )  
  action :create
end

service "postfix" do
  action :restart
end

rightscale_marker :end
