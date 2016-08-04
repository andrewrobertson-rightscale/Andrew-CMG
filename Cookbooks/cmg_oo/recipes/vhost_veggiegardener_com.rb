rightscale_marker :begin

directory "/mnt/efs/vhosts/core.carbonmedia.net" do
	owner "rightscale"
	group "apache"
	mode 00755
	recursive true
	action :create
end

template "/etc/httpd/sites-available/27-www.veggiegardener.com.conf" do
	source "vhost_veggiegardener_com.conf.erb"
	owner "root"
	group "root"
	mode "0644"
	action :create
end

link "/etc/httpd/sites-enabled/27-www.veggiegardener.com.conf" do
    to "/etc/httpd/sites-available/27-www.veggiegardener.com.conf"
end

bash "restart_httpd" do
	code <<-EOF
		service httpd restart
	EOF
end

rightscale_marker :end
