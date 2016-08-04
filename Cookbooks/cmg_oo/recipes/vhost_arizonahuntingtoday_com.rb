rightscale_marker :begin

directory "/mnt/efs/vhosts/arizonahuntingtoday.com" do
	owner "rightscale"
	group "apache"
	mode 00755
	recursive true
	action :create
end

template "/etc/httpd/sites-available/16-www.arizonahuntingtoday.com.conf" do
	source "vhost_arizonahuntingtoday_com.conf.erb"
	owner "root"
	group "root"
	mode "0644"
	action :create
end

link "/etc/httpd/sites-enabled/16-www.arizonahuntingtoday.com.conf" do
    to "/etc/httpd/sites-available/16-www.arizonahuntingtoday.com.conf"
end

bash "restart_httpd" do
	code <<-EOF
		service httpd restart
	EOF
end

rightscale_marker :end
