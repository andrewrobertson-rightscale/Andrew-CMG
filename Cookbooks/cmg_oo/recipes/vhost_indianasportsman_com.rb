rightscale_marker :begin

service "apache2" do
	case node[:platform]
	when "redhat","centos","scientific","fedora","suse"
		service_name "httpd"
		# If restarted/reloaded too quickly httpd has a habit of failing.
		# This may happen with multiple recipes notifying apache to restart - like
		# during the initial bootstrap.
		restart_command "/sbin/service httpd restart && sleep 1"
		reload_command "/sbin/service httpd reload && sleep 1"
	when "debian","ubuntu"
		service_name "apache2"
		restart_command "/usr/sbin/invoke-rc.d apache2 restart && sleep 1"
		reload_command "/usr/sbin/invoke-rc.d apache2 reload && sleep 1"
	when "arch"
		service_name "httpd"
	end
	supports value_for_platform(
		"debian" => { "4.0" => [ :restart, :reload ], "default" => [ :restart, :reload, :status ] },
		"ubuntu" => { "default" => [ :restart, :reload, :status ] },
		"redhat" => { "default" => [ :restart, :reload, :status ] },
		"centos" => { "default" => [ :restart, :reload, :status ] },
		"scientific" => { "default" => [ :restart, :reload, :status ] },
		"fedora" => { "default" => [ :restart, :reload, :status ] },
		"arch" => { "default" => [ :restart, :reload, :status ] },
		"suse" => { "default" => [ :restart, :reload, :status ] },
		"default" => { "default" => [:restart, :reload ] }
	)
	action :nothing
end

# Sets up apache PHP virtual host
project_root = "/home/vhosts/indianasportsman.com"
php_port = 8000

# Adds php port to list of ports for webserver to listen on
# See cookbooks/app/definitions/app_add_listen_port.rb for the "app_add_listen_port" definition.
app_add_listen_port php_port

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

service "apache2"
  action :restart
end

rightscale_marker :end