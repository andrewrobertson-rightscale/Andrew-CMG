rightscale_marker :begin

directory "/home/vhosts/biggamehunt.net" do
    owner "rightscale"
    group "apache"
    mode 00755
    recursive true
    action :create
end

template "/etc/httpd/sites-available/31-www.biggamehunt.net.conf" do
    source "vhost_biggamehunt_net.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/31-www.biggamehunt.net.conf" do
    to "/etc/httpd/sites-available/31-www.biggamehunt.net.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end