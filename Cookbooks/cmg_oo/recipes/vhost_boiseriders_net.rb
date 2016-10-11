rightscale_marker :begin

directory "/home/vhosts/boiseriders.net" do
    owner "rightscale"
    group "apache"
    mode 02775
    recursive true
    action :create
end

template "/etc/httpd/sites-available/23-www.boiseriders.net.conf" do
    source "vhost_boiseriders_net.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/23-www.boiseriders.net.conf" do
    to "/etc/httpd/sites-available/23-www.boiseriders.net.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end