rightscale_marker :begin

directory "/mnt/efs/vhosts/heartbeat" do
	owner "rightscale"
	group "apache"
	mode 00755
	recursive true
	action :create
end

template "/etc/httpd/sites-available/99-www.heartbeat.conf" do
	source "vhost_heartbeat.conf.erb"
	owner "root"
	group "root"
	mode "0644"
	action :create
end

link "/etc/httpd/sites-enabled/99-www.heartbeat.com.conf" do
    to "/etc/httpd/sites-available/99-www.heartbeat.com.conf"
end

template "/mnt/efs/vhosts/heartbeat/db-heartbeat.php" do
  source "db-heartbeat.php"
  owner "apache"
  group "apache"
  mode 0777
  action :create
end

service "httpd" do
  action :restart
end

rightscale_marker :end
