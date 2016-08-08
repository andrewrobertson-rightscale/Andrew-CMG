rightscale_marker :begin

directory "/mnt/efs/vhosts/biggamehunt.net" do
    owner "rightscale"
    group "apache"
    mode 00755
    recursive true
    action :create
end

template "/etc/httpd/sites-available/31b-www.biggamehunt.net_80.conf" do
    source "vhost_biggamehunt_net_80.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/31b-www.biggamehunt.net_80.conf" do
    to "/etc/httpd/sites-available/31b-www.biggamehunt.net_80.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end
