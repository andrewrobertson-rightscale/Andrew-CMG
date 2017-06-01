rightscale_marker :begin

directory "/home/vhosts/arkansashunting.net" do
    owner "rightscale"
    group "apache"
    mode 02775
    recursive true
    action :create
end

template "/etc/httpd/sites-available/39-www.arkansashunting.net.conf" do
    source "vhost_arkansashunting_net.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/39-www.arkansashunting.net.conf" do
    to "/etc/httpd/sites-available/39-www.arkansashunting.net.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end
