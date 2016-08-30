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
  source "authorized_keys.erb"
  owner "root"
  group "root"
  mode "0600"
  variables( 
            :ssh_key => "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAnuOjr9HpRrhDglkuNNrpZDxsN6jGin78Av9w5OKGeVernUNDkbN6Z/Ju+QCQnBLTV1zHCKa8105Q3dojS/EazU2e2po4QrAm/ZZwQVwSUyExXJ4aQ0tVDP3WKWq5JZ0TcBwVesF1siSpuSUDJ4I3uUhWk2qYz8UszbPqkAjsUzBc0DIEvU9sRhIL1/2Ct6KPEseia8VrygrrU2qvXM5DQP/9akISlC1RhdgUj2Nf+h3b8mhJCWoVlPG3xr9U8MZsY95yi45uoPgmxO+Wgq53I3op2khqC+gWUTAJHFGR2gUXdA4AiE0OEUeveA7B8yFQZC5NiFrm76TW3S+dNQN2DQ== cmg-oo-app-server"
            )
  action :create
end

rightscale_marker :end
