rightscale_marker :begin

directory "/home/vhosts/microskiff.com" do
    owner "rightscale"
    group "apache"
    mode 00755
    recursive true
    action :create
end

template "/etc/httpd/sites-available/30-www.microskiff.com.conf" do
    source "vhost_microskiff_com.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    action :create
end

link "/etc/httpd/sites-enabled/30-www.microskiff.com.conf" do
    to "/etc/httpd/sites-available/30-www.microskiff.com.conf"
end

bash "restart_httpd" do
    code <<-EOF
        service httpd restart
    EOF
end

rightscale_marker :end