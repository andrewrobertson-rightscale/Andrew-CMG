#
# Cookbook Name:: cmg_oo
# Recipe:: install_core_oo_app1_github_ssh_key
#

rightscale_marker :begin

directory "/root/.ssh" do
    owner "root"
    group "root"
    mode "0700"
    recursive true
    action :create
end

template "/root/.ssh/id_rsa" do
  source "app1-core-sites-ssh-key.erb"
  owner "root"
  group "root"
  mode "0600"
  action :create
end

rightscale_marker :end
