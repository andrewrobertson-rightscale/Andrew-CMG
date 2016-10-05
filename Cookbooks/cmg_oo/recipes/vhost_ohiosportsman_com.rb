rightscale_marker :begin

directory "/home/vhosts/ohiosportsman.com" do
    owner "rightscale"
    group "apache"
    mode 00755
    recursive true
    action :create
end

template "/etc/httpd/sites-available/21-www.ohiosportsman.com.conf" do
    source "vhost_ohiosportsman_com.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/21-www.ohiosportsman.com.conf" do
    to "/etc/httpd/sites-available/21-www.ohiosportsman.com.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end