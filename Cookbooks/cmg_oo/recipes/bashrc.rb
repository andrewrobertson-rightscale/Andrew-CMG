#
# Cookbook Name:: cmg_oo
# Recipe:: bashrc
#

rightscale_marker :begin

template "/root/.bashrc" do
  source "bashrc.erb"
  owner "root"
  group "root"
  mode "0644"
  variables( 
            :server_name => node['bashrc']['server']['name'],
            :server_deployment => node['bashrc']['server']['deployment']
          )  
  action :create
end

template "/etc/skel/.bashrc" do
  source "bashrc.erb"
  owner "root"
  group "root"
  mode "0644"
  variables( 
            :server_name => node['bashrc']['server']['name'],
            :server_deployment => node['bashrc']['server']['deployment']
          )  
  action :create
end

rightscale_marker :end
