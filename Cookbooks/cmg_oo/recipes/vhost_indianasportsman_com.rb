#
# Cookbook Name:: cmg_oo
# Recipe:: vhost_indianasportsman_com
#

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
  
  # Configure apache vhost for PHP
  # See https://github.com/rightscale/cookbooks/blob/master/apache2/definitions/web_app.rb for the "web_app" definition.
  web_app "002-indianasportsman.com" do
    template "app_server.erb"
    docroot project_root
    vhost_port php_port.to_s
    server_name "indianasportsman.com"
    allow_override "All"
    apache_log_dir node[:apache][:log_dir]
    cookbook "app_php"
  end

rightscale_marker :end