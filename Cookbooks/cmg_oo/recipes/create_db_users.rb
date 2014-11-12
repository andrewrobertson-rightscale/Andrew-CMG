#
# Cookbook Name:: cmg_oo
# Recipe:: create_db_users
#

rightscale_marker :begin

template "/root/create_db_users" do
  source "create_db_users.erb"
  owner "root"
  group "root"
  mode "0775"
  action :create
end

bash "run_create_db_users" do
  user "root"
  cwd "/root"
  code <<-EOH
  ~/create_db_users
  EOH
end

rightscale_marker :end
