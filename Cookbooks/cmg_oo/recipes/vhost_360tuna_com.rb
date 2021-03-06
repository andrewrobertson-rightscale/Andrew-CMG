rightscale_marker :begin

directory "/mnt/efs/vhosts/360tuna.com" do
    owner "rightscale"
    group "apache"
    mode 00755
    recursive true
    action :create
end

template "/etc/httpd/sites-available/33-www.360tuna.com.conf" do
    source "vhost_360tuna_com.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/33-www.360tuna.com.conf" do
    to "/etc/httpd/sites-available/33-www.360tuna.com.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end
