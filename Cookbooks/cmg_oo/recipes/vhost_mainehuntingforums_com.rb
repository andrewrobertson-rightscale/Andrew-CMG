rightscale_marker :begin

directory "/home/vhosts/mainehuntingforums.com" do
    owner "rightscale"
    group "apache"
    mode 02775
    recursive true
    action :create
end

template "/etc/httpd/sites-available/15-www.mainehuntingforums.com.conf" do
    source "vhost_mainehuntingforums_com.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/15-www.mainehuntingforums.com.conf" do
    to "/etc/httpd/sites-available/15-www.mainehuntingforums.com.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end