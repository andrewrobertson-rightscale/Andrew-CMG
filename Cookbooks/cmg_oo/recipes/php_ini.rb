#
# Cookbook Name:: cmg_oo
# Recipe:: php_ini
#

rightscale_marker :begin

template "/etc/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables( 
            :include_path => ".:/usr/share/pear:/usr/share/php",
            :upload_max_filesize => "256M",
            :max_input_time => "7200",
            :max_execution_time => "600",
            :memory_limit => "128M",
            :mysql_connect_timeout => "15",
            :post_max_size => "256M",
            :error_reporting => "E_ALL & ~E_NOTICE & ~E_DEPRECATED & ~E_STRICT & ~E_WARNING",
            :short_open_tag => "On"
             )
  action :create
end

rightscale_marker :end
