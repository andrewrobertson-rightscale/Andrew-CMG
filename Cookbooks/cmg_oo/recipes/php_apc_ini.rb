#
# Cookbook Name:: cmg_oo
# Recipe:: php_apc_ini
#

rightscale_marker :begin

template "/etc/php.d/apc.ini" do
  source "apc.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables( 
            :enabled => "1",
            :optimization => "0",
            :shm_segments => "1",
            :shm_size => "256M",
            :ttl => "60",
            :user_ttl => "7200",
            :num_files_hint => "1024",
            :mmap_file_mask => "/dev/zero",
            :enable_cli => "1",
            :rfc1867 => "1"
             )
  action :create
end

rightscale_marker :end
