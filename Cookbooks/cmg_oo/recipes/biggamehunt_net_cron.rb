#
# Cookbook Name:: cmg_oo
# Recipe:: biggamehunt_net_cron
#

rightscale_marker :begin

bash "install_composer" do 
  user "root"
  cwd "/root"
  code <<-EOH
    cd
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
    ln -s /usr/local/bin/composer /usr/bin/composer
  EOH
end

bash "install_drush" do
  user "root"
  cwd "/root"
  code <<-EOH
    cd
    git clone https://github.com/drush-ops/drush.git /usr/local/src/drush
    cd /usr/local/src/drush
    git checkout 7.3.0 #or whatever version you want.
    ln -s /usr/local/src/drush/drush /usr/bin/drush
    composer install
    drush --version    
  EOH
end

cron "biggamehunt_net_cron" do
  minute "00"
  command "cd /mnt/storage1/biggamehunt.net && /usr/bin/drush cron"
  action :create
end

rightscale_marker :end
