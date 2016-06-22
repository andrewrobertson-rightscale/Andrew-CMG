#
# Cookbook Name:: cmg_oo
# Recipe:: install_php56
#

bash "install_php56" do 
  user "root"
  cwd "/root"
  code <<-EOH
    yum -y install yum-plugin-replace
	yum -y replace php53u --replace-with=php56u
  EOH
end

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
