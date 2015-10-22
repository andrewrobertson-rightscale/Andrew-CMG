#
# Cookbook Name:: cmg_oo
# Recipe:: biggamehunt_net_cron
#

rightscale_marker :begin

cron "biggamehunt_net_cron" do
  minute "00"
  mailto "rchristy@carbonmediagroup.com"
  command "cd /home/vhosts/biggamehunt.net && /usr/bin/drush cron"
  action :create
end

rightscale_marker :end
