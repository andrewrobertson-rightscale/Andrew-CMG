rightscale_marker :begin

directory "/home/vhosts/pavementsucks.com" do
    owner "rightscale"
    group "apache"
    mode 02775
    recursive true
    action :create
end

template "/etc/httpd/sites-available/32-www.pavementsucks.com.conf" do
    source "vhost_pavementsucks_com.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/32-www.pavementsucks.com.conf" do
    to "/etc/httpd/sites-available/32-www.pavementsucks.com.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end