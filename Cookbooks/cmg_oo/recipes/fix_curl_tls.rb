#
# Cookbook Name:: cmg_oo
# Recipe:: fix_curl_tls
#

rightscale_marker :begin

bash "fix_curl_tls" do
	user "root"
	code <<-EOF
		rpm -Uvh http://www.city-fan.org/ftp/contrib/yum-repo/city-fan.org-release-1-13.rhel6.noarch.rpm
		yum -y --enablerepo=city-fan.org update curl
		service httpd restart
	EOF
end

rightscale_marker :end