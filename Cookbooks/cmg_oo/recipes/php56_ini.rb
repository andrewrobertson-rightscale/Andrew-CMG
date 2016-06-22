#
# Cookbook Name:: cmg_oo
# Recipe:: php56_ini
#

rightscale_marker :begin

template "/etc/php.ini" do
  source "php56.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables( 
            :include_path => ".:/usr/share/pear:/usr/share/php:/var/lib/www/cake-latest/lib:/var/www/html/api.carbonmediagroup.com/rest/server/lib",
            :upload_max_filesize => "384M",
            :max_input_time => "7200",
            :memory_limit => "384M",
            :post_max_size => "384M",
            :error_reporting => "E_ALL & ~E_NOTICE & ~E_DEPRECATED & ~E_STRICT & ~E_WARNING",
            :short_open_tag => "On",
            :new_relic_license_key => node['new_relic']['install']['license_key']
             )
  action :create
end

rightscale_marker :end
