rightscale_marker :begin

directory "/home/vhosts/beginningfarmers.org" do
    owner "rightscale"
    group "apache"
    mode 02775
    recursive true
    action :create
end

template "/etc/httpd/sites-available/29-www.beginningfarmers.org.conf" do
    source "vhost_beginningfarmers_org.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/29-www.beginningfarmers.org.conf" do
    to "/etc/httpd/sites-available/29-www.beginningfarmers.org.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end