rightscale_marker :begin

directory "/home/vhosts/theboxotruth.com" do
    owner "rightscale"
    group "apache"
    mode 02775
    recursive true
    action :create
end

template "/etc/httpd/sites-available/18-www.theboxotruth.com.conf" do
    source "vhost_theboxotruth_com.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/18-www.theboxotruth.com.conf" do
    to "/etc/httpd/sites-available/18-www.theboxotruth.com.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end