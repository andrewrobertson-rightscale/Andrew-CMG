rightscale_marker :begin

directory "/home/vhosts/msgo.com" do
    owner "rightscale"
    group "apache"
    mode 02775
    recursive true
    action :create
end

template "/etc/httpd/sites-available/34-www.msgo.com.conf" do
    source "vhost_msgo_com.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/34-www.msgo.com.conf" do
    to "/etc/httpd/sites-available/34-www.msgo.com.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end