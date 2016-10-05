rightscale_marker :begin

directory "/home/vhosts/core.carbonmedia.net" do
    owner "rightscale"
    group "apache"
    mode 00755
    recursive true
    action :create
end

template "/etc/httpd/sites-available/25-www.core.carbonmedia.net.conf" do
    source "vhost_core_carbonmedia_net.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/25-www.core.carbonmedia.net.conf" do
    to "/etc/httpd/sites-available/25-www.core.carbonmedia.net.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end