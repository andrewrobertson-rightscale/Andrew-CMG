rightscale_marker :begin

# Adds php port to list of ports for webserver to listen on
# See cookbooks/app/definitions/app_add_listen_port.rb for the "app_add_listen_port" definition.
app_add_listen_port 8000

directory "/home/vhosts/indianasportsman.com" do
    owner "rightscale"
    group "apache"
    mode 00755
    recursive true
    action :create
end

template "/etc/httpd/sites-available/10-www.indianasportsman.com" do
  source ".conf.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

link "/etc/httpd/sites-available/10-www.indianasportsman.com" do
    to "/etc/httpd/sites-enabled/10-www.indianasportsman.com"
end

bash "restart_httpd" do
  code <<-EOF
  	service httpd restart
  EOF
end

rightscale_marker :end