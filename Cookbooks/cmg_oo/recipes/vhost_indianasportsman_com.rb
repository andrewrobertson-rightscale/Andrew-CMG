rightscale_marker :begin

directory "/home/vhosts/indianasportsman.com" do
	owner "rightscale"
	group "apache"
	mode 00755
	recursive true
	action :create
end

template "/etc/httpd/sites-available/10-www.indianasportsman.com" do
	source "vhost_indianasportsman_com.conf.erb"
	owner "root"
	group "root"
	mode "0644"
	action :create
end

link "/etc/httpd/sites-available/10-www.indianasportsman.com" do
    to "/etc/httpd/sites-enabled/10-www.indianasportsman.com"
end

bash "restart_httpd" do
	code <<-EOF
		service httpd restart
	EOF
end

rightscale_marker :end