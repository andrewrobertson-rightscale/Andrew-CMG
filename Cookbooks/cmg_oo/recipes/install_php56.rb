#
# Cookbook Name:: cmg_oo
# Recipe:: install_php56
#

bash "install_php56" do 
  user "root"
  cwd "/root"
  code <<-EOH
	wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
	rpm -Uvh epel-release-latest-6.noarch.rpm  
	rpm -Uvh http://dl.iuscommunity.org/pub/ius/stable/Redhat/6/x86_64/ius-release-1.0-10.ius.el6.noarch.rpm
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
