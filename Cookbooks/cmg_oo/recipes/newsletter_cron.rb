#
# Cookbook Name:: cmg_oo
# Recipe:: newsletter_cron
#

rightscale_marker :begin

cron "newsletter_cron" do
  minute "*/5"
  command "php -f /home/vhosts/newsletter.carbonmedia.net/scheduled.php > /dev/null 2>&1"
  action :create
end

rightscale_marker :end
