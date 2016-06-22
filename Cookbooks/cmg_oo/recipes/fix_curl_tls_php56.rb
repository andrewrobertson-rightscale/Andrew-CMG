#
# Cookbook Name:: cmg_oo
# Recipe:: fix_curl_tls_php56
#

bash "install_php56" do 
  user "root"
  cwd "/root"
  code <<-EOH
	rpm -Uvh http://www.city-fan.org/ftp/contrib/yum-repo/city-fan.org-release-1-13.rhel6.noarch.rpm
	yum -y --enablerepo=city-fan.org update curl  
  EOH
end

