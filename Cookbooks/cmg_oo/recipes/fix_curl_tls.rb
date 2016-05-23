#
# Cookbook Name:: cmg_oo
# Recipe:: fix_curl_tls
#

rightscale_marker :begin

bash "fix_curl_tls" do
	user "root"
	code <<-EOF
		wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
		rpm -Uvh epel-release-latest-6.noarch.rpm
		rpm -Uvh http://dl.iuscommunity.org/pub/ius/stable/Redhat/6/x86_64/ius-release-1.0-10.ius.el6.noarch.rpm
		yum install -y yum-plugin-replace
		yum replace -y openssl --replace-with openssl10
		rpm -Uvh http://www.city-fan.org/ftp/contrib/yum-repo/city-fan.org-release-1-13.rhel6.noarch.rpm
		yum -y --enablerepo=city-fan.org update curl
		service httpd restart
	EOF
end

rightscale_marker :end