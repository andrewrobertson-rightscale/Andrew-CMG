rightscale_marker :begin

directory "/home/vhosts/xenforo-addons" do
	owner "rightscale"
	group "apache"
	mode 00755
	recursive true
	action :create
end

#bash "create passwd" do
#  user "root"
#  cwd "/root"
#  code <<-EOH
#	cd /home/vhosts && htpasswd -bc .passwd cmgsysop 533_EMM_6eef7W
#  EOH
#end

template "/etc/httpd/sites-available/99-xenforo-addons.carbonmedia.net.conf" do
	source "vhost_xenforo-addons_carbonmedia_net.conf.erb"
	owner "root"
	group "root"
	mode "0644"
	action :create
end

link "/etc/httpd/sites-enabled/99-xenforo-addons.carbonmedia.net.conf" do
    to "/etc/httpd/sites-available/99-xenforo-addons.carbonmedia.net.conf"
end

bash "restart_httpd" do
	code <<-EOF
		service httpd restart
	EOF
end

rightscale_marker :end