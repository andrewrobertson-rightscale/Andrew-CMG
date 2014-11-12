#
# Cookbook Name:: cmg_oo
# Recipe:: create_db_users_run
#

rightscale_marker :begin

bash "run_create_db_users" do
  user "root"
  cwd "/root"
  code <<-EOH
  ~/create_db_users
  EOH
end

rightscale_marker :end
