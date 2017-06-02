rightscale_marker :begin

directory "/home/vhosts/catfish1.com" do
    owner "rightscale"
    group "apache"
    mode 02775
    recursive true
    action :create
end

template "/etc/httpd/sites-available/40-www.catfish1.com.conf" do
    source "vhost_catfish1_com.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/40-www.catfish1.com.conf" do
    to "/etc/httpd/sites-available/40-www.catfish1.com.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end
