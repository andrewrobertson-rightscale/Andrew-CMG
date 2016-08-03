rightscale_marker :begin

directory "/mnt/efs/vhosts/xenforo-addons_carbonmedia.net" do
	owner "rightscale"
	group "apache"
	mode 00755
	recursive true
	action :create
end

template "/etc/httpd/sites-available/19-www.xenforo-addons_carbonmedia.net.conf" do
	source "vhost_xenforo-addons_carbonmedia_net.conf.erb"
	owner "root"
	group "root"
	mode "0644"
	action :create
end

link "/etc/httpd/sites-enabled/19-www.xenforo-addons_carbonmedia.net.conf" do
    to "/etc/httpd/sites-available/19-www.xenforo-addons_carbonmedia.net.conf"
end

bash "restart_httpd" do
	code <<-EOF
		service httpd restart
	EOF
end

rightscale_marker :end
